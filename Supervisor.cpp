#include "Supervisor.h"
#include <QQmlApplicationEngine>
#include <QKeyEvent>
#include <iostream>
#include <QTextCodec>
#include <QSslSocket>
#include <QGuiApplication>
#include <usb.h>

#include <QDir>
#include <QFileSystemWatcher>
#include <QtQuick/qquickimageprovider.h>

extern QObject *object;

ST_ROBOT *probot;
ST_MAP *pmap;
int ui_state = 0;
bool is_debug = false;

Supervisor::Supervisor(QObject *parent)
    : QObject(parent)
{
    timer = new QTimer();
    connect(timer, SIGNAL(timeout()),this,SLOT(onTimer()));
    timer->start(200);
    canvas.clear();
    flag_clear = false;

    probot = &robot;
    pmap = &map;
    mMain = nullptr;

    usb_map_list.clear();
    usb_check = false;
    usb_check_count = 0;

    canvas.clear();
    canvas_redo.clear();
    minimap_grid.clear();



    lcm = new LCMHandler();
    server = new ServerHandler();
    joystick = new JoystickHandler();

    //Test USB
    QFileSystemWatcher *FSwatcher;
    FSwatcher = new QFileSystemWatcher(this);
    std::string user = getenv("USER");
    std::string path = "/media/" + user;
    FSwatcher->addPath(path.c_str());
    connect(FSwatcher, SIGNAL(directoryChanged(QString)),this,SLOT(usb_detect()));
    usb_detect();

    isaccepted = false;
    readSetting();
    ui_state = UI_STATE_NONE;

    connect(server,SIGNAL(server_pause()),this,SLOT(server_cmd_pause()));
    connect(server,SIGNAL(server_resume()),this,SLOT(server_cmd_resume()));
    connect(server,SIGNAL(server_new_target()),this,SLOT(server_cmd_newtarget()));
    connect(server,SIGNAL(server_new_call()),this,SLOT(server_cmd_newcall()));
    connect(server,SIGNAL(server_set_ini()),this,SLOT(server_cmd_setini()));
    connect(lcm, SIGNAL(pathchanged()),this,SLOT(path_changed()));
    plog->write("[BUILDER] SUPERVISOR constructed");
}


////*********************************************  WINDOW 관련   ***************************************************////
void Supervisor::setWindow(QQuickWindow *Window){
    plog->write("[BUILDER] SET WINDOW ");
    mMain = Window;
}
QQuickWindow *Supervisor::getWindow()
{
    std::cout << "getWindow called "<<std::endl;
    return mMain;
}
void Supervisor::setObject(QObject *object)
{
    //invokemethod의 매개변수에는 rootobject값이 필요하기 때문에 set으로 설정 해준다.
    mObject = object;
}
QObject *Supervisor::getObject()
{
    //rootobject를 리턴해준다.
    return mObject;
}
void Supervisor::programExit(){
    plog->write("[USER INPUT] PROGRAM EXIT");
    QCoreApplication::quit();
}
void Supervisor::programHide(){
    plog->write("[USER INPUT] PROGRAM MINIMIZE");
}
void Supervisor::writelog(QString msg){
    plog->write(msg);
}

////*********************************************  SETTING 관련   ***************************************************////
void Supervisor::setSetting(QString name, QString value){
    QString ini_path = "setting/robot.ini";
    QSettings setting(ini_path, QSettings::IniFormat);
    setting.setValue(name,value);
    plog->write("[SETTING] SET "+name+" VALUE TO "+value);
    readSetting();
}
void Supervisor::readSetting(){
    //Map Meta Data======================================================================
    QString ini_path = "setting/map_meta.ini";
    QSettings setting_meta(ini_path, QSettings::IniFormat);

    setting_meta.beginGroup("map_metadata");
    pmap->map_name = setting_meta.value("name").toString();
    pmap->width = setting_meta.value("map_w").toInt();
    pmap->height = setting_meta.value("map_h").toInt();
    pmap->gridwidth = setting_meta.value("map_grid_width").toFloat();
    pmap->origin[0] = setting_meta.value("map_origin_u").toInt();
    pmap->origin[1] = setting_meta.value("map_origin_v").toInt();
    setting_meta.endGroup();

    //Annotation======================================================================
    ini_path = "setting/annotation.ini";
    QSettings setting_anot(ini_path, QSettings::IniFormat);

    setting_anot.beginGroup("charging_locations");
    int charge_num = setting_anot.value("num").toInt();
    pmap->vecLocation.clear();
    ST_POSE temp_pose;
    ST_LOCATION temp_loc;
    for(int i=0; i<charge_num; i++){
        QString loc_str = setting_anot.value("loc"+QString::number(i)).toString();
        QStringList strlist = loc_str.split(",");
        temp_pose.x = strlist[1].toFloat();
        temp_pose.y = strlist[2].toFloat();
        temp_pose.th = strlist[3].toFloat();
        temp_loc.pose = temp_pose;
        temp_loc.type = "Charging";
        temp_loc.name = strlist[0];
        pmap->vecLocation.push_back(temp_loc);
    }
    setting_anot.endGroup();


    setting_anot.beginGroup("other_locations");
    int patrol_num = setting_anot.value("num").toInt();
    for(int i=0; i<patrol_num; i++){
        QString loc_str = setting_anot.value("loc"+QString::number(i)).toString();
        QStringList strlist = loc_str.split(",");
        temp_pose.x = strlist[1].toFloat();
        temp_pose.y = strlist[2].toFloat();
        temp_pose.th = strlist[3].toFloat();
        temp_loc.pose = temp_pose;
        temp_loc.type = "Other";
        temp_loc.name = strlist[0];
        pmap->vecLocation.push_back(temp_loc);
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
        temp_loc.pose = temp_pose;
        temp_loc.type = "Resting";
        temp_loc.name = strlist[0];
        pmap->vecLocation.push_back(temp_loc);
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
        temp_loc.pose = temp_pose;
        temp_loc.type = "Serving";
        temp_loc.name = strlist[0];
        pmap->vecLocation.push_back(temp_loc);
    }
    setting_anot.endGroup();

    setting_anot.beginGroup("objects");
    int obj_num = setting_anot.value("num").toInt();
    pmap->vecObject.clear();
    ST_FPOINT temp_point;
    for(int i=0; i<obj_num; i++){
        QString name = setting_anot.value("poly"+QString::number(i)).toString();
        QStringList strlist = name.split(",");
        ST_OBJECT temp_obj;
        if(strlist[0].left(5) == "Table"){
            temp_obj.type = "Table";
        }else if(strlist[0].left(5) == "Chair"){
            temp_obj.type = "Chair";
        }else if(strlist[0].left(4) == "Wall"){
            temp_obj.type = "Wall";
        }else{
            temp_obj.type = "Unknown";
        }

        if(strlist[1].toInt() == 1){
            temp_obj.is_rect = true;
        }else{
            temp_obj.is_rect = false;
        }

        for(int j=2; j<strlist.size(); j++){
            temp_point.x = strlist[j].split(":")[0].toFloat();
            temp_point.y = strlist[j].split(":")[1].toFloat();
            temp_obj.pose.push_back(temp_point);
        }
        pmap->vecObject.push_back(temp_obj);
    }
    setObjPose();
    setting_anot.endGroup();

    setting_anot.beginGroup("travel_lines");
    int trav_num = setting_anot.value("num").toInt();
    pmap->vecTline.clear();
    for(int i=0; i<trav_num; i++){
        QString loc_str = setting_anot.value("line"+QString::number(i)).toString();
        QStringList strlist = loc_str.split(",");
        QVector<ST_FPOINT> temp_v;
        for(int j=1; j<strlist.size(); j++){
            temp_point.x = strlist[j].split(":")[0].toFloat();
            temp_point.y = strlist[j].split(":")[1].toFloat();
            temp_v.push_back(temp_point);
        }
        pmap->vecTline.push_back(temp_v);
    }
    setting_anot.endGroup();

    //Robot Setting================================================================
    ini_path = "setting/robot.ini";
    QSettings setting_robot(ini_path, QSettings::IniFormat);

    setting_robot.beginGroup("ROBOT");
    probot->name = setting_robot.value("name").toString();
    probot->radius = setting_robot.value("radius").toFloat();
    probot->type = setting_robot.value("type").toString();
    probot->velocity = setting_robot.value("velocity").toFloat();
    setting.tray_num = setting_robot.value("tray_num").toInt();
    setting.useVoice = setting_robot.value("use_voice").toBool();
    setting.useBGM = setting_robot.value("use_bgm").toBool();
    setting_robot.endGroup();

    setting_robot.beginGroup("FLOOR");
    pmap->margin = setting_robot.value("margin").toFloat();
    pmap->use_server = setting_robot.value("map_server").toBool();
    pmap->map_loaded = setting_robot.value("map_load").toBool();
    setting.table_num = setting_robot.value("table_num").toInt();
    setting.table_col_num = setting_robot.value("table_col_num").toInt();
    setting_robot.endGroup();

    setting_robot.beginGroup("SERVER");
    setting.useServerCMD = setting_robot.value("use_servercmd").toBool();
    setting.useTravelline = setting_robot.value("use_travelline").toBool();
    setting.travelline = setting_robot.value("travelline").toInt();
    setting_robot.endGroup();

    setting_robot.beginGroup("PATROL");
    patrol.filename = setting_robot.value("curfile").toString();
    patrol.mode = setting_robot.value("patrol_mode").toInt();
    setting_robot.endGroup();

    //Set Variable
    probot->trays.clear();
    for(int i=0; i<setting.tray_num; i++){
        probot->trays.push_back(0);
    }

    lcm->subscribe();
    flag_read_ini = true;
}
void Supervisor::setVelocity(float vel){
    probot->velocity = vel;
    setSetting("ROBOT/velocity",QString::number(vel));
    lcm->setVelocity(vel);
}
float Supervisor::getVelocity(){
    return probot->velocity;
}
bool Supervisor::getuseTravelline(){
    return setting.useTravelline;
}
void Supervisor::setuseTravelline(bool use){
    setSetting("SERVER/use_travelline",QVariant(use).toString());
}
int Supervisor::getnumTravelline(){
    return setting.travelline;
}
void Supervisor::setnumTravelline(int num){
    setSetting("SERVER/travelline",QString::number(num));
}
int Supervisor::getTrayNum(){
    return setting.tray_num;
}
void Supervisor::setTrayNum(int tray_num){
    setSetting("ROBOT/tray_num",QString::number(tray_num));
}
int Supervisor::getTableNum(){
    return setting.table_num;
}
void Supervisor::setTableNum(int table_num){
    setSetting("FLOOR/table_num",QString::number(table_num));
}
int Supervisor::getTableColNum(){
    return setting.table_col_num;
}
void Supervisor::setTableColNum(int col_num){
    setSetting("FLOOR/table_col_num",QString::number(col_num));
}
bool Supervisor::getuseVoice(){
    return setting.useVoice;
}
void Supervisor::setuseVoice(bool use){
    setSetting("ROBOT/use_voice",QVariant(use).toString());
}
bool Supervisor::getuseBGM(){
    return setting.useBGM;
}
void Supervisor::setuseBGM(bool use){
    setSetting("ROBOT/use_bgm",QVariant(use).toString());
}
bool Supervisor::getserverCMD(){
    return setting.useServerCMD;
}
void Supervisor::setserverCMD(bool use){
    setSetting("SERVER/use_servercmd",QVariant(use).toString());
}
void Supervisor::setRobotType(int type){
    if(type == 0){
        setSetting("ROBOT/type","SERVING");
    }else{
        setSetting("ROBOT/type","CALLING");
    }
}
QString Supervisor::getRobotType(){
    return probot->type;
}
void Supervisor::setDebugName(QString name){
    plog->write("[SETTING] SET DEBUG NAME : "+name);
    robot.name_debug = name;
    lcm->subscribe();
}
QString Supervisor::getDebugName(){
    return robot.name_debug;
}
bool Supervisor::getDebugState(){
    return is_debug;
}
void Supervisor::setDebugState(bool isdebug){
    if(isdebug)
        plog->write("[SETTING] SET DEBUG STATE : TRUE" );
    else
        plog->write("[SETTING] SET DEBUG STATE : FALSE" );
    is_debug = isdebug;
}




