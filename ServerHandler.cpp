#include "ServerHandler.h"
#include <iostream>
#include <QUrl>
#include <QDataStream>

using namespace std;
ServerHandler::ServerHandler()
{
    // 네트워크 연결 관리
    manager = new QNetworkAccessManager(this);

    timer = new QTimer();
    connect(timer, SIGNAL(timeout()),this,SLOT(onTimer()));
    timer->start(TIMER_MS);

    myID = getSettingServer("SERVER","my_id");
    checkUpdate();
    sendConfig();
    sendMaps();
    uploadRelease(QDir::homePath()+"/UI_MOBILE_release/MAIN_MOBILE","hello..3");
    uploadRelease(QDir::homePath()+"/UI_MOBILE_release/ExtProcess","hello..3");
    uploadRelease(QDir::homePath()+"/UI_MOBILE_release/autostart.sh","hello..3");
    getGitCommits();
}

void ServerHandler::onTimer(){
    //주기적으로 서버에게 상태를 보냄.
    if(connection){
        if(myID == "serving.001.01.test" || myID == ""){
            getNewID();
        }else if(!send_config){
            sendConfig();
        }else if(!send_map){
            sendMaps();
            TIMER_MS = 60000;
            timer->start(TIMER_MS);
        }else{
            postStatus();
        }
    }
}

void ServerHandler::postStatus(){
    ClearJson(json_out);
    json_out["id"] = myID;
    json_out["battery"] = probot->battery;
    json_out["git_version"] = getSetting("ROBOT_SW","version_date");

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

    json_out["path_size"] = probot->curPath.size();
    for(int i=0; i<probot->curPath.size(); i++){
        json_out["path_x_"+QString::number(i)] = QString::number(probot->curPath[i].point.x);
        json_out["path_y_"+QString::number(i)] = probot->curPath[i].point.y;
        json_out["path_th_"+QString::number(i)] = probot->curPath[i].angle;
    }

    QByteArray temp_array = QJsonDocument(json_out).toJson();
    generalPost(temp_array,serverURL+"/setstatus");
}

void ServerHandler::uploadRelease(QString file, QString message){
//    QString dir = QDir::homePath()+"/UI_MOBILE_release/MAIN_MOBILE";
    QFile exe(file);
    if(exe.open(QIODevice::ReadOnly)){
        sendfilePost(file, serverURL+"/upload/release/"+myID+"/"+message);
    }else{
        plog->write("[SERVER] Send UI : Failed (File not open)");
    }
}

void ServerHandler::setSettingServer(QString name, QString value){
    QString ini_path = QDir::homePath()+"/server_config.ini";
    QSettings setting(ini_path, QSettings::IniFormat);
    setting.setValue(name,value);
    plog->write("[SETTING] SET "+name+" VALUE TO "+value);
}

void ServerHandler::setSetting(QString name, QString value){
    QString ini_path = QDir::homePath()+"/robot_config.ini";
    QSettings setting(ini_path, QSettings::IniFormat);
    setting.setValue(name,value);
    plog->write("[SETTING] SET "+name+" VALUE TO "+value);
}

void ServerHandler::checkUpdate(){
    plog->write("[SERVER] Check Update"+myID);
    generalGet(serverURL+"/update/"+myID);

}

void ServerHandler::getNewID(){
    ClearJson(json_out);
    json_out["server_group"] = getSettingServer("SERVER","server_group");
    json_out["server_name"] = getSettingServer("SERVER","server_name");
    json_out["id"] = myID;
    json_out["platform_name"] = getSetting("ROBOT_HW","model");

    QByteArray temp_array = QJsonDocument(json_out).toJson();
//    qDebug() << temp_array;

    generalPost(temp_array,serverURL+"/setting/getname");
}

bool ServerHandler::need_update(){
    if(connection){
        return new_update;
    }else{
        return new_update_local;
    }
}

void ServerHandler::getGitCommits(){
    plog->write("[SERVER] CMD : Get Git Commits");
    generalGet("https://api.github.com/repos/yuuujinHeo/UI_MOBILE_release/commits");
}

void ServerHandler::sendConfig(){
    QString dir = QDir::homePath()+"/robot_config.ini";
    QFile config(dir);
    send_config = true;
    if(config.open(QIODevice::ReadOnly)){
        sendfilePost(dir, serverURL+"/upload/config/"+myID);
    }else{
        plog->write("[SERVER] Send Config : Failed (File not open)");
    }
}

void ServerHandler::sendMaps(){
    ZIPHandler zip;
    send_map = true;
    zip.makeMapZip(QDir::homePath(),getSetting("FLOOR","map_name"));
    QString dir = QDir::homePath()+"/"+getSetting("FLOOR","map_name")+".zip";
    QFile config(dir);
    if(config.open(QIODevice::ReadOnly)){
        sendfilePost(dir, serverURL+"/upload/map/"+myID);
    }else{
        plog->write("[SERVER] Send Map : Failed (File not open)");
    }


}

