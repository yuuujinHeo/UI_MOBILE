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
    QByteArray generalPost(QByteArray post_data, QString url);
    QByteArray generalGet(QString url);
    QByteArray generalPut(QString url, QByteArray put_data);
    QByteArray generalDelete(QString url);
    void ClearJson(QJsonObject &json);

    void postStatus();

    QJsonObject json_in;
    QJsonObject json_out;
    QProcess *process;
private slots:
    void onTimer();
private:
    // 네트워크 커넥션 관리 -----------------
    QNetworkAccessManager   *manager;
    QEventLoop              connection_loop;
    QTimer  *timer;
};

#endif // SERVERHANDLER_H
