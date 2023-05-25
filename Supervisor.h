#ifndef SUPERVISOR_H
#define SUPERVISOR_H

#include <QObject>
#include <QTimer>
#include <QThread>
#include <QQuickWindow>
#include "GlobalHeader.h"
#include "LCMHandler.h"
#include "JoystickHandler.h"
#include "CallbellHandler.h"
#include "HTTPHandler.h"
#include "ZIPHandler.h"
#include "IPCHandler.h"
#include "MapView.h"
#include <libusb-1.0/libusb.h>

#define MOTOR_RUN(x)            ((x)&0x01)
#define MOTOR_MOD_ERROR(x)      ((x>>1)&0x01)
#define MOTOR_JAM_ERROR(x)      ((x>>2)&0x01)
#define MOTOR_CUR_ERROR(x)      ((x>>3)&0x01)
#define MOTOR_BIG_ERROR(x)      ((x>>4)&0x01)
#define MOTOR_INP_ERROR(x)      ((x>>5)&0x01)
#define MOTOR_PS_ERROR(x)       ((x>>6)&0x01)
#define MOTOR_COL_ERROR(x)      ((x>>7)&0x01)

enum{
    PATROL_NONE = 0,
    PATROL_RANDOM,
    PATROL_SEQUENCE
};

class Supervisor : public QObject
{
    Q_OBJECT
public:
    explicit Supervisor(QObject *parent = nullptr);
    ~Supervisor();
public:

    ////*********************************************  FLAGS   ***************************************************////
    int ui_cmd;
    bool flag_read_ini = false;
    bool isaccepted;
    bool flag_clear;
    int patrol_mode = PATROL_NONE;
    bool patrol_use_pickup = false;
    int state_rotate_tables;

    ////*********************************************  STRUCT   ***************************************************////
    ST_MAP map;
    ST_ROBOT robot;
    ST_SETTING setting;
    ST_PATROLMODE patrol;

    ////*********************************************  VARIABLE   ***************************************************////
    QStringList usb_list;
    QStringList usb_file_full_list;
    QStringList usb_file_list;
    QStringList usb_backup_list;
    QVector<QString> usb_map_list;
    QVector<QString> map_list;
    QVector<QString> map_detail_list;

    int count_excuseme = 0;
    bool flag_excuseme = false;

    QVector<QString> call_list;
    int setting_call_id = -1;

//    QString cur_location;

    ////*********************************************  CLASS   ***************************************************////
    LCMHandler *lcm;
    ZIPHandler *zip;
    JoystickHandler *joystick;
    HTTPHandler *git;
    CallbellHandler *call;
    IPCHandler *ipc;
    QProcess *slam_process;



    Q_INVOKABLE bool checkINI();
    void checkShellFiles();
    void makeKillShell();
    void makeKillSlam();
    void makeStartShell();
    void makeAllKillShell();


    ////*********************************************  IPC 관련   ***************************************************////
    Q_INVOKABLE bool isIPCused(){return probot->ipc_use;}

    ////*********************************************  LCM 관련   ***************************************************////
    Q_INVOKABLE bool getLCMConnection();
    Q_INVOKABLE bool getLCMRX();
    Q_INVOKABLE bool getLCMTX();
    Q_INVOKABLE bool getLCMProcess();

    ////*********************************************  WINDOW 관련   ***************************************************////
    void setWindow(QQuickWindow* Window);
    QQuickWindow *getWindow();
    void setObject(QObject* object);
    QObject* getObject();
    Q_INVOKABLE void programRestart();
    Q_INVOKABLE void programExit();
    Q_INVOKABLE void programHide();
    Q_INVOKABLE void writelog(QString msg);
    Q_INVOKABLE QString getRawMapPath(QString name);
    Q_INVOKABLE QString getMapPath(QString name);
    Q_INVOKABLE QString getAnnotPath(QString name);
    Q_INVOKABLE QString getMetaPath(QString name);
    Q_INVOKABLE QString getTravelRawPath(QString name);
    Q_INVOKABLE QString getTravelPath(QString name);
    Q_INVOKABLE QString getCostPath(QString name);
    Q_INVOKABLE QString getIniPath();

