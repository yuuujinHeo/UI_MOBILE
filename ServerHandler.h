#ifndef SERVERHANDLER_H
#define SERVERHANDLER_H

#include <QObject>
#include <QThread>
#include <QSettings>
#include <QTimer>
#include <chrono>
#include <thread>
#include <math.h>
// websocket
#include <QWebSocket>
// json
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
    int connection_status;
    int client_number;
    bool isMapExist;

    QString server_cmd;
    ST_POSE target_pose;
    ST_MAP      map;
    ST_ROBOT    robot;
    QString robot_name;
    QSettings map_annotation;

    void setMap(ST_MAP _map);
    void setData(QString name, ST_ROBOT _robot);
    void sendMap(QString path);

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
