#ifndef SUPERVISOR_H
#define SUPERVISOR_H

#include <QObject>
#include <QTimer>
#include <QThread>
#include <QQuickWindow>
#include "GlobalHeader.h"
#include "LCMHandler.h"
#include "ServerHandler.h"

typedef struct{
    QString name;
    bool check;
    int x;
    int y;
}ST_GRID;
class Supervisor : public QObject
{
    Q_OBJECT
public:
    explicit Supervisor(QObject *parent = nullptr);
public:
    enum TOOL_NUM{
        TOOL_MOUSE = 0,
        TOOL_BRUSH,
        TOOL_ERASER
    };
    enum UI_CMD{
        UI_CMD_NONE = 0,
        UI_CMD_MOVE_TABLE,
        UI_CMD_PAUSE,
        UI_CMD_RESUME,
        UI_CMD_MOVE_WAIT,
        UI_CMD_MOVE_CHARGE,
        UI_CMD_PICKUP_CONFIRM,
        UI_CMD_WAIT_KITCHEN,
        UI_CMD_TABLE_PATROL,
        UI_CMD_PATROL_STOP
    };

    enum UI_STATE{
        UI_STATE_NONE = 0,
        UI_STATE_READY,
        UI_STATE_CHARGING,
        UI_STATE_GO_HOME,
        UI_STATE_GO_CHARGE,
        UI_STATE_SERVING,
        UI_STATE_CALLING,
        UI_STATE_PICKUP,
        UI_STATE_PATROLLING,
        UI_STATE_MOVEFAIL
    };

    enum ROBOT_STATE{
        ROBOT_STATE_NOT_READY = 0,
        ROBOT_STATE_READY,
        ROBOT_STATE_MOVING,
        ROBOT_STATE_AVOID,
        ROBOT_STATE_PAUSED,
        ROBOT_STATE_ERROR,
        ROBOT_STATE_MANUALMODE
    };

    enum ROBOT_ERROR{
        ROBOT_ERROR_NONE = 0,
        ROBOT_ERROR_COL,
        ROBOT_ERROR_NO_PATH,
        ROBOT_ERROR_MOTOR_COMM,
        ROBOT_ERROR_MOTOR,
        ROBOT_ERROR_VOLTAGE,
        ROBOT_ERROR_SENSOR
    };

    Q_ENUMS(ROBOT_STATE);
    Q_ENUMS(ROBOT_ERROR);
    Q_ENUMS(UI_STATE);
    Q_ENUMS(UI_CMD);
    Q_ENUMS(TOOL_NUM);

    //Scheduler
    int ui_cmd;
    int ui_state;

    QString robot_name;
    float robot_radius;

    QString debug_name = "C1";
    bool is_debug = false;
    bool read_ini = false;

    ST_MAP map;
    ST_SETTING setting;
    //LCMHandler
    LCMHandler *lcm;
    bool isaccepted;
    bool isMapExist = false;

    void setWindow(QQuickWindow* Window);
    QQuickWindow *getWindow();
    void setObject(QObject* object);
    QObject* getObject();

    void setSetting(QString name, QString value);

    //// ******************************** Init Check ************************************////
    Q_INVOKABLE bool isConnectServer();
    //0:no map, 1:map_server, 2: map_edited only, 3:raw_map only
    Q_INVOKABLE int isExistMap();
    Q_INVOKABLE bool loadMaptoServer();
    Q_INVOKABLE bool isUSBFile();
    Q_INVOKABLE QString getUSBFilename();
    Q_INVOKABLE bool loadMaptoUSB();
    Q_INVOKABLE bool isuseServerMap();
    Q_INVOKABLE void setuseServerMap(bool use);
    Q_INVOKABLE void removeRawMap();
    Q_INVOKABLE void removeEditedMap();
    Q_INVOKABLE void removeServerMap();
    Q_INVOKABLE bool isloadMap();
    Q_INVOKABLE void setloadMap(bool load);
    Q_INVOKABLE bool isExistRobotINI();
    Q_INVOKABLE void makeRobotINI();
    bool rotate_map(QString _src, QString _dst, int mode);
    Q_INVOKABLE bool getLCMConnection();
    Q_INVOKABLE bool getLCMProcess();
    Q_INVOKABLE bool getIniRead();

    //// *********************************** SLAM *********************************** ////
    Q_INVOKABLE void startSLAM();
    Q_INVOKABLE void stopSLAM();
    Q_INVOKABLE void setSLAMMode(int mode);
    Q_INVOKABLE bool isConnectJoystick();
    Q_INVOKABLE QString getKeyboard(int mode);
    Q_INVOKABLE QString getJoystick(int mode);


