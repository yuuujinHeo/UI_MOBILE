#include <QtMath>
#include <QQmlApplicationEngine>
#include <QDir>
#include <iostream>
#include <exception>
#include <QGuiApplication>
#include <fstream>
#include <iostream>
#include <sys/stat.h>
#include <sys/types.h>
#include <QQmlEngine>
#include "MapView.h"

extern QObject *object;

PixmapContainer::PixmapContainer(QObject *parent){

}

MapView::MapView(QQuickItem *parent):
    QQuickPaintedItem(parent)
{
    map_width = 1000;
    map_height = 1000;
    scale = 1;
    map_x = 0;
    map_y = 0;
    tool = "move";

    //선택한 오브젝트 번호
    select_location = -1;
    select_object = -1;
    select_object_point = -1;

    //메인 타이머
    timer = new QTimer();
    connect(timer, SIGNAL(timeout()),this,SLOT(onTimer()));
    timer->start(200);
}

void MapView::onTimer(){
    // QML 오브젝트 매칭
    if(mMain == nullptr && object != nullptr){
        setObject(object);
        setWindow(qobject_cast<QQuickWindow*>(object));
    }

    if(enable){
        //Robot Following
        if(robot_following){
            setZoomCenter();
        }

        if(probot->ipc_use){
            setMapCurrent();
        }else{
            if(probot->lcmconnection){
                setMapCurrent();
            }
        }
    }
}

void MapView::setMode(QString name){
    mode = name;
    plog->write("[MAPVIEW] "+object_name+" set Mode to "+name);
    if(mode == "none"){
        show_robot = true;
        show_global_path = false;
        show_local_path = false;
        show_lidar = true;
        show_object = true;
        show_object_box = true;
        show_location = false;
        show_location_icon = true;
        robot_following = false;
        setFullScreen();
    }else if(mode == "mapping"){
        show_robot = true;
        show_global_path = false;
        show_local_path = false;
        show_lidar = true;
        show_object = false;
        show_object_box = false;
        show_location = false;
        show_location_icon = false;
        robot_following = false;
//        pmap->width = 1000;
//        pmap->height = 1000;
//        pmap->origin[0] = 500;
//        pmap->origin[1] = 500;

        setFullScreen();
    }else if(mode == "current"){
        show_robot = true;
        show_global_path = true;
        show_local_path = true;
        show_lidar = true;
        show_object = true;
        show_object_box = true;
        show_location = false;
        show_location_icon = true;
        robot_following = true;
        setFullScreen();
    }else if(mode == "annot_view"){
        show_robot = false;
        show_global_path = false;
        show_local_path = false;
        show_lidar = false;
        show_object = true;
        show_object_box = true;
        show_location = true;
        show_location_icon = true;
        robot_following = false;
        initObject();
        setFullScreen();
    }else if(mode == "annot_objecting" || mode == "annot_object"){
        show_robot = true;
        show_global_path = false;
        show_local_path = false;
        show_lidar = true;
        show_object = true;
        show_object_box = true;
        show_location = true;
        show_location_icon = true;
        robot_following = false;
        initObject();
        setFullScreen();
    }else if(mode == "annot_drawing" || mode == "annot_rotate"){
        show_robot = false;
        show_global_path = false;
        show_local_path = false;
        show_lidar = false;
        show_object = false;
        show_object_box = false;
        show_location = false;
        show_location_icon = false;
        robot_following = false;
        setFullScreen();
    }else if(mode == "annot_location"){
        show_robot = true;
        show_global_path = false;
        show_local_path = false;
        show_lidar = true;
        show_object = true;
        show_object_box = true;
        show_location = true;
        show_location_icon = true;
        robot_following = false;
        setFullScreen();
    }
    updateMap();
}

void MapView::initObject(){
    //Read annotation.ini
    QString file_path = QDir::homePath() + "/maps/" + map_name + "/map_obs.png";;
    objects.clear();
    map_objecting.release();
    map_objecting = cv::imread(file_path.toStdString(),cv::IMREAD_GRAYSCALE);
    cv::flip(map_objecting,map_objecting,0);
    cv::rotate(map_objecting,map_objecting,cv::ROTATE_90_COUNTERCLOCKWISE);

    for(int i=0; i<pmap->objects.size(); i++){
        OBJECT temp;
        temp.type = pmap->objects[i].type;
        temp.is_rect = pmap->objects[i].is_rect;
        for(int j=0; j<pmap->objects[i].points.size(); j++){
            temp.points.push_back(setAxis(pmap->objects[i].points[j]));
        }
//        qDebug() << i << temp.type;
        objects.push_back(temp);
    }
}
void MapView::initLocation(){
    //Read annotation.ini
    locations.clear();
    for(int i=0; i<pmap->locations.size(); i++){
        LOCATION temp;
        temp.type = pmap->locations[i].type;
        temp.name = pmap->locations[i].name;
        temp.point = setAxis(pmap->locations[i].point);
        temp.angle = setAxis(pmap->locations[i].angle);
        locations.push_back(temp);
    }
}
void MapView::setFullScreen(){
    map_x = 0;
    map_y = 0;
    float max_ws = (float)pmap->width/map_width;
    float max_hs = (float)pmap->height/map_height;
    if(max_ws > max_hs){
        scale = max_hs;
    }else{
        scale = max_ws;
    }
    qDebug() << "setFullScreen " << object_name << max_ws << max_hs;
}