////*********************************************  INIT PAGE 관련   ***************************************************////
bool Supervisor::isConnectServer(){
    return server->isconnect;
}
int Supervisor::isExistMap(){
//0:no map, 1:map_server, 2: map_edited, 3:raw_map only
    QString file_rotated = QGuiApplication::applicationDirPath()+"/image/map_rotated.png";


    QString map_server = "image/map_server.png";
    QString map_rotated = "image/map_rotated.png";

    QString map_raw = "image/raw_map.png";
    QString map_raw_rotated = "image/map_raw.png";
    QString map_edited = "image/map_edited.png";

    QString file_meta = "setting/map_meta.ini";
    QString file_annot = "setting/annotation.ini";


    //map_meta.ini 파일이 없으면 기본세팅된 값으로 만든다. (필수)
    if(!QFile::exists(file_meta)){
        QString filename = "setting/map_meta.ini";
        QSettings settings(filename, QSettings::IniFormat);
        settings.clear();
        settings.setValue("map_metadata/map_w",1000);
        settings.setValue("map_metadata/map_h",1000);
        settings.setValue("map_metadata/map_grid_width",QString::number(0.03));
        settings.setValue("map_metadata/map_origin_u",500);
        settings.setValue("map_metadata/map_origin_v",500);
        qDebug() << QGuiApplication::applicationDirPath()+"/setting/map_meta.ini" << filename;
        plog->write("[SETTING] map_meta.ini not found -> make basic format");
        if(pmap->map_loaded){
            setSetting("FLOOR/map_load","false");
        }
    }

    if(QFile::exists(file_annot)){
        //서버에서 받아온 맵(회전된 버전)
        if(QFile::exists(map_rotated)){
            return 1;
        }

        //서버에서 받아온 원본 맵
        if(QFile::exists(map_server)){
            if(rotate_map(map_server,map_rotated,0)){
                return 1;
            }
        }

        //로컬에서 만들어진 맵(회전되고 수정된 버전)
        if(QFile::exists(map_edited)){
            return 2;
        }
    }else{
        if(pmap->map_loaded){
            setSetting("FLOOR/map_load","false");
        }
    }

    //로컬에서 만든 맵(매핑 로우 파일)
    if(QFile::exists(map_raw)){
        if(pmap->map_loaded)
            setSetting("FLOOR/map_load","false");
        if(!QFile::exists(map_raw_rotated)){
            rotate_map(map_raw, map_raw_rotated,0);
        }
        if(QFile::exists(file_annot)){
            if(!QFile::exists(map_edited)){
                rotate_map(map_raw, map_edited,0);
            }
            return 2;
        }
        return 3;
    }else{
        if(pmap->map_loaded)
            setSetting("FLOOR/map_load","false");
        return 0;
    }
}
bool Supervisor::loadMaptoServer(){
    if(server->isconnect){
        plog->write("[USER INPUT] load map to server : request");
        server->requestMap();
        return true;
    }else{
        plog->write("[USER INPUT - ERROR] load map to server : server not connected");
        return false;
    }
}
bool Supervisor::isUSBFile(){
    return false;
}
QString Supervisor::getUSBFilename(){
    return "";
}
bool Supervisor::loadMaptoUSB(){
    return false;
}
bool Supervisor::isuseServerMap(){
    return pmap->use_server;
}
void Supervisor::setuseServerMap(bool use){
    QString ini_path = "setting/robot.ini";
    QSettings settings(ini_path, QSettings::IniFormat);
    settings.setValue("FLOOR/map_server",use);
    if(use){
        plog->write("[SETTING] USE SERVER MAP Changed : True");
    }else{
        plog->write("[SETTING] USE SERVER MAP Changed : False");
    }
    readSetting();
}
void Supervisor::removeRawMap(){
    plog->write("[USER INPUT] Remove Map : raw_map.png, map_raw.png");
    QFile *file_1 = new QFile(QGuiApplication::applicationDirPath()+"/image/raw_map.png");
    QFile *file_2 = new QFile(QGuiApplication::applicationDirPath()+"/image/map_raw.png");
    file_1->remove();
    file_2->remove();
}
void Supervisor::removeEditedMap(){
    plog->write("[USER INPUT] Remove Map : raw_map.png, map_raw.png, map_edited.png");
    QFile *file_1 = new QFile(QGuiApplication::applicationDirPath()+"/image/raw_map.png");
    QFile *file_2 = new QFile(QGuiApplication::applicationDirPath()+"/image/map_raw.png");
    QFile *file_3 = new QFile(QGuiApplication::applicationDirPath()+"/image/map_edited.png");
    file_1->remove();
    file_2->remove();
    file_3->remove();
}
void Supervisor::removeServerMap(){
    plog->write("[USER INPUT] Remove Map : map_server.png, map_rotated.png");
    QFile *file_1= new QFile(QGuiApplication::applicationDirPath()+"/image/map_server.png");
    QFile *file_2 = new QFile(QGuiApplication::applicationDirPath()+"/image/map_rotated.png");
    file_1->remove();
    file_2->remove();
}
bool Supervisor::isloadMap(){
    return pmap->map_loaded;
}
void Supervisor::setloadMap(bool load){
    QString ini_path = "setting/robot.ini";
    QSettings settings(ini_path, QSettings::IniFormat);
    if(settings.value("FLOOR/map_load").toBool() == load){

    }else{
        settings.setValue("FLOOR/map_load",load);
        if(load){
            plog->write("[SETTING] LOAD MAP Changed : True");
        }else{
            plog->write("[SETTING] LOAD MAP Changed : False");
        }
        readSetting();
    }
}
bool Supervisor::isExistRobotINI(){
    QString file = "setting/robot.ini";
    return QFile::exists(file);
}
void Supervisor::makeRobotINI(){
    plog->write("[SETTING] Make Robot.ini basic format");
    setSetting("ROBOT/name","test1");
    setSetting("ROBOT/radius","0.25");
    setSetting("ROBOT/tray_num","3");
    setSetting("ROBOT/type","SERVING");
    setSetting("ROBOT/use_bgm","true");
    setSetting("ROBOT/use_voice","true");
    setSetting("ROBOT/velocity","1");
    setSetting("SERVER/travelline","0");
    setSetting("SERVER/use_servercmd","true");
    setSetting("SERVER/use_travelline","true");
    setSetting("FLOOR/map_load","true");
    setSetting("FLOOR/map_server","false");
    setSetting("FLOOR/margin","0.25");
    setSetting("FLOOR/table_num","5");
    setSetting("PATROL/patrol_mode","0");
    setSetting("PATROL/curfile","");
    readSetting();
}
bool Supervisor::rotate_map(QString _src, QString _dst, int mode){
    cv::Mat map1 = cv::imread(_src.toStdString());

    if(mode == 0){
        cv::flip(map1, map1, 0);
        cv::rotate(map1,map1,cv::ROTATE_90_COUNTERCLOCKWISE);
    }else{
        cv::rotate(map1,map1,cv::ROTATE_90_CLOCKWISE);
        cv::flip(map1, map1, 0);

    }

    QImage temp_image = QPixmap::fromImage(mat_to_qimage_cpy(map1)).toImage();

    //Save PNG File
    if(temp_image.save(_dst,"PNG")){
        return true;
    }else{
        return false;
    }
}
bool Supervisor::getLCMConnection(){
    return lcm->isconnect;
}
bool Supervisor::getLCMRX(){
    return lcm->flag_rx;
}
bool Supervisor::getLCMTX(){
    return lcm->flag_tx;
}
bool Supervisor::getLCMProcess(){
    return false;
}
bool Supervisor::getIniRead(){
    return flag_read_ini;
}
int Supervisor::getUsbMapSize(){
    return usb_map_list.size();
}
QString Supervisor::getUsbMapPath(int num){
    QStringList templist = usb_map_list[num].split("/");
    QString temp = templist[templist.size() - 2] + "/" + templist[templist.size()-1];
    return temp;
}
QString Supervisor::getUsbMapPathFull(int num){
    return usb_map_list[num];
}
void Supervisor::saveMapfromUsb(QString path){
    std::string user = getenv("USER");
    std::string path1 = "/media/" + user + "/";

    QString orin_path = path1.c_str() + path;
    QStringList kk = path.split('/');
    QString new_path = QCoreApplication::applicationDirPath() + "/image/" + kk[kk.length()-1];
    if(QFile::exists(orin_path)){
        if(QFile::copy(orin_path, new_path)){
            plog->write("[SETTING] Save Map from USB : "+kk[kk.length()-1]);
        }else{
            plog->write("[SETTING - ERROR] Save Map from USB (Copy failed): "+kk[kk.length()-1]);
        }
    }else{
        plog->write("[SETTING - ERROR] Save Map from USB (Origin not found): "+kk[kk.length()-1]);
    }
}





