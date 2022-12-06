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
    QByteArrayData data[259];
    char stringdata0[3245];
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
QT_MOC_LITERAL(6, 76, 18), // "server_cmd_newcall"
QT_MOC_LITERAL(7, 95, 17), // "server_cmd_setini"
QT_MOC_LITERAL(8, 113, 12), // "path_changed"
QT_MOC_LITERAL(9, 126, 15), // "isConnectServer"
QT_MOC_LITERAL(10, 142, 10), // "isExistMap"
QT_MOC_LITERAL(11, 153, 15), // "loadMaptoServer"
QT_MOC_LITERAL(12, 169, 9), // "isUSBFile"
QT_MOC_LITERAL(13, 179, 14), // "getUSBFilename"
QT_MOC_LITERAL(14, 194, 12), // "loadMaptoUSB"
QT_MOC_LITERAL(15, 207, 14), // "isuseServerMap"
QT_MOC_LITERAL(16, 222, 15), // "setuseServerMap"
QT_MOC_LITERAL(17, 238, 3), // "use"
QT_MOC_LITERAL(18, 242, 12), // "removeRawMap"
QT_MOC_LITERAL(19, 255, 15), // "removeEditedMap"
QT_MOC_LITERAL(20, 271, 15), // "removeServerMap"
QT_MOC_LITERAL(21, 287, 9), // "isloadMap"
QT_MOC_LITERAL(22, 297, 10), // "setloadMap"
QT_MOC_LITERAL(23, 308, 4), // "load"
QT_MOC_LITERAL(24, 313, 15), // "isExistRobotINI"
QT_MOC_LITERAL(25, 329, 12), // "makeRobotINI"
QT_MOC_LITERAL(26, 342, 16), // "getLCMConnection"
QT_MOC_LITERAL(27, 359, 13), // "getLCMProcess"
QT_MOC_LITERAL(28, 373, 10), // "getIniRead"
QT_MOC_LITERAL(29, 384, 9), // "startSLAM"
QT_MOC_LITERAL(30, 394, 8), // "stopSLAM"
QT_MOC_LITERAL(31, 403, 11), // "setSLAMMode"
QT_MOC_LITERAL(32, 415, 4), // "mode"
QT_MOC_LITERAL(33, 420, 17), // "isConnectJoystick"
QT_MOC_LITERAL(34, 438, 11), // "getKeyboard"
QT_MOC_LITERAL(35, 450, 11), // "getJoystick"
QT_MOC_LITERAL(36, 462, 10), // "setObjPose"
QT_MOC_LITERAL(37, 473, 12), // "setMarginObj"
QT_MOC_LITERAL(38, 486, 14), // "clearMarginObj"
QT_MOC_LITERAL(39, 501, 14), // "setMarginPoint"
QT_MOC_LITERAL(40, 516, 9), // "pixel_num"
QT_MOC_LITERAL(41, 526, 12), // "getMarginObj"
QT_MOC_LITERAL(42, 539, 12), // "QVector<int>"
QT_MOC_LITERAL(43, 552, 11), // "programExit"
QT_MOC_LITERAL(44, 564, 11), // "programHide"
QT_MOC_LITERAL(45, 576, 10), // "acceptCall"
QT_MOC_LITERAL(46, 587, 3), // "yes"
QT_MOC_LITERAL(47, 591, 11), // "readSetting"
QT_MOC_LITERAL(48, 603, 7), // "setTray"
QT_MOC_LITERAL(49, 611, 8), // "tray_num"
QT_MOC_LITERAL(50, 620, 9), // "table_num"
QT_MOC_LITERAL(51, 630, 6), // "moveTo"
QT_MOC_LITERAL(52, 637, 10), // "target_num"
QT_MOC_LITERAL(53, 648, 1), // "x"
QT_MOC_LITERAL(54, 650, 1), // "y"
QT_MOC_LITERAL(55, 652, 2), // "th"
QT_MOC_LITERAL(56, 655, 9), // "movePause"
QT_MOC_LITERAL(57, 665, 10), // "moveResume"
QT_MOC_LITERAL(58, 676, 8), // "moveStop"
QT_MOC_LITERAL(59, 685, 10), // "moveManual"
QT_MOC_LITERAL(60, 696, 13), // "confirmPickup"
QT_MOC_LITERAL(61, 710, 12), // "moveToCharge"
QT_MOC_LITERAL(62, 723, 10), // "moveToWait"
QT_MOC_LITERAL(63, 734, 10), // "getBattery"
QT_MOC_LITERAL(64, 745, 8), // "getState"
QT_MOC_LITERAL(65, 754, 10), // "getErrcode"
QT_MOC_LITERAL(66, 765, 12), // "getRobotName"
QT_MOC_LITERAL(67, 778, 12), // "setRobotName"
QT_MOC_LITERAL(68, 791, 4), // "name"
QT_MOC_LITERAL(69, 796, 14), // "getPickuptrays"
QT_MOC_LITERAL(70, 811, 9), // "getcurLoc"
QT_MOC_LITERAL(71, 821, 11), // "getcurTable"
QT_MOC_LITERAL(72, 833, 12), // "getcurTarget"
QT_MOC_LITERAL(73, 846, 14), // "QVector<float>"
QT_MOC_LITERAL(74, 861, 16), // "getImageChunkNum"
QT_MOC_LITERAL(75, 878, 12), // "getImageSize"
QT_MOC_LITERAL(76, 891, 17), // "getPatrolFileName"
QT_MOC_LITERAL(77, 909, 10), // "makePatrol"
QT_MOC_LITERAL(78, 920, 14), // "loadPatrolFile"
QT_MOC_LITERAL(79, 935, 4), // "path"
QT_MOC_LITERAL(80, 940, 14), // "savePatrolFile"
QT_MOC_LITERAL(81, 955, 9), // "addPatrol"
QT_MOC_LITERAL(82, 965, 4), // "type"
QT_MOC_LITERAL(83, 970, 8), // "location"
QT_MOC_LITERAL(84, 979, 12), // "getPatrolNum"
QT_MOC_LITERAL(85, 992, 13), // "getPatrolType"
QT_MOC_LITERAL(86, 1006, 3), // "num"
QT_MOC_LITERAL(87, 1010, 17), // "getPatrolLocation"
QT_MOC_LITERAL(88, 1028, 10), // "getPatrolX"
QT_MOC_LITERAL(89, 1039, 10), // "getPatrolY"
QT_MOC_LITERAL(90, 1050, 11), // "getPatrolTH"
QT_MOC_LITERAL(91, 1062, 12), // "removePatrol"
QT_MOC_LITERAL(92, 1075, 12), // "movePatrolUp"
QT_MOC_LITERAL(93, 1088, 14), // "movePatrolDown"
QT_MOC_LITERAL(94, 1103, 13), // "getPatrolMode"
QT_MOC_LITERAL(95, 1117, 13), // "setPatrolMode"
QT_MOC_LITERAL(96, 1131, 11), // "setVelocity"
QT_MOC_LITERAL(97, 1143, 3), // "vel"
QT_MOC_LITERAL(98, 1147, 13), // "getVelocityXY"
QT_MOC_LITERAL(99, 1161, 16), // "getuseTravelline"
QT_MOC_LITERAL(100, 1178, 16), // "setuseTravelline"
QT_MOC_LITERAL(101, 1195, 16), // "getnumTravelline"
QT_MOC_LITERAL(102, 1212, 16), // "setnumTravelline"
QT_MOC_LITERAL(103, 1229, 10), // "getTrayNum"
QT_MOC_LITERAL(104, 1240, 10), // "setTrayNum"
QT_MOC_LITERAL(105, 1251, 11), // "getTableNum"
QT_MOC_LITERAL(106, 1263, 11), // "setTableNum"
QT_MOC_LITERAL(107, 1275, 11), // "getuseVoice"
QT_MOC_LITERAL(108, 1287, 11), // "setuseVoice"
QT_MOC_LITERAL(109, 1299, 9), // "getuseBGM"
QT_MOC_LITERAL(110, 1309, 9), // "setuseBGM"
QT_MOC_LITERAL(111, 1319, 12), // "getserverCMD"
QT_MOC_LITERAL(112, 1332, 12), // "setserverCMD"
QT_MOC_LITERAL(113, 1345, 12), // "getRobotType"
QT_MOC_LITERAL(114, 1358, 12), // "setRobotType"
QT_MOC_LITERAL(115, 1371, 11), // "getMapExist"
QT_MOC_LITERAL(116, 1383, 11), // "getMapState"
QT_MOC_LITERAL(117, 1395, 10), // "getMapname"
QT_MOC_LITERAL(118, 1406, 10), // "getMappath"
QT_MOC_LITERAL(119, 1417, 11), // "getMapWidth"
QT_MOC_LITERAL(120, 1429, 12), // "getMapHeight"
QT_MOC_LITERAL(121, 1442, 12), // "getGridWidth"
QT_MOC_LITERAL(122, 1455, 9), // "getOrigin"
QT_MOC_LITERAL(123, 1465, 14), // "getLocationNum"
QT_MOC_LITERAL(124, 1480, 16), // "getLocationTypes"
QT_MOC_LITERAL(125, 1497, 12), // "getLocationx"
QT_MOC_LITERAL(126, 1510, 12), // "getLocationy"
QT_MOC_LITERAL(127, 1523, 13), // "getLocationth"
QT_MOC_LITERAL(128, 1537, 8), // "getLidar"
QT_MOC_LITERAL(129, 1546, 12), // "getObjectNum"
QT_MOC_LITERAL(130, 1559, 13), // "getObjectName"
QT_MOC_LITERAL(131, 1573, 18), // "getObjectPointSize"
QT_MOC_LITERAL(132, 1592, 10), // "getObjectX"
QT_MOC_LITERAL(133, 1603, 5), // "point"
QT_MOC_LITERAL(134, 1609, 10), // "getObjectY"
QT_MOC_LITERAL(135, 1620, 17), // "getTempObjectSize"
QT_MOC_LITERAL(136, 1638, 14), // "getTempObjectX"
QT_MOC_LITERAL(137, 1653, 14), // "getTempObjectY"
QT_MOC_LITERAL(138, 1668, 9), // "getObjNum"
QT_MOC_LITERAL(139, 1678, 14), // "getObjPointNum"
QT_MOC_LITERAL(140, 1693, 7), // "obj_num"
QT_MOC_LITERAL(141, 1701, 9), // "getLocNum"
QT_MOC_LITERAL(142, 1711, 14), // "getRobotRadius"
QT_MOC_LITERAL(143, 1726, 14), // "addObjectPoint"
QT_MOC_LITERAL(144, 1741, 15), // "editObjectPoint"
QT_MOC_LITERAL(145, 1757, 17), // "removeObjectPoint"
QT_MOC_LITERAL(146, 1775, 21), // "removeObjectPointLast"
QT_MOC_LITERAL(147, 1797, 17), // "clearObjectPoints"
QT_MOC_LITERAL(148, 1815, 9), // "addObject"
QT_MOC_LITERAL(149, 1825, 12), // "removeObject"
QT_MOC_LITERAL(150, 1838, 15), // "moveObjectPoint"
QT_MOC_LITERAL(151, 1854, 9), // "point_num"
QT_MOC_LITERAL(152, 1864, 14), // "removeLocation"
QT_MOC_LITERAL(153, 1879, 11), // "addLocation"
QT_MOC_LITERAL(154, 1891, 17), // "moveLocationPoint"
QT_MOC_LITERAL(155, 1909, 7), // "loc_num"
QT_MOC_LITERAL(156, 1917, 12), // "getTlineSize"
QT_MOC_LITERAL(157, 1930, 12), // "getTlineName"
QT_MOC_LITERAL(158, 1943, 9), // "getTlineX"
QT_MOC_LITERAL(159, 1953, 9), // "getTlineY"
QT_MOC_LITERAL(160, 1963, 8), // "addTline"
QT_MOC_LITERAL(161, 1972, 2), // "x1"
QT_MOC_LITERAL(162, 1975, 2), // "y1"
QT_MOC_LITERAL(163, 1978, 2), // "x2"
QT_MOC_LITERAL(164, 1981, 2), // "y2"
QT_MOC_LITERAL(165, 1984, 11), // "removeTline"
QT_MOC_LITERAL(166, 1996, 4), // "line"
QT_MOC_LITERAL(167, 2001, 11), // "getTlineNum"
QT_MOC_LITERAL(168, 2013, 12), // "setDebugName"
QT_MOC_LITERAL(169, 2026, 12), // "getDebugName"
QT_MOC_LITERAL(170, 2039, 13), // "getDebugState"
QT_MOC_LITERAL(171, 2053, 13), // "setDebugState"
QT_MOC_LITERAL(172, 2067, 7), // "isdebug"
QT_MOC_LITERAL(173, 2075, 9), // "getMargin"
QT_MOC_LITERAL(174, 2085, 9), // "getRobotx"
QT_MOC_LITERAL(175, 2095, 9), // "getRoboty"
QT_MOC_LITERAL(176, 2105, 10), // "getRobotth"
QT_MOC_LITERAL(177, 2116, 13), // "getRobotState"
QT_MOC_LITERAL(178, 2130, 10), // "getPathNum"
QT_MOC_LITERAL(179, 2141, 8), // "getPathx"
QT_MOC_LITERAL(180, 2150, 8), // "getPathy"
QT_MOC_LITERAL(181, 2159, 9), // "getPathth"
QT_MOC_LITERAL(182, 2169, 15), // "getLocalPathNum"
QT_MOC_LITERAL(183, 2185, 13), // "getLocalPathx"
QT_MOC_LITERAL(184, 2199, 13), // "getLocalPathy"
QT_MOC_LITERAL(185, 2213, 9), // "joyMoveXY"
QT_MOC_LITERAL(186, 2223, 8), // "joyMoveR"
QT_MOC_LITERAL(187, 2232, 1), // "r"
QT_MOC_LITERAL(188, 2234, 13), // "getCanvasSize"
QT_MOC_LITERAL(189, 2248, 11), // "getRedoSize"
QT_MOC_LITERAL(190, 2260, 8), // "getLineX"
QT_MOC_LITERAL(191, 2269, 5), // "index"
QT_MOC_LITERAL(192, 2275, 8), // "getLineY"
QT_MOC_LITERAL(193, 2284, 12), // "getLineColor"
QT_MOC_LITERAL(194, 2297, 12), // "getLineWidth"
QT_MOC_LITERAL(195, 2310, 9), // "startLine"
QT_MOC_LITERAL(196, 2320, 5), // "color"
QT_MOC_LITERAL(197, 2326, 5), // "width"
QT_MOC_LITERAL(198, 2332, 7), // "setLine"
QT_MOC_LITERAL(199, 2340, 8), // "stopLine"
QT_MOC_LITERAL(200, 2349, 4), // "undo"
QT_MOC_LITERAL(201, 2354, 4), // "redo"
QT_MOC_LITERAL(202, 2359, 9), // "clear_all"
QT_MOC_LITERAL(203, 2369, 15), // "startRecordPath"
QT_MOC_LITERAL(204, 2385, 12), // "startcurPath"
QT_MOC_LITERAL(205, 2398, 11), // "stopcurPath"
QT_MOC_LITERAL(206, 2410, 12), // "pausecurPath"
QT_MOC_LITERAL(207, 2423, 15), // "runRotateTables"
QT_MOC_LITERAL(208, 2439, 16), // "stopRotateTables"
QT_MOC_LITERAL(209, 2456, 14), // "saveAnnotation"
QT_MOC_LITERAL(210, 2471, 8), // "filename"
QT_MOC_LITERAL(211, 2480, 12), // "saveMetaData"
QT_MOC_LITERAL(212, 2493, 15), // "sendMaptoServer"
QT_MOC_LITERAL(213, 2509, 7), // "setGrid"
QT_MOC_LITERAL(214, 2517, 8), // "editGrid"
QT_MOC_LITERAL(215, 2526, 7), // "getGrid"
QT_MOC_LITERAL(216, 2534, 12), // "make_minimap"
QT_MOC_LITERAL(217, 2547, 8), // "TOOL_NUM"
QT_MOC_LITERAL(218, 2556, 10), // "TOOL_MOUSE"
QT_MOC_LITERAL(219, 2567, 10), // "TOOL_BRUSH"
QT_MOC_LITERAL(220, 2578, 11), // "TOOL_ERASER"
QT_MOC_LITERAL(221, 2590, 6), // "UI_CMD"
QT_MOC_LITERAL(222, 2597, 11), // "UI_CMD_NONE"
QT_MOC_LITERAL(223, 2609, 17), // "UI_CMD_MOVE_TABLE"
QT_MOC_LITERAL(224, 2627, 12), // "UI_CMD_PAUSE"
QT_MOC_LITERAL(225, 2640, 13), // "UI_CMD_RESUME"
QT_MOC_LITERAL(226, 2654, 16), // "UI_CMD_MOVE_WAIT"
QT_MOC_LITERAL(227, 2671, 18), // "UI_CMD_MOVE_CHARGE"
QT_MOC_LITERAL(228, 2690, 21), // "UI_CMD_PICKUP_CONFIRM"
QT_MOC_LITERAL(229, 2712, 19), // "UI_CMD_WAIT_KITCHEN"
QT_MOC_LITERAL(230, 2732, 19), // "UI_CMD_TABLE_PATROL"
QT_MOC_LITERAL(231, 2752, 18), // "UI_CMD_PATROL_STOP"
QT_MOC_LITERAL(232, 2771, 8), // "UI_STATE"
QT_MOC_LITERAL(233, 2780, 13), // "UI_STATE_NONE"
QT_MOC_LITERAL(234, 2794, 14), // "UI_STATE_READY"
QT_MOC_LITERAL(235, 2809, 17), // "UI_STATE_CHARGING"
QT_MOC_LITERAL(236, 2827, 16), // "UI_STATE_GO_HOME"
QT_MOC_LITERAL(237, 2844, 18), // "UI_STATE_GO_CHARGE"
QT_MOC_LITERAL(238, 2863, 16), // "UI_STATE_SERVING"
QT_MOC_LITERAL(239, 2880, 16), // "UI_STATE_CALLING"
QT_MOC_LITERAL(240, 2897, 15), // "UI_STATE_PICKUP"
QT_MOC_LITERAL(241, 2913, 19), // "UI_STATE_PATROLLING"
QT_MOC_LITERAL(242, 2933, 17), // "UI_STATE_MOVEFAIL"
QT_MOC_LITERAL(243, 2951, 11), // "ROBOT_STATE"
QT_MOC_LITERAL(244, 2963, 21), // "ROBOT_STATE_NOT_READY"
QT_MOC_LITERAL(245, 2985, 17), // "ROBOT_STATE_READY"
QT_MOC_LITERAL(246, 3003, 18), // "ROBOT_STATE_MOVING"
QT_MOC_LITERAL(247, 3022, 17), // "ROBOT_STATE_AVOID"
QT_MOC_LITERAL(248, 3040, 18), // "ROBOT_STATE_PAUSED"
QT_MOC_LITERAL(249, 3059, 17), // "ROBOT_STATE_ERROR"
QT_MOC_LITERAL(250, 3077, 22), // "ROBOT_STATE_MANUALMODE"
QT_MOC_LITERAL(251, 3100, 11), // "ROBOT_ERROR"
QT_MOC_LITERAL(252, 3112, 16), // "ROBOT_ERROR_NONE"
QT_MOC_LITERAL(253, 3129, 15), // "ROBOT_ERROR_COL"
QT_MOC_LITERAL(254, 3145, 19), // "ROBOT_ERROR_NO_PATH"
QT_MOC_LITERAL(255, 3165, 22), // "ROBOT_ERROR_MOTOR_COMM"
QT_MOC_LITERAL(256, 3188, 17), // "ROBOT_ERROR_MOTOR"
QT_MOC_LITERAL(257, 3206, 19), // "ROBOT_ERROR_VOLTAGE"
QT_MOC_LITERAL(258, 3226, 18) // "ROBOT_ERROR_SENSOR"

    },
    "Supervisor\0onTimer\0\0server_cmd_pause\0"
    "server_cmd_resume\0server_cmd_newtarget\0"
    "server_cmd_newcall\0server_cmd_setini\0"
    "path_changed\0isConnectServer\0isExistMap\0"
    "loadMaptoServer\0isUSBFile\0getUSBFilename\0"
    "loadMaptoUSB\0isuseServerMap\0setuseServerMap\0"
    "use\0removeRawMap\0removeEditedMap\0"
    "removeServerMap\0isloadMap\0setloadMap\0"
    "load\0isExistRobotINI\0makeRobotINI\0"
    "getLCMConnection\0getLCMProcess\0"
    "getIniRead\0startSLAM\0stopSLAM\0setSLAMMode\0"
    "mode\0isConnectJoystick\0getKeyboard\0"
    "getJoystick\0setObjPose\0setMarginObj\0"
    "clearMarginObj\0setMarginPoint\0pixel_num\0"
    "getMarginObj\0QVector<int>\0programExit\0"
    "programHide\0acceptCall\0yes\0readSetting\0"
    "setTray\0tray_num\0table_num\0moveTo\0"
    "target_num\0x\0y\0th\0movePause\0moveResume\0"
    "moveStop\0moveManual\0confirmPickup\0"
    "moveToCharge\0moveToWait\0getBattery\0"
    "getState\0getErrcode\0getRobotName\0"
    "setRobotName\0name\0getPickuptrays\0"
    "getcurLoc\0getcurTable\0getcurTarget\0"
    "QVector<float>\0getImageChunkNum\0"
    "getImageSize\0getPatrolFileName\0"
    "makePatrol\0loadPatrolFile\0path\0"
    "savePatrolFile\0addPatrol\0type\0location\0"
    "getPatrolNum\0getPatrolType\0num\0"
    "getPatrolLocation\0getPatrolX\0getPatrolY\0"
    "getPatrolTH\0removePatrol\0movePatrolUp\0"
    "movePatrolDown\0getPatrolMode\0setPatrolMode\0"
    "setVelocity\0vel\0getVelocityXY\0"
    "getuseTravelline\0setuseTravelline\0"
    "getnumTravelline\0setnumTravelline\0"
    "getTrayNum\0setTrayNum\0getTableNum\0"
    "setTableNum\0getuseVoice\0setuseVoice\0"
    "getuseBGM\0setuseBGM\0getserverCMD\0"
    "setserverCMD\0getRobotType\0setRobotType\0"
    "getMapExist\0getMapState\0getMapname\0"
    "getMappath\0getMapWidth\0getMapHeight\0"
    "getGridWidth\0getOrigin\0getLocationNum\0"
    "getLocationTypes\0getLocationx\0"
    "getLocationy\0getLocationth\0getLidar\0"
    "getObjectNum\0getObjectName\0"
    "getObjectPointSize\0getObjectX\0point\0"
    "getObjectY\0getTempObjectSize\0"
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
    "startRecordPath\0startcurPath\0stopcurPath\0"
    "pausecurPath\0runRotateTables\0"
    "stopRotateTables\0saveAnnotation\0"
    "filename\0saveMetaData\0sendMaptoServer\0"
    "setGrid\0editGrid\0getGrid\0make_minimap\0"
    "TOOL_NUM\0TOOL_MOUSE\0TOOL_BRUSH\0"
    "TOOL_ERASER\0UI_CMD\0UI_CMD_NONE\0"
    "UI_CMD_MOVE_TABLE\0UI_CMD_PAUSE\0"
    "UI_CMD_RESUME\0UI_CMD_MOVE_WAIT\0"
    "UI_CMD_MOVE_CHARGE\0UI_CMD_PICKUP_CONFIRM\0"
    "UI_CMD_WAIT_KITCHEN\0UI_CMD_TABLE_PATROL\0"
    "UI_CMD_PATROL_STOP\0UI_STATE\0UI_STATE_NONE\0"
    "UI_STATE_READY\0UI_STATE_CHARGING\0"
    "UI_STATE_GO_HOME\0UI_STATE_GO_CHARGE\0"
    "UI_STATE_SERVING\0UI_STATE_CALLING\0"
    "UI_STATE_PICKUP\0UI_STATE_PATROLLING\0"
    "UI_STATE_MOVEFAIL\0ROBOT_STATE\0"
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
     186,   14, // methods
       0,    0, // properties
       5, 1380, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,  944,    2, 0x0a /* Public */,
       3,    0,  945,    2, 0x0a /* Public */,
       4,    0,  946,    2, 0x0a /* Public */,
       5,    0,  947,    2, 0x0a /* Public */,
       6,    0,  948,    2, 0x0a /* Public */,
       7,    0,  949,    2, 0x0a /* Public */,
       8,    0,  950,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
       9,    0,  951,    2, 0x02 /* Public */,
      10,    0,  952,    2, 0x02 /* Public */,
      11,    0,  953,    2, 0x02 /* Public */,
      12,    0,  954,    2, 0x02 /* Public */,
      13,    0,  955,    2, 0x02 /* Public */,
      14,    0,  956,    2, 0x02 /* Public */,
      15,    0,  957,    2, 0x02 /* Public */,
      16,    1,  958,    2, 0x02 /* Public */,
      18,    0,  961,    2, 0x02 /* Public */,
      19,    0,  962,    2, 0x02 /* Public */,
      20,    0,  963,    2, 0x02 /* Public */,
      21,    0,  964,    2, 0x02 /* Public */,
      22,    1,  965,    2, 0x02 /* Public */,
      24,    0,  968,    2, 0x02 /* Public */,
      25,    0,  969,    2, 0x02 /* Public */,
      26,    0,  970,    2, 0x02 /* Public */,
      27,    0,  971,    2, 0x02 /* Public */,
      28,    0,  972,    2, 0x02 /* Public */,
      29,    0,  973,    2, 0x02 /* Public */,
      30,    0,  974,    2, 0x02 /* Public */,
      31,    1,  975,    2, 0x02 /* Public */,
      33,    0,  978,    2, 0x02 /* Public */,
      34,    1,  979,    2, 0x02 /* Public */,
      35,    1,  982,    2, 0x02 /* Public */,
      36,    0,  985,    2, 0x02 /* Public */,
      37,    0,  986,    2, 0x02 /* Public */,
      38,    0,  987,    2, 0x02 /* Public */,
      39,    1,  988,    2, 0x02 /* Public */,
      41,    0,  991,    2, 0x02 /* Public */,
      43,    0,  992,    2, 0x02 /* Public */,
      44,    0,  993,    2, 0x02 /* Public */,
      45,    1,  994,    2, 0x02 /* Public */,
      47,    0,  997,    2, 0x02 /* Public */,
      48,    2,  998,    2, 0x02 /* Public */,
      51,    1, 1003,    2, 0x02 /* Public */,
      51,    3, 1006,    2, 0x02 /* Public */,
      56,    0, 1013,    2, 0x02 /* Public */,
      57,    0, 1014,    2, 0x02 /* Public */,
      58,    0, 1015,    2, 0x02 /* Public */,
      59,    0, 1016,    2, 0x02 /* Public */,
      60,    0, 1017,    2, 0x02 /* Public */,
      61,    0, 1018,    2, 0x02 /* Public */,
      62,    0, 1019,    2, 0x02 /* Public */,
      63,    0, 1020,    2, 0x02 /* Public */,
      64,    0, 1021,    2, 0x02 /* Public */,
      65,    0, 1022,    2, 0x02 /* Public */,
      66,    0, 1023,    2, 0x02 /* Public */,
      67,    1, 1024,    2, 0x02 /* Public */,
      69,    0, 1027,    2, 0x02 /* Public */,
      70,    0, 1028,    2, 0x02 /* Public */,
      71,    0, 1029,    2, 0x02 /* Public */,
      72,    0, 1030,    2, 0x02 /* Public */,
      74,    0, 1031,    2, 0x02 /* Public */,
      75,    0, 1032,    2, 0x02 /* Public */,
      76,    0, 1033,    2, 0x02 /* Public */,
      77,    0, 1034,    2, 0x02 /* Public */,
      78,    1, 1035,    2, 0x02 /* Public */,
      80,    1, 1038,    2, 0x02 /* Public */,
      81,    5, 1041,    2, 0x02 /* Public */,
      84,    0, 1052,    2, 0x02 /* Public */,
      85,    1, 1053,    2, 0x02 /* Public */,
      87,    1, 1056,    2, 0x02 /* Public */,
      88,    1, 1059,    2, 0x02 /* Public */,
      89,    1, 1062,    2, 0x02 /* Public */,
      90,    1, 1065,    2, 0x02 /* Public */,
      91,    1, 1068,    2, 0x02 /* Public */,
      92,    1, 1071,    2, 0x02 /* Public */,
      93,    1, 1074,    2, 0x02 /* Public */,
      94,    0, 1077,    2, 0x02 /* Public */,
      95,    1, 1078,    2, 0x02 /* Public */,
      96,    1, 1081,    2, 0x02 /* Public */,
      98,    0, 1084,    2, 0x02 /* Public */,
      99,    0, 1085,    2, 0x02 /* Public */,
     100,    1, 1086,    2, 0x02 /* Public */,
     101,    0, 1089,    2, 0x02 /* Public */,
     102,    1, 1090,    2, 0x02 /* Public */,
     103,    0, 1093,    2, 0x02 /* Public */,
     104,    1, 1094,    2, 0x02 /* Public */,
     105,    0, 1097,    2, 0x02 /* Public */,
     106,    1, 1098,    2, 0x02 /* Public */,
     107,    0, 1101,    2, 0x02 /* Public */,
     108,    1, 1102,    2, 0x02 /* Public */,
     109,    0, 1105,    2, 0x02 /* Public */,
     110,    1, 1106,    2, 0x02 /* Public */,
     111,    0, 1109,    2, 0x02 /* Public */,
     112,    1, 1110,    2, 0x02 /* Public */,
     113,    0, 1113,    2, 0x02 /* Public */,
     114,    1, 1114,    2, 0x02 /* Public */,
     115,    0, 1117,    2, 0x02 /* Public */,
     116,    0, 1118,    2, 0x02 /* Public */,
     117,    0, 1119,    2, 0x02 /* Public */,
     118,    0, 1120,    2, 0x02 /* Public */,
     119,    0, 1121,    2, 0x02 /* Public */,
     120,    0, 1122,    2, 0x02 /* Public */,
     121,    0, 1123,    2, 0x02 /* Public */,
     122,    0, 1124,    2, 0x02 /* Public */,
     123,    0, 1125,    2, 0x02 /* Public */,
     124,    1, 1126,    2, 0x02 /* Public */,
     125,    1, 1129,    2, 0x02 /* Public */,
     126,    1, 1132,    2, 0x02 /* Public */,
     127,    1, 1135,    2, 0x02 /* Public */,
     128,    1, 1138,    2, 0x02 /* Public */,
     129,    0, 1141,    2, 0x02 /* Public */,
     130,    1, 1142,    2, 0x02 /* Public */,
     131,    1, 1145,    2, 0x02 /* Public */,
     132,    2, 1148,    2, 0x02 /* Public */,
     134,    2, 1153,    2, 0x02 /* Public */,
     135,    0, 1158,    2, 0x02 /* Public */,
     136,    1, 1159,    2, 0x02 /* Public */,
     137,    1, 1162,    2, 0x02 /* Public */,
     138,    1, 1165,    2, 0x02 /* Public */,
     138,    2, 1168,    2, 0x02 /* Public */,
     139,    3, 1173,    2, 0x02 /* Public */,
     141,    1, 1180,    2, 0x02 /* Public */,
     141,    2, 1183,    2, 0x02 /* Public */,
     142,    0, 1188,    2, 0x02 /* Public */,
     143,    2, 1189,    2, 0x02 /* Public */,
     144,    3, 1194,    2, 0x02 /* Public */,
     145,    1, 1201,    2, 0x02 /* Public */,
     146,    0, 1204,    2, 0x02 /* Public */,
     147,    0, 1205,    2, 0x02 /* Public */,
     148,    1, 1206,    2, 0x02 /* Public */,
     149,    1, 1209,    2, 0x02 /* Public */,
     150,    4, 1212,    2, 0x02 /* Public */,
     152,    1, 1221,    2, 0x02 /* Public */,
     153,    4, 1224,    2, 0x02 /* Public */,
     154,    4, 1233,    2, 0x02 /* Public */,
     156,    0, 1242,    2, 0x02 /* Public */,
     156,    1, 1243,    2, 0x02 /* Public */,
     157,    1, 1246,    2, 0x02 /* Public */,
     158,    2, 1249,    2, 0x02 /* Public */,
     159,    2, 1254,    2, 0x02 /* Public */,
     160,    5, 1259,    2, 0x02 /* Public */,
     165,    2, 1270,    2, 0x02 /* Public */,
     167,    1, 1275,    2, 0x02 /* Public */,
     167,    2, 1278,    2, 0x02 /* Public */,
     168,    1, 1283,    2, 0x02 /* Public */,
     169,    0, 1286,    2, 0x02 /* Public */,
     170,    0, 1287,    2, 0x02 /* Public */,
     171,    1, 1288,    2, 0x02 /* Public */,
     173,    0, 1291,    2, 0x02 /* Public */,
     174,    0, 1292,    2, 0x02 /* Public */,
     175,    0, 1293,    2, 0x02 /* Public */,
     176,    0, 1294,    2, 0x02 /* Public */,
     177,    0, 1295,    2, 0x02 /* Public */,
     178,    0, 1296,    2, 0x02 /* Public */,
     179,    1, 1297,    2, 0x02 /* Public */,
     180,    1, 1300,    2, 0x02 /* Public */,
     181,    1, 1303,    2, 0x02 /* Public */,
     182,    0, 1306,    2, 0x02 /* Public */,
     183,    1, 1307,    2, 0x02 /* Public */,
     184,    1, 1310,    2, 0x02 /* Public */,
     185,    1, 1313,    2, 0x02 /* Public */,
     186,    1, 1316,    2, 0x02 /* Public */,
     188,    0, 1319,    2, 0x02 /* Public */,
     189,    0, 1320,    2, 0x02 /* Public */,
     190,    1, 1321,    2, 0x02 /* Public */,
     192,    1, 1324,    2, 0x02 /* Public */,
     193,    1, 1327,    2, 0x02 /* Public */,
     194,    1, 1330,    2, 0x02 /* Public */,
     195,    2, 1333,    2, 0x02 /* Public */,
     198,    2, 1338,    2, 0x02 /* Public */,
     199,    0, 1343,    2, 0x02 /* Public */,
     200,    0, 1344,    2, 0x02 /* Public */,
     201,    0, 1345,    2, 0x02 /* Public */,
     202,    0, 1346,    2, 0x02 /* Public */,
     203,    0, 1347,    2, 0x02 /* Public */,
     204,    0, 1348,    2, 0x02 /* Public */,
     205,    0, 1349,    2, 0x02 /* Public */,
     206,    0, 1350,    2, 0x02 /* Public */,
     207,    0, 1351,    2, 0x02 /* Public */,
     208,    0, 1352,    2, 0x02 /* Public */,
     209,    1, 1353,    2, 0x02 /* Public */,
     211,    1, 1356,    2, 0x02 /* Public */,
     212,    0, 1359,    2, 0x02 /* Public */,
     213,    3, 1360,    2, 0x02 /* Public */,
     214,    3, 1367,    2, 0x02 /* Public */,
     215,    2, 1374,    2, 0x02 /* Public */,
     216,    0, 1379,    2, 0x02 /* Public */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   17,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   23,
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   32,
    QMetaType::Bool,
    QMetaType::QString, QMetaType::Int,   32,
    QMetaType::QString, QMetaType::Int,   32,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   40,
    0x80000000 | 42,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,   46,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   49,   50,
    QMetaType::Void, QMetaType::QString,   52,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,   53,   54,   55,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,   68,
    0x80000000 | 42,
    QMetaType::QString,
    QMetaType::QString,
    0x80000000 | 73,
    QMetaType::Int,
    QMetaType::UInt,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   79,
    QMetaType::Void, QMetaType::QString,   79,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Float, QMetaType::Float, QMetaType::Float,   82,   83,   53,   54,   55,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   86,
    QMetaType::QString, QMetaType::Int,   86,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Void, QMetaType::Int,   86,
    QMetaType::Void, QMetaType::Int,   86,
    QMetaType::Void, QMetaType::Int,   86,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   32,
    QMetaType::Void, QMetaType::Float,   97,
    QMetaType::Float,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   17,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   86,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   49,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   50,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   17,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   17,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   17,
    QMetaType::QString,
    QMetaType::Void, QMetaType::Int,   82,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float,
    0x80000000 | 42,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   86,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   86,
    QMetaType::Int, QMetaType::Int,   86,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   86,  133,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   86,  133,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Int, QMetaType::QString,   68,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   53,   54,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  140,   53,   54,
    QMetaType::Int, QMetaType::QString,   68,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   53,   54,
    QMetaType::Float,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   53,   54,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int,   86,   53,   54,
    QMetaType::Void, QMetaType::Int,   86,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   68,
    QMetaType::Void, QMetaType::QString,   68,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  140,  151,   53,   54,
    QMetaType::Void, QMetaType::QString,   68,
    QMetaType::Void, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::Float,   68,   53,   54,   55,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Float,  155,   53,   54,   55,
    QMetaType::Int,
    QMetaType::Int, QMetaType::Int,   86,
    QMetaType::QString, QMetaType::Int,   86,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   86,  133,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   86,  133,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   86,  161,  162,  163,  164,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   86,  166,
    QMetaType::Int, QMetaType::QString,   68,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   53,   54,
    QMetaType::Void, QMetaType::QString,   68,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  172,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Float, QMetaType::Int,   86,
    QMetaType::Void, QMetaType::Float,   53,
    QMetaType::Void, QMetaType::Float,  187,
    QMetaType::Int,
    QMetaType::Int,
    0x80000000 | 42, QMetaType::Int,  191,
    0x80000000 | 42, QMetaType::Int,  191,
    QMetaType::QString, QMetaType::Int,  191,
    QMetaType::Float, QMetaType::Int,  191,
    QMetaType::Void, QMetaType::QString, QMetaType::Float,  196,  197,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   53,   54,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,  210,
    QMetaType::Void, QMetaType::QString,  210,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QString,   53,   54,   68,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QString,   53,   54,   68,
    QMetaType::QString, QMetaType::Int, QMetaType::Int,   53,   54,
    QMetaType::Void,

 // enums: name, alias, flags, count, data
     217,  217, 0x0,    3, 1405,
     221,  221, 0x0,   10, 1411,
     232,  232, 0x0,   10, 1431,
     243,  243, 0x0,    7, 1451,
     251,  251, 0x0,    7, 1465,

 // enum data: key, value
     218, uint(Supervisor::TOOL_MOUSE),
     219, uint(Supervisor::TOOL_BRUSH),
     220, uint(Supervisor::TOOL_ERASER),
     222, uint(Supervisor::UI_CMD_NONE),
     223, uint(Supervisor::UI_CMD_MOVE_TABLE),
     224, uint(Supervisor::UI_CMD_PAUSE),
     225, uint(Supervisor::UI_CMD_RESUME),
     226, uint(Supervisor::UI_CMD_MOVE_WAIT),
     227, uint(Supervisor::UI_CMD_MOVE_CHARGE),
     228, uint(Supervisor::UI_CMD_PICKUP_CONFIRM),
     229, uint(Supervisor::UI_CMD_WAIT_KITCHEN),
     230, uint(Supervisor::UI_CMD_TABLE_PATROL),
     231, uint(Supervisor::UI_CMD_PATROL_STOP),
     233, uint(Supervisor::UI_STATE_NONE),
     234, uint(Supervisor::UI_STATE_READY),
     235, uint(Supervisor::UI_STATE_CHARGING),
     236, uint(Supervisor::UI_STATE_GO_HOME),
     237, uint(Supervisor::UI_STATE_GO_CHARGE),
     238, uint(Supervisor::UI_STATE_SERVING),
     239, uint(Supervisor::UI_STATE_CALLING),
     240, uint(Supervisor::UI_STATE_PICKUP),
     241, uint(Supervisor::UI_STATE_PATROLLING),
     242, uint(Supervisor::UI_STATE_MOVEFAIL),
     244, uint(Supervisor::ROBOT_STATE_NOT_READY),
     245, uint(Supervisor::ROBOT_STATE_READY),
     246, uint(Supervisor::ROBOT_STATE_MOVING),
     247, uint(Supervisor::ROBOT_STATE_AVOID),
     248, uint(Supervisor::ROBOT_STATE_PAUSED),
     249, uint(Supervisor::ROBOT_STATE_ERROR),
     250, uint(Supervisor::ROBOT_STATE_MANUALMODE),
     252, uint(Supervisor::ROBOT_ERROR_NONE),
     253, uint(Supervisor::ROBOT_ERROR_COL),
     254, uint(Supervisor::ROBOT_ERROR_NO_PATH),
     255, uint(Supervisor::ROBOT_ERROR_MOTOR_COMM),
     256, uint(Supervisor::ROBOT_ERROR_MOTOR),
     257, uint(Supervisor::ROBOT_ERROR_VOLTAGE),
     258, uint(Supervisor::ROBOT_ERROR_SENSOR),

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
        case 4: _t->server_cmd_newcall(); break;
        case 5: _t->server_cmd_setini(); break;
        case 6: _t->path_changed(); break;
        case 7: { bool _r = _t->isConnectServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 8: { int _r = _t->isExistMap();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 9: { bool _r = _t->loadMaptoServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 10: { bool _r = _t->isUSBFile();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 11: { QString _r = _t->getUSBFilename();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 12: { bool _r = _t->loadMaptoUSB();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 13: { bool _r = _t->isuseServerMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 14: _t->setuseServerMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 15: _t->removeRawMap(); break;
        case 16: _t->removeEditedMap(); break;
        case 17: _t->removeServerMap(); break;
        case 18: { bool _r = _t->isloadMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 19: _t->setloadMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 20: { bool _r = _t->isExistRobotINI();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 21: _t->makeRobotINI(); break;
        case 22: { bool _r = _t->getLCMConnection();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 23: { bool _r = _t->getLCMProcess();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 24: { bool _r = _t->getIniRead();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 25: _t->startSLAM(); break;
        case 26: _t->stopSLAM(); break;
        case 27: _t->setSLAMMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 28: { bool _r = _t->isConnectJoystick();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 29: { QString _r = _t->getKeyboard((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 30: { QString _r = _t->getJoystick((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 31: _t->setObjPose(); break;
        case 32: _t->setMarginObj(); break;
        case 33: _t->clearMarginObj(); break;
        case 34: _t->setMarginPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 35: { QVector<int> _r = _t->getMarginObj();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 36: _t->programExit(); break;
        case 37: _t->programHide(); break;
        case 38: _t->acceptCall((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 39: _t->readSetting(); break;
        case 40: _t->setTray((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 41: _t->moveTo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 42: _t->moveTo((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 43: _t->movePause(); break;
        case 44: _t->moveResume(); break;
        case 45: _t->moveStop(); break;
        case 46: _t->moveManual(); break;
        case 47: _t->confirmPickup(); break;
        case 48: _t->moveToCharge(); break;
        case 49: _t->moveToWait(); break;
        case 50: { float _r = _t->getBattery();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 51: { int _r = _t->getState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 52: { int _r = _t->getErrcode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 53: { QString _r = _t->getRobotName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 54: _t->setRobotName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 55: { QVector<int> _r = _t->getPickuptrays();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 56: { QString _r = _t->getcurLoc();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 57: { QString _r = _t->getcurTable();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 58: { QVector<float> _r = _t->getcurTarget();
            if (_a[0]) *reinterpret_cast< QVector<float>*>(_a[0]) = std::move(_r); }  break;
        case 59: { int _r = _t->getImageChunkNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 60: { uint _r = _t->getImageSize();
            if (_a[0]) *reinterpret_cast< uint*>(_a[0]) = std::move(_r); }  break;
        case 61: { QString _r = _t->getPatrolFileName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 62: _t->makePatrol(); break;
        case 63: _t->loadPatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 64: _t->savePatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 65: _t->addPatrol((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4])),(*reinterpret_cast< float(*)>(_a[5]))); break;
        case 66: { int _r = _t->getPatrolNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 67: { QString _r = _t->getPatrolType((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 68: { QString _r = _t->getPatrolLocation((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 69: { float _r = _t->getPatrolX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 70: { float _r = _t->getPatrolY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 71: { float _r = _t->getPatrolTH((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 72: _t->removePatrol((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 73: _t->movePatrolUp((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 74: _t->movePatrolDown((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 75: { int _r = _t->getPatrolMode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 76: _t->setPatrolMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 77: _t->setVelocity((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 78: { float _r = _t->getVelocityXY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 79: { bool _r = _t->getuseTravelline();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 80: _t->setuseTravelline((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 81: { int _r = _t->getnumTravelline();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 82: _t->setnumTravelline((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 83: { int _r = _t->getTrayNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 84: _t->setTrayNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 85: { int _r = _t->getTableNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 86: _t->setTableNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 87: { bool _r = _t->getuseVoice();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 88: _t->setuseVoice((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 89: { bool _r = _t->getuseBGM();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 90: _t->setuseBGM((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 91: { bool _r = _t->getserverCMD();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 92: _t->setserverCMD((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 93: { QString _r = _t->getRobotType();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 94: _t->setRobotType((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 95: { bool _r = _t->getMapExist();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 96: { bool _r = _t->getMapState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 97: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 98: { QString _r = _t->getMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 99: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 100: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 101: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 102: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 103: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 104: { QString _r = _t->getLocationTypes((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 105: { float _r = _t->getLocationx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 106: { float _r = _t->getLocationy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 107: { float _r = _t->getLocationth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 108: { float _r = _t->getLidar((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 109: { int _r = _t->getObjectNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 110: { QString _r = _t->getObjectName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 111: { int _r = _t->getObjectPointSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 112: { float _r = _t->getObjectX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 113: { float _r = _t->getObjectY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 114: { int _r = _t->getTempObjectSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 115: { float _r = _t->getTempObjectX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 116: { float _r = _t->getTempObjectY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 117: { int _r = _t->getObjNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 118: { int _r = _t->getObjNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 119: { int _r = _t->getObjPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 120: { int _r = _t->getLocNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 121: { int _r = _t->getLocNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 122: { float _r = _t->getRobotRadius();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 123: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 124: _t->editObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 125: _t->removeObjectPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 126: _t->removeObjectPointLast(); break;
        case 127: _t->clearObjectPoints(); break;
        case 128: _t->addObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 129: _t->removeObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 130: _t->moveObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4]))); break;
        case 131: _t->removeLocation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 132: _t->addLocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 133: _t->moveLocationPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 134: { int _r = _t->getTlineSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 135: { int _r = _t->getTlineSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 136: { QString _r = _t->getTlineName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 137: { float _r = _t->getTlineX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 138: { float _r = _t->getTlineY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 139: _t->addTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< int(*)>(_a[5]))); break;
        case 140: _t->removeTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 141: { int _r = _t->getTlineNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 142: { int _r = _t->getTlineNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 143: _t->setDebugName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 144: { QString _r = _t->getDebugName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 145: { bool _r = _t->getDebugState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 146: _t->setDebugState((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 147: { float _r = _t->getMargin();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 148: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 149: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 150: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 151: { int _r = _t->getRobotState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 152: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 153: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 154: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 155: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 156: { int _r = _t->getLocalPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 157: { float _r = _t->getLocalPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 158: { float _r = _t->getLocalPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 159: _t->joyMoveXY((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 160: _t->joyMoveR((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 161: { int _r = _t->getCanvasSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 162: { int _r = _t->getRedoSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 163: { QVector<int> _r = _t->getLineX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 164: { QVector<int> _r = _t->getLineY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 165: { QString _r = _t->getLineColor((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 166: { float _r = _t->getLineWidth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 167: _t->startLine((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 168: _t->setLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 169: _t->stopLine(); break;
        case 170: _t->undo(); break;
        case 171: _t->redo(); break;
        case 172: _t->clear_all(); break;
        case 173: _t->startRecordPath(); break;
        case 174: _t->startcurPath(); break;
        case 175: _t->stopcurPath(); break;
        case 176: _t->pausecurPath(); break;
        case 177: _t->runRotateTables(); break;
        case 178: _t->stopRotateTables(); break;
        case 179: _t->saveAnnotation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 180: _t->saveMetaData((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 181: _t->sendMaptoServer(); break;
        case 182: _t->setGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 183: _t->editGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 184: { QString _r = _t->getGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 185: _t->make_minimap(); break;
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
        if (_id < 186)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 186;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 186)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 186;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
