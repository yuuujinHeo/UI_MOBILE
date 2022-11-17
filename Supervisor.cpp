#include "Supervisor.h"
#include <QQmlApplicationEngine>
#include <QKeyEvent>
#include <iostream>
#include <QTextCodec>
#include <QSslSocket>

//extern QObject *object;

extern QObject *object;
using namespace std;
Supervisor::Supervisor(QObject *parent)
    : QObject(parent)
{
    timer = new QTimer();
    connect(timer, SIGNAL(timeout()),this,SLOT(onTimer()));
    timer->start(200);
    canvas.clear();
    flag_clear = 0;
    dbHandler = new DBHandler();

    mMain = nullptr;

    server = new ServerHandler();
    map = server->map;

    isaccepted = false;
    readSetting();
}

void Supervisor::setWindow(QQuickWindow *Window){
    qDebug() << "SET WINDOW!!!!!!!!!!!!!!!!";
    mMain = Window;
}
QQuickWindow *Supervisor::getWindow()
{
    std::cout << "getWindow called "<<std::endl;
    return mMain;
}

void Supervisor::setObject(QObject *object)
{
    mObject = object;//invokemethod의 매개변수에는 rootobject값이 필요하기 때문에 set으로 설정 해준다.
}

QObject *Supervisor::getObject()
{
    return mObject;//rootobject를 리턴해준다.
}

int Supervisor::getCanvasSize(){
    return canvas.size();
}
int Supervisor::getRedoSize(){
    qDebug() <<canvas_redo.size();
    return canvas_redo.size();
}
QVector<int> Supervisor::getLineX(int index){
    QVector<int>    temp_x;
    for(int i=0; i<canvas[index].line.size(); i++){
        temp_x.push_back(canvas[index].line[i].x);
    }
    return temp_x;
}
QVector<int> Supervisor::getLineY(int index){
    QVector<int>    temp_y;
    for(int i=0; i<canvas[index].line.size(); i++){
        temp_y.push_back(canvas[index].line[i].y);
    }
    return temp_y;
}

QString Supervisor::getLineColor(int index){
    if(index < canvas.size()){
        return canvas[index].color;
    }
    return "";
}

double Supervisor::getLineWidth(int index){
    if(index < canvas.size()){
        return canvas[index].width;
    }
    return 0;
}


void Supervisor::setLine(int x, int y){
    ST_POINT temp_point;
    temp_point.x = x;
    temp_point.y = y;
    temp_line.line.push_back(temp_point);

}

void Supervisor::startLine(QString color, double width){
    temp_line.line.clear();
    temp_line.color = color;
    temp_line.width = width;

    qDebug() << "startLine : " << color << width;
}
void Supervisor::stopLine(){
    canvas.push_back(temp_line);
    canvas_redo.clear();
}

void Supervisor::undo(){
    ST_LINE temp;
    if(canvas.size() > 0){
        temp = canvas.back();
        canvas.pop_back();
        canvas_redo.push_back(temp);

        qDebug() << "UNDO [canvas size = "<<canvas.size() << "] redo size = " << canvas_redo.size();
    }
}

void Supervisor::redo(){
    if(canvas_redo.size() > 0){
        if(flag_clear == 1){
            flag_clear = 0;
            if(canvas.size() > 0){

            }else{
                canvas = canvas_redo;
                canvas_redo.clear();
            }
        }else{
            canvas.push_back(canvas_redo.back());
            canvas_redo.pop_back();
        }
        qDebug() << "REDO [canvas size = "<<canvas.size() << "] redo size = " << canvas_redo.size();
    }
}

QString Supervisor::getMapURL(){
    return dbHandler->DBbase["map_url"];
}

void Supervisor::setMapURL(QString url){
    dbHandler->editDataBase("map_url",url);
}

QString Supervisor::getDBvalue(QString name){
    return dbHandler->DBbase[name];
}

