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

    QString server_cmd;
    QString target_location;
    ST_POSE target_pose;
    ST_MAP      map;
    ST_ROBOT    robot;
    QString robot_name;
    QSettings map_annotation;

    int ui_state = 0;
    bool is_debug = false;
    QString debug_name = "C1";

    void setMap(ST_MAP _map);
    void setData(QString name, ST_ROBOT _robot, int state);
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
