#include "Supervisor.h"
#include <QQmlApplicationEngine>
#include <QKeyEvent>
#include <iostream>
#include <fstream>
#include <iostream>
#include <sys/stat.h>
#include <sys/types.h>
#include <QQmlEngine>
#include <QTextCodec>
#include <QSslSocket>
#include <exception>
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
#define MAIN_THREAD 200

Supervisor::Supervisor(QObject *parent)
    : QObject(parent)
{
    timer = new QTimer();
    connect(timer, SIGNAL(timeout()),this,SLOT(onTimer()));
    timer->start(MAIN_THREAD);
    flag_clear = false;

    checkShellFiles();

    probot = &robot;
    pmap = &map;
    mMain = nullptr;

    usb_map_list.clear();
    usb_check = false;
    usb_check_count = 0;

    ipc = new IPCHandler();
    lcm = new LCMHandler();
    server = new ServerHandler();
    joystick = new JoystickHandler();
    call = new CallbellHandler();
    git = new HTTPHandler();
    connect(call, SIGNAL(new_call()),this,SLOT(new_call()));
    connect(git, SIGNAL(pullSuccess()),this,SLOT(git_pull_success()));
    connect(git, SIGNAL(pullFailed()),this,SLOT(git_pull_failed()));

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
    connect(server,SIGNAL(server_get_map()),this,SLOT(server_get_map()));
    connect(lcm, SIGNAL(pathchanged()),this,SLOT(path_changed()));
    connect(lcm, SIGNAL(mappingin()),this,SLOT(mapping_update()));
    connect(lcm, SIGNAL(objectingin()),this,SLOT(objecting_update()));
    connect(lcm, SIGNAL(cameraupdate()),this,SLOT(camera_update()));
    connect(ipc, SIGNAL(pathchanged()),this,SLOT(path_changed()));
    connect(ipc, SIGNAL(mappingin()),this,SLOT(mapping_update()));
    connect(ipc, SIGNAL(objectingin()),this,SLOT(objecting_update()));
    connect(ipc, SIGNAL(cameraupdate()),this,SLOT(camera_update()));
    plog->write("");
    plog->write("");
    plog->write("");
    plog->write("");
    plog->write("[BUILDER] SUPERVISOR constructed");


    QProcess *process = new QProcess(this);
    QString file = QDir::homePath() + "/auto_reset.sh";
    process->start(file);
    process->waitForReadyRead();
    startSLAM();

//    const QHostAddress &localhost = QHostAddress(QHostAddress::LocalHost);
//    for(QHostAddress &address: QNetworkInterface::allAddresses()){
//        if(address.protocol() == QAbstractSocket::IPv4Protocol && address != localhost){
//            qDebug() << "!!!!!!!!!!!!!!!!!!!!! : " << address.toString();
////            qDebug() << QNetworkInterface::type();
//            if(address.toString() == "192.168.2.1"){
//                qDebug() << "CHANGED";
//                address.setAddress("192.168.2.11");
//            }
//        }
//    }

//    for(QNetworkInterface &interface: QNetworkInterface::allInterfaces()){
//        if(interface.type() == QNetworkInterface::Wifi && interface.addressEntries().size()>0){
//            QHostAddress address = interface.addressEntries().at(0).ip();
//            if(address.protocol() == QAbstractSocket::IPv4Protocol && address != localhost){
//                qDebug() << "!!!!!!!!!!!!!!!!!!!!! : " << address.toString();
//                if(address.toString() == "192.168.2.1"){
//                    qDebug() << "CHANGED";
//                    address.setAddress("192.168.2.11");
//                }
//            }
//        }
//    }
}

Supervisor::~Supervisor(){
    plog->write("[BUILDER] SUPERVISOR desployed");
    slam_process->kill();
    slam_process->close();
    QString file = QDir::homePath() + "/auto_kill.sh";
    slam_process->start(file);
    QThread::sleep(1);
    slam_process->kill();
    slam_process->close();
    plog->write("[BUILDER] KILLED SLAMNAV");
}

////*********************************************  WINDOW 관련   ***************************************************////
void Supervisor::setWindow(QQuickWindow *Window){
    plog->write("[BUILDER] SUPERVISOR SET WINDOW ");
    mMain = Window;
}
QQuickWindow *Supervisor::getWindow()
{
    return mMain;
}
void Supervisor::setObject(QObject *object)
{
    mObject = object;
}
QObject *Supervisor::getObject()
{
    //rootobject를 리턴해준다.
    return mObject;
}
void Supervisor::programRestart(){
    plog->write("[USER INPUT] PROGRAM RESTART");
    slam_process->kill();
    QProcess::startDetached(QApplication::applicationFilePath());
    QApplication::exit(12);
}
void Supervisor::programExit(){
    plog->write("[USER INPUT] PROGRAM EXIT");
    slam_process->kill();
    QCoreApplication::quit();
}
void Supervisor::programHide(){
    plog->write("[USER INPUT] PROGRAM MINIMIZE");
}
void Supervisor::writelog(QString msg){
    plog->write(msg);
}

QString Supervisor::getRawMapPath(QString name){
    return QDir::homePath()+"/maps/"+name+"/map_raw.png";
}
QString Supervisor::getMapPath(QString name){
    return QDir::homePath()+"/maps/"+name+"/map_edited.png";
}
QString Supervisor::getAnnotPath(QString name){
    return QDir::homePath()+"/maps/"+name+"/annotation.ini";
}
QString Supervisor::getMetaPath(QString name){
    return QDir::homePath()+"/maps/"+name+"/map_meta.ini";
}
QString Supervisor::getTravelRawPath(QString name){
    return QDir::homePath()+"/maps/"+name+"/travel_raw.png";
}
QString Supervisor::getTravelPath(QString name){
    return QDir::homePath()+"/maps/"+name+"/travel_edited.png";
}
QString Supervisor::getCostPath(QString name){
    return QDir::homePath()+"/maps/"+name+"/map_cost.png";
}
QString Supervisor::getIniPath(){
    return QDir::homePath()+"/robot_config.ini";
}

////*********************************************  CALLING 관련   ***************************************************////
void Supervisor::new_call(){
    if(setting_call_id > -1){
        plog->write("[SUPERVISOR] NEW CALL ("+call->getBellID()+") SETTING");
        setSetting("CALLING/call_"+QString::number(setting_call_id),call->getBellID());
        QMetaObject::invokeMethod(mMain, "call_setting");
    }else{
        bool already_in = false;
        for(int i=0; i<call_list.size(); i++){
            if(call_list[i] == call->getBellID()){
                already_in = true;
                plog->write("[SUPERVISOR] NEW CALL ("+call_list[i]+") BUT ALREADY LIST IN");
                break;
            }
        }
        if(already_in){

        }else{
            call_list.push_back(call->getBellID());
            plog->write("[SUPERVISOR] NEW CALL ("+call->getBellID()+") GET -> LIST SIZE IS "+QString::number(call_list.size()));
        }
    }
}

void Supervisor::setCallbell(int id){
    setting_call_id = id;
}

QString Supervisor::getCallName(QString id){
    for(int i=0; i<getSetting("CALLING","call_num").toInt(); i++){
        if(getSetting("CALLING","call_"+QString::number(i)) == id){
            return "Serving_"+QString::number(i);
        }
    }
    return id;
}

void Supervisor::removeCall(int id){
    plog->write("[USER INPUT] REMOVE CALL_LIST "+QString::number(id));
    call_list.remove(id);
}
void Supervisor::removeCallAll(){
    plog->write("[USER INPUT] REMOVE CALL_LIST ALL");
    call_list.clear();
}

////*********************************************  SETTING 관련   ***************************************************////
void Supervisor::git_pull_success(){
    QString date = probot->program_date;
    plog->write("[SUPERVISOR] GIT PULL SUCCESS : "+probot->program_date+", "+date);
    setSetting("ROBOT_SW/version_msg",probot->program_message);
    setSetting("ROBOT_SW/version_date",date);//probot->program_date);
    setSetting("ROBOT_SW/version",probot->program_version);
    readSetting();
}
void Supervisor::git_pull_failed(){
    QString date = probot->program_date;
    plog->write("[SUPERVISOR] GIT PULL FAILED : "+probot->program_date+", "+date);
    setSetting("ROBOT_SW/version_msg",probot->program_message);
    setSetting("ROBOT_SW/version_date",date);//probot->program_date);
    setSetting("ROBOT_SW/version",probot->program_version);
    readSetting();
    git->resetGit();
}
bool Supervisor::isNewVersion(){
    git->updateGitArray();
    if(probot->gitList[0].date == probot->program_date){
        return true;
    }else{
        return false;
    }
}
QString Supervisor::getLocalVersion(){
    return probot->program_version;
}
QString Supervisor::getServerVersion(){
    if(probot->gitList.size() > 0){
        return probot->gitList[0].commit;
    }else{
        return "";
    }
}
QString Supervisor::getLocalVersionDate(){
    return probot->program_date;
}
QString Supervisor::getServerVersionDate(){
    if(probot->gitList.size() > 0){
        return probot->gitList[0].date;
    }else{
        return "";
    }
}
QString Supervisor::getLocalVersionMessage(){
    return probot->program_message;
}
QString Supervisor::getServerVersionMessage(){
    if(probot->gitList.size() > 0){
        return probot->gitList[0].message;
    }else{
        return "";
    }
}
void Supervisor::pullGit(){
    git->pullGit();

}

