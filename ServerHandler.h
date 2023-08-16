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

    void checkUpdate();
    void postStatus();

    QJsonObject json_in;
    QJsonObject json_out;
    QProcess *process;

    QString serverURL = "http://rbyujin.com:8080";
    QString myID = "serving.001.01.test";

private slots:
    void onTimer();

private:
    QNetworkAccessManager   *manager;
    QEventLoop              connection_loop;
    QTimer  *timer;
};

#endif // SERVERHANDLER_H
