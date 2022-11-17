#include "LCMHandler.h"
#include <QQmlApplicationEngine>
#include <iostream>
#include <QDebug>
#include <QPixmap>


LCMHandler::LCMHandler()
    : lcm("udpm://239.255.76.67:7667?ttl=1")
{
    if(bThread == NULL){
        bFlag = true;
        bThread = new std::thread(&LCMHandler::bLoop, this);
    }

    timer = new QTimer();
    connect(timer, SIGNAL(timeout()),this,SLOT(onTimer()));
    timer->start(200);
}

LCMHandler::~LCMHandler(){
    if(bThread != NULL)
    {
        bFlag = false;
        bThread->join();
    }
}

void LCMHandler::onTimer(){
    static int cnt = 0;
    if(!isdownloadMap && cnt%50 == 0){
        RequestMap();
    }

    if(flagJoystick){
        moveJog();
        flagJoystick = false;
    }else{
        if(robot.joy_x != 0 || robot.joy_y != 0 || robot.joy_th != 0){
            moveJog();
        }
    }

    cnt++;
}

void LCMHandler::moveTo(QString target_loc){
    qDebug() << target_loc;
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_LOCATION;

    memcpy(send_msg.params,target_loc.toUtf8(),sizeof(char)*255);
    robot.curLocation = target_loc;
    plog->write("[LCM] SEND COMMAND : MOVE LOCATION TO "+target_loc);
    lcm.publish("COMMAND",&send_msg);
}
void LCMHandler::moveTo(float x, float y, float th){
    command send_msg;
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

    robot.curTarget.x = x;
    robot.curTarget.y = y;
    robot.curTarget.th = th;
    plog->write("[LCM] SEND COMMAND : MOVE TARGET TO "+QString().sprintf("%f, %f, %f",x,y,th));
    lcm.publish("COMMAND",&send_msg);
}
void LCMHandler::movePause(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_PAUSE;
    plog->write("[LCM] SEND COMMAND : MOVE PAUSE");
    lcm.publish("COMMAND",&send_msg);
}
void LCMHandler::moveResume(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_RESUME;
    plog->write("[LCM] SEND COMMAND : MOVE RESUME");
    lcm.publish("COMMAND",&send_msg);
}
void LCMHandler::moveJog(float vx, float vy, float vth){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_JOG;
    uint8_t *array;
    array = reinterpret_cast<uint8_t*>(&vx);
    send_msg.params[0] = array[0];
    send_msg.params[1] = array[1];
    send_msg.params[2] = array[2];
    send_msg.params[3] = array[3];

    array = reinterpret_cast<uint8_t*>(&vy);
    send_msg.params[4] = array[0];
    send_msg.params[5] = array[1];
    send_msg.params[6] = array[2];
    send_msg.params[7] = array[3];

    array = reinterpret_cast<uint8_t*>(&vth);
    send_msg.params[8] = array[0];
    send_msg.params[9] = array[1];
    send_msg.params[10]= array[2];
    send_msg.params[11]= array[3];
    plog->write("[LCM] SEND COMMAND : MOVE TARGET TO "+QString().sprintf("%f, %f, %f",vx,vy,vth));
    lcm.publish("COMMAND",&send_msg);
}
void LCMHandler::moveJog(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_JOG;
    uint8_t *array;
    array = reinterpret_cast<uint8_t*>(&robot.joy_x);
    send_msg.params[0] = array[0];
    send_msg.params[1] = array[1];
    send_msg.params[2] = array[2];
    send_msg.params[3] = array[3];

    array = reinterpret_cast<uint8_t*>(&robot.joy_y);
    send_msg.params[4] = array[0];
    send_msg.params[5] = array[1];
    send_msg.params[6] = array[2];
    send_msg.params[7] = array[3];

    array = reinterpret_cast<uint8_t*>(&robot.joy_th);
    send_msg.params[8] = array[0];
    send_msg.params[9] = array[1];
    send_msg.params[10]= array[2];
    send_msg.params[11]= array[3];
    plog->write("[LCM] SEND COMMAND : MOVE TARGET TO "+QString().sprintf("%f, %f, %f",robot.joy_x,robot.joy_y,robot.joy_th));
    lcm.publish("COMMAND",&send_msg);
}

void LCMHandler::moveStop(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_STOP;
    plog->write("[LCM] SEND COMMAND : MOVE STOP");
    lcm.publish("COMMAND",&send_msg);
}

void LCMHandler::moveManual(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_MANUAL;
    plog->write("[LCM] SEND COMMAND : MOVE MANUAL START");
    lcm.publish("COMMAND",&send_msg);
}

