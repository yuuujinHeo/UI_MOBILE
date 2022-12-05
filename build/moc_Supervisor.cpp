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
    QByteArrayData data[240];
    char stringdata0[3005];
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
QT_MOC_LITERAL(76, 891, 11), // "setVelocity"
QT_MOC_LITERAL(77, 903, 3), // "vel"
QT_MOC_LITERAL(78, 907, 13), // "getVelocityXY"
QT_MOC_LITERAL(79, 921, 16), // "getuseTravelline"
QT_MOC_LITERAL(80, 938, 16), // "setuseTravelline"
QT_MOC_LITERAL(81, 955, 16), // "getnumTravelline"
QT_MOC_LITERAL(82, 972, 16), // "setnumTravelline"
QT_MOC_LITERAL(83, 989, 3), // "num"
QT_MOC_LITERAL(84, 993, 10), // "getTrayNum"
QT_MOC_LITERAL(85, 1004, 10), // "setTrayNum"
QT_MOC_LITERAL(86, 1015, 11), // "getTableNum"
QT_MOC_LITERAL(87, 1027, 11), // "setTableNum"
QT_MOC_LITERAL(88, 1039, 11), // "getuseVoice"
QT_MOC_LITERAL(89, 1051, 11), // "setuseVoice"
QT_MOC_LITERAL(90, 1063, 9), // "getuseBGM"
QT_MOC_LITERAL(91, 1073, 9), // "setuseBGM"
QT_MOC_LITERAL(92, 1083, 12), // "getserverCMD"
QT_MOC_LITERAL(93, 1096, 12), // "setserverCMD"
QT_MOC_LITERAL(94, 1109, 12), // "getRobotType"
QT_MOC_LITERAL(95, 1122, 12), // "setRobotType"
QT_MOC_LITERAL(96, 1135, 4), // "type"
QT_MOC_LITERAL(97, 1140, 11), // "getMapExist"
QT_MOC_LITERAL(98, 1152, 11), // "getMapState"
QT_MOC_LITERAL(99, 1164, 10), // "getMapname"
QT_MOC_LITERAL(100, 1175, 10), // "getMappath"
QT_MOC_LITERAL(101, 1186, 11), // "getMapWidth"
QT_MOC_LITERAL(102, 1198, 12), // "getMapHeight"
QT_MOC_LITERAL(103, 1211, 12), // "getGridWidth"
QT_MOC_LITERAL(104, 1224, 9), // "getOrigin"
QT_MOC_LITERAL(105, 1234, 14), // "getLocationNum"
QT_MOC_LITERAL(106, 1249, 16), // "getLocationTypes"
QT_MOC_LITERAL(107, 1266, 12), // "getLocationx"
QT_MOC_LITERAL(108, 1279, 12), // "getLocationy"
QT_MOC_LITERAL(109, 1292, 13), // "getLocationth"
QT_MOC_LITERAL(110, 1306, 12), // "getObjectNum"
QT_MOC_LITERAL(111, 1319, 13), // "getObjectName"
QT_MOC_LITERAL(112, 1333, 18), // "getObjectPointSize"
QT_MOC_LITERAL(113, 1352, 10), // "getObjectX"
QT_MOC_LITERAL(114, 1363, 5), // "point"
QT_MOC_LITERAL(115, 1369, 10), // "getObjectY"
QT_MOC_LITERAL(116, 1380, 17), // "getTempObjectSize"
QT_MOC_LITERAL(117, 1398, 14), // "getTempObjectX"
QT_MOC_LITERAL(118, 1413, 14), // "getTempObjectY"
QT_MOC_LITERAL(119, 1428, 9), // "getObjNum"
QT_MOC_LITERAL(120, 1438, 14), // "getObjPointNum"
QT_MOC_LITERAL(121, 1453, 7), // "obj_num"
QT_MOC_LITERAL(122, 1461, 9), // "getLocNum"
QT_MOC_LITERAL(123, 1471, 14), // "getRobotRadius"
QT_MOC_LITERAL(124, 1486, 14), // "addObjectPoint"
QT_MOC_LITERAL(125, 1501, 15), // "editObjectPoint"
QT_MOC_LITERAL(126, 1517, 17), // "removeObjectPoint"
QT_MOC_LITERAL(127, 1535, 21), // "removeObjectPointLast"
QT_MOC_LITERAL(128, 1557, 17), // "clearObjectPoints"
QT_MOC_LITERAL(129, 1575, 9), // "addObject"
QT_MOC_LITERAL(130, 1585, 12), // "removeObject"
QT_MOC_LITERAL(131, 1598, 15), // "moveObjectPoint"
QT_MOC_LITERAL(132, 1614, 9), // "point_num"
QT_MOC_LITERAL(133, 1624, 14), // "removeLocation"
QT_MOC_LITERAL(134, 1639, 11), // "addLocation"
QT_MOC_LITERAL(135, 1651, 17), // "moveLocationPoint"
QT_MOC_LITERAL(136, 1669, 7), // "loc_num"
QT_MOC_LITERAL(137, 1677, 12), // "getTlineSize"
QT_MOC_LITERAL(138, 1690, 12), // "getTlineName"
QT_MOC_LITERAL(139, 1703, 9), // "getTlineX"
QT_MOC_LITERAL(140, 1713, 9), // "getTlineY"
QT_MOC_LITERAL(141, 1723, 8), // "addTline"
QT_MOC_LITERAL(142, 1732, 2), // "x1"
QT_MOC_LITERAL(143, 1735, 2), // "y1"
QT_MOC_LITERAL(144, 1738, 2), // "x2"
QT_MOC_LITERAL(145, 1741, 2), // "y2"
QT_MOC_LITERAL(146, 1744, 11), // "removeTline"
QT_MOC_LITERAL(147, 1756, 4), // "line"
QT_MOC_LITERAL(148, 1761, 11), // "getTlineNum"
QT_MOC_LITERAL(149, 1773, 12), // "setDebugName"
QT_MOC_LITERAL(150, 1786, 12), // "getDebugName"
QT_MOC_LITERAL(151, 1799, 13), // "getDebugState"
QT_MOC_LITERAL(152, 1813, 13), // "setDebugState"
QT_MOC_LITERAL(153, 1827, 7), // "isdebug"
QT_MOC_LITERAL(154, 1835, 9), // "getMargin"
QT_MOC_LITERAL(155, 1845, 9), // "getRobotx"
QT_MOC_LITERAL(156, 1855, 9), // "getRoboty"
QT_MOC_LITERAL(157, 1865, 10), // "getRobotth"
QT_MOC_LITERAL(158, 1876, 13), // "getRobotState"
QT_MOC_LITERAL(159, 1890, 10), // "getPathNum"
QT_MOC_LITERAL(160, 1901, 8), // "getPathx"
QT_MOC_LITERAL(161, 1910, 8), // "getPathy"
QT_MOC_LITERAL(162, 1919, 9), // "getPathth"
QT_MOC_LITERAL(163, 1929, 15), // "getLocalPathNum"
QT_MOC_LITERAL(164, 1945, 13), // "getLocalPathx"
QT_MOC_LITERAL(165, 1959, 13), // "getLocalPathy"
QT_MOC_LITERAL(166, 1973, 9), // "joyMoveXY"
QT_MOC_LITERAL(167, 1983, 8), // "joyMoveR"
QT_MOC_LITERAL(168, 1992, 1), // "r"
QT_MOC_LITERAL(169, 1994, 13), // "getCanvasSize"
QT_MOC_LITERAL(170, 2008, 11), // "getRedoSize"
QT_MOC_LITERAL(171, 2020, 8), // "getLineX"
QT_MOC_LITERAL(172, 2029, 5), // "index"
QT_MOC_LITERAL(173, 2035, 8), // "getLineY"
QT_MOC_LITERAL(174, 2044, 12), // "getLineColor"
QT_MOC_LITERAL(175, 2057, 12), // "getLineWidth"
QT_MOC_LITERAL(176, 2070, 9), // "startLine"
QT_MOC_LITERAL(177, 2080, 5), // "color"
QT_MOC_LITERAL(178, 2086, 5), // "width"
QT_MOC_LITERAL(179, 2092, 7), // "setLine"
QT_MOC_LITERAL(180, 2100, 8), // "stopLine"
QT_MOC_LITERAL(181, 2109, 4), // "undo"
QT_MOC_LITERAL(182, 2114, 4), // "redo"
QT_MOC_LITERAL(183, 2119, 9), // "clear_all"
QT_MOC_LITERAL(184, 2129, 15), // "startRecordPath"
QT_MOC_LITERAL(185, 2145, 12), // "startcurPath"
QT_MOC_LITERAL(186, 2158, 11), // "stopcurPath"
QT_MOC_LITERAL(187, 2170, 12), // "pausecurPath"
QT_MOC_LITERAL(188, 2183, 15), // "runRotateTables"
QT_MOC_LITERAL(189, 2199, 16), // "stopRotateTables"
QT_MOC_LITERAL(190, 2216, 14), // "saveAnnotation"
QT_MOC_LITERAL(191, 2231, 8), // "filename"
QT_MOC_LITERAL(192, 2240, 12), // "saveMetaData"
QT_MOC_LITERAL(193, 2253, 15), // "sendMaptoServer"
QT_MOC_LITERAL(194, 2269, 7), // "setGrid"
QT_MOC_LITERAL(195, 2277, 8), // "editGrid"
QT_MOC_LITERAL(196, 2286, 7), // "getGrid"
QT_MOC_LITERAL(197, 2294, 12), // "make_minimap"
QT_MOC_LITERAL(198, 2307, 8), // "TOOL_NUM"
QT_MOC_LITERAL(199, 2316, 10), // "TOOL_MOUSE"
QT_MOC_LITERAL(200, 2327, 10), // "TOOL_BRUSH"
QT_MOC_LITERAL(201, 2338, 11), // "TOOL_ERASER"
QT_MOC_LITERAL(202, 2350, 6), // "UI_CMD"
QT_MOC_LITERAL(203, 2357, 11), // "UI_CMD_NONE"
QT_MOC_LITERAL(204, 2369, 17), // "UI_CMD_MOVE_TABLE"
QT_MOC_LITERAL(205, 2387, 12), // "UI_CMD_PAUSE"
QT_MOC_LITERAL(206, 2400, 13), // "UI_CMD_RESUME"
QT_MOC_LITERAL(207, 2414, 16), // "UI_CMD_MOVE_WAIT"
QT_MOC_LITERAL(208, 2431, 18), // "UI_CMD_MOVE_CHARGE"
QT_MOC_LITERAL(209, 2450, 21), // "UI_CMD_PICKUP_CONFIRM"
QT_MOC_LITERAL(210, 2472, 19), // "UI_CMD_WAIT_KITCHEN"
QT_MOC_LITERAL(211, 2492, 19), // "UI_CMD_TABLE_PATROL"
QT_MOC_LITERAL(212, 2512, 18), // "UI_CMD_PATROL_STOP"
QT_MOC_LITERAL(213, 2531, 8), // "UI_STATE"
QT_MOC_LITERAL(214, 2540, 13), // "UI_STATE_NONE"
QT_MOC_LITERAL(215, 2554, 14), // "UI_STATE_READY"
QT_MOC_LITERAL(216, 2569, 17), // "UI_STATE_CHARGING"
QT_MOC_LITERAL(217, 2587, 16), // "UI_STATE_GO_HOME"
QT_MOC_LITERAL(218, 2604, 18), // "UI_STATE_GO_CHARGE"
QT_MOC_LITERAL(219, 2623, 16), // "UI_STATE_SERVING"
QT_MOC_LITERAL(220, 2640, 16), // "UI_STATE_CALLING"
QT_MOC_LITERAL(221, 2657, 15), // "UI_STATE_PICKUP"
QT_MOC_LITERAL(222, 2673, 19), // "UI_STATE_PATROLLING"
QT_MOC_LITERAL(223, 2693, 17), // "UI_STATE_MOVEFAIL"
QT_MOC_LITERAL(224, 2711, 11), // "ROBOT_STATE"
QT_MOC_LITERAL(225, 2723, 21), // "ROBOT_STATE_NOT_READY"
QT_MOC_LITERAL(226, 2745, 17), // "ROBOT_STATE_READY"
QT_MOC_LITERAL(227, 2763, 18), // "ROBOT_STATE_MOVING"
QT_MOC_LITERAL(228, 2782, 17), // "ROBOT_STATE_AVOID"
QT_MOC_LITERAL(229, 2800, 18), // "ROBOT_STATE_PAUSED"
QT_MOC_LITERAL(230, 2819, 17), // "ROBOT_STATE_ERROR"
QT_MOC_LITERAL(231, 2837, 22), // "ROBOT_STATE_MANUALMODE"
QT_MOC_LITERAL(232, 2860, 11), // "ROBOT_ERROR"
QT_MOC_LITERAL(233, 2872, 16), // "ROBOT_ERROR_NONE"
QT_MOC_LITERAL(234, 2889, 15), // "ROBOT_ERROR_COL"
QT_MOC_LITERAL(235, 2905, 19), // "ROBOT_ERROR_NO_PATH"
QT_MOC_LITERAL(236, 2925, 22), // "ROBOT_ERROR_MOTOR_COMM"
QT_MOC_LITERAL(237, 2948, 17), // "ROBOT_ERROR_MOTOR"
QT_MOC_LITERAL(238, 2966, 19), // "ROBOT_ERROR_VOLTAGE"
QT_MOC_LITERAL(239, 2986, 18) // "ROBOT_ERROR_SENSOR"

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
     169,   14, // methods
       0,    0, // properties
       5, 1244, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,  859,    2, 0x0a /* Public */,
       3,    0,  860,    2, 0x0a /* Public */,
       4,    0,  861,    2, 0x0a /* Public */,
       5,    0,  862,    2, 0x0a /* Public */,
       6,    0,  863,    2, 0x0a /* Public */,
       7,    0,  864,    2, 0x0a /* Public */,
       8,    0,  865,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
       9,    0,  866,    2, 0x02 /* Public */,
      10,    0,  867,    2, 0x02 /* Public */,
      11,    0,  868,    2, 0x02 /* Public */,
      12,    0,  869,    2, 0x02 /* Public */,
      13,    0,  870,    2, 0x02 /* Public */,
      14,    0,  871,    2, 0x02 /* Public */,
      15,    0,  872,    2, 0x02 /* Public */,
      16,    1,  873,    2, 0x02 /* Public */,
      18,    0,  876,    2, 0x02 /* Public */,
      19,    0,  877,    2, 0x02 /* Public */,
      20,    0,  878,    2, 0x02 /* Public */,
      21,    0,  879,    2, 0x02 /* Public */,
      22,    1,  880,    2, 0x02 /* Public */,
      24,    0,  883,    2, 0x02 /* Public */,
      25,    0,  884,    2, 0x02 /* Public */,
      26,    0,  885,    2, 0x02 /* Public */,
      27,    0,  886,    2, 0x02 /* Public */,
      28,    0,  887,    2, 0x02 /* Public */,
      29,    0,  888,    2, 0x02 /* Public */,
      30,    0,  889,    2, 0x02 /* Public */,
      31,    1,  890,    2, 0x02 /* Public */,
      33,    0,  893,    2, 0x02 /* Public */,
      34,    1,  894,    2, 0x02 /* Public */,
      35,    1,  897,    2, 0x02 /* Public */,
      36,    0,  900,    2, 0x02 /* Public */,
      37,    0,  901,    2, 0x02 /* Public */,
      38,    0,  902,    2, 0x02 /* Public */,
      39,    1,  903,    2, 0x02 /* Public */,
      41,    0,  906,    2, 0x02 /* Public */,
      43,    0,  907,    2, 0x02 /* Public */,
      44,    0,  908,    2, 0x02 /* Public */,
      45,    1,  909,    2, 0x02 /* Public */,
      47,    0,  912,    2, 0x02 /* Public */,
      48,    2,  913,    2, 0x02 /* Public */,
      51,    1,  918,    2, 0x02 /* Public */,
      51,    3,  921,    2, 0x02 /* Public */,
      56,    0,  928,    2, 0x02 /* Public */,
      57,    0,  929,    2, 0x02 /* Public */,
      58,    0,  930,    2, 0x02 /* Public */,
      59,    0,  931,    2, 0x02 /* Public */,
      60,    0,  932,    2, 0x02 /* Public */,
      61,    0,  933,    2, 0x02 /* Public */,
      62,    0,  934,    2, 0x02 /* Public */,
      63,    0,  935,    2, 0x02 /* Public */,
      64,    0,  936,    2, 0x02 /* Public */,
      65,    0,  937,    2, 0x02 /* Public */,
      66,    0,  938,    2, 0x02 /* Public */,
      67,    1,  939,    2, 0x02 /* Public */,
      69,    0,  942,    2, 0x02 /* Public */,
      70,    0,  943,    2, 0x02 /* Public */,
      71,    0,  944,    2, 0x02 /* Public */,
      72,    0,  945,    2, 0x02 /* Public */,
      74,    0,  946,    2, 0x02 /* Public */,
      75,    0,  947,    2, 0x02 /* Public */,
      76,    1,  948,    2, 0x02 /* Public */,
      78,    0,  951,    2, 0x02 /* Public */,
      79,    0,  952,    2, 0x02 /* Public */,
      80,    1,  953,    2, 0x02 /* Public */,
      81,    0,  956,    2, 0x02 /* Public */,
      82,    1,  957,    2, 0x02 /* Public */,
      84,    0,  960,    2, 0x02 /* Public */,
      85,    1,  961,    2, 0x02 /* Public */,
      86,    0,  964,    2, 0x02 /* Public */,
      87,    1,  965,    2, 0x02 /* Public */,
      88,    0,  968,    2, 0x02 /* Public */,
      89,    1,  969,    2, 0x02 /* Public */,
      90,    0,  972,    2, 0x02 /* Public */,
      91,    1,  973,    2, 0x02 /* Public */,
      92,    0,  976,    2, 0x02 /* Public */,
      93,    1,  977,    2, 0x02 /* Public */,
      94,    0,  980,    2, 0x02 /* Public */,
      95,    1,  981,    2, 0x02 /* Public */,
      97,    0,  984,    2, 0x02 /* Public */,
      98,    0,  985,    2, 0x02 /* Public */,
      99,    0,  986,    2, 0x02 /* Public */,
     100,    0,  987,    2, 0x02 /* Public */,
     101,    0,  988,    2, 0x02 /* Public */,
     102,    0,  989,    2, 0x02 /* Public */,
     103,    0,  990,    2, 0x02 /* Public */,
     104,    0,  991,    2, 0x02 /* Public */,
     105,    0,  992,    2, 0x02 /* Public */,
     106,    1,  993,    2, 0x02 /* Public */,
     107,    1,  996,    2, 0x02 /* Public */,
     108,    1,  999,    2, 0x02 /* Public */,
     109,    1, 1002,    2, 0x02 /* Public */,
     110,    0, 1005,    2, 0x02 /* Public */,
     111,    1, 1006,    2, 0x02 /* Public */,
     112,    1, 1009,    2, 0x02 /* Public */,
     113,    2, 1012,    2, 0x02 /* Public */,
     115,    2, 1017,    2, 0x02 /* Public */,
     116,    0, 1022,    2, 0x02 /* Public */,
     117,    1, 1023,    2, 0x02 /* Public */,
     118,    1, 1026,    2, 0x02 /* Public */,
     119,    1, 1029,    2, 0x02 /* Public */,
     119,    2, 1032,    2, 0x02 /* Public */,
     120,    3, 1037,    2, 0x02 /* Public */,
     122,    1, 1044,    2, 0x02 /* Public */,
     122,    2, 1047,    2, 0x02 /* Public */,
     123,    0, 1052,    2, 0x02 /* Public */,
     124,    2, 1053,    2, 0x02 /* Public */,
     125,    3, 1058,    2, 0x02 /* Public */,
     126,    1, 1065,    2, 0x02 /* Public */,
     127,    0, 1068,    2, 0x02 /* Public */,
     128,    0, 1069,    2, 0x02 /* Public */,
     129,    1, 1070,    2, 0x02 /* Public */,
     130,    1, 1073,    2, 0x02 /* Public */,
     131,    4, 1076,    2, 0x02 /* Public */,
     133,    1, 1085,    2, 0x02 /* Public */,
     134,    4, 1088,    2, 0x02 /* Public */,
     135,    4, 1097,    2, 0x02 /* Public */,
     137,    0, 1106,    2, 0x02 /* Public */,
     137,    1, 1107,    2, 0x02 /* Public */,
     138,    1, 1110,    2, 0x02 /* Public */,
     139,    2, 1113,    2, 0x02 /* Public */,
     140,    2, 1118,    2, 0x02 /* Public */,
     141,    5, 1123,    2, 0x02 /* Public */,
     146,    2, 1134,    2, 0x02 /* Public */,
     148,    1, 1139,    2, 0x02 /* Public */,
     148,    2, 1142,    2, 0x02 /* Public */,
     149,    1, 1147,    2, 0x02 /* Public */,
     150,    0, 1150,    2, 0x02 /* Public */,
     151,    0, 1151,    2, 0x02 /* Public */,
     152,    1, 1152,    2, 0x02 /* Public */,
     154,    0, 1155,    2, 0x02 /* Public */,
     155,    0, 1156,    2, 0x02 /* Public */,
     156,    0, 1157,    2, 0x02 /* Public */,
     157,    0, 1158,    2, 0x02 /* Public */,
     158,    0, 1159,    2, 0x02 /* Public */,
     159,    0, 1160,    2, 0x02 /* Public */,
     160,    1, 1161,    2, 0x02 /* Public */,
     161,    1, 1164,    2, 0x02 /* Public */,
     162,    1, 1167,    2, 0x02 /* Public */,
     163,    0, 1170,    2, 0x02 /* Public */,
     164,    1, 1171,    2, 0x02 /* Public */,
     165,    1, 1174,    2, 0x02 /* Public */,
     166,    1, 1177,    2, 0x02 /* Public */,
     167,    1, 1180,    2, 0x02 /* Public */,
     169,    0, 1183,    2, 0x02 /* Public */,
     170,    0, 1184,    2, 0x02 /* Public */,
     171,    1, 1185,    2, 0x02 /* Public */,
     173,    1, 1188,    2, 0x02 /* Public */,
     174,    1, 1191,    2, 0x02 /* Public */,
     175,    1, 1194,    2, 0x02 /* Public */,
     176,    2, 1197,    2, 0x02 /* Public */,
     179,    2, 1202,    2, 0x02 /* Public */,
     180,    0, 1207,    2, 0x02 /* Public */,
     181,    0, 1208,    2, 0x02 /* Public */,
     182,    0, 1209,    2, 0x02 /* Public */,
     183,    0, 1210,    2, 0x02 /* Public */,
     184,    0, 1211,    2, 0x02 /* Public */,
     185,    0, 1212,    2, 0x02 /* Public */,
     186,    0, 1213,    2, 0x02 /* Public */,
     187,    0, 1214,    2, 0x02 /* Public */,
     188,    0, 1215,    2, 0x02 /* Public */,
     189,    0, 1216,    2, 0x02 /* Public */,
     190,    1, 1217,    2, 0x02 /* Public */,
     192,    1, 1220,    2, 0x02 /* Public */,
     193,    0, 1223,    2, 0x02 /* Public */,
     194,    3, 1224,    2, 0x02 /* Public */,
     195,    3, 1231,    2, 0x02 /* Public */,
     196,    2, 1238,    2, 0x02 /* Public */,
     197,    0, 1243,    2, 0x02 /* Public */,

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
    QMetaType::Void, QMetaType::Float,   77,
    QMetaType::Float,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   17,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   83,
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
    QMetaType::Void, QMetaType::Int,   96,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float,
    0x80000000 | 42,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   83,
    QMetaType::Float, QMetaType::Int,   83,
    QMetaType::Float, QMetaType::Int,   83,
    QMetaType::Float, QMetaType::Int,   83,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   83,
    QMetaType::Int, QMetaType::Int,   83,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   83,  114,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   83,  114,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   83,
    QMetaType::Float, QMetaType::Int,   83,
    QMetaType::Int, QMetaType::QString,   68,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   53,   54,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  121,   53,   54,
    QMetaType::Int, QMetaType::QString,   68,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   53,   54,
    QMetaType::Float,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   53,   54,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int,   83,   53,   54,
    QMetaType::Void, QMetaType::Int,   83,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   68,
    QMetaType::Void, QMetaType::QString,   68,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  121,  132,   53,   54,
    QMetaType::Void, QMetaType::QString,   68,
    QMetaType::Void, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::Float,   68,   53,   54,   55,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Float,  136,   53,   54,   55,
    QMetaType::Int,
    QMetaType::Int, QMetaType::Int,   83,
    QMetaType::QString, QMetaType::Int,   83,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   83,  114,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   83,  114,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   83,  142,  143,  144,  145,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   83,  147,
    QMetaType::Int, QMetaType::QString,   68,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   53,   54,
    QMetaType::Void, QMetaType::QString,   68,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  153,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   83,
    QMetaType::Float, QMetaType::Int,   83,
    QMetaType::Float, QMetaType::Int,   83,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   83,
    QMetaType::Float, QMetaType::Int,   83,
    QMetaType::Void, QMetaType::Float,   53,
    QMetaType::Void, QMetaType::Float,  168,
    QMetaType::Int,
    QMetaType::Int,
    0x80000000 | 42, QMetaType::Int,  172,
    0x80000000 | 42, QMetaType::Int,  172,
    QMetaType::QString, QMetaType::Int,  172,
    QMetaType::Float, QMetaType::Int,  172,
    QMetaType::Void, QMetaType::QString, QMetaType::Float,  177,  178,
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
    QMetaType::Void, QMetaType::QString,  191,
    QMetaType::Void, QMetaType::QString,  191,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QString,   53,   54,   68,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QString,   53,   54,   68,
    QMetaType::QString, QMetaType::Int, QMetaType::Int,   53,   54,
    QMetaType::Void,

 // enums: name, alias, flags, count, data
     198,  198, 0x0,    3, 1269,
     202,  202, 0x0,   10, 1275,
     213,  213, 0x0,   10, 1295,
     224,  224, 0x0,    7, 1315,
     232,  232, 0x0,    7, 1329,

 // enum data: key, value
     199, uint(Supervisor::TOOL_MOUSE),
     200, uint(Supervisor::TOOL_BRUSH),
     201, uint(Supervisor::TOOL_ERASER),
     203, uint(Supervisor::UI_CMD_NONE),
     204, uint(Supervisor::UI_CMD_MOVE_TABLE),
     205, uint(Supervisor::UI_CMD_PAUSE),
     206, uint(Supervisor::UI_CMD_RESUME),
     207, uint(Supervisor::UI_CMD_MOVE_WAIT),
     208, uint(Supervisor::UI_CMD_MOVE_CHARGE),
     209, uint(Supervisor::UI_CMD_PICKUP_CONFIRM),
     210, uint(Supervisor::UI_CMD_WAIT_KITCHEN),
     211, uint(Supervisor::UI_CMD_TABLE_PATROL),
     212, uint(Supervisor::UI_CMD_PATROL_STOP),
     214, uint(Supervisor::UI_STATE_NONE),
     215, uint(Supervisor::UI_STATE_READY),
     216, uint(Supervisor::UI_STATE_CHARGING),
     217, uint(Supervisor::UI_STATE_GO_HOME),
     218, uint(Supervisor::UI_STATE_GO_CHARGE),
     219, uint(Supervisor::UI_STATE_SERVING),
     220, uint(Supervisor::UI_STATE_CALLING),
     221, uint(Supervisor::UI_STATE_PICKUP),
     222, uint(Supervisor::UI_STATE_PATROLLING),
     223, uint(Supervisor::UI_STATE_MOVEFAIL),
     225, uint(Supervisor::ROBOT_STATE_NOT_READY),
     226, uint(Supervisor::ROBOT_STATE_READY),
     227, uint(Supervisor::ROBOT_STATE_MOVING),
     228, uint(Supervisor::ROBOT_STATE_AVOID),
     229, uint(Supervisor::ROBOT_STATE_PAUSED),
     230, uint(Supervisor::ROBOT_STATE_ERROR),
     231, uint(Supervisor::ROBOT_STATE_MANUALMODE),
     233, uint(Supervisor::ROBOT_ERROR_NONE),
     234, uint(Supervisor::ROBOT_ERROR_COL),
     235, uint(Supervisor::ROBOT_ERROR_NO_PATH),
     236, uint(Supervisor::ROBOT_ERROR_MOTOR_COMM),
     237, uint(Supervisor::ROBOT_ERROR_MOTOR),
     238, uint(Supervisor::ROBOT_ERROR_VOLTAGE),
     239, uint(Supervisor::ROBOT_ERROR_SENSOR),

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
        case 61: _t->setVelocity((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 62: { float _r = _t->getVelocityXY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 63: { bool _r = _t->getuseTravelline();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 64: _t->setuseTravelline((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 65: { int _r = _t->getnumTravelline();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 66: _t->setnumTravelline((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 67: { int _r = _t->getTrayNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 68: _t->setTrayNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 69: { int _r = _t->getTableNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 70: _t->setTableNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 71: { bool _r = _t->getuseVoice();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 72: _t->setuseVoice((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 73: { bool _r = _t->getuseBGM();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 74: _t->setuseBGM((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 75: { bool _r = _t->getserverCMD();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 76: _t->setserverCMD((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 77: { QString _r = _t->getRobotType();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 78: _t->setRobotType((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 79: { bool _r = _t->getMapExist();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 80: { bool _r = _t->getMapState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 81: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 82: { QString _r = _t->getMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 83: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 84: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 85: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 86: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 87: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 88: { QString _r = _t->getLocationTypes((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 89: { float _r = _t->getLocationx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 90: { float _r = _t->getLocationy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 91: { float _r = _t->getLocationth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 92: { int _r = _t->getObjectNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 93: { QString _r = _t->getObjectName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 94: { int _r = _t->getObjectPointSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 95: { float _r = _t->getObjectX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 96: { float _r = _t->getObjectY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 97: { int _r = _t->getTempObjectSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 98: { float _r = _t->getTempObjectX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 99: { float _r = _t->getTempObjectY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 100: { int _r = _t->getObjNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 101: { int _r = _t->getObjNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 102: { int _r = _t->getObjPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 103: { int _r = _t->getLocNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 104: { int _r = _t->getLocNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 105: { float _r = _t->getRobotRadius();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 106: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 107: _t->editObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 108: _t->removeObjectPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 109: _t->removeObjectPointLast(); break;
        case 110: _t->clearObjectPoints(); break;
        case 111: _t->addObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 112: _t->removeObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 113: _t->moveObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4]))); break;
        case 114: _t->removeLocation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 115: _t->addLocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 116: _t->moveLocationPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 117: { int _r = _t->getTlineSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 118: { int _r = _t->getTlineSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 119: { QString _r = _t->getTlineName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 120: { float _r = _t->getTlineX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 121: { float _r = _t->getTlineY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 122: _t->addTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< int(*)>(_a[5]))); break;
        case 123: _t->removeTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 124: { int _r = _t->getTlineNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 125: { int _r = _t->getTlineNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 126: _t->setDebugName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 127: { QString _r = _t->getDebugName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 128: { bool _r = _t->getDebugState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 129: _t->setDebugState((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 130: { float _r = _t->getMargin();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 131: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 132: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 133: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 134: { int _r = _t->getRobotState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 135: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 136: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 137: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 138: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 139: { int _r = _t->getLocalPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 140: { float _r = _t->getLocalPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 141: { float _r = _t->getLocalPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 142: _t->joyMoveXY((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 143: _t->joyMoveR((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 144: { int _r = _t->getCanvasSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 145: { int _r = _t->getRedoSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 146: { QVector<int> _r = _t->getLineX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 147: { QVector<int> _r = _t->getLineY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 148: { QString _r = _t->getLineColor((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 149: { float _r = _t->getLineWidth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 150: _t->startLine((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 151: _t->setLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 152: _t->stopLine(); break;
        case 153: _t->undo(); break;
        case 154: _t->redo(); break;
        case 155: _t->clear_all(); break;
        case 156: _t->startRecordPath(); break;
        case 157: _t->startcurPath(); break;
        case 158: _t->stopcurPath(); break;
        case 159: _t->pausecurPath(); break;
        case 160: _t->runRotateTables(); break;
        case 161: _t->stopRotateTables(); break;
        case 162: _t->saveAnnotation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 163: _t->saveMetaData((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 164: _t->sendMaptoServer(); break;
        case 165: _t->setGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 166: _t->editGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 167: { QString _r = _t->getGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 168: _t->make_minimap(); break;
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
        if (_id < 169)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 169;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 169)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 169;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