////*******************************************  SLAM(LOCALIZATION) 관련   ************************************************////
void Supervisor::startMapping(){
    plog->write("[USER INPUT] START MAPPING");
    lcm->sendCommand(ROBOT_CMD_MAPPING_START, "MAPPING START");
}
void Supervisor::stopMapping(){
    plog->write("[USER INPUT] STOP MAPPING");
    lcm->sendCommand(ROBOT_CMD_MAPPING_STOP, "MAPPING STOP");

}
void Supervisor::setSLAMMode(int mode){

}
void Supervisor::setInitPos(int x, int y, float th){
    ST_FPOINT temp = canvasTomap(x,y);
    pmap->init_pose.x = temp.x;
    pmap->init_pose.y = temp.y;
    pmap->init_pose.th = th;
    plog->write("[LOCALIZATION] SET INIT POSE : "+QString().sprintf("%f, %f, %f",temp.x, temp.y, th));
}
float Supervisor::getInitPoseX(){
    ST_POSE temp = setAxis(pmap->init_pose);
    return temp.x;
}
float Supervisor::getInitPoseY(){
    ST_POSE temp = setAxis(pmap->init_pose);
    return temp.y;
}
float Supervisor::getInitPoseTH(){
    ST_POSE temp = setAxis(pmap->init_pose);
    return temp.th;
}
void Supervisor::slam_setInit(){
    plog->write("[SLAM] SLAM SET INIT : "+QString().sprintf("%f, %f, %f",pmap->init_pose.x,pmap->init_pose.y,pmap->init_pose.th));
    lcm->setInitPose(pmap->init_pose.x, pmap->init_pose.y, pmap->init_pose.th);
}
void Supervisor::slam_run(){
    lcm->sendCommand(ROBOT_CMD_SLAM_RUN, "LOCALIZATION RUN");
}
void Supervisor::slam_stop(){
    lcm->sendCommand(ROBOT_CMD_SLAM_STOP, "LOCALIZATION STOP");
}
void Supervisor::slam_autoInit(){
    lcm->sendCommand(ROBOT_CMD_SLAM_AUTO, "LOCALIZATION AUTO INIT");
}
bool Supervisor::is_slam_running(){
    if(probot->state == ROBOT_STATE_NOT_READY){
        return false;
    }else{
        return true;
    }
}

bool Supervisor::getMappingflag(){
    return true;
    return lcm->flagMapping;
}

void Supervisor::setMappingflag(bool flag){
    lcm->flagMapping = flag;
}

QList<int> Supervisor::getMapping(){
    return pmap->data.toList();
}
void Supervisor::pushMapData(QList<int> data){
    pmap->data.clear();
    for(int i=0; i<data.size(); i++){
        pmap->data.push_back(data[i]);
    }
}

////*********************************************  JOYSTICK 관련   ***************************************************////
bool Supervisor::isconnectJoy(){
    return joystick->connection;
}
float Supervisor::getJoyAxis(int num){
    return joystick->JoyAxis[num];
}
int Supervisor::getJoyButton(int num){
    return joystick->JoyButton[num];
}
QString Supervisor::getKeyboard(int mode){
    return "";
}
QString Supervisor::getJoystick(int mode){
    return "";
}
void Supervisor::usb_detect(){
    plog->write("[USB] NEW USB Detected");
    usb_check = true;
    usb_check_count = 0;
}






////*********************************************  ANNOTATION 관련   ***************************************************////
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
    plog->write("[ANNOTATION] START LINE : color("+color+") width("+QString::number(width)+")");
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
        plog->write("[ANNOTATION] UNDO [canvas size = "+QString::number(canvas.size())+ "] redo size = " + QString::number(canvas_redo.size()));
    }
}
void Supervisor::redo(){
    if(canvas_redo.size() > 0){
        if(flag_clear){
            flag_clear = false;
            if(canvas.size() > 0){

            }else{
                canvas = canvas_redo;
                canvas_redo.clear();
            }
        }else{
            canvas.push_back(canvas_redo.back());
            canvas_redo.pop_back();
        }
        plog->write("[ANNOTATION] REDO [canvas size = "+QString::number(canvas.size())+ "] redo size = " + QString::number(canvas_redo.size()));
    }
}
void Supervisor::clear_all(){
    if(canvas.size() > 0 || canvas_redo.size() > 0 || temp_object.size() > 0){
        plog->write("[ANNOTATION] CLEAR [canvas size = "+QString::number(canvas.size())+ "] redo size = " + QString::number(canvas_redo.size()));
    }
    canvas_redo.clear();
    for(int i=0; i<canvas.size(); i++){
        canvas_redo.push_back(canvas[i]);
        flag_clear = true;
    }
    temp_object.clear();
    canvas.clear();
}
void Supervisor::setObjPose(){
    list_obj_dR.clear();
    list_obj_uL.clear();
    for(int i=0; i<pmap->vecObject.size(); i++){
        ST_FPOINT temp_uL;
        ST_FPOINT temp_dR;
        //Find Square Pos
        temp_uL.x = pmap->vecObject[i].pose[0].x;
        temp_uL.y = pmap->vecObject[i].pose[0].y;
        temp_dR.x = pmap->vecObject[i].pose[0].x;
        temp_dR.y = pmap->vecObject[i].pose[0].y;
        for(int j=1; j<pmap->vecObject[i].pose.size(); j++){
            if(temp_uL.x > pmap->vecObject[i].pose[j].x){
                temp_uL.x = pmap->vecObject[i].pose[j].x;
            }
            if(temp_uL.y > pmap->vecObject[i].pose[j].y){
                temp_uL.y = pmap->vecObject[i].pose[j].y;
            }
            if(temp_dR.x < pmap->vecObject[i].pose[j].x){
                temp_dR.x = pmap->vecObject[i].pose[j].x;
            }
            if(temp_dR.y < pmap->vecObject[i].pose[j].y){
                temp_dR.y = pmap->vecObject[i].pose[j].y;
            }
        }
        list_obj_dR.push_back(temp_uL);
        list_obj_uL.push_back(temp_dR);
    }
}
void Supervisor::setMarginObj(){
    for(int i=0; i<list_obj_dR.size(); i++){
        ST_POINT pixel_uL = mapTocanvas(list_obj_uL[i].x,list_obj_uL[i].y);
        ST_POINT pixel_bR = mapTocanvas(list_obj_dR[i].x,list_obj_dR[i].y);
        for(int x=pixel_uL.x; x<pixel_bR.x; x++){
            for(int y=pixel_uL.y; y<pixel_bR.y; y++){
                list_margin_obj.push_back(x + y*pmap->width);
            }
        }
    }
    plog->write("[QML] SET MARGIN OBJECT DONE");
}
void Supervisor::clearMarginObj(){
    list_margin_obj.clear();
}
void Supervisor::setMarginPoint(int pixel_num){
    list_margin_obj.push_back(pixel_num);
}
QVector<int> Supervisor::getMarginObj(){
    return list_margin_obj;
}
float Supervisor::getMargin(){
    return pmap->margin;
}
int Supervisor::getLocationNum(){
    return pmap->vecLocation.size();
}
int Supervisor::getLocationSize(QString type){
    int count = -1;
    for(int i=0; i<pmap->vecLocation.size(); i++){
        if(pmap->vecLocation[i].type == type){
            QStringList namelist = pmap->vecLocation[i].name.split("_");
            if(namelist[0] == type && namelist.size() >1){
                if(namelist[1].toInt() > count){
                    count = namelist[1].toInt();
                }
            }
        }
    }
    return count + 1;
}
QString Supervisor::getLocationName(int num){
    if(num > -1 && num < pmap->vecLocation.size()){
        return pmap->vecLocation[num].name;
    }
    return "";
}
QString Supervisor::getLocationTypes(int num){
    if(num > -1 && num < pmap->vecLocation.size()){
        return pmap->vecLocation[num].type;
    }
    return "";
}
float Supervisor::getLocationx(int num){
    if(num > -1 && num < pmap->vecLocation.size()){
        ST_POSE temp = setAxis(pmap->vecLocation[num].pose);
        return temp.x;
    }
    return 0.;
}
float Supervisor::getLocationy(int num){
    if(num > -1 && num < pmap->vecLocation.size()){
        ST_POSE temp = setAxis(pmap->vecLocation[num].pose);
        return temp.y;
    }
    return 0.;
}
float Supervisor::getLocationth(int num){
    if(num > -1 && num < pmap->vecLocation.size()){
        ST_POSE temp = setAxis(pmap->vecLocation[num].pose);
        return temp.th;
    }
    return 0.;
}
float Supervisor::getLidar(int num){
    return probot->lidar_data[num];
}

ST_POSE Supervisor::setAxis(ST_POSE _pose){
    ST_POSE temp;
    temp.x = -_pose.y;
    temp.y = -_pose.x;
    temp.th = _pose.th;
    return temp;
}
ST_FPOINT Supervisor::setAxis(ST_FPOINT _point){
    ST_FPOINT temp;
    temp.x = -_point.y;
    temp.y = -_point.x;
    return temp;
}
ST_FPOINT Supervisor::canvasTomap(int x, int y){
    ST_FPOINT temp;
    temp.x = -pmap->gridwidth*(y-pmap->origin[1]);
    temp.y = -pmap->gridwidth*(x-pmap->origin[0]);
    return temp;
}
ST_POINT Supervisor::mapTocanvas(float x, float y){
    ST_POINT temp;
    temp.x = -y/pmap->gridwidth + pmap->origin[1];
    temp.y = -x/pmap->gridwidth + pmap->origin[0];
    return temp;
}

int Supervisor::getObjectNum(){
    return pmap->vecObject.size();
}
QString Supervisor::getObjectName(int num){
    int count = 0;
    if(num > -1 && num < pmap->vecObject.size()){
        for(int i=0; i<num; i++){
            if(pmap->vecObject[i].type == pmap->vecObject[num].type){
                count++;
            }
        }
        return pmap->vecObject[num].type + "_" + QString::number(count);
    }
}
int Supervisor::getObjectPointSize(int num){
    return pmap->vecObject[num].pose.size();
}
float Supervisor::getObjectX(int num, int point){
    if(num > -1 && num < pmap->vecObject.size()){
        if(point > -1 && point < pmap->vecObject[num].pose.size()){
            ST_FPOINT temp = setAxis(pmap->vecObject[num].pose[point]);
            return temp.x;
        }
    }
    return 0;
}
float Supervisor::getObjectY(int num, int point){
    if(num > -1 && num < pmap->vecObject.size()){
        if(point > -1 && point < pmap->vecObject[num].pose.size()){
            ST_FPOINT temp = setAxis(pmap->vecObject[num].pose[point]);
            return temp.y;
        }
    }
    return 0;
}

