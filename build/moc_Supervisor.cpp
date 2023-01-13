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
    QByteArrayData data[278];
    char stringdata0[3251];
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
QT_MOC_LITERAL(10, 141, 10), // "usb_detect"
QT_MOC_LITERAL(11, 152, 11), // "programExit"
QT_MOC_LITERAL(12, 164, 11), // "programHide"
QT_MOC_LITERAL(13, 176, 8), // "writelog"
QT_MOC_LITERAL(14, 185, 3), // "msg"
QT_MOC_LITERAL(15, 189, 13), // "getRawMapPath"
QT_MOC_LITERAL(16, 203, 4), // "name"
QT_MOC_LITERAL(17, 208, 10), // "getMapPath"
QT_MOC_LITERAL(18, 219, 12), // "getAnnotPath"
QT_MOC_LITERAL(19, 232, 11), // "getMetaPath"
QT_MOC_LITERAL(20, 244, 10), // "getIniPath"
QT_MOC_LITERAL(21, 255, 10), // "setSetting"
QT_MOC_LITERAL(22, 266, 5), // "value"
QT_MOC_LITERAL(23, 272, 11), // "readSetting"
QT_MOC_LITERAL(24, 284, 8), // "map_name"
QT_MOC_LITERAL(25, 293, 10), // "getSetting"
QT_MOC_LITERAL(26, 304, 5), // "group"
QT_MOC_LITERAL(27, 310, 11), // "setVelocity"
QT_MOC_LITERAL(28, 322, 3), // "vel"
QT_MOC_LITERAL(29, 326, 11), // "getVelocity"
QT_MOC_LITERAL(30, 338, 16), // "getuseTravelline"
QT_MOC_LITERAL(31, 355, 16), // "setuseTravelline"
QT_MOC_LITERAL(32, 372, 3), // "use"
QT_MOC_LITERAL(33, 376, 16), // "getnumTravelline"
QT_MOC_LITERAL(34, 393, 16), // "setnumTravelline"
QT_MOC_LITERAL(35, 410, 3), // "num"
QT_MOC_LITERAL(36, 414, 10), // "getTrayNum"
QT_MOC_LITERAL(37, 425, 10), // "setTrayNum"
QT_MOC_LITERAL(38, 436, 8), // "tray_num"
QT_MOC_LITERAL(39, 445, 11), // "getTableNum"
QT_MOC_LITERAL(40, 457, 11), // "setTableNum"
QT_MOC_LITERAL(41, 469, 9), // "table_num"
QT_MOC_LITERAL(42, 479, 14), // "getTableColNum"
QT_MOC_LITERAL(43, 494, 14), // "setTableColNum"
QT_MOC_LITERAL(44, 509, 7), // "col_num"
QT_MOC_LITERAL(45, 517, 11), // "getuseVoice"
QT_MOC_LITERAL(46, 529, 11), // "setuseVoice"
QT_MOC_LITERAL(47, 541, 9), // "getuseBGM"
QT_MOC_LITERAL(48, 551, 9), // "setuseBGM"
QT_MOC_LITERAL(49, 561, 12), // "getserverCMD"
QT_MOC_LITERAL(50, 574, 12), // "setserverCMD"
QT_MOC_LITERAL(51, 587, 12), // "getRobotType"
QT_MOC_LITERAL(52, 600, 12), // "setRobotType"
QT_MOC_LITERAL(53, 613, 4), // "type"
QT_MOC_LITERAL(54, 618, 12), // "setDebugName"
QT_MOC_LITERAL(55, 631, 12), // "getDebugName"
QT_MOC_LITERAL(56, 644, 13), // "getDebugState"
QT_MOC_LITERAL(57, 658, 13), // "setDebugState"
QT_MOC_LITERAL(58, 672, 7), // "isdebug"
QT_MOC_LITERAL(59, 680, 13), // "requestCamera"
QT_MOC_LITERAL(60, 694, 13), // "getLeftCamera"
QT_MOC_LITERAL(61, 708, 14), // "getRightCamera"
QT_MOC_LITERAL(62, 723, 9), // "setCamera"
QT_MOC_LITERAL(63, 733, 4), // "left"
QT_MOC_LITERAL(64, 738, 5), // "right"
QT_MOC_LITERAL(65, 744, 12), // "getCameraNum"
QT_MOC_LITERAL(66, 757, 9), // "getCamera"
QT_MOC_LITERAL(67, 767, 10), // "QList<int>"
QT_MOC_LITERAL(68, 778, 15), // "getCameraSerial"
QT_MOC_LITERAL(69, 794, 15), // "isConnectServer"
QT_MOC_LITERAL(70, 810, 10), // "isExistMap"
QT_MOC_LITERAL(71, 821, 13), // "isExistRawMap"
QT_MOC_LITERAL(72, 835, 15), // "getAvailableMap"
QT_MOC_LITERAL(73, 851, 19), // "getAvailableMapPath"
QT_MOC_LITERAL(74, 871, 14), // "getMapFileSize"
QT_MOC_LITERAL(75, 886, 10), // "getMapFile"
QT_MOC_LITERAL(76, 897, 17), // "isExistAnnotation"
QT_MOC_LITERAL(77, 915, 16), // "deleteAnnotation"
QT_MOC_LITERAL(78, 932, 15), // "loadMaptoServer"
QT_MOC_LITERAL(79, 948, 9), // "isUSBFile"
QT_MOC_LITERAL(80, 958, 14), // "getUSBFilename"
QT_MOC_LITERAL(81, 973, 12), // "loadMaptoUSB"
QT_MOC_LITERAL(82, 986, 14), // "isuseServerMap"
QT_MOC_LITERAL(83, 1001, 15), // "setuseServerMap"
QT_MOC_LITERAL(84, 1017, 9), // "removeMap"
QT_MOC_LITERAL(85, 1027, 8), // "filename"
QT_MOC_LITERAL(86, 1036, 9), // "isloadMap"
QT_MOC_LITERAL(87, 1046, 10), // "setloadMap"
QT_MOC_LITERAL(88, 1057, 4), // "load"
QT_MOC_LITERAL(89, 1062, 15), // "isExistRobotINI"
QT_MOC_LITERAL(90, 1078, 12), // "makeRobotINI"
QT_MOC_LITERAL(91, 1091, 10), // "rotate_map"
QT_MOC_LITERAL(92, 1102, 4), // "_src"
QT_MOC_LITERAL(93, 1107, 4), // "_dst"
QT_MOC_LITERAL(94, 1112, 4), // "mode"
QT_MOC_LITERAL(95, 1117, 16), // "getLCMConnection"
QT_MOC_LITERAL(96, 1134, 8), // "getLCMRX"
QT_MOC_LITERAL(97, 1143, 8), // "getLCMTX"
QT_MOC_LITERAL(98, 1152, 13), // "getLCMProcess"
QT_MOC_LITERAL(99, 1166, 10), // "getIniRead"
QT_MOC_LITERAL(100, 1177, 13), // "getUsbMapSize"
QT_MOC_LITERAL(101, 1191, 13), // "getUsbMapPath"
QT_MOC_LITERAL(102, 1205, 17), // "getUsbMapPathFull"
QT_MOC_LITERAL(103, 1223, 14), // "saveMapfromUsb"
QT_MOC_LITERAL(104, 1238, 4), // "path"
QT_MOC_LITERAL(105, 1243, 6), // "setMap"
QT_MOC_LITERAL(106, 1250, 12), // "startMapping"
QT_MOC_LITERAL(107, 1263, 11), // "stopMapping"
QT_MOC_LITERAL(108, 1275, 11), // "setSLAMMode"
QT_MOC_LITERAL(109, 1287, 10), // "setInitPos"
QT_MOC_LITERAL(110, 1298, 1), // "x"
QT_MOC_LITERAL(111, 1300, 1), // "y"
QT_MOC_LITERAL(112, 1302, 2), // "th"
QT_MOC_LITERAL(113, 1305, 12), // "getInitPoseX"
QT_MOC_LITERAL(114, 1318, 12), // "getInitPoseY"
QT_MOC_LITERAL(115, 1331, 13), // "getInitPoseTH"
QT_MOC_LITERAL(116, 1345, 12), // "slam_setInit"
QT_MOC_LITERAL(117, 1358, 8), // "slam_run"
QT_MOC_LITERAL(118, 1367, 9), // "slam_stop"
QT_MOC_LITERAL(119, 1377, 13), // "slam_autoInit"
QT_MOC_LITERAL(120, 1391, 15), // "is_slam_running"
QT_MOC_LITERAL(121, 1407, 14), // "getMappingflag"
QT_MOC_LITERAL(122, 1422, 14), // "setMappingflag"
QT_MOC_LITERAL(123, 1437, 4), // "flag"
QT_MOC_LITERAL(124, 1442, 6), // "getMap"
QT_MOC_LITERAL(125, 1449, 9), // "getRawMap"
QT_MOC_LITERAL(126, 1459, 10), // "getMiniMap"
QT_MOC_LITERAL(127, 1470, 10), // "getMapping"
QT_MOC_LITERAL(128, 1481, 11), // "pushMapData"
QT_MOC_LITERAL(129, 1493, 4), // "data"
QT_MOC_LITERAL(130, 1498, 12), // "isconnectJoy"
QT_MOC_LITERAL(131, 1511, 10), // "getJoyAxis"
QT_MOC_LITERAL(132, 1522, 12), // "getJoyButton"
QT_MOC_LITERAL(133, 1535, 11), // "getKeyboard"
QT_MOC_LITERAL(134, 1547, 11), // "getJoystick"
QT_MOC_LITERAL(135, 1559, 13), // "getCanvasSize"
QT_MOC_LITERAL(136, 1573, 11), // "getRedoSize"
QT_MOC_LITERAL(137, 1585, 8), // "getLineX"
QT_MOC_LITERAL(138, 1594, 12), // "QVector<int>"
QT_MOC_LITERAL(139, 1607, 5), // "index"
QT_MOC_LITERAL(140, 1613, 8), // "getLineY"
QT_MOC_LITERAL(141, 1622, 12), // "getLineColor"
QT_MOC_LITERAL(142, 1635, 12), // "getLineWidth"
QT_MOC_LITERAL(143, 1648, 9), // "startLine"
QT_MOC_LITERAL(144, 1658, 5), // "color"
QT_MOC_LITERAL(145, 1664, 5), // "width"
QT_MOC_LITERAL(146, 1670, 7), // "setLine"
QT_MOC_LITERAL(147, 1678, 8), // "stopLine"
QT_MOC_LITERAL(148, 1687, 4), // "undo"
QT_MOC_LITERAL(149, 1692, 4), // "redo"
QT_MOC_LITERAL(150, 1697, 9), // "clear_all"
QT_MOC_LITERAL(151, 1707, 10), // "setObjPose"
QT_MOC_LITERAL(152, 1718, 12), // "setMarginObj"
QT_MOC_LITERAL(153, 1731, 14), // "clearMarginObj"
QT_MOC_LITERAL(154, 1746, 14), // "setMarginPoint"
QT_MOC_LITERAL(155, 1761, 9), // "pixel_num"
QT_MOC_LITERAL(156, 1771, 12), // "getMarginObj"
QT_MOC_LITERAL(157, 1784, 9), // "getMargin"
QT_MOC_LITERAL(158, 1794, 14), // "getLocationNum"
QT_MOC_LITERAL(159, 1809, 15), // "getLocationSize"
QT_MOC_LITERAL(160, 1825, 15), // "getLocationName"
QT_MOC_LITERAL(161, 1841, 16), // "getLocationTypes"
QT_MOC_LITERAL(162, 1858, 12), // "getLocationx"
QT_MOC_LITERAL(163, 1871, 12), // "getLocationy"
QT_MOC_LITERAL(164, 1884, 13), // "getLocationth"
QT_MOC_LITERAL(165, 1898, 8), // "getLidar"
QT_MOC_LITERAL(166, 1907, 12), // "getObjectNum"
QT_MOC_LITERAL(167, 1920, 13), // "getObjectName"
QT_MOC_LITERAL(168, 1934, 18), // "getObjectPointSize"
QT_MOC_LITERAL(169, 1953, 10), // "getObjectX"
QT_MOC_LITERAL(170, 1964, 5), // "point"
QT_MOC_LITERAL(171, 1970, 10), // "getObjectY"
QT_MOC_LITERAL(172, 1981, 17), // "getTempObjectSize"
QT_MOC_LITERAL(173, 1999, 14), // "getTempObjectX"
QT_MOC_LITERAL(174, 2014, 14), // "getTempObjectY"
QT_MOC_LITERAL(175, 2029, 9), // "getObjNum"
QT_MOC_LITERAL(176, 2039, 14), // "getObjPointNum"
QT_MOC_LITERAL(177, 2054, 7), // "obj_num"
QT_MOC_LITERAL(178, 2062, 9), // "getLocNum"
QT_MOC_LITERAL(179, 2072, 14), // "addObjectPoint"
QT_MOC_LITERAL(180, 2087, 17), // "removeObjectPoint"
QT_MOC_LITERAL(181, 2105, 21), // "removeObjectPointLast"
QT_MOC_LITERAL(182, 2127, 17), // "clearObjectPoints"
QT_MOC_LITERAL(183, 2145, 13), // "getObjectSize"
QT_MOC_LITERAL(184, 2159, 9), // "addObject"
QT_MOC_LITERAL(185, 2169, 13), // "addObjectRect"
QT_MOC_LITERAL(186, 2183, 10), // "editObject"
QT_MOC_LITERAL(187, 2194, 12), // "removeObject"
QT_MOC_LITERAL(188, 2207, 14), // "removeLocation"
QT_MOC_LITERAL(189, 2222, 11), // "addLocation"
QT_MOC_LITERAL(190, 2234, 17), // "moveLocationPoint"
QT_MOC_LITERAL(191, 2252, 7), // "loc_num"
QT_MOC_LITERAL(192, 2260, 12), // "getTlineSize"
QT_MOC_LITERAL(193, 2273, 12), // "getTlineName"
QT_MOC_LITERAL(194, 2286, 9), // "getTlineX"
QT_MOC_LITERAL(195, 2296, 9), // "getTlineY"
QT_MOC_LITERAL(196, 2306, 8), // "addTline"
QT_MOC_LITERAL(197, 2315, 2), // "x1"
QT_MOC_LITERAL(198, 2318, 2), // "y1"
QT_MOC_LITERAL(199, 2321, 2), // "x2"
QT_MOC_LITERAL(200, 2324, 2), // "y2"
QT_MOC_LITERAL(201, 2327, 11), // "removeTline"
QT_MOC_LITERAL(202, 2339, 4), // "line"
QT_MOC_LITERAL(203, 2344, 11), // "getTlineNum"
QT_MOC_LITERAL(204, 2356, 14), // "saveAnnotation"
QT_MOC_LITERAL(205, 2371, 12), // "saveMetaData"
QT_MOC_LITERAL(206, 2384, 15), // "sendMaptoServer"
QT_MOC_LITERAL(207, 2400, 10), // "acceptCall"
QT_MOC_LITERAL(208, 2411, 3), // "yes"
QT_MOC_LITERAL(209, 2415, 7), // "setTray"
QT_MOC_LITERAL(210, 2423, 13), // "confirmPickup"
QT_MOC_LITERAL(211, 2437, 14), // "getPickuptrays"
QT_MOC_LITERAL(212, 2452, 6), // "moveTo"
QT_MOC_LITERAL(213, 2459, 10), // "target_num"
QT_MOC_LITERAL(214, 2470, 9), // "movePause"
QT_MOC_LITERAL(215, 2480, 10), // "moveResume"
QT_MOC_LITERAL(216, 2491, 8), // "moveStop"
QT_MOC_LITERAL(217, 2500, 10), // "moveManual"
QT_MOC_LITERAL(218, 2511, 12), // "moveToCharge"
QT_MOC_LITERAL(219, 2524, 10), // "moveToWait"
QT_MOC_LITERAL(220, 2535, 9), // "getcurLoc"
QT_MOC_LITERAL(221, 2545, 11), // "getcurTable"
QT_MOC_LITERAL(222, 2557, 12), // "getcurTarget"
QT_MOC_LITERAL(223, 2570, 14), // "QVector<float>"
QT_MOC_LITERAL(224, 2585, 9), // "joyMoveXY"
QT_MOC_LITERAL(225, 2595, 8), // "joyMoveR"
QT_MOC_LITERAL(226, 2604, 1), // "r"
QT_MOC_LITERAL(227, 2606, 8), // "getJoyXY"
QT_MOC_LITERAL(228, 2615, 7), // "getJoyR"
QT_MOC_LITERAL(229, 2623, 10), // "getBattery"
QT_MOC_LITERAL(230, 2634, 8), // "getState"
QT_MOC_LITERAL(231, 2643, 10), // "getErrcode"
QT_MOC_LITERAL(232, 2654, 12), // "getRobotName"
QT_MOC_LITERAL(233, 2667, 12), // "setRobotName"
QT_MOC_LITERAL(234, 2680, 14), // "getRobotRadius"
QT_MOC_LITERAL(235, 2695, 9), // "getRobotx"
QT_MOC_LITERAL(236, 2705, 9), // "getRoboty"
QT_MOC_LITERAL(237, 2715, 10), // "getRobotth"
QT_MOC_LITERAL(238, 2726, 13), // "getRobotState"
QT_MOC_LITERAL(239, 2740, 10), // "getPathNum"
QT_MOC_LITERAL(240, 2751, 8), // "getPathx"
QT_MOC_LITERAL(241, 2760, 8), // "getPathy"
QT_MOC_LITERAL(242, 2769, 9), // "getPathth"
QT_MOC_LITERAL(243, 2779, 15), // "getLocalPathNum"
QT_MOC_LITERAL(244, 2795, 13), // "getLocalPathx"
QT_MOC_LITERAL(245, 2809, 13), // "getLocalPathy"
QT_MOC_LITERAL(246, 2823, 10), // "getuistate"
QT_MOC_LITERAL(247, 2834, 10), // "getMapname"
QT_MOC_LITERAL(248, 2845, 10), // "getMappath"
QT_MOC_LITERAL(249, 2856, 16), // "getServerMapname"
QT_MOC_LITERAL(250, 2873, 16), // "getServerMappath"
QT_MOC_LITERAL(251, 2890, 11), // "getMapWidth"
QT_MOC_LITERAL(252, 2902, 12), // "getMapHeight"
QT_MOC_LITERAL(253, 2915, 12), // "getGridWidth"
QT_MOC_LITERAL(254, 2928, 9), // "getOrigin"
QT_MOC_LITERAL(255, 2938, 17), // "getPatrolFileName"
QT_MOC_LITERAL(256, 2956, 10), // "makePatrol"
QT_MOC_LITERAL(257, 2967, 14), // "loadPatrolFile"
QT_MOC_LITERAL(258, 2982, 14), // "savePatrolFile"
QT_MOC_LITERAL(259, 2997, 9), // "addPatrol"
QT_MOC_LITERAL(260, 3007, 8), // "location"
QT_MOC_LITERAL(261, 3016, 12), // "getPatrolNum"
QT_MOC_LITERAL(262, 3029, 13), // "getPatrolType"
QT_MOC_LITERAL(263, 3043, 17), // "getPatrolLocation"
QT_MOC_LITERAL(264, 3061, 10), // "getPatrolX"
QT_MOC_LITERAL(265, 3072, 10), // "getPatrolY"
QT_MOC_LITERAL(266, 3083, 11), // "getPatrolTH"
QT_MOC_LITERAL(267, 3095, 12), // "removePatrol"
QT_MOC_LITERAL(268, 3108, 12), // "movePatrolUp"
QT_MOC_LITERAL(269, 3121, 14), // "movePatrolDown"
QT_MOC_LITERAL(270, 3136, 13), // "getPatrolMode"
QT_MOC_LITERAL(271, 3150, 13), // "setPatrolMode"
QT_MOC_LITERAL(272, 3164, 15), // "startRecordPath"
QT_MOC_LITERAL(273, 3180, 12), // "startcurPath"
QT_MOC_LITERAL(274, 3193, 11), // "stopcurPath"
QT_MOC_LITERAL(275, 3205, 12), // "pausecurPath"
QT_MOC_LITERAL(276, 3218, 15), // "runRotateTables"
QT_MOC_LITERAL(277, 3234, 16) // "stopRotateTables"

    },
    "Supervisor\0onTimer\0\0server_cmd_pause\0"
    "server_cmd_resume\0server_cmd_newtarget\0"
    "server_cmd_newcall\0server_cmd_setini\0"
    "server_get_map\0path_changed\0usb_detect\0"
    "programExit\0programHide\0writelog\0msg\0"
    "getRawMapPath\0name\0getMapPath\0"
    "getAnnotPath\0getMetaPath\0getIniPath\0"
    "setSetting\0value\0readSetting\0map_name\0"
    "getSetting\0group\0setVelocity\0vel\0"
    "getVelocity\0getuseTravelline\0"
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
    "getCameraSerial\0isConnectServer\0"
    "isExistMap\0isExistRawMap\0getAvailableMap\0"
    "getAvailableMapPath\0getMapFileSize\0"
    "getMapFile\0isExistAnnotation\0"
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
    "getRobotName\0setRobotName\0getRobotRadius\0"
    "getRobotx\0getRoboty\0getRobotth\0"
    "getRobotState\0getPathNum\0getPathx\0"
    "getPathy\0getPathth\0getLocalPathNum\0"
    "getLocalPathx\0getLocalPathy\0getuistate\0"
    "getMapname\0getMappath\0getServerMapname\0"
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
     237,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0, 1199,    2, 0x0a /* Public */,
       3,    0, 1200,    2, 0x0a /* Public */,
       4,    0, 1201,    2, 0x0a /* Public */,
       5,    0, 1202,    2, 0x0a /* Public */,
       6,    0, 1203,    2, 0x0a /* Public */,
       7,    0, 1204,    2, 0x0a /* Public */,
       8,    0, 1205,    2, 0x0a /* Public */,
       9,    0, 1206,    2, 0x0a /* Public */,
      10,    0, 1207,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      11,    0, 1208,    2, 0x02 /* Public */,
      12,    0, 1209,    2, 0x02 /* Public */,
      13,    1, 1210,    2, 0x02 /* Public */,
      15,    1, 1213,    2, 0x02 /* Public */,
      17,    1, 1216,    2, 0x02 /* Public */,
      18,    1, 1219,    2, 0x02 /* Public */,
      19,    1, 1222,    2, 0x02 /* Public */,
      20,    0, 1225,    2, 0x02 /* Public */,
      21,    2, 1226,    2, 0x02 /* Public */,
      23,    1, 1231,    2, 0x02 /* Public */,
      23,    0, 1234,    2, 0x22 /* Public | MethodCloned */,
      25,    2, 1235,    2, 0x02 /* Public */,
      27,    1, 1240,    2, 0x02 /* Public */,
      29,    0, 1243,    2, 0x02 /* Public */,
      30,    0, 1244,    2, 0x02 /* Public */,
      31,    1, 1245,    2, 0x02 /* Public */,
      33,    0, 1248,    2, 0x02 /* Public */,
      34,    1, 1249,    2, 0x02 /* Public */,
      36,    0, 1252,    2, 0x02 /* Public */,
      37,    1, 1253,    2, 0x02 /* Public */,
      39,    0, 1256,    2, 0x02 /* Public */,
      40,    1, 1257,    2, 0x02 /* Public */,
      42,    0, 1260,    2, 0x02 /* Public */,
      43,    1, 1261,    2, 0x02 /* Public */,
      45,    0, 1264,    2, 0x02 /* Public */,
      46,    1, 1265,    2, 0x02 /* Public */,
      47,    0, 1268,    2, 0x02 /* Public */,
      48,    1, 1269,    2, 0x02 /* Public */,
      49,    0, 1272,    2, 0x02 /* Public */,
      50,    1, 1273,    2, 0x02 /* Public */,
      51,    0, 1276,    2, 0x02 /* Public */,
      52,    1, 1277,    2, 0x02 /* Public */,
      54,    1, 1280,    2, 0x02 /* Public */,
      55,    0, 1283,    2, 0x02 /* Public */,
      56,    0, 1284,    2, 0x02 /* Public */,
      57,    1, 1285,    2, 0x02 /* Public */,
      59,    0, 1288,    2, 0x02 /* Public */,
      60,    0, 1289,    2, 0x02 /* Public */,
      61,    0, 1290,    2, 0x02 /* Public */,
      62,    2, 1291,    2, 0x02 /* Public */,
      65,    0, 1296,    2, 0x02 /* Public */,
      66,    1, 1297,    2, 0x02 /* Public */,
      68,    1, 1300,    2, 0x02 /* Public */,
      69,    0, 1303,    2, 0x02 /* Public */,
      70,    1, 1304,    2, 0x02 /* Public */,
      71,    1, 1307,    2, 0x02 /* Public */,
      70,    0, 1310,    2, 0x02 /* Public */,
      72,    0, 1311,    2, 0x02 /* Public */,
      73,    1, 1312,    2, 0x02 /* Public */,
      74,    1, 1315,    2, 0x02 /* Public */,
      75,    1, 1318,    2, 0x02 /* Public */,
      76,    1, 1321,    2, 0x02 /* Public */,
      77,    0, 1324,    2, 0x02 /* Public */,
      78,    0, 1325,    2, 0x02 /* Public */,
      79,    0, 1326,    2, 0x02 /* Public */,
      80,    0, 1327,    2, 0x02 /* Public */,
      81,    0, 1328,    2, 0x02 /* Public */,
      82,    0, 1329,    2, 0x02 /* Public */,
      83,    1, 1330,    2, 0x02 /* Public */,
      84,    1, 1333,    2, 0x02 /* Public */,
      86,    0, 1336,    2, 0x02 /* Public */,
      87,    1, 1337,    2, 0x02 /* Public */,
      89,    0, 1340,    2, 0x02 /* Public */,
      90,    0, 1341,    2, 0x02 /* Public */,
      91,    3, 1342,    2, 0x02 /* Public */,
      95,    0, 1349,    2, 0x02 /* Public */,
      96,    0, 1350,    2, 0x02 /* Public */,
      97,    0, 1351,    2, 0x02 /* Public */,
      98,    0, 1352,    2, 0x02 /* Public */,
      99,    0, 1353,    2, 0x02 /* Public */,
     100,    0, 1354,    2, 0x02 /* Public */,
     101,    1, 1355,    2, 0x02 /* Public */,
     102,    1, 1358,    2, 0x02 /* Public */,
     103,    1, 1361,    2, 0x02 /* Public */,
     105,    1, 1364,    2, 0x02 /* Public */,
     106,    0, 1367,    2, 0x02 /* Public */,
     107,    0, 1368,    2, 0x02 /* Public */,
     108,    1, 1369,    2, 0x02 /* Public */,
     109,    3, 1372,    2, 0x02 /* Public */,
     113,    0, 1379,    2, 0x02 /* Public */,
     114,    0, 1380,    2, 0x02 /* Public */,
     115,    0, 1381,    2, 0x02 /* Public */,
     116,    0, 1382,    2, 0x02 /* Public */,
     117,    0, 1383,    2, 0x02 /* Public */,
     118,    0, 1384,    2, 0x02 /* Public */,
     119,    0, 1385,    2, 0x02 /* Public */,
     120,    0, 1386,    2, 0x02 /* Public */,
     121,    0, 1387,    2, 0x02 /* Public */,
     122,    1, 1388,    2, 0x02 /* Public */,
     124,    1, 1391,    2, 0x02 /* Public */,
     125,    1, 1394,    2, 0x02 /* Public */,
     126,    1, 1397,    2, 0x02 /* Public */,
     127,    0, 1400,    2, 0x02 /* Public */,
     128,    1, 1401,    2, 0x02 /* Public */,
     130,    0, 1404,    2, 0x02 /* Public */,
     131,    1, 1405,    2, 0x02 /* Public */,
     132,    1, 1408,    2, 0x02 /* Public */,
     133,    1, 1411,    2, 0x02 /* Public */,
     134,    1, 1414,    2, 0x02 /* Public */,
     135,    0, 1417,    2, 0x02 /* Public */,
     136,    0, 1418,    2, 0x02 /* Public */,
     137,    1, 1419,    2, 0x02 /* Public */,
     140,    1, 1422,    2, 0x02 /* Public */,
     141,    1, 1425,    2, 0x02 /* Public */,
     142,    1, 1428,    2, 0x02 /* Public */,
     143,    2, 1431,    2, 0x02 /* Public */,
     146,    2, 1436,    2, 0x02 /* Public */,
     147,    0, 1441,    2, 0x02 /* Public */,
     148,    0, 1442,    2, 0x02 /* Public */,
     149,    0, 1443,    2, 0x02 /* Public */,
     150,    0, 1444,    2, 0x02 /* Public */,
     151,    0, 1445,    2, 0x02 /* Public */,
     152,    0, 1446,    2, 0x02 /* Public */,
     153,    0, 1447,    2, 0x02 /* Public */,
     154,    1, 1448,    2, 0x02 /* Public */,
     156,    0, 1451,    2, 0x02 /* Public */,
     157,    0, 1452,    2, 0x02 /* Public */,
     158,    0, 1453,    2, 0x02 /* Public */,
     159,    1, 1454,    2, 0x02 /* Public */,
     160,    1, 1457,    2, 0x02 /* Public */,
     161,    1, 1460,    2, 0x02 /* Public */,
     162,    1, 1463,    2, 0x02 /* Public */,
     163,    1, 1466,    2, 0x02 /* Public */,
     164,    1, 1469,    2, 0x02 /* Public */,
     165,    1, 1472,    2, 0x02 /* Public */,
     166,    0, 1475,    2, 0x02 /* Public */,
     167,    1, 1476,    2, 0x02 /* Public */,
     168,    1, 1479,    2, 0x02 /* Public */,
     169,    2, 1482,    2, 0x02 /* Public */,
     171,    2, 1487,    2, 0x02 /* Public */,
     172,    0, 1492,    2, 0x02 /* Public */,
     173,    1, 1493,    2, 0x02 /* Public */,
     174,    1, 1496,    2, 0x02 /* Public */,
     175,    1, 1499,    2, 0x02 /* Public */,
     175,    2, 1502,    2, 0x02 /* Public */,
     176,    3, 1507,    2, 0x02 /* Public */,
     178,    1, 1514,    2, 0x02 /* Public */,
     178,    2, 1517,    2, 0x02 /* Public */,
     179,    2, 1522,    2, 0x02 /* Public */,
     180,    1, 1527,    2, 0x02 /* Public */,
     181,    0, 1530,    2, 0x02 /* Public */,
     182,    0, 1531,    2, 0x02 /* Public */,
     183,    1, 1532,    2, 0x02 /* Public */,
     184,    1, 1535,    2, 0x02 /* Public */,
     185,    1, 1538,    2, 0x02 /* Public */,
     186,    4, 1541,    2, 0x02 /* Public */,
     187,    1, 1550,    2, 0x02 /* Public */,
     188,    1, 1553,    2, 0x02 /* Public */,
     189,    5, 1556,    2, 0x02 /* Public */,
     190,    4, 1567,    2, 0x02 /* Public */,
     192,    0, 1576,    2, 0x02 /* Public */,
     192,    1, 1577,    2, 0x02 /* Public */,
     193,    1, 1580,    2, 0x02 /* Public */,
     194,    2, 1583,    2, 0x02 /* Public */,
     195,    2, 1588,    2, 0x02 /* Public */,
     196,    5, 1593,    2, 0x02 /* Public */,
     201,    2, 1604,    2, 0x02 /* Public */,
     203,    2, 1609,    2, 0x02 /* Public */,
     204,    1, 1614,    2, 0x02 /* Public */,
     205,    1, 1617,    2, 0x02 /* Public */,
     206,    0, 1620,    2, 0x02 /* Public */,
     207,    1, 1621,    2, 0x02 /* Public */,
     209,    2, 1624,    2, 0x02 /* Public */,
     210,    0, 1629,    2, 0x02 /* Public */,
     211,    0, 1630,    2, 0x02 /* Public */,
     212,    1, 1631,    2, 0x02 /* Public */,
     212,    3, 1634,    2, 0x02 /* Public */,
     214,    0, 1641,    2, 0x02 /* Public */,
     215,    0, 1642,    2, 0x02 /* Public */,
     216,    0, 1643,    2, 0x02 /* Public */,
     217,    0, 1644,    2, 0x02 /* Public */,
     218,    0, 1645,    2, 0x02 /* Public */,
     219,    0, 1646,    2, 0x02 /* Public */,
     220,    0, 1647,    2, 0x02 /* Public */,
     221,    0, 1648,    2, 0x02 /* Public */,
     222,    0, 1649,    2, 0x02 /* Public */,
     224,    1, 1650,    2, 0x02 /* Public */,
     225,    1, 1653,    2, 0x02 /* Public */,
     227,    0, 1656,    2, 0x02 /* Public */,
     228,    0, 1657,    2, 0x02 /* Public */,
     229,    0, 1658,    2, 0x02 /* Public */,
     230,    0, 1659,    2, 0x02 /* Public */,
     231,    0, 1660,    2, 0x02 /* Public */,
     232,    0, 1661,    2, 0x02 /* Public */,
     233,    1, 1662,    2, 0x02 /* Public */,
     234,    0, 1665,    2, 0x02 /* Public */,
     235,    0, 1666,    2, 0x02 /* Public */,
     236,    0, 1667,    2, 0x02 /* Public */,
     237,    0, 1668,    2, 0x02 /* Public */,
     238,    0, 1669,    2, 0x02 /* Public */,
     239,    0, 1670,    2, 0x02 /* Public */,
     240,    1, 1671,    2, 0x02 /* Public */,
     241,    1, 1674,    2, 0x02 /* Public */,
     242,    1, 1677,    2, 0x02 /* Public */,
     243,    0, 1680,    2, 0x02 /* Public */,
     244,    1, 1681,    2, 0x02 /* Public */,
     245,    1, 1684,    2, 0x02 /* Public */,
     246,    0, 1687,    2, 0x02 /* Public */,
     247,    0, 1688,    2, 0x02 /* Public */,
     248,    0, 1689,    2, 0x02 /* Public */,
     249,    0, 1690,    2, 0x02 /* Public */,
     250,    0, 1691,    2, 0x02 /* Public */,
     251,    0, 1692,    2, 0x02 /* Public */,
     252,    0, 1693,    2, 0x02 /* Public */,
     253,    0, 1694,    2, 0x02 /* Public */,
     254,    0, 1695,    2, 0x02 /* Public */,
     255,    0, 1696,    2, 0x02 /* Public */,
     256,    0, 1697,    2, 0x02 /* Public */,
     257,    1, 1698,    2, 0x02 /* Public */,
     258,    1, 1701,    2, 0x02 /* Public */,
     259,    5, 1704,    2, 0x02 /* Public */,
     261,    0, 1715,    2, 0x02 /* Public */,
     262,    1, 1716,    2, 0x02 /* Public */,
     263,    1, 1719,    2, 0x02 /* Public */,
     264,    1, 1722,    2, 0x02 /* Public */,
     265,    1, 1725,    2, 0x02 /* Public */,
     266,    1, 1728,    2, 0x02 /* Public */,
     267,    1, 1731,    2, 0x02 /* Public */,
     268,    1, 1734,    2, 0x02 /* Public */,
     269,    1, 1737,    2, 0x02 /* Public */,
     270,    0, 1740,    2, 0x02 /* Public */,
     271,    1, 1741,    2, 0x02 /* Public */,
     272,    0, 1744,    2, 0x02 /* Public */,
     273,    0, 1745,    2, 0x02 /* Public */,
     274,    0, 1746,    2, 0x02 /* Public */,
     275,    0, 1747,    2, 0x02 /* Public */,
     276,    0, 1748,    2, 0x02 /* Public */,
     277,    0, 1749,    2, 0x02 /* Public */,

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

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   14,
    QMetaType::QString, QMetaType::QString,   16,
    QMetaType::QString, QMetaType::QString,   16,
    QMetaType::QString, QMetaType::QString,   16,
    QMetaType::QString, QMetaType::QString,   16,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   16,   22,
    QMetaType::Void, QMetaType::QString,   24,
    QMetaType::Void,
    QMetaType::QString, QMetaType::QString, QMetaType::QString,   26,   16,
    QMetaType::Void, QMetaType::Float,   28,
    QMetaType::Float,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   32,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   35,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   38,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   41,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   44,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   32,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   32,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   32,
    QMetaType::QString,
    QMetaType::Void, QMetaType::Int,   53,
    QMetaType::Void, QMetaType::QString,   16,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   58,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   63,   64,
    QMetaType::Int,
    0x80000000 | 67, QMetaType::Int,   35,
    QMetaType::QString, QMetaType::Int,   35,
    QMetaType::Bool,
    QMetaType::Bool, QMetaType::QString,   16,
    QMetaType::Bool, QMetaType::QString,   16,
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   35,
    QMetaType::Int, QMetaType::QString,   16,
    QMetaType::QString, QMetaType::Int,   35,
    QMetaType::Bool, QMetaType::QString,   16,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   32,
    QMetaType::Void, QMetaType::QString,   85,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   88,
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString, QMetaType::Int,   92,   93,   94,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   35,
    QMetaType::QString, QMetaType::Int,   35,
    QMetaType::Void, QMetaType::QString,  104,
    QMetaType::Void, QMetaType::QString,   16,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   94,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,  110,  111,  112,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  123,
    0x80000000 | 67, QMetaType::QString,   85,
    0x80000000 | 67, QMetaType::QString,   85,
    0x80000000 | 67, QMetaType::QString,   85,
    0x80000000 | 67,
    QMetaType::Void, 0x80000000 | 67,  129,
    QMetaType::Bool,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Int, QMetaType::Int,   35,
    QMetaType::QString, QMetaType::Int,   94,
    QMetaType::QString, QMetaType::Int,   94,
    QMetaType::Int,
    QMetaType::Int,
    0x80000000 | 138, QMetaType::Int,  139,
    0x80000000 | 138, QMetaType::Int,  139,
    QMetaType::QString, QMetaType::Int,  139,
    QMetaType::Float, QMetaType::Int,  139,
    QMetaType::Void, QMetaType::QString, QMetaType::Float,  144,  145,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,  110,  111,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,  155,
    0x80000000 | 138,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int, QMetaType::QString,   53,
    QMetaType::QString, QMetaType::Int,   35,
    QMetaType::QString, QMetaType::Int,   35,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   35,
    QMetaType::Int, QMetaType::Int,   35,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   35,  170,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   35,  170,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Int, QMetaType::QString,   16,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  110,  111,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  177,  110,  111,
    QMetaType::Int, QMetaType::QString,   16,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  110,  111,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,  110,  111,
    QMetaType::Void, QMetaType::Int,   35,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int, QMetaType::QString,   53,
    QMetaType::Void, QMetaType::QString,   53,
    QMetaType::Void, QMetaType::QString,   53,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   35,  170,  110,  111,
    QMetaType::Void, QMetaType::Int,   35,
    QMetaType::Void, QMetaType::QString,   16,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::Float,   53,   16,  110,  111,  112,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Float,  191,  110,  111,  112,
    QMetaType::Int,
    QMetaType::Int, QMetaType::Int,   35,
    QMetaType::QString, QMetaType::Int,   35,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   35,  170,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   35,  170,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   35,  197,  198,  199,  200,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,  202,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  110,  111,
    QMetaType::Bool, QMetaType::QString,   85,
    QMetaType::Bool, QMetaType::QString,   85,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,  208,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   38,   41,
    QMetaType::Void,
    0x80000000 | 138,
    QMetaType::Void, QMetaType::QString,  213,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,  110,  111,  112,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    0x80000000 | 223,
    QMetaType::Void, QMetaType::Float,  110,
    QMetaType::Void, QMetaType::Float,  226,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,   16,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Int,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float,
    0x80000000 | 138,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,  104,
    QMetaType::Void, QMetaType::QString,  104,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Float, QMetaType::Float, QMetaType::Float,   53,  260,  110,  111,  112,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   35,
    QMetaType::QString, QMetaType::Int,   35,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Float, QMetaType::Int,   35,
    QMetaType::Void, QMetaType::Int,   35,
    QMetaType::Void, QMetaType::Int,   35,
    QMetaType::Void, QMetaType::Int,   35,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   94,
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
        case 8: _t->usb_detect(); break;
        case 9: _t->programExit(); break;
        case 10: _t->programHide(); break;
        case 11: _t->writelog((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 12: { QString _r = _t->getRawMapPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 13: { QString _r = _t->getMapPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 14: { QString _r = _t->getAnnotPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 15: { QString _r = _t->getMetaPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 16: { QString _r = _t->getIniPath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 17: _t->setSetting((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 18: _t->readSetting((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 19: _t->readSetting(); break;
        case 20: { QString _r = _t->getSetting((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 21: _t->setVelocity((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 22: { float _r = _t->getVelocity();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 23: { bool _r = _t->getuseTravelline();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 24: _t->setuseTravelline((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 25: { int _r = _t->getnumTravelline();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 26: _t->setnumTravelline((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 27: { int _r = _t->getTrayNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 28: _t->setTrayNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 29: { int _r = _t->getTableNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 30: _t->setTableNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 31: { int _r = _t->getTableColNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 32: _t->setTableColNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 33: { bool _r = _t->getuseVoice();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 34: _t->setuseVoice((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 35: { bool _r = _t->getuseBGM();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 36: _t->setuseBGM((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 37: { bool _r = _t->getserverCMD();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 38: _t->setserverCMD((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 39: { QString _r = _t->getRobotType();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 40: _t->setRobotType((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 41: _t->setDebugName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 42: { QString _r = _t->getDebugName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 43: { bool _r = _t->getDebugState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 44: _t->setDebugState((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 45: _t->requestCamera(); break;
        case 46: { QString _r = _t->getLeftCamera();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 47: { QString _r = _t->getRightCamera();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 48: _t->setCamera((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 49: { int _r = _t->getCameraNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 50: { QList<int> _r = _t->getCamera((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 51: { QString _r = _t->getCameraSerial((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 52: { bool _r = _t->isConnectServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 53: { bool _r = _t->isExistMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 54: { bool _r = _t->isExistRawMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 55: { bool _r = _t->isExistMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 56: { int _r = _t->getAvailableMap();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 57: { QString _r = _t->getAvailableMapPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 58: { int _r = _t->getMapFileSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 59: { QString _r = _t->getMapFile((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 60: { bool _r = _t->isExistAnnotation((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 61: _t->deleteAnnotation(); break;
        case 62: { bool _r = _t->loadMaptoServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 63: { bool _r = _t->isUSBFile();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 64: { QString _r = _t->getUSBFilename();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 65: { bool _r = _t->loadMaptoUSB();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 66: { bool _r = _t->isuseServerMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 67: _t->setuseServerMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 68: _t->removeMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 69: { bool _r = _t->isloadMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 70: _t->setloadMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 71: { bool _r = _t->isExistRobotINI();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 72: _t->makeRobotINI(); break;
        case 73: { bool _r = _t->rotate_map((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 74: { bool _r = _t->getLCMConnection();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 75: { bool _r = _t->getLCMRX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 76: { bool _r = _t->getLCMTX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 77: { bool _r = _t->getLCMProcess();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 78: { bool _r = _t->getIniRead();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 79: { int _r = _t->getUsbMapSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 80: { QString _r = _t->getUsbMapPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 81: { QString _r = _t->getUsbMapPathFull((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 82: _t->saveMapfromUsb((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 83: _t->setMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 84: _t->startMapping(); break;
        case 85: _t->stopMapping(); break;
        case 86: _t->setSLAMMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 87: _t->setInitPos((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 88: { float _r = _t->getInitPoseX();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 89: { float _r = _t->getInitPoseY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 90: { float _r = _t->getInitPoseTH();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 91: _t->slam_setInit(); break;
        case 92: _t->slam_run(); break;
        case 93: _t->slam_stop(); break;
        case 94: _t->slam_autoInit(); break;
        case 95: { bool _r = _t->is_slam_running();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 96: { bool _r = _t->getMappingflag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 97: _t->setMappingflag((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 98: { QList<int> _r = _t->getMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 99: { QList<int> _r = _t->getRawMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 100: { QList<int> _r = _t->getMiniMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 101: { QList<int> _r = _t->getMapping();
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 102: _t->pushMapData((*reinterpret_cast< QList<int>(*)>(_a[1]))); break;
        case 103: { bool _r = _t->isconnectJoy();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 104: { float _r = _t->getJoyAxis((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 105: { int _r = _t->getJoyButton((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 106: { QString _r = _t->getKeyboard((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 107: { QString _r = _t->getJoystick((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 108: { int _r = _t->getCanvasSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 109: { int _r = _t->getRedoSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 110: { QVector<int> _r = _t->getLineX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 111: { QVector<int> _r = _t->getLineY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 112: { QString _r = _t->getLineColor((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 113: { float _r = _t->getLineWidth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 114: _t->startLine((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 115: _t->setLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 116: _t->stopLine(); break;
        case 117: _t->undo(); break;
        case 118: _t->redo(); break;
        case 119: _t->clear_all(); break;
        case 120: _t->setObjPose(); break;
        case 121: _t->setMarginObj(); break;
        case 122: _t->clearMarginObj(); break;
        case 123: _t->setMarginPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 124: { QVector<int> _r = _t->getMarginObj();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 125: { float _r = _t->getMargin();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 126: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 127: { int _r = _t->getLocationSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 128: { QString _r = _t->getLocationName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 129: { QString _r = _t->getLocationTypes((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 130: { float _r = _t->getLocationx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 131: { float _r = _t->getLocationy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 132: { float _r = _t->getLocationth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 133: { float _r = _t->getLidar((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 134: { int _r = _t->getObjectNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 135: { QString _r = _t->getObjectName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 136: { int _r = _t->getObjectPointSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 137: { float _r = _t->getObjectX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 138: { float _r = _t->getObjectY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 139: { int _r = _t->getTempObjectSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 140: { float _r = _t->getTempObjectX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 141: { float _r = _t->getTempObjectY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 142: { int _r = _t->getObjNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 143: { int _r = _t->getObjNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 144: { int _r = _t->getObjPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 145: { int _r = _t->getLocNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 146: { int _r = _t->getLocNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 147: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 148: _t->removeObjectPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 149: _t->removeObjectPointLast(); break;
        case 150: _t->clearObjectPoints(); break;
        case 151: { int _r = _t->getObjectSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 152: _t->addObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 153: _t->addObjectRect((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 154: _t->editObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4]))); break;
        case 155: _t->removeObject((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 156: _t->removeLocation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 157: _t->addLocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< float(*)>(_a[5]))); break;
        case 158: _t->moveLocationPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 159: { int _r = _t->getTlineSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 160: { int _r = _t->getTlineSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 161: { QString _r = _t->getTlineName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 162: { float _r = _t->getTlineX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 163: { float _r = _t->getTlineY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 164: _t->addTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< int(*)>(_a[5]))); break;
        case 165: _t->removeTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 166: { int _r = _t->getTlineNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 167: { bool _r = _t->saveAnnotation((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 168: { bool _r = _t->saveMetaData((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 169: _t->sendMaptoServer(); break;
        case 170: _t->acceptCall((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 171: _t->setTray((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 172: _t->confirmPickup(); break;
        case 173: { QVector<int> _r = _t->getPickuptrays();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 174: _t->moveTo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 175: _t->moveTo((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 176: _t->movePause(); break;
        case 177: _t->moveResume(); break;
        case 178: _t->moveStop(); break;
        case 179: _t->moveManual(); break;
        case 180: _t->moveToCharge(); break;
        case 181: _t->moveToWait(); break;
        case 182: { QString _r = _t->getcurLoc();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 183: { QString _r = _t->getcurTable();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 184: { QVector<float> _r = _t->getcurTarget();
            if (_a[0]) *reinterpret_cast< QVector<float>*>(_a[0]) = std::move(_r); }  break;
        case 185: _t->joyMoveXY((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 186: _t->joyMoveR((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 187: { float _r = _t->getJoyXY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 188: { float _r = _t->getJoyR();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 189: { float _r = _t->getBattery();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 190: { int _r = _t->getState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 191: { int _r = _t->getErrcode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 192: { QString _r = _t->getRobotName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 193: _t->setRobotName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 194: { float _r = _t->getRobotRadius();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 195: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 196: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 197: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 198: { int _r = _t->getRobotState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 199: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 200: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 201: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 202: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 203: { int _r = _t->getLocalPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 204: { float _r = _t->getLocalPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 205: { float _r = _t->getLocalPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 206: { int _r = _t->getuistate();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 207: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 208: { QString _r = _t->getMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 209: { QString _r = _t->getServerMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 210: { QString _r = _t->getServerMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 211: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 212: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 213: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 214: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 215: { QString _r = _t->getPatrolFileName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 216: _t->makePatrol(); break;
        case 217: _t->loadPatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 218: _t->savePatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 219: _t->addPatrol((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4])),(*reinterpret_cast< float(*)>(_a[5]))); break;
        case 220: { int _r = _t->getPatrolNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 221: { QString _r = _t->getPatrolType((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 222: { QString _r = _t->getPatrolLocation((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 223: { float _r = _t->getPatrolX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 224: { float _r = _t->getPatrolY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 225: { float _r = _t->getPatrolTH((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 226: _t->removePatrol((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 227: _t->movePatrolUp((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 228: _t->movePatrolDown((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 229: { int _r = _t->getPatrolMode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 230: _t->setPatrolMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 231: _t->startRecordPath(); break;
        case 232: _t->startcurPath(); break;
        case 233: _t->stopcurPath(); break;
        case 234: _t->pausecurPath(); break;
        case 235: _t->runRotateTables(); break;
        case 236: _t->stopRotateTables(); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 102:
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
        if (_id < 237)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 237;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 237)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 237;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
