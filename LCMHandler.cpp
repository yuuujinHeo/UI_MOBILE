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

    robot.joystick[0] = 0;
    robot.joystick[1] = 0;


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

void LCMHandler::setMapData(ST_MAP _map){
    map = _map;
}


////*********************************************  COMMAND FUNCTIONS   ***************************************************////

void LCMHandler::moveTo(QString target_loc){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_LOCATION;
    memcpy(send_msg.params,target_loc.toUtf8(),sizeof(char)*255);
    robot.curLocation = target_loc;
    plog->write("[LCM] SEND COMMAND : MOVE LOCATION TO "+target_loc);
    if(isdebug){
        lcm.publish("COMMAND_"+debug_robot_name.toStdString(),&send_msg);
    }else{
        lcm.publish("COMMAND_"+robot.name.toStdString(),&send_msg);
    }
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
    qDebug() << isdebug << robot.name;
    if(isdebug){
        lcm.publish("COMMAND_"+debug_robot_name.toStdString(),&send_msg);
    }else{
        lcm.publish("COMMAND_"+robot.name.toStdString(),&send_msg);
    }
}
void LCMHandler::movePause(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_PAUSE;
    plog->write("[LCM] SEND COMMAND : MOVE PAUSE");
    if(isdebug){
        lcm.publish("COMMAND_"+debug_robot_name.toStdString(),&send_msg);
    }else{
        lcm.publish("COMMAND_"+robot.name.toStdString(),&send_msg);
    }
}
void LCMHandler::moveResume(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_RESUME;
    plog->write("[LCM] SEND COMMAND : MOVE RESUME");
    if(isdebug){
        lcm.publish("COMMAND_"+debug_robot_name.toStdString(),&send_msg);
    }else{
        lcm.publish("COMMAND_"+robot.name.toStdString(),&send_msg);
    }
}
void LCMHandler::moveJog(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_JOG;
    uint8_t *array;
    array = reinterpret_cast<uint8_t*>(&robot.joystick[0]);
    send_msg.params[0] = array[0];
    send_msg.params[1] = array[1];
    send_msg.params[2] = array[2];
    send_msg.params[3] = array[3];

    array = reinterpret_cast<uint8_t*>(&robot.joystick[1]);
    send_msg.params[4] = array[0];
    send_msg.params[5] = array[1];
    send_msg.params[6] = array[2];
    send_msg.params[7] = array[3];
    plog->write("[LCM] SEND COMMAND : MOVE TARGET TO "+QString().sprintf("%f, %f",robot.joystick[0],robot.joystick[1]));
    if(isdebug){
        qDebug() << debug_robot_name;
        lcm.publish("COMMAND_"+debug_robot_name.toStdString(),&send_msg);
    }else{
        lcm.publish("COMMAND_"+robot.name.toStdString(),&send_msg);
    }
}
void LCMHandler::moveStop(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_STOP;
    plog->write("[LCM] SEND COMMAND : MOVE STOP");
    if(isdebug){
        lcm.publish("COMMAND_"+debug_robot_name.toStdString(),&send_msg);
    }else{
        lcm.publish("COMMAND_"+robot.name.toStdString(),&send_msg);
    }
}
void LCMHandler::moveManual(){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_MOVE_MANUAL;
    plog->write("[LCM] SEND COMMAND : MOVE MANUAL START");
    if(isdebug){
        lcm.publish("COMMAND_"+debug_robot_name.toStdString(),&send_msg);
    }else{
        lcm.publish("COMMAND_"+robot.name.toStdString(),&send_msg);
    }
}

int LCMHandler::getLocationNum(QString name){
    for(int i=0; i<map.locationName.size(); i++){
        if(map.locationName[i] == name){
            return i + 2;
        }
    }
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
    if(isdebug){
        lcm.publish("COMMAND_"+debug_robot_name.toStdString(),&send_msg);
    }else{
        lcm.publish("COMMAND_"+robot.name.toStdString(),&send_msg);
    }
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
    plog->write("[LCM] SEND COMMAND : SET VELOCITY TO "+QString().sprintf("%f",vel));
    if(isdebug){
        lcm.publish("COMMAND_"+debug_robot_name.toStdString(),&send_msg);
    }else{
        lcm.publish("COMMAND_"+robot.name.toStdString(),&send_msg);
    }
}
void LCMHandler::programStart(){
    command send_msg;
//    send_msg.cmd = ROBOT_CMD_START;
    if(isdebug){
        lcm.publish("COMMAND_"+debug_robot_name.toStdString(),&send_msg);
    }else{
        lcm.publish("COMMAND_"+robot.name.toStdString(),&send_msg);
    }
}

