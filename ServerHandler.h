#ifndef SERVERHANDLER_H
#define SERVERHANDLER_H

#include <QObject>
#include <QtNetwork>
#include <QTimer>
#include <QDebug>

#include <QGuiApplication>
// json -----------------------
#include <QJsonDocument>
#include <QJsonValue>
#include <QJsonArray>
#include <QJsonObject>

// connection ------------------
#include <QEventLoop>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QUrl>
#include <QNetworkRequest>

#include <QTimer>

#include "GlobalHeader.h"
#include "ZIPHandler.h"

// websocket ------------------
#include <websocket/QtHttpServer.h>
#include <websocket/QtHttpRequest.h>
#include <websocket/QtHttpReply.h>
#include <QApplication>
#include <websocket/QtHttpHeader.h>


class ServerHandler : public QObject
{
    Q_OBJECT
public:
    ServerHandler();
    QByteArray sendfilePost(QString file_dir, QString url);
    QByteArray generalPost(QByteArray post_data, QString url);
    QByteArray generalGet(QString url);
    QByteArray generalPut(QString url, QByteArray put_data);
    QByteArray generalDelete(QString url);
    void ClearJson(QJsonObject &json);
    void setSetting(QString name, QString value);
    void checkUpdate();
    void postStatus();

    void getNewID();
    void sendConfig();
    void sendMaps();

    QString getSetting(QString group, QString name);
    QJsonObject json_in;
    QJsonObject json_out;
    QProcess *process;

    bool connection = true;
    bool send_config = false;
    bool send_map = false;

    bool new_update = false;
    bool update_config = false;
    bool update_program = false;
    bool update_map = false;
    bool update_auto = false;
    QString config_version;
    QString program_version;
    QString maps_version;
    QString config_str;
    QString program_str;
    QString maps_str;
    QString message;


    int TIMER_MS = 1000;
    QString serverURL = "http://rbyujin.com:8080";
    QString myID = "";//"serving.001.01.test34";

private slots:
    void onTimer();
    void response();

private:
    QNetworkAccessManager   *manager;
//    QEventLoop              connection_loop;

    QTimer  *timer;
//    QTimer  *connection_timer;
};

#endif // SERVERHANDLER_H
