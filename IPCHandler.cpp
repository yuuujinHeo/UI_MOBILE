#include "IPCHandler.h"

IPCHandler::IPCHandler(QObject *parent)
    : QObject(parent)
    , shm_cmd("slamnav_cmd")
    , shm_status("slamnav_status")
    , shm_global_path("slamnav_globalpath")
    , shm_local_path("slamnav_localpath")
    , shm_map("slamnav_map")
    , shm_obs("slamnav_obs")
    , shm_cam0("slamnav_cam0")
    , shm_cam1("slamnav_cam1")
{
    // msg tick clear, check for new data
    tick = 0;

    // create or attach
    updateSharedMemory(shm_cmd,"Command",sizeof(IPCHandler::CMD));
    updateSharedMemory(shm_status,"Status",sizeof(IPCHandler::STATUS));
    updateSharedMemory(shm_global_path,"GlobalPath",sizeof(IPCHandler::PATH));
    updateSharedMemory(shm_local_path,"LocalPath",sizeof(IPCHandler::PATH));
    updateSharedMemory(shm_map,"Map",sizeof(IPCHandler::MAP));
    updateSharedMemory(shm_obs,"ObsMap",sizeof(IPCHandler::MAP));
    updateSharedMemory(shm_cam0,"Camera0",sizeof(IPCHandler::IMG));
    updateSharedMemory(shm_cam1,"Camera1",sizeof(IPCHandler::IMG));

    timer = new QTimer();
    connect(timer, SIGNAL(timeout()), this, SLOT(onTimer()));
    timer->start(200);
}

void IPCHandler::updateSharedMemory(QSharedMemory &mem, QString name, int size){
    if(!mem.isAttached()){
        if (!mem.create(size, QSharedMemory::ReadWrite) && mem.error() == QSharedMemory::AlreadyExists)
        {
            if(mem.attach()){
                plog->write("[IPC] "+name+" is already exist. attach success. ");
            }else{
                plog->write("[IPC] "+name+" is already exist. attach failed. ");
            }
        }
        else
        {
            plog->write("[IPC] "+name+" is created. size : "+QString::number(size));
        }
    }
}
void IPCHandler::detachSharedMemory(QSharedMemory &mem, QString name){
    if(shm_cmd.detach())
    {
        plog->write("[IPC] "+name+" is detached success.");
    }else{
        plog->write("[IPC] "+name+" is detached failed.");
    }
}
void IPCHandler::update(){
    updateSharedMemory(shm_cmd,"Command",sizeof(IPCHandler::CMD));
    updateSharedMemory(shm_status,"Status",sizeof(IPCHandler::STATUS));
    updateSharedMemory(shm_global_path,"GlobalPath",sizeof(IPCHandler::PATH));
    updateSharedMemory(shm_local_path,"LocalPath",sizeof(IPCHandler::PATH));
    updateSharedMemory(shm_map,"Map",sizeof(IPCHandler::MAP));
    updateSharedMemory(shm_obs,"ObsMap",sizeof(IPCHandler::MAP));
    updateSharedMemory(shm_cam0,"Camera0",sizeof(IPCHandler::IMG));
    updateSharedMemory(shm_cam1,"Camera1",sizeof(IPCHandler::IMG));
}

IPCHandler::~IPCHandler()
{
    detachSharedMemory(shm_cmd,"Command");
    detachSharedMemory(shm_status,"Status");
    detachSharedMemory(shm_global_path,"GlobalPath");
    detachSharedMemory(shm_local_path,"LocalPath");
    detachSharedMemory(shm_map,"Map");
    detachSharedMemory(shm_obs,"ObsMap");
    detachSharedMemory(shm_cam0,"Camera0");
    detachSharedMemory(shm_cam1,"Camera1");
}

