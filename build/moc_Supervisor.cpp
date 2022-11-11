/****************************************************************************
** Meta object code from reading C++ file 'Supervisor.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.14.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../Supervisor.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Supervisor.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.14.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_Supervisor_t {
    QByteArrayData data[117];
    char stringdata0[1367];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Supervisor_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Supervisor_t qt_meta_stringdata_Supervisor = {
    {
QT_MOC_LITERAL(0, 0, 10), // "Supervisor"
QT_MOC_LITERAL(1, 11, 7), // "onTimer"
QT_MOC_LITERAL(2, 19, 0), // ""
QT_MOC_LITERAL(3, 20, 7), // "setTray"
QT_MOC_LITERAL(4, 28, 5), // "tray1"
QT_MOC_LITERAL(5, 34, 5), // "tray2"
QT_MOC_LITERAL(6, 40, 5), // "tray3"
QT_MOC_LITERAL(7, 46, 6), // "moveTo"
QT_MOC_LITERAL(8, 53, 10), // "target_num"
QT_MOC_LITERAL(9, 64, 1), // "x"
QT_MOC_LITERAL(10, 66, 1), // "y"
QT_MOC_LITERAL(11, 68, 2), // "th"
QT_MOC_LITERAL(12, 71, 9), // "movePause"
QT_MOC_LITERAL(13, 81, 10), // "moveResume"
QT_MOC_LITERAL(14, 92, 7), // "moveJog"
QT_MOC_LITERAL(15, 100, 2), // "vx"
QT_MOC_LITERAL(16, 103, 2), // "vy"
QT_MOC_LITERAL(17, 106, 3), // "vth"
QT_MOC_LITERAL(18, 110, 8), // "moveStop"
QT_MOC_LITERAL(19, 119, 10), // "moveManual"
QT_MOC_LITERAL(20, 130, 11), // "setVelocity"
QT_MOC_LITERAL(21, 142, 3), // "vel"
QT_MOC_LITERAL(22, 146, 5), // "velth"
QT_MOC_LITERAL(23, 152, 13), // "confirmPickup"
QT_MOC_LITERAL(24, 166, 12), // "moveToCharge"
QT_MOC_LITERAL(25, 179, 10), // "moveToWait"
QT_MOC_LITERAL(26, 190, 10), // "getBattery"
QT_MOC_LITERAL(27, 201, 8), // "getState"
QT_MOC_LITERAL(28, 210, 10), // "getErrcode"
QT_MOC_LITERAL(29, 221, 12), // "getRobotName"
QT_MOC_LITERAL(30, 234, 12), // "setRobotName"
QT_MOC_LITERAL(31, 247, 4), // "name"
QT_MOC_LITERAL(32, 252, 14), // "getPickuptrays"
QT_MOC_LITERAL(33, 267, 12), // "QVector<int>"
QT_MOC_LITERAL(34, 280, 9), // "getcurLoc"
QT_MOC_LITERAL(35, 290, 11), // "getcurTable"
QT_MOC_LITERAL(36, 302, 12), // "getcurTarget"
QT_MOC_LITERAL(37, 315, 14), // "QVector<float>"
QT_MOC_LITERAL(38, 330, 16), // "getImageChunkNum"
QT_MOC_LITERAL(39, 347, 12), // "getImageSize"
QT_MOC_LITERAL(40, 360, 12), // "getImageData"
QT_MOC_LITERAL(41, 373, 11), // "getMapExist"
QT_MOC_LITERAL(42, 385, 11), // "getMapState"
QT_MOC_LITERAL(43, 397, 10), // "getMapname"
QT_MOC_LITERAL(44, 408, 11), // "getMapWidth"
QT_MOC_LITERAL(45, 420, 12), // "getMapHeight"
QT_MOC_LITERAL(46, 433, 12), // "getGridWidth"
QT_MOC_LITERAL(47, 446, 9), // "getOrigin"
QT_MOC_LITERAL(48, 456, 14), // "getLocationNum"
QT_MOC_LITERAL(49, 471, 16), // "getLocationTypes"
QT_MOC_LITERAL(50, 488, 3), // "num"
QT_MOC_LITERAL(51, 492, 12), // "getLocationx"
QT_MOC_LITERAL(52, 505, 12), // "getLocationy"
QT_MOC_LITERAL(53, 518, 13), // "getLocationth"
QT_MOC_LITERAL(54, 532, 9), // "getRobotx"
QT_MOC_LITERAL(55, 542, 9), // "getRoboty"
QT_MOC_LITERAL(56, 552, 10), // "getRobotth"
QT_MOC_LITERAL(57, 563, 13), // "getRobotState"
QT_MOC_LITERAL(58, 577, 10), // "getPathNum"
QT_MOC_LITERAL(59, 588, 8), // "getPathx"
QT_MOC_LITERAL(60, 597, 8), // "getPathy"
QT_MOC_LITERAL(61, 606, 9), // "getPathth"
QT_MOC_LITERAL(62, 616, 13), // "getCanvasSize"
QT_MOC_LITERAL(63, 630, 11), // "getRedoSize"
QT_MOC_LITERAL(64, 642, 8), // "getLineX"
QT_MOC_LITERAL(65, 651, 5), // "index"
QT_MOC_LITERAL(66, 657, 8), // "getLineY"
QT_MOC_LITERAL(67, 666, 12), // "getLineColor"
QT_MOC_LITERAL(68, 679, 12), // "getLineWidth"
QT_MOC_LITERAL(69, 692, 9), // "startLine"
QT_MOC_LITERAL(70, 702, 5), // "color"
QT_MOC_LITERAL(71, 708, 5), // "width"
QT_MOC_LITERAL(72, 714, 7), // "setLine"
QT_MOC_LITERAL(73, 722, 8), // "stopLine"
QT_MOC_LITERAL(74, 731, 4), // "undo"
QT_MOC_LITERAL(75, 736, 4), // "redo"
QT_MOC_LITERAL(76, 741, 9), // "clear_all"
QT_MOC_LITERAL(77, 751, 9), // "getMapURL"
QT_MOC_LITERAL(78, 761, 9), // "setMapURL"
QT_MOC_LITERAL(79, 771, 3), // "url"
QT_MOC_LITERAL(80, 775, 10), // "getDBvalue"
QT_MOC_LITERAL(81, 786, 8), // "TOOL_NUM"
QT_MOC_LITERAL(82, 795, 10), // "TOOL_MOUSE"
QT_MOC_LITERAL(83, 806, 10), // "TOOL_BRUSH"
QT_MOC_LITERAL(84, 817, 11), // "TOOL_ERASER"
QT_MOC_LITERAL(85, 829, 6), // "UI_CMD"
QT_MOC_LITERAL(86, 836, 11), // "UI_CMD_NONE"
QT_MOC_LITERAL(87, 848, 17), // "UI_CMD_MOVE_TABLE"
QT_MOC_LITERAL(88, 866, 12), // "UI_CMD_PAUSE"
QT_MOC_LITERAL(89, 879, 13), // "UI_CMD_RESUME"
QT_MOC_LITERAL(90, 893, 16), // "UI_CMD_MOVE_WAIT"
QT_MOC_LITERAL(91, 910, 18), // "UI_CMD_MOVE_CHARGE"
QT_MOC_LITERAL(92, 929, 21), // "UI_CMD_PICKUP_CONFIRM"
QT_MOC_LITERAL(93, 951, 19), // "UI_CMD_WAIT_KITCHEN"
QT_MOC_LITERAL(94, 971, 8), // "UI_STATE"
QT_MOC_LITERAL(95, 980, 13), // "UI_STATE_NONE"
QT_MOC_LITERAL(96, 994, 14), // "UI_STATE_READY"
QT_MOC_LITERAL(97, 1009, 15), // "UI_STATE_MOVING"
QT_MOC_LITERAL(98, 1025, 15), // "UI_STATE_PAUSED"
QT_MOC_LITERAL(99, 1041, 15), // "UI_STATE_PICKUP"
QT_MOC_LITERAL(100, 1057, 15), // "UI_STATE_CHARGE"
QT_MOC_LITERAL(101, 1073, 11), // "ROBOT_STATE"
QT_MOC_LITERAL(102, 1085, 21), // "ROBOT_STATE_NOT_READY"
QT_MOC_LITERAL(103, 1107, 17), // "ROBOT_STATE_READY"
QT_MOC_LITERAL(104, 1125, 18), // "ROBOT_STATE_MOVING"
QT_MOC_LITERAL(105, 1144, 17), // "ROBOT_STATE_AVOID"
QT_MOC_LITERAL(106, 1162, 18), // "ROBOT_STATE_PAUSED"
QT_MOC_LITERAL(107, 1181, 17), // "ROBOT_STATE_ERROR"
QT_MOC_LITERAL(108, 1199, 22), // "ROBOT_STATE_MANUALMODE"
QT_MOC_LITERAL(109, 1222, 11), // "ROBOT_ERROR"
QT_MOC_LITERAL(110, 1234, 16), // "ROBOT_ERROR_NONE"
QT_MOC_LITERAL(111, 1251, 15), // "ROBOT_ERROR_COL"
QT_MOC_LITERAL(112, 1267, 19), // "ROBOT_ERROR_NO_PATH"
QT_MOC_LITERAL(113, 1287, 22), // "ROBOT_ERROR_MOTOR_COMM"
QT_MOC_LITERAL(114, 1310, 17), // "ROBOT_ERROR_MOTOR"
QT_MOC_LITERAL(115, 1328, 19), // "ROBOT_ERROR_VOLTAGE"
QT_MOC_LITERAL(116, 1348, 18) // "ROBOT_ERROR_SENSOR"

    },
    "Supervisor\0onTimer\0\0setTray\0tray1\0"
    "tray2\0tray3\0moveTo\0target_num\0x\0y\0th\0"
    "movePause\0moveResume\0moveJog\0vx\0vy\0"
    "vth\0moveStop\0moveManual\0setVelocity\0"
    "vel\0velth\0confirmPickup\0moveToCharge\0"
    "moveToWait\0getBattery\0getState\0"
    "getErrcode\0getRobotName\0setRobotName\0"
    "name\0getPickuptrays\0QVector<int>\0"
    "getcurLoc\0getcurTable\0getcurTarget\0"
    "QVector<float>\0getImageChunkNum\0"
    "getImageSize\0getImageData\0getMapExist\0"
    "getMapState\0getMapname\0getMapWidth\0"
    "getMapHeight\0getGridWidth\0getOrigin\0"
    "getLocationNum\0getLocationTypes\0num\0"
    "getLocationx\0getLocationy\0getLocationth\0"
    "getRobotx\0getRoboty\0getRobotth\0"
    "getRobotState\0getPathNum\0getPathx\0"
    "getPathy\0getPathth\0getCanvasSize\0"
    "getRedoSize\0getLineX\0index\0getLineY\0"
    "getLineColor\0getLineWidth\0startLine\0"
    "color\0width\0setLine\0stopLine\0undo\0"
    "redo\0clear_all\0getMapURL\0setMapURL\0"
    "url\0getDBvalue\0TOOL_NUM\0TOOL_MOUSE\0"
    "TOOL_BRUSH\0TOOL_ERASER\0UI_CMD\0UI_CMD_NONE\0"
    "UI_CMD_MOVE_TABLE\0UI_CMD_PAUSE\0"
    "UI_CMD_RESUME\0UI_CMD_MOVE_WAIT\0"
    "UI_CMD_MOVE_CHARGE\0UI_CMD_PICKUP_CONFIRM\0"
    "UI_CMD_WAIT_KITCHEN\0UI_STATE\0UI_STATE_NONE\0"
    "UI_STATE_READY\0UI_STATE_MOVING\0"
    "UI_STATE_PAUSED\0UI_STATE_PICKUP\0"
    "UI_STATE_CHARGE\0ROBOT_STATE\0"
    "ROBOT_STATE_NOT_READY\0ROBOT_STATE_READY\0"
    "ROBOT_STATE_MOVING\0ROBOT_STATE_AVOID\0"
    "ROBOT_STATE_PAUSED\0ROBOT_STATE_ERROR\0"
    "ROBOT_STATE_MANUALMODE\0ROBOT_ERROR\0"
    "ROBOT_ERROR_NONE\0ROBOT_ERROR_COL\0"
    "ROBOT_ERROR_NO_PATH\0ROBOT_ERROR_MOTOR_COMM\0"
    "ROBOT_ERROR_MOTOR\0ROBOT_ERROR_VOLTAGE\0"
    "ROBOT_ERROR_SENSOR"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Supervisor[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      60,   14, // methods
       0,    0, // properties
       5,  434, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,  314,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
       3,    3,  315,    2, 0x02 /* Public */,
       7,    1,  322,    2, 0x02 /* Public */,
       7,    3,  325,    2, 0x02 /* Public */,
      12,    0,  332,    2, 0x02 /* Public */,
      13,    0,  333,    2, 0x02 /* Public */,
      14,    3,  334,    2, 0x02 /* Public */,
      18,    0,  341,    2, 0x02 /* Public */,
      19,    0,  342,    2, 0x02 /* Public */,
      20,    2,  343,    2, 0x02 /* Public */,
      23,    0,  348,    2, 0x02 /* Public */,
      24,    0,  349,    2, 0x02 /* Public */,
      25,    0,  350,    2, 0x02 /* Public */,
      26,    0,  351,    2, 0x02 /* Public */,
      27,    0,  352,    2, 0x02 /* Public */,
      28,    0,  353,    2, 0x02 /* Public */,
      29,    0,  354,    2, 0x02 /* Public */,
      30,    1,  355,    2, 0x02 /* Public */,
      32,    0,  358,    2, 0x02 /* Public */,
      34,    0,  359,    2, 0x02 /* Public */,
      35,    0,  360,    2, 0x02 /* Public */,
      36,    0,  361,    2, 0x02 /* Public */,
      38,    0,  362,    2, 0x02 /* Public */,
      39,    0,  363,    2, 0x02 /* Public */,
      40,    0,  364,    2, 0x02 /* Public */,
      41,    0,  365,    2, 0x02 /* Public */,
      42,    0,  366,    2, 0x02 /* Public */,
      43,    0,  367,    2, 0x02 /* Public */,
      44,    0,  368,    2, 0x02 /* Public */,
      45,    0,  369,    2, 0x02 /* Public */,
      46,    0,  370,    2, 0x02 /* Public */,
      47,    0,  371,    2, 0x02 /* Public */,
      48,    0,  372,    2, 0x02 /* Public */,
      49,    1,  373,    2, 0x02 /* Public */,
      51,    1,  376,    2, 0x02 /* Public */,
      52,    1,  379,    2, 0x02 /* Public */,
      53,    1,  382,    2, 0x02 /* Public */,
      54,    0,  385,    2, 0x02 /* Public */,
      55,    0,  386,    2, 0x02 /* Public */,
      56,    0,  387,    2, 0x02 /* Public */,
      57,    0,  388,    2, 0x02 /* Public */,
      58,    0,  389,    2, 0x02 /* Public */,
      59,    1,  390,    2, 0x02 /* Public */,
      60,    1,  393,    2, 0x02 /* Public */,
      61,    1,  396,    2, 0x02 /* Public */,
      62,    0,  399,    2, 0x02 /* Public */,
      63,    0,  400,    2, 0x02 /* Public */,
      64,    1,  401,    2, 0x02 /* Public */,
      66,    1,  404,    2, 0x02 /* Public */,
      67,    1,  407,    2, 0x02 /* Public */,
      68,    1,  410,    2, 0x02 /* Public */,
      69,    2,  413,    2, 0x02 /* Public */,
      72,    2,  418,    2, 0x02 /* Public */,
      73,    0,  423,    2, 0x02 /* Public */,
      74,    0,  424,    2, 0x02 /* Public */,
      75,    0,  425,    2, 0x02 /* Public */,
      76,    0,  426,    2, 0x02 /* Public */,
      77,    0,  427,    2, 0x02 /* Public */,
      78,    1,  428,    2, 0x02 /* Public */,
      80,    1,  431,    2, 0x02 /* Public */,

 // slots: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int,    4,    5,    6,
    QMetaType::Void, QMetaType::QString,    8,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,    9,   10,   11,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,   15,   16,   17,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Float, QMetaType::Float,   21,   22,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,   31,
    0x80000000 | 33,
    QMetaType::QString,
    QMetaType::QString,
    0x80000000 | 37,
    QMetaType::Int,
    QMetaType::UInt,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float,
    0x80000000 | 33,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   50,
    QMetaType::Float, QMetaType::Int,   50,
    QMetaType::Float, QMetaType::Int,   50,
    QMetaType::Float, QMetaType::Int,   50,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   50,
    QMetaType::Float, QMetaType::Int,   50,
    QMetaType::Float, QMetaType::Int,   50,
    QMetaType::Int,
    QMetaType::Int,
    0x80000000 | 33, QMetaType::Int,   65,
    0x80000000 | 33, QMetaType::Int,   65,
    QMetaType::QString, QMetaType::Int,   65,
    QMetaType::Double, QMetaType::Int,   65,
    QMetaType::Void, QMetaType::QString, QMetaType::Double,   70,   71,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    9,   10,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,   79,
    QMetaType::QString, QMetaType::QString,   31,

 // enums: name, alias, flags, count, data
      81,   81, 0x0,    3,  459,
      85,   85, 0x0,    8,  465,
      94,   94, 0x0,    6,  481,
     101,  101, 0x0,    7,  493,
     109,  109, 0x0,    7,  507,

 // enum data: key, value
      82, uint(Supervisor::TOOL_MOUSE),
      83, uint(Supervisor::TOOL_BRUSH),
      84, uint(Supervisor::TOOL_ERASER),
      86, uint(Supervisor::UI_CMD_NONE),
      87, uint(Supervisor::UI_CMD_MOVE_TABLE),
      88, uint(Supervisor::UI_CMD_PAUSE),
      89, uint(Supervisor::UI_CMD_RESUME),
      90, uint(Supervisor::UI_CMD_MOVE_WAIT),
      91, uint(Supervisor::UI_CMD_MOVE_CHARGE),
      92, uint(Supervisor::UI_CMD_PICKUP_CONFIRM),
      93, uint(Supervisor::UI_CMD_WAIT_KITCHEN),
      95, uint(Supervisor::UI_STATE_NONE),
      96, uint(Supervisor::UI_STATE_READY),
      97, uint(Supervisor::UI_STATE_MOVING),
      98, uint(Supervisor::UI_STATE_PAUSED),
      99, uint(Supervisor::UI_STATE_PICKUP),
     100, uint(Supervisor::UI_STATE_CHARGE),
     102, uint(Supervisor::ROBOT_STATE_NOT_READY),
     103, uint(Supervisor::ROBOT_STATE_READY),
     104, uint(Supervisor::ROBOT_STATE_MOVING),
     105, uint(Supervisor::ROBOT_STATE_AVOID),
     106, uint(Supervisor::ROBOT_STATE_PAUSED),
     107, uint(Supervisor::ROBOT_STATE_ERROR),
     108, uint(Supervisor::ROBOT_STATE_MANUALMODE),
     110, uint(Supervisor::ROBOT_ERROR_NONE),
     111, uint(Supervisor::ROBOT_ERROR_COL),
     112, uint(Supervisor::ROBOT_ERROR_NO_PATH),
     113, uint(Supervisor::ROBOT_ERROR_MOTOR_COMM),
     114, uint(Supervisor::ROBOT_ERROR_MOTOR),
     115, uint(Supervisor::ROBOT_ERROR_VOLTAGE),
     116, uint(Supervisor::ROBOT_ERROR_SENSOR),

       0        // eod
};