void Supervisor::clear_all(){
    canvas_redo.clear();
    for(int i=0; i<canvas.size(); i++){
        canvas_redo.push_back(canvas[i]);
        flag_clear = 1;
    }
    canvas.clear();
    qDebug() << "CLEAR [canvas size = "<<canvas.size() << "] redo size = " << canvas_redo.size();

}




////////////////////////////////////////////////////////////////////////////////////////
void Supervisor::onTimer(){
    if(mMain == nullptr && object != nullptr){
        setObject(object);
        setWindow(qobject_cast<QQuickWindow*>(object));
    }

    switch(ui_cmd){
    case UI_CMD_MOVE_TABLE:{
        if(lcm.robot.state == ROBOT_STATE_READY){
            if(isaccepted){
                // pickup
                qDebug() << "do pickup";
                ui_state = UI_STATE_PICKUP;
                ui_cmd = UI_CMD_NONE;

                int curNum = 0;
                lcm.robot.pickupTrays.clear();
                for(int i=0; i<NUM_TRAY; i++){
                    if(lcm.robot.tray_num[i] == curNum){
                        lcm.robot.tray_num[i] = 0;
                        if(curNum != 0)
                            lcm.robot.pickupTrays.push_back(i+1);
                    }else if(curNum == 0){
                        curNum = lcm.robot.tray_num[i];
                        lcm.robot.pickupTrays.push_back(i+1);
                        lcm.robot.tray_num[i] = 0;
                    }
                }
                qDebug() << lcm.robot.tray_num[0] << lcm.robot.tray_num[1]<< lcm.robot.tray_num[2];
                QMetaObject::invokeMethod(mMain, "showpickup");
                isaccepted = false;
            }else{
                // move start
                static int timer_cnt = 0;
                if(timer_cnt%5==0){
                    if(lcm.robot.tray_num[0] != 0){
                        lcm.moveTo("serving_"+QString().sprintf("%d",lcm.robot.tray_num[0]-1));
                    }else if(lcm.robot.tray_num[1] != 0){
                        lcm.moveTo("serving_"+QString().sprintf("%d",lcm.robot.tray_num[1]-1));
                    }else if(lcm.robot.tray_num[2] != 0){
                        lcm.moveTo("serving_"+QString().sprintf("%d",lcm.robot.tray_num[2]-1));
                    }else{
                        // move done -> move to wait
                        ui_cmd = UI_CMD_MOVE_WAIT;
                    }
                }
                timer_cnt++;
            }
        }else if(lcm.robot.state == ROBOT_STATE_MOVING){
            // moving
            if(isaccepted){

            }else{
                qDebug() << "robot moving start";
                isaccepted = true;
                ui_state = UI_STATE_MOVING;
                QMetaObject::invokeMethod(mMain, "movelocation");
            }
        }else{
            qDebug() << "state = " << lcm.robot.state;
        }
        break;
    }
    case UI_CMD_MOVE_WAIT:{
        if(lcm.robot.state == ROBOT_STATE_READY){
            if(isaccepted){
                // move done
                qDebug() << "move done";
                ui_cmd = UI_CMD_NONE;
                QMetaObject::invokeMethod(mMain, "waitkitchen");
//                ui_cmd = UI_CMD_WAIT_KITCHEN;
                ui_state = UI_STATE_READY;
                isaccepted = false;
            }else{
                qDebug() << "move to wait";
                lcm.moveTo("wait_0");
            }
        }else if(lcm.robot.state == ROBOT_STATE_MOVING){
            // moving
            if(isaccepted){

            }else{
                qDebug() << "robot wait moving start";
                isaccepted = true;
                ui_state = UI_STATE_MOVING;
                QMetaObject::invokeMethod(mMain, "movelocation");
            }
        }
        break;
    }
    case UI_CMD_WAIT_KITCHEN:{
        QMetaObject::invokeMethod(mMain, "waitkitchen");
        ui_cmd = UI_CMD_NONE;
        break;
    }
    case UI_CMD_MOVE_CHARGE:{
        if(lcm.robot.state == ROBOT_STATE_READY){
            if(isaccepted){
                // move done
                ui_cmd = UI_CMD_NONE;
                ui_state = UI_STATE_CHARGE;
                isaccepted = false;
                QMetaObject::invokeMethod(mMain, "docharge");
            }else{
                lcm.moveTo("charging_0");
            }
        }else if(lcm.robot.state == ROBOT_STATE_MOVING){
            // moving
            if(isaccepted){

            }else{
                qDebug() << "robot charge moving start";
                isaccepted = true;
                ui_state = UI_STATE_MOVING;
                QMetaObject::invokeMethod(mMain, "movelocation");
            }
        }
        break;
    }
    case UI_CMD_PAUSE:{
        if(lcm.robot.state == ROBOT_STATE_MOVING || lcm.robot.state == ROBOT_STATE_AVOID){
            lcm.movePause();
        }else if(lcm.robot.state == ROBOT_STATE_PAUSED){
            // pause success
            ui_cmd = UI_CMD_NONE;
        }
        break;
    }
    case UI_CMD_RESUME:{
        if(lcm.robot.state == ROBOT_STATE_PAUSED){
            lcm.moveResume();
        }else{
            // resume success
            ui_cmd = UI_CMD_NONE;
        }
        break;
    }
    case UI_CMD_PICKUP_CONFIRM:{
        ui_cmd = UI_CMD_MOVE_TABLE;
        break;
    }
    default:{

    }
    }

    //Server data set
    if(server->map.map_name == ""){
        server->setMap(map);
    }
    server->setData(robot_name, lcm.robot);

    //robot state check

}