void IPCHandler::onTimer(){
    IPCHandler::STATUS temp1 = get_status();
    if((int)temp1.tick != prev_tick_status){
        flag_rx = true;
        read_count = 0;
        probot->battery_in = temp1.bat_in;
        probot->battery_out = temp1.bat_out;
        probot->battery = (temp1.bat_in-44)*100/10;
        if(probot->battery > 100) probot->battery = 100;
        if(probot->battery < 0) probot->battery = 0;

        probot->battery_cur = temp1.bat_cur;
        probot->motor[0].connection = temp1.connection_m0;
        probot->motor[1].connection = temp1.connection_m1;
        probot->motor[0].status = temp1.status_m0;
        probot->motor[1].status = temp1.status_m1;
        probot->motor[0].temperature = temp1.temp_m0;
        probot->motor[1].temperature = temp1.temp_m1;
        probot->motor[0].current = temp1.cur_m0;
        probot->motor[1].current = temp1.cur_m1;
        probot->status_power = temp1.status_power;
        if(probot->status_emo == temp1.status_emo){
            plog->write("[LCM] EMO status changed !! "+QString::number(!temp1.status_emo));
        }
        probot->status_emo = !temp1.status_emo;
        probot->status_remote = temp1.status_remote;
        //DEBUG
        probot->status_charge = temp1.status_charge;
        probot->motor_state = temp1.ui_motor_state;
        probot->localization_state = temp1.ui_loc_state;
        probot->running_state = temp1.ui_auto_state;
        probot->obs_state = temp1.ui_obs_state;
        probot->curPose.point.x = temp1.robot_pose[0];
        probot->curPose.point.y = temp1.robot_pose[1];
        probot->curPose.angle = temp1.robot_pose[2];
        for(int i=0; i<360; i++){
            probot->lidar_data[i] = temp1.robot_scan[i];
        }
        prev_tick_status = temp1.tick;
    }

    IPCHandler::PATH temp2 = get_global_path();
    if((int)temp2.tick != prev_tick_global_path){
        flag_rx = true;
        read_count = 0;

        probot->pathSize = temp2.num;
        for(int i=0; i<probot->pathSize; i++){
            POSE temp;
            temp.point.x = temp2.x[i];
            temp.point.y = temp2.y[i];
            temp.angle = 0;
            if(probot->curPath.size() > i){
                probot->curPath[i] = temp;
            }else{
                probot->curPath.push_back(temp);
            }
        }
        prev_tick_global_path = temp2.tick;
        emit pathchanged();
    }

    temp2 = get_local_path();
    if((int)temp2.tick != prev_tick_local_path){
        flag_rx = true;
        read_count = 0;

        probot->localpathSize = temp2.num;
        for(int i=0; i<probot->localpathSize; i++){
            POSE temp;
            temp.point.x = temp2.x[i];
            temp.point.y = temp2.y[i];
            temp.angle = 0;
            probot->localPath[i] = temp;
        }
        prev_tick_local_path = temp2.tick;
        emit pathchanged();
    }

    IPCHandler::MAP temp3 = get_map();
    if((int)temp3.tick != prev_tick_map){
        flag_rx = true;
        read_count = 0;

        cv::Mat map1(temp3.height, temp3.width, CV_8U, cv::Scalar::all(0));
        memcpy(map1.data, temp3.buf, temp3.height*temp3.width);
        cv::flip(map1, map1, 0);
        cv::rotate(map1, map1, cv::ROTATE_90_COUNTERCLOCKWISE);

        pmap->map_mapping = map1;

        flag_mapping = true;
        prev_tick_map = temp3.tick;
        emit mappingin();
    }

    temp3 = get_obs();
    if((int)temp3.tick != prev_tick_obs){
        flag_rx = true;
        read_count = 0;

        cv::Mat map1(temp3.height, temp3.width, CV_8U, cv::Scalar::all(0));
        memcpy(map1.data, temp3.buf, temp3.width*temp3.height);
        cv::flip(map1, map1, 0);
        cv::rotate(map1, map1, cv::ROTATE_90_COUNTERCLOCKWISE);

        pmap->map_objecting = map1;

        flag_objecting = true;
        prev_tick_obs = temp3.tick;
        emit objectingin();
    }

    IPCHandler::IMG temp = get_cam0();
    if((int)temp.tick != prev_tick_cam0){
        flag_rx = true;
        read_count = 0;

        ST_CAMERA temp_info;

        temp_info.serial = QString::fromUcs4(temp.serial,temp.serial_len);
//        temp_info.serial = temp.serial;// QString::fromStdString(temp.serial);
        temp_info.imageSize = temp.width*temp.height;
        temp_info.width = temp.width;
        temp_info.height = temp.height;

        cv::Mat map(temp_info.height, temp_info.width, CV_8U, cv::Scalar::all(0));
        memcpy(map.data, temp.buf, temp_info.width*temp_info.height);
        temp_info.pixmap = QPixmap::fromImage(mat_to_qimage_cpy(map));

        if(pmap->camera_info.count() > 0){
            pmap->camera_info[0] = temp_info;
        }else{
            pmap->camera_info.push_back(temp_info);
        }

        try{
            emit cameraupdate();
        }catch(std::bad_alloc){
            qDebug() << "bad alloc?";
        }
        prev_tick_cam0 = temp.tick;
    }

    temp = get_cam1();
    if((int)temp.tick != prev_tick_cam1){
        flag_rx = true;
        read_count = 0;

        ST_CAMERA temp_info;

        temp_info.serial = QString::fromUcs4(temp.serial,temp.serial_len);
//        temp_info.serial = temp.serial;//QString::fromStdString(temp.serial);
        temp_info.imageSize = temp.width*temp.height;
        temp_info.width = temp.width;
        temp_info.height = temp.height;

        cv::Mat map(temp_info.height, temp_info.width, CV_8U, cv::Scalar::all(0));
        memcpy(map.data, temp.buf, temp_info.width*temp_info.height);
        temp_info.pixmap = QPixmap::fromImage(mat_to_qimage_cpy(map));

        if(pmap->camera_info.count() > 1){
            pmap->camera_info[1] = temp_info;
        }else{
            pmap->camera_info.push_back(temp_info);
        }

        try{
            emit cameraupdate();
        }catch(std::bad_alloc){
            qDebug() << "bad alloc?";
        }

        prev_tick_cam1 = temp.tick;
    }

    read_count++;
}