    ////*********************************************  SETTING 관련   ***************************************************////
    Q_INVOKABLE void setSetting(QString name, QString value);
    Q_INVOKABLE void readSetting(QString map_name="");
    Q_INVOKABLE QString getSetting(QString group, QString name);
    Q_INVOKABLE void setVelocity(float vel);
    Q_INVOKABLE float getVelocity();

    Q_INVOKABLE int getTrayNum();
    Q_INVOKABLE int getTableNum();
    Q_INVOKABLE void setTableNum(int table_num);
    Q_INVOKABLE void setTableColNum(int col_num);


    Q_INVOKABLE QString getRobotType();

    Q_INVOKABLE void requestCamera();
    Q_INVOKABLE QString getLeftCamera();
    Q_INVOKABLE QString getRightCamera();
    Q_INVOKABLE void setCamera(QString left, QString right);
    Q_INVOKABLE int getCameraNum();
    Q_INVOKABLE QList<int> getCamera(int num);
    Q_INVOKABLE QString getCameraSerial(int num);


    Q_INVOKABLE void pullGit();
    Q_INVOKABLE bool isNewVersion();
    Q_INVOKABLE QString getLocalVersion();
    Q_INVOKABLE QString getServerVersion();
    Q_INVOKABLE QString getLocalVersionDate();
    Q_INVOKABLE QString getServerVersionDate();
    Q_INVOKABLE QString getLocalVersionMessage();
    Q_INVOKABLE QString getServerVersionMessage();

    QNetworkSession *temp_wifi;
    QStringList wifi_list;
    Q_INVOKABLE void readWifi();
    Q_INVOKABLE int getWifiNum();
    Q_INVOKABLE QString getWifiSSD(int num);
    Q_INVOKABLE void connectWifi(QString ssd, QString passwd);


    QStringList curLog;
    QString log_folder = "ui_log";
    Q_INVOKABLE void setLog(int num){
        if(num==1){
            log_folder = "ui_log";
        }else{
            log_folder = "sn_log";
        }
    }
    Q_INVOKABLE void goSerivng(int group, int table);
    Q_INVOKABLE int getLogLineNum();
    Q_INVOKABLE QString getLogLine(int num){return curLog[num];}
    Q_INVOKABLE QString getLogDate(int num);
    Q_INVOKABLE QString getLogAuth(int num);
    Q_INVOKABLE QString getLogMessage(int num);
    Q_INVOKABLE void readLogList();
    Q_INVOKABLE void readLog(QDateTime date);
    Q_INVOKABLE void readLog(int year, int month, int date);
    Q_INVOKABLE bool isHasLog(QDateTime date);
    Q_INVOKABLE bool isHasLog(int year, int month, int date);
    Q_INVOKABLE QString getLocaleDate(int year, int month, int date){
        return QString().sprintf("%d-%02d-%02d",year,month,date);
    }

    void makeUSBShell();
    Q_INVOKABLE void updateUSB();
    Q_INVOKABLE int getusbsize();
    Q_INVOKABLE void readusbfile(QString name);
    Q_INVOKABLE void readusbrecentfile();
    Q_INVOKABLE int getusbfilesize();
    Q_INVOKABLE QString getusbfile(int num);
    Q_INVOKABLE QString getusbrecentfile();
    Q_INVOKABLE QString getusbname(int num);
    Q_INVOKABLE void readusb();


