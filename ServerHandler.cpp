#include "ServerHandler.h"
#include <QGuiApplication>
#include <QPixmap>

ServerHandler::ServerHandler()
{
    connection_status = 0;
    connect(&socket, SIGNAL(connected()), this, SLOT(onConnected()));
    connect(&socket, SIGNAL(disconnected()), this, SLOT(onDisconnected()));
    connect(&socket, SIGNAL(textMessageReceived(QString)), this, SLOT(onTextMessageReceived(QString)));
    connect(&socket, SIGNAL(binaryMessageReceived(QByteArray)), this, SLOT(onBinaryMessageReceived(QByteArray)));

    timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(onTimer()));
    timer->start(200);

    robot_name = "test";







    QString map_path = "image/raw_map.png";
    cv::Mat map1 = cv::imread(map_path.toStdString());
    cv::flip(map1, map1, 0);
    cv::rotate(map1,map1,cv::ROTATE_90_COUNTERCLOCKWISE);

    QImage temp_image = QPixmap::fromImage(mat_to_qimage_cpy(map1)).toImage();

    //Save PNG File
    if(temp_image.save("image/map_downloaded.png","PNG")){
        qDebug() << "Success to png";
        isMapExist = true;
    }else{
        qDebug() << "Fail to png";
    }
}

void ServerHandler::onConnected(){
    plog->write("[SERVER] CONNECTED TO SERVER");
}

void ServerHandler::onDisconnected(){
    if(connection_status){
        plog->write("[SERVER] DISCONNECTED TO SERVER");
    }
}
void ServerHandler::onTextMessageReceived(QString message){
    QJsonObject json = QJsonDocument::fromJson(message.toUtf8()).object();

    QString cmd = json["cmd"].toString();
    plog->write("[SERVER] NEW COMMAND : "+cmd);

    server_cmd = cmd;
    if(cmd == "START"){
//        start();
    }else if(cmd == "STOP"){
//        stop();
    }else if(cmd == "PAUSE"){
//        pause();
    }else if(cmd == "RESUME"){
//        resume();
    }else if(cmd == "NEW_TARGET"){
        float x = json["x"].toDouble();
        float y = json["y"].toDouble();
        float th = json["th"].toDouble();

        target_pose.x = x;
        target_pose.y = y;
        target_pose.th = th;
//        start();
    }else if(cmd == "REQ_MAP"){
        sendMap(QGuiApplication::applicationDirPath()+"/image/raw_map.png");
    }else if(cmd == "PUSH_MAP"){
        QFile *file;
        plog->write("[SERVER] Push Map : ");

        file = new QFile(QGuiApplication::applicationDirPath()+"/image/map_server.png");
        file->open(QIODevice::WriteOnly);
        file->write(QByteArray::fromBase64(json["map"].toString().toLocal8Bit()));
        file->close();

        QString map_path = "image/map_server.png";
        cv::Mat map1 = cv::imread(map_path.toStdString());
        cv::flip(map1, map1, 0);
        cv::rotate(map1,map1,cv::ROTATE_90_COUNTERCLOCKWISE);

        QImage temp_image = QPixmap::fromImage(mat_to_qimage_cpy(map1)).toImage();

        //Save PNG File
        if(temp_image.save("image/map_downloaded1.png","PNG")){
            qDebug() << "Success to png";
            isMapExist = true;
        }else{
            qDebug() << "Fail to png";
        }
        delete file;

        file = new QFile(QGuiApplication::applicationDirPath()+"/setting/map.ini");
        file->open(QIODevice::WriteOnly);
        file->write(QByteArray::fromBase64(json["annotation"].toString().toLocal8Bit()));
        file->close();

    }
}

void ServerHandler::onBinaryMessageReceived(QByteArray message){
    ;
}

void ServerHandler::setData(QString name, ST_ROBOT _robot){
    robot_name = name;
    robot = _robot;
}

void ServerHandler::setMap(ST_MAP _map){
    map = _map;
}
void ServerHandler::onTimer(){
    static int cnt = 0;

    if(socket.state() == QAbstractSocket::ConnectedState){
        connection_status = true;

        QJsonObject json;
        QJsonArray path_array;

        // name
        json["name"] = robot_name;
        json["type"] = "DATA";

        // status
        json["status"] = robot.state;

        // cur_pose
        json["cur_pose_x"] = robot.curPose.x;
        json["cur_pose_y"] = robot.curPose.y;
        json["cur_pose_th"] = robot.curPose.th;

        // target_pose
        json["target_pose_x"] = target_pose.x;
        json["target_pose_y"] = target_pose.y;
        json["target_pose_th"] = target_pose.th;

        // path
        QJsonObject path_element;
        QVector<ST_POSE> send_path = robot.curPath;
        for(int i=0; i<send_path.size(); i++){
            path_element["x"] = send_path[i].x;
            path_element["y"] = send_path[i].y;
            path_element["th"] = send_path[i].th;

            path_array.push_back(path_element);
        }
        json["path"] = path_array;

        QJsonDocument doc(json);
        QString str(doc.toJson(QJsonDocument::Indented));
        socket.sendTextMessage(str);

//        qDebug() << str;
    }else if(socket.state() == QAbstractSocket::ConnectingState){
        ;
    }else{
        connection_status = false;
        if(++cnt%5 == 0){
            socket.open(QUrl("ws://192.168.0.200:22334"));
        }
    }
}

void ServerHandler::sendMap(QString path){
    QFile* imageMap = new QFile(path);
    imageMap->open(QIODevice::ReadOnly);
    QByteArray ba = imageMap->readAll();
    imageMap->close();

    delete imageMap;

    QJsonObject json;
    json["type"] = "MAP";
    json["map"] = QString(ba.toBase64());

    json["width"] = map.width;
    json["height"] = map.height;
    json["grid_width"] = map.gridwidth;
    json["origin_x"] = map.origin[0];
    json["origin_y"] = map.origin[1];

    QJsonObject loc_element;
    QJsonArray loc_array;
    int loc_num = map.locationSize;
    QVector<QString> loc_types = map.locationTypes;
    QVector<ST_POSE> loc_pose = map.locationsPose;
    for(int i=0; i<loc_num; i++){
        loc_element["name"] = loc_types[i];
        loc_element["x"] = loc_pose[i].x;
        loc_element["y"] = loc_pose[i].y;
        loc_element["th"] = loc_pose[i].th;

        loc_array.push_back(loc_element);
    }
    json["loc_num"] = loc_num;
    json["locations"] = loc_element;

    QJsonDocument doc(json);
    QString str(doc.toJson(QJsonDocument::Indented));
    socket.sendTextMessage(str);
}
