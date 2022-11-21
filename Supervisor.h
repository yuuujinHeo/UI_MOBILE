#ifndef SUPERVISOR_H
#define SUPERVISOR_H

#include <QObject>
#include <QTimer>
#include <QThread>
#include <QQuickWindow>
#include "GlobalHeader.h"
#include "DBHandler.h"
#include "LCMHandler.h"
#include "ServerHandler.h"

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
        UI_CMD_WAIT_KITCHEN
    };

    enum UI_STATE{
        UI_STATE_NONE = 0,
        UI_STATE_READY,
        UI_STATE_MOVING,
        UI_STATE_PAUSED,
        UI_STATE_PICKUP,
        UI_STATE_CHARGE
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
    QVector<ST_FPOINT> temp_object;

    ST_MAP map;
    //LCMHandler
    LCMHandler *lcm;
    bool isaccepted;

    void setWindow(QQuickWindow* Window);
    QQuickWindow *getWindow();
    void setObject(QObject* object);
    QObject* getObject();

    void readSetting();
    //Mobile Move Functions
    Q_INVOKABLE void setTray(int tray1, int tray2, int tray3);
    Q_INVOKABLE void moveTo(QString target_num);
    Q_INVOKABLE void moveTo(float x, float y, float th);
    Q_INVOKABLE void movePause();
    Q_INVOKABLE void moveResume();
    Q_INVOKABLE void moveJog(float vx, float vy, float vth);
    Q_INVOKABLE void moveStop();
    Q_INVOKABLE void moveManual();
    Q_INVOKABLE void setVelocity(float vel, float velth);
    Q_INVOKABLE void confirmPickup();
    Q_INVOKABLE void moveToCharge();
    Q_INVOKABLE void moveToWait();

    Q_INVOKABLE float getBattery();
    Q_INVOKABLE int getState();
    Q_INVOKABLE int getErrcode();
    Q_INVOKABLE QString getRobotName();
    Q_INVOKABLE void setRobotName(QString name);
    Q_INVOKABLE float getVelocityXY();
    Q_INVOKABLE float getVelocityTH();

    Q_INVOKABLE QVector<int> getPickuptrays();
    Q_INVOKABLE QString getcurLoc();
    Q_INVOKABLE QString getcurTable();
    Q_INVOKABLE QVector<float> getcurTarget();

    Q_INVOKABLE int getImageChunkNum();
//    Q_INVOKABLE int getImageChunkSize();
    Q_INVOKABLE unsigned int getImageSize();
    Q_INVOKABLE QString getImageData();

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

    //***********************************************************************Object(INI)..
    Q_INVOKABLE int getObjectNum();
    Q_INVOKABLE QString getObjectName(int num);
    Q_INVOKABLE int getObjectPointSize(int num);
    Q_INVOKABLE float getObjectX(int num, int point);
    Q_INVOKABLE float getObjectY(int num, int point);

    Q_INVOKABLE void clickObject(QString name);
    Q_INVOKABLE void clickObject(float x, float y);

    //***********************************************************************Object(NEW)..
//    Q_INVOKABLE void newObjectPoint(int x, int y);
    Q_INVOKABLE int getTempObjectSize();
    Q_INVOKABLE float getTempObjectX(int num);
    Q_INVOKABLE float getTempObjectY(int num);

    Q_INVOKABLE int getObjNum(QString name);
    Q_INVOKABLE int getObjNum(int x, int y);
    Q_INVOKABLE int getObjPointNum(int obj_num, int x, int y);

    Q_INVOKABLE void addObjectPoint(int x, int y);
    Q_INVOKABLE void editObjectPoint(int num, int x, int y);
    Q_INVOKABLE void removeObjectPoint(int num);
    Q_INVOKABLE void removeObjectPointLast();
    Q_INVOKABLE void clearObjectPoints();
    Q_INVOKABLE void addObject(QString name);

    Q_INVOKABLE void removeObject(QString name);
    Q_INVOKABLE void moveObjectPoint(int obj_num, int point_num, int x, int y);

    Q_INVOKABLE float getMargin();

    Q_INVOKABLE float getRobotx();
    Q_INVOKABLE float getRoboty();
    Q_INVOKABLE float getRobotth();

    Q_INVOKABLE int getRobotState();
    Q_INVOKABLE int getPathNum();
    Q_INVOKABLE float getPathx(int num);
    Q_INVOKABLE float getPathy(int num);
    Q_INVOKABLE float getPathth(int num);

    Q_INVOKABLE void joyMoveXY(float x, float y);
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

    Q_INVOKABLE QString getMapURL();
    Q_INVOKABLE void setMapURL(QString url);

    Q_INVOKABLE QString getDBvalue(QString name);

    Q_INVOKABLE void startRecordPath();
    Q_INVOKABLE void startcurPath();
    Q_INVOKABLE void stopcurPath();
    Q_INVOKABLE void pausecurPath();


    DBHandler  *dbHandler;
    ServerHandler *server;
    QVector<ST_LINE>    canvas;
    QVector<ST_LINE>    canvas_redo;
    int flag_clear;
    ST_LINE   temp_line;

    bool flag_joy = false;
    float joyx = 0.;
    float joyy = 0.;
    float joyr = 0.;

public slots:
    void onTimer();
    void server_cmd_pause();
    void server_cmd_resume();

private:
    QTimer *timer;
    QQuickWindow *mMain;
    QObject *mObject = nullptr;
};

#endif // SUPERVISOR_H