QString ServerHandler::getSetting(QString group, QString name){
    QString ini_path = QDir::homePath()+"/robot_config.ini";
    QSettings setting_robot(ini_path, QSettings::IniFormat);
    setting_robot.beginGroup(group);
    return setting_robot.value(name).toString();
}

QString ServerHandler::getSettingServer(QString group, QString name){
    QString ini_path = QDir::homePath()+"/server_config.ini";
    QSettings setting_robot(ini_path, QSettings::IniFormat);
    setting_robot.beginGroup(group);
    return setting_robot.value(name).toString();
}

void ServerHandler::sendfilePost(QString file_dir, QString url){
    QUrl serviceURL(url);
    QNetworkRequest request(serviceURL);

    QHttpMultiPart *files = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    QStringList file_dirs = file_dir.split("/");
    QString filename = file_dirs[file_dirs.size()-1];

    QHttpPart filepart;
    filepart.setHeader(QNetworkRequest::ContentDispositionHeader,QVariant("form-data; name=\"file\"; filename=\""+filename+"\""));
    QFile *file = new QFile(file_dir);
    file->open(QIODevice::ReadOnly);
    filepart.setBody(file->readAll());
    file->setParent(files);

    files->append(filepart);

    quint32 random[6];
    QRandomGenerator::global()->fillRange(random);
    QByteArray boundary = "--boundary_zyl_"+ QByteArray::fromRawData(reinterpret_cast<char *>(random),sizeof(random)).toBase64();

    QByteArray contentType;
    contentType += "multipart/";
    contentType += "form-data";
    contentType += "; boundary=";
    contentType += boundary;
    files->setBoundary(boundary);
    request.setHeader(QNetworkRequest::ContentTypeHeader, contentType);

    QNetworkReply *reply = manager->post(request, files);
    connect(reply, &QNetworkReply::finished, [=](){
        files->setParent(reply);
        parsingReply("POST",url,reply);
    });
}
// 공통적으로 사용되는 POST 구문 : 출력으로 응답 정보를 보냄
void ServerHandler::generalPost(QByteArray post_data, QString url){
    QByteArray postDataSize = QByteArray::number(post_data.size());
    QUrl serviceURL(url);
    QNetworkRequest request(serviceURL);
    request.setRawHeader("Content-Type", "application/json");
    request.setRawHeader("Content-Length", postDataSize);
    request.setRawHeader("Connection", "Keep-Alive");
    request.setRawHeader("AcceptEncoding", "gzip, deflate");
    request.setRawHeader("AcceptLanguage", "ko-KR,en,*");

    QNetworkReply *reply = manager->post(request, post_data);
    connect(reply, &QNetworkReply::finished, [=](){
        parsingReply("POST",url,reply);
    });
}

