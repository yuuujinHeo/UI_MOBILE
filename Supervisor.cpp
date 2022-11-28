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
    connect(server,SIGNAL(server_new_target()),this,SLOT(server_cmd_newtarget()));
    connect(lcm, SIGNAL(pathchanged()),this,SLOT(path_changed()));



    calculateGrid2();
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

void Supervisor::runRotateTables(){
    plog->write("[UI] START ROTATE TEST");
    flag_rotate_tables = true;
    state_rotate_tables = 1;
}

void Supervisor::stopRotateTables(){
    plog->write("[UI] STOP ROTATE TEST");
    flag_rotate_tables = false;
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
}

void Supervisor::sendMaptoServer(){

    QString map_path = "image/map_edited.png";
    cv::Mat map1 = cv::imread(map_path.toStdString());
    cv::rotate(map1,map1,cv::ROTATE_90_CLOCKWISE);
    cv::flip(map1, map1, 0);

    QImage temp_image = QPixmap::fromImage(mat_to_qimage_cpy(map1)).toImage();

    //Save PNG File
    if(temp_image.save("image/map_raw.png","PNG")){
        qDebug() << "Success to png";
    }else{
        qDebug() << "Fail to png";
    }
    server->sendMap(QGuiApplication::applicationDirPath()+"/image/map_raw.png",QGuiApplication::applicationDirPath()+"/setting/");
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

//bool Supervisor::isoutline(int x, int y){
//    bool find_floor = false;
//    bool find_wall = false;
//    for(int i=x; i<minimap_grid.size(); i++){
//        if(minimap_grid[i][y] == "floor"){
//            find_floor = true;
//        }
//        if(minimap_grid[i][y] == "nothing"){
//            if(find_floor){
//                return true;
//            }
//            if(!find_wall){

//            }
//        }
//        if(minimap_grid[i][y] == "wall"){
//            find_wall = true;
//        }
//    }
//}


void Supervisor::calculateGrid2(){
    QString map_path = "image/map_rotated.png";
    minimap = cv::imread(map_path.toStdString());
    cv::Mat minimap_1, minimap_2;

//    for(int i=0; i<minimap.rows; i=i+3){
//        for(int j=0; j<minimap.cols; j=j+3){
//            int pixel = 0;
//            for(int k=0; k<3; k++){
//                for(int m=0; m<3; m++){
//                    pixel+=minimap.at<int>(i+k,j+m);
//                }
//            }
//            pixel = pixel/9;

//            if(pixel < 10)
//                pixel = 0;
//            else if(pixel > 100)
//                pixel = 255;
//            else
//                pixel = 38;

////            minimap[i
//        }
//    }

//    cv::resize(minimap, minimap_1, cv::Size(300,300),0.5,0.5,cv::INTER_AREA);
//    minimap = minimap_1;
//    cv::resize(minimap_1, minimap, cv::Size(1000,1000),0.5,0.5,cv::INTER_AREA);
    cv::cvtColor(minimap, minimap_1,cv::COLOR_BGR2HSV);
    cv::GaussianBlur(minimap_1, minimap_2,cv::Size(3,3),0);
    minimap_2 = minimap_1;
    cv::Scalar lower(0,0,37);
    cv::Scalar upper(0,0,255);
    cv::inRange(minimap_1,lower,upper,minimap_2);
    minimap_1 = minimap_2;
    cv::Canny(minimap_1,minimap_2,600,600);

    cv::Mat kernel = getStructuringElement(cv::MORPH_RECT, cv::Size(5,5));
    dilate(minimap_2, minimap_1, kernel);
     minimap_2 = minimap_1;

//    std::cout << minimap_1;


    std::vector<std::vector<cv::Point>> contours;
    std::vector<cv::Vec4i> hierarchy;

    cv::findContours(minimap_2,contours,hierarchy,cv::RETR_EXTERNAL,cv::CHAIN_APPROX_SIMPLE);

    std::vector<std::vector<cv::Point>> conPoly(contours.size());

    for (int i = 0; i < contours.size(); i++)
    {
//        int area = contourArea(contours[i]);
//        if (area > 1000)
//        {
//            // contours요소의 아크 길이를 리턴. 두번째 요소는 아크가 닫혀있으면(boolean true) 그 값을 리턴하는 듯.
//            float peri = arcLength(contours[i], true);
//            // 감지한 윤곽에 대해서, 해당 윤곽이 사각형인지 삼각형인지를 파악한다. 선분 갯수를 계산해서 아웃풋 어레이로 반환한다.
//            approxPolyDP(contours[i], conPoly[i], 0.02 * peri, true);

//                drawContours(minimap_2, conPoly, i, cv::Scalar(255, 0, 255), 3);
//                imwrite("img_wContours.jpg", minimap_2);

//        }
    }

//    std::vector<cv::Vec2f> lines;


//    cv::HoughLines(minimap_canny,lines, 1, CV_PI/180,150);


//    for(int i=0; i<lines.size(); i++){
//        qDebug() << lines[i][0] << lines[i][1];
//        float rho = lines[i][0];
//        float theta = lines[i][1];
//        cv::Point pt1, pt2;
//        double a = cos(theta);
//        double b = sin(theta);
//        double x0 = a*rho;
//        double y0 = b*rho;
//        pt1.x = cvRound(x0+1000*(-b));
//        pt1.y = cvRound(x0+1000*(a));
//        pt2.x = cvRound(x0-1000*(-b));
//        pt2.y = cvRound(x0-1000*(a));
//        cv::line(minimap_canny, pt1,pt2,cv::Scalar::all(255),1,8);
//    }
















    QImage temp_image = QPixmap::fromImage(mat_to_qimage_cpy(minimap_2)).toImage();
    if(temp_image.save("image/map_mini.png","PNG")){
        qDebug() << "Success to png";
    }else{
        qDebug() << "Fail to png";
    }

}

void Supervisor::calculateGrid(){
    ST_POINT min, max;
    for(int x=0; x<minimap_grid.size(); x++){
        bool is_find = false;
        for(int y=0; y<minimap_grid[x].size(); y++){
            //Find Init Floor Group
            int floor_grid_min = 10;
            if(minimap_grid[x][y] == "floor"){
                ST_GRID right = getRightFloor(x,y);
                ST_GRID bottom = getBottomFloor(x,y);
                int last_x = right.x;
                int last_y = bottom.y;
                for(int xx = x; xx<right.x; xx++){
                    for(int yy = y; yy<last_y; yy++){
                        if(minimap_grid[xx][yy] != "floor"){
                            last_y = yy;
                            last_x = xx;
                            break;
                        }
                        map_y[xx].push_back(yy);
                    }
                }

                if(last_x-x > floor_grid_min && last_y-y > floor_grid_min){
                    qDebug() << "FIND FLOOR GROUP!!!!!";
                    qDebug() << x << y <<  last_x << last_y;
                    min.x = x;
                    min.y = y;
                    max.x = last_x;
                    max.y = last_y;

                    is_find = true;
                    break;
                }else{
                    map_y.clear();
                }
            }
        }
            if(is_find)
                break;
    }

    QList<int> map_x = map_y.keys();

    //위로 올라가면서 확인 (기준축 : x)
    for(int x=0; x<map_x.size(); x++){
        for(int y=0; y<map_y[map_x[x]].size(); y++){
            calculateUpper(map_x[x],map_y[map_x[x]][y]-1);
        }
    }
    map_x = map_y.keys();
    //위로 올라가면서 확인 (기준축 : x)
    for(int x=0; x<map_x.size(); x++){
        for(int y=0; y<map_y[map_x[x]].size(); y++){
            calculateRight(map_x[x]+1,map_y[map_x[x]][y]);
        }
    }
    map_x = map_y.keys();
    //아래로 내려가면서 확인 (기준축 : x)
    for(int x=0; x<map_x.size(); x++){
        for(int y=0; y<map_y[map_x[x]].size(); y++){
            calculateBottom(map_x[x],map_y[map_x[x]][y]+1);
        }
    }
    map_x = map_y.keys();
    //위로 올라가면서 확인 (기준축 : x)
    for(int x=0; x<map_x.size(); x++){
        for(int y=0; y<map_y[map_x[x]].size(); y++){
            calculateLeft(map_x[x]-1,map_y[map_x[x]][y]);
        }
    }
    map_x = map_y.keys();
    //위로 올라가면서 확인 (기준축 : x)
    for(int x=0; x<map_x.size(); x++){
        for(int y=0; y<map_y[map_x[x]].size(); y++){
            calculateRight(map_x[x]+1,map_y[map_x[x]][y]);
        }
    }
}

void Supervisor::calculateUpper(int x, int y){
    QVector<int> y_wall;
    QVector<int> y_unknown;


    for(int i=0; i<map_y[x].size(); i++){
        if(map_y[x][i] == y){
            //already find
            return;
        }
    }
    for(int i=y; i>-1; i--){
        QString up_grid = minimap_grid[x][i];
        if(up_grid == "floor"){
            map_y[x].push_back(i);
        }else if(up_grid == "unknown"){
            y_unknown.push_back(i);
        }else{
            for(int j=0; j<y_unknown.size(); j++)
                map_y[x].push_back(y_unknown[j]);
            return;
        }
    }
}

void Supervisor::calculateBottom(int x, int y){
    QVector<int> y_wall;
    QVector<int> y_unknown;


    for(int i=0; i<map_y[x].size(); i++){
        if(map_y[x][i] == y){
            //already find
            return;
        }
    }
    for(int i=y; i<minimap_grid[x].size(); i++){
        QString bottom_grid = minimap_grid[x][i];
        if(bottom_grid == "floor"){
            map_y[x].push_back(i);
        }else if(bottom_grid == "unknown"){
            y_unknown.push_back(i);
        }else{
            for(int j=0; j<y_unknown.size(); j++)
                map_y[x].push_back(y_unknown[j]);
            return;
        }
    }
}

void Supervisor::calculateLeft(int x, int y){
    QVector<int> y_wall;
    QVector<int> y_unknown;

    for(int i=0; i<map_y[x].size(); i++){
        if(map_y[x][i] == y){
            //already find
            return;
        }
    }
    for(int i=x; i>-1; i--){
        QString bottom_grid = minimap_grid[i][y];
        if(bottom_grid == "floor"){
            map_y[i].push_back(y);
        }else if(bottom_grid == "unknown"){
            y_unknown.push_back(i);
        }else{
            for(int j=0; j<y_unknown.size(); j++)
                map_y[y_unknown[j]].push_back(y);
            return;
        }
    }
}

void Supervisor::calculateRight(int x, int y){
    QVector<int> y_wall;
    QVector<int> y_unknown;

    for(int i=0; i<map_y[x].size(); i++){
        if(map_y[x][i] == y){
            //already find
            return;
        }
    }
    for(int i=x; i<minimap_grid[x].size(); i++){
        QString bottom_grid = minimap_grid[i][y];
        if(bottom_grid == "floor"){
            map_y[i].push_back(y);
        }else if(bottom_grid == "unknown"){
            y_unknown.push_back(i);
        }else{
            for(int j=0; j<y_unknown.size(); j++)
                map_y[y_unknown[j]].push_back(y);
            return;
        }
    }
}
ST_GRID Supervisor::getNextGrid(QString cur, int x, int y){
    ST_GRID temp;
    if(x > minimap_grid.size()-1){
        temp.name = "nothing";
        temp.x = x;
        temp.y = y;
        return temp;
    }else if(minimap_grid[x][y] != cur){
        temp.name = minimap_grid[x][y];
        temp.x = x;
        temp.y = y;
        return temp;
    }else{
        return getNextGrid(cur,++x,y);
    }
}

ST_GRID Supervisor::getRightFloor(int x, int y){
    ST_GRID temp;
    if(x > minimap_grid.size()-1){
        temp.name = "floor";
        temp.x = x;
        temp.y = y;
        return temp;
    }else if(minimap_grid[x][y] != "floor"){
        temp.name = minimap_grid[x][y];
        temp.x = x;
        temp.y = y;
        return temp;
    }else{
        return getRightFloor(++x,y);
    }
}
ST_GRID Supervisor::getBottomFloor(int x, int y){
    ST_GRID temp;
    if(y > minimap_grid[x].size()-1){
        temp.name = "floor";
        temp.x = x;
        temp.y = y;
        return temp;
    }else if(minimap_grid[x][y] != "floor"){
        temp.name = minimap_grid[x][y];
        temp.x = x;
        temp.y = y;
        return temp;
    }else{
        return getBottomFloor(x,++y);
    }
}

ST_GRID Supervisor::getLeftWall(int x, int y){
    ST_GRID temp;
    if(x < 0){
        temp.name = "fail";
        temp.x = x;
        temp.y = y;
        return temp;
    }else if(minimap_grid[x][y] == "wall" || minimap_grid[x][y] == "nothing"){
        temp.name = minimap_grid[x][y];
        temp.x = x;
        temp.y = y;
        return temp;
    }else{
        return getRightWall(--x,y);
    }
}
ST_GRID Supervisor::getRightWall(int x, int y){
    ST_GRID temp;
    if(x > minimap_grid.size()-1){
        temp.name = "wall";
        temp.x = x;
        temp.y = y;
        return temp;
    }else if(minimap_grid[x][y] != "wall" && minimap_grid[x][y] != "outline_wall"){
        temp.name = minimap_grid[x][y];
        temp.x = x;
        temp.y = y;
        return temp;
    }else{
        return getRightWall(++x,y);
    }
}
ST_GRID Supervisor::getBottomWall(int x, int y){
    ST_GRID temp;
    if(y > minimap_grid[x].size()-1){
        temp.name = "wall";
        temp.x = x;
        temp.y = y;
        return temp;
    }else if(minimap_grid[x][y] != "wall" && minimap_grid[x][y] != "outline_wall"){
        temp.name = minimap_grid[x][y];
        temp.x = x;
        temp.y = y;
        return temp;
    }else{
        return getBottomWall(x,++y);
    }
}
bool Supervisor::findNothingRight(int x, int y){
    if(x > minimap_grid.size()){
        return false;
    }else if(minimap_grid[x][y] == "nothing"){
        return true;
    }else{
        return findNothingRight(x++,y);
    }
}

bool Supervisor::findWallRight(int x, int y){
    if(x > minimap_grid.size()){
        return false;
    }else if(minimap_grid[x][y] == "wall"){
        return true;
    }else{
        return findWallRight(x++,y);
    }
}

bool Supervisor::findFloorRight(int x, int y){
    if(x > minimap_grid.size()){
        return false;
    }else if(minimap_grid[x][y] == "floor"){
        return true;
    }else{
        return findFloorRight(x++,y);
    }
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

bool Supervisor::getFloor(int x, int y){
    for(int i=0; i<map_y[x].size(); i++){
        if(map_y[x][i] == y){
            return true;
        }
    }
    return false;
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
    // QML 오브젝트 매칭
    if(mMain == nullptr && object != nullptr){
        setObject(object);
        setWindow(qobject_cast<QQuickWindow*>(object));
    }

    // 맵 유무 확인 -> 없으면 생성성
    if(!isMapExist){
//        QFile *file_raw = new QFile(QGuiApplication::applicationDirPath()+"/image/raw_map.png");
        QFile *file = new QFile(QGuiApplication::applicationDirPath()+"/image/map_rotated.png");
//        if(file_raw->open(QIODevice::ReadOnly)){
//            QString map_path = "image/raw_map.png";
//            cv::Mat map1 = cv::imread(map_path.toStdString());
//            cv::flip(map1, map1, 0);
//            cv::rotate(map1,map1,cv::ROTATE_90_COUNTERCLOCKWISE);

//            QImage temp_image = QPixmap::fromImage(mat_to_qimage_cpy(map1)).toImage();

            //Save PNG File
//            if(temp_image.save("image/map_raw.png","PNG")){
//                file_raw->remove();
//            }
//        }

        if(file->open(QIODevice::ReadOnly)){
            isMapExist = true;
        }else{
            isMapExist = false;
            rotate_map();
        }

    }

    // Server, LCM 데이터 매칭
    if(!lcm->flagPath){
        server->setData(robot_name, lcm->robot);
    }
    server->setMap(map);
    lcm->setMapData(map);



    if(flag_rotate_tables){
        static int table_num_last = 0;
        switch(state_rotate_tables){
        case 1:
        {//Start
            if(lcm->robot.state == ROBOT_STATE_READY){
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
    }else{
        if(state_rotate_tables != 0){
            qDebug() << "Moving Stop Signal!!";
            lcm->moveStop();
            state_rotate_tables = 0;
        }else{

        }
    }

    // 로봇 커맨드 스케줄러
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
    map.margin = setting_robot.value("margin").toFloat();
    robot_radius = setting_robot.value("radius").toFloat();
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
    if(is_debug){
        return robot_name + "_" + debug_name;
    }else{
        return robot_name;
    }
}

void Supervisor::setRobotName(QString name){
    robot_name = name;
    //set ini
    QString ini_path = "setting/robot.ini";
    QSettings settings(ini_path, QSettings::IniFormat);
    settings.setValue("ROBOT/name",robot_name);
}
bool Supervisor::getMapExist(){
    return isMapExist;
//    QFile *file;
//    file = new QFile("image/map_rotated.png");
//    bool isopen = file->open(QIODevice::ReadOnly);
//    delete file;
//    return isopen;
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
    if(num > map.travellinePose.size()){
        QVector<ST_FPOINT> temp;
        temp.push_back(canvasTomap(x1,y1));
        temp.push_back(canvasTomap(x2,y2));
        map.travellinePose.push_back(temp);
        map.travellineSize++;
    }else if(num > -1){
        map.travellinePose[num].push_back(canvasTomap(x1,y1));
        map.travellinePose[num].push_back(canvasTomap(x2,y2));
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
void Supervisor::rotate_map(){
    QString map_path = "image/map_server.png";
    cv::Mat map1 = cv::imread(map_path.toStdString());
    cv::flip(map1, map1, 0);
    cv::rotate(map1,map1,cv::ROTATE_90_COUNTERCLOCKWISE);

    QImage temp_image = QPixmap::fromImage(mat_to_qimage_cpy(map1)).toImage();

    //Save PNG File
    if(temp_image.save("image/map_rotated.png","PNG")){
        qDebug() << "Success to png";
        isMapExist = true;
    }else{
        qDebug() << "Fail to png";
    }
}