void MapView::setMap(QObject *pixmapContainer){
    PixmapContainer *pc = qobject_cast<PixmapContainer*>(pixmapContainer);
    Q_ASSERT(pc);
    pixmap_map.pixmap = pc->pixmap;
    delete pc;
    update();
}
void MapView::moveMap(){
    if(mode == "mapping"){
        //Crop Show Rect
        cv::Mat source;
        if(pmap->map_mapping.rows > 0 && pmap->map_mapping.cols > 0){
            pmap->map_mapping(cv::Rect(map_x*1000/pmap->width,map_y*1000/pmap->width,map_width*scale*1000/pmap->width,map_height*scale*1000/pmap->width)).copyTo(source);
        }else{
            map_map(cv::Rect(map_x,map_y,map_width*scale,map_height*scale)).copyTo(source);
        }
        pixmap_map.pixmap = QPixmap::fromImage(mat_to_qimage_cpy(source));

        QPixmap temp_pixmap = map_object.copy(map_x*res,map_y*res,map_width*scale*res,map_height*scale*res);
        pixmap_object.pixmap = temp_pixmap;
        temp_pixmap = map_location.copy(map_x*res,map_y*res,map_width*scale*res,map_height*scale*res);
        pixmap_location.pixmap = temp_pixmap;
        temp_pixmap = map_current.copy(map_x*res,map_y*res,map_width*scale*res,map_height*scale*res);
        pixmap_current.pixmap = temp_pixmap;
        update();
    }else if(map_orin.cols > 0 && map_orin.rows > 0){
        //Crop Show Rect
        cv::Mat source;
        if(mode == "mapping" && pmap->map_mapping.rows > 0 && pmap->map_mapping.cols > 0){
            pmap->map_mapping(cv::Rect(map_x*1000/pmap->width,map_y*1000/pmap->width,map_width*scale*1000/pmap->width,map_height*scale*1000/pmap->width)).copyTo(source);
        }else{
            map_map(cv::Rect(map_x,map_y,map_width*scale,map_height*scale)).copyTo(source);
        }

        pixmap_map.pixmap = QPixmap::fromImage(mat_to_qimage_cpy(source));

        QPixmap temp_pixmap = map_object.copy(map_x*res,map_y*res,map_width*scale*res,map_height*scale*res);
        pixmap_object.pixmap = temp_pixmap;
        temp_pixmap = map_location.copy(map_x*res,map_y*res,map_width*scale*res,map_height*scale*res);
        pixmap_location.pixmap = temp_pixmap;
        temp_pixmap = map_current.copy(map_x*res,map_y*res,map_width*scale*res,map_height*scale*res);
        pixmap_current.pixmap = temp_pixmap;
        update();
    }
}
void MapView::updateMap(){
//    /*setMapTline*/();
    setMapDrawing();
    setMapMap();
    setMapCurrent();
    setMapLocation();
    setMapObject();
    update();
}
void MapView::setMapMap(){
    if(map_orin.cols > 0 && map_orin.rows > 0 && mode != "mapping"){
        Q_ASSERT(!(map_x+map_width*scale > map_orin.cols));
        Q_ASSERT(!(map_y+map_height*scale > map_orin.rows));

        //Rotation Map
        cv::Mat temp_orin;
        cv::Mat temp_drawing;
        cv::Mat temp_drawing_mask;
        if(rotate_angle != 0){
            cv::Mat rot = cv::getRotationMatrix2D(cv::Point2f(map_orin.cols/2, map_orin.rows/2),-rotate_angle,1.0);
            cv::warpAffine(map_orin,temp_orin,rot,map_orin.size(),cv::INTER_NEAREST);
            cv::warpAffine(map_drawing,temp_drawing,rot,map_drawing.size(),cv::INTER_NEAREST);
            cv::warpAffine(map_drawing_mask,temp_drawing_mask,rot,map_drawing_mask.size(),cv::INTER_NEAREST);
        }else{
            map_orin.copyTo(temp_orin);
            map_drawing.copyTo(temp_drawing);
            map_drawing_mask.copyTo(temp_drawing_mask);
        }

        //Merge Layer
        if(temp_orin.channels() == 3)
            cv::cvtColor(temp_orin,temp_orin,cv::COLOR_BGR2GRAY);
        if(temp_drawing.channels() == 4)
            cv::cvtColor(temp_drawing,temp_drawing,cv::COLOR_BGRA2GRAY);
        if(temp_drawing_mask.channels() == 4)
            cv::cvtColor(temp_drawing_mask,temp_drawing_mask,cv::COLOR_BGRA2GRAY);

        if(mode == "annot_tline" && map_tline.cols > 0 && map_tline.rows > 0){
            cv::multiply(cv::Scalar::all(1.0)-temp_drawing_mask,map_tline,map_tline);
            cv::add(map_tline,temp_drawing,map_tline);
            temp_orin.copyTo(map_map);
        }else{
            cv::multiply(cv::Scalar::all(1.0)-temp_drawing_mask,temp_orin,temp_orin);
            cv::add(temp_orin,temp_drawing,map_map);
        }

        if(mode == "annot_tline" && map_tline.cols > 0 && map_tline.rows > 0){
            cv::addWeighted(map_map,0.5,map_tline,1,0,map_map);
        }else if(mode == "annot_object" && map_objecting.cols > 0 && map_objecting.rows > 0){
            if(show_object){
                cv::addWeighted(map_map,1,map_objecting,0.7,0,map_map);
            }
        }

        //Cur Brush View
        if(show_brush){
            if(cur_line_color == 255)
                cv::circle(map_map,curPoint,cur_line_width/2,cv::Scalar(0,0,0,255),1,8,0);
            else
                cv::circle(map_map,curPoint,cur_line_width/2,cv::Scalar(255,255,255,255),1,8,0);
        }

        //Crop Show Rect
        cv::Mat source;
        map_map(cv::Rect(map_x,map_y,map_width*scale,map_height*scale)).copyTo(source);
        pixmap_map.pixmap = QPixmap::fromImage(mat_to_qimage_cpy(source));
    }else{
        QPixmap blank(map_width,map_height);{
            QPainter painter(&blank);
            painter.fillRect(blank.rect(),"black");
        }
        pixmap_map.pixmap = blank;
    }
    update();
}

void MapView::reloadMap(){
    initLocation();
    initObject();
    updateMap();
}
void MapView::setMapping(){
    cv::Mat source;
//    qDebug() << map_x << map_y << scale << map_width << map_height << pmap->map_mapping.rows;
    pmap->map_mapping(cv::Rect(map_x*1000/pmap->width,map_y*1000/pmap->width,map_width*scale*1000/pmap->width,map_height*scale*1000/pmap->width)).copyTo(source);
    pixmap_map.pixmap = QPixmap::fromImage(mat_to_qimage_cpy(source));
    Q_ASSERT(!pixmap_map.pixmap.isNull());
    update();
}
void MapView::setObjecting(){
    cv::Mat source;

    pmap->map_objecting(cv::Rect(map_x*1000/pmap->width,map_y*1000/pmap->width,map_width*scale*1000/pmap->width,map_height*scale*1000/pmap->width)).copyTo(source);
    pixmap_map.pixmap = QPixmap::fromImage(mat_to_qimage_cpy(source));
    Q_ASSERT(!pixmap_map.pixmap.isNull());
    update();
}

