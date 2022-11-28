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
    QByteArrayData data[194];
    char stringdata0[2353];
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
QT_MOC_LITERAL(5, 55, 20), // "server_cmd_newtarget"
QT_MOC_LITERAL(6, 76, 12), // "path_changed"
QT_MOC_LITERAL(7, 89, 10), // "setObjPose"
QT_MOC_LITERAL(8, 100, 12), // "setMarginObj"
QT_MOC_LITERAL(9, 113, 14), // "clearMarginObj"
QT_MOC_LITERAL(10, 128, 14), // "setMarginPoint"
QT_MOC_LITERAL(11, 143, 9), // "pixel_num"
QT_MOC_LITERAL(12, 153, 12), // "getMarginObj"
QT_MOC_LITERAL(13, 166, 12), // "QVector<int>"
QT_MOC_LITERAL(14, 179, 7), // "setTray"
QT_MOC_LITERAL(15, 187, 5), // "tray1"
QT_MOC_LITERAL(16, 193, 5), // "tray2"
QT_MOC_LITERAL(17, 199, 5), // "tray3"
QT_MOC_LITERAL(18, 205, 6), // "moveTo"
QT_MOC_LITERAL(19, 212, 10), // "target_num"
QT_MOC_LITERAL(20, 223, 1), // "x"
QT_MOC_LITERAL(21, 225, 1), // "y"
QT_MOC_LITERAL(22, 227, 2), // "th"
QT_MOC_LITERAL(23, 230, 9), // "movePause"
QT_MOC_LITERAL(24, 240, 10), // "moveResume"
QT_MOC_LITERAL(25, 251, 8), // "moveStop"
QT_MOC_LITERAL(26, 260, 10), // "moveManual"
QT_MOC_LITERAL(27, 271, 11), // "setVelocity"
QT_MOC_LITERAL(28, 283, 3), // "vel"
QT_MOC_LITERAL(29, 287, 5), // "velth"
QT_MOC_LITERAL(30, 293, 13), // "confirmPickup"
QT_MOC_LITERAL(31, 307, 12), // "moveToCharge"
QT_MOC_LITERAL(32, 320, 10), // "moveToWait"
QT_MOC_LITERAL(33, 331, 10), // "getBattery"
QT_MOC_LITERAL(34, 342, 8), // "getState"
QT_MOC_LITERAL(35, 351, 10), // "getErrcode"
QT_MOC_LITERAL(36, 362, 12), // "getRobotName"
QT_MOC_LITERAL(37, 375, 12), // "setRobotName"
QT_MOC_LITERAL(38, 388, 4), // "name"
QT_MOC_LITERAL(39, 393, 13), // "getVelocityXY"
QT_MOC_LITERAL(40, 407, 13), // "getVelocityTH"
QT_MOC_LITERAL(41, 421, 14), // "getPickuptrays"
QT_MOC_LITERAL(42, 436, 9), // "getcurLoc"
QT_MOC_LITERAL(43, 446, 11), // "getcurTable"
QT_MOC_LITERAL(44, 458, 12), // "getcurTarget"
QT_MOC_LITERAL(45, 471, 14), // "QVector<float>"
QT_MOC_LITERAL(46, 486, 16), // "getImageChunkNum"
QT_MOC_LITERAL(47, 503, 12), // "getImageSize"
QT_MOC_LITERAL(48, 516, 12), // "getImageData"
QT_MOC_LITERAL(49, 529, 11), // "getMapExist"
QT_MOC_LITERAL(50, 541, 11), // "getMapState"
QT_MOC_LITERAL(51, 553, 10), // "getMapname"
QT_MOC_LITERAL(52, 564, 10), // "getMappath"
QT_MOC_LITERAL(53, 575, 11), // "getMapWidth"
QT_MOC_LITERAL(54, 587, 12), // "getMapHeight"
QT_MOC_LITERAL(55, 600, 12), // "getGridWidth"
QT_MOC_LITERAL(56, 613, 9), // "getOrigin"
QT_MOC_LITERAL(57, 623, 14), // "getLocationNum"
QT_MOC_LITERAL(58, 638, 16), // "getLocationTypes"
QT_MOC_LITERAL(59, 655, 3), // "num"
QT_MOC_LITERAL(60, 659, 12), // "getLocationx"
QT_MOC_LITERAL(61, 672, 12), // "getLocationy"
QT_MOC_LITERAL(62, 685, 13), // "getLocationth"
QT_MOC_LITERAL(63, 699, 12), // "getObjectNum"
QT_MOC_LITERAL(64, 712, 13), // "getObjectName"
QT_MOC_LITERAL(65, 726, 18), // "getObjectPointSize"
QT_MOC_LITERAL(66, 745, 10), // "getObjectX"
QT_MOC_LITERAL(67, 756, 5), // "point"
QT_MOC_LITERAL(68, 762, 10), // "getObjectY"
QT_MOC_LITERAL(69, 773, 11), // "clickObject"
QT_MOC_LITERAL(70, 785, 17), // "getTempObjectSize"
QT_MOC_LITERAL(71, 803, 14), // "getTempObjectX"
QT_MOC_LITERAL(72, 818, 14), // "getTempObjectY"
QT_MOC_LITERAL(73, 833, 9), // "getObjNum"
QT_MOC_LITERAL(74, 843, 14), // "getObjPointNum"
QT_MOC_LITERAL(75, 858, 7), // "obj_num"
QT_MOC_LITERAL(76, 866, 9), // "getLocNum"
QT_MOC_LITERAL(77, 876, 14), // "getRobotRadius"
QT_MOC_LITERAL(78, 891, 14), // "addObjectPoint"
QT_MOC_LITERAL(79, 906, 15), // "editObjectPoint"
QT_MOC_LITERAL(80, 922, 17), // "removeObjectPoint"
QT_MOC_LITERAL(81, 940, 21), // "removeObjectPointLast"
QT_MOC_LITERAL(82, 962, 17), // "clearObjectPoints"
QT_MOC_LITERAL(83, 980, 9), // "addObject"
QT_MOC_LITERAL(84, 990, 12), // "removeObject"
QT_MOC_LITERAL(85, 1003, 15), // "moveObjectPoint"
QT_MOC_LITERAL(86, 1019, 9), // "point_num"
QT_MOC_LITERAL(87, 1029, 14), // "removeLocation"
QT_MOC_LITERAL(88, 1044, 11), // "addLocation"
QT_MOC_LITERAL(89, 1056, 17), // "moveLocationPoint"
QT_MOC_LITERAL(90, 1074, 7), // "loc_num"
QT_MOC_LITERAL(91, 1082, 12), // "getTlineSize"
QT_MOC_LITERAL(92, 1095, 12), // "getTlineName"
QT_MOC_LITERAL(93, 1108, 9), // "getTlineX"
QT_MOC_LITERAL(94, 1118, 9), // "getTlineY"
QT_MOC_LITERAL(95, 1128, 8), // "addTline"
QT_MOC_LITERAL(96, 1137, 2), // "x1"
QT_MOC_LITERAL(97, 1140, 2), // "y1"
QT_MOC_LITERAL(98, 1143, 2), // "x2"
QT_MOC_LITERAL(99, 1146, 2), // "y2"
QT_MOC_LITERAL(100, 1149, 11), // "removeTline"
QT_MOC_LITERAL(101, 1161, 4), // "line"
QT_MOC_LITERAL(102, 1166, 11), // "getTlineNum"
QT_MOC_LITERAL(103, 1178, 12), // "setDebugName"
QT_MOC_LITERAL(104, 1191, 12), // "getDebugName"
QT_MOC_LITERAL(105, 1204, 13), // "getDebugState"
QT_MOC_LITERAL(106, 1218, 13), // "setDebugState"
QT_MOC_LITERAL(107, 1232, 7), // "isdebug"
QT_MOC_LITERAL(108, 1240, 9), // "getMargin"
QT_MOC_LITERAL(109, 1250, 9), // "getRobotx"
QT_MOC_LITERAL(110, 1260, 9), // "getRoboty"
QT_MOC_LITERAL(111, 1270, 10), // "getRobotth"
QT_MOC_LITERAL(112, 1281, 13), // "getRobotState"
QT_MOC_LITERAL(113, 1295, 10), // "getPathNum"
QT_MOC_LITERAL(114, 1306, 8), // "getPathx"
QT_MOC_LITERAL(115, 1315, 8), // "getPathy"
QT_MOC_LITERAL(116, 1324, 9), // "getPathth"
QT_MOC_LITERAL(117, 1334, 15), // "getLocalPathNum"
QT_MOC_LITERAL(118, 1350, 13), // "getLocalPathx"
QT_MOC_LITERAL(119, 1364, 13), // "getLocalPathy"
QT_MOC_LITERAL(120, 1378, 9), // "joyMoveXY"
QT_MOC_LITERAL(121, 1388, 8), // "joyMoveR"
QT_MOC_LITERAL(122, 1397, 1), // "r"
QT_MOC_LITERAL(123, 1399, 13), // "getCanvasSize"
QT_MOC_LITERAL(124, 1413, 11), // "getRedoSize"
QT_MOC_LITERAL(125, 1425, 8), // "getLineX"
QT_MOC_LITERAL(126, 1434, 5), // "index"
QT_MOC_LITERAL(127, 1440, 8), // "getLineY"
QT_MOC_LITERAL(128, 1449, 12), // "getLineColor"
QT_MOC_LITERAL(129, 1462, 12), // "getLineWidth"
QT_MOC_LITERAL(130, 1475, 9), // "startLine"
QT_MOC_LITERAL(131, 1485, 5), // "color"
QT_MOC_LITERAL(132, 1491, 5), // "width"
QT_MOC_LITERAL(133, 1497, 7), // "setLine"
QT_MOC_LITERAL(134, 1505, 8), // "stopLine"
QT_MOC_LITERAL(135, 1514, 4), // "undo"
QT_MOC_LITERAL(136, 1519, 4), // "redo"
QT_MOC_LITERAL(137, 1524, 9), // "clear_all"
QT_MOC_LITERAL(138, 1534, 9), // "getMapURL"
QT_MOC_LITERAL(139, 1544, 9), // "setMapURL"
QT_MOC_LITERAL(140, 1554, 3), // "url"
QT_MOC_LITERAL(141, 1558, 10), // "getDBvalue"
QT_MOC_LITERAL(142, 1569, 15), // "startRecordPath"
QT_MOC_LITERAL(143, 1585, 12), // "startcurPath"
QT_MOC_LITERAL(144, 1598, 11), // "stopcurPath"
QT_MOC_LITERAL(145, 1610, 12), // "pausecurPath"
QT_MOC_LITERAL(146, 1623, 15), // "runRotateTables"
QT_MOC_LITERAL(147, 1639, 16), // "stopRotateTables"
QT_MOC_LITERAL(148, 1656, 14), // "saveAnnotation"
QT_MOC_LITERAL(149, 1671, 8), // "filename"
QT_MOC_LITERAL(150, 1680, 12), // "saveMetaData"
QT_MOC_LITERAL(151, 1693, 15), // "sendMaptoServer"
QT_MOC_LITERAL(152, 1709, 7), // "setGrid"
QT_MOC_LITERAL(153, 1717, 8), // "editGrid"
QT_MOC_LITERAL(154, 1726, 7), // "getGrid"
QT_MOC_LITERAL(155, 1734, 13), // "calculateGrid"
QT_MOC_LITERAL(156, 1748, 14), // "calculateGrid2"
QT_MOC_LITERAL(157, 1763, 8), // "getFloor"
QT_MOC_LITERAL(158, 1772, 8), // "TOOL_NUM"
QT_MOC_LITERAL(159, 1781, 10), // "TOOL_MOUSE"
QT_MOC_LITERAL(160, 1792, 10), // "TOOL_BRUSH"
QT_MOC_LITERAL(161, 1803, 11), // "TOOL_ERASER"
QT_MOC_LITERAL(162, 1815, 6), // "UI_CMD"
QT_MOC_LITERAL(163, 1822, 11), // "UI_CMD_NONE"
QT_MOC_LITERAL(164, 1834, 17), // "UI_CMD_MOVE_TABLE"
QT_MOC_LITERAL(165, 1852, 12), // "UI_CMD_PAUSE"
QT_MOC_LITERAL(166, 1865, 13), // "UI_CMD_RESUME"
QT_MOC_LITERAL(167, 1879, 16), // "UI_CMD_MOVE_WAIT"
QT_MOC_LITERAL(168, 1896, 18), // "UI_CMD_MOVE_CHARGE"
QT_MOC_LITERAL(169, 1915, 21), // "UI_CMD_PICKUP_CONFIRM"
QT_MOC_LITERAL(170, 1937, 19), // "UI_CMD_WAIT_KITCHEN"
QT_MOC_LITERAL(171, 1957, 8), // "UI_STATE"
QT_MOC_LITERAL(172, 1966, 13), // "UI_STATE_NONE"
QT_MOC_LITERAL(173, 1980, 14), // "UI_STATE_READY"
QT_MOC_LITERAL(174, 1995, 15), // "UI_STATE_MOVING"
QT_MOC_LITERAL(175, 2011, 15), // "UI_STATE_PAUSED"
QT_MOC_LITERAL(176, 2027, 15), // "UI_STATE_PICKUP"
QT_MOC_LITERAL(177, 2043, 15), // "UI_STATE_CHARGE"
QT_MOC_LITERAL(178, 2059, 11), // "ROBOT_STATE"
QT_MOC_LITERAL(179, 2071, 21), // "ROBOT_STATE_NOT_READY"
QT_MOC_LITERAL(180, 2093, 17), // "ROBOT_STATE_READY"
QT_MOC_LITERAL(181, 2111, 18), // "ROBOT_STATE_MOVING"
QT_MOC_LITERAL(182, 2130, 17), // "ROBOT_STATE_AVOID"
QT_MOC_LITERAL(183, 2148, 18), // "ROBOT_STATE_PAUSED"
QT_MOC_LITERAL(184, 2167, 17), // "ROBOT_STATE_ERROR"
QT_MOC_LITERAL(185, 2185, 22), // "ROBOT_STATE_MANUALMODE"
QT_MOC_LITERAL(186, 2208, 11), // "ROBOT_ERROR"
QT_MOC_LITERAL(187, 2220, 16), // "ROBOT_ERROR_NONE"
QT_MOC_LITERAL(188, 2237, 15), // "ROBOT_ERROR_COL"
QT_MOC_LITERAL(189, 2253, 19), // "ROBOT_ERROR_NO_PATH"
QT_MOC_LITERAL(190, 2273, 22), // "ROBOT_ERROR_MOTOR_COMM"
QT_MOC_LITERAL(191, 2296, 17), // "ROBOT_ERROR_MOTOR"
QT_MOC_LITERAL(192, 2314, 19), // "ROBOT_ERROR_VOLTAGE"
QT_MOC_LITERAL(193, 2334, 18) // "ROBOT_ERROR_SENSOR"

    },
    "Supervisor\0onTimer\0\0server_cmd_pause\0"
    "server_cmd_resume\0server_cmd_newtarget\0"
    "path_changed\0setObjPose\0setMarginObj\0"
    "clearMarginObj\0setMarginPoint\0pixel_num\0"
    "getMarginObj\0QVector<int>\0setTray\0"
    "tray1\0tray2\0tray3\0moveTo\0target_num\0"
    "x\0y\0th\0movePause\0moveResume\0moveStop\0"
    "moveManual\0setVelocity\0vel\0velth\0"
    "confirmPickup\0moveToCharge\0moveToWait\0"
    "getBattery\0getState\0getErrcode\0"
    "getRobotName\0setRobotName\0name\0"
    "getVelocityXY\0getVelocityTH\0getPickuptrays\0"
    "getcurLoc\0getcurTable\0getcurTarget\0"
    "QVector<float>\0getImageChunkNum\0"
    "getImageSize\0getImageData\0getMapExist\0"
    "getMapState\0getMapname\0getMappath\0"
    "getMapWidth\0getMapHeight\0getGridWidth\0"
    "getOrigin\0getLocationNum\0getLocationTypes\0"
    "num\0getLocationx\0getLocationy\0"
    "getLocationth\0getObjectNum\0getObjectName\0"
    "getObjectPointSize\0getObjectX\0point\0"
    "getObjectY\0clickObject\0getTempObjectSize\0"
    "getTempObjectX\0getTempObjectY\0getObjNum\0"
    "getObjPointNum\0obj_num\0getLocNum\0"
    "getRobotRadius\0addObjectPoint\0"
    "editObjectPoint\0removeObjectPoint\0"
    "removeObjectPointLast\0clearObjectPoints\0"
    "addObject\0removeObject\0moveObjectPoint\0"
    "point_num\0removeLocation\0addLocation\0"
    "moveLocationPoint\0loc_num\0getTlineSize\0"
    "getTlineName\0getTlineX\0getTlineY\0"
    "addTline\0x1\0y1\0x2\0y2\0removeTline\0line\0"
    "getTlineNum\0setDebugName\0getDebugName\0"
    "getDebugState\0setDebugState\0isdebug\0"
    "getMargin\0getRobotx\0getRoboty\0getRobotth\0"
    "getRobotState\0getPathNum\0getPathx\0"
    "getPathy\0getPathth\0getLocalPathNum\0"
    "getLocalPathx\0getLocalPathy\0joyMoveXY\0"
    "joyMoveR\0r\0getCanvasSize\0getRedoSize\0"
    "getLineX\0index\0getLineY\0getLineColor\0"
    "getLineWidth\0startLine\0color\0width\0"
    "setLine\0stopLine\0undo\0redo\0clear_all\0"
    "getMapURL\0setMapURL\0url\0getDBvalue\0"
    "startRecordPath\0startcurPath\0stopcurPath\0"
    "pausecurPath\0runRotateTables\0"
    "stopRotateTables\0saveAnnotation\0"
    "filename\0saveMetaData\0sendMaptoServer\0"
    "setGrid\0editGrid\0getGrid\0calculateGrid\0"
    "calculateGrid2\0getFloor\0TOOL_NUM\0"
    "TOOL_MOUSE\0TOOL_BRUSH\0TOOL_ERASER\0"
    "UI_CMD\0UI_CMD_NONE\0UI_CMD_MOVE_TABLE\0"
    "UI_CMD_PAUSE\0UI_CMD_RESUME\0UI_CMD_MOVE_WAIT\0"
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
     132,   14, // methods
       0,    0, // properties
       5, 1014, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,  674,    2, 0x0a /* Public */,
       3,    0,  675,    2, 0x0a /* Public */,
       4,    0,  676,    2, 0x0a /* Public */,
       5,    0,  677,    2, 0x0a /* Public */,
       6,    0,  678,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
       7,    0,  679,    2, 0x02 /* Public */,
       8,    0,  680,    2, 0x02 /* Public */,
       9,    0,  681,    2, 0x02 /* Public */,
      10,    1,  682,    2, 0x02 /* Public */,
      12,    0,  685,    2, 0x02 /* Public */,
      14,    3,  686,    2, 0x02 /* Public */,
      18,    1,  693,    2, 0x02 /* Public */,
      18,    3,  696,    2, 0x02 /* Public */,
      23,    0,  703,    2, 0x02 /* Public */,
      24,    0,  704,    2, 0x02 /* Public */,
      25,    0,  705,    2, 0x02 /* Public */,
      26,    0,  706,    2, 0x02 /* Public */,
      27,    2,  707,    2, 0x02 /* Public */,
      30,    0,  712,    2, 0x02 /* Public */,
      31,    0,  713,    2, 0x02 /* Public */,
      32,    0,  714,    2, 0x02 /* Public */,
      33,    0,  715,    2, 0x02 /* Public */,
      34,    0,  716,    2, 0x02 /* Public */,
      35,    0,  717,    2, 0x02 /* Public */,
      36,    0,  718,    2, 0x02 /* Public */,
      37,    1,  719,    2, 0x02 /* Public */,
      39,    0,  722,    2, 0x02 /* Public */,
      40,    0,  723,    2, 0x02 /* Public */,
      41,    0,  724,    2, 0x02 /* Public */,
      42,    0,  725,    2, 0x02 /* Public */,
      43,    0,  726,    2, 0x02 /* Public */,
      44,    0,  727,    2, 0x02 /* Public */,
      46,    0,  728,    2, 0x02 /* Public */,
      47,    0,  729,    2, 0x02 /* Public */,
      48,    0,  730,    2, 0x02 /* Public */,
      49,    0,  731,    2, 0x02 /* Public */,
      50,    0,  732,    2, 0x02 /* Public */,
      51,    0,  733,    2, 0x02 /* Public */,
      52,    0,  734,    2, 0x02 /* Public */,
      53,    0,  735,    2, 0x02 /* Public */,
      54,    0,  736,    2, 0x02 /* Public */,
      55,    0,  737,    2, 0x02 /* Public */,
      56,    0,  738,    2, 0x02 /* Public */,
      57,    0,  739,    2, 0x02 /* Public */,
      58,    1,  740,    2, 0x02 /* Public */,
      60,    1,  743,    2, 0x02 /* Public */,
      61,    1,  746,    2, 0x02 /* Public */,
      62,    1,  749,    2, 0x02 /* Public */,
      63,    0,  752,    2, 0x02 /* Public */,
      64,    1,  753,    2, 0x02 /* Public */,
      65,    1,  756,    2, 0x02 /* Public */,
      66,    2,  759,    2, 0x02 /* Public */,
      68,    2,  764,    2, 0x02 /* Public */,
      69,    1,  769,    2, 0x02 /* Public */,
      69,    2,  772,    2, 0x02 /* Public */,
      70,    0,  777,    2, 0x02 /* Public */,
      71,    1,  778,    2, 0x02 /* Public */,
      72,    1,  781,    2, 0x02 /* Public */,
      73,    1,  784,    2, 0x02 /* Public */,
      73,    2,  787,    2, 0x02 /* Public */,
      74,    3,  792,    2, 0x02 /* Public */,
      76,    1,  799,    2, 0x02 /* Public */,
      76,    2,  802,    2, 0x02 /* Public */,
      77,    0,  807,    2, 0x02 /* Public */,
      78,    2,  808,    2, 0x02 /* Public */,
      79,    3,  813,    2, 0x02 /* Public */,
      80,    1,  820,    2, 0x02 /* Public */,
      81,    0,  823,    2, 0x02 /* Public */,
      82,    0,  824,    2, 0x02 /* Public */,
      83,    1,  825,    2, 0x02 /* Public */,
      84,    1,  828,    2, 0x02 /* Public */,
      85,    4,  831,    2, 0x02 /* Public */,
      87,    1,  840,    2, 0x02 /* Public */,
      88,    4,  843,    2, 0x02 /* Public */,
      89,    4,  852,    2, 0x02 /* Public */,
      91,    0,  861,    2, 0x02 /* Public */,
      91,    1,  862,    2, 0x02 /* Public */,
      92,    1,  865,    2, 0x02 /* Public */,
      93,    2,  868,    2, 0x02 /* Public */,
      94,    2,  873,    2, 0x02 /* Public */,
      95,    5,  878,    2, 0x02 /* Public */,
     100,    2,  889,    2, 0x02 /* Public */,
     102,    1,  894,    2, 0x02 /* Public */,
     102,    2,  897,    2, 0x02 /* Public */,
     103,    1,  902,    2, 0x02 /* Public */,
     104,    0,  905,    2, 0x02 /* Public */,
     105,    0,  906,    2, 0x02 /* Public */,
     106,    1,  907,    2, 0x02 /* Public */,
     108,    0,  910,    2, 0x02 /* Public */,
     109,    0,  911,    2, 0x02 /* Public */,
     110,    0,  912,    2, 0x02 /* Public */,
     111,    0,  913,    2, 0x02 /* Public */,
     112,    0,  914,    2, 0x02 /* Public */,
     113,    0,  915,    2, 0x02 /* Public */,
     114,    1,  916,    2, 0x02 /* Public */,
     115,    1,  919,    2, 0x02 /* Public */,
     116,    1,  922,    2, 0x02 /* Public */,
     117,    0,  925,    2, 0x02 /* Public */,
     118,    1,  926,    2, 0x02 /* Public */,
     119,    1,  929,    2, 0x02 /* Public */,
     120,    2,  932,    2, 0x02 /* Public */,
     121,    1,  937,    2, 0x02 /* Public */,
     123,    0,  940,    2, 0x02 /* Public */,
     124,    0,  941,    2, 0x02 /* Public */,
     125,    1,  942,    2, 0x02 /* Public */,
     127,    1,  945,    2, 0x02 /* Public */,
     128,    1,  948,    2, 0x02 /* Public */,
     129,    1,  951,    2, 0x02 /* Public */,
     130,    2,  954,    2, 0x02 /* Public */,
     133,    2,  959,    2, 0x02 /* Public */,
     134,    0,  964,    2, 0x02 /* Public */,
     135,    0,  965,    2, 0x02 /* Public */,
     136,    0,  966,    2, 0x02 /* Public */,
     137,    0,  967,    2, 0x02 /* Public */,
     138,    0,  968,    2, 0x02 /* Public */,
     139,    1,  969,    2, 0x02 /* Public */,
     141,    1,  972,    2, 0x02 /* Public */,
     142,    0,  975,    2, 0x02 /* Public */,
     143,    0,  976,    2, 0x02 /* Public */,
     144,    0,  977,    2, 0x02 /* Public */,
     145,    0,  978,    2, 0x02 /* Public */,
     146,    0,  979,    2, 0x02 /* Public */,
     147,    0,  980,    2, 0x02 /* Public */,
     148,    1,  981,    2, 0x02 /* Public */,
     150,    1,  984,    2, 0x02 /* Public */,
     151,    0,  987,    2, 0x02 /* Public */,
     152,    3,  988,    2, 0x02 /* Public */,
     153,    3,  995,    2, 0x02 /* Public */,
     154,    2, 1002,    2, 0x02 /* Public */,
     155,    0, 1007,    2, 0x02 /* Public */,
     156,    0, 1008,    2, 0x02 /* Public */,
     157,    2, 1009,    2, 0x02 /* Public */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   11,
    0x80000000 | 13,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int,   15,   16,   17,
    QMetaType::Void, QMetaType::QString,   19,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,   20,   21,   22,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Float, QMetaType::Float,   28,   29,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,   38,
    QMetaType::Float,
    QMetaType::Float,
    0x80000000 | 13,
    QMetaType::QString,
    QMetaType::QString,
    0x80000000 | 45,
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
    0x80000000 | 13,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   59,
    QMetaType::Float, QMetaType::Int,   59,
    QMetaType::Float, QMetaType::Int,   59,
    QMetaType::Float, QMetaType::Int,   59,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   59,
    QMetaType::Int, QMetaType::Int,   59,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   59,   67,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   59,   67,
    QMetaType::Void, QMetaType::QString,   38,
    QMetaType::Void, QMetaType::Float, QMetaType::Float,   20,   21,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   59,
    QMetaType::Float, QMetaType::Int,   59,
    QMetaType::Int, QMetaType::QString,   38,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   20,   21,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   75,   20,   21,
    QMetaType::Int, QMetaType::QString,   38,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   20,   21,
    QMetaType::Float,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   20,   21,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int,   59,   20,   21,
    QMetaType::Void, QMetaType::Int,   59,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   38,
    QMetaType::Void, QMetaType::QString,   38,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   75,   86,   20,   21,
    QMetaType::Void, QMetaType::QString,   38,
    QMetaType::Void, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::Float,   38,   20,   21,   22,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Float,   90,   20,   21,   22,
    QMetaType::Int,
    QMetaType::Int, QMetaType::Int,   59,
    QMetaType::QString, QMetaType::Int,   59,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   59,   67,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   59,   67,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   59,   96,   97,   98,   99,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   59,  101,
    QMetaType::Int, QMetaType::QString,   38,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   20,   21,
    QMetaType::Void, QMetaType::QString,   38,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  107,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   59,
    QMetaType::Float, QMetaType::Int,   59,
    QMetaType::Float, QMetaType::Int,   59,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   59,
    QMetaType::Float, QMetaType::Int,   59,
    QMetaType::Void, QMetaType::Float, QMetaType::Float,   20,   21,
    QMetaType::Void, QMetaType::Float,  122,
    QMetaType::Int,
    QMetaType::Int,
    0x80000000 | 13, QMetaType::Int,  126,
    0x80000000 | 13, QMetaType::Int,  126,
    QMetaType::QString, QMetaType::Int,  126,
    QMetaType::Float, QMetaType::Int,  126,
    QMetaType::Void, QMetaType::QString, QMetaType::Float,  131,  132,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   20,   21,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,  140,
    QMetaType::QString, QMetaType::QString,   38,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,  149,
    QMetaType::Void, QMetaType::QString,  149,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QString,   20,   21,   38,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QString,   20,   21,   38,
    QMetaType::QString, QMetaType::Int, QMetaType::Int,   20,   21,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,   20,   21,

 // enums: name, alias, flags, count, data
     158,  158, 0x0,    3, 1039,
     162,  162, 0x0,    8, 1045,
     171,  171, 0x0,    6, 1061,
     178,  178, 0x0,    7, 1073,
     186,  186, 0x0,    7, 1087,

 // enum data: key, value
     159, uint(Supervisor::TOOL_MOUSE),
     160, uint(Supervisor::TOOL_BRUSH),
     161, uint(Supervisor::TOOL_ERASER),
     163, uint(Supervisor::UI_CMD_NONE),
     164, uint(Supervisor::UI_CMD_MOVE_TABLE),
     165, uint(Supervisor::UI_CMD_PAUSE),
     166, uint(Supervisor::UI_CMD_RESUME),
     167, uint(Supervisor::UI_CMD_MOVE_WAIT),
     168, uint(Supervisor::UI_CMD_MOVE_CHARGE),
     169, uint(Supervisor::UI_CMD_PICKUP_CONFIRM),
     170, uint(Supervisor::UI_CMD_WAIT_KITCHEN),
     172, uint(Supervisor::UI_STATE_NONE),
     173, uint(Supervisor::UI_STATE_READY),
     174, uint(Supervisor::UI_STATE_MOVING),
     175, uint(Supervisor::UI_STATE_PAUSED),
     176, uint(Supervisor::UI_STATE_PICKUP),
     177, uint(Supervisor::UI_STATE_CHARGE),
     179, uint(Supervisor::ROBOT_STATE_NOT_READY),
     180, uint(Supervisor::ROBOT_STATE_READY),
     181, uint(Supervisor::ROBOT_STATE_MOVING),
     182, uint(Supervisor::ROBOT_STATE_AVOID),
     183, uint(Supervisor::ROBOT_STATE_PAUSED),
     184, uint(Supervisor::ROBOT_STATE_ERROR),
     185, uint(Supervisor::ROBOT_STATE_MANUALMODE),
     187, uint(Supervisor::ROBOT_ERROR_NONE),
     188, uint(Supervisor::ROBOT_ERROR_COL),
     189, uint(Supervisor::ROBOT_ERROR_NO_PATH),
     190, uint(Supervisor::ROBOT_ERROR_MOTOR_COMM),
     191, uint(Supervisor::ROBOT_ERROR_MOTOR),
     192, uint(Supervisor::ROBOT_ERROR_VOLTAGE),
     193, uint(Supervisor::ROBOT_ERROR_SENSOR),

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
        case 3: _t->server_cmd_newtarget(); break;
        case 4: _t->path_changed(); break;
        case 5: _t->setObjPose(); break;
        case 6: _t->setMarginObj(); break;
        case 7: _t->clearMarginObj(); break;
        case 8: _t->setMarginPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 9: { QVector<int> _r = _t->getMarginObj();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 10: _t->setTray((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 11: _t->moveTo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 12: _t->moveTo((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 13: _t->movePause(); break;
        case 14: _t->moveResume(); break;
        case 15: _t->moveStop(); break;
        case 16: _t->moveManual(); break;
        case 17: _t->setVelocity((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 18: _t->confirmPickup(); break;
        case 19: _t->moveToCharge(); break;
        case 20: _t->moveToWait(); break;
        case 21: { float _r = _t->getBattery();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 22: { int _r = _t->getState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 23: { int _r = _t->getErrcode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 24: { QString _r = _t->getRobotName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 25: _t->setRobotName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 26: { float _r = _t->getVelocityXY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 27: { float _r = _t->getVelocityTH();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 28: { QVector<int> _r = _t->getPickuptrays();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 29: { QString _r = _t->getcurLoc();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 30: { QString _r = _t->getcurTable();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 31: { QVector<float> _r = _t->getcurTarget();
            if (_a[0]) *reinterpret_cast< QVector<float>*>(_a[0]) = std::move(_r); }  break;
        case 32: { int _r = _t->getImageChunkNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 33: { uint _r = _t->getImageSize();
            if (_a[0]) *reinterpret_cast< uint*>(_a[0]) = std::move(_r); }  break;
        case 34: { QString _r = _t->getImageData();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 35: { bool _r = _t->getMapExist();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 36: { bool _r = _t->getMapState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 37: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 38: { QString _r = _t->getMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 39: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 40: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 41: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 42: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 43: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 44: { QString _r = _t->getLocationTypes((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 45: { float _r = _t->getLocationx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 46: { float _r = _t->getLocationy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 47: { float _r = _t->getLocationth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 48: { int _r = _t->getObjectNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 49: { QString _r = _t->getObjectName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 50: { int _r = _t->getObjectPointSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 51: { float _r = _t->getObjectX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 52: { float _r = _t->getObjectY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 53: _t->clickObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 54: _t->clickObject((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 55: { int _r = _t->getTempObjectSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 56: { float _r = _t->getTempObjectX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 57: { float _r = _t->getTempObjectY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 58: { int _r = _t->getObjNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 59: { int _r = _t->getObjNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 60: { int _r = _t->getObjPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 61: { int _r = _t->getLocNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 62: { int _r = _t->getLocNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 63: { float _r = _t->getRobotRadius();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 64: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 65: _t->editObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 66: _t->removeObjectPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 67: _t->removeObjectPointLast(); break;
        case 68: _t->clearObjectPoints(); break;
        case 69: _t->addObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 70: _t->removeObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 71: _t->moveObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4]))); break;
        case 72: _t->removeLocation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 73: _t->addLocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 74: _t->moveLocationPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 75: { int _r = _t->getTlineSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 76: { int _r = _t->getTlineSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 77: { QString _r = _t->getTlineName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 78: { float _r = _t->getTlineX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 79: { float _r = _t->getTlineY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 80: _t->addTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< int(*)>(_a[5]))); break;
        case 81: _t->removeTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 82: { int _r = _t->getTlineNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 83: { int _r = _t->getTlineNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 84: _t->setDebugName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 85: { QString _r = _t->getDebugName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 86: { bool _r = _t->getDebugState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 87: _t->setDebugState((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 88: { float _r = _t->getMargin();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 89: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 90: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 91: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 92: { int _r = _t->getRobotState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 93: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 94: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 95: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 96: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 97: { int _r = _t->getLocalPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 98: { float _r = _t->getLocalPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 99: { float _r = _t->getLocalPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 100: _t->joyMoveXY((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 101: _t->joyMoveR((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 102: { int _r = _t->getCanvasSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 103: { int _r = _t->getRedoSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 104: { QVector<int> _r = _t->getLineX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 105: { QVector<int> _r = _t->getLineY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 106: { QString _r = _t->getLineColor((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 107: { float _r = _t->getLineWidth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 108: _t->startLine((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 109: _t->setLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 110: _t->stopLine(); break;
        case 111: _t->undo(); break;
        case 112: _t->redo(); break;
        case 113: _t->clear_all(); break;
        case 114: { QString _r = _t->getMapURL();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 115: _t->setMapURL((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 116: { QString _r = _t->getDBvalue((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 117: _t->startRecordPath(); break;
        case 118: _t->startcurPath(); break;
        case 119: _t->stopcurPath(); break;
        case 120: _t->pausecurPath(); break;
        case 121: _t->runRotateTables(); break;
        case 122: _t->stopRotateTables(); break;
        case 123: _t->saveAnnotation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 124: _t->saveMetaData((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 125: _t->sendMaptoServer(); break;
        case 126: _t->setGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 127: _t->editGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 128: { QString _r = _t->getGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 129: _t->calculateGrid(); break;
        case 130: _t->calculateGrid2(); break;
        case 131: { bool _r = _t->getFloor((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
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
        if (_id < 132)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 132;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 132)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 132;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
