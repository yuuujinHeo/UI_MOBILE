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
#include <QtCore/QList>
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
    QByteArrayData data[283];
    char stringdata0[3323];
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
QT_MOC_LITERAL(8, 113, 14), // "server_get_map"
QT_MOC_LITERAL(9, 128, 12), // "path_changed"
QT_MOC_LITERAL(10, 141, 13), // "camera_update"
QT_MOC_LITERAL(11, 155, 10), // "usb_detect"
QT_MOC_LITERAL(12, 166, 16), // "git_pull_success"
QT_MOC_LITERAL(13, 183, 11), // "programExit"
QT_MOC_LITERAL(14, 195, 11), // "programHide"
QT_MOC_LITERAL(15, 207, 8), // "writelog"
QT_MOC_LITERAL(16, 216, 3), // "msg"
QT_MOC_LITERAL(17, 220, 13), // "getRawMapPath"
QT_MOC_LITERAL(18, 234, 4), // "name"
QT_MOC_LITERAL(19, 239, 10), // "getMapPath"
QT_MOC_LITERAL(20, 250, 12), // "getAnnotPath"
QT_MOC_LITERAL(21, 263, 11), // "getMetaPath"
QT_MOC_LITERAL(22, 275, 10), // "getIniPath"
QT_MOC_LITERAL(23, 286, 10), // "setSetting"
QT_MOC_LITERAL(24, 297, 5), // "value"
QT_MOC_LITERAL(25, 303, 11), // "readSetting"
QT_MOC_LITERAL(26, 315, 8), // "map_name"
QT_MOC_LITERAL(27, 324, 10), // "getSetting"
QT_MOC_LITERAL(28, 335, 5), // "group"
QT_MOC_LITERAL(29, 341, 11), // "setVelocity"
QT_MOC_LITERAL(30, 353, 3), // "vel"
QT_MOC_LITERAL(31, 357, 11), // "getVelocity"
QT_MOC_LITERAL(32, 369, 16), // "getuseTravelline"
QT_MOC_LITERAL(33, 386, 16), // "setuseTravelline"
QT_MOC_LITERAL(34, 403, 3), // "use"
QT_MOC_LITERAL(35, 407, 16), // "getnumTravelline"
QT_MOC_LITERAL(36, 424, 16), // "setnumTravelline"
QT_MOC_LITERAL(37, 441, 3), // "num"
QT_MOC_LITERAL(38, 445, 10), // "getTrayNum"
QT_MOC_LITERAL(39, 456, 10), // "setTrayNum"
QT_MOC_LITERAL(40, 467, 8), // "tray_num"
QT_MOC_LITERAL(41, 476, 11), // "getTableNum"
QT_MOC_LITERAL(42, 488, 11), // "setTableNum"
QT_MOC_LITERAL(43, 500, 9), // "table_num"
QT_MOC_LITERAL(44, 510, 14), // "getTableColNum"
QT_MOC_LITERAL(45, 525, 14), // "setTableColNum"
QT_MOC_LITERAL(46, 540, 7), // "col_num"
QT_MOC_LITERAL(47, 548, 11), // "getuseVoice"
QT_MOC_LITERAL(48, 560, 11), // "setuseVoice"
QT_MOC_LITERAL(49, 572, 9), // "getuseBGM"
QT_MOC_LITERAL(50, 582, 9), // "setuseBGM"
QT_MOC_LITERAL(51, 592, 12), // "getserverCMD"
QT_MOC_LITERAL(52, 605, 12), // "setserverCMD"
QT_MOC_LITERAL(53, 618, 12), // "getRobotType"
QT_MOC_LITERAL(54, 631, 12), // "setRobotType"
QT_MOC_LITERAL(55, 644, 4), // "type"
QT_MOC_LITERAL(56, 649, 12), // "setDebugName"
QT_MOC_LITERAL(57, 662, 12), // "getDebugName"
QT_MOC_LITERAL(58, 675, 13), // "getDebugState"
QT_MOC_LITERAL(59, 689, 13), // "setDebugState"
QT_MOC_LITERAL(60, 703, 7), // "isdebug"
QT_MOC_LITERAL(61, 711, 13), // "requestCamera"
QT_MOC_LITERAL(62, 725, 13), // "getLeftCamera"
QT_MOC_LITERAL(63, 739, 14), // "getRightCamera"
QT_MOC_LITERAL(64, 754, 9), // "setCamera"
QT_MOC_LITERAL(65, 764, 4), // "left"
QT_MOC_LITERAL(66, 769, 5), // "right"
QT_MOC_LITERAL(67, 775, 12), // "getCameraNum"
QT_MOC_LITERAL(68, 788, 9), // "getCamera"
QT_MOC_LITERAL(69, 798, 10), // "QList<int>"
QT_MOC_LITERAL(70, 809, 15), // "getCameraSerial"
QT_MOC_LITERAL(71, 825, 7), // "pullGit"
QT_MOC_LITERAL(72, 833, 12), // "isNewVersion"
QT_MOC_LITERAL(73, 846, 15), // "getLocalVersion"
QT_MOC_LITERAL(74, 862, 16), // "getServerVersion"
QT_MOC_LITERAL(75, 879, 15), // "isConnectServer"
QT_MOC_LITERAL(76, 895, 10), // "isExistMap"
QT_MOC_LITERAL(77, 906, 13), // "isExistRawMap"
QT_MOC_LITERAL(78, 920, 15), // "getAvailableMap"
QT_MOC_LITERAL(79, 936, 19), // "getAvailableMapPath"
QT_MOC_LITERAL(80, 956, 14), // "getMapFileSize"
QT_MOC_LITERAL(81, 971, 10), // "getMapFile"
QT_MOC_LITERAL(82, 982, 17), // "isExistAnnotation"
QT_MOC_LITERAL(83, 1000, 16), // "deleteAnnotation"
QT_MOC_LITERAL(84, 1017, 15), // "loadMaptoServer"
QT_MOC_LITERAL(85, 1033, 9), // "isUSBFile"
QT_MOC_LITERAL(86, 1043, 14), // "getUSBFilename"
QT_MOC_LITERAL(87, 1058, 12), // "loadMaptoUSB"
QT_MOC_LITERAL(88, 1071, 14), // "isuseServerMap"
QT_MOC_LITERAL(89, 1086, 15), // "setuseServerMap"
QT_MOC_LITERAL(90, 1102, 9), // "removeMap"
QT_MOC_LITERAL(91, 1112, 8), // "filename"
QT_MOC_LITERAL(92, 1121, 9), // "isloadMap"
QT_MOC_LITERAL(93, 1131, 10), // "setloadMap"
QT_MOC_LITERAL(94, 1142, 4), // "load"
QT_MOC_LITERAL(95, 1147, 15), // "isExistRobotINI"
QT_MOC_LITERAL(96, 1163, 12), // "makeRobotINI"
QT_MOC_LITERAL(97, 1176, 10), // "rotate_map"
QT_MOC_LITERAL(98, 1187, 4), // "_src"
QT_MOC_LITERAL(99, 1192, 4), // "_dst"
QT_MOC_LITERAL(100, 1197, 4), // "mode"
QT_MOC_LITERAL(101, 1202, 16), // "getLCMConnection"
QT_MOC_LITERAL(102, 1219, 8), // "getLCMRX"
QT_MOC_LITERAL(103, 1228, 8), // "getLCMTX"
QT_MOC_LITERAL(104, 1237, 13), // "getLCMProcess"
QT_MOC_LITERAL(105, 1251, 10), // "getIniRead"
QT_MOC_LITERAL(106, 1262, 13), // "getUsbMapSize"
QT_MOC_LITERAL(107, 1276, 13), // "getUsbMapPath"
QT_MOC_LITERAL(108, 1290, 17), // "getUsbMapPathFull"
QT_MOC_LITERAL(109, 1308, 14), // "saveMapfromUsb"
QT_MOC_LITERAL(110, 1323, 4), // "path"
QT_MOC_LITERAL(111, 1328, 6), // "setMap"
QT_MOC_LITERAL(112, 1335, 12), // "startMapping"
QT_MOC_LITERAL(113, 1348, 11), // "stopMapping"
QT_MOC_LITERAL(114, 1360, 11), // "setSLAMMode"
QT_MOC_LITERAL(115, 1372, 10), // "setInitPos"
QT_MOC_LITERAL(116, 1383, 1), // "x"
QT_MOC_LITERAL(117, 1385, 1), // "y"
QT_MOC_LITERAL(118, 1387, 2), // "th"
QT_MOC_LITERAL(119, 1390, 12), // "getInitPoseX"
QT_MOC_LITERAL(120, 1403, 12), // "getInitPoseY"
QT_MOC_LITERAL(121, 1416, 13), // "getInitPoseTH"
QT_MOC_LITERAL(122, 1430, 12), // "slam_setInit"
QT_MOC_LITERAL(123, 1443, 8), // "slam_run"
QT_MOC_LITERAL(124, 1452, 9), // "slam_stop"
QT_MOC_LITERAL(125, 1462, 13), // "slam_autoInit"
QT_MOC_LITERAL(126, 1476, 15), // "is_slam_running"
QT_MOC_LITERAL(127, 1492, 14), // "getMappingflag"
QT_MOC_LITERAL(128, 1507, 14), // "setMappingflag"
QT_MOC_LITERAL(129, 1522, 4), // "flag"
QT_MOC_LITERAL(130, 1527, 6), // "getMap"
QT_MOC_LITERAL(131, 1534, 9), // "getRawMap"
QT_MOC_LITERAL(132, 1544, 10), // "getMiniMap"
QT_MOC_LITERAL(133, 1555, 10), // "getMapping"
QT_MOC_LITERAL(134, 1566, 11), // "pushMapData"
QT_MOC_LITERAL(135, 1578, 4), // "data"
QT_MOC_LITERAL(136, 1583, 12), // "isconnectJoy"
QT_MOC_LITERAL(137, 1596, 10), // "getJoyAxis"
QT_MOC_LITERAL(138, 1607, 12), // "getJoyButton"
QT_MOC_LITERAL(139, 1620, 11), // "getKeyboard"
QT_MOC_LITERAL(140, 1632, 11), // "getJoystick"
QT_MOC_LITERAL(141, 1644, 13), // "getCanvasSize"
QT_MOC_LITERAL(142, 1658, 11), // "getRedoSize"
QT_MOC_LITERAL(143, 1670, 8), // "getLineX"
QT_MOC_LITERAL(144, 1679, 12), // "QVector<int>"
QT_MOC_LITERAL(145, 1692, 5), // "index"
QT_MOC_LITERAL(146, 1698, 8), // "getLineY"
QT_MOC_LITERAL(147, 1707, 12), // "getLineColor"
QT_MOC_LITERAL(148, 1720, 12), // "getLineWidth"
QT_MOC_LITERAL(149, 1733, 9), // "startLine"
QT_MOC_LITERAL(150, 1743, 5), // "color"
QT_MOC_LITERAL(151, 1749, 5), // "width"
QT_MOC_LITERAL(152, 1755, 7), // "setLine"
QT_MOC_LITERAL(153, 1763, 8), // "stopLine"
QT_MOC_LITERAL(154, 1772, 4), // "undo"
QT_MOC_LITERAL(155, 1777, 4), // "redo"
QT_MOC_LITERAL(156, 1782, 9), // "clear_all"
QT_MOC_LITERAL(157, 1792, 10), // "setObjPose"
QT_MOC_LITERAL(158, 1803, 12), // "setMarginObj"
QT_MOC_LITERAL(159, 1816, 14), // "clearMarginObj"
QT_MOC_LITERAL(160, 1831, 14), // "setMarginPoint"
QT_MOC_LITERAL(161, 1846, 9), // "pixel_num"
QT_MOC_LITERAL(162, 1856, 12), // "getMarginObj"
QT_MOC_LITERAL(163, 1869, 9), // "getMargin"
QT_MOC_LITERAL(164, 1879, 14), // "getLocationNum"
QT_MOC_LITERAL(165, 1894, 15), // "getLocationSize"
QT_MOC_LITERAL(166, 1910, 15), // "getLocationName"
QT_MOC_LITERAL(167, 1926, 16), // "getLocationTypes"
QT_MOC_LITERAL(168, 1943, 12), // "getLocationx"
QT_MOC_LITERAL(169, 1956, 12), // "getLocationy"
QT_MOC_LITERAL(170, 1969, 13), // "getLocationth"
QT_MOC_LITERAL(171, 1983, 8), // "getLidar"
QT_MOC_LITERAL(172, 1992, 12), // "getObjectNum"
QT_MOC_LITERAL(173, 2005, 13), // "getObjectName"
QT_MOC_LITERAL(174, 2019, 18), // "getObjectPointSize"
QT_MOC_LITERAL(175, 2038, 10), // "getObjectX"
QT_MOC_LITERAL(176, 2049, 5), // "point"
QT_MOC_LITERAL(177, 2055, 10), // "getObjectY"
QT_MOC_LITERAL(178, 2066, 17), // "getTempObjectSize"
QT_MOC_LITERAL(179, 2084, 14), // "getTempObjectX"
QT_MOC_LITERAL(180, 2099, 14), // "getTempObjectY"
QT_MOC_LITERAL(181, 2114, 9), // "getObjNum"
QT_MOC_LITERAL(182, 2124, 14), // "getObjPointNum"
QT_MOC_LITERAL(183, 2139, 7), // "obj_num"
QT_MOC_LITERAL(184, 2147, 9), // "getLocNum"
QT_MOC_LITERAL(185, 2157, 14), // "addObjectPoint"
QT_MOC_LITERAL(186, 2172, 17), // "removeObjectPoint"
QT_MOC_LITERAL(187, 2190, 21), // "removeObjectPointLast"
QT_MOC_LITERAL(188, 2212, 17), // "clearObjectPoints"
QT_MOC_LITERAL(189, 2230, 13), // "getObjectSize"
QT_MOC_LITERAL(190, 2244, 9), // "addObject"
QT_MOC_LITERAL(191, 2254, 13), // "addObjectRect"
QT_MOC_LITERAL(192, 2268, 10), // "editObject"
QT_MOC_LITERAL(193, 2279, 12), // "removeObject"
QT_MOC_LITERAL(194, 2292, 14), // "removeLocation"
QT_MOC_LITERAL(195, 2307, 11), // "addLocation"
QT_MOC_LITERAL(196, 2319, 17), // "moveLocationPoint"
QT_MOC_LITERAL(197, 2337, 7), // "loc_num"
QT_MOC_LITERAL(198, 2345, 12), // "getTlineSize"
QT_MOC_LITERAL(199, 2358, 12), // "getTlineName"
QT_MOC_LITERAL(200, 2371, 9), // "getTlineX"
QT_MOC_LITERAL(201, 2381, 9), // "getTlineY"
QT_MOC_LITERAL(202, 2391, 8), // "addTline"
QT_MOC_LITERAL(203, 2400, 2), // "x1"
QT_MOC_LITERAL(204, 2403, 2), // "y1"
QT_MOC_LITERAL(205, 2406, 2), // "x2"
QT_MOC_LITERAL(206, 2409, 2), // "y2"
QT_MOC_LITERAL(207, 2412, 11), // "removeTline"
QT_MOC_LITERAL(208, 2424, 4), // "line"
QT_MOC_LITERAL(209, 2429, 11), // "getTlineNum"
QT_MOC_LITERAL(210, 2441, 14), // "saveAnnotation"
QT_MOC_LITERAL(211, 2456, 12), // "saveMetaData"
QT_MOC_LITERAL(212, 2469, 15), // "sendMaptoServer"
QT_MOC_LITERAL(213, 2485, 10), // "acceptCall"
QT_MOC_LITERAL(214, 2496, 3), // "yes"
QT_MOC_LITERAL(215, 2500, 7), // "setTray"
QT_MOC_LITERAL(216, 2508, 13), // "confirmPickup"
QT_MOC_LITERAL(217, 2522, 14), // "getPickuptrays"
QT_MOC_LITERAL(218, 2537, 6), // "moveTo"
QT_MOC_LITERAL(219, 2544, 10), // "target_num"
QT_MOC_LITERAL(220, 2555, 9), // "movePause"
QT_MOC_LITERAL(221, 2565, 10), // "moveResume"
QT_MOC_LITERAL(222, 2576, 8), // "moveStop"
QT_MOC_LITERAL(223, 2585, 10), // "moveManual"
QT_MOC_LITERAL(224, 2596, 12), // "moveToCharge"
QT_MOC_LITERAL(225, 2609, 10), // "moveToWait"
QT_MOC_LITERAL(226, 2620, 9), // "getcurLoc"
QT_MOC_LITERAL(227, 2630, 11), // "getcurTable"
QT_MOC_LITERAL(228, 2642, 12), // "getcurTarget"
QT_MOC_LITERAL(229, 2655, 14), // "QVector<float>"
QT_MOC_LITERAL(230, 2670, 9), // "joyMoveXY"
QT_MOC_LITERAL(231, 2680, 8), // "joyMoveR"
QT_MOC_LITERAL(232, 2689, 1), // "r"
QT_MOC_LITERAL(233, 2691, 8), // "getJoyXY"
QT_MOC_LITERAL(234, 2700, 7), // "getJoyR"
QT_MOC_LITERAL(235, 2708, 10), // "getBattery"
QT_MOC_LITERAL(236, 2719, 8), // "getState"
QT_MOC_LITERAL(237, 2728, 10), // "getErrcode"
QT_MOC_LITERAL(238, 2739, 12), // "getRobotName"
QT_MOC_LITERAL(239, 2752, 14), // "getRobotRadius"
QT_MOC_LITERAL(240, 2767, 9), // "getRobotx"
QT_MOC_LITERAL(241, 2777, 9), // "getRoboty"
QT_MOC_LITERAL(242, 2787, 10), // "getRobotth"
QT_MOC_LITERAL(243, 2798, 13), // "getRobotState"
QT_MOC_LITERAL(244, 2812, 10), // "getPathNum"
QT_MOC_LITERAL(245, 2823, 8), // "getPathx"
QT_MOC_LITERAL(246, 2832, 8), // "getPathy"
QT_MOC_LITERAL(247, 2841, 9), // "getPathth"
QT_MOC_LITERAL(248, 2851, 15), // "getLocalPathNum"
QT_MOC_LITERAL(249, 2867, 13), // "getLocalPathx"
QT_MOC_LITERAL(250, 2881, 13), // "getLocalPathy"
QT_MOC_LITERAL(251, 2895, 10), // "getuistate"
QT_MOC_LITERAL(252, 2906, 10), // "getMapname"
QT_MOC_LITERAL(253, 2917, 10), // "getMappath"
QT_MOC_LITERAL(254, 2928, 16), // "getServerMapname"
QT_MOC_LITERAL(255, 2945, 16), // "getServerMappath"
QT_MOC_LITERAL(256, 2962, 11), // "getMapWidth"
QT_MOC_LITERAL(257, 2974, 12), // "getMapHeight"
QT_MOC_LITERAL(258, 2987, 12), // "getGridWidth"
QT_MOC_LITERAL(259, 3000, 9), // "getOrigin"
QT_MOC_LITERAL(260, 3010, 17), // "getPatrolFileName"
QT_MOC_LITERAL(261, 3028, 10), // "makePatrol"
QT_MOC_LITERAL(262, 3039, 14), // "loadPatrolFile"
QT_MOC_LITERAL(263, 3054, 14), // "savePatrolFile"
QT_MOC_LITERAL(264, 3069, 9), // "addPatrol"
QT_MOC_LITERAL(265, 3079, 8), // "location"
QT_MOC_LITERAL(266, 3088, 12), // "getPatrolNum"
QT_MOC_LITERAL(267, 3101, 13), // "getPatrolType"
QT_MOC_LITERAL(268, 3115, 17), // "getPatrolLocation"
QT_MOC_LITERAL(269, 3133, 10), // "getPatrolX"
QT_MOC_LITERAL(270, 3144, 10), // "getPatrolY"
QT_MOC_LITERAL(271, 3155, 11), // "getPatrolTH"
QT_MOC_LITERAL(272, 3167, 12), // "removePatrol"
QT_MOC_LITERAL(273, 3180, 12), // "movePatrolUp"
QT_MOC_LITERAL(274, 3193, 14), // "movePatrolDown"
QT_MOC_LITERAL(275, 3208, 13), // "getPatrolMode"
QT_MOC_LITERAL(276, 3222, 13), // "setPatrolMode"
QT_MOC_LITERAL(277, 3236, 15), // "startRecordPath"
QT_MOC_LITERAL(278, 3252, 12), // "startcurPath"
QT_MOC_LITERAL(279, 3265, 11), // "stopcurPath"
QT_MOC_LITERAL(280, 3277, 12), // "pausecurPath"
QT_MOC_LITERAL(281, 3290, 15), // "runRotateTables"
QT_MOC_LITERAL(282, 3306, 16) // "stopRotateTables"

    },
    "Supervisor\0onTimer\0\0server_cmd_pause\0"
    "server_cmd_resume\0server_cmd_newtarget\0"
    "server_cmd_newcall\0server_cmd_setini\0"
    "server_get_map\0path_changed\0camera_update\0"
    "usb_detect\0git_pull_success\0programExit\0"
    "programHide\0writelog\0msg\0getRawMapPath\0"
    "name\0getMapPath\0getAnnotPath\0getMetaPath\0"
    "getIniPath\0setSetting\0value\0readSetting\0"
    "map_name\0getSetting\0group\0setVelocity\0"
    "vel\0getVelocity\0getuseTravelline\0"
    "setuseTravelline\0use\0getnumTravelline\0"
    "setnumTravelline\0num\0getTrayNum\0"
    "setTrayNum\0tray_num\0getTableNum\0"
    "setTableNum\0table_num\0getTableColNum\0"
    "setTableColNum\0col_num\0getuseVoice\0"
    "setuseVoice\0getuseBGM\0setuseBGM\0"
    "getserverCMD\0setserverCMD\0getRobotType\0"
    "setRobotType\0type\0setDebugName\0"
    "getDebugName\0getDebugState\0setDebugState\0"
    "isdebug\0requestCamera\0getLeftCamera\0"
    "getRightCamera\0setCamera\0left\0right\0"
    "getCameraNum\0getCamera\0QList<int>\0"
    "getCameraSerial\0pullGit\0isNewVersion\0"
    "getLocalVersion\0getServerVersion\0"
    "isConnectServer\0isExistMap\0isExistRawMap\0"
    "getAvailableMap\0getAvailableMapPath\0"
    "getMapFileSize\0getMapFile\0isExistAnnotation\0"
    "deleteAnnotation\0loadMaptoServer\0"
    "isUSBFile\0getUSBFilename\0loadMaptoUSB\0"
    "isuseServerMap\0setuseServerMap\0removeMap\0"
    "filename\0isloadMap\0setloadMap\0load\0"
    "isExistRobotINI\0makeRobotINI\0rotate_map\0"
    "_src\0_dst\0mode\0getLCMConnection\0"
    "getLCMRX\0getLCMTX\0getLCMProcess\0"
    "getIniRead\0getUsbMapSize\0getUsbMapPath\0"
    "getUsbMapPathFull\0saveMapfromUsb\0path\0"
    "setMap\0startMapping\0stopMapping\0"
    "setSLAMMode\0setInitPos\0x\0y\0th\0"
    "getInitPoseX\0getInitPoseY\0getInitPoseTH\0"
    "slam_setInit\0slam_run\0slam_stop\0"
    "slam_autoInit\0is_slam_running\0"
    "getMappingflag\0setMappingflag\0flag\0"
    "getMap\0getRawMap\0getMiniMap\0getMapping\0"
    "pushMapData\0data\0isconnectJoy\0getJoyAxis\0"
    "getJoyButton\0getKeyboard\0getJoystick\0"
    "getCanvasSize\0getRedoSize\0getLineX\0"
    "QVector<int>\0index\0getLineY\0getLineColor\0"
    "getLineWidth\0startLine\0color\0width\0"
    "setLine\0stopLine\0undo\0redo\0clear_all\0"
    "setObjPose\0setMarginObj\0clearMarginObj\0"
    "setMarginPoint\0pixel_num\0getMarginObj\0"
    "getMargin\0getLocationNum\0getLocationSize\0"
    "getLocationName\0getLocationTypes\0"
    "getLocationx\0getLocationy\0getLocationth\0"
    "getLidar\0getObjectNum\0getObjectName\0"
    "getObjectPointSize\0getObjectX\0point\0"
    "getObjectY\0getTempObjectSize\0"
    "getTempObjectX\0getTempObjectY\0getObjNum\0"
    "getObjPointNum\0obj_num\0getLocNum\0"
    "addObjectPoint\0removeObjectPoint\0"
    "removeObjectPointLast\0clearObjectPoints\0"
    "getObjectSize\0addObject\0addObjectRect\0"
    "editObject\0removeObject\0removeLocation\0"
    "addLocation\0moveLocationPoint\0loc_num\0"
    "getTlineSize\0getTlineName\0getTlineX\0"
    "getTlineY\0addTline\0x1\0y1\0x2\0y2\0"
    "removeTline\0line\0getTlineNum\0"
    "saveAnnotation\0saveMetaData\0sendMaptoServer\0"
    "acceptCall\0yes\0setTray\0confirmPickup\0"
    "getPickuptrays\0moveTo\0target_num\0"
    "movePause\0moveResume\0moveStop\0moveManual\0"
    "moveToCharge\0moveToWait\0getcurLoc\0"
    "getcurTable\0getcurTarget\0QVector<float>\0"
    "joyMoveXY\0joyMoveR\0r\0getJoyXY\0getJoyR\0"
    "getBattery\0getState\0getErrcode\0"
    "getRobotName\0getRobotRadius\0getRobotx\0"
    "getRoboty\0getRobotth\0getRobotState\0"
    "getPathNum\0getPathx\0getPathy\0getPathth\0"
    "getLocalPathNum\0getLocalPathx\0"
    "getLocalPathy\0getuistate\0getMapname\0"
    "getMappath\0getServerMapname\0"
    "getServerMappath\0getMapWidth\0getMapHeight\0"
    "getGridWidth\0getOrigin\0getPatrolFileName\0"
    "makePatrol\0loadPatrolFile\0savePatrolFile\0"
    "addPatrol\0location\0getPatrolNum\0"
    "getPatrolType\0getPatrolLocation\0"
    "getPatrolX\0getPatrolY\0getPatrolTH\0"
    "removePatrol\0movePatrolUp\0movePatrolDown\0"
    "getPatrolMode\0setPatrolMode\0startRecordPath\0"
    "startcurPath\0stopcurPath\0pausecurPath\0"
    "runRotateTables\0stopRotateTables"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Supervisor[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
     242,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0, 1224,    2, 0x0a /* Public */,
       3,    0, 1225,    2, 0x0a /* Public */,
       4,    0, 1226,    2, 0x0a /* Public */,
       5,    0, 1227,    2, 0x0a /* Public */,
       6,    0, 1228,    2, 0x0a /* Public */,
       7,    0, 1229,    2, 0x0a /* Public */,
       8,    0, 1230,    2, 0x0a /* Public */,
       9,    0, 1231,    2, 0x0a /* Public */,
      10,    0, 1232,    2, 0x0a /* Public */,
      11,    0, 1233,    2, 0x0a /* Public */,
      12,    0, 1234,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      13,    0, 1235,    2, 0x02 /* Public */,
      14,    0, 1236,    2, 0x02 /* Public */,
      15,    1, 1237,    2, 0x02 /* Public */,
      17,    1, 1240,    2, 0x02 /* Public */,
      19,    1, 1243,    2, 0x02 /* Public */,
      20,    1, 1246,    2, 0x02 /* Public */,
      21,    1, 1249,    2, 0x02 /* Public */,
      22,    0, 1252,    2, 0x02 /* Public */,
      23,    2, 1253,    2, 0x02 /* Public */,
      25,    1, 1258,    2, 0x02 /* Public */,
      25,    0, 1261,    2, 0x22 /* Public | MethodCloned */,
      27,    2, 1262,    2, 0x02 /* Public */,
      29,    1, 1267,    2, 0x02 /* Public */,
      31,    0, 1270,    2, 0x02 /* Public */,
      32,    0, 1271,    2, 0x02 /* Public */,
      33,    1, 1272,    2, 0x02 /* Public */,
      35,    0, 1275,    2, 0x02 /* Public */,
      36,    1, 1276,    2, 0x02 /* Public */,
      38,    0, 1279,    2, 0x02 /* Public */,
      39,    1, 1280,    2, 0x02 /* Public */,
      41,    0, 1283,    2, 0x02 /* Public */,
      42,    1, 1284,    2, 0x02 /* Public */,
      44,    0, 1287,    2, 0x02 /* Public */,
      45,    1, 1288,    2, 0x02 /* Public */,
      47,    0, 1291,    2, 0x02 /* Public */,
      48,    1, 1292,    2, 0x02 /* Public */,
      49,    0, 1295,    2, 0x02 /* Public */,
      50,    1, 1296,    2, 0x02 /* Public */,
      51,    0, 1299,    2, 0x02 /* Public */,
      52,    1, 1300,    2, 0x02 /* Public */,
      53,    0, 1303,    2, 0x02 /* Public */,
      54,    1, 1304,    2, 0x02 /* Public */,
      56,    1, 1307,    2, 0x02 /* Public */,
      57,    0, 1310,    2, 0x02 /* Public */,
      58,    0, 1311,    2, 0x02 /* Public */,
      59,    1, 1312,    2, 0x02 /* Public */,
      61,    0, 1315,    2, 0x02 /* Public */,
      62,    0, 1316,    2, 0x02 /* Public */,
      63,    0, 1317,    2, 0x02 /* Public */,
      64,    2, 1318,    2, 0x02 /* Public */,
      67,    0, 1323,    2, 0x02 /* Public */,
      68,    1, 1324,    2, 0x02 /* Public */,
      70,    1, 1327,    2, 0x02 /* Public */,
      71,    0, 1330,    2, 0x02 /* Public */,
      72,    0, 1331,    2, 0x02 /* Public */,
      73,    0, 1332,    2, 0x02 /* Public */,
      74,    0, 1333,    2, 0x02 /* Public */,
      75,    0, 1334,    2, 0x02 /* Public */,
      76,    1, 1335,    2, 0x02 /* Public */,
      77,    1, 1338,    2, 0x02 /* Public */,
      76,    0, 1341,    2, 0x02 /* Public */,
      78,    0, 1342,    2, 0x02 /* Public */,
      79,    1, 1343,    2, 0x02 /* Public */,
      80,    1, 1346,    2, 0x02 /* Public */,
      81,    1, 1349,    2, 0x02 /* Public */,
      82,    1, 1352,    2, 0x02 /* Public */,
      83,    0, 1355,    2, 0x02 /* Public */,
      84,    0, 1356,    2, 0x02 /* Public */,
      85,    0, 1357,    2, 0x02 /* Public */,
      86,    0, 1358,    2, 0x02 /* Public */,
      87,    0, 1359,    2, 0x02 /* Public */,
      88,    0, 1360,    2, 0x02 /* Public */,
      89,    1, 1361,    2, 0x02 /* Public */,
      90,    1, 1364,    2, 0x02 /* Public */,
      92,    0, 1367,    2, 0x02 /* Public */,
      93,    1, 1368,    2, 0x02 /* Public */,
      95,    0, 1371,    2, 0x02 /* Public */,
      96,    0, 1372,    2, 0x02 /* Public */,
      97,    3, 1373,    2, 0x02 /* Public */,
     101,    0, 1380,    2, 0x02 /* Public */,
     102,    0, 1381,    2, 0x02 /* Public */,
     103,    0, 1382,    2, 0x02 /* Public */,
     104,    0, 1383,    2, 0x02 /* Public */,
     105,    0, 1384,    2, 0x02 /* Public */,
     106,    0, 1385,    2, 0x02 /* Public */,
     107,    1, 1386,    2, 0x02 /* Public */,
     108,    1, 1389,    2, 0x02 /* Public */,
     109,    1, 1392,    2, 0x02 /* Public */,
     111,    1, 1395,    2, 0x02 /* Public */,
     112,    0, 1398,    2, 0x02 /* Public */,
     113,    0, 1399,    2, 0x02 /* Public */,
     114,    1, 1400,    2, 0x02 /* Public */,
     115,    3, 1403,    2, 0x02 /* Public */,
     119,    0, 1410,    2, 0x02 /* Public */,
     120,    0, 1411,    2, 0x02 /* Public */,
     121,    0, 1412,    2, 0x02 /* Public */,
     122,    0, 1413,    2, 0x02 /* Public */,
     123,    0, 1414,    2, 0x02 /* Public */,
     124,    0, 1415,    2, 0x02 /* Public */,
     125,    0, 1416,    2, 0x02 /* Public */,
     126,    0, 1417,    2, 0x02 /* Public */,
     127,    0, 1418,    2, 0x02 /* Public */,
     128,    1, 1419,    2, 0x02 /* Public */,
     130,    1, 1422,    2, 0x02 /* Public */,
     131,    1, 1425,    2, 0x02 /* Public */,
     132,    1, 1428,    2, 0x02 /* Public */,
     133,    0, 1431,    2, 0x02 /* Public */,
     134,    1, 1432,    2, 0x02 /* Public */,
     136,    0, 1435,    2, 0x02 /* Public */,
     137,    1, 1436,    2, 0x02 /* Public */,
     138,    1, 1439,    2, 0x02 /* Public */,
     139,    1, 1442,    2, 0x02 /* Public */,
     140,    1, 1445,    2, 0x02 /* Public */,
     141,    0, 1448,    2, 0x02 /* Public */,
     142,    0, 1449,    2, 0x02 /* Public */,
     143,    1, 1450,    2, 0x02 /* Public */,
     146,    1, 1453,    2, 0x02 /* Public */,
     147,    1, 1456,    2, 0x02 /* Public */,
     148,    1, 1459,    2, 0x02 /* Public */,
     149,    2, 1462,    2, 0x02 /* Public */,
     152,    2, 1467,    2, 0x02 /* Public */,
     153,    0, 1472,    2, 0x02 /* Public */,
     154,    0, 1473,    2, 0x02 /* Public */,
     155,    0, 1474,    2, 0x02 /* Public */,
     156,    0, 1475,    2, 0x02 /* Public */,
     157,    0, 1476,    2, 0x02 /* Public */,
     158,    0, 1477,    2, 0x02 /* Public */,
     159,    0, 1478,    2, 0x02 /* Public */,
     160,    1, 1479,    2, 0x02 /* Public */,
     162,    0, 1482,    2, 0x02 /* Public */,
     163,    0, 1483,    2, 0x02 /* Public */,
     164,    0, 1484,    2, 0x02 /* Public */,
     165,    1, 1485,    2, 0x02 /* Public */,
     166,    1, 1488,    2, 0x02 /* Public */,
     167,    1, 1491,    2, 0x02 /* Public */,
     168,    1, 1494,    2, 0x02 /* Public */,
     169,    1, 1497,    2, 0x02 /* Public */,
     170,    1, 1500,    2, 0x02 /* Public */,
     171,    1, 1503,    2, 0x02 /* Public */,
     172,    0, 1506,    2, 0x02 /* Public */,
     173,    1, 1507,    2, 0x02 /* Public */,
     174,    1, 1510,    2, 0x02 /* Public */,
     175,    2, 1513,    2, 0x02 /* Public */,
     177,    2, 1518,    2, 0x02 /* Public */,
     178,    0, 1523,    2, 0x02 /* Public */,
     179,    1, 1524,    2, 0x02 /* Public */,
     180,    1, 1527,    2, 0x02 /* Public */,
     181,    1, 1530,    2, 0x02 /* Public */,
     181,    2, 1533,    2, 0x02 /* Public */,
     182,    3, 1538,    2, 0x02 /* Public */,
     184,    1, 1545,    2, 0x02 /* Public */,
     184,    2, 1548,    2, 0x02 /* Public */,
     185,    2, 1553,    2, 0x02 /* Public */,
     186,    1, 1558,    2, 0x02 /* Public */,
     187,    0, 1561,    2, 0x02 /* Public */,
     188,    0, 1562,    2, 0x02 /* Public */,
     189,    1, 1563,    2, 0x02 /* Public */,
     190,    1, 1566,    2, 0x02 /* Public */,
     191,    1, 1569,    2, 0x02 /* Public */,
     192,    4, 1572,    2, 0x02 /* Public */,
     193,    1, 1581,    2, 0x02 /* Public */,
     194,    1, 1584,    2, 0x02 /* Public */,
     195,    5, 1587,    2, 0x02 /* Public */,
     196,    4, 1598,    2, 0x02 /* Public */,
     198,    0, 1607,    2, 0x02 /* Public */,
     198,    1, 1608,    2, 0x02 /* Public */,
     199,    1, 1611,    2, 0x02 /* Public */,
     200,    2, 1614,    2, 0x02 /* Public */,
     201,    2, 1619,    2, 0x02 /* Public */,
     202,    5, 1624,    2, 0x02 /* Public */,
     207,    2, 1635,    2, 0x02 /* Public */,
     209,    2, 1640,    2, 0x02 /* Public */,
     210,    1, 1645,    2, 0x02 /* Public */,
     211,    1, 1648,    2, 0x02 /* Public */,
     212,    0, 1651,    2, 0x02 /* Public */,
     213,    1, 1652,    2, 0x02 /* Public */,
     215,    2, 1655,    2, 0x02 /* Public */,
     216,    0, 1660,    2, 0x02 /* Public */,
     217,    0, 1661,    2, 0x02 /* Public */,
     218,    1, 1662,    2, 0x02 /* Public */,
     218,    3, 1665,    2, 0x02 /* Public */,
     220,    0, 1672,    2, 0x02 /* Public */,
     221,    0, 1673,    2, 0x02 /* Public */,
     222,    0, 1674,    2, 0x02 /* Public */,
     223,    0, 1675,    2, 0x02 /* Public */,
     224,    0, 1676,    2, 0x02 /* Public */,
     225,    0, 1677,    2, 0x02 /* Public */,
     226,    0, 1678,    2, 0x02 /* Public */,
     227,    0, 1679,    2, 0x02 /* Public */,
     228,    0, 1680,    2, 0x02 /* Public */,
     230,    1, 1681,    2, 0x02 /* Public */,
     231,    1, 1684,    2, 0x02 /* Public */,
     233,    0, 1687,    2, 0x02 /* Public */,
     234,    0, 1688,    2, 0x02 /* Public */,
     235,    0, 1689,    2, 0x02 /* Public */,
     236,    0, 1690,    2, 0x02 /* Public */,
     237,    0, 1691,    2, 0x02 /* Public */,
     238,    0, 1692,    2, 0x02 /* Public */,
     239,    0, 1693,    2, 0x02 /* Public */,
     240,    0, 1694,    2, 0x02 /* Public */,
     241,    0, 1695,    2, 0x02 /* Public */,
     242,    0, 1696,    2, 0x02 /* Public */,
     243,    0, 1697,    2, 0x02 /* Public */,
     244,    0, 1698,    2, 0x02 /* Public */,
     245,    1, 1699,    2, 0x02 /* Public */,
     246,    1, 1702,    2, 0x02 /* Public */,
     247,    1, 1705,    2, 0x02 /* Public */,
     248,    0, 1708,    2, 0x02 /* Public */,
     249,    1, 1709,    2, 0x02 /* Public */,
     250,    1, 1712,    2, 0x02 /* Public */,
     251,    0, 1715,    2, 0x02 /* Public */,
     252,    0, 1716,    2, 0x02 /* Public */,
     253,    0, 1717,    2, 0x02 /* Public */,
     254,    0, 1718,    2, 0x02 /* Public */,
     255,    0, 1719,    2, 0x02 /* Public */,
     256,    0, 1720,    2, 0x02 /* Public */,
     257,    0, 1721,    2, 0x02 /* Public */,
     258,    0, 1722,    2, 0x02 /* Public */,
     259,    0, 1723,    2, 0x02 /* Public */,
     260,    0, 1724,    2, 0x02 /* Public */,
     261,    0, 1725,    2, 0x02 /* Public */,
     262,    1, 1726,    2, 0x02 /* Public */,
     263,    1, 1729,    2, 0x02 /* Public */,
     264,    5, 1732,    2, 0x02 /* Public */,
     266,    0, 1743,    2, 0x02 /* Public */,
     267,    1, 1744,    2, 0x02 /* Public */,
     268,    1, 1747,    2, 0x02 /* Public */,
     269,    1, 1750,    2, 0x02 /* Public */,
     270,    1, 1753,    2, 0x02 /* Public */,
     271,    1, 1756,    2, 0x02 /* Public */,
     272,    1, 1759,    2, 0x02 /* Public */,
     273,    1, 1762,    2, 0x02 /* Public */,
     274,    1, 1765,    2, 0x02 /* Public */,
     275,    0, 1768,    2, 0x02 /* Public */,
     276,    1, 1769,    2, 0x02 /* Public */,
     277,    0, 1772,    2, 0x02 /* Public */,
     278,    0, 1773,    2, 0x02 /* Public */,
     279,    0, 1774,    2, 0x02 /* Public */,
     280,    0, 1775,    2, 0x02 /* Public */,
     281,    0, 1776,    2, 0x02 /* Public */,
     282,    0, 1777,    2, 0x02 /* Public */,

 // slots: parameters
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
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   16,
    QMetaType::QString, QMetaType::QString,   18,
    QMetaType::QString, QMetaType::QString,   18,
    QMetaType::QString, QMetaType::QString,   18,
    QMetaType::QString, QMetaType::QString,   18,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   18,   24,
    QMetaType::Void, QMetaType::QString,   26,
    QMetaType::Void,
    QMetaType::QString, QMetaType::QString, QMetaType::QString,   28,   18,
    QMetaType::Void, QMetaType::Float,   30,
    QMetaType::Float,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   34,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   37,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   40,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   43,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   46,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   34,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   34,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   34,
    QMetaType::QString,
    QMetaType::Void, QMetaType::Int,   55,
    QMetaType::Void, QMetaType::QString,   18,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   60,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   65,   66,
    QMetaType::Int,
    0x80000000 | 69, QMetaType::Int,   37,
    QMetaType::QString, QMetaType::Int,   37,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool, QMetaType::QString,   18,
    QMetaType::Bool, QMetaType::QString,   18,
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   37,
    QMetaType::Int, QMetaType::QString,   18,
    QMetaType::QString, QMetaType::Int,   37,
    QMetaType::Bool, QMetaType::QString,   18,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   34,
    QMetaType::Void, QMetaType::QString,   91,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   94,
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString, QMetaType::Int,   98,   99,  100,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   37,
    QMetaType::QString, QMetaType::Int,   37,
    QMetaType::Void, QMetaType::QString,  110,
    QMetaType::Void, QMetaType::QString,   18,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,  100,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,  116,  117,  118,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  129,
    0x80000000 | 69, QMetaType::QString,   91,
    0x80000000 | 69, QMetaType::QString,   91,
    0x80000000 | 69, QMetaType::QString,   91,
    0x80000000 | 69,
    QMetaType::Void, 0x80000000 | 69,  135,
    QMetaType::Bool,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Int, QMetaType::Int,   37,
    QMetaType::QString, QMetaType::Int,  100,
    QMetaType::QString, QMetaType::Int,  100,
    QMetaType::Int,
    QMetaType::Int,
    0x80000000 | 144, QMetaType::Int,  145,
    0x80000000 | 144, QMetaType::Int,  145,
    QMetaType::QString, QMetaType::Int,  145,
    QMetaType::Float, QMetaType::Int,  145,
    QMetaType::Void, QMetaType::QString, QMetaType::Float,  150,  151,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,  116,  117,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,  161,
    0x80000000 | 144,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int, QMetaType::QString,   55,
    QMetaType::QString, QMetaType::Int,   37,
    QMetaType::QString, QMetaType::Int,   37,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   37,
    QMetaType::Int, QMetaType::Int,   37,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   37,  176,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   37,  176,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Int, QMetaType::QString,   18,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  116,  117,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  183,  116,  117,
    QMetaType::Int, QMetaType::QString,   18,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  116,  117,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,  116,  117,
    QMetaType::Void, QMetaType::Int,   37,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int, QMetaType::QString,   55,
    QMetaType::Void, QMetaType::QString,   55,
    QMetaType::Void, QMetaType::QString,   55,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   37,  176,  116,  117,
    QMetaType::Void, QMetaType::Int,   37,
    QMetaType::Void, QMetaType::QString,   18,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::Float,   55,   18,  116,  117,  118,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Float,  197,  116,  117,  118,
    QMetaType::Int,
    QMetaType::Int, QMetaType::Int,   37,
    QMetaType::QString, QMetaType::Int,   37,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   37,  176,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   37,  176,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   37,  203,  204,  205,  206,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   37,  208,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  116,  117,
    QMetaType::Bool, QMetaType::QString,   91,
    QMetaType::Bool, QMetaType::QString,   91,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,  214,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   40,   43,
    QMetaType::Void,
    0x80000000 | 144,
    QMetaType::Void, QMetaType::QString,  219,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,  116,  117,  118,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    0x80000000 | 229,
    QMetaType::Void, QMetaType::Float,  116,
    QMetaType::Void, QMetaType::Float,  232,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::QString,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Int,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float,
    0x80000000 | 144,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,  110,
    QMetaType::Void, QMetaType::QString,  110,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Float, QMetaType::Float, QMetaType::Float,   55,  265,  116,  117,  118,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   37,
    QMetaType::QString, QMetaType::Int,   37,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Float, QMetaType::Int,   37,
    QMetaType::Void, QMetaType::Int,   37,
    QMetaType::Void, QMetaType::Int,   37,
    QMetaType::Void, QMetaType::Int,   37,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,  100,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

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
        case 6: _t->server_get_map(); break;
        case 7: _t->path_changed(); break;
        case 8: _t->camera_update(); break;
        case 9: _t->usb_detect(); break;
        case 10: _t->git_pull_success(); break;
        case 11: _t->programExit(); break;
        case 12: _t->programHide(); break;
        case 13: _t->writelog((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 14: { QString _r = _t->getRawMapPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 15: { QString _r = _t->getMapPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 16: { QString _r = _t->getAnnotPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 17: { QString _r = _t->getMetaPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 18: { QString _r = _t->getIniPath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 19: _t->setSetting((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 20: _t->readSetting((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 21: _t->readSetting(); break;
        case 22: { QString _r = _t->getSetting((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 23: _t->setVelocity((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 24: { float _r = _t->getVelocity();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 25: { bool _r = _t->getuseTravelline();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 26: _t->setuseTravelline((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 27: { int _r = _t->getnumTravelline();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 28: _t->setnumTravelline((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 29: { int _r = _t->getTrayNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 30: _t->setTrayNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 31: { int _r = _t->getTableNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 32: _t->setTableNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 33: { int _r = _t->getTableColNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 34: _t->setTableColNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 35: { bool _r = _t->getuseVoice();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 36: _t->setuseVoice((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 37: { bool _r = _t->getuseBGM();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 38: _t->setuseBGM((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 39: { bool _r = _t->getserverCMD();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 40: _t->setserverCMD((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 41: { QString _r = _t->getRobotType();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 42: _t->setRobotType((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 43: _t->setDebugName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 44: { QString _r = _t->getDebugName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 45: { bool _r = _t->getDebugState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 46: _t->setDebugState((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 47: _t->requestCamera(); break;
        case 48: { QString _r = _t->getLeftCamera();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 49: { QString _r = _t->getRightCamera();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 50: _t->setCamera((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 51: { int _r = _t->getCameraNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 52: { QList<int> _r = _t->getCamera((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 53: { QString _r = _t->getCameraSerial((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 54: _t->pullGit(); break;
        case 55: { bool _r = _t->isNewVersion();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 56: { QString _r = _t->getLocalVersion();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 57: { QString _r = _t->getServerVersion();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 58: { bool _r = _t->isConnectServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 59: { bool _r = _t->isExistMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 60: { bool _r = _t->isExistRawMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 61: { bool _r = _t->isExistMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 62: { int _r = _t->getAvailableMap();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 63: { QString _r = _t->getAvailableMapPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 64: { int _r = _t->getMapFileSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 65: { QString _r = _t->getMapFile((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 66: { bool _r = _t->isExistAnnotation((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 67: _t->deleteAnnotation(); break;
        case 68: { bool _r = _t->loadMaptoServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 69: { bool _r = _t->isUSBFile();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 70: { QString _r = _t->getUSBFilename();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 71: { bool _r = _t->loadMaptoUSB();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 72: { bool _r = _t->isuseServerMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 73: _t->setuseServerMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 74: _t->removeMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 75: { bool _r = _t->isloadMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 76: _t->setloadMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 77: { bool _r = _t->isExistRobotINI();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 78: _t->makeRobotINI(); break;
        case 79: { bool _r = _t->rotate_map((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 80: { bool _r = _t->getLCMConnection();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 81: { bool _r = _t->getLCMRX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 82: { bool _r = _t->getLCMTX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 83: { bool _r = _t->getLCMProcess();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 84: { bool _r = _t->getIniRead();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 85: { int _r = _t->getUsbMapSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 86: { QString _r = _t->getUsbMapPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 87: { QString _r = _t->getUsbMapPathFull((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 88: _t->saveMapfromUsb((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 89: _t->setMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 90: _t->startMapping(); break;
        case 91: _t->stopMapping(); break;
        case 92: _t->setSLAMMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 93: _t->setInitPos((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 94: { float _r = _t->getInitPoseX();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 95: { float _r = _t->getInitPoseY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 96: { float _r = _t->getInitPoseTH();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 97: _t->slam_setInit(); break;
        case 98: _t->slam_run(); break;
        case 99: _t->slam_stop(); break;
        case 100: _t->slam_autoInit(); break;
        case 101: { bool _r = _t->is_slam_running();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 102: { bool _r = _t->getMappingflag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 103: _t->setMappingflag((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 104: { QList<int> _r = _t->getMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 105: { QList<int> _r = _t->getRawMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 106: { QList<int> _r = _t->getMiniMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 107: { QList<int> _r = _t->getMapping();
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 108: _t->pushMapData((*reinterpret_cast< QList<int>(*)>(_a[1]))); break;
        case 109: { bool _r = _t->isconnectJoy();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 110: { float _r = _t->getJoyAxis((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 111: { int _r = _t->getJoyButton((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 112: { QString _r = _t->getKeyboard((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 113: { QString _r = _t->getJoystick((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 114: { int _r = _t->getCanvasSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 115: { int _r = _t->getRedoSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 116: { QVector<int> _r = _t->getLineX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 117: { QVector<int> _r = _t->getLineY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 118: { QString _r = _t->getLineColor((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 119: { float _r = _t->getLineWidth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 120: _t->startLine((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 121: _t->setLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 122: _t->stopLine(); break;
        case 123: _t->undo(); break;
        case 124: _t->redo(); break;
        case 125: _t->clear_all(); break;
        case 126: _t->setObjPose(); break;
        case 127: _t->setMarginObj(); break;
        case 128: _t->clearMarginObj(); break;
        case 129: _t->setMarginPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 130: { QVector<int> _r = _t->getMarginObj();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 131: { float _r = _t->getMargin();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 132: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 133: { int _r = _t->getLocationSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 134: { QString _r = _t->getLocationName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 135: { QString _r = _t->getLocationTypes((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 136: { float _r = _t->getLocationx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 137: { float _r = _t->getLocationy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 138: { float _r = _t->getLocationth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 139: { float _r = _t->getLidar((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 140: { int _r = _t->getObjectNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 141: { QString _r = _t->getObjectName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 142: { int _r = _t->getObjectPointSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 143: { float _r = _t->getObjectX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 144: { float _r = _t->getObjectY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 145: { int _r = _t->getTempObjectSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 146: { float _r = _t->getTempObjectX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 147: { float _r = _t->getTempObjectY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 148: { int _r = _t->getObjNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 149: { int _r = _t->getObjNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 150: { int _r = _t->getObjPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 151: { int _r = _t->getLocNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 152: { int _r = _t->getLocNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 153: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 154: _t->removeObjectPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 155: _t->removeObjectPointLast(); break;
        case 156: _t->clearObjectPoints(); break;
        case 157: { int _r = _t->getObjectSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 158: _t->addObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 159: _t->addObjectRect((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 160: _t->editObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4]))); break;
        case 161: _t->removeObject((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 162: _t->removeLocation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 163: _t->addLocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< float(*)>(_a[5]))); break;
        case 164: _t->moveLocationPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 165: { int _r = _t->getTlineSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 166: { int _r = _t->getTlineSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 167: { QString _r = _t->getTlineName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 168: { float _r = _t->getTlineX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 169: { float _r = _t->getTlineY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 170: _t->addTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< int(*)>(_a[5]))); break;
        case 171: _t->removeTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 172: { int _r = _t->getTlineNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 173: { bool _r = _t->saveAnnotation((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 174: { bool _r = _t->saveMetaData((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 175: _t->sendMaptoServer(); break;
        case 176: _t->acceptCall((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 177: _t->setTray((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 178: _t->confirmPickup(); break;
        case 179: { QVector<int> _r = _t->getPickuptrays();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 180: _t->moveTo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 181: _t->moveTo((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 182: _t->movePause(); break;
        case 183: _t->moveResume(); break;
        case 184: _t->moveStop(); break;
        case 185: _t->moveManual(); break;
        case 186: _t->moveToCharge(); break;
        case 187: _t->moveToWait(); break;
        case 188: { QString _r = _t->getcurLoc();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 189: { QString _r = _t->getcurTable();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 190: { QVector<float> _r = _t->getcurTarget();
            if (_a[0]) *reinterpret_cast< QVector<float>*>(_a[0]) = std::move(_r); }  break;
        case 191: _t->joyMoveXY((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 192: _t->joyMoveR((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 193: { float _r = _t->getJoyXY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 194: { float _r = _t->getJoyR();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 195: { float _r = _t->getBattery();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 196: { int _r = _t->getState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 197: { int _r = _t->getErrcode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 198: { QString _r = _t->getRobotName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 199: { float _r = _t->getRobotRadius();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 200: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 201: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 202: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 203: { int _r = _t->getRobotState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 204: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 205: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 206: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 207: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 208: { int _r = _t->getLocalPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 209: { float _r = _t->getLocalPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 210: { float _r = _t->getLocalPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 211: { int _r = _t->getuistate();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 212: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 213: { QString _r = _t->getMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 214: { QString _r = _t->getServerMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 215: { QString _r = _t->getServerMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 216: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 217: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 218: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 219: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 220: { QString _r = _t->getPatrolFileName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 221: _t->makePatrol(); break;
        case 222: _t->loadPatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 223: _t->savePatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 224: _t->addPatrol((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4])),(*reinterpret_cast< float(*)>(_a[5]))); break;
        case 225: { int _r = _t->getPatrolNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 226: { QString _r = _t->getPatrolType((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 227: { QString _r = _t->getPatrolLocation((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 228: { float _r = _t->getPatrolX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 229: { float _r = _t->getPatrolY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 230: { float _r = _t->getPatrolTH((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 231: _t->removePatrol((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 232: _t->movePatrolUp((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 233: _t->movePatrolDown((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 234: { int _r = _t->getPatrolMode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 235: _t->setPatrolMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 236: _t->startRecordPath(); break;
        case 237: _t->startcurPath(); break;
        case 238: _t->stopcurPath(); break;
        case 239: _t->pausecurPath(); break;
        case 240: _t->runRotateTables(); break;
        case 241: _t->stopRotateTables(); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 108:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
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
        if (_id < 242)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 242;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 242)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 242;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