void MapView::setRawMap(QString filename){
    PixmapContainer *pc = new PixmapContainer();
    QString file_path = QDir::homePath() + "/maps/"+filename + "/map_raw.png";
    map_name = filename;
    map_orin.release();

    if(filename == "" || !QFile::exists(file_path)){
        plog->write("[MAPVIEW] SET RAW MAP ERROR : "+filename+", "+file_path);
        QPixmap blank(map_width,map_height);{
            QPainter painter(&blank);
            painter.fillRect(blank.rect(),"black");
        }

        pc->pixmap = blank;
        Q_ASSERT(!pc->pixmap.isNull());
        QQmlEngine::setObjectOwnership(pc, QQmlEngine::JavaScriptOwnership);
    }else{
        map_orin = cv::imread(file_path.toStdString(),cv::IMREAD_GRAYSCALE);
        cv::flip(map_orin,map_orin,0);
        cv::rotate(map_orin,map_orin,cv::ROTATE_90_COUNTERCLOCKWISE);
        cv::resize(map_orin,map_orin,map_orin.size());

        qDebug() << "SET RAW MAP : " << map_orin.rows << map_orin.cols;
    }
    delete pc;
    reloadMap();
}
void MapView::setEditedMap(QString filename){
    PixmapContainer *pc = new PixmapContainer();
    QString file_path = QDir::homePath() + "/maps/"+filename + "/map_edited.png";
    map_name = filename;
    map_orin.release();

    if(filename == "" || !QFile::exists(file_path)){
        plog->write("[MAPVIEW] SET EDITED MAP ERROR : "+filename+", "+file_path);
        QPixmap blank(map_width,map_height);{
            QPainter painter(&blank);
            painter.fillRect(blank.rect(),"black");
        }
        pc->pixmap = blank;
        Q_ASSERT(!pc->pixmap.isNull());
        QQmlEngine::setObjectOwnership(pc, QQmlEngine::JavaScriptOwnership);
    }else{
        map_orin = cv::imread(file_path.toStdString(),cv::IMREAD_GRAYSCALE);
        cv::flip(map_orin,map_orin,0);
        cv::rotate(map_orin,map_orin,cv::ROTATE_90_COUNTERCLOCKWISE);
        cv::resize(map_orin,map_orin,map_orin.size());
        plog->write("[MAPVIEW] SET EDITED MAP SUCCESS : "+QString().sprintf("size(%d,%d)",map_orin.rows,map_orin.cols));
    }
    delete pc;
    reloadMap();
}
void MapView::setCostMap(QString filename){
    PixmapContainer *pc = new PixmapContainer();
    QString file_path = QDir::homePath() + "/maps/"+filename + "/map_cost.png";
    map_name = filename;
    map_orin.release();

    if(filename == "" || !QFile::exists(file_path)){
        plog->write("[MAPVIEW] SET COST MAP ERROR : "+filename+", "+file_path);
        QPixmap blank(map_width,map_height);{
            QPainter painter(&blank);
            painter.fillRect(blank.rect(),"black");
        }

        pc->pixmap = blank;
        Q_ASSERT(!pc->pixmap.isNull());
        QQmlEngine::setObjectOwnership(pc, QQmlEngine::JavaScriptOwnership);
    }else{
        map_orin = cv::imread(file_path.toStdString(),cv::IMREAD_GRAYSCALE);
        cv::flip(map_orin,map_orin,0);
        cv::rotate(map_orin,map_orin,cv::ROTATE_90_COUNTERCLOCKWISE);
        qDebug() << "SET COST MAP : " << map_orin.rows << map_orin.cols;
    }
    delete pc;
    reloadMap();
}
void MapView::setObjectMap(QString filename){
    PixmapContainer *pc = new PixmapContainer();
    QString file_path = QDir::homePath() + "/maps/"+filename + "/map_edited.png";
//    QString file_path = QDir::homePath() + "/maps/"+filename + "/map_obs.png";
    map_name = filename;
    map_orin.release();

    if(filename == "" || !QFile::exists(file_path)){
        plog->write("[MAPVIEW] SET EDITED(OB) MAP ERROR : "+filename+", "+file_path);
        QPixmap blank(map_width,map_height);{
            QPainter painter(&blank);
            painter.fillRect(blank.rect(),"black");
        }

        pc->pixmap = blank;
        Q_ASSERT(!pc->pixmap.isNull());
        QQmlEngine::setObjectOwnership(pc, QQmlEngine::JavaScriptOwnership);
    }else{
        map_orin = cv::imread(file_path.toStdString(),cv::IMREAD_GRAYSCALE);
        cv::flip(map_orin,map_orin,0);
        cv::rotate(map_orin,map_orin,cv::ROTATE_90_COUNTERCLOCKWISE);
        qDebug() << "SET OBJECT MAP : " << map_orin.rows << map_orin.cols;
    }
    delete pc;
    reloadMap();
}
void MapView::setMapCurrent(){
    if(map_orin.cols > 0 && map_orin.rows > 0){
        map_current=QPixmap(map_orin.cols*res,map_orin.rows*res);
        map_current.fill(Qt::transparent);
        QPainter painter(&map_current);
        painter.setRenderHint(QPainter::Antialiasing, true);
        painter.setRenderHint(QPainter::SmoothPixmapTransform, true);

        if(show_global_path){
//            qDebug() << "global path";
            painter.setPen(QPen(QColor(hex_color_pink),2));
            cv::Point2f pose;
            cv::Point2f pose_next;
            float target_angle=0;
            for(int i=0; i<probot->curPath.size()-1; i++){
                pose = setAxis(probot->curPath[i].point);
                pose_next = setAxis(probot->curPath[i+1].point);
                target_angle = setAxis(probot->curPath[i+1].angle);
                painter.drawLine(pose.x,pose.y,pose_next.x,pose_next.y);
            }

            //target Pose
            if(probot->curPath.size() > 0){
                float distance = (pmap->robot_radius/pmap->gridwidth)*2;
                float distance2 = distance*0.8;
                float th_dist = M_PI/8;

                float x =   (pose_next.x - distance    * qSin(target_angle))*res;
                float y =   (pose_next.y - distance    * qCos(target_angle))*res;
                float x1 =  (pose_next.x - distance2   * qSin(target_angle-th_dist))*res;
                float y1 =  (pose_next.y - distance2   * qCos(target_angle-th_dist))*res;
                float x2 =  (pose_next.x - distance2   * qSin(target_angle+th_dist))*res;
                float y2 =  (pose_next.y - distance2   * qCos(target_angle+th_dist))*res;
                float rad = pmap->robot_radius*2*res/pmap->gridwidth;
                QPainterPath path;
                path.addRoundedRect((pose_next.x-rad/2)*res,(pose_next.y-rad/2)*res,rad,rad,rad,rad);
                painter.setPen(QPen(QColor(hex_color_pink),2));
                painter.fillPath(path,QBrush(QColor("white")));
                painter.drawPath(path);
                painter.drawLine(QLine(x1,y1,x,y));
                painter.drawLine(QLine(x2,y2,x,y));


                if(show_local_path){
//                    qDebug() << "local path";
                    QPainterPath circles;
                    for(int i=0; i<probot->localpathSize; i++){
                        int rad = 2*res;
                        int xx = setAxis(probot->localPath[i].point).x*res - rad;
                        int yy = setAxis(probot->localPath[i].point).y*res - rad;
                        circles.addRoundedRect(xx,yy,rad*2,rad*2,rad,rad);
                        painter.fillPath(circles,Qt::white);
                    }
                }
            }
        }
        if(set_init_flag){
//            qDebug() << "init" << probot->localization_state << mode;
            cv::Point2f pose = set_init_pose.point;
//                qDebug() << "DRAW INIT " << pose.x << pose.y;
            float angle = set_init_pose.angle;
            float distance = (pmap->robot_radius/pmap->gridwidth)*2;
            float distance2 = distance*0.8;
            float th_dist = M_PI/8;

            float x =   (pose.x + distance    * qCos(angle))*res;
            float y =   (pose.y + distance    * qSin(angle))*res;
            float x1 =  (pose.x + distance2   * qCos(angle-th_dist))*res;
            float y1 =  (pose.y + distance2   * qSin(angle-th_dist))*res;
            float x2 =  (pose.x + distance2   * qCos(angle+th_dist))*res;
            float y2 =  (pose.y + distance2   * qSin(angle+th_dist))*res;
            float rad = pmap->robot_radius*2*res/pmap->gridwidth;
            QPainterPath path;
            path.addRoundedRect((pose.x-rad/2)*res,(pose.y-rad/2)*res,rad,rad,rad,rad);
            painter.setPen(QPen(QColor("white"),2));
            painter.fillPath(path,QBrush(QColor(hex_color_pink)));
            painter.drawPath(path);
            painter.drawLine(QLine(x1,y1,x,y));
            painter.drawLine(QLine(x2,y2,x,y));
        }

        if(show_robot){
//            qDebug() << "robot";
            if(probot->localization_state == LOCAL_READY || mode == "mapping"){
                cv::Point2f pose = setAxis(probot->curPose.point);
                float angle = setAxis(probot->curPose.angle);
                float distance = (pmap->robot_radius/pmap->gridwidth)*2;
                float distance2 = distance*0.8;
                float th_dist = M_PI/8;

                float x =   (pose.x + distance    * qCos(angle))*res;
                float y =   (pose.y + distance    * qSin(angle))*res;
                float x1 =  (pose.x + distance2   * qCos(angle-th_dist))*res;
                float y1 =  (pose.y + distance2   * qSin(angle-th_dist))*res;
                float x2 =  (pose.x + distance2   * qCos(angle+th_dist))*res;
                float y2 =  (pose.y + distance2   * qSin(angle+th_dist))*res;

                float rad = pmap->robot_radius*2*res/pmap->gridwidth;
                QPainterPath path;
                QPolygonF polygon;
                polygon << QPointF(x1,y1) << QPointF(x2,y2) << QPointF(x,y) << QPointF(x1,y1);
                path.addRoundedRect((pose.x-rad/2)*res,(pose.y-rad/2)*res,rad,rad,rad,rad);
                painter.setPen(QPen(QColor("white"),2));
                painter.fillPath(path,QBrush(QColor("red")));
                painter.drawPath(path);
                QPainterPath direction;
                direction.addPolygon(polygon);
                painter.fillPath(direction,QBrush(QColor("red")));
            }
        }
        if(show_lidar){
            cv::Point2f pose = setAxis(probot->curPose.point);
            float angle = setAxis(probot->curPose.angle);
            for(int i=0; i<360; i++){
                painter.setPen(QPen(QColor("red"),1*res*scale));
                if(probot->lidar_data[i] > pmap->gridwidth){
                    float x = (pose.x + (probot->lidar_data[i]/pmap->gridwidth)*cos((-M_PI*i)/180 + angle))*res;
                    float y = (pose.y + (probot->lidar_data[i]/pmap->gridwidth)*sin((-M_PI*i)/180 + angle))*res;
                    painter.drawPoint((int)x,(int)y);
                }
            }
        }
        QPixmap temp_pixmap = map_current.copy(map_x*res,map_y*res,map_width*scale*res,map_height*scale*res);
        pixmap_current.pixmap = temp_pixmap;
        update();
    }else if(mode == "mapping"){
        map_current=QPixmap(pmap->width*res,pmap->height*res);
        map_current.fill(Qt::transparent);
        QPainter painter(&map_current);
        painter.setRenderHint(QPainter::Antialiasing, true);
        painter.setRenderHint(QPainter::SmoothPixmapTransform, true);

        cv::Point2f pose = setAxis(probot->curPose.point);
        float angle = setAxis(probot->curPose.angle);
        float distance = (pmap->robot_radius/pmap->gridwidth)*2;
        float distance2 = distance*0.8;
        float th_dist = M_PI/8;

        float x =   (pose.x + distance    * qCos(angle))*res;
        float y =   (pose.y + distance    * qSin(angle))*res;
        float x1 =  (pose.x + distance2   * qCos(angle-th_dist))*res;
        float y1 =  (pose.y + distance2   * qSin(angle-th_dist))*res;
        float x2 =  (pose.x + distance2   * qCos(angle+th_dist))*res;
        float y2 =  (pose.y + distance2   * qSin(angle+th_dist))*res;

        float rad = pmap->robot_radius*2*res/pmap->gridwidth;
        QPainterPath path;
        QPolygonF polygon;
        polygon << QPointF(x1,y1) << QPointF(x2,y2) << QPointF(x,y) << QPointF(x1,y1);
        path.addRoundedRect((pose.x-rad/2)*res,(pose.y-rad/2)*res,rad,rad,rad,rad);
        painter.setPen(QPen(QColor("white"),2));
        painter.fillPath(path,QBrush(QColor("red")));
        painter.drawPath(path);
        QPainterPath direction;
        direction.addPolygon(polygon);
        painter.fillPath(direction,QBrush(QColor("red")));

        for(int i=0; i<360; i++){
            painter.setPen(QPen(QColor("red"),1*res*scale));
            if(probot->lidar_data[i] > pmap->gridwidth){
                float x = (pose.x + (probot->lidar_data[i]/pmap->gridwidth)*cos((-M_PI*i)/180 + angle))*res;
                float y = (pose.y + (probot->lidar_data[i]/pmap->gridwidth)*sin((-M_PI*i)/180 + angle))*res;
                painter.drawPoint((int)x,(int)y);
            }
        }
        QPixmap temp_pixmap = map_current.copy(map_x*res,map_y*res,map_width*scale*res,map_height*scale*res);
        pixmap_current.pixmap = temp_pixmap;
        update();

    }
}
void MapView::setMapDrawing(){
    initDrawing();
    for(int line=0; line<lines.size(); line++){
        for(int i=0; i<lines[line].points.size()-1; i++){
            cv::line(map_drawing,cv::Point2f(lines[line].points[i].x,lines[line].points[i].y),cv::Point2f(lines[line].points[i+1].x,lines[line].points[i+1].y),cv::Scalar(lines[line].color,lines[line].color,lines[line].color),lines[line].width,8,0);
            cv::line(map_drawing_mask,cv::Point2f(lines[line].points[i].x,lines[line].points[i].y),cv::Point2f(lines[line].points[i+1].x,lines[line].points[i+1].y),cv::Scalar::all(255),lines[line].width,8,0);
        }
    }
}
void MapView::setMapObject(){
    if(map_orin.cols > 0 && map_orin.rows > 0){
        map_object=QPixmap(map_orin.cols*res,map_orin.rows*res);
        map_object.fill(Qt::transparent);
        QPainter painter(&map_object);
        painter.setRenderHint(QPainter::Antialiasing, true);
        painter.setRenderHint(QPainter::SmoothPixmapTransform, true);

        if(show_object_box){
            for(int obj=0; obj<objects.size(); obj++){
                QPainterPath path;
                if(objects[obj].is_rect){
                    if(select_object == obj){
                        painter.setPen(QPen(Qt::white,3));
                        path.addRect(QRectF(QPointF(objects[obj].points[0].x*res,objects[obj].points[0].y*res),QPointF(objects[obj].points[2].x*res,objects[obj].points[2].y*res)));
                        painter.fillPath(path,QBrush(QColor(10,24,50,100)));
                        painter.drawPath(path);

                        QPainterPath circles;
                        for(int j=0; j<objects[obj].points.size(); j++){
                            int rad = 2*res;
                            int xx = objects[obj].points[j].x*res - rad;
                            int yy = objects[obj].points[j].y*res - rad;
                            circles.addRoundedRect(xx,yy,rad*2,rad*2,rad,rad);
                            painter.fillPath(circles,Qt::white);
                        }
                    }else{
                        painter.setPen(QPen(Qt::white,1));
                        path.addRect(QRectF(QPointF(objects[obj].points[0].x*res,objects[obj].points[0].y*res),QPointF(objects[obj].points[2].x*res,objects[obj].points[2].y*res)));
                        painter.fillPath(path,QBrush(QColor(0,0,0,100)));
                        painter.drawPath(path);
                    }
                }else{
                    QPolygonF polygon;
                    for(int j=0; j<objects[obj].points.size(); j++){
                        polygon << QPointF(objects[obj].points[j].x*res, objects[obj].points[j].y*res);
                    }

                    path.addPolygon(polygon);

                    if(select_object == obj){
                        painter.setPen(QPen(Qt::white,3));
                        painter.fillPath(path,QBrush(QColor(10,24,50,100)));
                        painter.drawPolygon(polygon);
                        QPainterPath circles;
                        for(int j=0; j<objects[obj].points.size(); j++){
                            int rad = 2*res;
                            int xx = objects[obj].points[j].x*res - rad;
                            int yy = objects[obj].points[j].y*res - rad;
                            circles.addRoundedRect(xx,yy,rad*2,rad*2,rad,rad);
                            painter.fillPath(circles,Qt::white);
                        }

                    }else{
                        painter.setPen(QPen(Qt::white,1));
                        painter.fillPath(path,QBrush(QColor(0,0,0,100)));
                        painter.drawPolygon(polygon);
                    }
                }
            }
            if(new_object_flag){
                QPainterPath path;
                qDebug() << "new object drawing";
                if(new_object.is_rect){
                    path.addRect(QRectF(QPointF(new_object.points[0].x*res,new_object.points[0].y*res),QPointF(new_object.points[2].x*res,new_object.points[2].y*res)));
                    painter.setPen(QPen(Qt::white,2));
                    painter.fillPath(path,QBrush(QColor(10,24,50,100)));
                    painter.drawPath(path);

//                    QPainterPath circles;
//                    for(int j=0; j<new_object.points.size(); j++){
//                        int rad = 2*res;
//                        int xx = new_object.points[j].x*res - rad;
//                        int yy = new_object.points[j].y*res - rad;
//                        circles.addRoundedRect(xx,yy,rad*2,rad*2,rad,rad);
//                        painter.fillPath(circles,Qt::white);
//                    }
                }else{

                    QPolygonF polygon;
                    for(int j=0; j<new_object.points.size(); j++){
                        polygon << QPointF(new_object.points[j].x*res, new_object.points[j].y*res);
                    }
                    painter.setPen(QPen(Qt::white,2));
                    path.addPolygon(polygon);
                    painter.fillPath(path,QBrush(QColor(10,24,50,100)));
                    painter.drawPolygon(polygon);
                }
            }
        }
        QPixmap temp_pixmap = map_object.copy(map_x*res,map_y*res,map_width*scale*res,map_height*scale*res);
        pixmap_object.pixmap = temp_pixmap;
        update();
    }
}
void MapView::setMapLocation(){
    if(map_orin.cols > 0 && map_orin.rows > 0){
        map_location=QPixmap(map_orin.cols*res,map_orin.rows*res);
        map_location.fill(Qt::transparent);
        QPainter painter(&map_location);
        painter.setRenderHint(QPainter::Antialiasing, true);
        painter.setRenderHint(QPainter::SmoothPixmapTransform, true);

        if(show_location){
            for(int i=0; i<locations.size(); i++){
                float distance = (pmap->robot_radius/pmap->gridwidth)*2;
                float distance2 = distance*0.8;
                float th_dist = M_PI/8;

                float x =   (locations[i].point.x + distance    * qCos(locations[i].angle))*res;
                float y =   (locations[i].point.y + distance    * qSin(locations[i].angle))*res;
                float x1 =  (locations[i].point.x + distance2   * qCos(locations[i].angle-th_dist))*res;
                float y1 =  (locations[i].point.y + distance2   * qSin(locations[i].angle-th_dist))*res;
                float x2 =  (locations[i].point.x + distance2   * qCos(locations[i].angle+th_dist))*res;
                float y2 =  (locations[i].point.y + distance2   * qSin(locations[i].angle+th_dist))*res;

                float rad = pmap->robot_radius*2*res/pmap->gridwidth;
                QPainterPath path;
                if(select_location == i){
                    if(locations[i].type == "Serving"){
                        path.addRoundedRect((locations[i].point.x-rad/2)*res,(locations[i].point.y-rad/2)*res,rad,rad,rad,rad);
                        painter.setPen(QPen(Qt::white,3));
                        painter.fillPath(path,QBrush(QColor(hex_color_blue)));
                        painter.drawPath(path);
                        painter.drawLine(x1,y1,x,y);
                        painter.drawLine(x,y,x2,y2);
                    }else if(locations[i].type == "Resting"){
                    }else if(locations[i].type == "Charging"){
                    }
                }else{
                    if(locations[i].type == "Serving"){
                        path.addRoundedRect((locations[i].point.x-rad/2)*res,(locations[i].point.y-rad/2)*res,rad,rad,rad,rad);
                        painter.setPen(QPen(Qt::white,1));
                        painter.fillPath(path,QBrush(QColor(hex_color_pink)));
                        painter.drawPath(path);
                        painter.setPen(QPen(Qt::white,1.5));
                        painter.drawLine(QLine(x1,y1,x,y));
                        painter.drawLine(QLine(x2,y2,x,y));
                    }else if(locations[i].type == "Resting"){
                    }else if(locations[i].type == "Charging"){
                    }
                }
            }
            if(new_location_flag){
                float distance = (pmap->robot_radius/pmap->gridwidth)*2;
                float distance2 = distance*0.8;
                float th_dist = M_PI/8;

                float x =   (new_location.point.x + distance    * qCos(new_location.angle))*res;
                float y =   (new_location.point.y + distance    * qSin(new_location.angle))*res;
                float x1 =  (new_location.point.x + distance2   * qCos(new_location.angle-th_dist))*res;
                float y1 =  (new_location.point.y + distance2   * qSin(new_location.angle-th_dist))*res;
                float x2 =  (new_location.point.x + distance2   * qCos(new_location.angle+th_dist))*res;
                float y2 =  (new_location.point.y + distance2   * qSin(new_location.angle+th_dist))*res;
                float rad = pmap->robot_radius*2*res/pmap->gridwidth;
                QPainterPath path;
                path.addRoundedRect((new_location.point.x-rad/2)*res,(new_location.point.y-rad/2)*res,rad,rad,rad,rad);
                painter.setPen(QPen(Qt::white,3));
                painter.fillPath(path,QBrush(QColor(hex_color_blue)));
                painter.drawPath(path);
                painter.drawLine(QLine(x1,y1,x,y));
                painter.drawLine(QLine(x2,y2,x,y));
            }
        }

        if(show_location_icon){
            for(int i=0; i<locations.size(); i++){
                float distance = (pmap->robot_radius/pmap->gridwidth)*2;
                float distance2 = distance*0.8;
                float th_dist = M_PI/8;
                float rad = pmap->robot_radius*2*res/pmap->gridwidth;

                float x =   (locations[i].point.x + distance    * qCos(locations[i].angle))*res;
                float y =   (locations[i].point.y + distance    * qSin(locations[i].angle))*res;
                float x1 =  (locations[i].point.x + distance2   * qCos(locations[i].angle-th_dist))*res;
                float y1 =  (locations[i].point.y + distance2   * qSin(locations[i].angle-th_dist))*res;
                float x2 =  (locations[i].point.x + distance2   * qCos(locations[i].angle+th_dist))*res;
                float y2 =  (locations[i].point.y + distance2   * qSin(locations[i].angle+th_dist))*res;

                QPainterPath path;
                if(locations[i].type == "Resting"){
                    if(select_location == i){
                        path.addRoundedRect((locations[i].point.x-rad/2)*res,(locations[i].point.y-rad/2)*res,rad,rad,rad,rad);
                        painter.setPen(QPen(Qt::yellow,3));
                        painter.drawPath(path);
                        painter.drawLine(x1,y1,x,y);
                        painter.drawLine(x,y,x2,y2);
                        QImage image(":/icon/icon_home_1.png");
                        painter.drawImage(QRectF((locations[i].point.x-rad/2)*res,(locations[i].point.y-rad/2)*res,rad,rad),image,QRectF(0,0,image.width(),image.height()));
                    }else{
                        path.addRoundedRect((locations[i].point.x-rad/2)*res,(locations[i].point.y-rad/2)*res,rad,rad,rad,rad);
                        painter.setPen(QPen(Qt::white,1));
                        painter.drawPath(path);
                        QImage image(":/icon/icon_home_2.png");
                        painter.drawImage(QRectF((locations[i].point.x-rad/2)*res,(locations[i].point.y-rad/2)*res,rad,rad),image,QRectF(0,0,image.width(),image.height()));
                    }
                }else if(locations[i].type == "Charging"){
                    if(select_location == i){
                        path.addRoundedRect((locations[i].point.x-rad/2)*res,(locations[i].point.y-rad/2)*res,rad,rad,rad,rad);
                        painter.setPen(QPen(Qt::yellow,3));
                        painter.drawPath(path);
                        painter.drawLine(x1,y1,x,y);
                        painter.drawLine(x,y,x2,y2);
                        QImage image(":/icon/icon_charge_1.png");
                        painter.drawImage(QRectF((locations[i].point.x-rad/2)*res,(locations[i].point.y-rad/2)*res,rad,rad),image,QRectF(0,0,image.width(),image.height()));
                    }else{
                        path.addRoundedRect((locations[i].point.x-rad/2)*res,(locations[i].point.y-rad/2)*res,rad,rad,rad,rad);
                        painter.setPen(QPen(Qt::white,1));
                        painter.drawPath(path);
                        QImage image(":/icon/icon_charge_2.png");
                        painter.drawImage(QRectF((locations[i].point.x-rad/2)*res,(locations[i].point.y-rad/2)*res,rad,rad),image,QRectF(0,0,image.width(),image.height()));
                    }
                }
            }
        }
        QPixmap temp_pixmap = map_location.copy(map_x*res,map_y*res,map_width*scale*res,map_height*scale*res);
        pixmap_location.pixmap = temp_pixmap;
        update();
    }
}

