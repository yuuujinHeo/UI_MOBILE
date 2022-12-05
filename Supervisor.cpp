#include "Supervisor.h"
#include <QQmlApplicationEngine>
#include <QKeyEvent>
#include <iostream>
#include <QTextCodec>
#include <QSslSocket>
#include <QGuiApplication>

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

    mMain = nullptr;

    lcm = new LCMHandler();
    server = new ServerHandler();
    map = server->map;

    isaccepted = false;
    readSetting();
    ui_state = UI_STATE_NONE;

    connect(server,SIGNAL(server_pause()),this,SLOT(server_cmd_pause()));
    connect(server,SIGNAL(server_resume()),this,SLOT(server_cmd_resume()));
    connect(server,SIGNAL(server_new_target()),this,SLOT(server_cmd_newtarget()));
    connect(server,SIGNAL(server_new_call()),this,SLOT(server_cmd_newcall()));
    connect(server,SIGNAL(server_set_ini()),this,SLOT(server_cmd_setini()));
    connect(lcm, SIGNAL(pathchanged()),this,SLOT(path_changed()));

//    make_minimap();
}

void Supervisor::programExit(){
    QCoreApplication::quit();
}

void Supervisor::programHide(){
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


//// ******************************** Init Check ************************************////
bool Supervisor::isConnectServer(){
    return server->connection_status;
}
bool Supervisor::isloadMap(){
    return map.map_loaded;
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
//0:no map, 1:map_server, 2: map_edited, 3:raw_map only
int Supervisor::isExistMap(){
    isMapExist = false;
    QFile *file = new QFile(QGuiApplication::applicationDirPath()+"/image/map_rotated.png");
    if(file->open(QIODevice::ReadOnly)){
        isMapExist = true;
    }else{
        if(rotate_map("image/map_server.png","image/map_rotated.png",0))
            isMapExist = true;
    }

    if(isMapExist){
        return 1;
    }else{
        QFile *file_raw = new QFile(QGuiApplication::applicationDirPath()+"/image/raw_map.png");
        QFile *file_edit = new QFile(QGuiApplication::applicationDirPath()+"/image/map_edited.png");
        QFile *file_meta = new QFile(QGuiApplication::applicationDirPath()+"/setting/map_meta.ini");
        QFile *file_annot = new QFile(QGuiApplication::applicationDirPath()+"/setting/annotation.ini");
        file_edit->open(QIODevice::ReadOnly);
        file_raw->open(QIODevice::ReadOnly);
        file_meta->open(QIODevice::ReadOnly);
        file_annot->open(QIODevice::ReadOnly);

        if(file_meta->isOpen()){
            if(file_raw->isOpen() && file_edit->isOpen() && file_annot->isOpen()){
                return 2;
            }else if(file_edit->isOpen()){
                if(file_annot->isOpen()){
                    //make raw_map
                    if(rotate_map("image/map_edited.png","image/raw_map.png",1)){
                        return 2;
                    }else{
                        setloadMap(false);
                        setSetting("FLOOR/map_load","false");
                        return 0;
                    }
                }else{
                    if(rotate_map("image/map_edited.png","image/raw_map.png",1)){
                        return 3;
                    }else{
                        setloadMap(false);
                        setSetting("FLOOR/map_load","false");
                        return 0;
                    }
                }
            }else if(file_raw->isOpen()){
                if(rotate_map("image/raw_map.png","image/map_raw.png",1)){
                    return 3;
                }else{
                    setloadMap(false);
                    setSetting("FLOOR/map_load","false");
                    return 0;
                }
            }else{
                setloadMap(false);
                setSetting("FLOOR/map_load","false");
                return 0;
            }
        }else{
            //Make metadata
            QString filename = "setting/map_meta.ini";
            QSettings settings(filename, QSettings::IniFormat);
            settings.clear();
            settings.setValue("map_metadata/map_w",1000);
            settings.setValue("map_metadata/map_h",1000);
            settings.setValue("map_metadata/map_grid_width",QString::number(0.03));
            settings.setValue("map_metadata/map_origin_u",500);
            settings.setValue("map_metadata/map_origin_v",500);
            setloadMap(false);
            setSetting("FLOOR/map_load","false");
            return 0;
        }
    }
}
bool Supervisor::loadMaptoServer(){
    if(server->connection_status){
        server->requestMap();
        return true;
    }else{
        return false;
    }
}
bool Supervisor::loadMaptoUSB(){
    return false;
}
bool Supervisor::isUSBFile(){
    return false;
}
QString Supervisor::getUSBFilename(){
    return "";
}

bool Supervisor::isuseServerMap(){
    return map.use_server;
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
    QFile *file_1 = new QFile(QGuiApplication::applicationDirPath()+"/image/raw_map.png");
    QFile *file_2 = new QFile(QGuiApplication::applicationDirPath()+"/image/map_raw.png");
    file_1->remove();
    file_2->remove();
}
void Supervisor::removeEditedMap(){
    QFile *file_1 = new QFile(QGuiApplication::applicationDirPath()+"/image/raw_map.png");
    QFile *file_2 = new QFile(QGuiApplication::applicationDirPath()+"/image/map_raw.png");
    QFile *file_3 = new QFile(QGuiApplication::applicationDirPath()+"/image/map_edited.png");
    file_1->remove();
    file_2->remove();
    file_3->remove();
}
void Supervisor::removeServerMap(){
    QFile *file_1= new QFile(QGuiApplication::applicationDirPath()+"/image/map_server.png");
    QFile *file_2 = new QFile(QGuiApplication::applicationDirPath()+"/image/map_rotated.png");
    file_1->remove();
    file_2->remove();
}
//// *********************************** SLAM *********************************** ////
void Supervisor::startSLAM(){

}
void Supervisor::stopSLAM(){

}
void Supervisor::setSLAMMode(int mode){

}
bool Supervisor::isConnectJoystick(){
    return false;
}
QString Supervisor::getKeyboard(int mode){
    return "";
}
QString Supervisor::getJoystick(int mode){
    return "";
}

void Supervisor::acceptCall(bool yes){

}

void Supervisor::server_cmd_setini(){
    readSetting();
}

//// *********************************** SLOTS *********************************** ////
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
    plog->write("[SERVER] NEW TARGET !!" + QString().sprintf("%f, %f, %f",server->target_pose.x, server->target_pose.y, server->target_pose.th));
    if(flag_rotate_tables)
        state_rotate_tables = 4;
    lcm->moveTo(server->target_pose.x, server->target_pose.y, server->target_pose.th);
}
void Supervisor::server_cmd_newcall(){
    QMetaObject::invokeMethod(mMain,"newcall");
}

//// *********************************** UI COMMAND *********************************** ////
void Supervisor::runRotateTables(){
    plog->write("[UI] START ROTATE TEST");
    ui_state = UI_STATE_PATROLLING;
    ui_cmd = UI_CMD_TABLE_PATROL;
    state_rotate_tables = 1;
}
void Supervisor::stopRotateTables(){
    plog->write("[UI] STOP ROTATE TEST");
    flag_rotate_tables = false;
}

void Supervisor::setTray(int tray_num, int table_num){
    if(tray_num > -1 && tray_num < setting.tray_num){
        lcm->robot.trays[tray_num] = table_num;
    }
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
void Supervisor::confirmPickup(){
    ui_cmd = UI_CMD_PICKUP_CONFIRM;
}

void Supervisor::moveToCharge(){
    ui_cmd = UI_CMD_MOVE_CHARGE;
}

void Supervisor::moveToWait(){
    ui_cmd = UI_CMD_MOVE_WAIT;
}
void Supervisor::joyMoveXY(float x){
    lcm->robot.joystick[0] = x;
    lcm->flagJoystick = true;
}
void Supervisor::joyMoveR(float r){
    lcm->robot.joystick[1] = r;
    lcm->flagJoystick = true;
}
void Supervisor::saveMetaData(QString filename){
    qDebug() << filename;
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
        }
    }else{
        plog->write("[DEBUG] Fail to copy map_meta.ini to map_meta_backup.ini (No file found)");
    }

    //데이터 입력(맵데이터)
    QSettings settings(filename, QSettings::IniFormat);
    settings.clear();
//    settings.setValue("map_metadata/name",map.map_name);
    settings.setValue("map_metadata/map_w",map.width);
    settings.setValue("map_metadata/map_h",map.height);
    settings.setValue("map_metadata/map_grid_width",QString::number(map.gridwidth));
    settings.setValue("map_metadata/map_origin_u",map.origin[0]);
    settings.setValue("map_metadata/map_origin_v",map.origin[1]);

}
void Supervisor::saveAnnotation(QString filename){
    qDebug() << filename;
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
    int patrol_num = 0;
    int resting_num = 0;
    int charging_num = 0;
    int serving_num = 0;
    QString str_name;
    QSettings settings(filename, QSettings::IniFormat);
    settings.clear();
    for(int i=0; i<map.locationsPose.size(); i++){
        if(map.locationName[i].left(4) == "Rest"){
            str_name = "Resting_"+QString().sprintf("%d,%f,%f,%f",resting_num,map.locationsPose[i].x,map.locationsPose[i].y,map.locationsPose[i].th);
            settings.setValue("resting_locations/loc"+QString::number(resting_num),str_name);
            resting_num++;
        }else if(map.locationName[i].left(4) == "Patr"){
            str_name = "Patrol_"+QString().sprintf("%d,%f,%f,%f",patrol_num,map.locationsPose[i].x,map.locationsPose[i].y,map.locationsPose[i].th);
            settings.setValue("patrol_locations/loc"+QString::number(patrol_num),str_name);
            patrol_num++;
        }else if(map.locationName[i].left(4) == "Tabl"){
            str_name = "Table_"+QString().sprintf("%d,%f,%f,%f",serving_num,map.locationsPose[i].x,map.locationsPose[i].y,map.locationsPose[i].th);
            settings.setValue("serving_locations/loc"+QString::number(serving_num),str_name);
            serving_num++;
        }else if(map.locationName[i].left(4) == "Char"){
            str_name = "Charging_"+QString().sprintf("%d,%f,%f,%f",charging_num,map.locationsPose[i].x,map.locationsPose[i].y,map.locationsPose[i].th);
            settings.setValue("charging_locations/loc"+QString::number(charging_num),str_name);
            charging_num++;
        }
    }
    settings.setValue("resting_locations/num",resting_num);
    settings.setValue("serving_locations/num",serving_num);
    settings.setValue("patrol_locations/num",patrol_num);
    settings.setValue("charging_locations/num",charging_num);

    //데이터 입력(오브젝트)
    for(int i=0; i<map.objectPose.size(); i++){
        str_name = map.objectName[i];
        for(int j=0; j<map.objectPose[i].size(); j++){
            str_name += QString().sprintf(",%f:%f",map.objectPose[i][j].x, map.objectPose[i][j].y);
        }
        settings.setValue("objects/poly"+QString::number(i),str_name);
    }
    settings.setValue("objects/num",map.objectPose.size());

    //데이터 입력(트래블라인)
    for(int i=0; i<map.travellinePose.size(); i++){
        str_name = "Travel_line_"+QString::number(i);
        for(int j=0; j<map.travellinePose[i].size(); j++){
            str_name += QString().sprintf(",%f:%f",map.travellinePose[i][j].x, map.travellinePose[i][j].y);
        }
        settings.setValue("travel_lines/line"+QString::number(i),str_name);
    }
    settings.setValue("travel_lines/num",map.travellinePose.size());

    readSetting();
}
void Supervisor::sendMaptoServer(){
    if(rotate_map("image/map_edited.png","image/map_raw.png",1)){
        server->sendMap(QGuiApplication::applicationDirPath()+"/image/map_raw.png",QGuiApplication::applicationDirPath()+"/setting/");
    }
}





