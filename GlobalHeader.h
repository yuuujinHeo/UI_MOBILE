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
    double      width;
}ST_LINE;



#define NUM_TRAY 3
typedef struct{
    float x = 0;
    float y = 0;
    float th = 0;
}ST_POSE;
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
    QVector<QString> locationTypes;
    QVector<ST_POSE> locationsPose;
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

    //mine
    int tray_num[NUM_TRAY] = {0,};
    ST_POSE targetPose;
    float joy_x = 0.;
    float joy_y = 0.;
    float joy_th = 0.;
    float vel_xy = 1.0;
    float vel_th = 1.0;
}ST_ROBOT;

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
    ROBOT_CMD_REQ_MAP
};



#endif // GLOBALHEADER_H