void ServerHandler::parsingReply(QString type, QString url, QNetworkReply *reply){
    if(reply->error() == QNetworkReply::NoError){
        if(url.left(22) == "https://api.github.com"){
            QByteArray response = reply->readAll();
            ClearJson(json_in);
            QJsonArray git_array = QJsonDocument::fromJson(response).array();
            probot->gitList.clear();

            for(int i=0; i<git_array.size(); i++){
                ST_GIT temp_git;
                temp_git.date = git_array[i].toObject()["commit"].toObject()["author"].toObject()["date"].toString();
                temp_git.commit = git_array[i].toObject()["sha"].toString();
                temp_git.message = git_array[i].toObject()["commit"].toObject()["message"].toString();
                probot->gitList.push_back(temp_git);
            }

            for(int i=0; i<probot->gitList.size(); i++){
                if(i==0){
                    plog->write("[SERVER] GET GIT RECENT COMMIT : "+probot->gitList[i].commit+", "+probot->gitList[i].date+", "+probot->gitList[i].message);
                }else{
                    qDebug() << probot->gitList[i].commit << probot->gitList[i].date << probot->gitList[i].message;
                }
            }

            if(probot->gitList.size() > 0){
                if(probot->gitList[0].date == probot->program_date){
                    new_update_local = false;
                    plog->write("[SERVER] PROGRAM ALREADY UPDATED "+probot->gitList[0].date);
                }else{
                    new_update_local = true;
                    plog->write("[SERVER] PROGRAM NEED UPDATE "+probot->program_date);
                }
            }
        }else{
            first_response = true;
            QString cmd = url.remove(0,23);
            QByteArray response = reply->readAll();
            if(type == "POST"){
                if(cmd == "/setting/getname"){
                    if(response.contains("status")){

                    }else{
                        ClearJson(json_in);
                        json_in = QJsonDocument::fromJson(response).object();
                        myID = json_in["id"].toString();
                        if(myID != "" || getSettingServer("SERVER","my_id") != ""){
                            plog->write("[SERVER] Get New Name : "+myID);
                            setSettingServer("SERVER/my_id",myID);
                        }
                    }
                }else if(cmd == "/setstatus"){
                    if(response == ""){
                        if(connection){
                            plog->write("[SERVER] Post Status : Failed");
                            connection = false;
                        }
                    }
                    ClearJson(json_in);
                    json_in = QJsonDocument::fromJson(response).object();
                    if(json_in["id"].toString() == myID){
                        TIMER_MS = json_in["activate_level"].toString().toInt();

                        if(json_in["server_group"].toString() != ""){
                            if(getSettingServer("SERVER","server_group") != json_in["server_group"].toString()){
                                setSettingServer("SERVER/server_group",json_in["server_group"].toString());
                            }
                        }
                        if(json_in["server_name"].toString() != ""){
                            if(getSettingServer("SERVER","server_name") != json_in["server_name"].toString()){
                                setSettingServer("SERVER/server_name",json_in["server_name"].toString());
                            }
                        }
                //        qDebug() << "timer ms = " << TIMER_MS << json_in["activate_level"].toString() << json_in["activate_level"].toString().toInt();
                        timer->start(TIMER_MS);
                    }

                }else if(cmd == "/upload/config/"+myID){
                    plog->write("[SERVER] Upload Config : Done");
                }else if(cmd == "/upload/map/"+myID){
                    plog->write("[SERVER] Upload Map : Done");
                }
            }else if(type == "GET"){
                if(cmd == "/update/"+myID){
                    QJsonObject temp = QJsonDocument::fromJson(response).object();
                    if(temp.size() > 0){
                        if(temp["id"] == myID){
                            update_auto = temp["update_auto"].toBool();
                            update_config = temp["update_config"].toBool();
                            update_program = temp["update_program"].toBool();
                            update_map = temp["update_maps"].toBool();
                            config_version = temp["config_version"].toString();
                            program_version = temp["program_version"].toString();
                            maps_version = temp["maps_version"].toString();
                            config_str = temp["config_version_str"].toString();
                            program_str = temp["program_version_str"].toString();
                            maps_str = temp["maps_version_str"].toString();
                            message = temp["message"].toString();
                            plog->write("[SERVER] New Update Detect : "+QVariant(update_auto).toString()+","+QVariant(update_program).toString()+","+QVariant(update_config).toString()
                                        +","+QVariant(update_map).toString()+","+program_version+","+config_version+","+maps_version);

                            if(update_auto){
                                setSetting("ROBOT_SW/update_auto","true");
                            }else{
                                setSetting("ROBOT_SW/update_auto","false");
                            }

                            new_update = false;
                            if(update_config){
                                if(config_version != getSetting("ROBOT_SW","config_version")){
                                    plog->write("[SERVER] NEW UPDATE(CONFIG) : OLD("+getSetting("ROBOT_SW","config_version")+") NEW("+config_version+")");
                                    new_update = true;
                                }

                            }

                            if(update_program){
                                if(program_version != getSetting("ROBOT_SW","version")){
                                    plog->write("[SERVER] NEW UPDATE(CONFIG) : OLD("+getSetting("ROBOT_SW","version")+") NEW("+program_version+")");
                                    new_update = true;
                                    ST_GIT temp_git;
                                    temp_git.date = program_str;
                                    temp_git.message = "";
                                    temp_git.commit = program_version;
                                    probot->gitList.clear();
                                    probot->gitList.append(temp_git);
                                }
                            }
                            if(update_map){
                                if(maps_version != getSetting("ROBOT_SW","map_version")){
                                    plog->write("[SERVER] NEW UPDATE(CONFIG) : OLD("+getSetting("ROBOT_SW","maps_version")+") NEW("+maps_version+")");
                                    new_update = true;
                                }
                            }
                        }else{
                            new_update  = false;
                        }
                    }else{
                        new_update  = false;
                    }

                }
            }
        }
    }else{
        QString err = reply->errorString();
        if(err == "Socket operation timed out"){
            if(connection){
                plog->write("[Server] Time out : disconnected");
                connection = false;
            }
        }
    }
    delete reply;
}

void ServerHandler::generalGet(QString url){
    QUrl serviceURL(url);
    QNetworkRequest request(serviceURL);
    request.setRawHeader("Content-Type","application./json");

    QNetworkReply *reply = manager->get(request);
    connect(reply, &QNetworkReply::finished, [=](){
        parsingReply("GET",url,reply);
    });
}
void ServerHandler::generalPut(QString url, QByteArray put_data){
    QUrl serviceURL(url);
    QNetworkRequest request(serviceURL);

    QNetworkReply *reply = manager->put(request, put_data);
    connect(reply, &QNetworkReply::finished, [=](){
        parsingReply("PUT",url,reply);
    });
}

void ServerHandler::generalDelete(QString url){
    QUrl serviceURL(url);
    QNetworkRequest request(serviceURL);

    QNetworkReply *reply = manager->deleteResource(request);
    connect(reply, &QNetworkReply::finished, [=](){
        parsingReply("DELETE",url,reply);
    });
}

void ServerHandler::ClearJson(QJsonObject &json){
    QStringList keys = json.keys();
    for(int i=0; i<keys.size(); i++){
        json.remove(keys[i]);
    }
}
