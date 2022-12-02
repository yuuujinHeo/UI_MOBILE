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
    QByteArrayData data[235];
    char stringdata0[2934];
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
QT_MOC_LITERAL(24, 313, 9), // "startSLAM"
QT_MOC_LITERAL(25, 323, 8), // "stopSLAM"
QT_MOC_LITERAL(26, 332, 11), // "setSLAMMode"
QT_MOC_LITERAL(27, 344, 4), // "mode"
QT_MOC_LITERAL(28, 349, 17), // "isConnectJoystick"
QT_MOC_LITERAL(29, 367, 11), // "getKeyboard"
QT_MOC_LITERAL(30, 379, 11), // "getJoystick"
QT_MOC_LITERAL(31, 391, 10), // "setObjPose"
QT_MOC_LITERAL(32, 402, 12), // "setMarginObj"
QT_MOC_LITERAL(33, 415, 14), // "clearMarginObj"
QT_MOC_LITERAL(34, 430, 14), // "setMarginPoint"
QT_MOC_LITERAL(35, 445, 9), // "pixel_num"
QT_MOC_LITERAL(36, 455, 12), // "getMarginObj"
QT_MOC_LITERAL(37, 468, 12), // "QVector<int>"
QT_MOC_LITERAL(38, 481, 11), // "programExit"
QT_MOC_LITERAL(39, 493, 11), // "programHide"
QT_MOC_LITERAL(40, 505, 10), // "acceptCall"
QT_MOC_LITERAL(41, 516, 3), // "yes"
QT_MOC_LITERAL(42, 520, 11), // "readSetting"
QT_MOC_LITERAL(43, 532, 7), // "setTray"
QT_MOC_LITERAL(44, 540, 8), // "tray_num"
QT_MOC_LITERAL(45, 549, 9), // "table_num"
QT_MOC_LITERAL(46, 559, 6), // "moveTo"
QT_MOC_LITERAL(47, 566, 10), // "target_num"
QT_MOC_LITERAL(48, 577, 1), // "x"
QT_MOC_LITERAL(49, 579, 1), // "y"
QT_MOC_LITERAL(50, 581, 2), // "th"
QT_MOC_LITERAL(51, 584, 9), // "movePause"
QT_MOC_LITERAL(52, 594, 10), // "moveResume"
QT_MOC_LITERAL(53, 605, 8), // "moveStop"
QT_MOC_LITERAL(54, 614, 10), // "moveManual"
QT_MOC_LITERAL(55, 625, 13), // "confirmPickup"
QT_MOC_LITERAL(56, 639, 12), // "moveToCharge"
QT_MOC_LITERAL(57, 652, 10), // "moveToWait"
QT_MOC_LITERAL(58, 663, 10), // "getBattery"
QT_MOC_LITERAL(59, 674, 8), // "getState"
QT_MOC_LITERAL(60, 683, 10), // "getErrcode"
QT_MOC_LITERAL(61, 694, 12), // "getRobotName"
QT_MOC_LITERAL(62, 707, 12), // "setRobotName"
QT_MOC_LITERAL(63, 720, 4), // "name"
QT_MOC_LITERAL(64, 725, 14), // "getPickuptrays"
QT_MOC_LITERAL(65, 740, 9), // "getcurLoc"
QT_MOC_LITERAL(66, 750, 11), // "getcurTable"
QT_MOC_LITERAL(67, 762, 12), // "getcurTarget"
QT_MOC_LITERAL(68, 775, 14), // "QVector<float>"
QT_MOC_LITERAL(69, 790, 16), // "getImageChunkNum"
QT_MOC_LITERAL(70, 807, 12), // "getImageSize"
QT_MOC_LITERAL(71, 820, 11), // "setVelocity"
QT_MOC_LITERAL(72, 832, 3), // "vel"
QT_MOC_LITERAL(73, 836, 13), // "getVelocityXY"
QT_MOC_LITERAL(74, 850, 16), // "getuseTravelline"
QT_MOC_LITERAL(75, 867, 16), // "setuseTravelline"
QT_MOC_LITERAL(76, 884, 16), // "getnumTravelline"
QT_MOC_LITERAL(77, 901, 16), // "setnumTravelline"
QT_MOC_LITERAL(78, 918, 3), // "num"
QT_MOC_LITERAL(79, 922, 10), // "getTrayNum"
QT_MOC_LITERAL(80, 933, 10), // "setTrayNum"
QT_MOC_LITERAL(81, 944, 11), // "getTableNum"
QT_MOC_LITERAL(82, 956, 11), // "setTableNum"
QT_MOC_LITERAL(83, 968, 11), // "getuseVoice"
QT_MOC_LITERAL(84, 980, 11), // "setuseVoice"
QT_MOC_LITERAL(85, 992, 9), // "getuseBGM"
QT_MOC_LITERAL(86, 1002, 9), // "setuseBGM"
QT_MOC_LITERAL(87, 1012, 12), // "getserverCMD"
QT_MOC_LITERAL(88, 1025, 12), // "setserverCMD"
QT_MOC_LITERAL(89, 1038, 12), // "getRobotType"
QT_MOC_LITERAL(90, 1051, 12), // "setRobotType"
QT_MOC_LITERAL(91, 1064, 4), // "type"
QT_MOC_LITERAL(92, 1069, 11), // "getMapExist"
QT_MOC_LITERAL(93, 1081, 11), // "getMapState"
QT_MOC_LITERAL(94, 1093, 10), // "getMapname"
QT_MOC_LITERAL(95, 1104, 10), // "getMappath"
QT_MOC_LITERAL(96, 1115, 11), // "getMapWidth"
QT_MOC_LITERAL(97, 1127, 12), // "getMapHeight"
QT_MOC_LITERAL(98, 1140, 12), // "getGridWidth"
QT_MOC_LITERAL(99, 1153, 9), // "getOrigin"
QT_MOC_LITERAL(100, 1163, 14), // "getLocationNum"
QT_MOC_LITERAL(101, 1178, 16), // "getLocationTypes"
QT_MOC_LITERAL(102, 1195, 12), // "getLocationx"
QT_MOC_LITERAL(103, 1208, 12), // "getLocationy"
QT_MOC_LITERAL(104, 1221, 13), // "getLocationth"
QT_MOC_LITERAL(105, 1235, 12), // "getObjectNum"
QT_MOC_LITERAL(106, 1248, 13), // "getObjectName"
QT_MOC_LITERAL(107, 1262, 18), // "getObjectPointSize"
QT_MOC_LITERAL(108, 1281, 10), // "getObjectX"
QT_MOC_LITERAL(109, 1292, 5), // "point"
QT_MOC_LITERAL(110, 1298, 10), // "getObjectY"
QT_MOC_LITERAL(111, 1309, 17), // "getTempObjectSize"
QT_MOC_LITERAL(112, 1327, 14), // "getTempObjectX"
QT_MOC_LITERAL(113, 1342, 14), // "getTempObjectY"
QT_MOC_LITERAL(114, 1357, 9), // "getObjNum"
QT_MOC_LITERAL(115, 1367, 14), // "getObjPointNum"
QT_MOC_LITERAL(116, 1382, 7), // "obj_num"
QT_MOC_LITERAL(117, 1390, 9), // "getLocNum"
QT_MOC_LITERAL(118, 1400, 14), // "getRobotRadius"
QT_MOC_LITERAL(119, 1415, 14), // "addObjectPoint"
QT_MOC_LITERAL(120, 1430, 15), // "editObjectPoint"
QT_MOC_LITERAL(121, 1446, 17), // "removeObjectPoint"
QT_MOC_LITERAL(122, 1464, 21), // "removeObjectPointLast"
QT_MOC_LITERAL(123, 1486, 17), // "clearObjectPoints"
QT_MOC_LITERAL(124, 1504, 9), // "addObject"
QT_MOC_LITERAL(125, 1514, 12), // "removeObject"
QT_MOC_LITERAL(126, 1527, 15), // "moveObjectPoint"
QT_MOC_LITERAL(127, 1543, 9), // "point_num"
QT_MOC_LITERAL(128, 1553, 14), // "removeLocation"
QT_MOC_LITERAL(129, 1568, 11), // "addLocation"
QT_MOC_LITERAL(130, 1580, 17), // "moveLocationPoint"
QT_MOC_LITERAL(131, 1598, 7), // "loc_num"
QT_MOC_LITERAL(132, 1606, 12), // "getTlineSize"
QT_MOC_LITERAL(133, 1619, 12), // "getTlineName"
QT_MOC_LITERAL(134, 1632, 9), // "getTlineX"
QT_MOC_LITERAL(135, 1642, 9), // "getTlineY"
QT_MOC_LITERAL(136, 1652, 8), // "addTline"
QT_MOC_LITERAL(137, 1661, 2), // "x1"
QT_MOC_LITERAL(138, 1664, 2), // "y1"
QT_MOC_LITERAL(139, 1667, 2), // "x2"
QT_MOC_LITERAL(140, 1670, 2), // "y2"
QT_MOC_LITERAL(141, 1673, 11), // "removeTline"
QT_MOC_LITERAL(142, 1685, 4), // "line"
QT_MOC_LITERAL(143, 1690, 11), // "getTlineNum"
QT_MOC_LITERAL(144, 1702, 12), // "setDebugName"
QT_MOC_LITERAL(145, 1715, 12), // "getDebugName"
QT_MOC_LITERAL(146, 1728, 13), // "getDebugState"
QT_MOC_LITERAL(147, 1742, 13), // "setDebugState"
QT_MOC_LITERAL(148, 1756, 7), // "isdebug"
QT_MOC_LITERAL(149, 1764, 9), // "getMargin"
QT_MOC_LITERAL(150, 1774, 9), // "getRobotx"
QT_MOC_LITERAL(151, 1784, 9), // "getRoboty"
QT_MOC_LITERAL(152, 1794, 10), // "getRobotth"
QT_MOC_LITERAL(153, 1805, 13), // "getRobotState"
QT_MOC_LITERAL(154, 1819, 10), // "getPathNum"
QT_MOC_LITERAL(155, 1830, 8), // "getPathx"
QT_MOC_LITERAL(156, 1839, 8), // "getPathy"
QT_MOC_LITERAL(157, 1848, 9), // "getPathth"
QT_MOC_LITERAL(158, 1858, 15), // "getLocalPathNum"
QT_MOC_LITERAL(159, 1874, 13), // "getLocalPathx"
QT_MOC_LITERAL(160, 1888, 13), // "getLocalPathy"
QT_MOC_LITERAL(161, 1902, 9), // "joyMoveXY"
QT_MOC_LITERAL(162, 1912, 8), // "joyMoveR"
QT_MOC_LITERAL(163, 1921, 1), // "r"
QT_MOC_LITERAL(164, 1923, 13), // "getCanvasSize"
QT_MOC_LITERAL(165, 1937, 11), // "getRedoSize"
QT_MOC_LITERAL(166, 1949, 8), // "getLineX"
QT_MOC_LITERAL(167, 1958, 5), // "index"
QT_MOC_LITERAL(168, 1964, 8), // "getLineY"
QT_MOC_LITERAL(169, 1973, 12), // "getLineColor"
QT_MOC_LITERAL(170, 1986, 12), // "getLineWidth"
QT_MOC_LITERAL(171, 1999, 9), // "startLine"
QT_MOC_LITERAL(172, 2009, 5), // "color"
QT_MOC_LITERAL(173, 2015, 5), // "width"
QT_MOC_LITERAL(174, 2021, 7), // "setLine"
QT_MOC_LITERAL(175, 2029, 8), // "stopLine"
QT_MOC_LITERAL(176, 2038, 4), // "undo"
QT_MOC_LITERAL(177, 2043, 4), // "redo"
QT_MOC_LITERAL(178, 2048, 9), // "clear_all"
QT_MOC_LITERAL(179, 2058, 15), // "startRecordPath"
QT_MOC_LITERAL(180, 2074, 12), // "startcurPath"
QT_MOC_LITERAL(181, 2087, 11), // "stopcurPath"
QT_MOC_LITERAL(182, 2099, 12), // "pausecurPath"
QT_MOC_LITERAL(183, 2112, 15), // "runRotateTables"
QT_MOC_LITERAL(184, 2128, 16), // "stopRotateTables"
QT_MOC_LITERAL(185, 2145, 14), // "saveAnnotation"
QT_MOC_LITERAL(186, 2160, 8), // "filename"
QT_MOC_LITERAL(187, 2169, 12), // "saveMetaData"
QT_MOC_LITERAL(188, 2182, 15), // "sendMaptoServer"
QT_MOC_LITERAL(189, 2198, 7), // "setGrid"
QT_MOC_LITERAL(190, 2206, 8), // "editGrid"
QT_MOC_LITERAL(191, 2215, 7), // "getGrid"
QT_MOC_LITERAL(192, 2223, 12), // "make_minimap"
QT_MOC_LITERAL(193, 2236, 8), // "TOOL_NUM"
QT_MOC_LITERAL(194, 2245, 10), // "TOOL_MOUSE"
QT_MOC_LITERAL(195, 2256, 10), // "TOOL_BRUSH"
QT_MOC_LITERAL(196, 2267, 11), // "TOOL_ERASER"
QT_MOC_LITERAL(197, 2279, 6), // "UI_CMD"
QT_MOC_LITERAL(198, 2286, 11), // "UI_CMD_NONE"
QT_MOC_LITERAL(199, 2298, 17), // "UI_CMD_MOVE_TABLE"
QT_MOC_LITERAL(200, 2316, 12), // "UI_CMD_PAUSE"
QT_MOC_LITERAL(201, 2329, 13), // "UI_CMD_RESUME"
QT_MOC_LITERAL(202, 2343, 16), // "UI_CMD_MOVE_WAIT"
QT_MOC_LITERAL(203, 2360, 18), // "UI_CMD_MOVE_CHARGE"
QT_MOC_LITERAL(204, 2379, 21), // "UI_CMD_PICKUP_CONFIRM"
QT_MOC_LITERAL(205, 2401, 19), // "UI_CMD_WAIT_KITCHEN"
QT_MOC_LITERAL(206, 2421, 19), // "UI_CMD_TABLE_PATROL"
QT_MOC_LITERAL(207, 2441, 18), // "UI_CMD_PATROL_STOP"
QT_MOC_LITERAL(208, 2460, 8), // "UI_STATE"
QT_MOC_LITERAL(209, 2469, 13), // "UI_STATE_NONE"
QT_MOC_LITERAL(210, 2483, 14), // "UI_STATE_READY"
QT_MOC_LITERAL(211, 2498, 17), // "UI_STATE_CHARGING"
QT_MOC_LITERAL(212, 2516, 16), // "UI_STATE_GO_HOME"
QT_MOC_LITERAL(213, 2533, 18), // "UI_STATE_GO_CHARGE"
QT_MOC_LITERAL(214, 2552, 16), // "UI_STATE_SERVING"
QT_MOC_LITERAL(215, 2569, 16), // "UI_STATE_CALLING"
QT_MOC_LITERAL(216, 2586, 15), // "UI_STATE_PICKUP"
QT_MOC_LITERAL(217, 2602, 19), // "UI_STATE_PATROLLING"
QT_MOC_LITERAL(218, 2622, 17), // "UI_STATE_MOVEFAIL"
QT_MOC_LITERAL(219, 2640, 11), // "ROBOT_STATE"
QT_MOC_LITERAL(220, 2652, 21), // "ROBOT_STATE_NOT_READY"
QT_MOC_LITERAL(221, 2674, 17), // "ROBOT_STATE_READY"
QT_MOC_LITERAL(222, 2692, 18), // "ROBOT_STATE_MOVING"
QT_MOC_LITERAL(223, 2711, 17), // "ROBOT_STATE_AVOID"
QT_MOC_LITERAL(224, 2729, 18), // "ROBOT_STATE_PAUSED"
QT_MOC_LITERAL(225, 2748, 17), // "ROBOT_STATE_ERROR"
QT_MOC_LITERAL(226, 2766, 22), // "ROBOT_STATE_MANUALMODE"
QT_MOC_LITERAL(227, 2789, 11), // "ROBOT_ERROR"
QT_MOC_LITERAL(228, 2801, 16), // "ROBOT_ERROR_NONE"
QT_MOC_LITERAL(229, 2818, 15), // "ROBOT_ERROR_COL"
QT_MOC_LITERAL(230, 2834, 19), // "ROBOT_ERROR_NO_PATH"
QT_MOC_LITERAL(231, 2854, 22), // "ROBOT_ERROR_MOTOR_COMM"
QT_MOC_LITERAL(232, 2877, 17), // "ROBOT_ERROR_MOTOR"
QT_MOC_LITERAL(233, 2895, 19), // "ROBOT_ERROR_VOLTAGE"
QT_MOC_LITERAL(234, 2915, 18) // "ROBOT_ERROR_SENSOR"

    },
    "Supervisor\0onTimer\0\0server_cmd_pause\0"
    "server_cmd_resume\0server_cmd_newtarget\0"
    "server_cmd_newcall\0server_cmd_setini\0"
    "path_changed\0isConnectServer\0isExistMap\0"
    "loadMaptoServer\0isUSBFile\0getUSBFilename\0"
    "loadMaptoUSB\0isuseServerMap\0setuseServerMap\0"
    "use\0removeRawMap\0removeEditedMap\0"
    "removeServerMap\0isloadMap\0setloadMap\0"
    "load\0startSLAM\0stopSLAM\0setSLAMMode\0"
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
    "getImageSize\0setVelocity\0vel\0getVelocityXY\0"
    "getuseTravelline\0setuseTravelline\0"
    "getnumTravelline\0setnumTravelline\0num\0"
    "getTrayNum\0setTrayNum\0getTableNum\0"
    "setTableNum\0getuseVoice\0setuseVoice\0"
    "getuseBGM\0setuseBGM\0getserverCMD\0"
    "setserverCMD\0getRobotType\0setRobotType\0"
    "type\0getMapExist\0getMapState\0getMapname\0"
    "getMappath\0getMapWidth\0getMapHeight\0"
    "getGridWidth\0getOrigin\0getLocationNum\0"
    "getLocationTypes\0getLocationx\0"
    "getLocationy\0getLocationth\0getObjectNum\0"
    "getObjectName\0getObjectPointSize\0"
    "getObjectX\0point\0getObjectY\0"
    "getTempObjectSize\0getTempObjectX\0"
    "getTempObjectY\0getObjNum\0getObjPointNum\0"
    "obj_num\0getLocNum\0getRobotRadius\0"
    "addObjectPoint\0editObjectPoint\0"
    "removeObjectPoint\0removeObjectPointLast\0"
    "clearObjectPoints\0addObject\0removeObject\0"
    "moveObjectPoint\0point_num\0removeLocation\0"
    "addLocation\0moveLocationPoint\0loc_num\0"
    "getTlineSize\0getTlineName\0getTlineX\0"
    "getTlineY\0addTline\0x1\0y1\0x2\0y2\0"
    "removeTline\0line\0getTlineNum\0setDebugName\0"
    "getDebugName\0getDebugState\0setDebugState\0"
    "isdebug\0getMargin\0getRobotx\0getRoboty\0"
    "getRobotth\0getRobotState\0getPathNum\0"
    "getPathx\0getPathy\0getPathth\0getLocalPathNum\0"
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
     164,   14, // methods
       0,    0, // properties
       5, 1214, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,  834,    2, 0x0a /* Public */,
       3,    0,  835,    2, 0x0a /* Public */,
       4,    0,  836,    2, 0x0a /* Public */,
       5,    0,  837,    2, 0x0a /* Public */,
       6,    0,  838,    2, 0x0a /* Public */,
       7,    0,  839,    2, 0x0a /* Public */,
       8,    0,  840,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
       9,    0,  841,    2, 0x02 /* Public */,
      10,    0,  842,    2, 0x02 /* Public */,
      11,    0,  843,    2, 0x02 /* Public */,
      12,    0,  844,    2, 0x02 /* Public */,
      13,    0,  845,    2, 0x02 /* Public */,
      14,    0,  846,    2, 0x02 /* Public */,
      15,    0,  847,    2, 0x02 /* Public */,
      16,    1,  848,    2, 0x02 /* Public */,
      18,    0,  851,    2, 0x02 /* Public */,
      19,    0,  852,    2, 0x02 /* Public */,
      20,    0,  853,    2, 0x02 /* Public */,
      21,    0,  854,    2, 0x02 /* Public */,
      22,    1,  855,    2, 0x02 /* Public */,
      24,    0,  858,    2, 0x02 /* Public */,
      25,    0,  859,    2, 0x02 /* Public */,
      26,    1,  860,    2, 0x02 /* Public */,
      28,    0,  863,    2, 0x02 /* Public */,
      29,    1,  864,    2, 0x02 /* Public */,
      30,    1,  867,    2, 0x02 /* Public */,
      31,    0,  870,    2, 0x02 /* Public */,
      32,    0,  871,    2, 0x02 /* Public */,
      33,    0,  872,    2, 0x02 /* Public */,
      34,    1,  873,    2, 0x02 /* Public */,
      36,    0,  876,    2, 0x02 /* Public */,
      38,    0,  877,    2, 0x02 /* Public */,
      39,    0,  878,    2, 0x02 /* Public */,
      40,    1,  879,    2, 0x02 /* Public */,
      42,    0,  882,    2, 0x02 /* Public */,
      43,    2,  883,    2, 0x02 /* Public */,
      46,    1,  888,    2, 0x02 /* Public */,
      46,    3,  891,    2, 0x02 /* Public */,
      51,    0,  898,    2, 0x02 /* Public */,
      52,    0,  899,    2, 0x02 /* Public */,
      53,    0,  900,    2, 0x02 /* Public */,
      54,    0,  901,    2, 0x02 /* Public */,
      55,    0,  902,    2, 0x02 /* Public */,
      56,    0,  903,    2, 0x02 /* Public */,
      57,    0,  904,    2, 0x02 /* Public */,
      58,    0,  905,    2, 0x02 /* Public */,
      59,    0,  906,    2, 0x02 /* Public */,
      60,    0,  907,    2, 0x02 /* Public */,
      61,    0,  908,    2, 0x02 /* Public */,
      62,    1,  909,    2, 0x02 /* Public */,
      64,    0,  912,    2, 0x02 /* Public */,
      65,    0,  913,    2, 0x02 /* Public */,
      66,    0,  914,    2, 0x02 /* Public */,
      67,    0,  915,    2, 0x02 /* Public */,
      69,    0,  916,    2, 0x02 /* Public */,
      70,    0,  917,    2, 0x02 /* Public */,
      71,    1,  918,    2, 0x02 /* Public */,
      73,    0,  921,    2, 0x02 /* Public */,
      74,    0,  922,    2, 0x02 /* Public */,
      75,    1,  923,    2, 0x02 /* Public */,
      76,    0,  926,    2, 0x02 /* Public */,
      77,    1,  927,    2, 0x02 /* Public */,
      79,    0,  930,    2, 0x02 /* Public */,
      80,    1,  931,    2, 0x02 /* Public */,
      81,    0,  934,    2, 0x02 /* Public */,
      82,    1,  935,    2, 0x02 /* Public */,
      83,    0,  938,    2, 0x02 /* Public */,
      84,    1,  939,    2, 0x02 /* Public */,
      85,    0,  942,    2, 0x02 /* Public */,
      86,    1,  943,    2, 0x02 /* Public */,
      87,    0,  946,    2, 0x02 /* Public */,
      88,    1,  947,    2, 0x02 /* Public */,
      89,    0,  950,    2, 0x02 /* Public */,
      90,    1,  951,    2, 0x02 /* Public */,
      92,    0,  954,    2, 0x02 /* Public */,
      93,    0,  955,    2, 0x02 /* Public */,
      94,    0,  956,    2, 0x02 /* Public */,
      95,    0,  957,    2, 0x02 /* Public */,
      96,    0,  958,    2, 0x02 /* Public */,
      97,    0,  959,    2, 0x02 /* Public */,
      98,    0,  960,    2, 0x02 /* Public */,
      99,    0,  961,    2, 0x02 /* Public */,
     100,    0,  962,    2, 0x02 /* Public */,
     101,    1,  963,    2, 0x02 /* Public */,
     102,    1,  966,    2, 0x02 /* Public */,
     103,    1,  969,    2, 0x02 /* Public */,
     104,    1,  972,    2, 0x02 /* Public */,
     105,    0,  975,    2, 0x02 /* Public */,
     106,    1,  976,    2, 0x02 /* Public */,
     107,    1,  979,    2, 0x02 /* Public */,
     108,    2,  982,    2, 0x02 /* Public */,
     110,    2,  987,    2, 0x02 /* Public */,
     111,    0,  992,    2, 0x02 /* Public */,
     112,    1,  993,    2, 0x02 /* Public */,
     113,    1,  996,    2, 0x02 /* Public */,
     114,    1,  999,    2, 0x02 /* Public */,
     114,    2, 1002,    2, 0x02 /* Public */,
     115,    3, 1007,    2, 0x02 /* Public */,
     117,    1, 1014,    2, 0x02 /* Public */,
     117,    2, 1017,    2, 0x02 /* Public */,
     118,    0, 1022,    2, 0x02 /* Public */,
     119,    2, 1023,    2, 0x02 /* Public */,
     120,    3, 1028,    2, 0x02 /* Public */,
     121,    1, 1035,    2, 0x02 /* Public */,
     122,    0, 1038,    2, 0x02 /* Public */,
     123,    0, 1039,    2, 0x02 /* Public */,
     124,    1, 1040,    2, 0x02 /* Public */,
     125,    1, 1043,    2, 0x02 /* Public */,
     126,    4, 1046,    2, 0x02 /* Public */,
     128,    1, 1055,    2, 0x02 /* Public */,
     129,    4, 1058,    2, 0x02 /* Public */,
     130,    4, 1067,    2, 0x02 /* Public */,
     132,    0, 1076,    2, 0x02 /* Public */,
     132,    1, 1077,    2, 0x02 /* Public */,
     133,    1, 1080,    2, 0x02 /* Public */,
     134,    2, 1083,    2, 0x02 /* Public */,
     135,    2, 1088,    2, 0x02 /* Public */,
     136,    5, 1093,    2, 0x02 /* Public */,
     141,    2, 1104,    2, 0x02 /* Public */,
     143,    1, 1109,    2, 0x02 /* Public */,
     143,    2, 1112,    2, 0x02 /* Public */,
     144,    1, 1117,    2, 0x02 /* Public */,
     145,    0, 1120,    2, 0x02 /* Public */,
     146,    0, 1121,    2, 0x02 /* Public */,
     147,    1, 1122,    2, 0x02 /* Public */,
     149,    0, 1125,    2, 0x02 /* Public */,
     150,    0, 1126,    2, 0x02 /* Public */,
     151,    0, 1127,    2, 0x02 /* Public */,
     152,    0, 1128,    2, 0x02 /* Public */,
     153,    0, 1129,    2, 0x02 /* Public */,
     154,    0, 1130,    2, 0x02 /* Public */,
     155,    1, 1131,    2, 0x02 /* Public */,
     156,    1, 1134,    2, 0x02 /* Public */,
     157,    1, 1137,    2, 0x02 /* Public */,
     158,    0, 1140,    2, 0x02 /* Public */,
     159,    1, 1141,    2, 0x02 /* Public */,
     160,    1, 1144,    2, 0x02 /* Public */,
     161,    1, 1147,    2, 0x02 /* Public */,
     162,    1, 1150,    2, 0x02 /* Public */,
     164,    0, 1153,    2, 0x02 /* Public */,
     165,    0, 1154,    2, 0x02 /* Public */,
     166,    1, 1155,    2, 0x02 /* Public */,
     168,    1, 1158,    2, 0x02 /* Public */,
     169,    1, 1161,    2, 0x02 /* Public */,
     170,    1, 1164,    2, 0x02 /* Public */,
     171,    2, 1167,    2, 0x02 /* Public */,
     174,    2, 1172,    2, 0x02 /* Public */,
     175,    0, 1177,    2, 0x02 /* Public */,
     176,    0, 1178,    2, 0x02 /* Public */,
     177,    0, 1179,    2, 0x02 /* Public */,
     178,    0, 1180,    2, 0x02 /* Public */,
     179,    0, 1181,    2, 0x02 /* Public */,
     180,    0, 1182,    2, 0x02 /* Public */,
     181,    0, 1183,    2, 0x02 /* Public */,
     182,    0, 1184,    2, 0x02 /* Public */,
     183,    0, 1185,    2, 0x02 /* Public */,
     184,    0, 1186,    2, 0x02 /* Public */,
     185,    1, 1187,    2, 0x02 /* Public */,
     187,    1, 1190,    2, 0x02 /* Public */,
     188,    0, 1193,    2, 0x02 /* Public */,
     189,    3, 1194,    2, 0x02 /* Public */,
     190,    3, 1201,    2, 0x02 /* Public */,
     191,    2, 1208,    2, 0x02 /* Public */,
     192,    0, 1213,    2, 0x02 /* Public */,

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
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   27,
    QMetaType::Bool,
    QMetaType::QString, QMetaType::Int,   27,
    QMetaType::QString, QMetaType::Int,   27,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   35,
    0x80000000 | 37,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,   41,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   44,   45,
    QMetaType::Void, QMetaType::QString,   47,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,   48,   49,   50,
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
    QMetaType::Void, QMetaType::QString,   63,
    0x80000000 | 37,
    QMetaType::QString,
    QMetaType::QString,
    0x80000000 | 68,
    QMetaType::Int,
    QMetaType::UInt,
    QMetaType::Void, QMetaType::Float,   72,
    QMetaType::Float,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   17,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   78,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   44,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   45,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   17,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   17,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   17,
    QMetaType::QString,
    QMetaType::Void, QMetaType::Int,   91,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float,
    0x80000000 | 37,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   78,
    QMetaType::Float, QMetaType::Int,   78,
    QMetaType::Float, QMetaType::Int,   78,
    QMetaType::Float, QMetaType::Int,   78,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   78,
    QMetaType::Int, QMetaType::Int,   78,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   78,  109,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   78,  109,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   78,
    QMetaType::Float, QMetaType::Int,   78,
    QMetaType::Int, QMetaType::QString,   63,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   48,   49,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  116,   48,   49,
    QMetaType::Int, QMetaType::QString,   63,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   48,   49,
    QMetaType::Float,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   48,   49,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int,   78,   48,   49,
    QMetaType::Void, QMetaType::Int,   78,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   63,
    QMetaType::Void, QMetaType::QString,   63,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  116,  127,   48,   49,
    QMetaType::Void, QMetaType::QString,   63,
    QMetaType::Void, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::Float,   63,   48,   49,   50,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Float,  131,   48,   49,   50,
    QMetaType::Int,
    QMetaType::Int, QMetaType::Int,   78,
    QMetaType::QString, QMetaType::Int,   78,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   78,  109,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   78,  109,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   78,  137,  138,  139,  140,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   78,  142,
    QMetaType::Int, QMetaType::QString,   63,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   48,   49,
    QMetaType::Void, QMetaType::QString,   63,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  148,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   78,
    QMetaType::Float, QMetaType::Int,   78,
    QMetaType::Float, QMetaType::Int,   78,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   78,
    QMetaType::Float, QMetaType::Int,   78,
    QMetaType::Void, QMetaType::Float,   48,
    QMetaType::Void, QMetaType::Float,  163,
    QMetaType::Int,
    QMetaType::Int,
    0x80000000 | 37, QMetaType::Int,  167,
    0x80000000 | 37, QMetaType::Int,  167,
    QMetaType::QString, QMetaType::Int,  167,
    QMetaType::Float, QMetaType::Int,  167,
    QMetaType::Void, QMetaType::QString, QMetaType::Float,  172,  173,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   48,   49,
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
    QMetaType::Void, QMetaType::QString,  186,
    QMetaType::Void, QMetaType::QString,  186,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QString,   48,   49,   63,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QString,   48,   49,   63,
    QMetaType::QString, QMetaType::Int, QMetaType::Int,   48,   49,
    QMetaType::Void,

 // enums: name, alias, flags, count, data
     193,  193, 0x0,    3, 1239,
     197,  197, 0x0,   10, 1245,
     208,  208, 0x0,   10, 1265,
     219,  219, 0x0,    7, 1285,
     227,  227, 0x0,    7, 1299,

 // enum data: key, value
     194, uint(Supervisor::TOOL_MOUSE),
     195, uint(Supervisor::TOOL_BRUSH),
     196, uint(Supervisor::TOOL_ERASER),
     198, uint(Supervisor::UI_CMD_NONE),
     199, uint(Supervisor::UI_CMD_MOVE_TABLE),
     200, uint(Supervisor::UI_CMD_PAUSE),
     201, uint(Supervisor::UI_CMD_RESUME),
     202, uint(Supervisor::UI_CMD_MOVE_WAIT),
     203, uint(Supervisor::UI_CMD_MOVE_CHARGE),
     204, uint(Supervisor::UI_CMD_PICKUP_CONFIRM),
     205, uint(Supervisor::UI_CMD_WAIT_KITCHEN),
     206, uint(Supervisor::UI_CMD_TABLE_PATROL),
     207, uint(Supervisor::UI_CMD_PATROL_STOP),
     209, uint(Supervisor::UI_STATE_NONE),
     210, uint(Supervisor::UI_STATE_READY),
     211, uint(Supervisor::UI_STATE_CHARGING),
     212, uint(Supervisor::UI_STATE_GO_HOME),
     213, uint(Supervisor::UI_STATE_GO_CHARGE),
     214, uint(Supervisor::UI_STATE_SERVING),
     215, uint(Supervisor::UI_STATE_CALLING),
     216, uint(Supervisor::UI_STATE_PICKUP),
     217, uint(Supervisor::UI_STATE_PATROLLING),
     218, uint(Supervisor::UI_STATE_MOVEFAIL),
     220, uint(Supervisor::ROBOT_STATE_NOT_READY),
     221, uint(Supervisor::ROBOT_STATE_READY),
     222, uint(Supervisor::ROBOT_STATE_MOVING),
     223, uint(Supervisor::ROBOT_STATE_AVOID),
     224, uint(Supervisor::ROBOT_STATE_PAUSED),
     225, uint(Supervisor::ROBOT_STATE_ERROR),
     226, uint(Supervisor::ROBOT_STATE_MANUALMODE),
     228, uint(Supervisor::ROBOT_ERROR_NONE),
     229, uint(Supervisor::ROBOT_ERROR_COL),
     230, uint(Supervisor::ROBOT_ERROR_NO_PATH),
     231, uint(Supervisor::ROBOT_ERROR_MOTOR_COMM),
     232, uint(Supervisor::ROBOT_ERROR_MOTOR),
     233, uint(Supervisor::ROBOT_ERROR_VOLTAGE),
     234, uint(Supervisor::ROBOT_ERROR_SENSOR),

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
        case 20: _t->startSLAM(); break;
        case 21: _t->stopSLAM(); break;
        case 22: _t->setSLAMMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 23: { bool _r = _t->isConnectJoystick();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 24: { QString _r = _t->getKeyboard((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 25: { QString _r = _t->getJoystick((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 26: _t->setObjPose(); break;
        case 27: _t->setMarginObj(); break;
        case 28: _t->clearMarginObj(); break;
        case 29: _t->setMarginPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 30: { QVector<int> _r = _t->getMarginObj();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 31: _t->programExit(); break;
        case 32: _t->programHide(); break;
        case 33: _t->acceptCall((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 34: _t->readSetting(); break;
        case 35: _t->setTray((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 36: _t->moveTo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 37: _t->moveTo((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 38: _t->movePause(); break;
        case 39: _t->moveResume(); break;
        case 40: _t->moveStop(); break;
        case 41: _t->moveManual(); break;
        case 42: _t->confirmPickup(); break;
        case 43: _t->moveToCharge(); break;
        case 44: _t->moveToWait(); break;
        case 45: { float _r = _t->getBattery();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 46: { int _r = _t->getState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 47: { int _r = _t->getErrcode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 48: { QString _r = _t->getRobotName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 49: _t->setRobotName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 50: { QVector<int> _r = _t->getPickuptrays();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 51: { QString _r = _t->getcurLoc();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 52: { QString _r = _t->getcurTable();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 53: { QVector<float> _r = _t->getcurTarget();
            if (_a[0]) *reinterpret_cast< QVector<float>*>(_a[0]) = std::move(_r); }  break;
        case 54: { int _r = _t->getImageChunkNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 55: { uint _r = _t->getImageSize();
            if (_a[0]) *reinterpret_cast< uint*>(_a[0]) = std::move(_r); }  break;
        case 56: _t->setVelocity((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 57: { float _r = _t->getVelocityXY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 58: { bool _r = _t->getuseTravelline();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 59: _t->setuseTravelline((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 60: { int _r = _t->getnumTravelline();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 61: _t->setnumTravelline((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 62: { int _r = _t->getTrayNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 63: _t->setTrayNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 64: { int _r = _t->getTableNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 65: _t->setTableNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 66: { bool _r = _t->getuseVoice();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 67: _t->setuseVoice((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 68: { bool _r = _t->getuseBGM();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 69: _t->setuseBGM((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 70: { bool _r = _t->getserverCMD();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 71: _t->setserverCMD((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 72: { QString _r = _t->getRobotType();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 73: _t->setRobotType((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 74: { bool _r = _t->getMapExist();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 75: { bool _r = _t->getMapState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 76: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 77: { QString _r = _t->getMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 78: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 79: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 80: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 81: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 82: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 83: { QString _r = _t->getLocationTypes((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 84: { float _r = _t->getLocationx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 85: { float _r = _t->getLocationy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 86: { float _r = _t->getLocationth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 87: { int _r = _t->getObjectNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 88: { QString _r = _t->getObjectName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 89: { int _r = _t->getObjectPointSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 90: { float _r = _t->getObjectX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 91: { float _r = _t->getObjectY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 92: { int _r = _t->getTempObjectSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 93: { float _r = _t->getTempObjectX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 94: { float _r = _t->getTempObjectY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 95: { int _r = _t->getObjNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 96: { int _r = _t->getObjNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 97: { int _r = _t->getObjPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 98: { int _r = _t->getLocNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 99: { int _r = _t->getLocNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 100: { float _r = _t->getRobotRadius();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 101: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 102: _t->editObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 103: _t->removeObjectPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 104: _t->removeObjectPointLast(); break;
        case 105: _t->clearObjectPoints(); break;
        case 106: _t->addObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 107: _t->removeObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 108: _t->moveObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4]))); break;
        case 109: _t->removeLocation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 110: _t->addLocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 111: _t->moveLocationPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 112: { int _r = _t->getTlineSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 113: { int _r = _t->getTlineSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 114: { QString _r = _t->getTlineName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 115: { float _r = _t->getTlineX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 116: { float _r = _t->getTlineY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 117: _t->addTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< int(*)>(_a[5]))); break;
        case 118: _t->removeTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 119: { int _r = _t->getTlineNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 120: { int _r = _t->getTlineNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 121: _t->setDebugName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 122: { QString _r = _t->getDebugName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 123: { bool _r = _t->getDebugState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 124: _t->setDebugState((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 125: { float _r = _t->getMargin();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 126: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 127: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 128: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 129: { int _r = _t->getRobotState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 130: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 131: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 132: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 133: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 134: { int _r = _t->getLocalPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 135: { float _r = _t->getLocalPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 136: { float _r = _t->getLocalPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 137: _t->joyMoveXY((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 138: _t->joyMoveR((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 139: { int _r = _t->getCanvasSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 140: { int _r = _t->getRedoSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 141: { QVector<int> _r = _t->getLineX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 142: { QVector<int> _r = _t->getLineY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 143: { QString _r = _t->getLineColor((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 144: { float _r = _t->getLineWidth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 145: _t->startLine((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 146: _t->setLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 147: _t->stopLine(); break;
        case 148: _t->undo(); break;
        case 149: _t->redo(); break;
        case 150: _t->clear_all(); break;
        case 151: _t->startRecordPath(); break;
        case 152: _t->startcurPath(); break;
        case 153: _t->stopcurPath(); break;
        case 154: _t->pausecurPath(); break;
        case 155: _t->runRotateTables(); break;
        case 156: _t->stopRotateTables(); break;
        case 157: _t->saveAnnotation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 158: _t->saveMetaData((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 159: _t->sendMaptoServer(); break;
        case 160: _t->setGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 161: _t->editGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 162: { QString _r = _t->getGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 163: _t->make_minimap(); break;
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
        if (_id < 164)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 164;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 164)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 164;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