IPCHandler::CMD IPCHandler::get_cmd()
{
    IPCHandler::CMD res;
    shm_cmd.lock();
    memcpy(&res, (char*)shm_cmd.constData(), sizeof(IPCHandler::CMD));
    shm_cmd.unlock();

    return res;
}

IPCHandler::STATUS IPCHandler::get_status()
{
    IPCHandler::STATUS res;
    shm_status.lock();
    memcpy(&res, (char*)shm_status.constData(), sizeof(IPCHandler::STATUS));
    shm_status.unlock();

    return res;
}

IPCHandler::PATH IPCHandler::get_global_path()
{
    IPCHandler::PATH res;

    shm_global_path.lock();
    memcpy(&res, (char*)shm_global_path.constData(), sizeof(IPCHandler::PATH));
    shm_global_path.unlock();

    return res;
}

IPCHandler::PATH IPCHandler::get_local_path()
{
    IPCHandler::PATH res;

    shm_local_path.lock();
    memcpy(&res, (char*)shm_local_path.constData(), sizeof(IPCHandler::PATH));
    shm_local_path.unlock();

    return res;
}

IPCHandler::MAP IPCHandler::get_map()
{
    IPCHandler::MAP res;

    shm_map.lock();
    memcpy(&res, (char*)shm_map.constData(), sizeof(IPCHandler::MAP));
    shm_map.unlock();

    return res;
}

IPCHandler::MAP IPCHandler::get_obs()
{
    IPCHandler::MAP res;

    shm_obs.lock();
    memcpy(&res, (char*)shm_obs.constData(), sizeof(IPCHandler::MAP));
    shm_obs.unlock();

    return res;
}

IPCHandler::IMG IPCHandler::get_cam0()
{
    IPCHandler::IMG res;

    shm_cam0.lock();
    memcpy(&res, (char*)shm_cam0.constData(), sizeof(IPCHandler::IMG));
    shm_cam0.unlock();

    return res;
}

IPCHandler::IMG IPCHandler::get_cam1()
{
    IPCHandler::IMG res;

    shm_cam1.lock();
    memcpy(&res, (char*)shm_cam1.constData(), sizeof(IPCHandler::IMG));
    shm_cam1.unlock();

    return res;
}

void IPCHandler::set_cmd(IPCHandler::CMD val, QString log)
{
    shm_cmd.lock();
    val.tick = ++tick;
    memcpy((char*)shm_cmd.data(), &val, sizeof(IPCHandler::CMD));
    if(log != ""){
        plog->write("[IPC] Set CMD "+QString::number(val.tick)+" : "+log);
    }
    shm_cmd.unlock();
}
void IPCHandler::set_cmd(int cmd, QString log){
    IPCHandler::CMD send_msg;
    send_msg.cmd = cmd;
    set_cmd(send_msg,log);
}