    //// ********************************* PAGE_ANNOTATION ************************************ ////
    QVector<ST_FPOINT> temp_object;
    QVector<ST_FPOINT> list_obj_uL;
    QVector<ST_FPOINT> list_obj_dR;
    QVector<int> list_margin_obj;
    Q_INVOKABLE void setObjPose();
    Q_INVOKABLE void setMarginObj();
    Q_INVOKABLE void clearMarginObj();
    Q_INVOKABLE void setMarginPoint(int pixel_num);
    Q_INVOKABLE QVector<int> getMarginObj();


    Q_INVOKABLE void programExit();
    Q_INVOKABLE void programHide();
    Q_INVOKABLE void acceptCall(bool yes);

    Q_INVOKABLE void readSetting();
    //Mobile Move Functions
    Q_INVOKABLE void setTray(int tray_num, int table_num);
    Q_INVOKABLE void moveTo(QString target_num);
    Q_INVOKABLE void moveTo(float x, float y, float th);
    Q_INVOKABLE void movePause();
    Q_INVOKABLE void moveResume();
    Q_INVOKABLE void moveStop();
    Q_INVOKABLE void moveManual();
    Q_INVOKABLE void confirmPickup();
    Q_INVOKABLE void moveToCharge();
    Q_INVOKABLE void moveToWait();

    Q_INVOKABLE float getBattery();
    Q_INVOKABLE int getState();
    Q_INVOKABLE int getErrcode();
    Q_INVOKABLE QString getRobotName();
    Q_INVOKABLE void setRobotName(QString name);

    Q_INVOKABLE QVector<int> getPickuptrays();
    Q_INVOKABLE QString getcurLoc();
    Q_INVOKABLE QString getcurTable();
    Q_INVOKABLE QVector<float> getcurTarget();

    Q_INVOKABLE int getImageChunkNum();
//    Q_INVOKABLE int getImageChunkSize();
    Q_INVOKABLE unsigned int getImageSize();

    //// ********************************* SETTING ************************************ ////
    Q_INVOKABLE void setVelocity(float vel);
    Q_INVOKABLE float getVelocityXY();
    Q_INVOKABLE bool getuseTravelline();
    Q_INVOKABLE void setuseTravelline(bool use);
    Q_INVOKABLE int getnumTravelline();
    Q_INVOKABLE void setnumTravelline(int num);

    Q_INVOKABLE int getTrayNum();
    Q_INVOKABLE void setTrayNum(int tray_num);
    Q_INVOKABLE int getTableNum();
    Q_INVOKABLE void setTableNum(int table_num);

    Q_INVOKABLE bool getuseVoice();
    Q_INVOKABLE void setuseVoice(bool use);
    Q_INVOKABLE bool getuseBGM();
    Q_INVOKABLE void setuseBGM(bool use);
    Q_INVOKABLE bool getserverCMD();
    Q_INVOKABLE void setserverCMD(bool use);

    Q_INVOKABLE QString getRobotType();
    Q_INVOKABLE void setRobotType(int type);


    //***********************************************************************Map
    Q_INVOKABLE bool getMapExist();
    Q_INVOKABLE bool getMapState();
    Q_INVOKABLE QString getMapname();
    Q_INVOKABLE QString getMappath();
    Q_INVOKABLE int getMapWidth();
    Q_INVOKABLE int getMapHeight();
    Q_INVOKABLE float getGridWidth();
    Q_INVOKABLE QVector<int> getOrigin();

    Q_INVOKABLE int getLocationNum();
    Q_INVOKABLE QString getLocationTypes(int num);
    Q_INVOKABLE float getLocationx(int num);
    Q_INVOKABLE float getLocationy(int num);
    Q_INVOKABLE float getLocationth(int num);

    ST_POSE setAxis(ST_POSE _pose);
    ST_FPOINT setAxis(ST_FPOINT _point);
    ST_FPOINT canvasTomap(int x, int y);
    ST_POINT mapTocanvas(float x, float y);
    //***********************************************************************Object(INI)..
    Q_INVOKABLE int getObjectNum();
    Q_INVOKABLE QString getObjectName(int num);
    Q_INVOKABLE int getObjectPointSize(int num);
    Q_INVOKABLE float getObjectX(int num, int point);
    Q_INVOKABLE float getObjectY(int num, int point);


    //***********************************************************************Object(NEW)..
//    Q_INVOKABLE void newObjectPoint(int x, int y);
    Q_INVOKABLE int getTempObjectSize();
    Q_INVOKABLE float getTempObjectX(int num);
    Q_INVOKABLE float getTempObjectY(int num);