void MapView::setMapSize(int width, int height){
    map_width = width;
    map_height = height;
    qDebug() << "setMapSize " << object_name << map_width <<  map_height;
    if(robot_following){
        if(map_orin.cols > 0 && map_orin.rows > 0){
            setZoomCenter();
        }else{
            setFullScreen();
        }
    }

}

void MapView::zoomIn(int x, int y){
    prev_scale = scale;
    scale -= 0.05;
    if(scale < 0.1){
        scale = 0.1;
    }
//    qDebug() << "ZOOM IN " << scale;
    setZoomCenter(x,y);
    moveMap();
}

void MapView::zoomOut(int x, int y){
    prev_scale = scale;
    scale += 0.05;
    float max_ws = (float)pmap->width/map_width;
    float max_hs = (float)pmap->height/map_height;
    if(scale > max_ws){
        scale = max_ws;
    }else if(scale > max_hs){
        scale = max_hs;
    }
//    qDebug() << "ZOOM OUT " << scale;
    setZoomCenter(x,y);
    moveMap();
}

void MapView::scaledIn(int x, int y){
//    qDebug() << "scaledIn " << pixmap_map.pixmap.width();
    pixmap_map.pixmap.scaled(pixmap_map.pixmap.width()*0.9,pixmap_map.pixmap.height()*0.9);
//    prev_scale = scale;
//    scale -= 0.05;
//    if(scale < 0.1){
//        scale = 0.1;
//    }
////    qDebug() << "ZOOM IN " << scale;
//    setZoomCenter(x,y);
//    moveMap();
}