    ////*********************************************  INIT PAGE 관련   ***************************************************////
    Q_INVOKABLE bool isConnectServer();
    //0:no map, 1:map_server, 2: map_edited only, 3:raw_map only
    Q_INVOKABLE bool isExistMap(QString name);
    Q_INVOKABLE bool isExistRawMap(QString name);
    Q_INVOKABLE bool isExistMap();
    Q_INVOKABLE int getAvailableMap();
    Q_INVOKABLE QString getAvailableMapPath(int num);
    Q_INVOKABLE int getMapFileSize(QString name);
    Q_INVOKABLE QString getMapFile(int num);
    Q_INVOKABLE bool isExistTravelRaw(QString name);
    Q_INVOKABLE bool isExistTravelEdited(QString name);
    Q_INVOKABLE bool isExistAnnotation(QString name);
    Q_INVOKABLE void deleteAnnotation();
    Q_INVOKABLE bool isUSBFile();
    Q_INVOKABLE QString getUSBFilename();
    Q_INVOKABLE bool loadMaptoUSB();
    Q_INVOKABLE void removeMap(QString filename);
    Q_INVOKABLE bool isloadMap();
    Q_INVOKABLE void setloadMap(bool load);
    Q_INVOKABLE bool isExistRobotINI();
    Q_INVOKABLE void makeRobotINI();
    Q_INVOKABLE bool rotate_map(QString _src, QString _dst, int mode);
    Q_INVOKABLE bool getIniRead();
    Q_INVOKABLE void saveMapfromUsb(QString path);
    Q_INVOKABLE void loadMap(QString name);
    Q_INVOKABLE void setMap(QString name);
    Q_INVOKABLE void restartSLAM();

    Q_INVOKABLE void startSLAM();

    ////*********************************************  SLAM(LOCALIZATION) 관련   ***************************************************////
    Q_INVOKABLE void startMapping(float grid);
    Q_INVOKABLE void stopMapping();
    Q_INVOKABLE void setSLAMMode(int mode);
    Q_INVOKABLE void saveMapping(QString name);

    Q_INVOKABLE void startObjecting();
    Q_INVOKABLE void stopObjecting();
    Q_INVOKABLE void saveObjecting();

    Q_INVOKABLE void setInitPos(int x, int y, float th);
    Q_INVOKABLE float getInitPoseX();
    Q_INVOKABLE float getInitPoseY();
    Q_INVOKABLE float getInitPoseTH();

    Q_INVOKABLE void slam_setInit();
    Q_INVOKABLE void slam_run();
    Q_INVOKABLE void slam_stop();
    Q_INVOKABLE void slam_autoInit();
    Q_INVOKABLE bool is_slam_running();

    Q_INVOKABLE bool getMappingflag();
    Q_INVOKABLE void setMappingflag(bool flag);

    Q_INVOKABLE bool getObjectingflag();
    Q_INVOKABLE void setObjectingflag(bool flag);

    Q_INVOKABLE QString getnewMapname();

    ////*********************************************  CALLING 관련   ***************************************************////
    Q_INVOKABLE QString getLastCall(){return call->getBellID();}
    Q_INVOKABLE int getCallSize(){return call_list.size();}
    Q_INVOKABLE QString getCall(int id){return call_list[id];}
    Q_INVOKABLE QString getCallName(QString id);
    Q_INVOKABLE void setCallbell(int id);
    Q_INVOKABLE void acceptCall(bool yes);
    Q_INVOKABLE void removeCall(int id);
    Q_INVOKABLE void removeCallAll();

    LOCATION getloc(QString name){
        for(int i=0; i<pmap->locations.size(); i++){
            if(pmap->locations[i].name == name)
                return pmap->locations[i];
        }
        return LOCATION();
    }

    ////*********************************************  JOYSTICK 관련   ***************************************************////
    Q_INVOKABLE bool isconnectJoy();
    Q_INVOKABLE float getJoyAxis(int num);
    Q_INVOKABLE int getJoyButton(int num);
    Q_INVOKABLE QString getKeyboard(int mode);
    Q_INVOKABLE QString getJoystick(int mode);


    bool isSameLocation(LOCATION l1, LOCATION l2){
        if(l1.group == l2.group && l1.number == l2.number && l1.name == l2.name){
            return true;
        }
        return false;
    }
    ////*********************************************  ANNOTATION 관련   ***************************************************////