    Q_INVOKABLE int getObjNum(QString name);
    Q_INVOKABLE int getObjNum(int x, int y);
    Q_INVOKABLE int getObjPointNum(int obj_num, int x, int y);
    Q_INVOKABLE int getLocNum(QString name);
    Q_INVOKABLE int getLocNum(int x, int y);
    Q_INVOKABLE float getRobotRadius();
    Q_INVOKABLE void addObjectPoint(int x, int y);
    Q_INVOKABLE void editObjectPoint(int num, int x, int y);
    Q_INVOKABLE void removeObjectPoint(int num);
    Q_INVOKABLE void removeObjectPointLast();
    Q_INVOKABLE void clearObjectPoints();
    Q_INVOKABLE void addObject(QString name);

    Q_INVOKABLE void removeObject(QString name);
    Q_INVOKABLE void moveObjectPoint(int obj_num, int point_num, int x, int y);

    Q_INVOKABLE void removeLocation(QString name);
    Q_INVOKABLE void addLocation(QString name, int x, int y, float th);
    Q_INVOKABLE void moveLocationPoint(int loc_num, int x, int y, float th);

    //******************************************************************Travel line
    Q_INVOKABLE int getTlineSize();
    Q_INVOKABLE int getTlineSize(int num);
    Q_INVOKABLE QString getTlineName(int num);
    Q_INVOKABLE float getTlineX(int num, int point);
    Q_INVOKABLE float getTlineY(int num, int point);

    Q_INVOKABLE void addTline(int num, int x1, int y1, int x2, int y2);
    Q_INVOKABLE void removeTline(int num, int line);
    Q_INVOKABLE int getTlineNum(QString name);
    Q_INVOKABLE int getTlineNum(int x, int y);


    //********************************************************************Debug
    Q_INVOKABLE void setDebugName(QString name);
    Q_INVOKABLE QString getDebugName();
    Q_INVOKABLE bool getDebugState();
    Q_INVOKABLE void setDebugState(bool isdebug);


    Q_INVOKABLE float getMargin();

    Q_INVOKABLE float getRobotx();
    Q_INVOKABLE float getRoboty();
    Q_INVOKABLE float getRobotth();

    Q_INVOKABLE int getRobotState();
    Q_INVOKABLE int getPathNum();
    Q_INVOKABLE float getPathx(int num);
    Q_INVOKABLE float getPathy(int num);
    Q_INVOKABLE float getPathth(int num);
    Q_INVOKABLE int getLocalPathNum();
    Q_INVOKABLE float getLocalPathx(int num);
    Q_INVOKABLE float getLocalPathy(int num);

    Q_INVOKABLE void joyMoveXY(float x);
    Q_INVOKABLE void joyMoveR(float r);

    //Outlet Functions
    Q_INVOKABLE int getCanvasSize();
    Q_INVOKABLE int getRedoSize();
    Q_INVOKABLE QVector<int> getLineX(int index);
    Q_INVOKABLE QVector<int> getLineY(int index);
    Q_INVOKABLE QString getLineColor(int index);
    Q_INVOKABLE float getLineWidth(int index);

    Q_INVOKABLE void startLine(QString color, float width);
    Q_INVOKABLE void setLine(int x, int y);
    Q_INVOKABLE void stopLine();

    Q_INVOKABLE void undo();
    Q_INVOKABLE void redo();
    Q_INVOKABLE void clear_all();

    Q_INVOKABLE void startRecordPath();
    Q_INVOKABLE void startcurPath();
    Q_INVOKABLE void stopcurPath();
    Q_INVOKABLE void pausecurPath();

    Q_INVOKABLE void runRotateTables();
    Q_INVOKABLE void stopRotateTables();

    Q_INVOKABLE void saveAnnotation(QString filename);
    Q_INVOKABLE void saveMetaData(QString filename);
    Q_INVOKABLE void sendMaptoServer();

    Q_INVOKABLE void setGrid(int x, int y, QString name);
    Q_INVOKABLE void editGrid(int x, int y, QString name);
    Q_INVOKABLE QString getGrid(int x, int y);

    Q_INVOKABLE void make_minimap();

    ServerHandler *server;
    QVector<ST_LINE>    canvas;
    QVector<ST_LINE>    canvas_redo;
    int flag_clear;
    ST_LINE   temp_line;
    QVector<QVector<QString>> minimap_grid;
    cv::Mat minimap;


    bool flag_rotate_tables = false;
    int state_rotate_tables;
    bool flag_joy = false;
    float joyx = 0.;
    float joyy = 0.;
    float joyr = 0.;
    QMap<int, QVector<int>> map_y;

public slots:
    void onTimer();
    void server_cmd_pause();
    void server_cmd_resume();
    void server_cmd_newtarget();
    void server_cmd_newcall();
    void server_cmd_setini();
    void path_changed();

private:
    QTimer *timer;
    QQuickWindow *mMain;
    QObject *mObject = nullptr;
};

#endif // SUPERVISOR_H