void MapView::scaledOut(int x, int y){
    pixmap_map.pixmap.scaled(pixmap_map.pixmap.size()*1.1);
//    prev_scale = scale;
//    scale += 0.05;
//    float max_ws = (float)map_orin.cols/map_width;
//    float max_hs = (float)map_orin.rows/map_height;
//    if(scale > max_ws){
//        scale = max_ws;
//    }else if(scale > max_hs){
//        scale = max_hs;
//    }
////    qDebug() << "ZOOM OUT " << scale;
//    setZoomCenter(x,y);
//    moveMap();
}
void MapView::setInitPose(int x, int y, float th){
    set_init_flag = true;
    set_init_pose.point.x = x;
    set_init_pose.point.y = y;
    set_init_pose.angle = th;
    qDebug() << object_name << "SET INIT " << x << y << th;
    setMapCurrent();
}

void MapView::clearInitPose(){
    set_init_flag = false;
}

void MapView::rotateMap(int angle){
    dangle = angle - rotate_angle;
    rotate_angle = angle;
    setMapMap();
//    updateMap();
}

void MapView::rotateMapCW(){
    dangle = 1;
    rotate_angle++;
//    qDebug() << "rotateCW " << rotate_angle;
    setMapMap();
}

void MapView::rotateMapCCW(){
    rotate_angle--;
    dangle = -1;
//    qDebug() << "rotateCCW " << rotate_angle;
    setMapMap();

}

