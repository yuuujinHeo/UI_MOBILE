#include "Supervisor.h"
#include <QQmlApplicationEngine>
#include <QKeyEvent>
#include <iostream>
#include <QTextCodec>
#include <QSslSocket>
#include <QGuiApplication>

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

    lcm = new LCMHandler();
    server = new ServerHandler();
    map = server->map;

    isaccepted = false;
    readSetting();

    connect(server,SIGNAL(server_pause()),this,SLOT(server_cmd_pause()));
    connect(server,SIGNAL(server_resume()),this,SLOT(server_cmd_resume()));


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

void Supervisor::server_cmd_pause(){
    plog->write("[SERVER] PAUSE");
    lcm->movePause();
}

void Supervisor::server_cmd_resume(){

    plog->write("[SERVER] RESUME");
    lcm->moveResume();
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

float Supervisor::getLineWidth(int index){
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

void Supervisor::startLine(QString color, float width){
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
    temp_object.clear();
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
        if(lcm->robot.state == ROBOT_STATE_READY){
            if(isaccepted){
                // pickup
                qDebug() << "do pickup";
                ui_state = UI_STATE_PICKUP;
                ui_cmd = UI_CMD_NONE;

                int curNum = 0;
                lcm->robot.pickupTrays.clear();
                for(int i=0; i<NUM_TRAY; i++){
                    if(lcm->robot.tray_num[i] == curNum){
                        lcm->robot.tray_num[i] = 0;
                        if(curNum != 0)
                            lcm->robot.pickupTrays.push_back(i+1);
                    }else if(curNum == 0){
                        curNum = lcm->robot.tray_num[i];
                        lcm->robot.pickupTrays.push_back(i+1);
                        lcm->robot.tray_num[i] = 0;
                    }
                }
                qDebug() << lcm->robot.tray_num[0] << lcm->robot.tray_num[1]<< lcm->robot.tray_num[2];
                QMetaObject::invokeMethod(mMain, "showpickup");
                isaccepted = false;
            }else{
                // move start
                static int timer_cnt = 0;
                if(timer_cnt%5==0){
                    if(lcm->robot.tray_num[0] != 0){
                        lcm->moveTo("serving_"+QString().sprintf("%d",lcm->robot.tray_num[0]-1));
                    }else if(lcm->robot.tray_num[1] != 0){
                        lcm->moveTo("serving_"+QString().sprintf("%d",lcm->robot.tray_num[1]-1));
                    }else if(lcm->robot.tray_num[2] != 0){
                        lcm->moveTo("serving_"+QString().sprintf("%d",lcm->robot.tray_num[2]-1));
                    }else{
                        // move done -> move to wait
                        ui_cmd = UI_CMD_MOVE_WAIT;
                    }
                }
                timer_cnt++;
            }
        }else if(lcm->robot.state == ROBOT_STATE_MOVING){
            // moving
            if(isaccepted){

            }else{
                qDebug() << "robot moving start";
                isaccepted = true;
                ui_state = UI_STATE_MOVING;
                QMetaObject::invokeMethod(mMain, "movelocation");
            }
        }else{
//            qDebug() << "state = " << lcm->robot.state;
        }
        break;
    }
    case UI_CMD_MOVE_WAIT:{
        if(lcm->robot.state == ROBOT_STATE_READY){
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
                lcm->moveTo("resting_0");
            }
        }else if(lcm->robot.state == ROBOT_STATE_MOVING){
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
        if(lcm->robot.state == ROBOT_STATE_READY){
            if(isaccepted){
                // move done
                ui_cmd = UI_CMD_NONE;
                ui_state = UI_STATE_CHARGE;
                isaccepted = false;
                QMetaObject::invokeMethod(mMain, "docharge");
            }else{
                lcm->moveTo("charging_0");
            }
        }else if(lcm->robot.state == ROBOT_STATE_MOVING){
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
        if(lcm->robot.state == ROBOT_STATE_MOVING || lcm->robot.state == ROBOT_STATE_AVOID){
            lcm->movePause();
        }else if(lcm->robot.state == ROBOT_STATE_PAUSED){
            // pause success
            ui_cmd = UI_CMD_NONE;
        }
        break;
    }
    case UI_CMD_RESUME:{
        if(lcm->robot.state == ROBOT_STATE_PAUSED){
            lcm->moveResume();
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
    server->setData(robot_name, lcm->robot);
    lcm->setData(map,lcm->robot);
    //robot state check

}

void Supervisor::readSetting(){
    //Map Meta Data======================================================================
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

    //Annotation======================================================================
    ini_path = "setting/annotation.ini";
    QSettings setting_anot(ini_path, QSettings::IniFormat);
    map.locationSize = 0;

    setting_anot.beginGroup("charging_locations");
    int charge_num = setting_anot.value("num").toInt();
    ST_POSE temp_pose;
    for(int i=0; i<charge_num; i++){
        QString loc_str = setting_anot.value("loc"+QString::number(i)).toString();
        QStringList strlist = loc_str.split(",");
        temp_pose.x = strlist[1].toFloat();
        temp_pose.y = strlist[2].toFloat();
        temp_pose.th = strlist[3].toFloat();
        map.locationName.push_back(strlist[0]);
        map.locationsPose.push_back(temp_pose);
        map.locationSize++;
    }
    setting_anot.endGroup();


    setting_anot.beginGroup("patrol_locations");
    int patrol_num = setting_anot.value("num").toInt();
    for(int i=0; i<patrol_num; i++){
        QString loc_str = setting_anot.value("loc"+QString::number(i)).toString();
        QStringList strlist = loc_str.split(",");
        temp_pose.x = strlist[1].toFloat();
        temp_pose.y = strlist[2].toFloat();
        temp_pose.th = strlist[3].toFloat();
        map.locationName.push_back(strlist[0]);
        map.locationsPose.push_back(temp_pose);
        map.locationSize++;
    }
    setting_anot.endGroup();


    setting_anot.beginGroup("resting_locations");
    int rest_num = setting_anot.value("num").toInt();
    for(int i=0; i<rest_num; i++){
        QString loc_str = setting_anot.value("loc"+QString::number(i)).toString();
        QStringList strlist = loc_str.split(",");
        temp_pose.x = strlist[1].toFloat();
        temp_pose.y = strlist[2].toFloat();
        temp_pose.th = strlist[3].toFloat();
        map.locationName.push_back(strlist[0]);
        map.locationsPose.push_back(temp_pose);
        map.locationSize++;
    }
    setting_anot.endGroup();

    setting_anot.beginGroup("serving_locations");
    int serv_num = setting_anot.value("num").toInt();
    for(int i=0; i<serv_num; i++){
        QString loc_str = setting_anot.value("loc"+QString::number(i)).toString();
        QStringList strlist = loc_str.split(",");
        temp_pose.x = strlist[1].toFloat();
        temp_pose.y = strlist[2].toFloat();
        temp_pose.th = strlist[3].toFloat();
        map.locationName.push_back(strlist[0]);
        map.locationsPose.push_back(temp_pose);
        map.locationSize++;
    }
    setting_anot.endGroup();


    setting_anot.beginGroup("objects");
    int obj_num = setting_anot.value("num").toInt();
    ST_FPOINT temp_point;
    for(int i=0; i<obj_num; i++){
        QString loc_str = setting_anot.value("poly"+QString::number(i)).toString();
        QStringList strlist = loc_str.split(",");
        QVector<ST_FPOINT> temp_v;
        for(int j=1; j<strlist.size(); j++){
            temp_point.x = strlist[j].split(":")[0].toFloat();
            temp_point.y = strlist[j].split(":")[1].toFloat();
            temp_v.push_back(temp_point);
        }
        map.objectName.push_back(strlist[0]);
        map.objectPose.push_back(temp_v);
        map.objectSize++;
    }
    setting_anot.endGroup();


    //Robot Setting================================================================
    ini_path = "setting/robot.ini";
    QSettings setting_robot(ini_path, QSettings::IniFormat);

    setting_robot.beginGroup("ROBOT");
    robot_name = setting_robot.value("name").toString();
    map.margin = setting_robot.value("margin").toFloat();
    qDebug() << "robot name" <<  robot_name;
    setting_robot.endGroup();
}


void Supervisor::setTray(int tray1, int tray2, int tray3){
    plog->write("[UI-FUNCTION] SET TRAY : "+QString().sprintf("%d, %d, %d",tray1,tray2,tray3));
    lcm->robot.tray_num[0] = tray1;
    lcm->robot.tray_num[1] = tray2;
    lcm->robot.tray_num[2] = tray3;
    ui_cmd = UI_CMD_MOVE_TABLE;
}

void Supervisor::moveTo(QString target_num){
    lcm->moveTo(target_num);
}
void Supervisor::moveTo(float x, float y, float th){
    lcm->moveTo(x,y,th);
}
void Supervisor::movePause(){
    lcm->movePause();
}
void Supervisor::moveResume(){
    lcm->moveResume();
}
void Supervisor::moveJog(float vx, float vy, float vth){
    lcm->moveJog(vx,vy,vth);
}
void Supervisor::moveStop(){
    lcm->moveStop();
}

void Supervisor::moveManual(){
    lcm->moveManual();
}

void Supervisor::setVelocity(float vel, float velth){
    lcm->robot.vel_xy = vel;
    lcm->robot.vel_th = velth;
    lcm->setVelocity(vel,velth);
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
    return lcm->robot.battery;
}
int Supervisor::getState(){
    return lcm->robot.state;
}
int Supervisor::getErrcode(){
    return lcm->robot.err_code;
}

QVector<int> Supervisor::getPickuptrays(){
    return lcm->robot.pickupTrays;
}
QString Supervisor::getcurLoc(){
    return lcm->robot.curLocation;
}

QString Supervisor::getcurTable(){
    if(lcm->robot.curLocation.left(7) == "serving"){
        int table = lcm->robot.curLocation.split("_")[1].toInt() + 1;
        qDebug() << lcm->robot.curLocation << table;
        return QString::number(table);
    }
    return "0";
}

void Supervisor::joyMoveXY(float x, float y){
    lcm->robot.joy_x = x;
    lcm->robot.joy_y = y;
    lcm->flagJoystick = true;
}
void Supervisor::joyMoveR(float r){
    lcm->robot.joy_th = r;
    lcm->flagJoystick = true;
}

QVector<float> Supervisor::getcurTarget(){
    QVector<float> temp;
    temp.push_back(lcm->robot.curTarget.x);
    temp.push_back(lcm->robot.curTarget.y);
    temp.push_back(lcm->robot.curTarget.th);
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
    file = new QFile("image/map_rotated.png");
    bool isopen = file->open(QIODevice::ReadOnly);
    delete file;
    return isopen;
}

float Supervisor::getVelocityXY(){
    return lcm->robot.vel_xy;
}
float Supervisor::getVelocityTH(){
    return lcm->robot.vel_th;
}

bool Supervisor::getMapState(){
    return lcm->isdownloadMap;
}
QString Supervisor::getMapname(){
    return map.map_name;
}
QString Supervisor::getMappath(){
    return "file://" + QGuiApplication::applicationDirPath() + "/image/" + map.map_name + ".png";
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
    return map.locationName[num];
}
float Supervisor::getLocationx(int num){
    ST_POSE temp = lcm->setAxis(map.locationsPose[num]);
    return temp.x;
}
float Supervisor::getLocationy(int num){
    ST_POSE temp = lcm->setAxis(map.locationsPose[num]);
    return temp.y;
}
float Supervisor::getLocationth(int num){
    ST_POSE temp = lcm->setAxis(map.locationsPose[num]);
    return temp.th;
}
int Supervisor::getObjectNum(){
    return map.objectSize;
}
QString Supervisor::getObjectName(int num){
    return map.objectName[num];
}
int Supervisor::getObjectPointSize(int num){
    return map.objectPose[num].size();
}
float Supervisor::getObjectX(int num, int point){
    ST_FPOINT temp = lcm->setAxis(map.objectPose[num][point]);
    return temp.x;
}
float Supervisor::getObjectY(int num, int point){
    ST_FPOINT temp = lcm->setAxis(map.objectPose[num][point]);
    return temp.y;
}
int Supervisor::getTempObjectSize(){
    return temp_object.size();
}
float Supervisor::getTempObjectX(int num){
    ST_FPOINT temp = lcm->setAxis(temp_object[num]);
    return temp.x;
}
float Supervisor::getTempObjectY(int num){
    ST_FPOINT temp = lcm->setAxis(temp_object[num]);
    return temp.y;
}
void Supervisor::addObjectPoint(int x, int y){
    ST_FPOINT temp = lcm->canvasTomap(x,y);
    plog->write("[DEBUG] addObjectPoint " + QString().sprintf("[%d] %f, %f",temp_object.size(),temp.x,temp.y));
    temp_object.push_back(temp);

    QMetaObject::invokeMethod(mMain, "updatecanvas");
}
void Supervisor::editObjectPoint(int num, int x, int y){
    if(num < temp_object.size()){
        plog->write("[DEBUG] editObjectPoint " + QString().sprintf("%d (x)%f -> %f (y)%f -> %f",num,temp_object[num].x,x,temp_object[num].y,y));
        ST_FPOINT temp = lcm->canvasTomap(x,y);
        temp_object[num].x = temp.x;
        temp_object[num].y = temp.y;
        QMetaObject::invokeMethod(mMain, "updatecanvas");
    }
}

void Supervisor::removeObjectPoint(int num){
    if(num < temp_object.size()){
        temp_object.remove(num);
        QMetaObject::invokeMethod(mMain, "updatecanvas");
    }else{
        plog->write("[DEBUG] removeObjectPoint " + QString().sprintf("%d, %d",num,temp_object.size()));
    }
}

void Supervisor::removeObject(QString name){
    for(int i=0; i<map.objectSize; i++){
        if(map.objectName[i] == name){
            plog->write("[UI-MAP] REMOVE OBJECT "+ name);
            map.objectName.remove(i);
            map.objectPose.remove(i);
            map.objectSize--;
            QMetaObject::invokeMethod(mMain, "updateobject");
            return;
        }
    }
    plog->write("[UI-MAP] REMOVE OBJECT BUT FAILED "+ name);
}

void Supervisor::moveObjectPoint(int obj_num, int point_num, int x, int y){
    if(obj_num > -1 && obj_num < map.objectSize){
        if(point_num > -1 && point_num < map.objectPose[obj_num].size()){
            ST_FPOINT pos = lcm->canvasTomap(x,y);
            map.objectPose[obj_num][point_num].x = pos.x;
            map.objectPose[obj_num][point_num].y = pos.y;
            qDebug() << "Move Point " << pos.x << pos.y;
            QMetaObject::invokeMethod(mMain, "updatecanvas");

        }
    }
}

float Supervisor::getMargin(){
    return map.margin;
}
void Supervisor::removeObjectPointLast(){
    if(temp_object.size() > 0){
        temp_object.pop_back();
        QMetaObject::invokeMethod(mMain, "updatecanvas");
    }
}

void Supervisor::clearObjectPoints(){
    temp_object.clear();
    QMetaObject::invokeMethod(mMain, "updatecanvas");
}
void Supervisor::addObject(QString name){
    if(temp_object.size() > 0){
        map.objectName.push_back(name);
        map.objectPose.push_back(temp_object);
        temp_object.clear();
        map.objectSize++;
        QMetaObject::invokeMethod(mMain, "updatecanvas");
        QMetaObject::invokeMethod(mMain, "updateobject");

        plog->write("[DEBUG] addObject " + name);
    }else{
        plog->write("[DEBUG] addObject " + name + " but size = 0");
    }
}

void Supervisor::clickObject(QString name){

}

void Supervisor::clickObject(float x, float y){

}

int Supervisor::getObjNum(QString name){
    for(int i=0; i<map.objectSize; i++){
        if(map.objectName[i] == name){
            return i;
        }
    }
    return -1;
}
int Supervisor::getObjNum(int x, int y){
    for(int i=0; i<map.objectSize; i++){
        //Find Square Pos
        ST_FPOINT uL, dR;
        uL.x = map.objectPose[i][0].x;
        uL.y = map.objectPose[i][0].y;
        dR.x = map.objectPose[i][0].x;
        dR.y = map.objectPose[i][0].y;
        for(int j=1; j<map.objectPose[i].size(); j++){
            if(uL.x > map.objectPose[i][j].x){
                uL.x = map.objectPose[i][j].x;
            }
            if(uL.y > map.objectPose[i][j].y){
                uL.y = map.objectPose[i][j].y;
            }
            if(dR.x < map.objectPose[i][j].x){
                dR.x = map.objectPose[i][j].x;
            }
            if(dR.y < map.objectPose[i][j].y){
                dR.y = map.objectPose[i][j].y;
            }
        }
//        qDebug() << i << " : " << uL.x << uL.y << dR.x << dR.y;

        ST_FPOINT pos = lcm->canvasTomap(x,y);

        if(pos.x>uL.x && pos.x<dR.x){
            if(pos.y>uL.y && pos.y<dR.y){
                qDebug() << "Match!! : " << i;
                return i;
            }
        }
    }
    return -1;
    qDebug() << "can't find obj num : " << x << y;
}

int Supervisor::getObjPointNum(int obj_num, int x, int y){
    ST_FPOINT pos = lcm->canvasTomap(x,y);
    qDebug() << pos.x << pos.y;
    if(obj_num < map.objectSize && obj_num > -1){
        qDebug() << "check obj" << obj_num << map.objectPose[obj_num].size();
        if(obj_num != -1){
            for(int j=0; j<map.objectPose[obj_num].size(); j++){
                qDebug() << map.objectPose[obj_num][j].x << map.objectPose[obj_num][j].y;
                if(fabs(map.objectPose[obj_num][j].x - pos.x) < 0.1){
                    if(fabs(map.objectPose[obj_num][j].y - pos.y) < 0.1){
                        qDebug() << "Match Point !!" << obj_num << j;
                        return j;
                    }
                }
            }
        }
    }
    qDebug() << "can't find obj num : " << x << y;
    return -1;

}

float Supervisor::getRobotx(){
    ST_POSE temp = lcm->setAxis(lcm->robot.curPose);
    return temp.x;
}
float Supervisor::getRoboty(){
    ST_POSE temp = lcm->setAxis(lcm->robot.curPose);
    return temp.y;
}
float Supervisor::getRobotth(){
    ST_POSE temp = lcm->setAxis(lcm->robot.curPose);
    return temp.th;
}

int Supervisor::getRobotState(){
    return lcm->robot.state;
}
int Supervisor::getPathNum(){
    return lcm->robot.pathSize;
}
float Supervisor::getPathx(int num){
    ST_POSE temp = lcm->setAxis(lcm->robot.curPath[num]);
    return temp.x;
}
float Supervisor::getPathy(int num){
    ST_POSE temp = lcm->setAxis(lcm->robot.curPath[num]);
    return temp.y;
}
float Supervisor::getPathth(int num){
    ST_POSE temp = lcm->setAxis(lcm->robot.curPath[num]);
    return temp.th;
}
