#ifndef SERVERHANDLER_H
#define SERVERHANDLER_H

#include <QObject>
#include <QThread>
#include <QSettings>
#include <QTimer>
#include <chrono>
#include <thread>
#include <math.h>
#include <QWebSocket>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include "GlobalHeader.h"

#define MOVING_TIMER_MS     40

enum{
    MS_STOP = 0,
    MS_MOVE,
    MS_PAUSE
};

class ServerHandler : public QObject
{
    Q_OBJECT
public:
    ServerHandler();
    ~ServerHandler();

    ////*********************************************  FLAGS   ***************************************************////
    //서버 연결상태
    bool isconnect = false;

    ////*********************************************  SEND FUNCTIONS   ***************************************************////
    void sendCalllist();
    void sendMap(QString map_path, QString dir);
    void requestMap();

signals:
    void server_pause();
    void server_resume();
    void server_new_target();
    void server_new_call();
    void server_set_ini();
public slots:
    void onConnected();
    void onDisconnected();
    void onTextMessageReceived(QString message);
    void onBinaryMessageReceived(QByteArray message);

    void onTimer();
private:
    QTimer  *timer;
    QWebSocket  socket;
};

#endif // SERVERHANDLER_H
