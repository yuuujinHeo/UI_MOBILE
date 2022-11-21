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
        emit server_pause();
    }else if(cmd == "RESUME"){
        emit server_resume();
    }else if(cmd == "NEW_TARGET"){
        float x = json["x"].toDouble();
        float y = json["y"].toDouble();
        float th = json["th"].toDouble();

        target_pose.x = x;
        target_pose.y = y;
        target_pose.th = th;
//        start();
    }else if(cmd == "MAP_REQ"){
        sendMap(QGuiApplication::applicationDirPath()+"/image/map_server.png", QGuiApplication::applicationDirPath()+"/setting/");
    }else if(cmd == "MAP_PUB"){
        QFile *file;
        plog->write("[SERVER] Push Map : ");

        file = new QFile(QGuiApplication::applicationDirPath()+"/image/map_from_server.png");
        file->open(QIODevice::WriteOnly);
        file->write(QByteArray::fromBase64(json["raw_map"].toString().toLocal8Bit()));
        file->close();

        QString map_path = "image/map_from_server.png";
        cv::Mat map1 = cv::imread(map_path.toStdString());
        cv::flip(map1, map1, 0);
        cv::rotate(map1,map1,cv::ROTATE_90_COUNTERCLOCKWISE);

        QImage temp_image = QPixmap::fromImage(mat_to_qimage_cpy(map1)).toImage();

        //Save PNG File
        if(temp_image.save("image/map_from_server_rotated.png","PNG")){
            qDebug() << "Success to png";
            isMapExist = true;
        }else{
            qDebug() << "Fail to png";
        }
        delete file;

        file = new QFile(QGuiApplication::applicationDirPath()+"/image/map_from_server2.png");
        file->open(QIODevice::WriteOnly);
        file->write(QByteArray::fromBase64(json["annot_map"].toString().toLocal8Bit()));
        file->close();

        map_path = "image/map_from_server2.png";
        map1 = cv::imread(map_path.toStdString());
        cv::flip(map1, map1, 0);
        cv::rotate(map1,map1,cv::ROTATE_90_COUNTERCLOCKWISE);

        temp_image = QPixmap::fromImage(mat_to_qimage_cpy(map1)).toImage();

        //Save PNG File
        if(temp_image.save("image/map_from_server_rotated2.png","PNG")){
            qDebug() << "Success to png";
            isMapExist = true;
        }else{
            qDebug() << "Fail to png";
        }
        delete file;



        file = new QFile(QGuiApplication::applicationDirPath()+"/setting/annotation_server.ini");
        file->open(QIODevice::WriteOnly);
        file->write(QByteArray::fromBase64(json["annot"].toString().toLocal8Bit()));
        file->close();

        file = new QFile(QGuiApplication::applicationDirPath()+"/setting/map_meta_server.ini");
        file->open(QIODevice::WriteOnly);
        file->write(QByteArray::fromBase64(json["meta"].toString().toLocal8Bit()));
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

        static int count = 0;
        qDebug() << count++;
    }else if(socket.state() == QAbstractSocket::ConnectingState){
        ;
    }else{
        connection_status = false;
        if(++cnt%5 == 0){
            socket.open(QUrl("ws://192.168.1.200:22334"));
        }
    }
}

void ServerHandler::sendMap(QString map_path, QString dir){
    QFile* file = new QFile(map_path);
    file->open(QIODevice::ReadOnly);
    QByteArray ba_map = file->readAll();
    file->close();
    delete file;

    file = new QFile(QGuiApplication::applicationDirPath()+"/image/map_server.png");
    file->open(QIODevice::ReadOnly);
    QByteArray ba_map2 = file->readAll();
    file->close();
    delete file;

    file = new QFile(dir+"map_meta.ini");
    file->open(QIODevice::ReadOnly);
    QByteArray ba_meta = file->readAll();
    file->close();
    delete file;

    file = new QFile(dir+"annotation.ini");
    file->open(QIODevice::ReadOnly);
    QByteArray ba_anot = file->readAll();
    file->close();
    delete file;

    QJsonObject json;
    json["name"] = robot_name;
    json["type"] = "MAP";
    json["raw_map"] = QString(ba_map.toBase64());
    json["annot_map"] = QString(ba_map2.toBase64());
    json["annot"] = QString(ba_anot.toBase64());
    json["meta"] = QString(ba_meta.toBase64());

    QJsonDocument doc(json);
    QString str(doc.toJson(QJsonDocument::Indented));
    socket.sendTextMessage(str);
}