    Q_INVOKABLE void setObjPose();
    Q_INVOKABLE QString getServingName(int group, int num);
//    Q_INVOKABLE int getLocation
    Q_INVOKABLE int getLocationNum(QString type="");
    Q_INVOKABLE QString getLocationName(int num, QString type="");
    Q_INVOKABLE QString getLocationType(int num);
    Q_INVOKABLE int getLocationNumber(int group, int num);
    Q_INVOKABLE void setLocationNumber(QString name, int num);
    Q_INVOKABLE int getLocationSize(QString type);
    Q_INVOKABLE QString getLocationGroup(int num);
    Q_INVOKABLE int getLocationGroupNum();
    Q_INVOKABLE int getLocationGroupSize(int num);
    Q_INVOKABLE int getLocationGroupNum(int num);
    Q_INVOKABLE void addLocationGroup(QString name);
    Q_INVOKABLE QString getLocGroupname(int num);
    Q_INVOKABLE void setLocation(int num, QString name, int group, int tablenum);

    Q_INVOKABLE float getLocationX(int num, QString type="");
    Q_INVOKABLE float getLocationY(int num, QString type="");
    Q_INVOKABLE float getLocationTH(int num, QString type="");

    Q_INVOKABLE bool isExistLocation(int group, int num);
    Q_INVOKABLE float getLidar(int num);

    Q_INVOKABLE bool getAnnotEditFlag();
    Q_INVOKABLE void setAnnotEditFlag(bool flag);

    Q_INVOKABLE void clearSharedMemory();

    //***********************************************************************Object(INI)..
    Q_INVOKABLE int getObjectNum();
    Q_INVOKABLE QString getObjectName(int num);
    Q_INVOKABLE int getObjectPointSize(int num);
    Q_INVOKABLE float getObjectX(int num, int point);
    Q_INVOKABLE float getObjectY(int num, int point);


    //***********************************************************************Object(NEW)..
    Q_INVOKABLE int getObjPointNum(int obj_num, int x, int y);
    Q_INVOKABLE int getLocNum(QString name);
    Q_INVOKABLE int getLocNum(int x, int y);

    Q_INVOKABLE int getObjectSize(QString type);
    Q_INVOKABLE void removeObject(int num);
    Q_INVOKABLE void removeLocation(QString name);

    //******************************************************************Travel line
    Q_INVOKABLE bool saveAnnotation(QString filename);






    ////*********************************************  SCHEDULER(SERVING) 관련   ***************************************************////
    Q_INVOKABLE void setTray(int tray_num, int table_num);
    Q_INVOKABLE void setPreset(int preset);
    Q_INVOKABLE void confirmPickup();
    Q_INVOKABLE QVector<int> getPickuptrays();



    ////*********************************************  ROBOT MOVE 관련   ***************************************************////
//    Q_INVOKABLE void moveTo(QString target_num);
    Q_INVOKABLE void moveToServing(QString target, int preset);
    Q_INVOKABLE void moveTo(QString target, int preset);
    Q_INVOKABLE void moveTo(float x, float y, float th);
    Q_INVOKABLE void moveToLast();
    Q_INVOKABLE void movePause();
    Q_INVOKABLE void moveResume();
    Q_INVOKABLE void moveStop();
    Q_INVOKABLE void moveManual();
    Q_INVOKABLE void moveToCharge();
    Q_INVOKABLE void moveToWait();
    Q_INVOKABLE QString getcurLoc();
    Q_INVOKABLE QString getcurTable();

    Q_INVOKABLE void joyMoveXY(float x);
    Q_INVOKABLE void joyMoveR(float r);
    Q_INVOKABLE float getJoyXY();
    Q_INVOKABLE float getJoyR();
    Q_INVOKABLE void resetHomeFolders();

    Q_INVOKABLE bool issetLocation(int number);
    Q_INVOKABLE QString getServingName(int number);