void MapView::move(int x, int y){
    setX(x);
    setY(y);
    moveMap();
//    updateMap();
}

void MapView::setX(int newx){
    if(newx < 0) newx=0;
    if(pmap->width > 0 && newx > (pmap->width - map_width*scale)){
        newx = pmap->width-map_width*scale;
    }
    map_x = newx;
}

void MapView::setY(int newy){
    if(newy < 0) newy=0;
    if(pmap->height > 0 && newy > pmap->height - map_height*scale){
        newy = pmap->height-map_height*scale;
    }
    map_y = newy;

}

void MapView::setZoomCenter(int x, int y){
    if(mode == "mapping"){
        if(robot_following && pmap->map_mapping.cols > 0 && pmap->map_mapping.rows > 0){
            cv::Point2f pose = setAxis(probot->curPose.point);
            float newx = pose.x - map_width*scale/2;
            float newy = pose.y - map_height*scale/2;
            setX((int)newx);
            setY((int)newy);
        }else if(prev_scale != scale){
            float newx = map_x+x*prev_scale - scale*x;
            float newy = map_y+y*prev_scale - scale*y;
            setX((int)newx);
            setY((int)newy);
        }
    }else{
        if(robot_following && map_orin.cols > 0 && map_orin.rows > 0){
            cv::Point2f pose = setAxis(probot->curPose.point);
            float newx = pose.x - map_width*scale/2;
            float newy = pose.y - map_height*scale/2;
            setX((int)newx);
            setY((int)newy);
        }else if(prev_scale != scale){
            float newx = map_x+x*prev_scale - scale*x;
            float newy = map_y+y*prev_scale - scale*y;
            setX((int)newx);
            setY((int)newy);
        }
    }
    prev_scale = scale;
}

void MapView::setCenter(int centerx, int centery){
    int newx = centerx - (map_width/2)*scale;
    int newy = centery - (map_height/2)*scale;
    qDebug() << centerx << centery << newx << newy;
    setX(newx);
    setY(newy);
}

bool MapView::getDrawingFlag(){
    if(lines.size() > 0 || line.size() > 0){
        return true;
    }else{
        return false;
    }
}
bool MapView::getDrawingUndoFlag(){
    if(lines_trash.size() > 0){
        return true;
    }else{
        return false;
    }
}
void MapView::startDrawing(int x, int y){
    line.clear();
    lines_trash.clear();
    curPoint.x = x;
    curPoint.y = y;
    line.push_back(curPoint);
}

void MapView::addLinePoint(int x, int y){
    curPoint.x = x;
    curPoint.y = y;
    line.push_back(curPoint);
    cv::line(map_drawing,line[line.size()-2],line[line.size()-1],cv::Scalar(cur_line_color,cur_line_color,cur_line_color),cur_line_width,8,0);
    cv::line(map_drawing_mask,line[line.size()-2],line[line.size()-1],cv::Scalar::all(255),cur_line_width,8,0);
//    setMapDrawing();
    setMapMap();
}

void MapView::endDrawing(int x, int y){
    curPoint.x = x;
    curPoint.y = y;
    line.push_back(curPoint);
    LINE temp_line;
    temp_line.color = cur_line_color;
    temp_line.width = cur_line_width;
    temp_line.points = line;
    lines.push_back(temp_line);
    setMapDrawing();
    setMapMap();
}

void MapView::clearDrawing(){
    line.clear();
    lines.clear();
    initTline(map_name);
    initDrawing();
    setMapDrawing();
    setMapMap();
}

void MapView::undoLine(){
    line.clear();
    if(lines.size() > 0 || line.size() > 0){
        qDebug() << "undoLine";
        lines_trash.push_back(lines[lines.size()-1]);
        lines.pop_back();
        initTline(map_name);
        setMapDrawing();
        setMapMap();
    }
}

void MapView::saveMap(){
    cv::Mat temp_orin;
    cv::Mat temp_draw;
    cv::Mat temp_mask;
    cv::Mat map_merge;

    map_orin.copyTo(temp_orin);
    map_drawing.copyTo(temp_draw);
    map_drawing_mask.copyTo(temp_mask);

    if(temp_orin.channels() == 3)
        cv::cvtColor(temp_orin,temp_orin,cv::COLOR_BGR2GRAY);
    else if(temp_orin.channels() == 4)
        cv::cvtColor(temp_orin,temp_orin,cv::COLOR_BGRA2GRAY);
    if(temp_draw.channels() == 3)
        cv::cvtColor(temp_draw,temp_draw,cv::COLOR_BGR2GRAY);
    else if(temp_draw.channels() == 4)
        cv::cvtColor(temp_draw,temp_draw,cv::COLOR_BGRA2GRAY);
    if(temp_mask.channels() == 3)
        cv::cvtColor(temp_mask,temp_mask,cv::COLOR_BGR2GRAY);
    else if(temp_mask.channels() == 4)
        cv::cvtColor(temp_mask,temp_mask,cv::COLOR_BGRA2GRAY);

    cv::multiply(cv::Scalar::all(1.0)-temp_mask,temp_orin,temp_orin);
    cv::add(temp_orin,temp_draw,map_merge);

////    cv::cvtColor(temp_orin,temp_orin,cv::COLOR_GRAY2BGRA);
////    cv::addWeighted(temp_orin, 1, map_drawing, 1, 0, map_merge);

    cv::Mat rot = cv::getRotationMatrix2D(cv::Point2f(map_merge.cols/2, map_merge.rows/2),-rotate_angle,1.0);
    rotate_angle = 0;
    cv::Mat rotated;
    cv::warpAffine(map_merge,rotated,rot,map_merge.size(),cv::INTER_NEAREST);

    cv::rotate(rotated,rotated,cv::ROTATE_90_CLOCKWISE);
    cv::flip(rotated,rotated,0);

    QString path = QDir::homePath() + "/maps/" + pmap->map_name + "/map_edited.png";
    plog->write("[MAPVIEW] SAVE MAP "+path);
    cv::imwrite(path.toStdString(),rotated);
}