void Supervisor::readSetting(){
    QString ini_path = "setting/map_meta.ini";
    QSettings setting_meta(ini_path, QSettings::IniFormat);

    setting_meta.beginGroup("map_metadata");
    map.map_name = setting_meta.value("name").toString();
    map.width = setting_meta.value("map_w").toInt();
    map.height = setting_meta.value("map_h").toInt();
    map.gridwidth = setting_meta.value("map_grid_width").toFloat();
    map.origin[0] = setting_meta.value("map_origin_u").toInt();
    map.origin[1] = setting_meta.value("map_origin_v").toInt();
    setting_meta.endGroup();

    ini_path = "setting/annotation.ini";
    QSettings setting_anot(ini_path, QSettings::IniFormat);
    map.locationSize = 0;



    setting_anot.beginGroup("charging_location");
    map.locationTypes.push_back("charge");
    int charge_num = setting_anot.value("total_number").toInt();
    map.locationSize+=charge_num;

    ST_POSE temp_pose;
    for(int i=0; i<charge_num; i++){
        QString str = "loc"+QString::number(i);
        temp_pose.x = setting_anot.value(str+"_x").toFloat();
        temp_pose.y = setting_anot.value(str+"_y").toFloat();
        temp_pose.th = setting_anot.value(str+"_th").toFloat();
        map.locationsPose.push_back(temp_pose);
    }
    setting_anot.endGroup();


    setting_anot.beginGroup("resting_location");
    map.locationTypes.push_back("wait");
    int wait_num = setting_anot.value("total_number").toInt();
    map.locationSize+=wait_num;

    for(int i=0; i<wait_num; i++){
        QString str = "loc"+QString::number(i);
        temp_pose.x = setting_anot.value(str+"_x").toFloat();
        temp_pose.y = setting_anot.value(str+"_y").toFloat();
        temp_pose.th = setting_anot.value(str+"_th").toFloat();
        map.locationsPose.push_back(temp_pose);
    }
    setting_anot.endGroup();



    setting_anot.beginGroup("serving_location");
    int serving_num = setting_anot.value("total_number").toInt();
    map.locationSize += serving_num;

    for(int i=0; i<serving_num; i++){
        QString str = "loc"+QString::number(i);
        map.locationTypes.push_back("table");

        ST_POSE temp_pose;
        temp_pose.x = setting_anot.value(str+"_x").toFloat();
        temp_pose.y = setting_anot.value(str+"_y").toFloat();
        temp_pose.th = setting_anot.value(str+"_th").toFloat();
        qDebug() << str << temp_pose.x << temp_pose.y << temp_pose.th;
        map.locationsPose.push_back(temp_pose);
    }
    setting_anot.endGroup();

    ini_path = "setting/robot.ini";
    QSettings setting_robot(ini_path, QSettings::IniFormat);

    setting_robot.beginGroup("ROBOT");
    robot_name = setting_robot.value("name").toString();
    qDebug() << "robot name" <<  robot_name;
    setting_robot.endGroup();
}


