#ifndef GLOBALHEADER_H
#define GLOBALHEADER_H

#include "Logger.h"
#include <opencv2/opencv.hpp>
#include <QDir>
#include <QPixmap>
#include "cv_to_qt.h"

extern Logger *plog;
extern int ui_state;
extern bool is_debug;

typedef struct{
    int x;
    int y;
}ST_POINT;

typedef struct{
    QString name;
    bool check;
    int x;
    int y;
}ST_GRID;

typedef struct{
    QVector<ST_POINT>   line;
    QString     color;
    float      width;
}ST_LINE;

typedef struct{
    float x = 0;
    float y = 0;
    float th = 0;
}ST_POSE;
typedef struct{
    float x = 0;
    float y = 0;
}ST_FPOINT;

typedef struct{
    QString type;
    bool is_rect;
    QVector<ST_FPOINT> pose;
}ST_OBJECT;

typedef struct{
    QString type;
    QString name;
    ST_POSE pose;
}ST_LOCATION;

typedef struct{
    QString serial;
    int imageSize = 0;
    QList<int> data;
    int width;
    int height;
}ST_CAMERA;

typedef struct{
    QString commit;
    QString message;
    QString date;
}ST_GIT;

typedef struct{
    int chunkSize = 0;
    int imageSize = 0;
    QVector<int> data;
    QPixmap test_mapping;

    QVector<ST_CAMERA> camera_info;
    QString left_camera;
    QString right_camera;

    QString map_name = "";
    QString map_path = "";
    int width = 0;
    int height = 0;
    float gridwidth = 0;
    int origin[2] = {0,};

    QVector<ST_LOCATION> vecLocation;
    QVector<QVector<ST_FPOINT>> vecTline;
    QVector<ST_OBJECT> vecObject;

    float margin;
    bool use_server;
    bool use_uicmd;
    bool map_loaded;

    ST_POSE init_pose;
}ST_MAP;
extern ST_MAP *pmap;

typedef struct{
    //from Robot
    float battery = 0;
    int state = 0;
    int err_code = 0;

    ST_POSE curPose;
    QString curLocation = "";
    QVector<int> pickupTrays;
    ST_POSE curTarget;

    int pathSize =0;
    QVector<ST_POSE> curPath;
    int localpathSize =0;
    ST_POSE localPath[4];

    //mine
    QString name = "";
    QString model = "";
    int serial_num;
    QString name_debug = "";
    QString type = "SERVING";
    float velocity = 1.0;

    QVector<int> trays;
    QVector<QString> call_list;

    ST_POSE targetPose;
    QString targetLocation;

    int call_moving_count;
    int max_moving_count;
    float joystick[2];
    float lidar_data[360];
    float radius;


    QString program_version;
    QString program_date;
    QString program_message;
    QVector<ST_GIT> gitList;



}ST_ROBOT;
extern ST_ROBOT *probot;

typedef struct{
    QString type;
    QString location;
    ST_POSE pose;
}ST_PATROL;

typedef struct{
    QVector<ST_PATROL> path;
    QString filename;
    int mode;
}ST_PATROLMODE;

typedef struct{
    int tray_num;
    int travelline;
    int table_num;
    int table_col_num;

    int volumeBGM;
    int volumeVoice;

    bool useAutoInit;
    bool useVoice;
    bool useBGM;
    bool useTravelline;
    bool useServerCMD;
}ST_SETTING;


enum ROBOT_CMD{
    ROBOT_CMD_NONE = 0,
    ROBOT_CMD_MOVE_LOCATION,
    ROBOT_CMD_MOVE_TARGET,
    ROBOT_CMD_MOVE_JOG,
    ROBOT_CMD_MOVE_MANUAL,

    ROBOT_CMD_MOVE_STOP,//=5
    ROBOT_CMD_MOVE_PAUSE,
    ROBOT_CMD_MOVE_RESUME,
    ROBOT_CMD_SET_VELOCITY,
    ROBOT_CMD_RESTART,

    ROBOT_CMD_SET_INIT,//=10
    ROBOT_CMD_SLAM_RUN,
    ROBOT_CMD_SLAM_STOP,
    ROBOT_CMD_SLAM_AUTO,
    ROBOT_CMD_MAPPING_START,

    ROBOT_CMD_MAPPING_STOP,//=15
    ROBOT_CMD_REQ_CAMERA,
    ROBOT_CMD_MAPPING_SAVE
};


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

    UI_CMD_MOVE_CHARGE,//5
    UI_CMD_PICKUP_CONFIRM,
    UI_CMD_WAIT_KITCHEN,
    UI_CMD_TABLE_PATROL,
    UI_CMD_PATROL_STOP,

    UI_CMD_MOVE_CALLING//10
};

enum UI_STATE{
    UI_STATE_NONE = 0,
    UI_STATE_READY,
    UI_STATE_CHARGING,
    UI_STATE_GO_HOME,
    UI_STATE_GO_CHARGE,

    UI_STATE_SERVING,//5
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

    ROBOT_STATE_ERROR,//5
    ROBOT_STATE_MANUALMODE,
    ROBOT_STATE_BUSY,
    ROBOT_STATE_CHARGING
};

enum ROBOT_ERROR{
    ROBOT_ERROR_NONE = 0,
    ROBOT_ERROR_WAIT,
    ROBOT_ERROR_NO_PATH,
    ROBOT_ERROR_MOTOR_COMM,
    ROBOT_ERROR_MOTOR,

    ROBOT_ERROR_VOLTAGE,//5
    ROBOT_ERROR_SENSOR
};

#endif // GLOBALHEADER_H
