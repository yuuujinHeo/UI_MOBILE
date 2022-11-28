#ifndef LCMHANDLER_H
#define LCMHANDLER_H

#include <QObject>
#include <QThread>
#include <chrono>
#include <thread>
#include <QTimer>
#include <lcm/lcm-cpp.hpp>
#include "lcm_types/command.hpp"
#include "lcm_types/robot_status.hpp"
#include "lcm_types/map_data_t.hpp"
#include "lcm_types/robot_path.hpp"
//#include "Supervisor.h"
#include "GlobalHeader.h"

class LCMHandler : public QObject
{
    Q_OBJECT
public:
    LCMHandler();
    ~LCMHandler();
    void setMapData(ST_MAP _map);

    // lcm
    lcm::LCM lcm;
    // lcm message loop
    std::atomic<bool> bFlag;
    std::thread* bThread = NULL;
    bool isdownloadMap = false;
    bool flagJoystick = false;
    bool flagPath = false;
    bool flagLocalPath = false;

    bool isdebug = false;
    bool robotnamechanged = false;
    QString debug_robot_name = "";

    ST_ROBOT    robot;
    ST_MAP      map;
    QTimer  *timer;

    ////*********************************************  COMMAND FUNCTIONS   ***************************************************////
    void RequestMap();
    void moveTo(QString target_loc);
    void moveTo(float x, float y, float th);
    void movePause();
    void moveResume();
    void moveJog();
    void moveStop();
    void moveManual();
    void setVelocity(float vel, float velth);
//    void setVelocityXY(float vel);
//    void setVelocityTH(float vel);

    ////*********************************************  CALLBACK FUNCTIONS   ***************************************************////
    void robot_status_callback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const robot_status *msg);
    void map_data_callback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const map_data_t *msg);
    void robot_path_callback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const robot_path *msg);
    void robot_local_path_callback(const lcm::ReceiveBuffer *rbuf, const std::string &chan, const robot_path *msg);

    ////***********************************************   THREADS  ********************************************************////
    void bLoop();

signals:
    void pathchanged();

public slots:
    void onTimer();
};

#endif // LCMHANDLER_H
