/****************************************************************************
** Meta object code from reading C++ file 'Supervisor.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.8)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../Supervisor.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Supervisor.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.8. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_Supervisor_t {
    QByteArrayData data[152];
    char stringdata0[1831];
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
QT_MOC_LITERAL(3, 20, 16), // "server_cmd_pause"
QT_MOC_LITERAL(4, 37, 17), // "server_cmd_resume"
QT_MOC_LITERAL(5, 55, 7), // "setTray"
QT_MOC_LITERAL(6, 63, 5), // "tray1"
QT_MOC_LITERAL(7, 69, 5), // "tray2"
QT_MOC_LITERAL(8, 75, 5), // "tray3"
QT_MOC_LITERAL(9, 81, 6), // "moveTo"
QT_MOC_LITERAL(10, 88, 10), // "target_num"
QT_MOC_LITERAL(11, 99, 1), // "x"
QT_MOC_LITERAL(12, 101, 1), // "y"
QT_MOC_LITERAL(13, 103, 2), // "th"
QT_MOC_LITERAL(14, 106, 9), // "movePause"
QT_MOC_LITERAL(15, 116, 10), // "moveResume"
QT_MOC_LITERAL(16, 127, 7), // "moveJog"
QT_MOC_LITERAL(17, 135, 2), // "vx"
QT_MOC_LITERAL(18, 138, 2), // "vy"
QT_MOC_LITERAL(19, 141, 3), // "vth"
QT_MOC_LITERAL(20, 145, 8), // "moveStop"
QT_MOC_LITERAL(21, 154, 10), // "moveManual"
QT_MOC_LITERAL(22, 165, 11), // "setVelocity"
QT_MOC_LITERAL(23, 177, 3), // "vel"
QT_MOC_LITERAL(24, 181, 5), // "velth"
QT_MOC_LITERAL(25, 187, 13), // "confirmPickup"
QT_MOC_LITERAL(26, 201, 12), // "moveToCharge"
QT_MOC_LITERAL(27, 214, 10), // "moveToWait"
QT_MOC_LITERAL(28, 225, 10), // "getBattery"
QT_MOC_LITERAL(29, 236, 8), // "getState"
QT_MOC_LITERAL(30, 245, 10), // "getErrcode"
QT_MOC_LITERAL(31, 256, 12), // "getRobotName"
QT_MOC_LITERAL(32, 269, 12), // "setRobotName"
QT_MOC_LITERAL(33, 282, 4), // "name"
QT_MOC_LITERAL(34, 287, 13), // "getVelocityXY"
QT_MOC_LITERAL(35, 301, 13), // "getVelocityTH"
QT_MOC_LITERAL(36, 315, 14), // "getPickuptrays"
QT_MOC_LITERAL(37, 330, 12), // "QVector<int>"
QT_MOC_LITERAL(38, 343, 9), // "getcurLoc"
QT_MOC_LITERAL(39, 353, 11), // "getcurTable"
QT_MOC_LITERAL(40, 365, 12), // "getcurTarget"
QT_MOC_LITERAL(41, 378, 14), // "QVector<float>"
QT_MOC_LITERAL(42, 393, 16), // "getImageChunkNum"
QT_MOC_LITERAL(43, 410, 12), // "getImageSize"
QT_MOC_LITERAL(44, 423, 12), // "getImageData"
QT_MOC_LITERAL(45, 436, 11), // "getMapExist"
QT_MOC_LITERAL(46, 448, 11), // "getMapState"
QT_MOC_LITERAL(47, 460, 10), // "getMapname"
QT_MOC_LITERAL(48, 471, 10), // "getMappath"
QT_MOC_LITERAL(49, 482, 11), // "getMapWidth"
QT_MOC_LITERAL(50, 494, 12), // "getMapHeight"
QT_MOC_LITERAL(51, 507, 12), // "getGridWidth"
QT_MOC_LITERAL(52, 520, 9), // "getOrigin"
QT_MOC_LITERAL(53, 530, 14), // "getLocationNum"
QT_MOC_LITERAL(54, 545, 16), // "getLocationTypes"
QT_MOC_LITERAL(55, 562, 3), // "num"
QT_MOC_LITERAL(56, 566, 12), // "getLocationx"
QT_MOC_LITERAL(57, 579, 12), // "getLocationy"
QT_MOC_LITERAL(58, 592, 13), // "getLocationth"
QT_MOC_LITERAL(59, 606, 12), // "getObjectNum"
QT_MOC_LITERAL(60, 619, 13), // "getObjectName"
QT_MOC_LITERAL(61, 633, 18), // "getObjectPointSize"
QT_MOC_LITERAL(62, 652, 10), // "getObjectX"
QT_MOC_LITERAL(63, 663, 5), // "point"
QT_MOC_LITERAL(64, 669, 10), // "getObjectY"
QT_MOC_LITERAL(65, 680, 11), // "clickObject"
QT_MOC_LITERAL(66, 692, 17), // "getTempObjectSize"
QT_MOC_LITERAL(67, 710, 14), // "getTempObjectX"
QT_MOC_LITERAL(68, 725, 14), // "getTempObjectY"
QT_MOC_LITERAL(69, 740, 9), // "getObjNum"
QT_MOC_LITERAL(70, 750, 14), // "getObjPointNum"
QT_MOC_LITERAL(71, 765, 7), // "obj_num"
QT_MOC_LITERAL(72, 773, 14), // "addObjectPoint"
QT_MOC_LITERAL(73, 788, 15), // "editObjectPoint"
QT_MOC_LITERAL(74, 804, 17), // "removeObjectPoint"
QT_MOC_LITERAL(75, 822, 21), // "removeObjectPointLast"
QT_MOC_LITERAL(76, 844, 17), // "clearObjectPoints"
QT_MOC_LITERAL(77, 862, 9), // "addObject"
QT_MOC_LITERAL(78, 872, 12), // "removeObject"
QT_MOC_LITERAL(79, 885, 15), // "moveObjectPoint"
QT_MOC_LITERAL(80, 901, 9), // "point_num"
QT_MOC_LITERAL(81, 911, 9), // "getMargin"
QT_MOC_LITERAL(82, 921, 9), // "getRobotx"
QT_MOC_LITERAL(83, 931, 9), // "getRoboty"
QT_MOC_LITERAL(84, 941, 10), // "getRobotth"
QT_MOC_LITERAL(85, 952, 13), // "getRobotState"
QT_MOC_LITERAL(86, 966, 10), // "getPathNum"
QT_MOC_LITERAL(87, 977, 8), // "getPathx"
QT_MOC_LITERAL(88, 986, 8), // "getPathy"
QT_MOC_LITERAL(89, 995, 9), // "getPathth"
QT_MOC_LITERAL(90, 1005, 9), // "joyMoveXY"
QT_MOC_LITERAL(91, 1015, 8), // "joyMoveR"
QT_MOC_LITERAL(92, 1024, 1), // "r"
QT_MOC_LITERAL(93, 1026, 13), // "getCanvasSize"
QT_MOC_LITERAL(94, 1040, 11), // "getRedoSize"
QT_MOC_LITERAL(95, 1052, 8), // "getLineX"
QT_MOC_LITERAL(96, 1061, 5), // "index"
QT_MOC_LITERAL(97, 1067, 8), // "getLineY"
QT_MOC_LITERAL(98, 1076, 12), // "getLineColor"
QT_MOC_LITERAL(99, 1089, 12), // "getLineWidth"
QT_MOC_LITERAL(100, 1102, 9), // "startLine"
QT_MOC_LITERAL(101, 1112, 5), // "color"
QT_MOC_LITERAL(102, 1118, 5), // "width"
QT_MOC_LITERAL(103, 1124, 7), // "setLine"
QT_MOC_LITERAL(104, 1132, 8), // "stopLine"
QT_MOC_LITERAL(105, 1141, 4), // "undo"
QT_MOC_LITERAL(106, 1146, 4), // "redo"
QT_MOC_LITERAL(107, 1151, 9), // "clear_all"
QT_MOC_LITERAL(108, 1161, 9), // "getMapURL"
QT_MOC_LITERAL(109, 1171, 9), // "setMapURL"
QT_MOC_LITERAL(110, 1181, 3), // "url"
QT_MOC_LITERAL(111, 1185, 10), // "getDBvalue"
QT_MOC_LITERAL(112, 1196, 15), // "startRecordPath"
QT_MOC_LITERAL(113, 1212, 12), // "startcurPath"
QT_MOC_LITERAL(114, 1225, 11), // "stopcurPath"
QT_MOC_LITERAL(115, 1237, 12), // "pausecurPath"
QT_MOC_LITERAL(116, 1250, 8), // "TOOL_NUM"
QT_MOC_LITERAL(117, 1259, 10), // "TOOL_MOUSE"
QT_MOC_LITERAL(118, 1270, 10), // "TOOL_BRUSH"
QT_MOC_LITERAL(119, 1281, 11), // "TOOL_ERASER"
QT_MOC_LITERAL(120, 1293, 6), // "UI_CMD"
QT_MOC_LITERAL(121, 1300, 11), // "UI_CMD_NONE"
QT_MOC_LITERAL(122, 1312, 17), // "UI_CMD_MOVE_TABLE"
QT_MOC_LITERAL(123, 1330, 12), // "UI_CMD_PAUSE"
QT_MOC_LITERAL(124, 1343, 13), // "UI_CMD_RESUME"
QT_MOC_LITERAL(125, 1357, 16), // "UI_CMD_MOVE_WAIT"
QT_MOC_LITERAL(126, 1374, 18), // "UI_CMD_MOVE_CHARGE"
QT_MOC_LITERAL(127, 1393, 21), // "UI_CMD_PICKUP_CONFIRM"
QT_MOC_LITERAL(128, 1415, 19), // "UI_CMD_WAIT_KITCHEN"
QT_MOC_LITERAL(129, 1435, 8), // "UI_STATE"
QT_MOC_LITERAL(130, 1444, 13), // "UI_STATE_NONE"
QT_MOC_LITERAL(131, 1458, 14), // "UI_STATE_READY"
QT_MOC_LITERAL(132, 1473, 15), // "UI_STATE_MOVING"
QT_MOC_LITERAL(133, 1489, 15), // "UI_STATE_PAUSED"
QT_MOC_LITERAL(134, 1505, 15), // "UI_STATE_PICKUP"
QT_MOC_LITERAL(135, 1521, 15), // "UI_STATE_CHARGE"
QT_MOC_LITERAL(136, 1537, 11), // "ROBOT_STATE"
QT_MOC_LITERAL(137, 1549, 21), // "ROBOT_STATE_NOT_READY"
QT_MOC_LITERAL(138, 1571, 17), // "ROBOT_STATE_READY"
QT_MOC_LITERAL(139, 1589, 18), // "ROBOT_STATE_MOVING"
QT_MOC_LITERAL(140, 1608, 17), // "ROBOT_STATE_AVOID"
QT_MOC_LITERAL(141, 1626, 18), // "ROBOT_STATE_PAUSED"
QT_MOC_LITERAL(142, 1645, 17), // "ROBOT_STATE_ERROR"
QT_MOC_LITERAL(143, 1663, 22), // "ROBOT_STATE_MANUALMODE"
QT_MOC_LITERAL(144, 1686, 11), // "ROBOT_ERROR"
QT_MOC_LITERAL(145, 1698, 16), // "ROBOT_ERROR_NONE"
QT_MOC_LITERAL(146, 1715, 15), // "ROBOT_ERROR_COL"
QT_MOC_LITERAL(147, 1731, 19), // "ROBOT_ERROR_NO_PATH"
QT_MOC_LITERAL(148, 1751, 22), // "ROBOT_ERROR_MOTOR_COMM"
QT_MOC_LITERAL(149, 1774, 17), // "ROBOT_ERROR_MOTOR"
QT_MOC_LITERAL(150, 1792, 19), // "ROBOT_ERROR_VOLTAGE"
QT_MOC_LITERAL(151, 1812, 18) // "ROBOT_ERROR_SENSOR"

    },
    "Supervisor\0onTimer\0\0server_cmd_pause\0"
    "server_cmd_resume\0setTray\0tray1\0tray2\0"
    "tray3\0moveTo\0target_num\0x\0y\0th\0movePause\0"
    "moveResume\0moveJog\0vx\0vy\0vth\0moveStop\0"
    "moveManual\0setVelocity\0vel\0velth\0"
    "confirmPickup\0moveToCharge\0moveToWait\0"
    "getBattery\0getState\0getErrcode\0"
    "getRobotName\0setRobotName\0name\0"
    "getVelocityXY\0getVelocityTH\0getPickuptrays\0"
    "QVector<int>\0getcurLoc\0getcurTable\0"
    "getcurTarget\0QVector<float>\0"
    "getImageChunkNum\0getImageSize\0"
    "getImageData\0getMapExist\0getMapState\0"
    "getMapname\0getMappath\0getMapWidth\0"
    "getMapHeight\0getGridWidth\0getOrigin\0"
    "getLocationNum\0getLocationTypes\0num\0"
    "getLocationx\0getLocationy\0getLocationth\0"
    "getObjectNum\0getObjectName\0"
    "getObjectPointSize\0getObjectX\0point\0"
    "getObjectY\0clickObject\0getTempObjectSize\0"
    "getTempObjectX\0getTempObjectY\0getObjNum\0"
    "getObjPointNum\0obj_num\0addObjectPoint\0"
    "editObjectPoint\0removeObjectPoint\0"
    "removeObjectPointLast\0clearObjectPoints\0"
    "addObject\0removeObject\0moveObjectPoint\0"
    "point_num\0getMargin\0getRobotx\0getRoboty\0"
    "getRobotth\0getRobotState\0getPathNum\0"
    "getPathx\0getPathy\0getPathth\0joyMoveXY\0"
    "joyMoveR\0r\0getCanvasSize\0getRedoSize\0"
    "getLineX\0index\0getLineY\0getLineColor\0"
    "getLineWidth\0startLine\0color\0width\0"
    "setLine\0stopLine\0undo\0redo\0clear_all\0"
    "getMapURL\0setMapURL\0url\0getDBvalue\0"
    "startRecordPath\0startcurPath\0stopcurPath\0"
    "pausecurPath\0TOOL_NUM\0TOOL_MOUSE\0"
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
      93,   14, // methods
       0,    0, // properties
       5,  696, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,  479,    2, 0x0a /* Public */,
       3,    0,  480,    2, 0x0a /* Public */,
       4,    0,  481,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
       5,    3,  482,    2, 0x02 /* Public */,
       9,    1,  489,    2, 0x02 /* Public */,
       9,    3,  492,    2, 0x02 /* Public */,
      14,    0,  499,    2, 0x02 /* Public */,
      15,    0,  500,    2, 0x02 /* Public */,
      16,    3,  501,    2, 0x02 /* Public */,
      20,    0,  508,    2, 0x02 /* Public */,
      21,    0,  509,    2, 0x02 /* Public */,
      22,    2,  510,    2, 0x02 /* Public */,
      25,    0,  515,    2, 0x02 /* Public */,
      26,    0,  516,    2, 0x02 /* Public */,
      27,    0,  517,    2, 0x02 /* Public */,
      28,    0,  518,    2, 0x02 /* Public */,
      29,    0,  519,    2, 0x02 /* Public */,
      30,    0,  520,    2, 0x02 /* Public */,
      31,    0,  521,    2, 0x02 /* Public */,
      32,    1,  522,    2, 0x02 /* Public */,
      34,    0,  525,    2, 0x02 /* Public */,
      35,    0,  526,    2, 0x02 /* Public */,
      36,    0,  527,    2, 0x02 /* Public */,
      38,    0,  528,    2, 0x02 /* Public */,
      39,    0,  529,    2, 0x02 /* Public */,
      40,    0,  530,    2, 0x02 /* Public */,
      42,    0,  531,    2, 0x02 /* Public */,
      43,    0,  532,    2, 0x02 /* Public */,
      44,    0,  533,    2, 0x02 /* Public */,
      45,    0,  534,    2, 0x02 /* Public */,
      46,    0,  535,    2, 0x02 /* Public */,
      47,    0,  536,    2, 0x02 /* Public */,
      48,    0,  537,    2, 0x02 /* Public */,
      49,    0,  538,    2, 0x02 /* Public */,
      50,    0,  539,    2, 0x02 /* Public */,
      51,    0,  540,    2, 0x02 /* Public */,
      52,    0,  541,    2, 0x02 /* Public */,
      53,    0,  542,    2, 0x02 /* Public */,
      54,    1,  543,    2, 0x02 /* Public */,
      56,    1,  546,    2, 0x02 /* Public */,
      57,    1,  549,    2, 0x02 /* Public */,
      58,    1,  552,    2, 0x02 /* Public */,
      59,    0,  555,    2, 0x02 /* Public */,
      60,    1,  556,    2, 0x02 /* Public */,
      61,    1,  559,    2, 0x02 /* Public */,
      62,    2,  562,    2, 0x02 /* Public */,
      64,    2,  567,    2, 0x02 /* Public */,
      65,    1,  572,    2, 0x02 /* Public */,
      65,    2,  575,    2, 0x02 /* Public */,
      66,    0,  580,    2, 0x02 /* Public */,
      67,    1,  581,    2, 0x02 /* Public */,
      68,    1,  584,    2, 0x02 /* Public */,
      69,    1,  587,    2, 0x02 /* Public */,
      69,    2,  590,    2, 0x02 /* Public */,
      70,    3,  595,    2, 0x02 /* Public */,
      72,    2,  602,    2, 0x02 /* Public */,
      73,    3,  607,    2, 0x02 /* Public */,
      74,    1,  614,    2, 0x02 /* Public */,
      75,    0,  617,    2, 0x02 /* Public */,
      76,    0,  618,    2, 0x02 /* Public */,
      77,    1,  619,    2, 0x02 /* Public */,
      78,    1,  622,    2, 0x02 /* Public */,
      79,    4,  625,    2, 0x02 /* Public */,
      81,    0,  634,    2, 0x02 /* Public */,
      82,    0,  635,    2, 0x02 /* Public */,
      83,    0,  636,    2, 0x02 /* Public */,
      84,    0,  637,    2, 0x02 /* Public */,
      85,    0,  638,    2, 0x02 /* Public */,
      86,    0,  639,    2, 0x02 /* Public */,
      87,    1,  640,    2, 0x02 /* Public */,
      88,    1,  643,    2, 0x02 /* Public */,
      89,    1,  646,    2, 0x02 /* Public */,
      90,    2,  649,    2, 0x02 /* Public */,
      91,    1,  654,    2, 0x02 /* Public */,
      93,    0,  657,    2, 0x02 /* Public */,
      94,    0,  658,    2, 0x02 /* Public */,
      95,    1,  659,    2, 0x02 /* Public */,
      97,    1,  662,    2, 0x02 /* Public */,
      98,    1,  665,    2, 0x02 /* Public */,
      99,    1,  668,    2, 0x02 /* Public */,
     100,    2,  671,    2, 0x02 /* Public */,
     103,    2,  676,    2, 0x02 /* Public */,
     104,    0,  681,    2, 0x02 /* Public */,
     105,    0,  682,    2, 0x02 /* Public */,
     106,    0,  683,    2, 0x02 /* Public */,
     107,    0,  684,    2, 0x02 /* Public */,
     108,    0,  685,    2, 0x02 /* Public */,
     109,    1,  686,    2, 0x02 /* Public */,
     111,    1,  689,    2, 0x02 /* Public */,
     112,    0,  692,    2, 0x02 /* Public */,
     113,    0,  693,    2, 0x02 /* Public */,
     114,    0,  694,    2, 0x02 /* Public */,
     115,    0,  695,    2, 0x02 /* Public */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int,    6,    7,    8,
    QMetaType::Void, QMetaType::QString,   10,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,   11,   12,   13,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,   17,   18,   19,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Float, QMetaType::Float,   23,   24,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,   33,
    QMetaType::Float,
    QMetaType::Float,
    0x80000000 | 37,
    QMetaType::QString,
    QMetaType::QString,
    0x80000000 | 41,
    QMetaType::Int,
    QMetaType::UInt,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float,
    0x80000000 | 37,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   55,
    QMetaType::Float, QMetaType::Int,   55,
    QMetaType::Float, QMetaType::Int,   55,
    QMetaType::Float, QMetaType::Int,   55,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   55,
    QMetaType::Int, QMetaType::Int,   55,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   55,   63,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   55,   63,
    QMetaType::Void, QMetaType::QString,   33,
    QMetaType::Void, QMetaType::Float, QMetaType::Float,   11,   12,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   55,
    QMetaType::Float, QMetaType::Int,   55,
    QMetaType::Int, QMetaType::QString,   33,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   11,   12,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   71,   11,   12,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   11,   12,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int,   55,   11,   12,
    QMetaType::Void, QMetaType::Int,   55,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   33,
    QMetaType::Void, QMetaType::QString,   33,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   71,   80,   11,   12,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   55,
    QMetaType::Float, QMetaType::Int,   55,
    QMetaType::Float, QMetaType::Int,   55,
    QMetaType::Void, QMetaType::Float, QMetaType::Float,   11,   12,
    QMetaType::Void, QMetaType::Float,   92,
    QMetaType::Int,
    QMetaType::Int,
    0x80000000 | 37, QMetaType::Int,   96,
    0x80000000 | 37, QMetaType::Int,   96,
    QMetaType::QString, QMetaType::Int,   96,
    QMetaType::Float, QMetaType::Int,   96,
    QMetaType::Void, QMetaType::QString, QMetaType::Float,  101,  102,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   11,   12,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,  110,
    QMetaType::QString, QMetaType::QString,   33,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // enums: name, alias, flags, count, data
     116,  116, 0x0,    3,  721,
     120,  120, 0x0,    8,  727,
     129,  129, 0x0,    6,  743,
     136,  136, 0x0,    7,  755,
     144,  144, 0x0,    7,  769,

 // enum data: key, value
     117, uint(Supervisor::TOOL_MOUSE),
     118, uint(Supervisor::TOOL_BRUSH),
     119, uint(Supervisor::TOOL_ERASER),
     121, uint(Supervisor::UI_CMD_NONE),
     122, uint(Supervisor::UI_CMD_MOVE_TABLE),
     123, uint(Supervisor::UI_CMD_PAUSE),
     124, uint(Supervisor::UI_CMD_RESUME),
     125, uint(Supervisor::UI_CMD_MOVE_WAIT),
     126, uint(Supervisor::UI_CMD_MOVE_CHARGE),
     127, uint(Supervisor::UI_CMD_PICKUP_CONFIRM),
     128, uint(Supervisor::UI_CMD_WAIT_KITCHEN),
     130, uint(Supervisor::UI_STATE_NONE),
     131, uint(Supervisor::UI_STATE_READY),
     132, uint(Supervisor::UI_STATE_MOVING),
     133, uint(Supervisor::UI_STATE_PAUSED),
     134, uint(Supervisor::UI_STATE_PICKUP),
     135, uint(Supervisor::UI_STATE_CHARGE),
     137, uint(Supervisor::ROBOT_STATE_NOT_READY),
     138, uint(Supervisor::ROBOT_STATE_READY),
     139, uint(Supervisor::ROBOT_STATE_MOVING),
     140, uint(Supervisor::ROBOT_STATE_AVOID),
     141, uint(Supervisor::ROBOT_STATE_PAUSED),
     142, uint(Supervisor::ROBOT_STATE_ERROR),
     143, uint(Supervisor::ROBOT_STATE_MANUALMODE),
     145, uint(Supervisor::ROBOT_ERROR_NONE),
     146, uint(Supervisor::ROBOT_ERROR_COL),
     147, uint(Supervisor::ROBOT_ERROR_NO_PATH),
     148, uint(Supervisor::ROBOT_ERROR_MOTOR_COMM),
     149, uint(Supervisor::ROBOT_ERROR_MOTOR),
     150, uint(Supervisor::ROBOT_ERROR_VOLTAGE),
     151, uint(Supervisor::ROBOT_ERROR_SENSOR),

       0        // eod
};