void Supervisor::setSetting(QString name, QString value){
    QString ini_path = getIniPath();
    QSettings setting(ini_path, QSettings::IniFormat);
    setting.setValue(name,value);
    plog->write("[SETTING] SET "+name+" VALUE TO "+value);
}
QString Supervisor::getSetting(QString group, QString name){
    QString ini_path = getIniPath();
    QSettings setting_robot(ini_path, QSettings::IniFormat);
    setting_robot.beginGroup(group);
    return setting_robot.value(name).toString();
}
void Supervisor::readSetting(QString map_name){
    //Robot Setting================================================================
    QString ini_path = getIniPath();
    QSettings setting_robot(ini_path, QSettings::IniFormat);

    setting_robot.beginGroup("ROBOT_HW");
    probot->model = setting_robot.value("model").toString();
    probot->serial_num = setting_robot.value("serial_num").toInt();
    probot->name = probot->model + QString::number(probot->serial_num);

    setting.tray_num = setting_robot.value("tray_num").toInt();
    probot->radius = setting_robot.value("radius").toFloat();
    pmap->robot_radius = probot->radius;
    probot->type = setting_robot.value("type").toString();
    setting_robot.endGroup();

    setting_robot.beginGroup("ROBOT_SW");
    probot->program_version = setting_robot.value("version").toString();
    probot->program_message = setting_robot.value("version_msg").toString();
    probot->program_date = setting_robot.value("version_date").toString();
    probot->velocity = setting_robot.value("velocity").toFloat();
    setting.useVoice = setting_robot.value("use_voice").toBool();
    setting.useAutoInit = setting_robot.value("use_autoinit").toBool();
    setting.useBGM = setting_robot.value("use_bgm").toBool();
    pmap->use_uicmd = setting_robot.value("use_uicmd").toBool();
    pmap->width = setting_robot.value("map_size").toInt();
    pmap->height = setting_robot.value("map_size").toInt();
    pmap->origin[0] = pmap->width/2;
    pmap->origin[1] = pmap->height/2;
    pmap->gridwidth = setting_robot.value("grid_size").toFloat();
    setting_robot.endGroup();


    setting_robot.beginGroup("CALLING");
    probot->max_moving_count = setting_robot.value("call_maximum").toInt();
    setting_robot.endGroup();

    setting_robot.beginGroup("FLOOR");
    pmap->margin = setting_robot.value("margin").toFloat();
    pmap->use_server = setting_robot.value("map_server").toBool();
    server->acceptCmd = pmap->use_server;
    pmap->map_loaded = setting_robot.value("map_load").toBool();
    pmap->map_name = setting_robot.value("map_name").toString();
    pmap->map_path = setting_robot.value("map_path").toString();
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

    setting_robot.beginGroup("SENSOR");
    pmap->left_camera = setting_robot.value("left_camera").toString();
    pmap->right_camera = setting_robot.value("right_camera").toInt();
    setting_robot.endGroup();

    if(map_name == ""){
        map_name = pmap->map_name;
    }

    plog->write("[SUPERVISOR] READ SETTING : "+map_name);
    //Map Meta Data======================================================================
    ini_path = getMetaPath(map_name);
    QSettings setting_meta(ini_path, QSettings::IniFormat);

    setting_meta.beginGroup("map_metadata");
//    pmap->width = setting_meta.value("map_w").toInt();
//    pmap->height = setting_meta.value("map_h").toInt();
//    pmap->gridwidth = setting_meta.value("map_grid_width").toFloat();
//    pmap->origin[0] = setting_meta.value("map_origin_u").toInt();
//    pmap->origin[1] = setting_meta.value("map_origin_v").toInt();
//    qDebug() << "Read Setting " << pmap->gridwidth;
    setting_meta.endGroup();

    //Annotation======================================================================
    ini_path = getAnnotPath(map_name);
    QSettings setting_anot(ini_path, QSettings::IniFormat);

    setting_anot.beginGroup("charging_locations");
    int charge_num = setting_anot.value("num").toInt();
    pmap->locations.clear();
    LOCATION temp_loc;
    for(int i=0; i<charge_num; i++){
        QString loc_str = setting_anot.value("loc"+QString::number(i)).toString();
        QStringList strlist = loc_str.split(",");
        temp_loc.point = cv::Point2f(strlist[1].toFloat(),strlist[2].toFloat());
        temp_loc.angle = strlist[3].toFloat();
        temp_loc.type = "Charging";
        temp_loc.name = strlist[0];
        pmap->locations.push_back(temp_loc);
    }
    setting_anot.endGroup();


    setting_anot.beginGroup("other_locations");
    int patrol_num = setting_anot.value("num").toInt();
    for(int i=0; i<patrol_num; i++){
        QString loc_str = setting_anot.value("loc"+QString::number(i)).toString();
        QStringList strlist = loc_str.split(",");
        temp_loc.point = cv::Point2f(strlist[1].toFloat(),strlist[2].toFloat());
        temp_loc.angle = strlist[3].toFloat();
        temp_loc.type = "Other";
        temp_loc.name = strlist[0];
        pmap->locations.push_back(temp_loc);
    }
    setting_anot.endGroup();


    setting_anot.beginGroup("resting_locations");
    int rest_num = setting_anot.value("num").toInt();
    for(int i=0; i<rest_num; i++){
        QString loc_str = setting_anot.value("loc"+QString::number(i)).toString();
        QStringList strlist = loc_str.split(",");
        temp_loc.point = cv::Point2f(strlist[1].toFloat(),strlist[2].toFloat());
        temp_loc.angle = strlist[3].toFloat();
        temp_loc.type = "Resting";
        temp_loc.name = strlist[0];
        pmap->locations.push_back(temp_loc);
    }
    setting_anot.endGroup();

    setting_anot.beginGroup("serving_locations");
    int serv_num = setting_anot.value("num").toInt();
    for(int i=0; i<serv_num; i++){
        QString loc_str = setting_anot.value("loc"+QString::number(i)).toString();
        QStringList strlist = loc_str.split(",");
        temp_loc.point = cv::Point2f(strlist[1].toFloat(),strlist[2].toFloat());
        temp_loc.angle = strlist[3].toFloat();
        temp_loc.type = "Serving";
        temp_loc.name = strlist[0];
        pmap->locations.push_back(temp_loc);
    }
    if(setting.table_num > serv_num){
        setting.table_num = serv_num;
    }
    setting_anot.endGroup();

    qDebug() << pmap->locations.size() << map_name;

    setting_anot.beginGroup("objects");
    int obj_num = setting_anot.value("num").toInt();

    pmap->objects.clear();
    cv::Point2f temp_point;
    for(int i=0; i<obj_num; i++){
        QString name = setting_anot.value("poly"+QString::number(i)).toString();
        QStringList strlist = name.split(",");
        OBJECT temp_obj;
        if(strlist[0].left(5) == "Table"){
            temp_obj.type = "Table";
        }else if(strlist[0].left(5) == "Chair"){
            temp_obj.type = "Chair";
        }else if(strlist[0].left(4) == "Wall"){
            temp_obj.type = "Wall";
        }else{
            temp_obj.type = "Unknown";
        }
        QStringList templist = strlist[1].split(":");

        if(templist.size() > 1){
            temp_obj.is_rect = false;
            for(int j=1; j<strlist.size(); j++){
                temp_point.x = strlist[j].split(":")[0].toFloat();
                temp_point.y = strlist[j].split(":")[1].toFloat();
                temp_obj.points.push_back(temp_point);
            }
        }else{
            if(strlist[1].toInt() == 1){
                temp_obj.is_rect = true;
                for(int j=2; j<strlist.size(); j++){
                    temp_point.x = strlist[j].split(":")[0].toFloat();
                    temp_point.y = strlist[j].split(":")[1].toFloat();
                    temp_obj.points.push_back(temp_point);
                }
            }else{
                temp_obj.is_rect = false;
                for(int j=2; j<strlist.size(); j++){
                    temp_point.x = strlist[j].split(":")[0].toFloat();
                    temp_point.y = strlist[j].split(":")[1].toFloat();
                    temp_obj.points.push_back(temp_point);
                }
            }
        }
        pmap->objects.push_back(temp_obj);
    }
    setObjPose();
    setting_anot.endGroup();

    //Set Variable
    probot->trays.clear();
    for(int i=0; i<setting.tray_num; i++){
        probot->trays.push_back(0);
    }

    if(probot->ipc_use){

    }else{
        lcm->subscribe();
    }
    flag_read_ini = true;

    QMetaObject::invokeMethod(mMain, "update_ini");
}

void Supervisor::setVelocity(float vel){
    probot->velocity = vel;
    setSetting("ROBOT_SW/velocity",QString::number(vel));
    readSetting();
    if(probot->ipc_use){
        ipc->set_velocity(vel);
    }else{
        lcm->setVelocity(vel);
    }
}

float Supervisor::getVelocity(){
    return probot->velocity;
}
int Supervisor::getTrayNum(){
    return setting.tray_num;
}
int Supervisor::getTableNum(){
    return setting.table_num;
}
void Supervisor::setTableNum(int table_num){
    setSetting("FLOOR/table_num",QString::number(table_num));
    readSetting();
}
int Supervisor::getTableColNum(){
    return setting.table_col_num;
}
void Supervisor::setTableColNum(int col_num){
    setSetting("FLOOR/table_col_num",QString::number(col_num));
    readSetting();
}
QString Supervisor::getRobotType(){
    return probot->type;
}

void Supervisor::requestCamera(){
    if(probot->ipc_use){
        IPCHandler::CMD send_msg;
        send_msg.cmd = ROBOT_CMD_REQ_CAMERA;
        ipc->set_cmd(send_msg);
    }else{
        command send_msg;
        send_msg.cmd = ROBOT_CMD_REQ_CAMERA;
        lcm->sendCommand(send_msg, "");
    }
}
void Supervisor::setCamera(QString left, QString right){
    setSetting("SENSOR/left_camera",left);
    setSetting("SENSOR/right_camera",right);
    readSetting();
}
QString Supervisor::getLeftCamera(){
    return pmap->left_camera;
}
QString Supervisor::getRightCamera(){
    return pmap->right_camera;
}
int Supervisor::getCameraNum(){
    return pmap->camera_info.size();
}
QList<int> Supervisor::getCamera(int num){
    QList<int> temp;
    return temp;
//    try{
////        return pmap->camera_info[num].data;
//    }catch(...){
//        qDebug() << "Something Wrong to get Camera " << num << pmap->camera_info.size();
//        QList<int> temp;
//        return temp;
//    }
}
QString Supervisor::getCameraSerial(int num){
    try{
        if(num > -1 && num < pmap->camera_info.size()){
            return pmap->camera_info[num].serial;
        }else{
            return "";
        }
    }catch(...){
        qDebug() << "Something Wrong to get Camera Serial " << num << pmap->camera_info.size();
        return "";
    }
}


////*********************************************  INIT PAGE 관련   ***************************************************////
bool Supervisor::isConnectServer(){
    return server->isconnect;
}

void Supervisor::deleteAnnotation(){
    plog->write("[USER INPUT] Remove Annotation Data");

    pmap->locations.clear();
    pmap->objects.clear();

    pmap->list_obj_dR.clear();
    pmap->list_obj_uL.clear();

//    readSetting();
}
bool Supervisor::isExistAnnotation(QString name){
    QString file_meta = getMetaPath(name);
    QString file_annot = getAnnotPath(name);
    return QFile::exists(file_annot);
}
bool Supervisor::isExistTravelRaw(QString name){
    QString file = getTravelRawPath(name);
    return QFile::exists(file);
}
bool Supervisor::isExistTravelEdited(QString name){
    QString file = getTravelPath(name);
    return QFile::exists(file);
}