//// *********************************** MAP *********************************** ////
void Supervisor::make_minimap(){
    QString map_path;
    if(map.use_server){
        map_path = "image/map_rotated.png";
    }else{
        map_path = "image/map_edited.png";
    }

    qDebug() << map.use_server << map_path;
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
        qDebug() << "Success to png";
    }else{
        qDebug() << "Fail to png";
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
        qDebug() << "Success to png";
    }else{
        qDebug() << "Fail to png";
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
        qDebug() << "Success to png";
    }else{
        qDebug() << "Fail to png";
    }
}







//// *********************************** UI DATA *********************************** ////
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

void Supervisor::startRecordPath(){

}
void Supervisor::startcurPath(){

}
void Supervisor::stopcurPath(){

}
void Supervisor::pausecurPath(){

}
QString Supervisor::getRobotName(){
    if(is_debug){
        return robot_name + "_" + debug_name;
    }else{
        return robot_name;
    }
}

void Supervisor::setRobotName(QString name){
    robot_name = name;
    lcm->robotnamechanged = true;
    setSetting("ROBOT/name",robot_name);
}
bool Supervisor::getMapExist(){
    return isMapExist;
//    QFile *file;
//    file = new QFile("image/map_rotated.png");
//    bool isopen = file->open(QIODevice::ReadOnly);
//    delete file;
//    return isopen;
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

//// *********************************** TIMER *********************************** ////
void Supervisor::onTimer(){
    // QML 오브젝트 매칭
    if(mMain == nullptr && object != nullptr){
        setObject(object);
        setWindow(qobject_cast<QQuickWindow*>(object));
    }

    // Server, LCM 데이터 매칭
    if(!lcm->flagPath){
        server->setData(robot_name, lcm->robot, ui_state);
    }
    server->setMap(map);
    lcm->setMapData(map);


    // 스케줄러 변수 초기화
    static int cur_error = ROBOT_ERROR_NONE;
    static int cur_state = UI_STATE_NONE;

    // 로봇 상태가 에러가 아니면 에러 초기화
    if(lcm->robot.state != ROBOT_STATE_ERROR)
        cur_error = ROBOT_ERROR_NONE;

    if(lcm->isconnect){
        // 로봇연결되고 로봇의 상태가 초기화 전이면 초기화 진행
        if(lcm->robot.state == ROBOT_STATE_NOT_READY){
            if(read_ini){
                if(map.use_server){
                    plog->write("[LCM] CONNECT -> INIT START");
                    lcm->sendMapPath("file://"+QCoreApplication::applicationDirPath()+"/image/map_server.png");
                    ui_state = UI_STATE_NONE;
                }else{
                    plog->write("[LCM] CONNECT -> INIT START");
                    lcm->sendMapPath("file://"+QCoreApplication::applicationDirPath()+"/image/map_raw.png");
                    ui_state = UI_STATE_NONE;
                }
            }
        }else if(lcm->robot.state == ROBOT_STATE_ERROR){
            //로봇이 에러상태면 ui에 movefail 화면 띄움
            if(ui_state != UI_STATE_MOVEFAIL){
                ui_state = UI_STATE_MOVEFAIL;
                plog->write(("[LCM] ROBOT ERROR DETECTED!"));
                isaccepted = false;
            }
        }else{
            // 로봇연결되면 READY로 상태 변경
            if(ui_state == UI_STATE_NONE){
                plog->write("[LCM] CONNECT -> UI_STATE = READY");
                ui_state = UI_STATE_READY;
            }
        }
    }else{
        // 로봇연결이 끊어졌는데 ui_state가 NONE이 아니
        if(ui_state != UI_STATE_NONE){
            ui_state = UI_STATE_NONE;
            plog->write("[LCM] DISCONNECT -> UI_STATE = NONE");
            QMetaObject::invokeMethod(mMain,"disconnected");
        }
    }

    switch(ui_state){
    case UI_STATE_READY:{
        cur_state = ui_state;
        if(lcm->robot.state == ROBOT_STATE_PAUSED){
            lcm->moveStop();
        }
        if(ui_cmd == UI_CMD_MOVE_TABLE){
            ui_state = UI_STATE_SERVING;
        }else if(ui_cmd == UI_CMD_MOVE_CHARGE){
            ui_state = UI_STATE_GO_CHARGE;
        }else if(ui_cmd == UI_CMD_MOVE_WAIT){
            ui_state = UI_STATE_GO_HOME;
        }
        break;
    }
    case UI_STATE_CHARGING:{
        cur_state = ui_state;
        break;
    }
    case UI_STATE_GO_HOME:{
        cur_state = ui_state;
        if(lcm->robot.state == ROBOT_STATE_READY){
            if(isaccepted){
                ui_cmd = UI_CMD_NONE;
                QMetaObject::invokeMethod(mMain, "waitkitchen");
                ui_state = UI_STATE_READY;
                isaccepted = false;
            }else{
                lcm->moveTo("resting_0");
            }
        }else if(lcm->robot.state == ROBOT_STATE_MOVING){
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
        if(lcm->robot.state == ROBOT_STATE_READY){
            if(isaccepted){
                ui_cmd = UI_CMD_NONE;
                isaccepted = false;
                ui_state = UI_STATE_CHARGING;
                QMetaObject::invokeMethod(mMain, "docharge");
            }else{
                lcm->moveTo("charging_0");
            }
        }else if(lcm->robot.state == ROBOT_STATE_MOVING){
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
        if(lcm->robot.state == ROBOT_STATE_READY){
            //Check Done Signal
            if(isaccepted){
                ui_state = UI_STATE_PICKUP;
                int curNum = 0;
                lcm->robot.pickupTrays.clear();
                for(int i=0; i<setting.tray_num; i++){
                    if(lcm->robot.trays[i] == curNum){
                        lcm->robot.trays[i] = 0;
                        if(curNum != 0)
                            lcm->robot.pickupTrays.push_back(i+1);
                    }else if(curNum == 0){
                        curNum = lcm->robot.trays[i];
                        lcm->robot.pickupTrays.push_back(i+1);
                        lcm->robot.trays[i] = 0;
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
                        if(lcm->robot.trays[i] != 0){
                            plog->write("[SCHEDULER] SERVING : MOVE TO (Table"+QString::number(lcm->robot.trays[i])+")");
                            lcm->moveTo("serving_"+QString().sprintf("%d",lcm->robot.trays[i]-1));
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
        }else if(lcm->robot.state == ROBOT_STATE_MOVING){
            // moving
            if(!isaccepted){
                isaccepted = true;
                plog->write("[SCHEDULER] SERVING : MOVE START");
                QMetaObject::invokeMethod(mMain, "movelocation");
            }
        }else if(lcm->robot.state == ROBOT_STATE_ERROR){
            if(cur_error != lcm->robot.err_code){
                cur_error = lcm->robot.err_code;
                if(cur_error == ROBOT_ERROR_NO_PATH){
                    isaccepted = false;
                    cur_error = lcm->robot.err_code;
                    ui_state = UI_STATE_MOVEFAIL;
                    plog->write("[SCHEDULER] ROBOT ERROR : NO PATH");
                    QMetaObject::invokeMethod(mMain, "nopathfound");
                }else{
                    plog->write("[SCHEDULER] ROBOT ERROR : " + QString::number(lcm->robot.err_code));
                }
            }
        }
        break;
    }
    case UI_STATE_CALLING:{
        cur_state = ui_state;

        break;
    }
    case UI_STATE_PICKUP:{
        cur_state = ui_state;
        if(lcm->robot.state == ROBOT_STATE_PAUSED){
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
            if(lcm->robot.state == ROBOT_STATE_READY){
                ui_state = UI_STATE_PATROLLING;
                int table_num = qrand()%5;
                while(table_num_last == table_num){
                    table_num = qrand()%5;
                }
                qDebug() << "Move To " << "serving_"+QString().sprintf("%d",table_num);
                lcm->moveTo("serving_"+QString().sprintf("%d",table_num));
                state_rotate_tables = 2;
                table_num_last = table_num;
            }
            break;
        }
        case 2:
        {//Wait State Change
            static int timer_cnt = 0;
            if(lcm->robot.state == ROBOT_STATE_MOVING){
                qDebug() << "Moving Start";
                state_rotate_tables = 3;
            }else{
                if(timer_cnt%10==0){
                    lcm->moveTo("serving_"+QString().sprintf("%d",table_num_last));
                }
            }
            break;
        }
        case 3:
        {
            if(lcm->robot.state == ROBOT_STATE_READY){
                //move done
                qDebug() << "Move Done!!";
                state_rotate_tables = 1;
            }
            break;
        }
        case 4:
        {//server new target
            if(lcm->robot.state == ROBOT_STATE_READY){
                state_rotate_tables = 5;
            }//confirm

            break;
        }
        case 5:{
            if(lcm->robot.state == ROBOT_STATE_MOVING){
                qDebug() << "Moving Start";
                state_rotate_tables = 3;
            }
            break;
        }
        }
        break;
    }
    case UI_STATE_MOVEFAIL:{
        if(cur_error != lcm->robot.err_code){
            cur_error = lcm->robot.err_code;
            if(cur_error == ROBOT_ERROR_NO_PATH){
                cur_error = lcm->robot.err_code;
                plog->write("[SCHEDULER] ROBOT ERROR : NO PATH");
                QMetaObject::invokeMethod(mMain, "nopathfound");
            }else{
                plog->write("[SCHEDULER] ROBOT ERROR : " + QString::number(lcm->robot.err_code));
            }
        }
        if(lcm->robot.state == ROBOT_STATE_MOVING){
            ui_state = cur_state;
        }
        break;
    }
    case UI_STATE_NONE:{
        break;
    }
    }

}

//// *********************************** SETTING(INI) *********************************** ////
bool Supervisor::isExistRobotINI(){
    QFile *file = new QFile(QGuiApplication::applicationDirPath()+"/setting/robot.ini");
    return file->open(QIODevice::ReadOnly);
}
void Supervisor::makeRobotINI(){
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
    readSetting();
}
bool Supervisor::getLCMConnection(){
    return lcm->isconnect;
}
bool Supervisor::getLCMProcess(){
    return false;
}
bool Supervisor::getIniRead(){
    return read_ini;
}
void Supervisor::setSetting(QString name, QString value){
    QString ini_path = "setting/robot.ini";
    QSettings setting(ini_path, QSettings::IniFormat);
    setting.setValue(name,value);
    plog->write("[SETTING] SET "+name+" VALUE TO "+value);
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
    setObjPose();
    setting_anot.endGroup();

    setting_anot.beginGroup("travel_lines");
    int trav_num = setting_anot.value("num").toInt();
    for(int i=0; i<trav_num; i++){
        QString loc_str = setting_anot.value("line"+QString::number(i)).toString();
        QStringList strlist = loc_str.split(",");
        QVector<ST_FPOINT> temp_v;
        for(int j=1; j<strlist.size(); j++){
            temp_point.x = strlist[j].split(":")[0].toFloat();
            temp_point.y = strlist[j].split(":")[1].toFloat();
            temp_v.push_back(temp_point);
        }
        map.travellineName.push_back(strlist[0]);
        map.travellinePose.push_back(temp_v);
        map.travellineSize++;
    }
    setting_anot.endGroup();

    //Robot Setting================================================================
    ini_path = "setting/robot.ini";
    QSettings setting_robot(ini_path, QSettings::IniFormat);

    setting_robot.beginGroup("ROBOT");
    robot_name = setting_robot.value("name").toString();
    lcm->robot.name = setting_robot.value("name").toString();
    robot_radius = setting_robot.value("radius").toFloat();
    lcm->robot.type = setting_robot.value("type").toString();
    lcm->robot.velocity = setting_robot.value("velocity").toFloat();
    setting.tray_num = setting_robot.value("tray_num").toInt();
    setting.useVoice = setting_robot.value("use_voice").toBool();
    setting.useBGM = setting_robot.value("use_bgm").toBool();
    setting_robot.endGroup();

    setting_robot.beginGroup("FLOOR");
    map.margin = setting_robot.value("margin").toFloat();
    map.use_server = setting_robot.value("map_server").toBool();
    map.map_loaded = setting_robot.value("map_load").toBool();
    setting.table_num = setting_robot.value("table_num").toInt();
    setting_robot.endGroup();

    setting_robot.beginGroup("SERVER");
    setting.useServerCMD = setting_robot.value("use_servercmd").toBool();
    setting.useTravelline = setting_robot.value("use_travelline").toBool();
    setting.travelline = setting_robot.value("travelline").toInt();
    setting_robot.endGroup();

    //Set Variable
    lcm->robot.trays.clear();
    for(int i=0; i<setting.tray_num; i++){
        lcm->robot.trays.push_back(0);
    }

    lcm->robotnamechanged = true;
    read_ini = true;
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
    return lcm->robot.type;
}
void Supervisor::setVelocity(float vel){
    lcm->robot.velocity = vel;
    lcm->setVelocity(vel);
}


float Supervisor::getVelocityXY(){
    return lcm->robot.velocity;
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
    if(num > -1 && num < map.locationSize){
        return map.locationName[num];
    }
    return "";
}
float Supervisor::getLocationx(int num){
    if(num > -1 && num < map.locationSize){
        ST_POSE temp = setAxis(map.locationsPose[num]);
        return temp.x;
    }
    return 0.;
}
float Supervisor::getLocationy(int num){
    if(num > -1 && num < map.locationSize){
        ST_POSE temp = setAxis(map.locationsPose[num]);
        return temp.y;
    }
    return 0.;
}
float Supervisor::getLocationth(int num){
    if(num > -1 && num < map.locationSize){
        ST_POSE temp = setAxis(map.locationsPose[num]);
        return temp.th;
    }
    return 0.;
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
    ST_FPOINT temp = setAxis(map.objectPose[num][point]);
    return temp.x;
}
float Supervisor::getObjectY(int num, int point){
    ST_FPOINT temp = setAxis(map.objectPose[num][point]);
    return temp.y;
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
void Supervisor::addObjectPoint(int x, int y){
    ST_FPOINT temp = canvasTomap(x,y);
    plog->write("[DEBUG] addObjectPoint " + QString().sprintf("[%d] %f, %f",temp_object.size(),temp.x,temp.y));
    temp_object.push_back(temp);

    QMetaObject::invokeMethod(mMain, "updatecanvas");
}
void Supervisor::editObjectPoint(int num, int x, int y){
    if(num < temp_object.size()){
        plog->write("[DEBUG] editObjectPoint " + QString().sprintf("%d (x)%f -> %f (y)%f -> %f",num,temp_object[num].x,x,temp_object[num].y,y));
        ST_FPOINT temp = canvasTomap(x,y);
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
            setObjPose();
            QMetaObject::invokeMethod(mMain, "updateobject");
            return;
        }
    }
    plog->write("[UI-MAP] REMOVE OBJECT BUT FAILED "+ name);
}

void Supervisor::moveObjectPoint(int obj_num, int point_num, int x, int y){
    if(obj_num > -1 && obj_num < map.objectSize){
        if(point_num > -1 && point_num < map.objectPose[obj_num].size()){
            ST_FPOINT pos = canvasTomap(x,y);
            map.objectPose[obj_num][point_num].x = pos.x;
            map.objectPose[obj_num][point_num].y = pos.y;
            qDebug() << "Move Point " << pos.x << pos.y;
            QMetaObject::invokeMethod(mMain, "updatecanvas");

        }
    }
}


int Supervisor::getTlineSize(){
    return map.travellinePose.size();
}

int Supervisor::getTlineSize(int num){
    if(num > -1 && num < map.travellinePose.size()){
        return map.travellinePose[num].size();
    }else{
        return 0;
    }
}

QString Supervisor::getTlineName(int num){
    if(num > -1 && num < map.travellineSize){
        return "Travel_line_"+QString::number(num);
    }else{
        return "";
    }
}
float Supervisor::getTlineX(int num, int point){
    if(num > -1 && num < map.travellineSize){
        ST_FPOINT temp = setAxis(map.travellinePose[num][point]);
        return temp.x;
    }else{
        return 0;
    }
}
float Supervisor::getTlineY(int num, int point){
    if(num > -1 && num < map.travellineSize){
        ST_FPOINT temp = setAxis(map.travellinePose[num][point]);
        return temp.y;
    }else{
        return 0;
    }
}


void Supervisor::addTline(int num, int x1, int y1, int x2, int y2){
    if(num < map.travellinePose.size() && num > -1){
        map.travellinePose[num].push_back(canvasTomap(x1,y1));
        map.travellinePose[num].push_back(canvasTomap(x2,y2));
    }else{
        QVector<ST_FPOINT> temp;
        temp.push_back(canvasTomap(x1,y1));
        temp.push_back(canvasTomap(x2,y2));
        map.travellinePose.push_back(temp);
        map.travellineSize++;
    }
    QMetaObject::invokeMethod(mMain,"updatetravelline");
}
void Supervisor::removeTline(int num, int line){
    if(num > -1 && num < map.travellinePose.size()){
        if(line > -1 && line < map.travellinePose[num].size()){
            map.travellinePose[num].remove(line);
            if(map.travellinePose[num].size() < 1){
                map.travellinePose.remove(num);
                map.travellineSize--;
            }
            QMetaObject::invokeMethod(mMain,"updatetravelline");
        }
    }
}
int Supervisor::getTlineNum(QString name){
    for(int i=0; i<map.travellineSize; i++){
        if(map.travellineName[i] == name){
            return i;
        }
    }
    return -1;
}
int Supervisor::getTlineNum(int x, int y){
    ST_FPOINT temp = canvasTomap(x,y);
    ST_FPOINT uL;
    ST_FPOINT dR;
    for(int i=0; i<map.travellinePose[0].size(); i=i+2){
        uL.x = map.travellinePose[0][i].x;
        uL.y = map.travellinePose[0][i].y;
        dR.x = map.travellinePose[0][i].x;
        dR.y = map.travellinePose[0][i].y;


        if(uL.x < map.travellinePose[0][i+1].x)
            uL.x = map.travellinePose[0][i+1].x;
        if(dR.x > map.travellinePose[0][i+1].x)
            dR.x = map.travellinePose[0][i+1].x;

        if(uL.y < map.travellinePose[0][i+1].y)
            uL.y = map.travellinePose[0][i+1].y;
        if(dR.y > map.travellinePose[0][i+1].y)
            dR.y = map.travellinePose[0][i+1].y;

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
    return -1;
}

void Supervisor::setDebugName(QString name){
    debug_name = name;
    lcm->robotnamechanged = true;
    lcm->debug_robot_name = debug_name;
    server->debug_name = debug_name;
}
QString Supervisor::getDebugName(){
    return debug_name;
}
bool Supervisor::getDebugState(){
    return is_debug;
}
void Supervisor::setDebugState(bool isdebug){
    is_debug = isdebug;
    lcm->isdebug = is_debug;
    server->is_debug = is_debug;
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
        setObjPose();
        QMetaObject::invokeMethod(mMain, "updatecanvas");
        QMetaObject::invokeMethod(mMain, "updateobject");

        plog->write("[DEBUG] addObject " + name);
    }else{
        plog->write("[DEBUG] addObject " + name + " but size = 0");
    }
}

int Supervisor::getObjNum(QString name){
    for(int i=0; i<map.objectSize; i++){
        if(map.objectName[i] == name){
            return i;
        }
    }
    return -1;
}
int Supervisor::getLocNum(QString name){
    for(int i=0; i<map.locationSize; i++){
        if(map.locationName[i] == name){
            return i;
        }
    }
    return -1;
}





void Supervisor::setObjPose(){
    list_obj_dR.clear();
    list_obj_uL.clear();
    for(int i=0; i<map.objectSize; i++){
        ST_FPOINT temp_uL;
        ST_FPOINT temp_dR;
        //Find Square Pos
        temp_uL.x = map.objectPose[i][0].x;
        temp_uL.y = map.objectPose[i][0].y;
        temp_dR.x = map.objectPose[i][0].x;
        temp_dR.y = map.objectPose[i][0].y;
        for(int j=1; j<map.objectPose[i].size(); j++){
            if(temp_uL.x > map.objectPose[i][j].x){
                temp_uL.x = map.objectPose[i][j].x;
            }
            if(temp_uL.y > map.objectPose[i][j].y){
                temp_uL.y = map.objectPose[i][j].y;
            }
            if(temp_dR.x < map.objectPose[i][j].x){
                temp_dR.x = map.objectPose[i][j].x;
            }
            if(temp_dR.y < map.objectPose[i][j].y){
                temp_dR.y = map.objectPose[i][j].y;
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
                list_margin_obj.push_back(x + y*map.width);
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

float Supervisor::getRobotRadius(){
    return robot_radius;
}
int Supervisor::getLocNum(int x, int y){
    for(int i=0; i<map.locationSize; i++){
        ST_FPOINT pos = canvasTomap(x,y);
        if(fabs(map.locationsPose[i].x - pos.x) < robot_radius){
            if(fabs(map.locationsPose[i].y - pos.y) < robot_radius){
                return i;
            }
        }
    }
    return -1;
}

void Supervisor::removeLocation(QString name){
    for(int i=0; i<map.locationSize; i++){
        if(map.locationName[i] == name){
            plog->write("[UI-MAP] REMOVE LOCATION "+ name);
            map.locationSize--;
            map.locationName.remove(i);
            map.locationsPose.remove(i);
            QMetaObject::invokeMethod(mMain, "updatelocation");
            return;
        }
    }
    plog->write("[UI-MAP] REMOVE OBJECT BUT FAILED "+ name);
}

void Supervisor::addLocation(QString name, int x, int y, float th){
    map.locationName.push_back(name);
    map.locationSize++;
    ST_POSE temp_pose;
    ST_FPOINT temp = canvasTomap(x,y);
    temp_pose.x = temp.x;
    temp_pose.y = temp.y;
    temp_pose.th = th;
    map.locationsPose.push_back(temp_pose);
    QMetaObject::invokeMethod(mMain, "updatecanvas");
    QMetaObject::invokeMethod(mMain, "updatelocation");

    plog->write("[DEBUG] addLocation "+ name);
}

void Supervisor::moveLocationPoint(int loc_num, int x, int y, float th){
    if(loc_num > -1 && loc_num < map.locationSize){
        ST_FPOINT temp = canvasTomap(x,y);
        map.locationsPose[loc_num].x = temp.x;
        map.locationsPose[loc_num].y = temp.y;
        map.locationsPose[loc_num].th = th;
        qDebug() << loc_num << x << y << th;
        plog->write("[DEBUG] moveLocation "+QString().sprintf("%d -> %f, %f, %f",loc_num , temp.x ,temp.y , th));
    }
}

int Supervisor::getObjPointNum(int obj_num, int x, int y){
    ST_FPOINT pos = canvasTomap(x,y);
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
    ST_POSE temp = setAxis(lcm->robot.curPose);
    return temp.x;
}
float Supervisor::getRoboty(){
    ST_POSE temp = setAxis(lcm->robot.curPose);
    return temp.y;
}
float Supervisor::getRobotth(){
    ST_POSE temp = setAxis(lcm->robot.curPose);
    return temp.th;
}

int Supervisor::getRobotState(){
    return lcm->robot.state;
}
int Supervisor::getPathNum(){
    if(lcm->flagPath){
        return 0;
    }else{
        return lcm->robot.pathSize;
    }
}
float Supervisor::getPathx(int num){
    if(lcm->flagPath){
        return 0;
    }else{
        ST_POSE temp = setAxis(lcm->robot.curPath[num]);
        return temp.x;
    }
}
float Supervisor::getPathy(int num){
    if(lcm->flagPath){
        return 0;
    }else{
        ST_POSE temp = setAxis(lcm->robot.curPath[num]);
        return temp.y;
    }
}
float Supervisor::getPathth(int num){
    if(lcm->flagPath){
        return 0;
    }else{
        ST_POSE temp = setAxis(lcm->robot.curPath[num]);
        return temp.th;
    }
}
int Supervisor::getLocalPathNum(){
    return lcm->robot.localpathSize;

}
float Supervisor::getLocalPathx(int num){
    ST_POSE temp = setAxis(lcm->robot.localPath[num]);
    return temp.x;

}
float Supervisor::getLocalPathy(int num){
    ST_POSE temp = setAxis(lcm->robot.localPath[num]);
    return temp.y;
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
    temp.x = -map.gridwidth*(y-map.origin[1]);
    temp.y = -map.gridwidth*(x-map.origin[0]);
    return temp;
}

ST_POINT Supervisor::mapTocanvas(float x, float y){
    ST_POINT temp;
    temp.x = -y/map.gridwidth + map.origin[1];
    temp.y = -x/map.gridwidth + map.origin[0];
    return temp;
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