void Supervisor::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Supervisor *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->onTimer(); break;
        case 1: _t->server_cmd_pause(); break;
        case 2: _t->server_cmd_resume(); break;
        case 3: _t->setTray((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 4: _t->moveTo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 5: _t->moveTo((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 6: _t->movePause(); break;
        case 7: _t->moveResume(); break;
        case 8: _t->moveJog((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 9: _t->moveStop(); break;
        case 10: _t->moveManual(); break;
        case 11: _t->setVelocity((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 12: _t->confirmPickup(); break;
        case 13: _t->moveToCharge(); break;
        case 14: _t->moveToWait(); break;
        case 15: { float _r = _t->getBattery();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 16: { int _r = _t->getState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 17: { int _r = _t->getErrcode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 18: { QString _r = _t->getRobotName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 19: _t->setRobotName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 20: { float _r = _t->getVelocityXY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 21: { float _r = _t->getVelocityTH();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 22: { QVector<int> _r = _t->getPickuptrays();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 23: { QString _r = _t->getcurLoc();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 24: { QString _r = _t->getcurTable();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 25: { QVector<float> _r = _t->getcurTarget();
            if (_a[0]) *reinterpret_cast< QVector<float>*>(_a[0]) = std::move(_r); }  break;
        case 26: { int _r = _t->getImageChunkNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 27: { uint _r = _t->getImageSize();
            if (_a[0]) *reinterpret_cast< uint*>(_a[0]) = std::move(_r); }  break;
        case 28: { QString _r = _t->getImageData();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 29: { bool _r = _t->getMapExist();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 30: { bool _r = _t->getMapState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 31: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 32: { QString _r = _t->getMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 33: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 34: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 35: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 36: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 37: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 38: { QString _r = _t->getLocationTypes((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 39: { float _r = _t->getLocationx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 40: { float _r = _t->getLocationy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 41: { float _r = _t->getLocationth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 42: { int _r = _t->getObjectNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 43: { QString _r = _t->getObjectName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 44: { int _r = _t->getObjectPointSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 45: { float _r = _t->getObjectX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 46: { float _r = _t->getObjectY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 47: _t->clickObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 48: _t->clickObject((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 49: { int _r = _t->getTempObjectSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 50: { float _r = _t->getTempObjectX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 51: { float _r = _t->getTempObjectY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 52: { int _r = _t->getObjNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 53: { int _r = _t->getObjNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 54: { int _r = _t->getObjPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 55: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 56: _t->editObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 57: _t->removeObjectPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 58: _t->removeObjectPointLast(); break;
        case 59: _t->clearObjectPoints(); break;
        case 60: _t->addObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 61: _t->removeObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 62: _t->moveObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4]))); break;
        case 63: { float _r = _t->getMargin();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 64: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 65: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 66: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 67: { int _r = _t->getRobotState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 68: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 69: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 70: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 71: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 72: _t->joyMoveXY((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 73: _t->joyMoveR((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 74: { int _r = _t->getCanvasSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 75: { int _r = _t->getRedoSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 76: { QVector<int> _r = _t->getLineX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 77: { QVector<int> _r = _t->getLineY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 78: { QString _r = _t->getLineColor((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 79: { float _r = _t->getLineWidth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 80: _t->startLine((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 81: _t->setLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 82: _t->stopLine(); break;
        case 83: _t->undo(); break;
        case 84: _t->redo(); break;
        case 85: _t->clear_all(); break;
        case 86: { QString _r = _t->getMapURL();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 87: _t->setMapURL((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 88: { QString _r = _t->getDBvalue((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 89: _t->startRecordPath(); break;
        case 90: _t->startcurPath(); break;
        case 91: _t->stopcurPath(); break;
        case 92: _t->pausecurPath(); break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject Supervisor::staticMetaObject = { {
    &QObject::staticMetaObject,
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
        if (_id < 93)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 93;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 93)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 93;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