int Supervisor::getAvailableMap(){
    std::string path = QString(QDir::homePath()+"/maps").toStdString();
    QDir directory(path.c_str());
    QStringList FileList = directory.entryList();
    map_list.clear();
    for(int i=0; i<FileList.size(); i++){
        QStringList namelist = FileList[i].split(".");
        if(namelist.size() > 1){
            continue;
        }
        std::string path2 = QString(QDir::homePath()+"/maps/"+FileList[i]).toStdString();
        QDir direc2(path2.c_str());
        QStringList detailList = direc2.entryList();
        bool available = false;
        for(int j=0; j<detailList.size(); j++){
            if(detailList[j].left(4) == "map_"){
                available = true;
                break;
            }
        }
        if(available){
            map_list.push_back(FileList[i]);
        }
    }
    return map_list.size();
}
QString Supervisor::getAvailableMapPath(int num){
    if(num>-1 && num<map_list.size()){
        return map_list[num];
    }
    return "";
}
int Supervisor::getMapFileSize(QString name){
    std::string path = QString(QDir::homePath()+"/maps/"+name).toStdString();
    QDir directory(path.c_str());
    QStringList FileList = directory.entryList();
    map_detail_list.clear();
    for(int i=0; i<FileList.size(); i++){
        if(FileList[i] == "." || FileList[i] == ".."){
            continue;
        }
        map_detail_list.push_back(FileList[i]);
    }
    return map_detail_list.size();
}
QString Supervisor::getMapFile(int num){
    return map_detail_list[num];
}
bool Supervisor::isExistMap(QString name){
    if(QFile::exists(getMapPath(name))){
        if(QFile::exists(getRawMapPath(name))){

        }else{
            //make map_raw.png
            QFile::copy(getMapPath(name),getRawMapPath(name));
        }
        return true;
    }else{
        return false;
    }
}
bool Supervisor::isExistRawMap(QString name){
    if(QFile::exists(getRawMapPath(name))){
        return true;
    }else{
        return false;
    }
}
bool Supervisor::isExistMap(){
    //기본 설정된 맵파일 확인
    if(pmap->map_loaded){
        if(QFile::exists(getMapPath(getMapname()))){
            return true;
        }else{

            plog->write("[SETTING - ERROR] "+getMapname()+" not found. map unloaded.");
            setSetting("FLOOR/map_load","false");
            readSetting();
        }
    }
    return false;
}
bool Supervisor::loadMaptoServer(){
    if(server->isconnect){
        plog->write("[USER INPUT] load map to server : request");
        server->requestMap();
        return true;
    }else{
        plog->write("[USER INPUT - ERROR] load map to server : server not connected");
        QMetaObject::invokeMethod(mMain, "loadmap_server_fail");
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
    QString ini_path = QDir::homePath()+"/robot_config.ini";
    QSettings settings(ini_path, QSettings::IniFormat);
    settings.setValue("FLOOR/map_server",use);
    if(use){
//        settings.setValue("FLOOR/map_load",true);
        settings.setValue("FLOOR/map_name",server->server_map_name);
        settings.setValue("FLOOR/map_path",QDir::homePath()+"/maps/"+server->server_map_name);
        readSetting();
        plog->write("[SETTING] USE SERVER MAP Changed : True");
    }else{
        plog->write("[SETTING] USE SERVER MAP Changed : False");
    }
    readSetting();
}
void Supervisor::removeMap(QString filename){
    plog->write("[USER INPUT] Remove Map : "+filename);
//    QFile *file = new QFile(QDir::homePath()+"/maps/"+filename);
    QDir dir(QDir::homePath()+"/maps/" + filename);

    if(dir.removeRecursively()){
        qDebug() << "true";
    }else{
        qDebug() << "false";
    }
//    file->remove();
}
bool Supervisor::isloadMap(){
    return pmap->map_loaded;
}
void Supervisor::setloadMap(bool load){
    QString ini_path = getIniPath();
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
    QString file = getIniPath();
    return QFile::exists(file);
}
void Supervisor::makeRobotINI(){
    plog->write("[SETTING] Make robot_config.ini basic format");
    setSetting("ROBOT_HW/model","TEMP");
    setSetting("ROBOT_HW/serial_num","1");
    setSetting("ROBOT_HW/radius","0.3");
    setSetting("ROBOT_HW/tray_num","2");
    setSetting("ROBOT_HW/type","SERVING");
    setSetting("ROBOT_HW/wheel_base","0.3542");
    setSetting("ROBOT_HW/wheel_radius","0.0635");

    setSetting("ROBOT_SW/robot_id","0");
    setSetting("ROBOT_SW/st_v","0.3");
    setSetting("ROBOT_SW/version","");
    setSetting("ROBOT_SW/version_msg","");
    setSetting("ROBOT_SW/version_date","");
    setSetting("ROBOT_SW/use_bgm","true");
    setSetting("ROBOT_SW/use_voice","true");
    setSetting("ROBOT_SW/use_autoinit","false");
    setSetting("ROBOT_SW/use_avoid","false");
    setSetting("ROBOT_SW/use_multirobot","false");
    setSetting("ROBOT_SW/velocity","1.0");
    setSetting("ROBOT_SW/volume_bgm","50");
    setSetting("ROBOT_SW/volume_voice","50");
    setSetting("ROBOT_SW/use_uicmd","true");
    setSetting("ROBOT_SW/k_curve","0.005");
    setSetting("ROBOT_SW/k_v","1.0");
    setSetting("ROBOT_SW/k_w","1.5");
    setSetting("ROBOT_SW/limit_manual_v","0.3");
    setSetting("ROBOT_SW/limit_manual_w","30.0");
    setSetting("ROBOT_SW/limit_pivot","30.0");
    setSetting("ROBOT_SW/limit_v","0.5");
    setSetting("ROBOT_SW/limit_w","90.0");
    setSetting("ROBOT_SW/limit_v_acc","0.2");
    setSetting("ROBOT_SW/limit_w_acc","90.0");
    setSetting("ROBOT_SW/look_ahead_dist","0.50");
    setSetting("ROBOT_SW/min_look_ahead_dist","0.1");
    setSetting("ROBOT_SW/narrow_decel_ratio","0.5");
    setSetting("ROBOT_SW/obs_deadzone","0.4");
    setSetting("ROBOT_SW/obs_wait_time","5.0");
    setSetting("ROBOT_SW/path_out_dist","1.0");
    setSetting("ROBOT_SW/goal_dist","0.1");
    setSetting("ROBOT_SW/goal_th","3.0");
    setSetting("ROBOT_SW/goal_v","0.05");
    setSetting("ROBOT_SW/grid_size","0.03");
    setSetting("ROBOT_SW/map_size","1000");
    setSetting("ROBOT_SW/icp_dist","0.5");
    setSetting("ROBOT_SW/icp_error","0.1");
    setSetting("ROBOT_SW/icp_near","1.0");
    setSetting("ROBOT_SW/icp_odometry_weight","0.5");
    setSetting("ROBOT_SW/icp_ratio","0.5");
    setSetting("ROBOT_SW/icp_repeat_dist","0.15");
    setSetting("ROBOT_SW/icp_repeat_time","1.0");

    setSetting("FLOOR/map_load","true");
    setSetting("FLOOR/map_server","false");
    setSetting("FLOOR/table_col_num","1");
    setSetting("FLOOR/table_num","5");
    setSetting("FLOOR/map_name","");
    setSetting("FLOOR/map_path","");

    setSetting("PATROL/patrol_mode","0");
    setSetting("PATROL/curfile","");

    setSetting("MOTOR/gear_ratio","1.0");
    setSetting("MOTOR/k_d","4400.0");
    setSetting("MOTOR/k_i","0.0");
    setSetting("MOTOR/k_p","100.0");
    setSetting("MOTOR/left_id","1");
    setSetting("MOTOR/right_id","0");
    setSetting("MOTOR/limit_v","1.5");
    setSetting("MOTOR/limit_v_acc","1.0");
    setSetting("MOTOR/limit_w","360.0");
    setSetting("MOTOR/limit_w_acc","360.0");
    setSetting("MOTOR/wheel_dir","-1");

    setSetting("SENSOR/baudrate","256000");
    setSetting("SENSOR/cam_exposure","2000.0");
    setSetting("SENSOR/mask","10.0");
    setSetting("SENSOR/max_range","40.0");
    setSetting("SENSOR/offset_x","0.0");
    setSetting("SENSOR/offset_y","0.0");
    setSetting("SENSOR/left_camera","");
    setSetting("SENSOR/right_camera","");
    setSetting("SENSOR/left_camera_tf","0,0,0,0,0,0");
    setSetting("SENSOR/right_camera_tf","0,0,0,0,0,0");

    readSetting();
    restartSLAM();
}

bool Supervisor::rotate_map(QString _src, QString _dst, int mode){
    cv::Mat map1 = cv::imread(_src.toStdString());

    cv::rotate(map1,map1,cv::ROTATE_90_CLOCKWISE);
    cv::flip(map1, map1, 0);
    QImage temp_image = QPixmap::fromImage(mat_to_qimage_cpy(map1)).toImage();
    QString path = QDir::homePath()+"/maps/"+_dst;
    QDir directory(path);
    if(!directory.exists()){
        directory.mkpath(".");
    }

    //Save PNG File
    if(mode == 1){//edited
        if(temp_image.save(QDir::homePath()+"/maps/"+_dst+"/map_edited.png","PNG")){
            QFile *file = new QFile(QGuiApplication::applicationDirPath()+"/"+_src);
            file->remove();
            plog->write("[MAP] Save edited Map : "+_dst);
            return true;
        }else{
            plog->write("[MAP] Fail to save edited Map : "+_dst);
            return false;
        }
    }else if(mode == 2){//raw
        qDebug() << QDir::homePath()+"/maps/"+_dst+"/map_raw.png";
        if(temp_image.save(QDir::homePath()+"/maps/"+_dst+"/map_raw.png","PNG")){
            QFile *file = new QFile(QGuiApplication::applicationDirPath()+"/"+_src);
            file->remove();
            plog->write("[MAP] Save raw Map : "+_dst);
            return true;
        }else{
            plog->write("[MAP] Fail to save raw Map : "+_dst);
            return false;
        }
    }
}
bool Supervisor::getLCMConnection(){
    if(probot->ipc_use)
        return ipc->getConnection();
    else
        return lcm->isconnect;
}
bool Supervisor::getLCMRX(){
    if(probot->ipc_use)
        return ipc->flag_rx;
    else
        return lcm->flag_rx;
}
bool Supervisor::getLCMTX(){
    if(probot->ipc_use)
        return ipc->flag_tx;
    else
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
    QString temp;

    if(templist.size() > 5){
        temp = templist[templist.size() - 3] + "/" + templist[templist.size() - 2] + "/" + templist[templist.size()-1];
    }else{
        temp = templist[templist.size() - 2] + "/" + templist[templist.size() - 1];
    }
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
    kk.pop_front();

    QString new_path = QCoreApplication::applicationDirPath();// + "/image/" + kk[kk.length()-1];
    for(int i=0; i<kk.size(); i++){
        new_path += "/" + kk[i];
    }
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

void Supervisor::setMap(QString name){
    setSetting("FLOOR/map_path",QDir::homePath()+"/maps/"+name);
    setSetting("FLOOR/map_name",name);
    setSetting("FLOOR/map_load","true");
    readSetting(name);
    restartSLAM();
//    lcm->restartSLAM();
}

void Supervisor::loadMap(QString name){
    setSetting("FLOOR/map_path",QDir::homePath()+"/maps/"+name);
    setSetting("FLOOR/map_name",name);
    setSetting("FLOOR/map_load","false");
    readSetting(name);
    restartSLAM();
//    readSetting()
}

void Supervisor::restartSLAM(){
    plog->write("[USER INPUT] Restart SLAM");
    if(slam_process != nullptr){
        plog->write("[SUPERVISOR] RESTART SLAM -> PID : "+QString::number(slam_process->pid()));
        if(slam_process->state() == QProcess::NotRunning){
            plog->write("[SUPERVISOR] RESTART SLAM -> NOT RUNNING -> KILL");
            slam_process->kill();
            slam_process->close();
            probot->localization_state = LOCAL_NOT_READY;
            probot->motor_state = MOTOR_NOT_READY;
            probot->status_charge = 0;
            probot->status_emo = 0;
            probot->status_power = 0;
            probot->status_remote = 0;
            QString file = "xterm ./auto_test.sh";
            slam_process->setWorkingDirectory(QDir::homePath());
            slam_process->start(file);
            slam_process->waitForReadyRead(3000);
            lcm->isconnect = false;
            plog->write("[SUPERVISOR] RESTART SLAM -> START SLAM "+QString::number(slam_process->pid()));
        }else if(slam_process->state() == QProcess::Starting){
            plog->write("[SUPERVISOR] RESTART SLAM -> STARTING");
        }else{
            plog->write("[SUPERVISOR] RESTART SLAM -> RUNNING");
            QProcess *tempprocess = new QProcess(this);
            tempprocess->start(QDir::homePath() + "/kill_slam.sh");
            tempprocess->waitForReadyRead(3000);
        }
        probot->localization_state = LOCAL_NOT_READY;
        probot->motor_state = MOTOR_NOT_READY;
        probot->status_charge = 0;
        probot->status_emo = 0;
        probot->status_power = 0;
        probot->status_remote = 0;
        lcm->isconnect = false;
    }else{
        plog->write("[SUPERVISOR] RESTART SLAM -> SLAM PROCESS IS NEW ");
        slam_process = new QProcess(this);
        QString file = "xterm ./auto_test.sh";
        slam_process->setWorkingDirectory(QDir::homePath());
        slam_process->start(file);
        slam_process->waitForReadyRead(3000);
        plog->write("[SUPERVISOR] RESTART SLAM -> START SLAM "+QString::number(slam_process->pid()));
    }
    probot->localization_state = LOCAL_NOT_READY;
    probot->motor_state = MOTOR_NOT_READY;
    probot->status_charge = 0;
    probot->status_emo = 0;
    probot->status_power = 0;
    probot->status_remote = 0;
    lcm->isconnect = false;
    ipc->update();
}

void Supervisor::startSLAM(){
    plog->write("[SUPERVISOR] START SLAM");
    probot->localization_state = LOCAL_NOT_READY;
    probot->motor_state = MOTOR_NOT_READY;
    probot->status_charge = 0;
    probot->status_emo = 0;
    probot->status_power = 0;
    probot->status_remote = 0;
    lcm->isconnect = false;

    slam_process = new QProcess(this);
    QString file = "xterm ./auto_test.sh";
    slam_process->setWorkingDirectory(QDir::homePath());
    slam_process->start(file);
    slam_process->waitForReadyRead(3000);
    ipc->update();
    plog->write("[SUPERVISOR] RESTART SLAM -> START SLAM "+QString::number(slam_process->pid()));
}

////*******************************************  SLAM(LOCALIZATION) 관련   ************************************************////
void Supervisor::startMapping(float grid){
    plog->write("[USER INPUT] START MAPPING");
    pmap->width = getSetting("ROBOT_SW","map_size").toInt();
    pmap->height = getSetting("ROBOT_SW","map_size").toInt();
    pmap->gridwidth = getSetting("ROBOT_SW","grid_size").toFloat();
    pmap->origin[0] = pmap->width/2;
    pmap->origin[1] = pmap->height/2;
    if(probot->ipc_use){
        ipc->startMapping(grid);
        ipc->is_mapping = true;
    }else{
        lcm->startMapping(grid);
        lcm->is_mapping = true;
    }
}
void Supervisor::stopMapping(){
    plog->write("[USER INPUT] STOP MAPPING");
    if(probot->ipc_use){
        ipc->flag_mapping = false;
        ipc->is_mapping = false;
        ipc->stopMapping();
    }else{
        lcm->flagMapping = false;
        lcm->is_mapping = false;
        lcm->sendCommand(ROBOT_CMD_MAPPING_STOP, "MAPPING STOP");
    }
}
void Supervisor::saveMapping(QString name){
    if(probot->ipc_use){
        ipc->saveMapping(name);
    }else{
        lcm->saveMapping(name);
    }
}
void Supervisor::startObjecting(){
    plog->write("[USER INPUT] START OBJECTING");
    if(probot->ipc_use){
        ipc->startObjecting();
        ipc->is_objecting = true;
    }else{
        lcm->startObjecting();
        lcm->is_objecting = true;
    }
}
void Supervisor::stopObjecting(){
    plog->write("[USER INPUT] STOP OBJECTING");
    if(probot->ipc_use){
        ipc->flag_objecting = false;
        ipc->is_objecting = false;
        ipc->stopObjecting();
    }else{
        lcm->flagObjecting = false;
        lcm->is_objecting = false;
        lcm->sendCommand(ROBOT_CMD_OBJECTING_STOP, "OBJECTING STOP");
    }
}
void Supervisor::saveObjecting(){
    if(probot->ipc_use){
        ipc->saveObjecting();
    }else{
        lcm->saveObjecting();
    }
}
void Supervisor::setSLAMMode(int mode){

}
void Supervisor::setInitPos(int x, int y, float th){
    qDebug() << "INIT" << x << y << setAxisBack(cv::Point2f(x,y)).x << setAxisBack(cv::Point2f(x,y)).y;
    pmap->init_pose.point = setAxisBack(cv::Point2f(x,y));
    pmap->init_pose.angle = setAxisBack(th);
    plog->write("[LOCALIZATION] SET INIT POSE : "+QString().sprintf("%f, %f, %f",pmap->init_pose.point.x, pmap->init_pose.point.y, pmap->init_pose.angle));
}
float Supervisor::getInitPoseX(){
    cv::Point2f temp = setAxis(pmap->init_pose.point);
    return temp.x;
}
float Supervisor::getInitPoseY(){
    cv::Point2f temp = setAxis(pmap->init_pose.point);
    return temp.y;
}
float Supervisor::getInitPoseTH(){
    return setAxis(pmap->init_pose.angle);
}
void Supervisor::slam_setInit(){
    plog->write("[SLAM] SLAM SET INIT : "+QString().sprintf("%f, %f, %f",pmap->init_pose.point.x,pmap->init_pose.point.y,pmap->init_pose.angle));
    if(probot->ipc_use){
        ipc->setInitPose(pmap->init_pose.point.x, pmap->init_pose.point.y, pmap->init_pose.angle);
    }else{
        lcm->setInitPose(pmap->init_pose.point.x, pmap->init_pose.point.y, pmap->init_pose.angle);
    }
}
void Supervisor::slam_run(){
    if(probot->ipc_use){
        ipc->set_cmd(ROBOT_CMD_SLAM_RUN, "LOCALIZATION RUN");
    }else{
        lcm->sendCommand(ROBOT_CMD_SLAM_RUN, "LOCALIZATION RUN");
    }
}
void Supervisor::slam_stop(){
    if(probot->ipc_use){
        ipc->set_cmd(ROBOT_CMD_SLAM_STOP, "LOCALIZATION STOP");
    }else{
        lcm->sendCommand(ROBOT_CMD_SLAM_STOP, "LOCALIZATION STOP");
    }
}
void Supervisor::slam_autoInit(){
    if(probot->ipc_use){
        ipc->set_cmd(ROBOT_CMD_SLAM_AUTO, "LOCALIZATION AUTO INIT");
    }else{
        lcm->sendCommand(ROBOT_CMD_SLAM_AUTO, "LOCALIZATION AUTO INIT");
    }
}
bool Supervisor::is_slam_running(){
    if(probot->localization_state == LOCAL_READY){
        return true;
    }else{
        return false;
    }
}
bool Supervisor::getMappingflag(){
    if(probot->ipc_use){
        return ipc->flag_mapping;
    }else{
        return lcm->flagMapping;
    }
}

void Supervisor::setMappingflag(bool flag){
    lcm->flagMapping = flag;
}

bool Supervisor::getObjectingflag(){
    if(probot->ipc_use){
        return ipc->flag_objecting;
    }else{
        return lcm->flagMapping;
    }
}

void Supervisor::setObjectingflag(bool flag){
    lcm->flagObjecting = flag;
    ipc->flag_objecting = flag;
}




#ifdef USE_MINIMAP
QObject *Supervisor::getMinimap(QString filename) const{
    PixmapContainer *pc = new PixmapContainer();

    QString file_path = QDir::homePath()+"/maps/"+filename+"/map_edited.png";
    if(filename == "" || !QFile::exists(file_path)){
        QPixmap blank(pmap->height, pmap->width);{
            QPainter painter(&blank);
            painter.fillRect(blank.rect(),"black");
        }

        pc->pixmap = blank;
        Q_ASSERT(!pc->pixmap.isNull());
        QQmlEngine::setObjectOwnership(pc, QQmlEngine::JavaScriptOwnership);
        return pc;
    }
    cv::Mat map = cv::imread(file_path.toStdString(),cv::IMREAD_GRAYSCALE);
    cv::flip(map,map,0);
    cv::rotate(map,map,cv::ROTATE_90_COUNTERCLOCKWISE);




    plog->write("[MAP] Make Minimap Start : "+filename);
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
            else if(kk > 200)
                pixel = 255;
            else
                pixel = 127;

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
            else if(kk > 200)
                pixel = 255;
            else
                pixel = 127;

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

    cv::cvtColor(minimap, minimap,cv::COLOR_BGR2HSV);
    cv::GaussianBlur(minimap, minimap,cv::Size(3,3),0);
    cv::Scalar lower(0,0,37);
    cv::Scalar upper(0,0,255);
    cv::inRange(minimap,lower,upper,minimap);
    cv::Canny(minimap,minimap,600,600);
    cv::Mat kernel = getStructuringElement(cv::MORPH_RECT, cv::Size(5,5));
    dilate(minimap, minimap, kernel);



    pc->pixmap = QPixmap::fromImage(mat_to_qimage_cpy(minimap));
    Q_ASSERT(!pc->pixmap.isNull());
    QQmlEngine::setObjectOwnership(pc, QQmlEngine::JavaScriptOwnership);
    return pc;
}

#endif


cv::Mat map_test;
//QObject *Supervisor::getTravelRawMap(QString filename) const{
//    PixmapContainer *pc = new PixmapContainer();
//    QString file_path = QDir::homePath()+"/maps/"+filename+"/travel_raw.png";
//    if(filename == "" || !QFile::exists(file_path)){
//        QPixmap blank(pmap->height, pmap->width);{
//            QPainter painter(&blank);
//            painter.fillRect(blank.rect(),"black");
//        }

//        pc->pixmap = blank;
//        Q_ASSERT(!pc->pixmap.isNull());
//        QQmlEngine::setObjectOwnership(pc, QQmlEngine::JavaScriptOwnership);
//        return pc;
//    }

//    cv::Mat map = cv::imread(file_path.toStdString(),cv::IMREAD_GRAYSCALE);
//    cv::flip(map,map,0);
//    cv::rotate(map,map,cv::ROTATE_90_COUNTERCLOCKWISE);

//    cv::Mat rot = cv::getRotationMatrix2D(cv::Point2f(map.cols/2, map.rows/2),-map_rotate_angle, 1.0);
//    cv::warpAffine(map,map,rot,map.size(),cv::INTER_NEAREST);

//    cv::Mat argb_map(map.rows, map.cols, CV_8UC4, cv::Scalar::all(0));
//    for(int i = 0; i < map.rows; i++)
//    {
//        for(int j = 0; j < map.cols; j++)
//        {
//            if(map.ptr<uchar>(i)[j] == 255)
//            {
//                argb_map.ptr<cv::Vec4b>(i)[j] = cv::Vec4b(0,0,255,255);
//            }
//        }
//    }
//    map_test = argb_map;

//    pc->pixmap = QPixmap::fromImage(mat_to_qimage_cpy(map_test));
//    Q_ASSERT(!pc->pixmap.isNull());
//    QQmlEngine::setObjectOwnership(pc, QQmlEngine::JavaScriptOwnership);
//    return pc;
//}

//QObject *Supervisor::getTravel(QList<int> canvas) const{
//    PixmapContainer *pc = new PixmapContainer();
//    cv::Mat argb_map;
//    map_test.copyTo(argb_map);

//    for(int i=0; i<canvas.size(); i++){
//        if(canvas[i] == 255){
//            argb_map.ptr<cv::Vec4b>(i/pmap->height)[i%pmap->width] = cv::Vec4b(0,0,255,255);
//        }else if(canvas[i] == 100){
//            argb_map.ptr<cv::Vec4b>(i/pmap->height)[i%pmap->width] = cv::Vec4b(0,0,0,0);
//        }
//    }
//    pc->pixmap = QPixmap::fromImage(mat_to_qimage_cpy(argb_map));
//    Q_ASSERT(!pc->pixmap.isNull());
//    QQmlEngine::setObjectOwnership(pc, QQmlEngine::JavaScriptOwnership);
//    return pc;
//}

QString Supervisor::getnewMapname(){
    int max_num = -1;
    for(int i=0; i<getAvailableMap(); i++){
        QStringList name = map_list[i].split("_");
        if(name.size() > 1 && name[0] == "map"){
            if(name[1].toInt() > max_num){
                max_num = name[1].toInt();
            }
        }
    }
    if(max_num == -1){
        return "map_0";
    }else{
        return "map_"+QString::number(max_num+1);
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
void Supervisor::setObjPose(){
    pmap->list_obj_dR.clear();
    pmap->list_obj_uL.clear();
    for(int i=0; i<pmap->objects.size(); i++){
        cv::Point2f temp_uL;
        cv::Point2f temp_dR;
        //Find Square Pos
        temp_uL.x = pmap->objects[i].points[0].x;
        temp_uL.y = pmap->objects[i].points[0].y;
        temp_dR.x = pmap->objects[i].points[0].x;
        temp_dR.y = pmap->objects[i].points[0].y;
        for(int j=1; j<pmap->objects[i].points.size(); j++){
            if(temp_uL.x > pmap->objects[i].points[j].x){
                temp_uL.x = pmap->objects[i].points[j].x;
            }
            if(temp_uL.y > pmap->objects[i].points[j].y){
                temp_uL.y = pmap->objects[i].points[j].y;
            }
            if(temp_dR.x < pmap->objects[i].points[j].x){
                temp_dR.x = pmap->objects[i].points[j].x;
            }
            if(temp_dR.y < pmap->objects[i].points[j].y){
                temp_dR.y = pmap->objects[i].points[j].y;
            }
        }
        pmap->list_obj_dR.push_back(temp_uL);
        pmap->list_obj_uL.push_back(temp_dR);
    }
}
int Supervisor::getLocationNum(){
    return pmap->locations.size();
}
int Supervisor::getLocationSize(QString type){
    int count = -1;
    for(int i=0; i<pmap->locations.size(); i++){
        if(pmap->locations[i].type == type){
            QStringList namelist = pmap->locations[i].name.split("_");
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
    if(num > -1 && num < pmap->locations.size()){
        return pmap->locations[num].name;
    }
    return "";
}
QString Supervisor::getLocationTypes(int num){
    if(num > -1 && num < pmap->locations.size()){
        return pmap->locations[num].type;
    }
    return "";
}
float Supervisor::getRestingLocationx(){
    for(int i=0; i<pmap->locations.size(); i++){
        if(pmap->locations[i].type == "Resting"){

            return setAxis(pmap->locations[i].point).x;
        }
    }
    return 0.;
}
float Supervisor::getRestingLocationy(){
    for(int i=0; i<pmap->locations.size(); i++){
        if(pmap->locations[i].type == "Resting"){

            return setAxis(pmap->locations[i].point).y;
        }
    }
    return 0.;
}
float Supervisor::getRestingLocationth(){
    for(int i=0; i<pmap->locations.size(); i++){
        if(pmap->locations[i].type == "Resting"){

            return setAxis(pmap->locations[i].angle);
        }
    }
    return 0.;
}
float Supervisor::getLocationx(int num){
    if(num > -1 && num < pmap->locations.size()){
        return setAxis(pmap->locations[num].point).x;
    }
    return 0.;
}
float Supervisor::getLocationy(int num){
    if(num > -1 && num < pmap->locations.size()){
        return setAxis(pmap->locations[num].point).y;
    }
    return 0.;
}
float Supervisor::getLocationth(int num){
    if(num > -1 && num < pmap->locations.size()){
        return setAxis(pmap->locations[num].angle);
    }
    return 0.;
}
bool Supervisor::isExistLocation(int num){
    for(int i=0; i<pmap->locations.size(); i++){
        if(pmap->locations[i].name.split("_").size() > 1 && pmap->locations[i].name.split("_")[0] == "Serving"){
            if(pmap->locations[i].name.split("_")[1].toInt() == num){
                return true;
            }
        }
    }
    return false;
}
float Supervisor::getLidar(int num){
    return probot->lidar_data[num];
}

float setAxis(float _angle){
    return -_angle - M_PI/2;
}
float setAxisBack(float _angle){
    return -_angle - M_PI/2;
}
cv::Point2f setAxis(cv::Point2f _point){
    cv::Point2f temp;
    temp.x = -_point.y/pmap->gridwidth + pmap->origin[1];
    temp.y = -_point.x/pmap->gridwidth + pmap->origin[0];
    return temp;
}
cv::Point2f setAxisBack(cv::Point2f _point){
    cv::Point2f temp;
    temp.x = -pmap->gridwidth*(_point.y-pmap->origin[1]);
    temp.y = -pmap->gridwidth*(_point.x-pmap->origin[0]);
    qDebug() << _point.y << temp.x << pmap->gridwidth << pmap->origin[1];
    return temp;
}
POSE setAxis(POSE _pose){
    POSE temp;
    temp.point = setAxis(_pose.point);
    temp.angle = setAxis(_pose.angle);
    return temp;
}

POSE setAxisBack(POSE _pose){
    POSE temp;
    temp.point = setAxisBack(_pose.point);
    temp.angle = setAxisBack(_pose.angle);
    return temp;
}
POSE setAxis(cv::Point2f _point, float _angle){
    POSE temp;
    temp.point = setAxis(_point);
    temp.angle = setAxis(_angle);
    return temp;
}
POSE setAxisBack(cv::Point2f _point, float _angle){
    POSE temp;
    temp.point = setAxisBack(_point);
    temp.angle = setAxisBack(_angle);
    return temp;
}

int Supervisor::getObjectNum(){
    return pmap->objects.size();
}
QString Supervisor::getObjectName(int num){
    int count = 0;
    if(num > -1 && num < pmap->objects.size()){
        for(int i=0; i<num; i++){
            if(pmap->objects[i].type == pmap->objects[num].type){
                count++;
            }
        }
        return pmap->objects[num].type + "_" + QString::number(count);
    }
}
int Supervisor::getObjectPointSize(int num){
    return pmap->objects[num].points.size();
}
float Supervisor::getObjectX(int num, int point){
    if(num > -1 && num < pmap->objects.size()){
        if(point > -1 && point < pmap->objects[num].points.size()){
            return setAxis(pmap->objects[num].points[point]).x;
        }
    }
    return 0;
}
float Supervisor::getObjectY(int num, int point){
    if(num > -1 && num < pmap->objects.size()){
        if(point > -1 && point < pmap->objects[num].points.size()){
            return setAxis(pmap->objects[num].points[point]).y;
        }
    }
    return 0;
}

bool Supervisor::getAnnotEditFlag(){
    return annotation_edit;
}
void Supervisor::setAnnotEditFlag(bool flag){
    annotation_edit = flag;
}

int Supervisor::getObjPointNum(int obj_num, int x, int y){
    //NEED DEBUG
    cv::Point2f pos = setAxisBack(cv::Point2f(x,y));
    if(obj_num < pmap->objects.size() && obj_num > -1){
        qDebug() << "check obj" << obj_num << pmap->objects[obj_num].points.size();
        if(obj_num != -1){
            for(int j=0; j<pmap->objects[obj_num].points.size(); j++){
                qDebug() << pmap->objects[obj_num].points[j].x << pmap->objects[obj_num].points[j].y;
                if(fabs(pmap->objects[obj_num].points[j].x - pos.x) < 0.1){
                    if(fabs(pmap->objects[obj_num].points[j].y - pos.y) < 0.1){
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
    for(int i=0; i<pmap->locations.size(); i++){
        if(pmap->locations[i].name == name){
            return i;
        }
    }
    return -1;
}
int Supervisor::getLocNum(int x, int y){
    for(int i=0; i<pmap->locations.size(); i++){
        cv::Point2f pos = setAxisBack(cv::Point2f(x,y));
        if(fabs(pmap->locations[i].point.x - pos.x) < probot->radius){
            if(fabs(pmap->locations[i].point.y - pos.y) < probot->radius){
                return i;
            }
        }
    }
    return -1;
}

void Supervisor::removeLocation(QString name){
    annotation_edit = true;
//    clear_all();
    for(int i=0; i<pmap->locations.size(); i++){
        if(pmap->locations[i].name == name){
            plog->write("[UI-MAP] REMOVE LOCATION "+ name);
            pmap->locations.remove(i);
            QMetaObject::invokeMethod(mMain, "updatelocation");
            return;
        }
    }
    plog->write("[UI-MAP] REMOVE OBJECT BUT FAILED "+ name);
}

int Supervisor::getObjectSize(QString type){
    int size = 0;
    for(int i=0; i<pmap->objects.size(); i++){
        if(pmap->objects[i].type == type)
            size++;
    }
    return size;
}

void Supervisor::removeObject(int num){
    annotation_edit = true;
//    clear_all();
    if(num > -1 && num < pmap->objects.size()){
        pmap->objects.remove(num);
        setObjPose();
        QMetaObject::invokeMethod(mMain, "updateobject");
        plog->write("[ANNOTATION - ERROR] removeObject " + QString().sprintf("(%d)",num));
    }else{
        plog->write("[ANNOTATION - ERROR] removeObject " + QString().sprintf("(%d)",num) + " but size error");
    }
}

bool Supervisor::saveAnnotation(QString filename){
    plog->write("[SUPERVISOR] SAVE Annotation "+filename);
    //기존 파일 백업
    QString backup = QDir::homePath()+"/maps/"+filename+"/annotation_backup.ini";
    QString origin = getAnnotPath(filename);
    if(QFile::exists(origin) == true){
        if(QFile::copy(origin, backup)){
            plog->write("[DEBUG] Copy annotation.ini to annotation_backup.ini");
        }else{
            plog->write("[DEBUG] Fail to copy annotation.ini to annotation_backup.ini");
        }
    }else{
        plog->write("[DEBUG] Fail to copy annotation.ini to annotation_backup.ini (No file found)");
    }

    qDebug() << getAnnotPath(filename);
    //데이터 입력(로케이션)
    int other_num = 0;
    int resting_num = 0;
    int charging_num = 0;
    int serving_num = 0;
    QString str_name;
    QSettings settings(getAnnotPath(filename), QSettings::IniFormat);
    settings.clear();
    for(int i=0; i<pmap->locations.size(); i++){
        if(pmap->locations[i].type == "Resting"){
            str_name = pmap->locations[i].name + QString().sprintf(",%f,%f,%f",pmap->locations[i].point.x,pmap->locations[i].point.y,pmap->locations[i].angle);
            settings.setValue("resting_locations/loc"+QString::number(resting_num),str_name);
            resting_num++;
        }else if(pmap->locations[i].type == "Other"){
            str_name = pmap->locations[i].name + QString().sprintf(",%f,%f,%f",pmap->locations[i].point.x,pmap->locations[i].point.y,pmap->locations[i].angle);
            settings.setValue("other_locations/loc"+QString::number(other_num),str_name);
            other_num++;
        }else if(pmap->locations[i].type == "Serving"){
            str_name = pmap->locations[i].name + QString().sprintf(",%f,%f,%f",pmap->locations[i].point.x,pmap->locations[i].point.y,pmap->locations[i].angle);
            settings.setValue("serving_locations/loc"+QString::number(serving_num),str_name);
            serving_num++;
        }else if(pmap->locations[i].type == "Charging"){
            str_name = pmap->locations[i].name + QString().sprintf(",%f,%f,%f",pmap->locations[i].point.x,pmap->locations[i].point.y,pmap->locations[i].angle);
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
    for(int i=0; i<pmap->objects.size(); i++){
        qDebug() << pmap->objects.size() << pmap->objects[i].type << pmap->objects[i].is_rect;
        if(pmap->objects[i].type == "Table"){
            str_name = pmap->objects[i].type + "_" + QString::number(table_num++);
        }else if(pmap->objects[i].type == "Chair"){
            str_name = pmap->objects[i].type + "_" + QString::number(chair_num++);
        }else if(pmap->objects[i].type == "Wall"){
            str_name = pmap->objects[i].type + "_" + QString::number(wall_num++);
        }else{
            str_name = pmap->objects[i].type;
        }

        if(pmap->objects[i].is_rect){
            str_name += ",1";
        }else{
            str_name += ",0";
        }

        for(int j=0; j<pmap->objects[i].points.size(); j++){
            str_name += QString().sprintf(",%f:%f",pmap->objects[i].points[j].x, pmap->objects[i].points[j].y);
        }
        settings.setValue("objects/poly"+QString::number(i),str_name);
    }
    settings.setValue("objects/num",pmap->objects.size());

    readSetting(filename);
    restartSLAM();
//    lcm->restartSLAM();
    annotation_edit = false;
    return true;
}
void Supervisor::sendMaptoServer(){
    server->sendMap(pmap->map_name);
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
    if(probot->ipc_use){
        ipc->moveTo(target_num);
    }else{
        lcm->moveTo(target_num);
    }
}
void Supervisor::moveToLast(){
    if(probot->ipc_use){
//        ipc->moveTo(target_num);
    }else{
        lcm->moveToLast();
    }
}
void Supervisor::moveTo(float x, float y, float th){
    if(probot->ipc_use){
//        ipc->moveTo(target_num);
    }else{
        lcm->moveToLast();
    }
    lcm->moveTo(x,y,th);
}
void Supervisor::movePause(){
    if(probot->ipc_use){
        ipc->movePause();
    }else{
        lcm->movePause();
    }
}
void Supervisor::moveResume(){
    if(probot->ipc_use){
        ipc->moveResume();
    }else{
        lcm->moveResume();
    }
}
void Supervisor::moveStop(){
    if(probot->ipc_use){
        ipc->moveStop();
    }else{
        lcm->moveStop();
    }
    ui_cmd = UI_CMD_NONE;
    ui_state = UI_STATE_INIT_DONE;
    isaccepted = false;
    QMetaObject::invokeMethod(mMain, "movestopped");
}
void Supervisor::moveManual(){
    if(probot->ipc_use){
        ipc->moveManual();
    }else{
        lcm->moveManual();
    }
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
void Supervisor::joyMoveXY(float x){
    probot->joystick[0] = x;
    lcm->flagJoystick = true;
    ipc->flag_joystick = true;
}
void Supervisor::joyMoveR(float r){
    probot->joystick[1] = r;
    lcm->flagJoystick = true;
    ipc->flag_joystick = true;
}
float Supervisor::getJoyXY(){
    return probot->joystick[0];
}
float Supervisor::getJoyR(){
    return probot->joystick[1];
}

void Supervisor::resetHomeFolders(){
    plog->write("[USER INPUT] RESET HOME FOLDERS");

    QDir lcm_orin(QGuiApplication::applicationDirPath() + "/lcm_types");
    QDir lcm_target(QDir::homePath() + "/lcm_types");

    qDebug() <<QGuiApplication::applicationDirPath() + "/lcm_types";
    qDebug() <<QDir::homePath() + "/lcm_types";
    if(lcm_orin.exists()){
        if(!lcm_target.exists()){
            plog->write("[SUPERVISOR] MAKE LCM_TYPES FOLDER INTO HOME");
            lcm_target.mkpath(".");
        }

        QStringList files = lcm_orin.entryList(QDir::Files);
        for(int i=0; i<files.count(); i++){
            qDebug() << QGuiApplication::applicationDirPath() + "/lcm_types/" + files[i];
            qDebug() << QDir::homePath() + "/lcm_types/" + files[i];
            QFile::copy(QGuiApplication::applicationDirPath() + "/lcm_types/" + files[i],
                        QDir::homePath() + "/lcm_types/" + files[i]);
            plog->write("[SUPERVISOR] COPY LCM_TYPES : " + files[i]);
        }
        files.clear();
    }
}


////*********************************************  ROBOT STATUS 관련   ***************************************************////
float Supervisor::getBattery(){
    return probot->battery;
}
bool Supervisor::getMotorConnection(int id){
    return probot->motor[id].connection;
}
int Supervisor::getMotorStatus(int id){
    return probot->motor[id].status;
}
QString Supervisor::getMotorStatusStr(int id){
    if(probot->motor[id].status == 0){
        return " ";
    }else{
        QString str = "";
        if(MOTOR_RUN(probot->motor[id].status) == 1)
            str += "RUN";

        if(MOTOR_MOD_ERROR(probot->motor[id].status) == 1)
            str += " MOD";

        if(MOTOR_JAM_ERROR(probot->motor[id].status) == 1)
            str += " JAM";

        if(MOTOR_CUR_ERROR(probot->motor[id].status) == 1)
            str += " CUR";

        if(MOTOR_BIG_ERROR(probot->motor[id].status) == 1)
            str += " BIG";

        if(MOTOR_INP_ERROR(probot->motor[id].status) == 1)
            str += " INP";

        if(MOTOR_PS_ERROR(probot->motor[id].status) == 1)
            str += " PS";

        if(MOTOR_COL_ERROR(probot->motor[id].status) == 1)
            str += " COL";

        return str;
    }
}
int Supervisor::getMotorTemperature(int id){
    return probot->motor[id].temperature;
}
int Supervisor::getMotorInsideTemperature(int id){
    return probot->motor[id].motor_temp;
}
int Supervisor::getMotorWarningTemperature(){
    return 50;
}
int Supervisor::getMotorCurrent(int id){
    return probot->motor[id].current;
}
int Supervisor::getPowerStatus(){
    return probot->status_power;
}
int Supervisor::getRemoteStatus(){
    return probot->status_remote;
}
int Supervisor::getChargeStatus(){
    return probot->status_charge;
}
int Supervisor::getEmoStatus(){
    return probot->status_emo;
}
float Supervisor::getBatteryIn(){
    return probot->battery_in;
}
float Supervisor::getBatteryOut(){
    return probot->battery_out;
}
float Supervisor::getBatteryCurrent(){
    return probot->battery_cur;
}
float Supervisor::getPower(){
    return probot->power;
}
float Supervisor::getPowerTotal(){
    return probot->total_power;
}
int Supervisor::getMotorState(){
    return probot->motor_state;
}
int Supervisor::getObsState(){
    return probot->obs_state;
}
int Supervisor::getLocalizationState(){
    return probot->localization_state;
}
int Supervisor::getStateMoving(){
    return probot->running_state;
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

float Supervisor::getRobotRadius(){
    return probot->radius;
}
float Supervisor::getRobotx(){
    POSE temp = setAxis(probot->curPose);
    return temp.point.x;
}
float Supervisor::getRoboty(){
    POSE temp = setAxis(probot->curPose);
    return temp.point.y;
}
float Supervisor::getRobotth(){
    POSE temp = setAxis(probot->curPose);
    return temp.angle;
}
float Supervisor::getlastRobotx(){
    POSE temp = setAxis(probot->lastPose);
    return temp.point.x;
}
float Supervisor::getlastRoboty(){
    POSE temp = setAxis(probot->lastPose);
    return temp.point.y;
}
float Supervisor::getlastRobotth(){
    POSE temp = setAxis(probot->lastPose);
    return temp.angle;
}
int Supervisor::getPathNum(){
    if(ipc->flag_path || lcm->flagPath){
        return 0;
    }else{
        return probot->pathSize;
    }
}
float Supervisor::getPathx(int num){
    if(ipc->flag_path || lcm->flagPath){
        return 0;
    }else{
        POSE temp = setAxis(probot->curPath[num]);
        return temp.point.x;
    }
}
float Supervisor::getPathy(int num){
    if(ipc->flag_path || lcm->flagPath){
        return 0;
    }else{
        POSE temp = setAxis(probot->curPath[num]);
        return temp.point.y;
    }
}
float Supervisor::getPathth(int num){
    if(ipc->flag_path || lcm->flagPath){
        return 0;
    }else{
        POSE temp = setAxis(probot->curPath[num]);
        return temp.angle;
    }
}
int Supervisor::getLocalPathNum(){
    return probot->localpathSize;

}
float Supervisor::getLocalPathx(int num){
    POSE temp = setAxis(probot->localPath[num]);
    return temp.point.x;

}
float Supervisor::getLocalPathy(int num){
    POSE temp = setAxis(probot->localPath[num]);
    return temp.point.y;
}

int Supervisor::getuistate(){
    return ui_state;
}

void Supervisor::initdone(){
    plog->write("[INIT] INIT DONE : UI_STATE -> INIT DONE");
    ui_state = UI_STATE_INIT_DONE;
}


////*********************************************  MAP IMAGE 관련   ***************************************************////
QString Supervisor::getMapname(){
    return pmap->map_name;
}
QString Supervisor::getMappath(){
    return pmap->map_path;
}
QString Supervisor::getServerMappath(){
    return QDir::homePath() + "/maps/"+server->server_map_name;
}
QString Supervisor::getServerMapname(){
    return server->server_map_name;
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

////*********************************************  PATROL 관련   ***************************************************////

#ifdef PATROL_USE
QString Supervisor::getPatrolFileName(){
    if(patrol.filename == ""){
        return patrol.filename;
    }else{
        QFile *file  = new QFile(patrol.filename);
        if(file->open(QIODevice::ReadOnly)){

            QStringList namelist = patrol.filename.split("/");
            QStringList name = namelist[namelist.size()-1].split(".");
            return name[0];
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
//    QStringList list1 = path.split("/");
//    QStringList list = list1[list1.size()-1].split(".");
//    if(list.size() == 1){
//        path = QDir::homePath()+"/patrols/" + list1[list1.size()-1] + ".ini";
//    }else{
//        path = QDir::homePath()+"/patrols/" + list1[list1.size()-1];
//    }
//    plog->write("[USER INPUT] Load Patrol : "+path);
//    QSettings patrols(path, QSettings::IniFormat);
//    patrol.path.clear();
//    patrol.filename = path;
//    ST_PATROL temp;
//    patrols.beginGroup("PATH");
//    int num = patrols.value("num").toInt();
//    patrol.mode = patrols.value("mode").toInt();
//    for(int i=0; i<num; i++){
//        temp.type = patrols.value("type_"+QString::number(i)).toString();
//        temp.location = patrols.value("location_"+QString::number(i)).toString();
//        temp.pose.x = patrols.value("x_"+QString::number(i)).toFloat();
//        temp.pose.y = patrols.value("y_"+QString::number(i)).toFloat();
//        temp.pose.th = patrols.value("th_"+QString::number(i)).toFloat();
//        patrol.path.push_back(temp);
//    }
//    patrols.endGroup();
//    setSetting("PATROL/curfile",path);
}
void Supervisor::savePatrolFile(QString path){
//    QStringList list1 = path.split("/");
//    QStringList list = list1[list1.size()-1].split(".");
//    if(list.size() == 1){
//        path = QDir::homePath()+"/patrols/" + list1[list1.size()-1] + ".ini";
//    }else{
//        path = QDir::homePath()+"/patrols/" + list1[list1.size()-1];
//    }
//    plog->write("[USER INPUT] Save Patrol : "+path);
//    QSettings patrols(path, QSettings::IniFormat);
//    patrols.clear();
//    for(int i=0; i<patrol.path.size(); i++){
//        patrols.setValue("PATH/type_"+QString::number(i),patrol.path[i].type);
//        patrols.setValue("PATH/location_"+QString::number(i),patrol.path[i].location);
//        patrols.setValue("PATH/x_"+QString::number(i),QString::number(patrol.path[i].pose.x));
//        patrols.setValue("PATH/y_"+QString::number(i),QString::number(patrol.path[i].pose.y));
//        patrols.setValue("PATH/th_"+QString::number(i),QString::number(patrol.path[i].pose.th));
//    }
//    patrols.setValue("PATH/num",patrol.path.size());
//    patrols.setValue("PATH/mode",QString::number(patrol.mode));

//    setSetting("PATROL/curfile",path);
}
void Supervisor::addPatrol(QString type, QString location, float x, float y, float th){
    ST_PATROL temp;

    temp.type = type;
    temp.location = location;
    qDebug() << type << location;

    if(temp.location == "MANUAL"){
        cv::Point2f temp1 = canvasTomap(x,y);
        temp.pose.x = temp1.x;
        temp.pose.y = temp1.y;
        temp.pose.th = th;
        patrol.path.push_back(temp);
        plog->write("[USER INPUT] Add Patrol Pose : "+QString().sprintf("%f, %f, %f",temp.pose.x, temp.pose.y, temp.pose.th));
    }else{
        for(int i=0; i<pmap->locations.size(); i++){
            if(pmap->locations[i].name == temp.location){
                temp.pose.x = pmap->locations[i].pose.x;
                temp.pose.y = pmap->locations[i].pose.y;
                temp.pose.th = pmap->locations[i].pose.th;
                patrol.path.push_back(temp);
                plog->write("[USER INPUT] Add Patrol Location : "+location);
                break;
            }
        }
    }
}
void Supervisor::removePatrol(int num){
    clear_all();
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
//    if(num > -1 && num < patrol.path.size()){
//        ST_POSE temp = setAxis(patrol.path[num].pose);
//        return temp.y;
//    }else{
//        return 0;
//    }
}
float Supervisor::getPatrolTH(int num){
//    if(num > -1 && num < patrol.path.size()){
//        ST_POSE temp = setAxis(patrol.path[num].pose);
//        return temp.th;
//    }else{
//        return 0;
//    }
}
#endif


void Supervisor::runRotateTables(){
    plog->write("[USER INPUT] START ROTATE TABLES");
    ui_cmd = UI_CMD_TABLE_PATROL;
    state_rotate_tables = 1;
}
void Supervisor::stopRotateTables(){
    plog->write("[USER INPUT] STOP ROTATE TABLES");
    ui_cmd = UI_CMD_PATROL_STOP;
}
void Supervisor::startServingTest(){
    plog->write("[USER INPUT] START PATROL SERVING");
    ui_cmd = UI_CMD_MOVE_TABLE;
    flag_patrol_serving = true;
}
void Supervisor::stopServingTest(){
    plog->write("[USER INPUT] STOP PATROL SERVING");
    flag_patrol_serving = false;
    moveStop();
}


//// *********************************** SLOTS *********************************** ////
void Supervisor::server_cmd_setini(){
    readSetting();
}
void Supervisor::server_get_map(){
    readSetting(server->server_map_name);
    QMetaObject::invokeMethod(mMain, "loadmap_server_success");
}
void Supervisor::path_changed(){
    QMetaObject::invokeMethod(mMain, "updatepath");
}
void Supervisor::camera_update(){
    qDebug() << "camera_update";
    QMetaObject::invokeMethod(mMain, "updatecamera");
}
void Supervisor::mapping_update(){
    QMetaObject::invokeMethod(mMain, "updatemapping");
}
void Supervisor::objecting_update(){
    QMetaObject::invokeMethod(mMain, "updateobjecting");
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
//    plog->write("[SERVER] NEW TARGET !!" + QString().sprintf("%f, %f, %f",probot->targetPose.x, probot->targetPose.y, probot->targetPose.th));
    if(ui_state == UI_STATE_PATROLLING)
        state_rotate_tables = 4;
}
void Supervisor::server_cmd_newcall(){
    ui_cmd = UI_CMD_MOVE_CALLING;
//    QMetaObject::invokeMethod(mMain,"newcall");
}

void Supervisor::checkShellFiles(){
//파일확인!
    QString file_path;

    //auto_test.sh
    file_path = QDir::homePath() + "/auto_test.sh";
    if(!QFile::exists(file_path)){
        plog->write("[SUPERVISOR] auto_test.sh not found. make new");
        makeStartShell();
    }

    //kill_slam.sh
    file_path = QDir::homePath() + "/kill_slam.sh";
    if(!QFile::exists(file_path)){
        plog->write("[SUPERVISOR] kill_slam.sh not found. make new");
        makeKillShell();
    }

    //auto_kill.sh
    file_path = QDir::homePath() + "/auto_kill.sh";
    if(!QFile::exists(file_path)){
        plog->write("[SUPERVISOR] auto_kill.sh not found. make new");
        makeAllKillShell();
    }

    //auto_reset.sh
    file_path = QDir::homePath() + "/auto_reset.sh";
    if(!QFile::exists(file_path)){
        plog->write("[SUPERVISOR] auto_reset.sh not found. make new");
        makeKillSlam();
    }
    QString path = QDir::homePath()+"/ui_log";
    QDir directory(path);
    if(!directory.exists()){
        directory.mkpath(".");
    }
}
void Supervisor::makeKillShell(){
    //Make kill_slam.sh
    QString file_name = QDir::homePath() + "/kill_slam.sh";
    QFile file(file_name);
    if(file.open(QIODevice::ReadWrite)){
        QTextStream stream(&file);
        stream << "#!/bin/bash" << endl << endl;
        stream << "pid=`ps -ef | grep \"SLAMNAV\" | grep -v 'grep' | awk '{print $2}'`"<<endl;
        stream << "if [ -z $pid ]" << endl;
        stream << "then" << endl;
        stream << "     echo \"SLAMNAV is not running\"" << endl;
        stream << "else" << endl;
        stream << "     kill -9 $pid" << endl;
        stream << "fi" << endl;
    }
    file.close();
    //Chmod
    QProcess process;
    process.setWorkingDirectory(QDir::homePath());
    process.start("chmod +x kill_slam.sh");
    process.waitForReadyRead(200);
}
void Supervisor::makeKillSlam(){
    //Make kill_slam.sh
    QString file_name = QDir::homePath() + "/auto_reset.sh";
    QFile file(file_name);
    if(file.open(QIODevice::ReadWrite)){
        QTextStream stream(&file);
        stream << "#!/bin/bash" << endl << endl;
        stream << "pid=`ps -ef | grep \"auto_test.sh\" | grep -v 'grep' | awk '{print $2}'`"<<endl;
        stream << "if [ -z $pid ]" << endl;
        stream << "then" << endl;
        stream << "     echo \"auto_test.sh is not running\"" << endl;
        stream << "else" << endl;
        stream << "     kill -9 $pid" << endl;
        stream << "fi" << endl;

        stream << "pid=`ps -ef | grep \"SLAMNAV\" | grep -v 'grep' | awk '{print $2}'`"<<endl;
        stream << "if [ -z $pid ]" << endl;
        stream << "then" << endl;
        stream << "     echo \"SLAMNAV is not running\"" << endl;
        stream << "else" << endl;
        stream << "     kill -9 $pid" << endl;
        stream << "fi" << endl;
    }
    file.close();
    //Chmod
    QProcess process;
    process.setWorkingDirectory(QDir::homePath());
    process.start("chmod +x auto_reset.sh");
    process.waitForReadyRead(200);

}
void Supervisor::makeStartShell(){
    //Make kill_slam.sh
    QString file_name = QDir::homePath() + "/auto_test.sh";
    QFile file(file_name);
    if(file.open(QIODevice::ReadWrite)){
        QTextStream stream(&file);
        stream << "#!/bin/bash" << endl << endl;
        stream << "while [ 1 ]"<<endl;
        stream << "do"<<endl;
        stream << "     pid=`ps -ef | grep \"SLAMNAV\" | grep -v 'grep' | awk '{print $2}'`"<<endl;
        stream << "     if [ -z $pid ]" << endl;
        stream << "     then" << endl;
        stream << "         /home/odroid/code/build-SLAMNAV-Desktop-Release/SLAMNAV" << endl;
        stream << "     else" << endl;
        stream << "         kill -9 $pid" << endl;
        stream << "         /home/odroid/code/build-SLAMNAV-Desktop-Release/SLAMNAV" << endl;
        stream << "     fi" << endl;
        stream << "done" << endl;
    }
    file.close();
    //Chmod
    QProcess process;
    process.setWorkingDirectory(QDir::homePath());
    process.start("chmod +x auto_test.sh");
    process.waitForReadyRead(200);

}
void Supervisor::makeAllKillShell(){
    //Make kill_slam.sh
    QString file_name = QDir::homePath() + "/auto_kill.sh";
    QFile file(file_name);
    if(file.open(QIODevice::ReadWrite)){
        QTextStream stream(&file);
        stream << "#!/bin/bash" << endl << endl;

        stream << "pid=`ps -ef | grep \"MAIN_MOBILE\" | grep -v 'grep' | awk '{print $2}'`"<<endl;
        stream << "if [ -z $pid ]" << endl;
        stream << "then" << endl;
        stream << "     echo \"MAIN_MOBILE is not running\"" << endl;
        stream << "else" << endl;
        stream << "     kill -9 $pid" << endl;
        stream << "fi" << endl;

        stream << "pid=`ps -ef | grep \"auto_test.sh\" | grep -v 'grep' | awk '{print $2}'`"<<endl;
        stream << "if [ -z $pid ]" << endl;
        stream << "then" << endl;
        stream << "     echo \"auto_test.sh is not running\"" << endl;
        stream << "else" << endl;
        stream << "     kill -9 $pid" << endl;
        stream << "fi" << endl;

        stream << "pid=`ps -ef | grep \"SLAMNAV\" | grep -v 'grep' | awk '{print $2}'`"<<endl;
        stream << "if [ -z $pid ]" << endl;
        stream << "then" << endl;
        stream << "     echo \"SLAMNAV is not running\"" << endl;
        stream << "else" << endl;
        stream << "     kill -9 $pid" << endl;
        stream << "fi" << endl;
    }
    file.close();
    //Chmod
    QProcess process;
    process.setWorkingDirectory(QDir::homePath());
    process.start("chmod +x auto_kill.sh");
    process.waitForReadyRead(200);
}

//// *********************************** TIMER *********************************** ////
void Supervisor::onTimer(){
    // QML 오브젝트 매칭
    if(mMain == nullptr && object != nullptr){
        setObject(object);
        setWindow(qobject_cast<QQuickWindow*>(object));
    }

    static int count_pass = 0;
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
                    if(FilesList2[j] == "maps"){
                        QString path_folder = path_usb+"/"+FilesList2[j];
                        QDir directory2(path_folder);
                        QStringList FilesList3 = directory2.entryList();
                        for(int k=0; k<FilesList3.size(); k++){
                            usb_map_list.push_back(path_folder +  "/" + FilesList3[k]);
                        }
                    }else if(FilesList2[j] == "lcm_types"){
                        usb_map_list.push_back(path_usb +  "/" + FilesList2[j]);
                    }else if(FilesList2[j] == "robot_config.ini"){
                        usb_map_list.push_back(path_usb +  "/" + FilesList2[j]);
                    }else if(FilesList2[j] == "auto_test.sh"){
                        usb_map_list.push_back(path_usb +  "/" + FilesList2[j]);
                    }else if(FilesList2[j] == "kill_slam.sh"){
                        usb_map_list.push_back(path_usb +  "/" + FilesList2[j]);
                    }else if(FilesList2[j] == "auto_kill.sh"){
                        usb_map_list.push_back(path_usb +  "/" + FilesList2[j]);
                    }
                }
            }

            if(usb_map_list.size() > 0){
                for(int i=0; i<usb_map_list.size(); i++){
                    plog->write("[SUPERVISOR] USB Detected : "+usb_map_list[i]);
                }
                usb_check = false;
                usb_check_count = 0;
            }
        }
    }
    // 스케줄러 변수 초기화
    static int prev_error = -1;
    static int prev_state = -1;
    static int prev_running_state = -1;
    static int prev_motor_state = -1;
    static int prev_local_state = -1;

    static int state_count = 0;
    static int table_num_last = 0;
    static bool is_set = false;
    static int table_num = -1;
    static int count_moveto = 0;
    // move start
    static int timer_cnt = 0;

    probot->lcmconnection = lcm->isconnect;
    if(probot->ipc_use){
        if(ipc->getConnection()){
            if(ui_state != UI_STATE_NONE){
                state_count = 0;
                if(probot->status_charge == 1){
                    if(ui_state != UI_STATE_CHARGING){
                        plog->write("[LCM] Charging Start -> UI_STATE = UI_STATE_CHARGING");
                        ui_state = UI_STATE_CHARGING;
                        QMetaObject::invokeMethod(mMain, "docharge");
                    }
                }else if(probot->motor_state == MOTOR_NOT_READY){
                    if(prev_motor_state != probot->motor_state){
                        plog->write(QString::number(probot->status_emo)+QString::number(probot->status_remote)+QString::number(probot->status_power)+QString::number(probot->motor[0].status)+QString::number(probot->motor[1].status)+QString::number(probot->battery_in)+QString::number(probot->battery_out));
                        plog->write("[LCM] MOTOR NOT READY -> UI_STATE = UI_STATE_MOVEFAIL ");
                        if(ui_state != UI_STATE_MOVEFAIL){
                            ui_state = UI_STATE_MOVEFAIL;
                        }
                    }
                }else if(probot->localization_state == LOCAL_NOT_READY){
                    if(prev_local_state != probot->localization_state){
                        plog->write("[LCM] LOCAL NOT READY -> UI_STATE = UI_STATE_MOVEFAIL");
                        if(ui_state != UI_STATE_MOVEFAIL){
                            ui_state = UI_STATE_MOVEFAIL;
                        }
                    }
                }else if(probot->localization_state == LOCAL_FAILED){
                    if(prev_local_state != probot->localization_state){
                        plog->write("[LCM] LOCAL FAILED -> UI_STATE = UI_STATE_MOVEFAIL");
                        if(ui_state != UI_STATE_MOVEFAIL){
                            ui_state = UI_STATE_MOVEFAIL;
                        }
                    }
                }else if(probot->running_state == ROBOT_MOVING_NOT_READY){
                    if(prev_running_state != probot->running_state){
                        if(ui_state != UI_STATE_MOVEFAIL){
                            plog->write("[LCM] RUNNING NOT READY -> UI_STATE = UI_STATE_MOVEFAIL");
                            ui_state = UI_STATE_MOVEFAIL;
                        }
                    }
                }else if(probot->running_state == ROBOT_MOVING_WAIT){
                    if(!flag_excuseme){
                        plog->write("[SCHEDULER] ROBOT ERROR : EXCUSE ME");
                        QMetaObject::invokeMethod(mMain, "excuseme");
                        count_excuseme = 0;
                        flag_excuseme = true;
                    }
                }else if(probot->motor_state == MOTOR_READY && probot->localization_state == LOCAL_READY){
                    if(ui_state == UI_STATE_INIT_DONE){
                        plog->write("[LCM] INIT ALL DONE -> UI_STATE = UI_STATE_READY");
                        ui_state = UI_STATE_READY;
                    }
                }
            }else{
                if(probot->motor_state == MOTOR_READY && probot->localization_state == LOCAL_READY){
                    if(state_count++ > 10){
                        plog->write("[LCM] INIT ALL DONE? -> UI_STATE = UI_STATE_READY");
                        ui_state = UI_STATE_READY;
                        state_count = 0;
                    }
                }
            }
        }else{
            // 로봇연결이 끊어졌는데 ui_state가 NONE이 아니면
            if(ui_state != UI_STATE_NONE){
                plog->write("[LCM] DISCONNECT -> UI_STATE = NONE");
                ui_state = UI_STATE_NONE;
                QMetaObject::invokeMethod(mMain, "stateinit");
            }
        }
    }else{
        if(lcm->isconnect){
            if(ui_state != UI_STATE_NONE){
                state_count = 0;
                if(probot->status_charge == 1){
                    if(ui_state != UI_STATE_CHARGING){
                        plog->write("[LCM] Charging Start -> UI_STATE = UI_STATE_CHARGING");
                        ui_state = UI_STATE_CHARGING;
                        QMetaObject::invokeMethod(mMain, "docharge");
                    }
                }else if(probot->motor_state == MOTOR_NOT_READY){
                    if(prev_motor_state != probot->motor_state){
                        plog->write(QString::number(probot->status_emo)+QString::number(probot->status_remote)+QString::number(probot->status_power)+QString::number(probot->motor[0].status)+QString::number(probot->motor[1].status)+QString::number(probot->battery_in)+QString::number(probot->battery_out));
                        plog->write("[LCM] MOTOR NOT READY -> UI_STATE = UI_STATE_MOVEFAIL ");
                        if(ui_state != UI_STATE_MOVEFAIL){
                            ui_state = UI_STATE_MOVEFAIL;
                        }
                    }
                }else if(probot->localization_state == LOCAL_NOT_READY){
                    if(prev_local_state != probot->localization_state){
                        plog->write("[LCM] LOCAL NOT READY -> UI_STATE = UI_STATE_MOVEFAIL");
                        if(ui_state != UI_STATE_MOVEFAIL){
                            ui_state = UI_STATE_MOVEFAIL;
                        }
                    }
                }else if(probot->localization_state == LOCAL_FAILED){
                    if(prev_local_state != probot->localization_state){
                        plog->write("[LCM] LOCAL FAILED -> UI_STATE = UI_STATE_MOVEFAIL");
                        if(ui_state != UI_STATE_MOVEFAIL){
                            ui_state = UI_STATE_MOVEFAIL;
                        }
                    }
                }else if(probot->running_state == ROBOT_MOVING_NOT_READY){
                    if(prev_running_state != probot->running_state){
                        if(ui_state != UI_STATE_MOVEFAIL){
                            plog->write("[LCM] RUNNING NOT READY -> UI_STATE = UI_STATE_MOVEFAIL");
                            ui_state = UI_STATE_MOVEFAIL;
                        }
                    }
                }else if(probot->running_state == ROBOT_MOVING_WAIT){
                    if(!flag_excuseme){
                        plog->write("[SCHEDULER] ROBOT ERROR : EXCUSE ME");
                        QMetaObject::invokeMethod(mMain, "excuseme");
                        count_excuseme = 0;
                        flag_excuseme = true;
                    }
                }else if(probot->motor_state == MOTOR_READY && probot->localization_state == LOCAL_READY){
                    if(ui_state == UI_STATE_INIT_DONE){
                        plog->write("[LCM] INIT ALL DONE -> UI_STATE = UI_STATE_READY");
                        ui_state = UI_STATE_READY;
                    }
                }
            }else{
                if(probot->motor_state == MOTOR_READY && probot->localization_state == LOCAL_READY){
                    if(state_count++ > 10){
                        plog->write("[LCM] INIT ALL DONE? -> UI_STATE = UI_STATE_READY");
                        ui_state = UI_STATE_READY;
                        state_count = 0;
                    }
                }
            }
        }else{
            // 로봇연결이 끊어졌는데 ui_state가 NONE이 아니면
            if(ui_state != UI_STATE_NONE){
                plog->write("[LCM] DISCONNECT -> UI_STATE = NONE");
                ui_state = UI_STATE_NONE;
                QMetaObject::invokeMethod(mMain, "stateinit");
            }
        }
    }


    if(flag_excuseme){
        if(count_excuseme++ > 5000/MAIN_THREAD){
            flag_excuseme = false;
            count_excuseme = 0;
        }
    }

    switch(ui_state){
    case UI_STATE_NONE:{
        if(probot->running_state == ROBOT_MOVING_PAUSED){
            if(probot->ipc_use){
                ipc->moveStop();
            }else{
                lcm->moveStop();
            }
        }
        break;
    }
    case UI_STATE_INIT_DONE:{
        ui_cmd = UI_CMD_NONE;
        break;
    }
    case UI_STATE_READY:{
        static int count_battery = 0;
        if(probot->battery < 20){
            if(count_battery++ > 60000/MAIN_THREAD){
                QMetaObject::invokeMethod(mMain, "lessbattery");
                plog->write("[SUPERVISOR] PLAY LESS BATTERY");
                count_battery = 0;
            }
        }else{
            count_battery = 0;
        }
        if(ui_cmd == UI_CMD_MOVE_TABLE){
            plog->write("[SUPERVISOR] UI_STATE = SERVING");
            ui_state = UI_STATE_SERVING;
            ui_cmd = UI_CMD_NONE;
        }else if(ui_cmd == UI_CMD_MOVE_CHARGE){
            plog->write("[SUPERVISOR] UI_STATE = GO CHARGE");
            ui_state = UI_STATE_GO_CHARGE;
            ui_cmd = UI_CMD_NONE;
        }else if(ui_cmd == UI_CMD_MOVE_WAIT){
            plog->write("[SUPERVISOR] UI_STATE = GO HOME");
            ui_state = UI_STATE_GO_HOME;
            ui_cmd = UI_CMD_NONE;
        }else if(ui_cmd == UI_CMD_TABLE_PATROL){
            plog->write("[SUPERVISOR] UI_STATE = PATROLLING");
            ui_state = UI_STATE_PATROLLING;
            ui_cmd = UI_CMD_NONE;
        }else if(ui_cmd == UI_CMD_MOVE_CALLING){
            plog->write("[SUPERVISOR] UI_STATE = CALLING");
            ui_state = UI_STATE_CALLING;
            probot->call_moving_count = 0;
            ui_cmd = UI_CMD_NONE;
        }
        break;
    }
    case UI_STATE_CHARGING:{
        flag_patrol_serving = false;
        if(probot->status_charge == 0){
            plog->write("[SCHEDULER] UI STATE IN CHARGING and Charge State = 0 -> NONE");
            ui_state = UI_STATE_NONE;
        }
        break;
    }
    case UI_STATE_GO_HOME:{
        flag_patrol_serving = false;
        if(probot->running_state == ROBOT_MOVING_READY){
            if(isaccepted){
                ui_cmd = UI_CMD_NONE;
                if(probot->type == "SERVING"){
                    plog->write("[SCHEDULER] GO HOME MOVING DONE -> waitkitchen");
                    QMetaObject::invokeMethod(mMain, "waitkitchen");
                    ui_state = UI_STATE_READY;
                }else{
                    plog->write("[SCHEDULER] GO HOME MOVING DONE -> clearkitchen");
                    QMetaObject::invokeMethod(mMain, "clearkitchen");
                    ui_state = UI_STATE_READY;
                }
                isaccepted = false;
            }else{
                if(timer_cnt%5==0){
                    if(count_moveto++ > 5){
                        if(probot->ipc_use){
                            ipc->moveStop();
                        }else{
                            lcm->moveStop();
                        }
                        ui_state = UI_STATE_MOVEFAIL;
                        plog->write("[SCHEDULER] GO HOME MOVE FAILED");
                    }else{
                        if(probot->ipc_use){
                            ipc->moveTo("Resting_0");
                        }else{
                            lcm->moveTo("Resting_0");
                        }
                        plog->write("[SCHEDULER] MOVE TO Resting_0");
                    }
                }
            }
        }else if(probot->running_state == ROBOT_MOVING_MOVING){
            // moving
            if(!isaccepted){
                isaccepted = true;
                count_moveto = 0;
                plog->write("[SCHEDULER] GO HOME MOVING START");
                QMetaObject::invokeMethod(mMain, "movelocation");
            }
        }
        break;
    }
    case UI_STATE_GO_CHARGE:{
        flag_patrol_serving = false;
        if(probot->running_state == ROBOT_MOVING_READY){
            if(isaccepted){
                ui_cmd = UI_CMD_NONE;
                isaccepted = false;
                ui_state = UI_STATE_CHARGING;
                plog->write("[SCHEDULER] GO CHARGE MOVING DONE -> docharge");
                QMetaObject::invokeMethod(mMain, "docharge");
            }else{
                if(timer_cnt%5==0){
                    if(count_moveto++ > 5){
                        if(probot->ipc_use){
                            ipc->moveStop();
                        }else{
                            lcm->moveStop();
                        }
                        ui_state = UI_STATE_MOVEFAIL;
                        plog->write("[SCHEDULER] GO CHARGE MOVE FAILED");
                    }else{
                        if(probot->ipc_use){
                            ipc->moveTo("Charging_0");
                        }else{
                            lcm->moveTo("Charging_0");
                        }
                        plog->write("[SCHEDULER] MOVE TO Charging_0");
                    }
                }
            }
        }else if(probot->running_state == ROBOT_MOVING_MOVING){
            // moving
            if(!isaccepted){
                isaccepted = true;
                count_moveto = 0;
                plog->write("[SCHEDULER] GO CHARGE MOVING START");
                QMetaObject::invokeMethod(mMain, "movelocation");
            }
        }
        break;
    }
    case UI_STATE_SERVING:{
        if(probot->running_state == ROBOT_MOVING_READY){
            //Check Done Signal
            if(isaccepted){
                count_pass = 0;
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
                if(flag_patrol_serving){
                    //시연용 가라모션
                    if(is_set){
                        if(timer_cnt%5 == 0){//1초 한번
                            if(count_moveto++ > 5){
                                if(probot->ipc_use){
                                    ipc->moveStop();
                                }else{
                                    lcm->moveStop();
                                }
                                ui_state = UI_STATE_MOVEFAIL;
                                plog->write("[SCHEDULER] RANDOM SERVING MOVE FAILED");
                            }else{
                                plog->write("[SCHEDULER] RANDOM SERVING : MOVE TO Serving_"+QString::number(table_num));

                                if(probot->ipc_use){
                                    ipc->moveTo("Serving_"+QString().sprintf("%d",table_num));
                                }else{
                                    lcm->moveTo("Serving_"+QString().sprintf("%d",table_num));
                                }
                                table_num_last = table_num;
                            }
                        }
                    }else{
                        count_moveto = 0;
                        int temp = qrand();
                        qDebug() << "First temp = " << temp << setting.table_num << temp%(setting.table_num);

                        while(table_num_last == temp%(setting.table_num)){
                            temp = qrand();
                            qDebug() << "Next temp = " << temp << temp%(setting.table_num);
                        }
                        is_set = true;
                        table_num = temp%(setting.table_num);
                        plog->write("[SCHEDULER] RANDOM SERVING : CUR ("+QString::number(table_num)+") LAST ("+QString::number(table_num_last)+")");
                    }
                }else{
                    bool serveDone = true;
                    if(timer_cnt%5==0){
                        for(int i=0; i<setting.tray_num; i++){
                            if(probot->trays[i] != 0){
                                if(count_moveto++ > 5){
                                    if(probot->ipc_use){
                                        ipc->moveStop();
                                    }else{
                                        lcm->moveStop();
                                    }
                                    ui_state = UI_STATE_MOVEFAIL;
                                    plog->write("[SCHEDULER] SERVING MOVE FAILED");
                                }else{
                                    plog->write("[SCHEDULER] SERVING : MOVE TO (Table"+QString::number(probot->trays[i])+")");

                                    if(probot->ipc_use){
                                        ipc->moveTo("Serving_"+QString().sprintf("%d",probot->trays[i]-1));
                                    }else{
                                        lcm->moveTo("Serving_"+QString().sprintf("%d",probot->trays[i]-1));
                                    }
                                    serveDone = false;
                                }
                                break;
                            }
                        }
                        if(serveDone){
                            // move done -> move to wait
                            plog->write("[SCHEDULER] SERVING : SERVE DONE");
                            ui_state = UI_STATE_GO_HOME;
                        }
                    }
                }
            }
        }else if(probot->running_state == ROBOT_MOVING_MOVING){
            // moving
            if(!isaccepted){
                isaccepted = true;
                count_moveto = 0;
                is_set = false;
                plog->write("[SCHEDULER] SERVING : MOVE START");
                QMetaObject::invokeMethod(mMain, "movelocation");
            }
        }
        break;
    }
    case UI_STATE_CALLING:{
        flag_patrol_serving = false;
        if(probot->running_state == ROBOT_MOVING_READY){
            if(isaccepted){
                plog->write("[SCHEDULER] CALLING MOVE ARRIVED "+call_list[0]);
                ui_state = UI_STATE_PICKUP;
                call_list.pop_front();
                probot->call_moving_count++;
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
                    if(call_list.size() == 0){
                        plog->write("[SCHEDULER] CALLING MOVE DONE(NO LIST)");
                        moveDone = true;
                    }

                    if(moveDone){
                        plog->write("[SCHEDULER] CALLING -> GO HOME");
                        ui_state = UI_STATE_GO_HOME;
                        probot->call_moving_count = 0;
                    }else{
                        if(count_moveto++ > 5){
                            if(probot->ipc_use){
                                ipc->moveStop();
                            }else{
                                lcm->moveStop();
                            }
                            ui_state = UI_STATE_MOVEFAIL;
                            plog->write("[SCHEDULER] CALLING MOVE FAILED");
                        }else{
                            //call_list에서 타겟 지정 후 move
                            QString cur_target = getCallName(call_list[0]);
                            plog->write("[SCHEDULER] CALLING MOVE TO "+cur_target);
                            if(probot->ipc_use){
                                ipc->moveTo(cur_target);
                            }else{
                                lcm->moveTo(cur_target);
                            }
                        }
                    }
                }
                timer_cnt++;
            }
        }else if(probot->running_state == ROBOT_MOVING_MOVING){
            // moving
            if(!isaccepted){
                isaccepted = true;
                count_moveto = 0;
                plog->write("[SCHEDULER] CALLING : MOVE START");
                QMetaObject::invokeMethod(mMain, "movelocation");
            }
        }
        break;
    }
    case UI_STATE_CLEAR:{
        break;
    }
    case UI_STATE_PICKUP:{
        if(probot->running_state == ROBOT_MOVING_PAUSED){
            plog->write("[SCHEDULER] IN PICKUP BUT ROBOT PAUSED -> RESUME");
            if(probot->ipc_use){
                ipc->moveResume();
            }else{
                lcm->moveResume();
            }
        }
        if(flag_patrol_serving){
            count_pass++;
            if(count_pass > 30){
                ui_state = UI_STATE_SERVING;
                ui_cmd = UI_CMD_NONE;
                count_pass = 0;
                plog->write("[SCHEDULER] PICKUP -> AUTO PASS");
            }
        }
        if(ui_cmd == UI_CMD_PICKUP_CONFIRM){
            if(probot->type == "SERVING"){
                plog->write("[SCHEDULER] PICKUP Confirm -> Serving");
                ui_state = UI_STATE_SERVING;
                ui_cmd = UI_CMD_NONE;
            }else{
                plog->write("[SCHEDULER] PICKUP Confirm -> Calling");
                ui_state = UI_STATE_CALLING;
                ui_cmd = UI_CMD_NONE;
            }
        }
        break;
    }
    case UI_STATE_PATROLLING:{
        plog->write("[SCHEDULER] Patrol State...WHY?");
        // 테스트용 테이블 로테이션
            if(ui_cmd == UI_CMD_TABLE_PATROL){
                state_rotate_tables = 1;
                ui_cmd = UI_CMD_NONE;
            }else if(ui_cmd == UI_CMD_PATROL_STOP){
                ui_cmd = UI_CMD_NONE;
                if(state_rotate_tables != 0){
                    ui_state = UI_STATE_NONE;
                    if(probot->ipc_use){
                        ipc->moveStop();
                    }else{
                        lcm->moveStop();
                    }
                    state_rotate_tables = 0;
                }
            }
            static int table_num_last = 0;
            switch(state_rotate_tables){
            case 1:
            {//Start
                if(probot->running_state == ROBOT_MOVING_READY){
                    ui_state = UI_STATE_PATROLLING;
                    int table_num = qrand()%5;
                    while(table_num_last == table_num){
                        table_num = qrand()%5;
                    }
                    qDebug() << "Move To " << "Serving_"+QString().sprintf("%d",table_num);

                    if(probot->ipc_use){
                        ipc->moveTo("Serving_"+QString().sprintf("%d",table_num));
                    }else{
                        lcm->moveTo("Serving_"+QString().sprintf("%d",table_num));
                    }
                    state_rotate_tables = 2;
                    table_num_last = table_num;
                }
                break;
            }
            case 2:
            {//Wait State Change
                static int timer_cnt = 0;
                if(probot->running_state == ROBOT_MOVING_MOVING){
                    qDebug() << "Moving Start";
                    state_rotate_tables = 3;
                }else{
                    if(timer_cnt%10==0){
                        if(probot->ipc_use){
                            ipc->moveTo("Serving_"+QString().sprintf("%d",table_num_last));
                        }else{
                            lcm->moveTo("Serving_"+QString().sprintf("%d",table_num_last));
                        }
                    }
                }
                break;
            }
            case 3:
            {
                if(probot->running_state == ROBOT_MOVING_READY){
                    //move done
                    qDebug() << "Move Done!!";
                    state_rotate_tables = 1;
                }
                break;
            }
            case 4:
            {//server new target
                if(probot->running_state == ROBOT_MOVING_READY){
                    state_rotate_tables = 5;
                }//confirm

                break;
            }
            case 5:{
                if(probot->running_state == ROBOT_MOVING_MOVING){
                    qDebug() << "Moving Start";
                    state_rotate_tables = 3;
                }
                break;
            }
        }
        break;
    }
    case UI_STATE_MOVEFAIL:{
        flag_patrol_serving = false;
        if(prev_motor_state != probot->motor_state){
            //UI에 movefail 페이지 표시
            flag_patrol_serving = false;
            QMetaObject::invokeMethod(mMain, "movefail");
            if(probot->motor_state == MOTOR_NOT_READY){
                plog->write("[SCHEDULER] ROBOT ERROR :ROBOT_INIT_NOT_READY");
            }
        }else if(prev_local_state != probot->localization_state){
            //UI에 movefail 페이지 표시
            QMetaObject::invokeMethod(mMain, "movefail");
            if(probot->localization_state == LOCAL_NOT_READY){
                plog->write("[SCHEDULER] ROBOT ERROR : LOCAL NOT READY");
            }else if(probot->localization_state == LOCAL_FAILED){
                plog->write("[SCHEDULER] ROBOT ERROR : ROBOT_INIT_LOCAL_FAILED");
            }
        }else{
            //UI에 movefail 페이지 표시
            QMetaObject::invokeMethod(mMain, "movefail");
            if(probot->motor_state == MOTOR_READY && probot->localization_state == LOCAL_READY && isaccepted){
                plog->write("[SCHEDULER] ROBOT ERROR : NO PATH");
                isaccepted = false;
            }
        }
        break;
    }
    }
    timer_cnt++;
    prev_state = ui_state;
    prev_running_state = probot->running_state;
    prev_motor_state = probot->motor_state;
    prev_local_state = probot->localization_state;
}



QString Supervisor::getLogDate(int num){
    QString str = curLog[num].split("[")[0];
    if(str.length() > 20){
        return str.left(20);
    }else{
        return str;
    }
}
QString Supervisor::getLogAuth(int num){
    QString str = curLog[num];
    if(str.split("[").size() > 1)
        return str.split("[")[1].split("]")[0];
    else
        return "";
}
QString Supervisor::getLogMessage(int num){
    QString str = curLog[num];
    if(str.split("[").size() > 1){
        str = curLog[num];
        if(str.split("]").size() > 1)
            return str.split("]")[1];
        else
            return "";
    }else{
        if(str.split("[")[0].length() > 20){
            return str.mid(20,str.length()-20);
        }else{
            return "";
        }
    }

}
void Supervisor::readLogList(){
}

void Supervisor::readLog(int year, int month, int date){

}
void Supervisor::readLog(QDateTime date){

    std::string path = QString().toStdString();
    QFile file(QDir::homePath()+"/"+log_folder+"/"+date.toString("yyyy_MM_dd")+".txt");
    if(!file.open(QIODevice::ReadOnly)){
        curLog.clear();
        plog->write("[SUPERVISOR] READ LOG FAILED : "+file.fileName());
        return;
    }

    curLog.clear();
    QTextStream logs(&file);
    while(!logs.atEnd()){
        QString line = logs.readLine();
        curLog.append(line);
    }
}

int Supervisor::getLogLineNum(){
    return curLog.size();
}

bool Supervisor::isHasLog(QDateTime date){
    std::string path = QString(QDir::homePath()+"/"+log_folder).toStdString();
    QDir directory(path.c_str());
    QStringList logList = directory.entryList();

    QString logName = date.toString("yyyy_MM_dd")+".txt";
    for(int i=0; i<logList.size(); i++){
        if(logList[i] == logName){
            return true;
        }
    }
    return false;
}
bool Supervisor::isHasLog(int year, int month, int date){
    std::string path = QString(QDir::homePath()+"/"+log_folder).toStdString();
    QDir directory(path.c_str());
    QStringList logList = directory.entryList();
    QString logName = QString().sprintf("%d_%02d_%02d.txt",year,month,date);
    for(int i=0; i<logList.size(); i++){
        if(logList[i] == logName){
            return true;
        }
    }
    return false;
}