    ////*********************************************  ROBOT STATUS 관련   ***************************************************////
    Q_INVOKABLE float getBattery();
    Q_INVOKABLE int getMotorState();
    Q_INVOKABLE int getLocalizationState();
    Q_INVOKABLE int getStateMoving();
    Q_INVOKABLE int getObsState();
    Q_INVOKABLE int getErrcode();
    Q_INVOKABLE QString getRobotName();

    Q_INVOKABLE bool getMotorConnection(int id);
    Q_INVOKABLE int getMotorStatus(int id);
    Q_INVOKABLE QString getMotorStatusStr(int id);
    Q_INVOKABLE int getMotorTemperature(int id);
    Q_INVOKABLE int getMotorInsideTemperature(int id);
    Q_INVOKABLE int getMotorWarningTemperature();
    Q_INVOKABLE int getMotorCurrent(int id);
    Q_INVOKABLE int getPowerStatus();
    Q_INVOKABLE int getRemoteStatus();
    Q_INVOKABLE int getChargeStatus();
    Q_INVOKABLE int getEmoStatus();
    Q_INVOKABLE float getBatteryIn();
    Q_INVOKABLE float getBatteryOut();
    Q_INVOKABLE float getBatteryCurrent();
    Q_INVOKABLE float getPower();
    Q_INVOKABLE float getPowerTotal();

    Q_INVOKABLE float getRobotRadius();
    Q_INVOKABLE float getRobotx();
    Q_INVOKABLE float getRoboty();
    Q_INVOKABLE float getRobotth();
    Q_INVOKABLE float getlastRobotx();
    Q_INVOKABLE float getlastRoboty();
    Q_INVOKABLE float getlastRobotth();

    Q_INVOKABLE int getPathNum();
    Q_INVOKABLE float getPathx(int num);
    Q_INVOKABLE float getPathy(int num);
    Q_INVOKABLE float getPathth(int num);
    Q_INVOKABLE int getLocalPathNum();
    Q_INVOKABLE float getLocalPathx(int num);
    Q_INVOKABLE float getLocalPathy(int num);

    Q_INVOKABLE int getuistate();
    Q_INVOKABLE void initdone();

    ////*********************************************  MAP IMAGE 관련   ***************************************************////
    Q_INVOKABLE QString getMapname();
    Q_INVOKABLE QString getMappath();
    Q_INVOKABLE int getMapWidth();
    Q_INVOKABLE int getMapHeight();
    Q_INVOKABLE float getGridWidth();
    Q_INVOKABLE QVector<int> getOrigin();

    ////*********************************************  OBJECTING 관련   ***************************************************////

    ////*********************************************  PATROL 관련   ***************************************************////
    Q_INVOKABLE void runRotateTables();
    Q_INVOKABLE void stopRotateTables();

    QStringList patrol_list;
    int patrol_num;
    Q_INVOKABLE void clearRotateList();
    Q_INVOKABLE void setRotateList(QString name);
    Q_INVOKABLE void startPatrol(QString mode, bool pickup);

    Q_INVOKABLE void startServingTest();
    Q_INVOKABLE void stopServingTest();

    Q_INVOKABLE int getusberrorsize();
    Q_INVOKABLE QString getusberror(int num);
    Q_INVOKABLE int getzipstate();
    Q_INVOKABLE void usbsave(QString usb="", bool _ui=true, bool _slam=true, bool _config=true, bool _map=true, bool _log=true);
public slots:
    void onTimer();
    void path_changed();
    void camera_update();
    void mapping_update();
    void objecting_update();
    void usb_detect();
    void git_pull_failed();
    void git_pull_success();
    void new_call();
    void zip_done();
    void unzip_done();
    void zip_failed();
    void unzip_failed();

private:
    QTimer *timer;
    QQuickWindow *mMain;
    QObject *mObject = nullptr;
};


#endif // SUPERVISOR_H