void Supervisor::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Supervisor *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->onTimer(); break;
        case 1: _t->setTray((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 2: _t->moveTo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->moveTo((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 4: _t->movePause(); break;
        case 5: _t->moveResume(); break;
        case 6: _t->moveJog((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 7: _t->moveStop(); break;
        case 8: _t->moveManual(); break;
        case 9: _t->setVelocity((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 10: _t->confirmPickup(); break;
        case 11: _t->moveToCharge(); break;
        case 12: _t->moveToWait(); break;
        case 13: { float _r = _t->getBattery();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 14: { int _r = _t->getState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 15: { int _r = _t->getErrcode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 16: { QString _r = _t->getRobotName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 17: _t->setRobotName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 18: { QVector<int> _r = _t->getPickuptrays();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 19: { QString _r = _t->getcurLoc();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 20: { QString _r = _t->getcurTable();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 21: { QVector<float> _r = _t->getcurTarget();
            if (_a[0]) *reinterpret_cast< QVector<float>*>(_a[0]) = std::move(_r); }  break;
        case 22: { int _r = _t->getImageChunkNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 23: { uint _r = _t->getImageSize();
            if (_a[0]) *reinterpret_cast< uint*>(_a[0]) = std::move(_r); }  break;
        case 24: { QString _r = _t->getImageData();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 25: { bool _r = _t->getMapExist();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 26: { bool _r = _t->getMapState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 27: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 28: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 29: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 30: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 31: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 32: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 33: { QString _r = _t->getLocationTypes((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 34: { float _r = _t->getLocationx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 35: { float _r = _t->getLocationy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 36: { float _r = _t->getLocationth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 37: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 38: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 39: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 40: { int _r = _t->getRobotState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 41: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 42: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 43: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 44: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 45: { int _r = _t->getCanvasSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 46: { int _r = _t->getRedoSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 47: { QVector<int> _r = _t->getLineX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 48: { QVector<int> _r = _t->getLineY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 49: { QString _r = _t->getLineColor((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 50: { double _r = _t->getLineWidth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 51: _t->startLine((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< double(*)>(_a[2]))); break;
        case 52: _t->setLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 53: _t->stopLine(); break;
        case 54: _t->undo(); break;
        case 55: _t->redo(); break;
        case 56: _t->clear_all(); break;
        case 57: { QString _r = _t->getMapURL();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 58: _t->setMapURL((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 59: { QString _r = _t->getDBvalue((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject Supervisor::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_Supervisor.data,
    qt_meta_data_Supervisor,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *Supervisor::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Supervisor::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_Supervisor.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Supervisor::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 60)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 60;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 60)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 60;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