void Supervisor::setTray(int tray1, int tray2, int tray3){
    plog->write("[UI-FUNCTION] SET TRAY : "+QString().sprintf("%d, %d, %d",tray1,tray2,tray3));
    lcm.robot.tray_num[0] = tray1;
    lcm.robot.tray_num[1] = tray2;
    lcm.robot.tray_num[2] = tray3;
    ui_cmd = UI_CMD_MOVE_TABLE;
}

void Supervisor::moveTo(QString target_num){
    lcm.moveTo(target_num);
}
void Supervisor::moveTo(float x, float y, float th){
    lcm.moveTo(x,y,th);
}
void Supervisor::movePause(){
    lcm.movePause();
}
void Supervisor::moveResume(){
    lcm.moveResume();
}
void Supervisor::moveJog(float vx, float vy, float vth){
    lcm.moveJog(vx,vy,vth);
}
void Supervisor::moveStop(){
    lcm.moveStop();
}

void Supervisor::moveManual(){
    lcm.moveManual();
}

void Supervisor::setVelocity(float vel, float velth){
    lcm.robot.vel_xy = vel;
    lcm.robot.vel_th = velth;
    lcm.setVelocity(vel,velth);
}

void Supervisor::confirmPickup(){
    ui_cmd = UI_CMD_PICKUP_CONFIRM;
}

void Supervisor::moveToCharge(){
    ui_cmd = UI_CMD_MOVE_CHARGE;
}

void Supervisor::moveToWait(){
    ui_cmd = UI_CMD_MOVE_WAIT;
}
float Supervisor::getBattery(){
    return lcm.robot.battery;
}
int Supervisor::getState(){
    return lcm.robot.state;
}
int Supervisor::getErrcode(){
    return lcm.robot.err_code;
}

QVector<int> Supervisor::getPickuptrays(){
    return lcm.robot.pickupTrays;
}
QString Supervisor::getcurLoc(){
    return lcm.robot.curLocation;
}

QString Supervisor::getcurTable(){
    if(lcm.robot.curLocation.left(7) == "serving"){
        int table = lcm.robot.curLocation.split("_")[1].toInt() + 1;
        qDebug() << lcm.robot.curLocation << table;
        return QString::number(table);
    }
    return "0";
}

void Supervisor::joyMoveXY(float x, float y){
    lcm.robot.joy_x = x;
    lcm.robot.joy_y = y;
    lcm.flagJoystick = true;
}
void Supervisor::joyMoveR(float r){
    lcm.robot.joy_th = r;
    lcm.flagJoystick = true;
}

QVector<float> Supervisor::getcurTarget(){
    QVector<float> temp;
    temp.push_back(lcm.robot.curTarget.x);
    temp.push_back(lcm.robot.curTarget.y);
    temp.push_back(lcm.robot.curTarget.th);
    return temp;
}
int Supervisor::getImageChunkNum(){
    return map.chunkSize;
}
unsigned int Supervisor::getImageSize(){
    return map.imageSize;
}
//QByteArray Supervisor::getImageData(){
//    QByteArray temp;
//    for(int i=0; i<map.imageSize; i++){
//        temp.push_back(map.data[i]);
//    }

//    qDebug() << temp;
//    return temp;
//}