void MapView::saveTline(){
    cv::Mat temp_orin;
    cv::Mat temp_draw;
    cv::Mat temp_mask;
    cv::Mat map_merge;

    if(map_drawing.channels() == 4)
        cv::cvtColor(map_drawing,temp_draw,cv::COLOR_BGRA2GRAY);
    if(map_drawing_mask.channels() == 4)
        cv::cvtColor(map_drawing_mask,temp_mask,cv::COLOR_BGRA2GRAY);

    if(map_tline.channels() == 4)
        cv::cvtColor(map_tline,temp_orin,cv::COLOR_BGRA2GRAY);
    else if(map_tline.channels() == 1)
        map_tline.copyTo(temp_orin);
    cv::multiply(cv::Scalar::all(1.0)-temp_mask,temp_orin,temp_orin);
    cv::add(temp_orin,temp_draw,map_merge);

    cv::rotate(map_merge,map_merge,cv::ROTATE_90_CLOCKWISE);
    cv::flip(map_merge,map_merge,0);

    QString path = QDir::homePath() + "/maps/" + pmap->map_name + "/travel_edited.png";
    plog->write("[MAPVIEW] SAVE MAP "+path);
    cv::imwrite(path.toStdString(),map_merge);
}

void MapView::redoLine(){
    if(lines_trash.size() > 0){
        qDebug() << "redoLine";
        lines.push_back(lines_trash[lines_trash.size()-1]);
        lines_trash.pop_back();
        initTline(map_name);
        setMapDrawing();
        setMapMap();
    }
}

int MapView::getObjectNum(int x, int y){
    cv::Point2f pos = setAxisBack(cv::Point2f(x,y));
    for(int i=0; i<pmap->list_obj_uL.size(); i++){
//        qDebug() << pos.x << pos.y << pmap->list_obj_uL[i].x << pmap->list_obj_uL[i].y << pmap->list_obj_dR[i].x << pmap->list_obj_dR[i].y;
        if(pos.x<pmap->list_obj_uL[i].x && pos.x>pmap->list_obj_dR[i].x){
            if(pos.y<pmap->list_obj_uL[i].y && pos.y>pmap->list_obj_dR[i].y){
                return i;
            }
        }
    }
    return -1;
}

int MapView::getObjectPointNum(int x, int y){
    cv::Point2f pos = setAxisBack(cv::Point2f(x,y));
    int num = select_object;
    if(num < pmap->objects.size() && num > -1){
//        qDebug() << "check obj" << num << pmap->objects[num].points.size();
        if(num != -1){
            for(int j=0; j<pmap->objects[num].points.size(); j++){
//                qDebug() << pmap->objects[num].points[j].x << pmap->objects[num].points[j].y;
                if(fabs(pmap->objects[num].points[j].x - pos.x) < 0.2){
                    if(fabs(pmap->objects[num].points[j].y - pos.y) < 0.2){
                        qDebug() << "Match Point !!" << num << j;
                        return j;
                    }
                }
            }
        }
    }
    qDebug() << "can't find obj num : " << x << y;
    return -1;
}
void MapView::addObject(int x, int y){
    qDebug() << "ADD OBJECT " << x << y;
    new_object_flag = true;
    new_object.is_rect = true;
    new_object.points.clear();
    new_object.points.push_back(cv::Point2f(x,y));
    new_object.points.push_back(cv::Point2f(x,y));
    new_object.points.push_back(cv::Point2f(x,y));
    new_object.points.push_back(cv::Point2f(x,y));
    setMapObject();
//    initObject();
//    setMapDrawing();
//    setMapMap();
}
void MapView::addObjectPoint(int x, int y){
    qDebug() << "ADD OBJECT POINT " << x << y;
    new_object_flag = true;
    new_object.is_rect = false;
    new_object.points.push_back(cv::Point2f(x,y));
    setMapObject();
}
void MapView::setObject(int x, int y){
    qDebug() << "SET OBJECT " << x << y;
    if(new_object.is_rect){
        if(new_object.points.size() > 3){
            cv::Point2f orin = new_object.points[0];
            new_object.points[1] = cv::Point2f(orin.x,y);
            new_object.points[2] = cv::Point2f(x,y);
            new_object.points[3] = cv::Point2f(x,orin.y);
        }
    }else{
        new_object.points[new_object.points.size() -1] = cv::Point2f(x,y);
    }
    setMapObject();
}
void MapView::editObjectStart(int x, int y){
    select_object_point = getObjectPointNum(x,y);
}
void MapView::editObject(int x, int y){
    int num = select_object;
    int point = select_object_point;
    if(num > -1 && num < pmap->objects.size()){
        if(pmap->objects[num].is_rect){
            if(point == 0){
                cv::Point2f pos = setAxisBack(cv::Point2f(x,y));
                pmap->objects[num].points[0].x = pos.x;
                pmap->objects[num].points[0].y = pos.y;
                pmap->objects[num].points[1].y = pos.y;
                pmap->objects[num].points[3].x = pos.x;
            }else if(point == 1){
                cv::Point2f pos = setAxisBack(cv::Point2f(x,y));
                pmap->objects[num].points[1].x = pos.x;
                pmap->objects[num].points[1].y = pos.y;
                pmap->objects[num].points[0].y = pos.y;
                pmap->objects[num].points[2].x = pos.x;
            }else if(point == 2){
                cv::Point2f pos = setAxisBack(cv::Point2f(x,y));
                pmap->objects[num].points[2].x = pos.x;
                pmap->objects[num].points[2].y = pos.y;
                pmap->objects[num].points[3].y = pos.y;
                pmap->objects[num].points[1].x = pos.x;
            }else if(point == 3){
                cv::Point2f pos = setAxisBack(cv::Point2f(x,y));
                pmap->objects[num].points[3].x = pos.x;
                pmap->objects[num].points[3].y = pos.y;
                pmap->objects[num].points[2].y = pos.y;
                pmap->objects[num].points[0].x = pos.x;
            }
            plog->write("[ANNOTATION] editObject " + QString().sprintf("(%d, %d, %d, %d)",num,point,x,y));
        }else{
            if(point > -1 && point < pmap->objects[num].points.size()){
                cv::Point2f pos = setAxisBack(cv::Point2f(x,y));
                pmap->objects[num].points[point].x = pos.x;
                pmap->objects[num].points[point].y = pos.y;
                plog->write("[ANNOTATION] editObject "+ QString().sprintf("(%d, %d, %d, %d)",num,point,x,y));
            }else{
                plog->write("[ANNOTATION - ERROR] editObject " + QString().sprintf("(%d, %d, %d, %d)",num,point,x,y) + " but pose size error");
            }
        }
    }
    initObject();
    setMapObject();
}
void MapView::saveObject(QString type){
    OBJECT temp;
    if(new_object.is_rect){
        plog->write("[ANNOTATION] ADD Object "+type+" (Rect) : "+QString().sprintf("(%f,%f) ,(%f,%f)",new_object.points[0].x, new_object.points[0].y, new_object.points[2].x,new_object.points[2].y));
    }else{
        plog->write("[ANNOTATION] ADD Object "+type+" : "+QString().sprintf("%d",new_object.points.size()));
    }

    temp.type = type;
    temp.is_rect = new_object.is_rect;
    for(int i=0; i<new_object.points.size(); i++){
        temp.points.push_back(setAxisBack(new_object.points[i]));
    }
    pmap->objects.push_back(temp);
    clearObject();
    setMapObject();
}