void LCMHandler::sendMapPath(QString path){
    command send_msg;
    send_msg.cmd = ROBOT_CMD_SET_MAP;
    memcpy(send_msg.params,path.toUtf8(),sizeof(char)*255);
    if(isdebug){
        lcm.publish("COMMAND_"+debug_robot_name.toStdString(),&send_msg);
    }else{
        lcm.publish("COMMAND_"+robot.name.toStdString(),&send_msg);
    }
}

////*********************************************  CALLBACK FUNCTIONS   ***************************************************////
void LCMHandler::robot_status_callback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const robot_status *msg){
    isconnect = true;
    connect_count = 0;
    robot.battery = msg->bat;
    robot.state = msg->state;
    robot.err_code = msg->err_code;
    robot.curPose.x = msg->robot_pose[0];
    robot.curPose.y = msg->robot_pose[1];
    robot.curPose.th = msg->robot_pose[2];
    for(int i=0; i<360; i++){
        map.lidar_data[i] = msg->robot_scan[i];
    }
}

void LCMHandler::robot_path_callback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const robot_path *msg){
    isconnect = true;
    connect_count = 0;
    flagPath = true;
    robot.pathSize = msg->num;
    for(int i=0; i<robot.pathSize; i++){
        ST_POSE temp;
        temp.x = msg->path[i][0];
        temp.y = msg->path[i][1];
        temp.th = msg->path[i][2];
        if(robot.curPath.size() > i){
            robot.curPath[i] = temp;
        }else{
            robot.curPath.push_back(temp);
        }
    }
    emit pathchanged();
    flagPath = false;
}

void LCMHandler::robot_local_path_callback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const robot_path *msg){
    isconnect = true;
    connect_count = 0;
    flagLocalPath = true;
    robot.localpathSize = msg->num;
    for(int i=0; i<robot.localpathSize; i++){
        ST_POSE temp;
        temp.x = msg->path[i][0];
        temp.y = msg->path[i][1];
        temp.th = msg->path[i][2];
        robot.localPath[i] = temp;
    }
    flagLocalPath = false;
}

////***********************************************   THREADS  ********************************************************////
void LCMHandler::bLoop()
{
    /*
    sudo ifconfig lo multicast
    sudo route add -net 224.0.0.0 netmask 240.0.0.0 dev lo
    */

    // lcm init
    if(lcm.good())
    {
        lcm.subscribe("STATUS_DATA_"+robot.name.toStdString(), &LCMHandler::robot_status_callback, this);
        lcm.subscribe("ROBOT_PATH_"+robot.name.toStdString(), &LCMHandler::robot_path_callback, this);
        lcm.subscribe("ROBOT_LOCAL_PATH_"+robot.name.toStdString(), &LCMHandler::robot_local_path_callback, this);
    }
    else
    {
        isconnect = false;
        qDebug() << "lcm init failed";
    }

    while(bFlag)
    {
        lcm.handleTimeout(1);

        if(robotnamechanged){
            robotnamechanged = false;
            if(isdebug){
                lcm.subscribe("STATUS_DATA_"+debug_robot_name.toStdString(), &LCMHandler::robot_status_callback, this);
                lcm.subscribe("ROBOT_PATH_"+debug_robot_name.toStdString(), &LCMHandler::robot_path_callback, this);
                lcm.subscribe("ROBOT_LOCAL_PATH_"+debug_robot_name.toStdString(), &LCMHandler::robot_local_path_callback, this);
            }else{
                lcm.subscribe("STATUS_DATA_"+robot.name.toStdString(), &LCMHandler::robot_status_callback, this);
                lcm.subscribe("ROBOT_PATH_"+robot.name.toStdString(), &LCMHandler::robot_path_callback, this);
                lcm.subscribe("ROBOT_LOCAL_PATH_"+robot.name.toStdString(), &LCMHandler::robot_local_path_callback, this);
            }
        }
    }
}

void LCMHandler::onTimer(){
    if(flagJoystick){
        moveJog();
        flagJoystick = false;
    }else{
        if(robot.joystick[0] != 0 || robot.joystick[1] != 0 ){
            moveJog();
        }
    }

    if(connect_count++ > 25){
        isconnect = false;
    }


}
