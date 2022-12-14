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

    probot->joystick[0] = 0;
    probot->joystick[1] = 0;

    timer = new QTimer();
    connect(timer, SIGNAL(timeout()),this,SLOT(onTimer()));
    timer->start(200);

    plog->write("[BUILDER] LCM HANDLER constructed");
}

LCMHandler::~LCMHandler(){
    if(bThread != NULL)
    {
        bFlag = false;
        bThread->join();
    }
    plog->write("[BUILDER] LCM HANDLER destroyed");
}



////*********************************************  COMMAND FUNCTIONS   ***************************************************////
void LCMHandler::sendCommand(command cmd, QString msg){
    if(isconnect){
        if(probot->state != ROBOT_STATE_BUSY){
            if(is_debug){
                lcm.publish("COMMAND_"+probot->name_debug.toStdString(),&cmd);
            }else{
                lcm.publish("COMMAND_"+probot->name.toStdString(),&cmd);
            }
            plog->write("[LCM] SEND COMMAND : " + msg);
            flag_tx = true;
        }else{
            plog->write("[LCM ERROR] SEND COMMAND (ROBOT BUSY) : " + msg);
        }
    }else{
        plog->write("[LCM ERROR] SEND COMMAND (DISCONNECTED) : " + msg);
    }
}

void LCMHandler::sendCommand(int cmd, QString msg){
    command send_msg;
    send_msg.cmd = cmd;

    if(isconnect){
        if(probot->state != ROBOT_STATE_BUSY){
            if(is_debug){
                lcm.publish("COMMAND_"+probot->name_debug.toStdString(),&send_msg);
            }else{
                lcm.publish("COMMAND_"+probot->name.toStdString(),&send_msg);
            }
            plog->write("[LCM] SEND COMMAND : " + msg);
            flag_tx = true;
        }else{
            plog->write("[LCM ERROR] SEND COMMAND (ROBOT BUSY) : " + msg);
        }
    }else{
        plog->write("[LCM ERROR] SEND COMMAND (DISCONNECTED) : " + msg);
    }
}

void LCMHandler::moveTo(QString target_loc){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_LOCATION;
    memcpy(send_msg.params,target_loc.toUtf8(),sizeof(char)*255);

    probot->curLocation = target_loc;
    sendCommand(send_msg, "MOVE LOCATION TO"+target_loc);
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

    probot->curTarget.x = x;
    probot->curTarget.y = y;
    probot->curTarget.th = th;
    sendCommand(send_msg, "MOVE TARGET TO"+QString().sprintf("%f, %f, %f",x,y,th));
}
void LCMHandler::movePause(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_PAUSE;
    sendCommand(send_msg, "MOVE PAUSE");
}
void LCMHandler::moveResume(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_RESUME;
    sendCommand(send_msg, "MOVE RESUME");
}
void LCMHandler::moveJog(){
    command send_msg;
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

    sendCommand(send_msg, "MOVE JOYSTICK "+QString().sprintf("%f, %f",probot->joystick[0],probot->joystick[1]));
}
void LCMHandler::moveStop(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_STOP;
    sendCommand(send_msg, "MOVE STOP");
}
void LCMHandler::moveManual(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_MANUAL;
    sendCommand(send_msg, "MOVE MANUAL START");
}

void LCMHandler::setVelocity(float vel){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_SET_VELOCITY;
    uint8_t *array;
    array = reinterpret_cast<uint8_t*>(&vel);
    send_msg.params[0] = array[0];
    send_msg.params[1] = array[1];
    send_msg.params[2] = array[2];
    send_msg.params[3] = array[3];

    sendCommand(send_msg, "SET VELOCITY TO "+QString().sprintf("%f",vel));
}

void LCMHandler::programStart(){
}

void LCMHandler::setInitPose(float x, float y, float th){
    command send_msg;
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

    sendCommand(send_msg, "SET INIT "+QString().sprintf("%f, %f, %f",x,y,th));
}

void LCMHandler::sendMapPath(QString path){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_SET_MAP;
    memcpy(send_msg.params,path.toUtf8(),sizeof(char)*255);

    sendCommand(send_msg,"SEND MAP PATH ("+path+")");
}

////*********************************************  CALLBACK FUNCTIONS   ***************************************************////
void LCMHandler::robot_status_callback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const robot_status *msg){
    isconnect = true;
    flag_rx = true;
    connect_count = 0;
    probot->battery = msg->bat;
    probot->state = msg->state;
    probot->err_code = msg->err_code;
    probot->curPose.x = msg->robot_pose[0];
    probot->curPose.y = msg->robot_pose[1];
    probot->curPose.th = msg->robot_pose[2];
    for(int i=0; i<360; i++){
        probot->lidar_data[i] = msg->robot_scan[i];
    }
}