void MapView::clearObject(){
    qDebug() << "clearobject";
    new_object_flag = false;
    new_object.points.clear();
    select_object = -1;
    select_object_point = -1;
    initObject();
    setMapObject();
}
void MapView::undoObject(){
    new_object.points.pop_back();
    if(new_object.points.size() > 0){

    }else{
        new_object_flag = false;
    }
    initObject();
    setMapObject();
}
void MapView::selectObject(int num){
    plog->write("[MAPVIEW] SELECT OBJECT : "+QString::number(num));
    select_object = num;
    setMapObject();
}

void MapView::selectLocation(int num){
    plog->write("[MAPVIEW] SELECT LOCATION : "+QString::number(num));
    select_location = num;
}
void MapView::saveLocation(QString type, QString name){
    LOCATION temp;
    temp.type = type;
    temp.name = name;
    temp.point = setAxisBack(new_location.point);
    temp.angle = setAxisBack(new_location.angle);
    plog->write("[ANNOTATION] ADD Location : "+type+","+name+","+QString().sprintf("%f,%f,%f",temp.point.x, temp.point.y, temp.angle));
    pmap->locations.push_back(temp);
    initLocation();
}

void MapView::clearLocation(){
    new_location_flag = false;
    new_location.name = "";
    edit_location_flag = false;
    new_location.type = "";
    select_location = -1;
    initLocation();
    setMapLocation();
}

void MapView::addLocation(int x, int y, float th){
    new_location_flag = true;
    new_location.point = cv::Point2f(x,y);
    new_location.angle = th;
    initLocation();
    setMapLocation();
}
void MapView::addLocationCur(int x, int y, float th){
    new_location_flag = true;
    new_location.point = setAxis(cv::Point2f(x,y));
    new_location.angle = setAxis(th);
    qDebug() << "add:ocationCur" << x << y << th << new_location.point.x << new_location.point.y << new_location.angle;
    initLocation();
    setMapLocation();
}
void MapView::setLocation(int x, int y, float th){
    int num = select_location;
    new_location_flag = false;
    if(pmap->locations.size() > num && num > -1){
        plog->write("[ANNOTATION] EDIT LOCATION "+QString().sprintf("%d : %f,%f,%f -> %f,%f,%f",num,pmap->locations[num].point.x, pmap->locations[num].point.y, pmap->locations[num].angle,setAxisBack(cv::Point2f(x,y)).x,setAxisBack(cv::Point2f(x,y)).y,setAxisBack(th)));
        pmap->locations[num].point = setAxisBack(cv::Point2f(x,y));
        pmap->locations[num].angle = setAxisBack(th);
//        qDebug() << pmap->locations[num].angle;

    }
    initLocation();
    setMapLocation();
}

int MapView::getLocationNum(int x, int y){
    for(int i=0; i<pmap->locations.size(); i++){
        cv::Point2f pos = setAxisBack(cv::Point2f(x,y));
        if(fabs(pmap->locations[i].point.x - pos.x) < probot->radius*1.2){
            if(fabs(pmap->locations[i].point.y - pos.y) < probot->radius*1.2){
                return i;
            }
        }
    }
    return -1;
}

void MapView::editLocation(int x, int y, float th){
    int num = select_location;
    if(pmap->locations.size() > num && num > -1){
        if(!edit_location_flag){
            edit_location_flag = true;
            orin_location = pmap->locations[num];
        }
//        qDebug() <<"1            " <<  orin_location.point.x  << setAxisBack(cv::Point2f(x,y)).x;
        pmap->locations[num].point = setAxisBack(cv::Point2f(x,y));
        pmap->locations[num].angle = setAxisBack(th);
//        qDebug() << pmap->locations[num].angle;
    }
    initLocation();
    setMapLocation();
}
void MapView::redoLocation(){
    int num = select_location;
    edit_location_flag = false;
    if(pmap->locations.size() > num && num > -1){
//        qDebug() <<"1            " <<  orin_location.point.x  << locations[num].point.x;
        pmap->locations[num].point = orin_location.point;
        pmap->locations[num].angle = orin_location.angle;
//        qDebug() << pmap->locations[num].angle;
    }
    initLocation();
    setMapLocation();
}

void MapView::editLocation(){
    int num = select_location;
    if(new_location_flag){
        if(pmap->locations.size() > num && num > -1){
            pmap->locations[num].point = setAxisBack(new_location.point);
            pmap->locations[num].angle = setAxisBack(new_location.angle);
        }
        edit_location_flag = false;
        initLocation();
        setMapLocation();
    }
}

void MapView::initTline(QString filename){
    QString file_path;
    if(is_edited_tline){
        file_path = QDir::homePath() + "/maps/" + filename + "/travel_edited.png";
    }else{
        file_path = QDir::homePath() + "/maps/" + filename + "/travel_raw.png";
    }
    map_tline.release();
    if(filename == "" || !QFile::exists(file_path)){
        plog->write("[MAPVIEW] INIT TRAVEL LINE ERROR : "+filename+", "+file_path);
        map_tline = cv::Mat(map_orin.rows, map_orin.cols, CV_8UC4,cv::Scalar::all(0));
    }else{
        map_name = filename;
        map_tline = cv::imread(file_path.toStdString(),cv::IMREAD_GRAYSCALE);
        cv::flip(map_tline,map_tline,0);
        cv::rotate(map_tline,map_tline,cv::ROTATE_90_COUNTERCLOCKWISE);
        plog->write("[MAPVIEW] INIT TRAVEL LINE SUCCESS : "+filename+", "+QString().sprintf("size(%d, %d)",map_tline.rows,map_tline.cols));
    }
}

void MapView::setMapTline(){
    setMapDrawing();
    if(map_orin.cols > 0 && map_orin.rows > 0){
        if(mode == "annot_tline" && map_tline.cols > 0 && map_tline.rows > 0){
            cv::Mat temp_orin;
            map_tline(cv::Rect(map_x,map_y,map_width*scale,map_height*scale)).copyTo(temp_orin);
            pixmap_tline.pixmap = QPixmap::fromImage(mat_to_qimage_cpy(temp_orin));
        }else{
            QPixmap pixmap(map_orin.cols*res,map_orin.rows*res);
            pixmap.fill(Qt::transparent);
        }
    }
    update();
}













void MapView::paint(QPainter *painter){
//    qDebug() << width() << height();
    painter->drawPixmap(0,0,width(),height(),pixmap_map.pixmap);
    painter->drawPixmap(0,0,width(),height(),pixmap_object.pixmap);
    painter->drawPixmap(0,0,width(),height(),pixmap_location.pixmap);
    painter->drawPixmap(0,0,width(),height(),pixmap_tline.pixmap);
    painter->drawPixmap(0,0,width(),height(),pixmap_current.pixmap);
}

void MapView::setWindow(QQuickWindow *Window){
    plog->write("[BUILDER] MAPVIEW SET WINDOW ");
    mMain = Window;
}

QQuickWindow *MapView::getWindow()
{
    return mMain;
}

void MapView::setObject(QObject *object)
{
    mObject = object;
}

QObject *MapView::getObject()
{
    //rootobject를 리턴해준다.
    return mObject;
}