void LCMHandler::setVelocity(float vel, float velth){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_SET_VELOCITY;
    uint8_t *array;
    array = reinterpret_cast<uint8_t*>(&vel);
    send_msg.params[0] = array[0];
    send_msg.params[1] = array[1];
    send_msg.params[2] = array[2];
    send_msg.params[3] = array[3];
    array = reinterpret_cast<uint8_t*>(&velth);
    send_msg.params[4] = array[0];
    send_msg.params[5] = array[1];
    send_msg.params[6] = array[2];
    send_msg.params[7] = array[3];
    plog->write("[LCM] SEND COMMAND : SET VELOCITY TO "+QString().sprintf("%f, %f",vel,velth));
    lcm.publish("COMMAND",&send_msg);
}


void LCMHandler::map_data_callback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const map_data_t *msg){
//    printf("SUB(MAP_DATA): %s, %d, %d\n", msg->map_name.data(), msg->data[msg->len-2], msg->data[msg->len-1]);

    map.map_name = msg->map_name.data();
    map.width = msg->map_w;
    map.height = msg->map_h;
    map.gridwidth = msg->map_grid_w;
    map.origin[0] = msg->map_origin[0];
    map.origin[1] = msg->map_origin[1];
    map.imageSize = msg->len;

    map.data.clear();

    cv::Mat map1(msg->map_h, msg->map_w, CV_8U, cv::Scalar::all(0));
    memcpy(map1.data, msg->data.data(), msg->len);

    cv::Mat plot_map;
    cv::cvtColor(map1, plot_map, cv::COLOR_GRAY2BGR);
    cv::flip(plot_map, plot_map, 0);
    cv::rotate(plot_map, plot_map, cv::ROTATE_90_COUNTERCLOCKWISE); // image north is +x axis

    QImage temp_image = QPixmap::fromImage(mat_to_qimage_cpy(plot_map)).toImage();

    //Save PNG File
    if(temp_image.save("image/map_downloaded2.png","PNG")){
        qDebug() << "Success to png";
    }else{
        qDebug() << "FAil to png";
    }
    map.locationSize = msg->loc_num;
    map.locationTypes.clear();
    map.locationsPose.clear();
    for(int i=0; i<msg->loc_num; i++){
        map.locationTypes.push_back(msg->loc_name[i].data());
        ST_POSE temp1,temp2;
        temp1.x = msg->loc_pos[i][0];
        temp1.y = msg->loc_pos[i][1];
        temp1.th = msg->loc_pos[i][2];
        temp2 = setAxis(temp1);
        map.locationsPose.push_back(temp2);
    }

    //Only Test (Debugging)
    //clear
    robot.curPath.clear();

    robot.pathSize = msg->via_num;
    for(int i=0; i<robot.pathSize; i++){
        ST_POSE temp1;
        temp1.x = msg->via_pos[i][0];
        temp1.y = msg->via_pos[i][1];
        temp1.th = msg->via_pos[i][2];
        robot.curPath.push_back(temp1);
    }

    isdownloadMap = true;
}

void LCMHandler::RequestMap(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_REQ_MAP;
//    plog->write("[LCM] SEND COMMAND : REQUEST MAP");
    lcm.publish("COMMAND",&send_msg);

}

ST_POSE LCMHandler::setAxis(ST_POSE _pose){
    ST_POSE temp;
    temp.x = -_pose.y;
    temp.y = -_pose.x;
    temp.th = _pose.th;
    return temp;
};

void LCMHandler::robot_status_callback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const robot_status *msg){
    robot.battery = msg->bat;
    robot.state = msg->state;
    robot.err_code = msg->err_code;
    robot.curPose.x = msg->robot_pose[0];
    robot.curPose.y = msg->robot_pose[1];
    robot.curPose.th = msg->robot_pose[2];
}

void LCMHandler::robot_path_callback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const robot_path *msg){
    robot.pathSize = msg->num;
    for(int i=0; i<robot.pathSize; i++){
        ST_POSE temp;
        temp.x = msg->path[i][0];
        temp.y = msg->path[i][1];
        temp.th = msg->path[i][2];
        robot.curPath.push_back(temp);
    }
}

void LCMHandler::bLoop()
{
    /*
    sudo ifconfig lo multicast
    sudo route add -net 224.0.0.0 netmask 240.0.0.0 dev lo
    */

    // lcm init
    if(lcm.good())
    {
        lcm.subscribe("MAP_DATA", &LCMHandler::map_data_callback, this);
        lcm.subscribe("STATUS_DATA", &LCMHandler::robot_status_callback, this);
        lcm.subscribe("ROBOT_PATH", &LCMHandler::robot_path_callback, this);
    }
    else
    {
        qDebug() << "lcm init failed";
    }

    while(bFlag)
    {
        lcm.handleTimeout(1);
    }
}