void LCMHandler::robot_path_callback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const robot_path *msg){
    isconnect = true;
    flag_rx = true;
    connect_count = 0;
    flagPath = true;
    probot->pathSize = msg->num;
    for(int i=0; i<probot->pathSize; i++){
        ST_POSE temp;
        temp.x = msg->path[i][0];
        temp.y = msg->path[i][1];
        temp.th = msg->path[i][2];
        if(probot->curPath.size() > i){
            probot->curPath[i] = temp;
        }else{
            probot->curPath.push_back(temp);
        }
    }
    emit pathchanged();
    flagPath = false;
}

void LCMHandler::robot_local_path_callback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const robot_path *msg){
    isconnect = true;
    flag_rx = true;
    connect_count = 0;
    flagLocalPath = true;
    probot->localpathSize = msg->num;
    for(int i=0; i<probot->localpathSize; i++){
        ST_POSE temp;
        temp.x = msg->path[i][0];
        temp.y = msg->path[i][1];
        temp.th = msg->path[i][2];
        probot->localPath[i] = temp;
    }
    flagLocalPath = false;
}

void LCMHandler::robot_mapping_calliback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const map_data_t *msg){
    isconnect = true;
    connect_count = 0;
    pmap->map_name = msg->map_name.data();
    pmap->width = msg->map_w;
    pmap->height = msg->map_h;
    pmap->gridwidth = msg->map_grid_w;
    pmap->origin[0] = msg->map_origin[0];
    pmap->origin[1] = msg->map_origin[1];
    pmap->imageSize = msg->len;

    pmap->data.clear();

    cv::Mat map1(msg->map_h, msg->map_w, CV_32S, cv::Scalar::all(0));
    memcpy(map1.data, msg->data.data(), msg->len);

    cv::Mat plot_map;
    cv::cvtColor(map1, plot_map, cv::COLOR_GRAY2BGR);
    cv::flip(plot_map, plot_map, 0);
    cv::rotate(plot_map, plot_map, cv::ROTATE_90_COUNTERCLOCKWISE); // image north is +x axis

    memcpy(plot_map.data, pmap->data.data(), msg->len);
    flagMapping = true;
}
////***********************************************   THREADS  ********************************************************////
void LCMHandler::bLoop()
{
    /*
    sudo ifconfig lo multicast
    sudo route add -net 224.0.0.0 netmask 240.0.0.0 dev lo
    */

    // lcm init
    if(!lcm.good())
    {
        plog->write("[LCM ERROR] LCM CONNECT FAILED");
        isconnect = false;
    }

    while(bFlag)
    {
        lcm.handleTimeout(1);
    }
}

void LCMHandler::subscribe(){
    lcm.unsubscribe(sub_status);
    lcm.unsubscribe(sub_path);
    lcm.unsubscribe(sub_localpath);
    lcm.unsubscribe(sub_mapping);
    if(is_debug){
        sub_mapping = lcm.subscribe("MAP_DATA_"+probot->name_debug.toStdString(), &LCMHandler::robot_status_callback, this);
        sub_status = lcm.subscribe("STATUS_DATA_"+probot->name_debug.toStdString(), &LCMHandler::robot_status_callback, this);
        sub_path = lcm.subscribe("ROBOT_PATH_"+probot->name_debug.toStdString(), &LCMHandler::robot_path_callback, this);
        sub_localpath = lcm.subscribe("ROBOT_LOCAL_PATH_"+probot->name_debug.toStdString(), &LCMHandler::robot_local_path_callback, this);
    }else{
        sub_mapping = lcm.subscribe("MAP_DATA_"+probot->name.toStdString(), &LCMHandler::robot_status_callback, this);
        sub_status = lcm.subscribe("STATUS_DATA_"+probot->name.toStdString(), &LCMHandler::robot_status_callback, this);
        sub_path = lcm.subscribe("ROBOT_PATH_"+probot->name.toStdString(), &LCMHandler::robot_path_callback, this);
        sub_localpath = lcm.subscribe("ROBOT_LOCAL_PATH_"+probot->name.toStdString(), &LCMHandler::robot_local_path_callback, this);
    }
}
void LCMHandler::onTimer(){
    //10ms ???????????? ??? ????????????
    if(flagJoystick){
        moveJog();
        flagJoystick = false;
    }else{
        if(probot->joystick[0] != 0 || probot->joystick[1] != 0 ){
            moveJog();
        }
    }

    static int count=0;
    if(count++%10==0){
        flag_rx = false;
        flag_tx = false;
    }
    //LCM ?????? ???????????? ??????(3???)
    if(connect_count++ > 300){
        isconnect = false;
    }
}
