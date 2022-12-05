#ifndef GLOBALHEADER_H
#define GLOBALHEADER_H

#include "Logger.h"
// opencv
#include <opencv2/opencv.hpp>
#include "cv_to_qt.h"

extern Logger *plog;

typedef struct{
    int x;
    int y;
}ST_POINT;

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
    int chunkSize = 0;
    int imageSize = 0;
    QVector<unsigned char> data;

    QString map_name = "";
    int width = 0;
    int height = 0;
    float gridwidth = 0;
    int origin[2] = {0,};

    int locationSize = 0;
    QVector<QString> locationName;
    QVector<ST_POSE> locationsPose;

    int travellineSize = 0;
    QVector<QString> travellineName;
    QVector<QVector<ST_FPOINT>> travellinePose;

    int objectSize = 0;
    QVector<QString> objectName;
    QVector<QVector<ST_FPOINT>> objectPose;

    float lidar_data[360];

    float margin;
    bool use_server;
    bool map_loaded;
}ST_MAP;

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
    QString type = "SERVING";
    float velocity = 1.0;
    QVector<int> trays;
    ST_POSE targetPose;
    float joystick[2];
}ST_ROBOT;

typedef struct{
    int tray_num;
    int travelline;
    int table_num;

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
    ROBOT_CMD_MOVE_STOP,
    ROBOT_CMD_MOVE_PAUSE,
    ROBOT_CMD_MOVE_RESUME,
    ROBOT_CMD_SET_VELOCITY,
    ROBOT_CMD_SET_MAP,
    ROBOT_CMD_dSET_MAP
};



#endif // GLOBALHEADER_H