void Supervisor::startRecordPath(){

}
void Supervisor::startcurPath(){

}
void Supervisor::stopcurPath(){

}
void Supervisor::pausecurPath(){

}

#include <iostream>
QString Supervisor::getImageData(){
    QVector<int>  temp;
    QByteArray teee;
    for(int i=0; i<map.imageSize; i++){
        teee.push_back(map.data[i]);
        teee.push_back(map.data[i]);
        teee.push_back(map.data[i]);
        teee.push_back(255);

//        temp.push_back(map.data[i]);
//        temp.push_back(0);
//        temp.push_back(0);
//        temp.push_back(1);
    }

    QImage temp_image((const unsigned char*)teee.data(),map.width,map.height,QImage::Format_ARGB32);
//    temp_image = QImage::fromData(teee, "png");
//    Image imm;
    if(temp_image.save("image/testplz.png","PNG")){
        qDebug() << "Success";
    }else{
        qDebug() << "FAil";
    }


    QString imagestr("data:image/png;base64,");
    imagestr.append(teee.toBase64().data());
//    qDebug() << imagestr;

    return imagestr;
}

QString Supervisor::getRobotName(){
    return robot_name;
}

void Supervisor::setRobotName(QString name){
    robot_name = name;
    //set ini
    QString ini_path = "setting/robot.ini";
    QSettings settings(ini_path, QSettings::IniFormat);
    settings.setValue("ROBOT/name",robot_name);
}
bool Supervisor::getMapExist(){
    QFile *file;
    file = new QFile("image/map_downloaded.png");
    bool isopen = file->open(QIODevice::ReadOnly);
    delete file;
    return isopen;
}

float Supervisor::getVelocityXY(){
    return lcm.robot.vel_xy;
}
float Supervisor::getVelocityTH(){
    return lcm.robot.vel_th;
}

bool Supervisor::getMapState(){
    return lcm.isdownloadMap;
}
QString Supervisor::getMapname(){
    return map.map_name;
}
int Supervisor::getMapWidth(){
    return map.width;
}
int Supervisor::getMapHeight(){
    return map.height;
}
float Supervisor::getGridWidth(){
    return map.gridwidth;
}
QVector<int> Supervisor::getOrigin(){
    QVector<int> temp;
    temp.push_back(map.origin[0]);
    temp.push_back(map.origin[1]);
    return temp;
}
int Supervisor::getLocationNum(){
    return map.locationSize;
}
QString Supervisor::getLocationTypes(int num){
    return map.locationTypes[num];
}
float Supervisor::getLocationx(int num){
    ST_POSE temp = lcm.setAxis(map.locationsPose[num]);
    return temp.x;
}
float Supervisor::getLocationy(int num){
    ST_POSE temp = lcm.setAxis(map.locationsPose[num]);
    return temp.y;
}
float Supervisor::getLocationth(int num){
    ST_POSE temp = lcm.setAxis(map.locationsPose[num]);
    return temp.th;
}

float Supervisor::getRobotx(){
    ST_POSE temp = lcm.setAxis(lcm.robot.curPose);
    return temp.x;
}
float Supervisor::getRoboty(){
    ST_POSE temp = lcm.setAxis(lcm.robot.curPose);
    return temp.y;
}
float Supervisor::getRobotth(){
    ST_POSE temp = lcm.setAxis(lcm.robot.curPose);
    return temp.th;
}

int Supervisor::getRobotState(){
    return lcm.robot.state;
}
int Supervisor::getPathNum(){
    return lcm.robot.pathSize;
}
float Supervisor::getPathx(int num){
    ST_POSE temp = lcm.setAxis(lcm.robot.curPath[num]);
    return temp.x;
}
float Supervisor::getPathy(int num){
    ST_POSE temp = lcm.setAxis(lcm.robot.curPath[num]);
    return temp.y;
}
float Supervisor::getPathth(int num){
    ST_POSE temp = lcm.setAxis(lcm.robot.curPath[num]);
    return temp.th;
}
