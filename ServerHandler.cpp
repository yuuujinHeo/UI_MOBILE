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
}

void ServerHandler::onTimer(){
    //주기적으로 서버에게 상태를 보냄.
    postStatus();
}

void ServerHandler::postStatus(){
    ClearJson(json_out);
    json_out["id"] = "serving.001.0.1";
    json_out["battery"] = 53;

    qDebug() << json_out;
    plog->write("[SERVER] post status : "+QString::number(probot->battery));
    QByteArray temp_array = QJsonDocument(json_out).toJson();

    QByteArray response = generalPost(temp_array,"http://rbyujin.com:8080/setstatus");

    ClearJson(json_in);
    json_in = QJsonDocument::fromJson(response).object();

    qDebug() << json_in;
}

// 공통적으로 사용되는 POST 구문 : 출력으로 응답 정보를 보냄
QByteArray ServerHandler::generalPost(QByteArray post_data, QString url){
    QByteArray postDataSize = QByteArray::number(post_data.size());
    QUrl serviceURL(url);
    QNetworkRequest request(serviceURL);
    qDebug() << serviceURL << url;
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