int Supervisor::getTempObjectSize(){
    return temp_object.size();
}
float Supervisor::getTempObjectX(int num){
    ST_FPOINT temp = setAxis(temp_object[num]);
    return temp.x;
}
float Supervisor::getTempObjectY(int num){
    ST_FPOINT temp = setAxis(temp_object[num]);
    return temp.y;
}

int Supervisor::getObjNum(QString name){
    QStringList namelist = name.split("_");
    int num = namelist[1].toInt();
    int count = 0;
    for(int i=0; i<pmap->vecObject.size(); i++){
        if(pmap->vecObject[i].type == namelist[0]){
            if(num == count){
                return i;
            }else{
                count++;
            }
        }
    }
    return -1;
}
int Supervisor::getObjNum(int x, int y){
    for(int i=0; i<list_obj_uL.size(); i++){
        ST_FPOINT pos = canvasTomap(x,y);
        if(pos.x<list_obj_uL[i].x && pos.x>list_obj_dR[i].x){
            if(pos.y<list_obj_uL[i].y && pos.y>list_obj_dR[i].y){
                return i;
            }
        }
    }
    return -1;
}
int Supervisor::getObjPointNum(int obj_num, int x, int y){
    ST_FPOINT pos = canvasTomap(x,y);
    if(obj_num < pmap->vecObject.size() && obj_num > -1){
        qDebug() << "check obj" << obj_num << pmap->vecObject[obj_num].pose.size();
        if(obj_num != -1){
            for(int j=0; j<pmap->vecObject[obj_num].pose.size(); j++){
                qDebug() << pmap->vecObject[obj_num].pose[j].x << pmap->vecObject[obj_num].pose[j].y;
                if(fabs(pmap->vecObject[obj_num].pose[j].x - pos.x) < 0.1){
                    if(fabs(pmap->vecObject[obj_num].pose[j].y - pos.y) < 0.1){
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

int Supervisor::getLocNum(QString name){
    for(int i=0; i<pmap->vecLocation.size(); i++){
        if(pmap->vecLocation[i].name == name){
            return i;
        }
    }
    return -1;
}
int Supervisor::getLocNum(int x, int y){
    for(int i=0; i<pmap->vecLocation.size(); i++){
        ST_FPOINT pos = canvasTomap(x,y);
        if(fabs(pmap->vecLocation[i].pose.x - pos.x) < probot->radius){
            if(fabs(pmap->vecLocation[i].pose.y - pos.y) < probot->radius){
                return i;
            }
        }
    }
    return -1;
}


void Supervisor::removeLocation(QString name){
    for(int i=0; i<pmap->vecLocation.size(); i++){
        if(pmap->vecLocation[i].name == name){
            plog->write("[UI-MAP] REMOVE LOCATION "+ name);
            pmap->vecLocation.remove(i);
            QMetaObject::invokeMethod(mMain, "updatelocation");
            return;
        }
    }
    plog->write("[UI-MAP] REMOVE OBJECT BUT FAILED "+ name);
}
void Supervisor::addLocation(QString type, QString name, int x, int y, float th){
    ST_LOCATION temp_loc;
    temp_loc.type = type;
    temp_loc.name = name;
    ST_POSE temp_pose;
    ST_FPOINT temp = canvasTomap(x,y);
    temp_pose.x = temp.x;
    temp_pose.y = temp.y;
    temp_pose.th = th;
    temp_loc.pose = temp_pose;
    pmap->vecLocation.push_back(temp_loc);
    QMetaObject::invokeMethod(mMain, "updatecanvas");
    QMetaObject::invokeMethod(mMain, "updatelocation");

    plog->write("[DEBUG] addLocation "+ name);
}
void Supervisor::moveLocationPoint(int loc_num, int x, int y, float th){
    if(loc_num > -1 && loc_num < pmap->vecLocation.size()){
        ST_FPOINT temp = canvasTomap(x,y);
        pmap->vecLocation[loc_num].pose.x = temp.x;
        pmap->vecLocation[loc_num].pose.y = temp.y;
        pmap->vecLocation[loc_num].pose.th = th;
        qDebug() << loc_num << x << y << th;
        plog->write("[DEBUG] moveLocation "+QString().sprintf("%d -> %f, %f, %f",loc_num , temp.x ,temp.y , th));
    }
}

void Supervisor::addObjectPoint(int x, int y){
    ST_FPOINT temp = canvasTomap(x,y);
    plog->write("[ANNOTATION] addObjectPoint " + QString().sprintf("[%d] %f, %f",temp_object.size(),temp.x,temp.y));
    temp_object.push_back(temp);

    QMetaObject::invokeMethod(mMain, "updatecanvas");
}
void Supervisor::removeObjectPoint(int num){
    if(num < temp_object.size()){
        temp_object.remove(num);
        QMetaObject::invokeMethod(mMain, "updatecanvas");
    }else{
        plog->write("[ANNOTATION] removeObjectPoint " + QString().sprintf("%d, %d",num,temp_object.size()));
    }
}
void Supervisor::removeObjectPointLast(){
    if(temp_object.size() > 0){
        temp_object.pop_back();
        plog->write("[ANNOTATION] Remove Object Point Last");
        QMetaObject::invokeMethod(mMain, "updatecanvas");
    }
}
void Supervisor::clearObjectPoints(){
    temp_object.clear();
    plog->write("[ANNOTATION] Clear Object Point");
    QMetaObject::invokeMethod(mMain, "updatecanvas");
}
int Supervisor::getObjectSize(QString type){
    int size = 0;
    for(int i=0; i<pmap->vecObject.size(); i++){
        if(pmap->vecObject[i].type == type)
            size++;
    }
    return size;
}
void Supervisor::addObject(QString type){
    QString num;
    if(temp_object.size() > 0){
        ST_OBJECT temp;
        temp.pose = temp_object;
        temp.is_rect = false;
        temp.type = type;
        pmap->vecObject.push_back(temp);
        temp_object.clear();
        setObjPose();
        QMetaObject::invokeMethod(mMain, "updatecanvas");
        QMetaObject::invokeMethod(mMain, "updateobject");
        plog->write("[DEBUG] addObject " + type);
    }else{
        plog->write("[DEBUG] addObject " + type + " but size = 0");
    }
}
void Supervisor::addObjectRect(QString type){
    QString num;
    if(temp_object.size() > 4){
        plog->write("[DEBUG] addObjectRect " + type + " but size > 4");
    }else if(temp_object.size() > 0){
        ST_OBJECT temp;
        temp.pose = temp_object;
        temp.is_rect = true;
        temp.type = type;
        pmap->vecObject.push_back(temp);
        temp_object.clear();
        setObjPose();
        QMetaObject::invokeMethod(mMain, "updatecanvas");
        QMetaObject::invokeMethod(mMain, "updateobject");
        plog->write("[DEBUG] addObjectRect " + type);
    }else{
        plog->write("[DEBUG] addObjectRect " + type + " but size = 0");
    }
}

void Supervisor::editObject(int num, int point, int x, int y){
    if(num > -1 && num < pmap->vecObject.size()){
        if(pmap->vecObject[num].is_rect){
            if(point == 0){
                ST_FPOINT pos = canvasTomap(x,y);
                pmap->vecObject[num].pose[0].x = pos.x;
                pmap->vecObject[num].pose[0].y = pos.y;
                pmap->vecObject[num].pose[1].y = pos.y;
                pmap->vecObject[num].pose[3].x = pos.x;
                QMetaObject::invokeMethod(mMain, "updatecanvas");
            }else if(point == 1){
                ST_FPOINT pos = canvasTomap(x,y);
                pmap->vecObject[num].pose[1].x = pos.x;
                pmap->vecObject[num].pose[1].y = pos.y;
                pmap->vecObject[num].pose[0].y = pos.y;
                pmap->vecObject[num].pose[2].x = pos.x;
                QMetaObject::invokeMethod(mMain, "updatecanvas");
            }else if(point == 2){
                ST_FPOINT pos = canvasTomap(x,y);
                pmap->vecObject[num].pose[2].x = pos.x;
                pmap->vecObject[num].pose[2].y = pos.y;
                pmap->vecObject[num].pose[3].y = pos.y;
                pmap->vecObject[num].pose[1].x = pos.x;
                QMetaObject::invokeMethod(mMain, "updatecanvas");
            }else if(point == 3){
                ST_FPOINT pos = canvasTomap(x,y);
                pmap->vecObject[num].pose[3].x = pos.x;
                pmap->vecObject[num].pose[3].y = pos.y;
                pmap->vecObject[num].pose[2].y = pos.y;
                pmap->vecObject[num].pose[0].x = pos.x;
                QMetaObject::invokeMethod(mMain, "updatecanvas");
            }
            plog->write("[ANNOTATION] editObject " + QString().sprintf("(%d, %d, %d, %d)",num,point,x,y));
        }else{
            if(point > -1 && point < pmap->vecObject[num].pose.size()){
                ST_FPOINT pos = canvasTomap(x,y);
                pmap->vecObject[num].pose[point].x = pos.x;
                pmap->vecObject[num].pose[point].y = pos.y;
                plog->write("[ANNOTATION] editObject "+ QString().sprintf("(%d, %d, %d, %d)",num,point,x,y));
                QMetaObject::invokeMethod(mMain, "updatecanvas");
            }else{
                plog->write("[ANNOTATION - ERROR] editObject " + QString().sprintf("(%d, %d, %d, %d)",num,point,x,y) + " but pose size error");
            }
        }
    }else{
        plog->write("[ANNOTATION - ERROR] editObject " + QString().sprintf("(%d, %d, %d, %d)",num,point,x,y) + " but size error");
    }
}

void Supervisor::removeObject(int num){
    if(num > -1 && num < pmap->vecObject.size()){
        pmap->vecObject.remove(num);
        setObjPose();
        QMetaObject::invokeMethod(mMain, "updateobject");
        plog->write("[ANNOTATION - ERROR] removeObject " + QString().sprintf("(%d)",num));
    }else{
        plog->write("[ANNOTATION - ERROR] removeObject " + QString().sprintf("(%d)",num) + " but size error");
    }
}

int Supervisor::getTlineSize(){
    return pmap->vecTline.size();
}
int Supervisor::getTlineSize(int num){
    if(num > -1 && num < pmap->vecTline.size()){
        return pmap->vecTline[num].size();
    }else{
        return 0;
    }
}
QString Supervisor::getTlineName(int num){
    if(num > -1 && num < pmap->vecTline.size()){
        return "Travel_line_"+QString::number(num);
    }else{
        return "";
    }
}
float Supervisor::getTlineX(int num, int point){
    if(num > -1 && num < pmap->vecTline.size()){
        ST_FPOINT temp = setAxis(pmap->vecTline[num][point]);
        return temp.x;
    }else{
        return 0;
    }
}
float Supervisor::getTlineY(int num, int point){
    if(num > -1 && num < pmap->vecTline.size()){
        ST_FPOINT temp = setAxis(pmap->vecTline[num][point]);
        return temp.y;
    }else{
        return 0;
    }
}

void Supervisor::addTline(int num, int x1, int y1, int x2, int y2){
    if(num < pmap->vecTline.size() && num > -1){
        pmap->vecTline[num].push_back(canvasTomap(x1,y1));
        pmap->vecTline[num].push_back(canvasTomap(x2,y2));

    }else{
        QVector<ST_FPOINT> temp;
        temp.push_back(canvasTomap(x1,y1));
        temp.push_back(canvasTomap(x2,y2));
        pmap->vecTline.push_back(temp);

    }
    plog->write("[ANNOTATION] ADD Travel Line "+ QString().sprintf("%d : point1(%d, %d), point2(%d, %d)",num,x1,y1,x2,y2));
    QMetaObject::invokeMethod(mMain,"updatetravelline");
}
void Supervisor::removeTline(int num, int line){
    if(num > -1 && num < pmap->vecTline.size()){
        if(line > -1 && line*2+1 < pmap->vecTline[num].size()){
            pmap->vecTline[num].remove(line*2);
            pmap->vecTline[num].remove(line*2);
            if(pmap->vecTline[num].size() < 1){
                pmap->vecTline.remove(num);
                plog->write("[ANNOTATION] REMOVE Travel Line "+ QString().sprintf("%d : line(%d)",num,line));
                QMetaObject::invokeMethod(mMain,"updatetravelline2");
            }else{
                QMetaObject::invokeMethod(mMain,"updatetravelline");
            }
        }
    }
}
int Supervisor::getTlineNum(int x, int y){
    ST_FPOINT temp = canvasTomap(x,y);
    ST_FPOINT uL;
    ST_FPOINT dR;
    if(pmap->vecTline.size() > 0){
        for(int i=0; i<pmap->vecTline[0].size(); i=i+2){
            uL.x = pmap->vecTline[0][i].x;
            uL.y = pmap->vecTline[0][i].y;
            dR.x = pmap->vecTline[0][i].x;
            dR.y = pmap->vecTline[0][i].y;


            if(uL.x < pmap->vecTline[0][i+1].x)
                uL.x = pmap->vecTline[0][i+1].x;
            if(dR.x > pmap->vecTline[0][i+1].x)
                dR.x = pmap->vecTline[0][i+1].x;

            if(uL.y < pmap->vecTline[0][i+1].y)
                uL.y = pmap->vecTline[0][i+1].y;
            if(dR.y > pmap->vecTline[0][i+1].y)
                dR.y = pmap->vecTline[0][i+1].y;

            float margin = 0.3;

            if(temp.x < uL.x+margin && temp.x > dR.x-margin){
                if(temp.y < uL.y+margin && temp.y > dR.y-margin){
                    //match box

                    float ang_line = atan2(uL.y-dR.y,uL.x-dR.x);
    //                qDebug() << i << atan2(uL.y-dR.y,uL.x-dR.x) << fabs(ang_line - atan2(uL.y-temp.y, uL.x-temp.x)) ;
                    if(fabs(ang_line - atan2(uL.y-temp.y, uL.x-temp.x)) < 0.5){
                        return i;
                    }

                }
            }
        }
    }

    return -1;
}


bool Supervisor::saveMetaData(QString filename){
    //파일 유무 확인
    QStringList filenamelist = filename.split("/");
    if(filenamelist[filenamelist.size()-1].split(".").size() <2){
        filename = "setting/"+filenamelist[filenamelist.size()-1]+".ini";
    }else{
        filename = "setting/"+filenamelist[filenamelist.size()-1];
    }

    //기존 파일 백업
    QString backup = QGuiApplication::applicationDirPath()+"/setting/map_meta_backup.ini";
    QString origin = QGuiApplication::applicationDirPath()+"/setting/map_meta.ini";
    QFile *file = new QFile(backup);
    file->remove();
    if(QFile::exists(origin) == true){
        if(QFile::copy(origin, backup)){
            plog->write("[DEBUG] Copy map_meta.ini to map_meta_backup.ini");
        }else{
            plog->write("[DEBUG] Fail to copy map_meta.ini to map_meta_backup.ini");
            return false;
        }
    }else{
        plog->write("[DEBUG] Fail to copy map_meta.ini to map_meta_backup.ini (No file found)");
        return false;
    }

    //데이터 입력(맵데이터)
    QSettings settings(filename, QSettings::IniFormat);
    settings.clear();
    settings.setValue("map_metadata/map_w",pmap->width);
    settings.setValue("map_metadata/map_h",pmap->height);
    settings.setValue("map_metadata/map_grid_width",QString::number(pmap->gridwidth));
    settings.setValue("map_metadata/map_origin_u",pmap->origin[0]);
    settings.setValue("map_metadata/map_origin_v",pmap->origin[1]);
    return true;

}
bool Supervisor::saveAnnotation(QString filename){
    //파일 유무 확인
    QStringList filenamelist = filename.split("/");
    if(filenamelist[filenamelist.size()-1].split(".").size() <2){
        filename = "setting/"+filenamelist[filenamelist.size()-1]+".ini";
    }else{
        filename = "setting/"+filenamelist[filenamelist.size()-1];
    }

    //기존 파일 백업
    QString backup = QGuiApplication::applicationDirPath()+"/setting/annotation_backup.ini";
    QString origin = QGuiApplication::applicationDirPath()+"/setting/annotation.ini";
    QFile *file = new QFile(backup);
    file->remove();
    if(QFile::exists(origin) == true){
        if(QFile::copy(origin, backup)){
            plog->write("[DEBUG] Copy annotation.ini to annotation_backup.ini");
        }else{
            plog->write("[DEBUG] Fail to copy annotation.ini to annotation_backup.ini");
        }
    }else{
        plog->write("[DEBUG] Fail to copy annotation.ini to annotation_backup.ini (No file found)");
    }

    //데이터 입력(로케이션)
    int other_num = 0;
    int resting_num = 0;
    int charging_num = 0;
    int serving_num = 0;
    QString str_name;
    QSettings settings(filename, QSettings::IniFormat);
    settings.clear();
    for(int i=0; i<pmap->vecLocation.size(); i++){
        if(pmap->vecLocation[i].type == "Resting"){
            str_name = pmap->vecLocation[i].name + QString().sprintf(",%f,%f,%f",pmap->vecLocation[i].pose.x,pmap->vecLocation[i].pose.y,pmap->vecLocation[i].pose.th);
            settings.setValue("resting_locations/loc"+QString::number(resting_num),str_name);
            resting_num++;
        }else if(pmap->vecLocation[i].type == "Other"){
            str_name = pmap->vecLocation[i].name + QString().sprintf(",%f,%f,%f",pmap->vecLocation[i].pose.x,pmap->vecLocation[i].pose.y,pmap->vecLocation[i].pose.th);
            settings.setValue("other_locations/loc"+QString::number(other_num),str_name);
            other_num++;
        }else if(pmap->vecLocation[i].type == "Serving"){
            str_name = pmap->vecLocation[i].name + QString().sprintf(",%f,%f,%f",pmap->vecLocation[i].pose.x,pmap->vecLocation[i].pose.y,pmap->vecLocation[i].pose.th);
            settings.setValue("serving_locations/loc"+QString::number(serving_num),str_name);
            serving_num++;
        }else if(pmap->vecLocation[i].type == "Charging"){
            str_name = pmap->vecLocation[i].name + QString().sprintf(",%f,%f,%f",pmap->vecLocation[i].pose.x,pmap->vecLocation[i].pose.y,pmap->vecLocation[i].pose.th);
            settings.setValue("charging_locations/loc"+QString::number(charging_num),str_name);
            charging_num++;
        }
    }
    settings.setValue("resting_locations/num",resting_num);
    settings.setValue("serving_locations/num",serving_num);
    settings.setValue("other_locations/num",other_num);
    settings.setValue("charging_locations/num",charging_num);

    //데이터 입력(오브젝트)
    int table_num = 0;
    int chair_num = 0;
    int wall_num = 0;
    for(int i=0; i<pmap->vecObject.size(); i++){
        if(pmap->vecObject[i].type == "Table"){
            str_name = pmap->vecObject[i].type + "_" + QString::number(table_num++);
        }else if(pmap->vecObject[i].type == "Chair"){
            str_name = pmap->vecObject[i].type + "_" + QString::number(chair_num++);
        }else if(pmap->vecObject[i].type == "Wall"){
            str_name = pmap->vecObject[i].type + "_" + QString::number(wall_num++);
        }else{
            str_name = pmap->vecObject[i].type;
        }

        if(pmap->vecObject[i].is_rect){
            str_name += ",1";
        }else{
            str_name += ",0";
        }

        for(int j=0; j<pmap->vecObject[i].pose.size(); j++){
            str_name += QString().sprintf(",%f:%f",pmap->vecObject[i].pose[j].x, pmap->vecObject[i].pose[j].y);
        }
        settings.setValue("objects/poly"+QString::number(i),str_name);
    }
    settings.setValue("objects/num",pmap->vecObject.size());

    //데이터 입력(트래블라인)
    for(int i=0; i<pmap->vecTline.size(); i++){
        str_name = "Travel_line_"+QString::number(i);
        for(int j=0; j<pmap->vecTline[i].size(); j++){
            str_name += QString().sprintf(",%f:%f",pmap->vecTline[i][j].x, pmap->vecTline[i][j].y);
        }
        settings.setValue("travel_lines/line"+QString::number(i),str_name);
    }
    settings.setValue("travel_lines/num",pmap->vecTline.size());

    readSetting();
    return true;
}
void Supervisor::sendMaptoServer(){
    if(rotate_map("image/map_edited.png","image/map_raw.png",1)){
        server->sendMap(QGuiApplication::applicationDirPath()+"/image/map_raw.png",QGuiApplication::applicationDirPath()+"/setting/");
    }
}



////*********************************************  SCHEDULER(CALLING) 관련   ***************************************************////
void Supervisor::acceptCall(bool yes){

}



////*********************************************  SCHEDULER(SERVING) 관련   ***************************************************////
void Supervisor::setTray(int tray_num, int table_num){
    if(tray_num > -1 && tray_num < setting.tray_num){
        probot->trays[tray_num] = table_num;
        plog->write("[USER INPUT] SERVING START : tray("+QString::number(tray_num)+") = table "+QString::number(table_num));
    }
    ui_cmd = UI_CMD_MOVE_TABLE;
}
void Supervisor::confirmPickup(){
    ui_cmd = UI_CMD_PICKUP_CONFIRM;
}
QVector<int> Supervisor::getPickuptrays(){
    return probot->pickupTrays;
}





////*********************************************  ROBOT MOVE 관련   ***************************************************////
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
void Supervisor::moveStop(){
    lcm->moveStop();
    ui_cmd = UI_CMD_NONE;
    ui_state = UI_STATE_NONE;
    isaccepted = false;
    QMetaObject::invokeMethod(mMain, "movestopped");
}
void Supervisor::moveManual(){
    lcm->moveManual();
}
void Supervisor::moveToCharge(){
    ui_cmd = UI_CMD_MOVE_CHARGE;
}
void Supervisor::moveToWait(){
    ui_cmd = UI_CMD_MOVE_WAIT;
}
QString Supervisor::getcurLoc(){
    return probot->curLocation;
}
QString Supervisor::getcurTable(){
    if(probot->curLocation.left(7) == "Serving"){
        int table = probot->curLocation.split("_")[1].toInt() + 1;
        qDebug() << probot->curLocation << table;
        return QString::number(table);
    }
    return "0";
}
QVector<float> Supervisor::getcurTarget(){
    QVector<float> temp;
    temp.push_back(probot->curTarget.x);
    temp.push_back(probot->curTarget.y);
    temp.push_back(probot->curTarget.th);
    return temp;
}
void Supervisor::joyMoveXY(float x){

    probot->joystick[0] = x;
    lcm->flagJoystick = true;
}
void Supervisor::joyMoveR(float r){
    probot->joystick[1] = r;
    lcm->flagJoystick = true;
}
float Supervisor::getJoyXY(){
    return probot->joystick[0];
}
float Supervisor::getJoyR(){
    return probot->joystick[1];
}




////*********************************************  ROBOT STATUS 관련   ***************************************************////
float Supervisor::getBattery(){
    return probot->battery;
}
int Supervisor::getState(){
    return probot->state;
}
int Supervisor::getErrcode(){
    return probot->err_code;
}
QString Supervisor::getRobotName(){
    if(is_debug){
        return robot.name + "_" + robot.name_debug;
    }else{
        return robot.name;
    }
}
void Supervisor::setRobotName(QString name){
    robot.name = name;
    lcm->subscribe();
    setSetting("ROBOT/name",robot.name);
}

float Supervisor::getRobotRadius(){
    return probot->radius;
}
float Supervisor::getRobotx(){
    ST_POSE temp = setAxis(probot->curPose);
    return temp.x;
}
float Supervisor::getRoboty(){
    ST_POSE temp = setAxis(probot->curPose);
    return temp.y;
}
float Supervisor::getRobotth(){
    ST_POSE temp = setAxis(probot->curPose);
    return temp.th;
}
int Supervisor::getRobotState(){
    return probot->state;
}

int Supervisor::getPathNum(){
    if(lcm->flagPath){
        return 0;
    }else{
        return probot->pathSize;
    }
}
float Supervisor::getPathx(int num){
    if(lcm->flagPath){
        return 0;
    }else{
        ST_POSE temp = setAxis(probot->curPath[num]);
        return temp.x;
    }
}
float Supervisor::getPathy(int num){
    if(lcm->flagPath){
        return 0;
    }else{
        ST_POSE temp = setAxis(probot->curPath[num]);
        return temp.y;
    }
}
float Supervisor::getPathth(int num){
    if(lcm->flagPath){
        return 0;
    }else{
        ST_POSE temp = setAxis(probot->curPath[num]);
        return temp.th;
    }
}
int Supervisor::getLocalPathNum(){
    return probot->localpathSize;

}
float Supervisor::getLocalPathx(int num){
    ST_POSE temp = setAxis(probot->localPath[num]);
    return temp.x;

}
float Supervisor::getLocalPathy(int num){
    ST_POSE temp = setAxis(probot->localPath[num]);
    return temp.y;
}

int Supervisor::getuistate(){
    return ui_state;
}





////*********************************************  MAP IMAGE 관련   ***************************************************////
QString Supervisor::getMapname(){
    return pmap->map_name;
}
QString Supervisor::getMappath(){
    return "file://" + QGuiApplication::applicationDirPath() + "/image/" + pmap->map_name + ".png";
}
int Supervisor::getMapWidth(){
    return pmap->width;
}
int Supervisor::getMapHeight(){
    return pmap->height;
}
float Supervisor::getGridWidth(){
    return pmap->gridwidth;
}
QVector<int> Supervisor::getOrigin(){
    QVector<int> temp;
    temp.push_back(pmap->origin[0]);
    temp.push_back(pmap->origin[1]);
    return temp;
}

void Supervisor::setGrid(int x, int y, QString name){
    if(minimap_grid.size() > x){
        if(minimap_grid[x].size() > y){
            minimap_grid[x][y] = name;
        }else{
            minimap_grid[x].push_back(name);
        }
    }else{
        QVector<QString> temp;
        temp.push_back(name);
        minimap_grid.push_back(temp);
    }
}
void Supervisor::editGrid(int x, int y, QString name){
    if(minimap_grid.size() > x){
        if(minimap_grid[x].size() > y){
            minimap_grid[x][y] = name;
        }
    }
}
QString Supervisor::getGrid(int x, int y){
    if(minimap_grid.size() > x){
        if(minimap_grid[x].size() > y){

            return minimap_grid[x][y];
        }
    }
}

void Supervisor::make_minimap(){
    QString map_path;
    if(pmap->use_server){
        map_path = "image/map_rotated.png";
    }else{
        map_path = "image/map_edited.png";
    }

    plog->write("[MAP] Make Minimap Start : "+map_path);
    minimap = cv::imread(map_path.toStdString());
    cv::Mat minimap_1, minimap_2;

    int dp = 3;
    for(int i=0; i<minimap.rows; i=i+dp){
        for(int j=0; j<minimap.cols; j=j+dp){
            int pixel = 0;
            bool outline = false;
            for(int k=0; k<dp; k++){
                for(int m=0; m<dp; m++){
                    if(i+k>minimap.rows-1)
                        continue;
                    if(j+m>minimap.cols-1)
                        continue;
                    pixel+=minimap.at<cv::Vec3b>(i+k,j+m)[0];
                    if(minimap.at<cv::Vec3b>(i+k,j+m)[0] == 0)
                        outline = true;
                }
            }
            float kk = pixel/(dp*dp);
            if(kk < 10 || outline)
                pixel = 0;
            else if(kk > 100)
                pixel = 255;
            else
                pixel = 38;

            for(int k=0; k<dp; k++){
                for(int m=0; m<dp; m++){
                    if(i+k>minimap.rows-1)
                        continue;
                    if(j+m>minimap.cols-1)
                        continue;
                    minimap.data[((i+k)*minimap.cols + (j+m))*3] = pixel;
                    minimap.data[((i+k)*minimap.cols + (j+m))*3 + 1] = pixel;
                    minimap.data[((i+k)*minimap.cols + (j+m))*3 + 2] = pixel;
                }
            }
        }
    }

    QImage temp_image = QPixmap::fromImage(mat_to_qimage_cpy(minimap)).toImage();
    if(temp_image.save("image/map_mini1.png","PNG")){
        plog->write("[MAP] Make Minimap : 1/3");
    }else{
        plog->write("[MAP - ERROR] Make Minimap (Fail to save): 1/3");
    }

    dp = 15;
    for(int i=0; i<minimap.rows; i=i+dp){
        for(int j=0; j<minimap.cols; j=j+dp){

            int pixel = 0;
            int outline = 0;
            for(int k=0; k<dp; k++){
                for(int m=0; m<dp; m++){
                    if(i+k>minimap.rows-1)
                        continue;
                    if(j+m>minimap.cols-1)
                        continue;
                    pixel+=minimap.at<cv::Vec3b>(i+k,j+m)[0];
                    if(minimap.at<cv::Vec3b>(i+k,j+m)[0] == 0)
                        outline++;
                }
            }
            float kk = pixel/(dp*dp);
            if(outline > (dp*dp)/3)
                pixel = 0;
            else if(kk > 100)
                pixel = 255;
            else
                pixel = 38;

            for(int k=0; k<dp; k++){
                for(int m=0; m<dp; m++){
                    if(i+k>minimap.rows-1)
                        continue;
                    if(j+m>minimap.cols-1)
                        continue;
                    minimap.data[((i+k)*minimap.cols + (j+m))*3] = pixel;
                    minimap.data[((i+k)*minimap.cols + (j+m))*3 + 1] = pixel;
                    minimap.data[((i+k)*minimap.cols + (j+m))*3 + 2] = pixel;
                }
            }
        }
    }
    temp_image = QPixmap::fromImage(mat_to_qimage_cpy(minimap)).toImage();
    if(temp_image.save("image/map_mini2.png","PNG")){
        plog->write("[MAP] Make Minimap : 2/3");
    }else{
        plog->write("[MAP - ERROR] Make Minimap (Fail to save): 2/3");
    }

    cv::cvtColor(minimap, minimap_1,cv::COLOR_BGR2HSV);
    cv::GaussianBlur(minimap_1, minimap_2,cv::Size(3,3),0);
    cv::Scalar lower(0,0,37);
    cv::Scalar upper(0,0,255);
    cv::inRange(minimap_2,lower,upper,minimap_1);
    cv::Canny(minimap_1,minimap_2,600,600);

    cv::Mat kernel = getStructuringElement(cv::MORPH_RECT, cv::Size(5,5));
    dilate(minimap_2, minimap_1, kernel);
    temp_image = QPixmap::fromImage(mat_to_qimage_cpy(minimap_1)).toImage();
    if(temp_image.save("image/map_mini.png","PNG")){
        plog->write("[MAP] Make Minimap : DONE");
    }else{
        plog->write("[MAP - ERROR] Make Minimap (Fail to save): 3/3");
    }
}






////*********************************************  PATROL 관련   ***************************************************////
QString Supervisor::getPatrolFileName(){
    if(patrol.filename == ""){
        return patrol.filename;
    }else{
        QFile *file  = new QFile(patrol.filename);
        if(file->open(QIODevice::ReadOnly)){
            return patrol.filename;
        }else{
            return "";
        }
    }
}
void Supervisor::makePatrol(){
    plog->write("[USER INPUT] Make New Patrol");
    setSetting("PATROL/curfile","");
    patrol.path.clear();
    patrol.filename = "";
}
void Supervisor::loadPatrolFile(QString path){
    QStringList list1 = path.split("/");
    QStringList list = list1[list1.size()-1].split(".");
    if(list.size() == 1){
        path = "patrol/" + list1[list1.size()-1] + ".ini";
    }else{
        path = "patrol/" + list1[list1.size()-1];
    }
    plog->write("[USER INPUT] Load Patrol : "+path);
    QSettings patrols(path, QSettings::IniFormat);
    patrol.path.clear();
    patrol.filename = path;
    ST_PATROL temp;
    patrols.beginGroup("PATH");
    int num = patrols.value("num").toInt();
    patrol.mode = patrols.value("mode").toInt();
    for(int i=0; i<num; i++){
        temp.type = patrols.value("type_"+QString::number(i)).toString();
        temp.location = patrols.value("location_"+QString::number(i)).toString();
        temp.pose.x = patrols.value("x_"+QString::number(i)).toFloat();
        temp.pose.y = patrols.value("y_"+QString::number(i)).toFloat();
        temp.pose.th = patrols.value("th_"+QString::number(i)).toFloat();
        patrol.path.push_back(temp);
    }
    patrols.endGroup();
    setSetting("PATROL/curfile",path);
}
void Supervisor::savePatrolFile(QString path){
    QStringList list1 = path.split("/");
    QStringList list = list1[list1.size()-1].split(".");
    if(list.size() == 1){
        path = "patrol/" + list1[list1.size()-1] + ".ini";
    }else{
        path = "patrol/" + list1[list1.size()-1];
    }
    plog->write("[USER INPUT] Save Patrol : "+path);
    QSettings patrols(path, QSettings::IniFormat);
    patrols.clear();
    for(int i=0; i<patrol.path.size(); i++){
        patrols.setValue("PATH/type_"+QString::number(i),patrol.path[i].type);
        patrols.setValue("PATH/location_"+QString::number(i),patrol.path[i].location);
        patrols.setValue("PATH/x_"+QString::number(i),QString::number(patrol.path[i].pose.x));
        patrols.setValue("PATH/y_"+QString::number(i),QString::number(patrol.path[i].pose.y));
        patrols.setValue("PATH/th_"+QString::number(i),QString::number(patrol.path[i].pose.th));
    }
    patrols.setValue("PATH/num",patrol.path.size());
    patrols.setValue("PATH/mode",QString::number(patrol.mode));

    setSetting("PATROL/curfile",path);
}
void Supervisor::addPatrol(QString type, QString location, float x, float y, float th){
    ST_PATROL temp;
    temp.type = type;
    temp.location = location;

    if(temp.location != ""){
        for(int i=0; i<pmap->vecLocation.size(); i++){
            if(pmap->vecLocation[i].name == temp.location){
                temp.pose.x = pmap->vecLocation[i].pose.x;
                temp.pose.y = pmap->vecLocation[i].pose.y;
                temp.pose.th = pmap->vecLocation[i].pose.th;
                patrol.path.push_back(temp);
                plog->write("[USER INPUT] Add Patrol Pose : "+QString().sprintf("%f, %f, %f",temp.pose.x, temp.pose.y, temp.pose.th));
                break;
            }
        }
    }else{
        ST_FPOINT temp1 = canvasTomap(x,y);
        temp.pose.x = temp1.x;
        temp.pose.y = temp1.y;
        temp.pose.th = th;
        patrol.path.push_back(temp);
        plog->write("[USER INPUT] Add Patrol Location : "+location);
    }
}
void Supervisor::removePatrol(int num){
    if(num > -1 && num < patrol.path.size()){
        patrol.path.remove(num);
        plog->write("[USER INPUT] Remove Patrol : "+QString::number(num));
    }
}
void Supervisor::movePatrolUp(int num){
    if(num > 1 && num < patrol.path.size()){
        ST_PATROL temp = patrol.path[num];
        patrol.path.remove(num);
        patrol.path.insert(num-1,temp);
        plog->write("[USER INPUT] Move Up Patrol : "+QString::number(num));
    }
}
void Supervisor::movePatrolDown(int num){
    if(num > 0 && num < patrol.path.size()-1){
        ST_PATROL temp = patrol.path[num];
        patrol.path.remove(num);
        patrol.path.insert(num+1,temp);
        plog->write("[USER INPUT] Move Down Patrol : "+QString::number(num));
    }
}
int Supervisor::getPatrolMode(){
    return patrol.mode;
}
void Supervisor::setPatrolMode(int mode){
    patrol.mode = mode;
    plog->write("[USER INPUT] SET Patrol Mode : "+QString::number(mode));
    QMetaObject::invokeMethod(mMain, "updatepatrol");
}
int Supervisor::getPatrolNum(){
    return patrol.path.size();
}
QString Supervisor::getPatrolType(int num){
    if(num > -1 && num < patrol.path.size()){
        return patrol.path[num].type;
    }else{
        return "";
    }
}
QString Supervisor::getPatrolLocation(int num){
    if(num > -1 && num < patrol.path.size()){
        return patrol.path[num].location;
    }else{
        return "";
    }
}
float Supervisor::getPatrolX(int num){
    if(num > -1 && num < patrol.path.size()){
        ST_POSE temp = setAxis(patrol.path[num].pose);
        return temp.x;
    }else{
        return 0;
    }
}
float Supervisor::getPatrolY(int num){
    if(num > -1 && num < patrol.path.size()){
        ST_POSE temp = setAxis(patrol.path[num].pose);
        return temp.y;
    }else{
        return 0;
    }
}
float Supervisor::getPatrolTH(int num){
    if(num > -1 && num < patrol.path.size()){
        ST_POSE temp = setAxis(patrol.path[num].pose);
        return temp.th;
    }else{
        return 0;
    }
}

void Supervisor::startRecordPath(){

}
void Supervisor::startcurPath(){

}
void Supervisor::stopcurPath(){

}
void Supervisor::pausecurPath(){

}

void Supervisor::runRotateTables(){
    plog->write("[USER INPUT] START ROTATE TABLES");
    ui_state = UI_STATE_PATROLLING;
    ui_cmd = UI_CMD_TABLE_PATROL;
    state_rotate_tables = 1;
}
void Supervisor::stopRotateTables(){
    plog->write("[USER INPUT] STOP ROTATE TABLES");
    ui_cmd = UI_CMD_PATROL_STOP;
}





//// *********************************** SLOTS *********************************** ////
void Supervisor::server_cmd_setini(){
    readSetting();
}
void Supervisor::path_changed(){
    QMetaObject::invokeMethod(mMain, "updatepath");
}
void Supervisor::server_cmd_pause(){
    plog->write("[SERVER] PAUSE");
    lcm->movePause();
    QMetaObject::invokeMethod(mMain, "pausedcheck");
}
void Supervisor::server_cmd_resume(){
    plog->write("[SERVER] RESUME");
    lcm->moveResume();
    QMetaObject::invokeMethod(mMain, "pausedcheck");
}
void Supervisor::server_cmd_newtarget(){
    plog->write("[SERVER] NEW TARGET !!" + QString().sprintf("%f, %f, %f",probot->targetPose.x, probot->targetPose.y, probot->targetPose.th));
    if(ui_state == UI_STATE_PATROLLING)
        state_rotate_tables = 4;
    lcm->moveTo(probot->targetPose.x, probot->targetPose.y, probot->targetPose.th);
}
void Supervisor::server_cmd_newcall(){
    ui_cmd = UI_CMD_MOVE_CALLING;
//    QMetaObject::invokeMethod(mMain,"newcall");
}


//// *********************************** TIMER *********************************** ////
void Supervisor::onTimer(){
    // QML 오브젝트 매칭
    if(mMain == nullptr && object != nullptr){
        setObject(object);
        setWindow(qobject_cast<QQuickWindow*>(object));
    }

    // usb 파일 확인
    if(usb_check){
        if(usb_check_count++ > 15){
            usb_check = false;
        }else{
            std::string user = getenv("USER");
            std::string path = "/media/" + user;
            QDir directory(path.c_str());
            QStringList FilesList = directory.entryList();
            usb_map_list.clear();
            for(int i=0; i<FilesList.size(); i++){
                std::string path1 = path + "/";
                QString path_usb = path1.c_str() + FilesList[i];
                QDir directory1(path_usb);
                QStringList FilesList2 = directory1.entryList();
                for(int j=0; j<FilesList2.size(); j++){
                    if(FilesList2[j].left(7) == "raw_map"){
                        usb_map_list.push_back(path_usb +  "/" + FilesList2[j]);
                    }else if(FilesList2[j].left(4) == "map_"){
                        usb_map_list.push_back(path_usb + "/" + FilesList2[j]);
                    }
                }
            }

            if(usb_map_list.size() > 0){
                qDebug() << usb_map_list;
                usb_check = false;
                usb_check_count = 0;
            }
        }
    }
    // 스케줄러 변수 초기화
    static int cur_error = ROBOT_ERROR_NONE;
    static int cur_state = UI_STATE_NONE;

    // 로봇 상태가 에러가 아니면 에러 초기화
    if(probot->state != ROBOT_STATE_ERROR)
        cur_error = ROBOT_ERROR_NONE;

    if(lcm->isconnect){
        // 로봇연결되고 로봇의 상태가 초기화 전이면 초기화 진행
        if(probot->state == ROBOT_STATE_NOT_READY && !lcm->map_updated){
            if(flag_read_ini){
                if(pmap->use_server){
                    plog->write("[LCM] CONNECT -> INIT START");
                    lcm->sendMapPath("file://"+QCoreApplication::applicationDirPath()+"/image/map_server.png");
                    ui_state = UI_STATE_NONE;
                }else{
                    plog->write("[LCM] CONNECT -> INIT START");
                    lcm->sendMapPath("file://"+QCoreApplication::applicationDirPath()+"/image/map_raw.png");
                    ui_state = UI_STATE_NONE;
                }
            }
            lcm->map_updated = true;
        }else if(probot->state == ROBOT_STATE_ERROR){
            //로봇이 에러상태면 ui에 movefail 화면 띄움
            if(ui_state != UI_STATE_MOVEFAIL){
                ui_state = UI_STATE_MOVEFAIL;
                plog->write(("[LCM] ROBOT ERROR DETECTED!"));
                isaccepted = false;
            }
        }else{
            if(!lcm->map_updated){
                lcm->map_updated = true;
            }
            // 로봇연결되면 READY로 상태 변경
            if(ui_state == UI_STATE_NONE){
                plog->write("[LCM] CONNECT -> UI_STATE = READY");
                ui_state = UI_STATE_READY;
            }
        }
    }else{
        lcm->map_updated = false;
        // 로봇연결이 끊어졌는데 ui_state가 NONE이 아니
        if(ui_state != UI_STATE_NONE){
            ui_state = UI_STATE_NONE;
            plog->write("[LCM] DISCONNECT -> UI_STATE = NONE");
        }
    }

    switch(ui_state){
    case UI_STATE_READY:{
        cur_state = ui_state;
        if(probot->state == ROBOT_STATE_PAUSED){
            lcm->moveStop();
        }

        if(ui_cmd == UI_CMD_MOVE_TABLE){
            ui_state = UI_STATE_SERVING;
            ui_cmd = UI_CMD_NONE;
        }else if(ui_cmd == UI_CMD_MOVE_CHARGE){
            ui_state = UI_STATE_GO_CHARGE;
            ui_cmd = UI_CMD_NONE;
        }else if(ui_cmd == UI_CMD_MOVE_WAIT){
            ui_state = UI_STATE_GO_HOME;
            ui_cmd = UI_CMD_NONE;
        }else if(ui_cmd == UI_CMD_TABLE_PATROL){

            ui_cmd = UI_CMD_NONE;
        }else if(ui_cmd == UI_CMD_MOVE_CALLING){
            ui_state = UI_STATE_CALLING;
            ui_cmd = UI_CMD_NONE;
        }
        break;
    }
    case UI_STATE_CHARGING:{
        cur_state = ui_state;
        break;
    }
    case UI_STATE_GO_HOME:{
        cur_state = ui_state;
        if(probot->state == ROBOT_STATE_READY){
            if(isaccepted){
                ui_cmd = UI_CMD_NONE;
                QMetaObject::invokeMethod(mMain, "waitkitchen");
                ui_state = UI_STATE_READY;
                isaccepted = false;
            }else{
                lcm->moveTo("Resting_0");
            }
        }else if(probot->state == ROBOT_STATE_MOVING){
            // moving
            if(!isaccepted){
                isaccepted = true;
                QMetaObject::invokeMethod(mMain, "movelocation");
            }
        }
        break;
    }
    case UI_STATE_GO_CHARGE:{
        cur_state = ui_state;
        if(probot->state == ROBOT_STATE_READY){
            if(isaccepted){
                ui_cmd = UI_CMD_NONE;
                isaccepted = false;
                ui_state = UI_STATE_CHARGING;
                QMetaObject::invokeMethod(mMain, "docharge");
            }else{
                lcm->moveTo("Charging_0");
            }
        }else if(probot->state == ROBOT_STATE_MOVING){
            // moving
            if(!isaccepted){
                isaccepted = true;
                QMetaObject::invokeMethod(mMain, "movelocation");
            }
        }
        break;
    }
    case UI_STATE_SERVING:{
        cur_state = ui_state;
        if(probot->state == ROBOT_STATE_READY){
            //Check Done Signal
            if(isaccepted){
                ui_state = UI_STATE_PICKUP;
                int curNum = 0;
                probot->pickupTrays.clear();
                for(int i=0; i<setting.tray_num; i++){
                    if(probot->trays[i] == curNum){
                        probot->trays[i] = 0;
                        if(curNum != 0)
                            probot->pickupTrays.push_back(i+1);
                    }else if(curNum == 0){
                        curNum = probot->trays[i];
                        probot->pickupTrays.push_back(i+1);
                        probot->trays[i] = 0;
                    }
                }
                plog->write("[SCHEDULER] SERVING : PICK UP (Table"+QString::number(curNum)+")");
                QMetaObject::invokeMethod(mMain, "showpickup");
                isaccepted = false;
            }else{
                // move start
                static int timer_cnt = 0;
                bool serveDone = true;
                if(timer_cnt%5==0){
                    for(int i=0; i<setting.tray_num; i++){
                        if(probot->trays[i] != 0){
                            plog->write("[SCHEDULER] SERVING : MOVE TO (Table"+QString::number(probot->trays[i])+")");
                            lcm->moveTo("Serving_"+QString().sprintf("%d",probot->trays[i]-1));
                            serveDone = false;
                            break;
                        }
                    }
                    if(serveDone){
                        // move done -> move to wait
                        plog->write("[SCHEDULER] SERVING : SERVE DONE");
                        ui_state = UI_STATE_GO_HOME;
                    }
                }
                timer_cnt++;
            }
        }else if(probot->state == ROBOT_STATE_MOVING){
            // moving
            if(!isaccepted){
                isaccepted = true;
                plog->write("[SCHEDULER] SERVING : MOVE START");
                QMetaObject::invokeMethod(mMain, "movelocation");
            }
        }else if(probot->state == ROBOT_STATE_ERROR){
            if(cur_error != probot->err_code){
                cur_error = probot->err_code;
                if(cur_error == ROBOT_ERROR_NO_PATH){
                    isaccepted = false;
                    cur_error = probot->err_code;
                    ui_state = UI_STATE_MOVEFAIL;
                    plog->write("[SCHEDULER] ROBOT ERROR : NO PATH");
                    QMetaObject::invokeMethod(mMain, "nopathfound");
                }else{
                    plog->write("[SCHEDULER] ROBOT ERROR : " + QString::number(probot->err_code));
                }
            }
        }
        break;
    }
    case UI_STATE_CALLING:{
        cur_state = ui_state;
        if(probot->state == ROBOT_STATE_READY){
            if(isaccepted){//도착
                plog->write("[SCHEDULER] CALLING MOVE ARRIVED "+probot->call_list[0]);
                probot->call_list.pop_front();
                QMetaObject::invokeMethod(mMain, "showpickup");
                isaccepted = false;
            }else{//출발
                static int timer_cnt = 0;
                bool moveDone = false;

                if(timer_cnt%5==0){
                    //최대 이동 횟수 초과 시 -> 대기장소로 이동
                    if(probot->call_moving_count > probot->max_moving_count){
                        plog->write("[SCHEDULER] CALLING MOVE DONE(MAX MOVING)");
                        moveDone = true;
                    }

                    //call_list 비어있으면 -> 대기장소로 이동(혹은 패트롤 재시작)
                    if(probot->call_list.size() == 0){
                        plog->write("[SCHEDULER] CALLING MOVE DONE(NO LIST)");
                        moveDone = true;
                    }

                    if(moveDone){
                        ui_state = UI_STATE_GO_HOME;
                    }else{
                        //call_list에서 타겟 지정 후 move
                        QString cur_target = probot->call_list[0];
                        plog->write("[SCHEDULER] CALLING MOVE TO "+cur_target);
                        lcm->moveTo(cur_target);
                    }
                }
                timer_cnt++;
            }
        }else if(probot->state == ROBOT_STATE_MOVING){
            // moving
            if(!isaccepted){
                isaccepted = true;
                plog->write("[SCHEDULER] CALLING : MOVE START");
                QMetaObject::invokeMethod(mMain, "movelocation");
            }
        }else if(probot->state == ROBOT_STATE_ERROR){
            if(cur_error != probot->err_code){
                cur_error = probot->err_code;
                if(cur_error == ROBOT_ERROR_NO_PATH){
                    isaccepted = false;
                    cur_error = probot->err_code;
                    ui_state = UI_STATE_MOVEFAIL;
                    plog->write("[SCHEDULER] ROBOT ERROR : NO PATH");
                    QMetaObject::invokeMethod(mMain, "nopathfound");
                }else{
                    plog->write("[SCHEDULER] ROBOT ERROR : " + QString::number(probot->err_code));
                }
            }
        }
        break;
    }
    case UI_STATE_PICKUP:{
        cur_state = ui_state;
        if(probot->state == ROBOT_STATE_PAUSED){
            lcm->moveResume();
        }
        if(ui_cmd == UI_CMD_PICKUP_CONFIRM){
            ui_state = UI_STATE_SERVING;
            ui_cmd = UI_CMD_NONE;
        }
        break;
    }
    case UI_STATE_PATROLLING:{
        cur_state = ui_state;
        // 테스트용 테이블 로테이션
        if(ui_cmd == UI_CMD_TABLE_PATROL){
            state_rotate_tables = 1;
            ui_cmd = UI_CMD_NONE;
        }else if(ui_cmd == UI_CMD_PATROL_STOP){
            ui_cmd = UI_CMD_NONE;
            if(state_rotate_tables != 0){
                ui_state = UI_STATE_NONE;
                lcm->moveStop();
                state_rotate_tables = 0;
            }
        }

        static int table_num_last = 0;
        switch(state_rotate_tables){
        case 1:
        {//Start
            if(probot->state == ROBOT_STATE_READY){
                ui_state = UI_STATE_PATROLLING;
                int table_num = qrand()%5;
                while(table_num_last == table_num){
                    table_num = qrand()%5;
                }
                qDebug() << "Move To " << "Serving_"+QString().sprintf("%d",table_num);
                lcm->moveTo("Serving_"+QString().sprintf("%d",table_num));
                state_rotate_tables = 2;
                table_num_last = table_num;
            }
            break;
        }
        case 2:
        {//Wait State Change
            static int timer_cnt = 0;
            if(probot->state == ROBOT_STATE_MOVING){
                qDebug() << "Moving Start";
                state_rotate_tables = 3;
            }else{
                if(timer_cnt%10==0){
                    lcm->moveTo("Serving_"+QString().sprintf("%d",table_num_last));
                }
            }
            break;
        }
        case 3:
        {
            if(probot->state == ROBOT_STATE_READY){
                //move done
                qDebug() << "Move Done!!";
                state_rotate_tables = 1;
            }
            break;
        }
        case 4:
        {//server new target
            if(probot->state == ROBOT_STATE_READY){
                state_rotate_tables = 5;
            }//confirm

            break;
        }
        case 5:{
            if(probot->state == ROBOT_STATE_MOVING){
                qDebug() << "Moving Start";
                state_rotate_tables = 3;
            }
            break;
        }
        }
        break;
    }
    case UI_STATE_MOVEFAIL:{
        if(cur_error != probot->err_code){
            cur_error = probot->err_code;
            if(cur_error == ROBOT_ERROR_NO_PATH){
                cur_error = probot->err_code;
                plog->write("[SCHEDULER] ROBOT ERROR : NO PATH");
                QMetaObject::invokeMethod(mMain, "nopathfound");
            }else{
                plog->write("[SCHEDULER] ROBOT ERROR : " + QString::number(probot->err_code));
            }
        }
        if(probot->state == ROBOT_STATE_MOVING){
            ui_state = cur_state;
        }
        break;
    }
    case UI_STATE_NONE:{
        break;
    }
    }
}