////*********************************************  COMMAND FUNCTIONS   ***************************************************////
void IPCHandler::moveTo(QString target_loc){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_LOCATION;
    memcpy(send_msg.params,target_loc.toUtf8(),sizeof(char)*255);
    probot->curLocation = target_loc;
    set_cmd(send_msg,"Move Location to "+target_loc);
}
void IPCHandler::moveTo(float x, float y, float th){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_TARGET;
    uint8_t *array;
    array = reinterpret_cast<uint8_t*>(&x);
    send_msg.params[0] = array[0];
    send_msg.params[1] = array[1];
    send_msg.params[2] = array[2];
    send_msg.params[3] = array[3];
    array = reinterpret_cast<uint8_t*>(&y);
    send_msg.params[4] = array[0];
    send_msg.params[5] = array[1];
    send_msg.params[6] = array[2];
    send_msg.params[7] = array[3];
    array = reinterpret_cast<uint8_t*>(&th);
    send_msg.params[8] = array[0];
    send_msg.params[9] = array[1];
    send_msg.params[10]= array[2];
    send_msg.params[11]= array[3];

    probot->curTarget.point.x = x;
    probot->curTarget.point.y = y;
    probot->curTarget.angle = th;
    set_cmd(send_msg,"Move Target to "+QString().sprintf("%f, %f, %f",x,y,th));
}
void IPCHandler::movePause(){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_PAUSE;
    set_cmd(send_msg,"Move Pause");
}
void IPCHandler::moveResume(){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_RESUME;
    set_cmd(send_msg,"Move Resume");
}
void IPCHandler::moveJog(){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_JOG;
    uint8_t *array;
    array = reinterpret_cast<uint8_t*>(&probot->joystick[0]);
    send_msg.params[0] = array[0];
    send_msg.params[1] = array[1];
    send_msg.params[2] = array[2];
    send_msg.params[3] = array[3];

    array = reinterpret_cast<uint8_t*>(&probot->joystick[1]);
    send_msg.params[4] = array[0];
    send_msg.params[5] = array[1];
    send_msg.params[6] = array[2];
    send_msg.params[7] = array[3];

    set_cmd(send_msg, "MOVE JOYSTICK "+QString().sprintf("%f, %f",probot->joystick[0],probot->joystick[1]));
}
void IPCHandler::moveStop(){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_STOP;
    set_cmd(send_msg, "MOVE STOP");
}
void IPCHandler::moveManual(){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_MANUAL;
    set_cmd(send_msg, "MOVE MANUAL START");
}
void IPCHandler::setInitPose(float x, float y, float th){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_SET_INIT;
    uint8_t *array;
    array = reinterpret_cast<uint8_t*>(&x);
    send_msg.params[0] = array[0];
    send_msg.params[1] = array[1];
    send_msg.params[2] = array[2];
    send_msg.params[3] = array[3];
    array = reinterpret_cast<uint8_t*>(&y);
    send_msg.params[4] = array[0];
    send_msg.params[5] = array[1];
    send_msg.params[6] = array[2];
    send_msg.params[7] = array[3];
    array = reinterpret_cast<uint8_t*>(&th);
    send_msg.params[8] = array[0];
    send_msg.params[9] = array[1];
    send_msg.params[10] = array[2];
    send_msg.params[11] = array[3];

    set_cmd(send_msg, "SET INIT "+QString().sprintf("%f, %f, %f",x,y,th));
}
void IPCHandler::saveMapping(QString name){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_MAPPING_SAVE;
    memcpy(send_msg.params,name.toUtf8(),sizeof(char)*255);
    set_cmd(send_msg,"SAVE MAPPING ("+name+")");
}

void IPCHandler::startMapping(float grid_size){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_MAPPING_START;
    uint8_t *array;
    array = reinterpret_cast<uint8_t*>(&grid_size);
    send_msg.params[0] = array[0];
    send_msg.params[1] = array[1];
    send_msg.params[2] = array[2];
    send_msg.params[3] = array[3];
    set_cmd(send_msg,"START MAPPING "+QString().sprintf("(grid size = %f)",grid_size));
}
void IPCHandler::stopMapping(){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_MAPPING_STOP;
    set_cmd(send_msg, "STOP MAPPING");
}
void IPCHandler::saveObjecting(){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_OBJECTING_SAVE;
    set_cmd(send_msg,"SAVE OBJECTING");
}
void IPCHandler::startObjecting(){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_OBJECTING_START;
    set_cmd(send_msg,"START OBJECTING ");
}
void IPCHandler::stopObjecting(){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_OBJECTING_STOP;
    set_cmd(send_msg, "STOP OBJECTING");
}
void IPCHandler::set_velocity(float vel){
    IPCHandler::CMD send_msg;
    send_msg.cmd = ROBOT_CMD_SET_VELOCITY;
    uint8_t *array;
    array = reinterpret_cast<uint8_t*>(&vel);
    send_msg.params[0] = array[0];
    send_msg.params[1] = array[1];
    send_msg.params[2] = array[2];
    send_msg.params[3] = array[3];
    set_cmd(send_msg, "SET Velocity to "+QString::number(vel));
}
