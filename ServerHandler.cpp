#include "ServerHandler.h"
#include <iostream>
#include <QDataStream>

#define TIMER_MS    3000

using namespace std;
ServerHandler::ServerHandler()
{
    // 네트워크 연결 관리
    manager = new QNetworkAccessManager(this);
    connect(manager, SIGNAL(finished(QNetworkReply*)), &connection_loop, SLOT(quit()));
    timer = new QTimer();
    connect(timer, SIGNAL(timeout()),this,SLOT(onTimer()));
    timer->start(TIMER_MS);

//    checkUpdate();
}

void ServerHandler::onTimer(){
    //주기적으로 서버에게 상태를 보냄.
    postStatus();
}

void ServerHandler::postStatus(){
    ClearJson(json_out);
    json_out["id"] = myID;
    json_out["battery"] = probot->battery;
    json_out["git_version"] = probot->program_date;

    json_out["last_update_time"] = QDateTime::currentDateTime().toString("yyyyMMdd-hhmmss");
    json_out["map_name"] = pmap->map_name;
    json_out["robot_x"] = probot->curPose.point.x;
    json_out["robot_y"] = probot->curPose.point.y;
    json_out["robot_th"] = probot->curPose.angle;
    json_out["velocity_preset"] = probot->cur_preset;

    json_out["state_ui"] = ui_state;
    json_out["state_charge"] = probot->status_charge;
    json_out["state_emo"] = probot->status_emo;
    json_out["state_power"] = probot->status_power;
    json_out["state_moving"] = probot->running_state;
    json_out["state_localization"] = probot->localization_state;
    json_out["state_obs"] = probot->obs_state;
    json_out["state_face"] = probot->obs_in_path_state;
    json_out["state_motorlock"] = probot->status_lock;
    json_out["state_multirobot"] = probot->multirobot_state;

    json_out["motor_connection_1"] = probot->motor[0].connection;
    json_out["motor_state_1"] = probot->motor[0].status;
    json_out["motor_temp_board_1"] = probot->motor[0].temperature;
    json_out["motor_temp_motor_1"] = probot->motor[0].motor_temp;
    json_out["motor_current_1"] = probot->motor[0].current;

    json_out["motor_connection_2"] = probot->motor[1].connection;
    json_out["motor_state_2"] = probot->motor[1].status;
    json_out["motor_temp_board_2"] = probot->motor[1].temperature;
    json_out["motor_temp_motor_2"] = probot->motor[1].motor_temp;
    json_out["motor_current_2"] = probot->motor[1].current;

//    qDebug() << json_out;
//    plog->write("[SERVER] post status : "+QString::number(probot->battery));
    QByteArray temp_array = QJsonDocument(json_out).toJson();

    QByteArray response = generalPost(temp_array,serverURL+"/setstatus");

    ClearJson(json_in);
    json_in = QJsonDocument::fromJson(response).object();

//    qDebug() << json_in;
}

void ServerHandler::setSetting(QString name, QString value){
    QString ini_path = QDir::homePath()+"/robot_config.ini";
    QSettings setting(ini_path, QSettings::IniFormat);
    setting.setValue(name,value);
    plog->write("[SETTING] SET "+name+" VALUE TO "+value);
}
void ServerHandler::checkUpdate(){
    QByteArray response = generalGet(serverURL+"/update/"+myID);

    QJsonObject temp = QJsonDocument::fromJson(response).object();
    if(temp.size() > 0){
        if(temp["id"] == myID){
            update_auto = temp["update_auto"].toBool();
            if(update_auto)
                setSetting("ROBOT_SW/update_auto","true");
            else
                setSetting("ROBOT_SW/update_auto","false");

            update_config = temp["update_config"].toBool();
            update_program = temp["update_program"].toBool();
            update_map = temp["update_maps"].toBool();
            config_version = temp["config_version"].toString();
            program_version = temp["program_version"].toString();
            maps_version = temp["maps_version"].toString();
            plog->write("[SERVER] New Update Detect : "+QVariant(update_auto).toString()+","+QVariant(update_program).toString()+","+QVariant(update_config).toString()
                        +","+QVariant(update_map).toString()+","+program_version+","+config_version+","+maps_version);
            new_update = true;
        }else{
            new_update  = false;
        }
    }else{
        new_update  = false;
    }
}

// 공통적으로 사용되는 POST 구문 : 출력으로 응답 정보를 보냄
QByteArray ServerHandler::generalPost(QByteArray post_data, QString url){
    QByteArray postDataSize = QByteArray::number(post_data.size());
    QUrl serviceURL(url);
    QNetworkRequest request(serviceURL);
//    qDebug() << serviceURL << url;
    request.setRawHeader("Content-Type", "application/json");
    request.setRawHeader("Content-Length", postDataSize);
    request.setRawHeader("Connection", "Keep-Alive");
    request.setRawHeader("AcceptEncoding", "gzip, deflate");
    request.setRawHeader("AcceptLanguage", "ko-KR,en,*");

    QNetworkReply *reply = manager->post(request, post_data);
    connection_loop.exec();

    reply->waitForReadyRead(200);
    QByteArray ret = reply->readAll();
    reply->deleteLater();
    return ret;
}

QByteArray ServerHandler::generalGet(QString url){
    QUrl serviceURL(url);
    QNetworkRequest request(serviceURL);

    QNetworkReply *reply = manager->get(request);
    connection_loop.exec();

    reply->waitForReadyRead(200);
    QByteArray ret = reply->readAll();
    reply->deleteLater();
    return ret;
}

QByteArray ServerHandler::generalPut(QString url, QByteArray put_data){
    QUrl serviceURL(url);
    QNetworkRequest request(serviceURL);

    QNetworkReply *reply = manager->put(request, put_data);
    connection_loop.exec();

    reply->waitForReadyRead(200);
    QByteArray ret = reply->readAll();
    reply->deleteLater();
    return ret;
}

QByteArray ServerHandler::generalDelete(QString url){
    QUrl serviceURL(url);
    QNetworkRequest request(serviceURL);

    QNetworkReply *reply = manager->deleteResource(request);
    connection_loop.exec();

    reply->waitForReadyRead(200);
    QByteArray ret = reply->readAll();
    reply->deleteLater();
    return ret;

}

void ServerHandler::ClearJson(QJsonObject &json){
    QStringList keys = json.keys();
    for(int i=0; i<keys.size(); i++){
        json.remove(keys[i]);
    }
}
