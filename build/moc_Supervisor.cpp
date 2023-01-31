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
    QByteArrayData data[294];
    char stringdata0[3461];
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
QT_MOC_LITERAL(11, 155, 14), // "mapping_update"
QT_MOC_LITERAL(12, 170, 10), // "usb_detect"
QT_MOC_LITERAL(13, 181, 16), // "git_pull_success"
QT_MOC_LITERAL(14, 198, 11), // "programExit"
QT_MOC_LITERAL(15, 210, 11), // "programHide"
QT_MOC_LITERAL(16, 222, 8), // "writelog"
QT_MOC_LITERAL(17, 231, 3), // "msg"
QT_MOC_LITERAL(18, 235, 13), // "getRawMapPath"
QT_MOC_LITERAL(19, 249, 4), // "name"
QT_MOC_LITERAL(20, 254, 10), // "getMapPath"
QT_MOC_LITERAL(21, 265, 12), // "getAnnotPath"
QT_MOC_LITERAL(22, 278, 11), // "getMetaPath"
QT_MOC_LITERAL(23, 290, 10), // "getIniPath"
QT_MOC_LITERAL(24, 301, 10), // "setSetting"
QT_MOC_LITERAL(25, 312, 5), // "value"
QT_MOC_LITERAL(26, 318, 11), // "readSetting"
QT_MOC_LITERAL(27, 330, 8), // "map_name"
QT_MOC_LITERAL(28, 339, 10), // "getSetting"
QT_MOC_LITERAL(29, 350, 5), // "group"
QT_MOC_LITERAL(30, 356, 11), // "setVelocity"
QT_MOC_LITERAL(31, 368, 3), // "vel"
QT_MOC_LITERAL(32, 372, 11), // "getVelocity"
QT_MOC_LITERAL(33, 384, 16), // "getuseTravelline"
QT_MOC_LITERAL(34, 401, 16), // "setuseTravelline"
QT_MOC_LITERAL(35, 418, 3), // "use"
QT_MOC_LITERAL(36, 422, 16), // "getnumTravelline"
QT_MOC_LITERAL(37, 439, 16), // "setnumTravelline"
QT_MOC_LITERAL(38, 456, 3), // "num"
QT_MOC_LITERAL(39, 460, 10), // "getTrayNum"
QT_MOC_LITERAL(40, 471, 10), // "setTrayNum"
QT_MOC_LITERAL(41, 482, 8), // "tray_num"
QT_MOC_LITERAL(42, 491, 11), // "getTableNum"
QT_MOC_LITERAL(43, 503, 11), // "setTableNum"
QT_MOC_LITERAL(44, 515, 9), // "table_num"
QT_MOC_LITERAL(45, 525, 14), // "getTableColNum"
QT_MOC_LITERAL(46, 540, 14), // "setTableColNum"
QT_MOC_LITERAL(47, 555, 7), // "col_num"
QT_MOC_LITERAL(48, 563, 11), // "getuseVoice"
QT_MOC_LITERAL(49, 575, 11), // "setuseVoice"
QT_MOC_LITERAL(50, 587, 9), // "getuseBGM"
QT_MOC_LITERAL(51, 597, 9), // "setuseBGM"
QT_MOC_LITERAL(52, 607, 12), // "getserverCMD"
QT_MOC_LITERAL(53, 620, 12), // "setserverCMD"
QT_MOC_LITERAL(54, 633, 12), // "getRobotType"
QT_MOC_LITERAL(55, 646, 12), // "setRobotType"
QT_MOC_LITERAL(56, 659, 4), // "type"
QT_MOC_LITERAL(57, 664, 12), // "setDebugName"
QT_MOC_LITERAL(58, 677, 12), // "getDebugName"
QT_MOC_LITERAL(59, 690, 13), // "getDebugState"
QT_MOC_LITERAL(60, 704, 13), // "setDebugState"
QT_MOC_LITERAL(61, 718, 7), // "isdebug"
QT_MOC_LITERAL(62, 726, 13), // "requestCamera"
QT_MOC_LITERAL(63, 740, 13), // "getLeftCamera"
QT_MOC_LITERAL(64, 754, 14), // "getRightCamera"
QT_MOC_LITERAL(65, 769, 9), // "setCamera"
QT_MOC_LITERAL(66, 779, 4), // "left"
QT_MOC_LITERAL(67, 784, 5), // "right"
QT_MOC_LITERAL(68, 790, 12), // "getCameraNum"
QT_MOC_LITERAL(69, 803, 9), // "getCamera"
QT_MOC_LITERAL(70, 813, 10), // "QList<int>"
QT_MOC_LITERAL(71, 824, 15), // "getCameraSerial"
QT_MOC_LITERAL(72, 840, 7), // "pullGit"
QT_MOC_LITERAL(73, 848, 12), // "isNewVersion"
QT_MOC_LITERAL(74, 861, 15), // "getLocalVersion"
QT_MOC_LITERAL(75, 877, 16), // "getServerVersion"
QT_MOC_LITERAL(76, 894, 15), // "isConnectServer"
QT_MOC_LITERAL(77, 910, 10), // "isExistMap"
QT_MOC_LITERAL(78, 921, 13), // "isExistRawMap"
QT_MOC_LITERAL(79, 935, 15), // "getAvailableMap"
QT_MOC_LITERAL(80, 951, 19), // "getAvailableMapPath"
QT_MOC_LITERAL(81, 971, 14), // "getMapFileSize"
QT_MOC_LITERAL(82, 986, 10), // "getMapFile"
QT_MOC_LITERAL(83, 997, 17), // "isExistAnnotation"
QT_MOC_LITERAL(84, 1015, 16), // "deleteAnnotation"
QT_MOC_LITERAL(85, 1032, 15), // "loadMaptoServer"
QT_MOC_LITERAL(86, 1048, 9), // "isUSBFile"
QT_MOC_LITERAL(87, 1058, 14), // "getUSBFilename"
QT_MOC_LITERAL(88, 1073, 12), // "loadMaptoUSB"
QT_MOC_LITERAL(89, 1086, 14), // "isuseServerMap"
QT_MOC_LITERAL(90, 1101, 15), // "setuseServerMap"
QT_MOC_LITERAL(91, 1117, 9), // "removeMap"
QT_MOC_LITERAL(92, 1127, 8), // "filename"
QT_MOC_LITERAL(93, 1136, 9), // "isloadMap"
QT_MOC_LITERAL(94, 1146, 10), // "setloadMap"
QT_MOC_LITERAL(95, 1157, 4), // "load"
QT_MOC_LITERAL(96, 1162, 15), // "isExistRobotINI"
QT_MOC_LITERAL(97, 1178, 12), // "makeRobotINI"
QT_MOC_LITERAL(98, 1191, 10), // "rotate_map"
QT_MOC_LITERAL(99, 1202, 4), // "_src"
QT_MOC_LITERAL(100, 1207, 4), // "_dst"
QT_MOC_LITERAL(101, 1212, 4), // "mode"
QT_MOC_LITERAL(102, 1217, 16), // "getLCMConnection"
QT_MOC_LITERAL(103, 1234, 8), // "getLCMRX"
QT_MOC_LITERAL(104, 1243, 8), // "getLCMTX"
QT_MOC_LITERAL(105, 1252, 13), // "getLCMProcess"
QT_MOC_LITERAL(106, 1266, 10), // "getIniRead"
QT_MOC_LITERAL(107, 1277, 13), // "getUsbMapSize"
QT_MOC_LITERAL(108, 1291, 13), // "getUsbMapPath"
QT_MOC_LITERAL(109, 1305, 17), // "getUsbMapPathFull"
QT_MOC_LITERAL(110, 1323, 14), // "saveMapfromUsb"
QT_MOC_LITERAL(111, 1338, 4), // "path"
QT_MOC_LITERAL(112, 1343, 6), // "setMap"
QT_MOC_LITERAL(113, 1350, 12), // "startMapping"
QT_MOC_LITERAL(114, 1363, 4), // "grid"
QT_MOC_LITERAL(115, 1368, 11), // "stopMapping"
QT_MOC_LITERAL(116, 1380, 11), // "setSLAMMode"
QT_MOC_LITERAL(117, 1392, 11), // "saveMapping"
QT_MOC_LITERAL(118, 1404, 10), // "setInitPos"
QT_MOC_LITERAL(119, 1415, 1), // "x"
QT_MOC_LITERAL(120, 1417, 1), // "y"
QT_MOC_LITERAL(121, 1419, 2), // "th"
QT_MOC_LITERAL(122, 1422, 12), // "getInitPoseX"
QT_MOC_LITERAL(123, 1435, 12), // "getInitPoseY"
QT_MOC_LITERAL(124, 1448, 13), // "getInitPoseTH"
QT_MOC_LITERAL(125, 1462, 12), // "slam_setInit"
QT_MOC_LITERAL(126, 1475, 8), // "slam_run"
QT_MOC_LITERAL(127, 1484, 9), // "slam_stop"
QT_MOC_LITERAL(128, 1494, 13), // "slam_autoInit"
QT_MOC_LITERAL(129, 1508, 15), // "is_slam_running"
QT_MOC_LITERAL(130, 1524, 14), // "getMappingflag"
QT_MOC_LITERAL(131, 1539, 14), // "setMappingflag"
QT_MOC_LITERAL(132, 1554, 4), // "flag"
QT_MOC_LITERAL(133, 1559, 15), // "getMappingImage"
QT_MOC_LITERAL(134, 1575, 10), // "getListMap"
QT_MOC_LITERAL(135, 1586, 13), // "getRawListMap"
QT_MOC_LITERAL(136, 1600, 11), // "pushMapData"
QT_MOC_LITERAL(137, 1612, 4), // "data"
QT_MOC_LITERAL(138, 1617, 12), // "isconnectJoy"
QT_MOC_LITERAL(139, 1630, 10), // "getJoyAxis"
QT_MOC_LITERAL(140, 1641, 12), // "getJoyButton"
QT_MOC_LITERAL(141, 1654, 11), // "getKeyboard"
QT_MOC_LITERAL(142, 1666, 11), // "getJoystick"
QT_MOC_LITERAL(143, 1678, 14), // "setRotateAngle"
QT_MOC_LITERAL(144, 1693, 5), // "angle"
QT_MOC_LITERAL(145, 1699, 13), // "getCanvasSize"
QT_MOC_LITERAL(146, 1713, 11), // "getRedoSize"
QT_MOC_LITERAL(147, 1725, 8), // "getLineX"
QT_MOC_LITERAL(148, 1734, 12), // "QVector<int>"
QT_MOC_LITERAL(149, 1747, 5), // "index"
QT_MOC_LITERAL(150, 1753, 8), // "getLineY"
QT_MOC_LITERAL(151, 1762, 12), // "getLineColor"
QT_MOC_LITERAL(152, 1775, 12), // "getLineWidth"
QT_MOC_LITERAL(153, 1788, 9), // "startLine"
QT_MOC_LITERAL(154, 1798, 5), // "color"
QT_MOC_LITERAL(155, 1804, 5), // "width"
QT_MOC_LITERAL(156, 1810, 7), // "setLine"
QT_MOC_LITERAL(157, 1818, 8), // "stopLine"
QT_MOC_LITERAL(158, 1827, 4), // "undo"
QT_MOC_LITERAL(159, 1832, 4), // "redo"
QT_MOC_LITERAL(160, 1837, 9), // "clear_all"
QT_MOC_LITERAL(161, 1847, 10), // "setObjPose"
QT_MOC_LITERAL(162, 1858, 12), // "setMarginObj"
QT_MOC_LITERAL(163, 1871, 14), // "clearMarginObj"
QT_MOC_LITERAL(164, 1886, 14), // "setMarginPoint"
QT_MOC_LITERAL(165, 1901, 9), // "pixel_num"
QT_MOC_LITERAL(166, 1911, 12), // "getMarginObj"
QT_MOC_LITERAL(167, 1924, 9), // "getMargin"
QT_MOC_LITERAL(168, 1934, 14), // "getLocationNum"
QT_MOC_LITERAL(169, 1949, 15), // "getLocationSize"
QT_MOC_LITERAL(170, 1965, 15), // "getLocationName"
QT_MOC_LITERAL(171, 1981, 16), // "getLocationTypes"
QT_MOC_LITERAL(172, 1998, 12), // "getLocationx"
QT_MOC_LITERAL(173, 2011, 12), // "getLocationy"
QT_MOC_LITERAL(174, 2024, 13), // "getLocationth"
QT_MOC_LITERAL(175, 2038, 8), // "getLidar"
QT_MOC_LITERAL(176, 2047, 12), // "getObjectNum"
QT_MOC_LITERAL(177, 2060, 13), // "getObjectName"
QT_MOC_LITERAL(178, 2074, 18), // "getObjectPointSize"
QT_MOC_LITERAL(179, 2093, 10), // "getObjectX"
QT_MOC_LITERAL(180, 2104, 5), // "point"
QT_MOC_LITERAL(181, 2110, 10), // "getObjectY"
QT_MOC_LITERAL(182, 2121, 17), // "getTempObjectSize"
QT_MOC_LITERAL(183, 2139, 14), // "getTempObjectX"
QT_MOC_LITERAL(184, 2154, 14), // "getTempObjectY"
QT_MOC_LITERAL(185, 2169, 9), // "getObjNum"
QT_MOC_LITERAL(186, 2179, 14), // "getObjPointNum"
QT_MOC_LITERAL(187, 2194, 7), // "obj_num"
QT_MOC_LITERAL(188, 2202, 9), // "getLocNum"
QT_MOC_LITERAL(189, 2212, 14), // "addObjectPoint"
QT_MOC_LITERAL(190, 2227, 17), // "removeObjectPoint"
QT_MOC_LITERAL(191, 2245, 21), // "removeObjectPointLast"
QT_MOC_LITERAL(192, 2267, 17), // "clearObjectPoints"
QT_MOC_LITERAL(193, 2285, 13), // "getObjectSize"
QT_MOC_LITERAL(194, 2299, 9), // "addObject"
QT_MOC_LITERAL(195, 2309, 13), // "addObjectRect"
QT_MOC_LITERAL(196, 2323, 10), // "editObject"
QT_MOC_LITERAL(197, 2334, 12), // "removeObject"
QT_MOC_LITERAL(198, 2347, 14), // "removeLocation"
QT_MOC_LITERAL(199, 2362, 11), // "addLocation"
QT_MOC_LITERAL(200, 2374, 17), // "moveLocationPoint"
QT_MOC_LITERAL(201, 2392, 7), // "loc_num"
QT_MOC_LITERAL(202, 2400, 12), // "getTlineSize"
QT_MOC_LITERAL(203, 2413, 12), // "getTlineName"
QT_MOC_LITERAL(204, 2426, 9), // "getTlineX"
QT_MOC_LITERAL(205, 2436, 9), // "getTlineY"
QT_MOC_LITERAL(206, 2446, 8), // "addTline"
QT_MOC_LITERAL(207, 2455, 2), // "x1"
QT_MOC_LITERAL(208, 2458, 2), // "y1"
QT_MOC_LITERAL(209, 2461, 2), // "x2"
QT_MOC_LITERAL(210, 2464, 2), // "y2"
QT_MOC_LITERAL(211, 2467, 11), // "removeTline"
QT_MOC_LITERAL(212, 2479, 4), // "line"
QT_MOC_LITERAL(213, 2484, 11), // "getTlineNum"
QT_MOC_LITERAL(214, 2496, 14), // "saveAnnotation"
QT_MOC_LITERAL(215, 2511, 12), // "saveMetaData"
QT_MOC_LITERAL(216, 2524, 15), // "sendMaptoServer"
QT_MOC_LITERAL(217, 2540, 10), // "acceptCall"
QT_MOC_LITERAL(218, 2551, 3), // "yes"
QT_MOC_LITERAL(219, 2555, 7), // "setTray"
QT_MOC_LITERAL(220, 2563, 13), // "confirmPickup"
QT_MOC_LITERAL(221, 2577, 14), // "getPickuptrays"
QT_MOC_LITERAL(222, 2592, 6), // "moveTo"
QT_MOC_LITERAL(223, 2599, 10), // "target_num"
QT_MOC_LITERAL(224, 2610, 9), // "movePause"
QT_MOC_LITERAL(225, 2620, 10), // "moveResume"
QT_MOC_LITERAL(226, 2631, 8), // "moveStop"
QT_MOC_LITERAL(227, 2640, 10), // "moveManual"
QT_MOC_LITERAL(228, 2651, 12), // "moveToCharge"
QT_MOC_LITERAL(229, 2664, 10), // "moveToWait"
QT_MOC_LITERAL(230, 2675, 9), // "getcurLoc"
QT_MOC_LITERAL(231, 2685, 11), // "getcurTable"
QT_MOC_LITERAL(232, 2697, 12), // "getcurTarget"
QT_MOC_LITERAL(233, 2710, 14), // "QVector<float>"
QT_MOC_LITERAL(234, 2725, 9), // "joyMoveXY"
QT_MOC_LITERAL(235, 2735, 8), // "joyMoveR"
QT_MOC_LITERAL(236, 2744, 1), // "r"
QT_MOC_LITERAL(237, 2746, 8), // "getJoyXY"
QT_MOC_LITERAL(238, 2755, 7), // "getJoyR"
QT_MOC_LITERAL(239, 2763, 10), // "getBattery"
QT_MOC_LITERAL(240, 2774, 8), // "getState"
QT_MOC_LITERAL(241, 2783, 10), // "getErrcode"
QT_MOC_LITERAL(242, 2794, 12), // "getRobotName"
QT_MOC_LITERAL(243, 2807, 14), // "getRobotRadius"
QT_MOC_LITERAL(244, 2822, 9), // "getRobotx"
QT_MOC_LITERAL(245, 2832, 9), // "getRoboty"
QT_MOC_LITERAL(246, 2842, 10), // "getRobotth"
QT_MOC_LITERAL(247, 2853, 13), // "getRobotState"
QT_MOC_LITERAL(248, 2867, 10), // "getPathNum"
QT_MOC_LITERAL(249, 2878, 8), // "getPathx"
QT_MOC_LITERAL(250, 2887, 8), // "getPathy"
QT_MOC_LITERAL(251, 2896, 9), // "getPathth"
QT_MOC_LITERAL(252, 2906, 15), // "getLocalPathNum"
QT_MOC_LITERAL(253, 2922, 13), // "getLocalPathx"
QT_MOC_LITERAL(254, 2936, 13), // "getLocalPathy"
QT_MOC_LITERAL(255, 2950, 10), // "getuistate"
QT_MOC_LITERAL(256, 2961, 10), // "getMapname"
QT_MOC_LITERAL(257, 2972, 10), // "getMappath"
QT_MOC_LITERAL(258, 2983, 16), // "getServerMapname"
QT_MOC_LITERAL(259, 3000, 16), // "getServerMappath"
QT_MOC_LITERAL(260, 3017, 11), // "getMapWidth"
QT_MOC_LITERAL(261, 3029, 12), // "getMapHeight"
QT_MOC_LITERAL(262, 3042, 12), // "getGridWidth"
QT_MOC_LITERAL(263, 3055, 9), // "getOrigin"
QT_MOC_LITERAL(264, 3065, 10), // "getMapData"
QT_MOC_LITERAL(265, 3076, 10), // "getMapping"
QT_MOC_LITERAL(266, 3087, 10), // "getMinimap"
QT_MOC_LITERAL(267, 3098, 6), // "getMap"
QT_MOC_LITERAL(268, 3105, 9), // "getRawMap"
QT_MOC_LITERAL(269, 3115, 17), // "getPatrolFileName"
QT_MOC_LITERAL(270, 3133, 10), // "makePatrol"
QT_MOC_LITERAL(271, 3144, 14), // "loadPatrolFile"
QT_MOC_LITERAL(272, 3159, 14), // "savePatrolFile"
QT_MOC_LITERAL(273, 3174, 9), // "addPatrol"
QT_MOC_LITERAL(274, 3184, 8), // "location"
QT_MOC_LITERAL(275, 3193, 12), // "getPatrolNum"
QT_MOC_LITERAL(276, 3206, 13), // "getPatrolType"
QT_MOC_LITERAL(277, 3220, 17), // "getPatrolLocation"
QT_MOC_LITERAL(278, 3238, 10), // "getPatrolX"
QT_MOC_LITERAL(279, 3249, 10), // "getPatrolY"
QT_MOC_LITERAL(280, 3260, 11), // "getPatrolTH"
QT_MOC_LITERAL(281, 3272, 12), // "removePatrol"
QT_MOC_LITERAL(282, 3285, 12), // "movePatrolUp"
QT_MOC_LITERAL(283, 3298, 14), // "movePatrolDown"
QT_MOC_LITERAL(284, 3313, 13), // "getPatrolMode"
QT_MOC_LITERAL(285, 3327, 13), // "setPatrolMode"
QT_MOC_LITERAL(286, 3341, 15), // "startRecordPath"
QT_MOC_LITERAL(287, 3357, 12), // "startcurPath"
QT_MOC_LITERAL(288, 3370, 11), // "stopcurPath"
QT_MOC_LITERAL(289, 3382, 12), // "pausecurPath"
QT_MOC_LITERAL(290, 3395, 15), // "runRotateTables"
QT_MOC_LITERAL(291, 3411, 16), // "stopRotateTables"
QT_MOC_LITERAL(292, 3428, 16), // "startServingTest"
QT_MOC_LITERAL(293, 3445, 15) // "stopServingTest"

    },
    "Supervisor\0onTimer\0\0server_cmd_pause\0"
    "server_cmd_resume\0server_cmd_newtarget\0"
    "server_cmd_newcall\0server_cmd_setini\0"
    "server_get_map\0path_changed\0camera_update\0"
    "mapping_update\0usb_detect\0git_pull_success\0"
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
    "setMap\0startMapping\0grid\0stopMapping\0"
    "setSLAMMode\0saveMapping\0setInitPos\0x\0"
    "y\0th\0getInitPoseX\0getInitPoseY\0"
    "getInitPoseTH\0slam_setInit\0slam_run\0"
    "slam_stop\0slam_autoInit\0is_slam_running\0"
    "getMappingflag\0setMappingflag\0flag\0"
    "getMappingImage\0getListMap\0getRawListMap\0"
    "pushMapData\0data\0isconnectJoy\0getJoyAxis\0"
    "getJoyButton\0getKeyboard\0getJoystick\0"
    "setRotateAngle\0angle\0getCanvasSize\0"
    "getRedoSize\0getLineX\0QVector<int>\0"
    "index\0getLineY\0getLineColor\0getLineWidth\0"
    "startLine\0color\0width\0setLine\0stopLine\0"
    "undo\0redo\0clear_all\0setObjPose\0"
    "setMarginObj\0clearMarginObj\0setMarginPoint\0"
    "pixel_num\0getMarginObj\0getMargin\0"
    "getLocationNum\0getLocationSize\0"
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
    "getGridWidth\0getOrigin\0getMapData\0"
    "getMapping\0getMinimap\0getMap\0getRawMap\0"
    "getPatrolFileName\0makePatrol\0"
    "loadPatrolFile\0savePatrolFile\0addPatrol\0"
    "location\0getPatrolNum\0getPatrolType\0"
    "getPatrolLocation\0getPatrolX\0getPatrolY\0"
    "getPatrolTH\0removePatrol\0movePatrolUp\0"
    "movePatrolDown\0getPatrolMode\0setPatrolMode\0"
    "startRecordPath\0startcurPath\0stopcurPath\0"
    "pausecurPath\0runRotateTables\0"
    "stopRotateTables\0startServingTest\0"
    "stopServingTest"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Supervisor[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
     251,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0, 1269,    2, 0x0a /* Public */,
       3,    0, 1270,    2, 0x0a /* Public */,
       4,    0, 1271,    2, 0x0a /* Public */,
       5,    0, 1272,    2, 0x0a /* Public */,
       6,    0, 1273,    2, 0x0a /* Public */,
       7,    0, 1274,    2, 0x0a /* Public */,
       8,    0, 1275,    2, 0x0a /* Public */,
       9,    0, 1276,    2, 0x0a /* Public */,
      10,    0, 1277,    2, 0x0a /* Public */,
      11,    0, 1278,    2, 0x0a /* Public */,
      12,    0, 1279,    2, 0x0a /* Public */,
      13,    0, 1280,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      14,    0, 1281,    2, 0x02 /* Public */,
      15,    0, 1282,    2, 0x02 /* Public */,
      16,    1, 1283,    2, 0x02 /* Public */,
      18,    1, 1286,    2, 0x02 /* Public */,
      20,    1, 1289,    2, 0x02 /* Public */,
      21,    1, 1292,    2, 0x02 /* Public */,
      22,    1, 1295,    2, 0x02 /* Public */,
      23,    0, 1298,    2, 0x02 /* Public */,
      24,    2, 1299,    2, 0x02 /* Public */,
      26,    1, 1304,    2, 0x02 /* Public */,
      26,    0, 1307,    2, 0x22 /* Public | MethodCloned */,
      28,    2, 1308,    2, 0x02 /* Public */,
      30,    1, 1313,    2, 0x02 /* Public */,
      32,    0, 1316,    2, 0x02 /* Public */,
      33,    0, 1317,    2, 0x02 /* Public */,
      34,    1, 1318,    2, 0x02 /* Public */,
      36,    0, 1321,    2, 0x02 /* Public */,
      37,    1, 1322,    2, 0x02 /* Public */,
      39,    0, 1325,    2, 0x02 /* Public */,
      40,    1, 1326,    2, 0x02 /* Public */,
      42,    0, 1329,    2, 0x02 /* Public */,
      43,    1, 1330,    2, 0x02 /* Public */,
      45,    0, 1333,    2, 0x02 /* Public */,
      46,    1, 1334,    2, 0x02 /* Public */,
      48,    0, 1337,    2, 0x02 /* Public */,
      49,    1, 1338,    2, 0x02 /* Public */,
      50,    0, 1341,    2, 0x02 /* Public */,
      51,    1, 1342,    2, 0x02 /* Public */,
      52,    0, 1345,    2, 0x02 /* Public */,
      53,    1, 1346,    2, 0x02 /* Public */,
      54,    0, 1349,    2, 0x02 /* Public */,
      55,    1, 1350,    2, 0x02 /* Public */,
      57,    1, 1353,    2, 0x02 /* Public */,
      58,    0, 1356,    2, 0x02 /* Public */,
      59,    0, 1357,    2, 0x02 /* Public */,
      60,    1, 1358,    2, 0x02 /* Public */,
      62,    0, 1361,    2, 0x02 /* Public */,
      63,    0, 1362,    2, 0x02 /* Public */,
      64,    0, 1363,    2, 0x02 /* Public */,
      65,    2, 1364,    2, 0x02 /* Public */,
      68,    0, 1369,    2, 0x02 /* Public */,
      69,    1, 1370,    2, 0x02 /* Public */,
      71,    1, 1373,    2, 0x02 /* Public */,
      72,    0, 1376,    2, 0x02 /* Public */,
      73,    0, 1377,    2, 0x02 /* Public */,
      74,    0, 1378,    2, 0x02 /* Public */,
      75,    0, 1379,    2, 0x02 /* Public */,
      76,    0, 1380,    2, 0x02 /* Public */,
      77,    1, 1381,    2, 0x02 /* Public */,
      78,    1, 1384,    2, 0x02 /* Public */,
      77,    0, 1387,    2, 0x02 /* Public */,
      79,    0, 1388,    2, 0x02 /* Public */,
      80,    1, 1389,    2, 0x02 /* Public */,
      81,    1, 1392,    2, 0x02 /* Public */,
      82,    1, 1395,    2, 0x02 /* Public */,
      83,    1, 1398,    2, 0x02 /* Public */,
      84,    0, 1401,    2, 0x02 /* Public */,
      85,    0, 1402,    2, 0x02 /* Public */,
      86,    0, 1403,    2, 0x02 /* Public */,
      87,    0, 1404,    2, 0x02 /* Public */,
      88,    0, 1405,    2, 0x02 /* Public */,
      89,    0, 1406,    2, 0x02 /* Public */,
      90,    1, 1407,    2, 0x02 /* Public */,
      91,    1, 1410,    2, 0x02 /* Public */,
      93,    0, 1413,    2, 0x02 /* Public */,
      94,    1, 1414,    2, 0x02 /* Public */,
      96,    0, 1417,    2, 0x02 /* Public */,
      97,    0, 1418,    2, 0x02 /* Public */,
      98,    3, 1419,    2, 0x02 /* Public */,
     102,    0, 1426,    2, 0x02 /* Public */,
     103,    0, 1427,    2, 0x02 /* Public */,
     104,    0, 1428,    2, 0x02 /* Public */,
     105,    0, 1429,    2, 0x02 /* Public */,
     106,    0, 1430,    2, 0x02 /* Public */,
     107,    0, 1431,    2, 0x02 /* Public */,
     108,    1, 1432,    2, 0x02 /* Public */,
     109,    1, 1435,    2, 0x02 /* Public */,
     110,    1, 1438,    2, 0x02 /* Public */,
     112,    1, 1441,    2, 0x02 /* Public */,
     113,    1, 1444,    2, 0x02 /* Public */,
     115,    0, 1447,    2, 0x02 /* Public */,
     116,    1, 1448,    2, 0x02 /* Public */,
     117,    1, 1451,    2, 0x02 /* Public */,
     118,    3, 1454,    2, 0x02 /* Public */,
     122,    0, 1461,    2, 0x02 /* Public */,
     123,    0, 1462,    2, 0x02 /* Public */,
     124,    0, 1463,    2, 0x02 /* Public */,
     125,    0, 1464,    2, 0x02 /* Public */,
     126,    0, 1465,    2, 0x02 /* Public */,
     127,    0, 1466,    2, 0x02 /* Public */,
     128,    0, 1467,    2, 0x02 /* Public */,
     129,    0, 1468,    2, 0x02 /* Public */,
     130,    0, 1469,    2, 0x02 /* Public */,
     131,    1, 1470,    2, 0x02 /* Public */,
     133,    0, 1473,    2, 0x02 /* Public */,
     134,    1, 1474,    2, 0x02 /* Public */,
     135,    1, 1477,    2, 0x02 /* Public */,
     136,    1, 1480,    2, 0x02 /* Public */,
     138,    0, 1483,    2, 0x02 /* Public */,
     139,    1, 1484,    2, 0x02 /* Public */,
     140,    1, 1487,    2, 0x02 /* Public */,
     141,    1, 1490,    2, 0x02 /* Public */,
     142,    1, 1493,    2, 0x02 /* Public */,
     143,    1, 1496,    2, 0x02 /* Public */,
     145,    0, 1499,    2, 0x02 /* Public */,
     146,    0, 1500,    2, 0x02 /* Public */,
     147,    1, 1501,    2, 0x02 /* Public */,
     150,    1, 1504,    2, 0x02 /* Public */,
     151,    1, 1507,    2, 0x02 /* Public */,
     152,    1, 1510,    2, 0x02 /* Public */,
     153,    2, 1513,    2, 0x02 /* Public */,
     156,    2, 1518,    2, 0x02 /* Public */,
     157,    0, 1523,    2, 0x02 /* Public */,
     158,    0, 1524,    2, 0x02 /* Public */,
     159,    0, 1525,    2, 0x02 /* Public */,
     160,    0, 1526,    2, 0x02 /* Public */,
     161,    0, 1527,    2, 0x02 /* Public */,
     162,    0, 1528,    2, 0x02 /* Public */,
     163,    0, 1529,    2, 0x02 /* Public */,
     164,    1, 1530,    2, 0x02 /* Public */,
     166,    0, 1533,    2, 0x02 /* Public */,
     167,    0, 1534,    2, 0x02 /* Public */,
     168,    0, 1535,    2, 0x02 /* Public */,
     169,    1, 1536,    2, 0x02 /* Public */,
     170,    1, 1539,    2, 0x02 /* Public */,
     171,    1, 1542,    2, 0x02 /* Public */,
     172,    1, 1545,    2, 0x02 /* Public */,
     173,    1, 1548,    2, 0x02 /* Public */,
     174,    1, 1551,    2, 0x02 /* Public */,
     175,    1, 1554,    2, 0x02 /* Public */,
     176,    0, 1557,    2, 0x02 /* Public */,
     177,    1, 1558,    2, 0x02 /* Public */,
     178,    1, 1561,    2, 0x02 /* Public */,
     179,    2, 1564,    2, 0x02 /* Public */,
     181,    2, 1569,    2, 0x02 /* Public */,
     182,    0, 1574,    2, 0x02 /* Public */,
     183,    1, 1575,    2, 0x02 /* Public */,
     184,    1, 1578,    2, 0x02 /* Public */,
     185,    1, 1581,    2, 0x02 /* Public */,
     185,    2, 1584,    2, 0x02 /* Public */,
     186,    3, 1589,    2, 0x02 /* Public */,
     188,    1, 1596,    2, 0x02 /* Public */,
     188,    2, 1599,    2, 0x02 /* Public */,
     189,    2, 1604,    2, 0x02 /* Public */,
     190,    1, 1609,    2, 0x02 /* Public */,
     191,    0, 1612,    2, 0x02 /* Public */,
     192,    0, 1613,    2, 0x02 /* Public */,
     193,    1, 1614,    2, 0x02 /* Public */,
     194,    1, 1617,    2, 0x02 /* Public */,
     195,    1, 1620,    2, 0x02 /* Public */,
     196,    4, 1623,    2, 0x02 /* Public */,
     197,    1, 1632,    2, 0x02 /* Public */,
     198,    1, 1635,    2, 0x02 /* Public */,
     199,    5, 1638,    2, 0x02 /* Public */,
     200,    4, 1649,    2, 0x02 /* Public */,
     202,    0, 1658,    2, 0x02 /* Public */,
     202,    1, 1659,    2, 0x02 /* Public */,
     203,    1, 1662,    2, 0x02 /* Public */,
     204,    2, 1665,    2, 0x02 /* Public */,
     205,    2, 1670,    2, 0x02 /* Public */,
     206,    5, 1675,    2, 0x02 /* Public */,
     211,    2, 1686,    2, 0x02 /* Public */,
     213,    2, 1691,    2, 0x02 /* Public */,
     214,    1, 1696,    2, 0x02 /* Public */,
     215,    1, 1699,    2, 0x02 /* Public */,
     216,    0, 1702,    2, 0x02 /* Public */,
     217,    1, 1703,    2, 0x02 /* Public */,
     219,    2, 1706,    2, 0x02 /* Public */,
     220,    0, 1711,    2, 0x02 /* Public */,
     221,    0, 1712,    2, 0x02 /* Public */,
     222,    1, 1713,    2, 0x02 /* Public */,
     222,    3, 1716,    2, 0x02 /* Public */,
     224,    0, 1723,    2, 0x02 /* Public */,
     225,    0, 1724,    2, 0x02 /* Public */,
     226,    0, 1725,    2, 0x02 /* Public */,
     227,    0, 1726,    2, 0x02 /* Public */,
     228,    0, 1727,    2, 0x02 /* Public */,
     229,    0, 1728,    2, 0x02 /* Public */,
     230,    0, 1729,    2, 0x02 /* Public */,
     231,    0, 1730,    2, 0x02 /* Public */,
     232,    0, 1731,    2, 0x02 /* Public */,
     234,    1, 1732,    2, 0x02 /* Public */,
     235,    1, 1735,    2, 0x02 /* Public */,
     237,    0, 1738,    2, 0x02 /* Public */,
     238,    0, 1739,    2, 0x02 /* Public */,
     239,    0, 1740,    2, 0x02 /* Public */,
     240,    0, 1741,    2, 0x02 /* Public */,
     241,    0, 1742,    2, 0x02 /* Public */,
     242,    0, 1743,    2, 0x02 /* Public */,
     243,    0, 1744,    2, 0x02 /* Public */,
     244,    0, 1745,    2, 0x02 /* Public */,
     245,    0, 1746,    2, 0x02 /* Public */,
     246,    0, 1747,    2, 0x02 /* Public */,
     247,    0, 1748,    2, 0x02 /* Public */,
     248,    0, 1749,    2, 0x02 /* Public */,
     249,    1, 1750,    2, 0x02 /* Public */,
     250,    1, 1753,    2, 0x02 /* Public */,
     251,    1, 1756,    2, 0x02 /* Public */,
     252,    0, 1759,    2, 0x02 /* Public */,
     253,    1, 1760,    2, 0x02 /* Public */,
     254,    1, 1763,    2, 0x02 /* Public */,
     255,    0, 1766,    2, 0x02 /* Public */,
     256,    0, 1767,    2, 0x02 /* Public */,
     257,    0, 1768,    2, 0x02 /* Public */,
     258,    0, 1769,    2, 0x02 /* Public */,
     259,    0, 1770,    2, 0x02 /* Public */,
     260,    0, 1771,    2, 0x02 /* Public */,
     261,    0, 1772,    2, 0x02 /* Public */,
     262,    0, 1773,    2, 0x02 /* Public */,
     263,    0, 1774,    2, 0x02 /* Public */,
     264,    1, 1775,    2, 0x02 /* Public */,
     265,    0, 1778,    2, 0x02 /* Public */,
     266,    1, 1779,    2, 0x02 /* Public */,
     267,    1, 1782,    2, 0x02 /* Public */,
     268,    1, 1785,    2, 0x02 /* Public */,
     269,    0, 1788,    2, 0x02 /* Public */,
     270,    0, 1789,    2, 0x02 /* Public */,
     271,    1, 1790,    2, 0x02 /* Public */,
     272,    1, 1793,    2, 0x02 /* Public */,
     273,    5, 1796,    2, 0x02 /* Public */,
     275,    0, 1807,    2, 0x02 /* Public */,
     276,    1, 1808,    2, 0x02 /* Public */,
     277,    1, 1811,    2, 0x02 /* Public */,
     278,    1, 1814,    2, 0x02 /* Public */,
     279,    1, 1817,    2, 0x02 /* Public */,
     280,    1, 1820,    2, 0x02 /* Public */,
     281,    1, 1823,    2, 0x02 /* Public */,
     282,    1, 1826,    2, 0x02 /* Public */,
     283,    1, 1829,    2, 0x02 /* Public */,
     284,    0, 1832,    2, 0x02 /* Public */,
     285,    1, 1833,    2, 0x02 /* Public */,
     286,    0, 1836,    2, 0x02 /* Public */,
     287,    0, 1837,    2, 0x02 /* Public */,
     288,    0, 1838,    2, 0x02 /* Public */,
     289,    0, 1839,    2, 0x02 /* Public */,
     290,    0, 1840,    2, 0x02 /* Public */,
     291,    0, 1841,    2, 0x02 /* Public */,
     292,    0, 1842,    2, 0x02 /* Public */,
     293,    0, 1843,    2, 0x02 /* Public */,

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
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   17,
    QMetaType::QString, QMetaType::QString,   19,
    QMetaType::QString, QMetaType::QString,   19,
    QMetaType::QString, QMetaType::QString,   19,
    QMetaType::QString, QMetaType::QString,   19,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   19,   25,
    QMetaType::Void, QMetaType::QString,   27,
    QMetaType::Void,
    QMetaType::QString, QMetaType::QString, QMetaType::QString,   29,   19,
    QMetaType::Void, QMetaType::Float,   31,
    QMetaType::Float,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   35,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   38,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   41,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   44,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   47,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   35,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   35,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   35,
    QMetaType::QString,
    QMetaType::Void, QMetaType::Int,   56,
    QMetaType::Void, QMetaType::QString,   19,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   61,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   66,   67,
    QMetaType::Int,
    0x80000000 | 70, QMetaType::Int,   38,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool, QMetaType::QString,   19,
    QMetaType::Bool, QMetaType::QString,   19,
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::Int, QMetaType::QString,   19,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::Bool, QMetaType::QString,   19,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   35,
    QMetaType::Void, QMetaType::QString,   92,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   95,
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString, QMetaType::Int,   99,  100,  101,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::Void, QMetaType::QString,  111,
    QMetaType::Void, QMetaType::QString,   19,
    QMetaType::Void, QMetaType::Float,  114,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,  101,
    QMetaType::Void, QMetaType::QString,   19,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,  119,  120,  121,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  132,
    QMetaType::QPixmap,
    0x80000000 | 70, QMetaType::QString,   92,
    0x80000000 | 70, QMetaType::QString,   92,
    QMetaType::Void, 0x80000000 | 70,  137,
    QMetaType::Bool,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Int, QMetaType::Int,   38,
    QMetaType::QString, QMetaType::Int,  101,
    QMetaType::QString, QMetaType::Int,  101,
    QMetaType::Void, QMetaType::Float,  144,
    QMetaType::Int,
    QMetaType::Int,
    0x80000000 | 148, QMetaType::Int,  149,
    0x80000000 | 148, QMetaType::Int,  149,
    QMetaType::QString, QMetaType::Int,  149,
    QMetaType::Float, QMetaType::Int,  149,
    QMetaType::Void, QMetaType::QString, QMetaType::Float,  154,  155,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,  119,  120,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,  165,
    0x80000000 | 148,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int, QMetaType::QString,   56,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::Int, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   38,  180,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   38,  180,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Int, QMetaType::QString,   19,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  119,  120,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  187,  119,  120,
    QMetaType::Int, QMetaType::QString,   19,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  119,  120,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,  119,  120,
    QMetaType::Void, QMetaType::Int,   38,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int, QMetaType::QString,   56,
    QMetaType::Void, QMetaType::QString,   56,
    QMetaType::Void, QMetaType::QString,   56,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   38,  180,  119,  120,
    QMetaType::Void, QMetaType::Int,   38,
    QMetaType::Void, QMetaType::QString,   19,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::Float,   56,   19,  119,  120,  121,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Float,  201,  119,  120,  121,
    QMetaType::Int,
    QMetaType::Int, QMetaType::Int,   38,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   38,  180,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   38,  180,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   38,  207,  208,  209,  210,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   38,  212,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  119,  120,
    QMetaType::Bool, QMetaType::QString,   92,
    QMetaType::Bool, QMetaType::QString,   92,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,  218,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   41,   44,
    QMetaType::Void,
    0x80000000 | 148,
    QMetaType::Void, QMetaType::QString,  223,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,  119,  120,  121,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    0x80000000 | 233,
    QMetaType::Void, QMetaType::Float,  119,
    QMetaType::Void, QMetaType::Float,  236,
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
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Int,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float,
    0x80000000 | 148,
    0x80000000 | 70, QMetaType::QString,   92,
    QMetaType::QObjectStar,
    QMetaType::QObjectStar, QMetaType::QString,   92,
    QMetaType::QObjectStar, QMetaType::QString,   92,
    QMetaType::QObjectStar, QMetaType::QString,   92,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,  111,
    QMetaType::Void, QMetaType::QString,  111,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Float, QMetaType::Float, QMetaType::Float,   56,  274,  119,  120,  121,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Void, QMetaType::Int,   38,
    QMetaType::Void, QMetaType::Int,   38,
    QMetaType::Void, QMetaType::Int,   38,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,  101,
    QMetaType::Void,
    QMetaType::Void,
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
        case 9: _t->mapping_update(); break;
        case 10: _t->usb_detect(); break;
        case 11: _t->git_pull_success(); break;
        case 12: _t->programExit(); break;
        case 13: _t->programHide(); break;
        case 14: _t->writelog((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 15: { QString _r = _t->getRawMapPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 16: { QString _r = _t->getMapPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 17: { QString _r = _t->getAnnotPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 18: { QString _r = _t->getMetaPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 19: { QString _r = _t->getIniPath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 20: _t->setSetting((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 21: _t->readSetting((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 22: _t->readSetting(); break;
        case 23: { QString _r = _t->getSetting((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 24: _t->setVelocity((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 25: { float _r = _t->getVelocity();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 26: { bool _r = _t->getuseTravelline();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 27: _t->setuseTravelline((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 28: { int _r = _t->getnumTravelline();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 29: _t->setnumTravelline((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 30: { int _r = _t->getTrayNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 31: _t->setTrayNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 32: { int _r = _t->getTableNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 33: _t->setTableNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 34: { int _r = _t->getTableColNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 35: _t->setTableColNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 36: { bool _r = _t->getuseVoice();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 37: _t->setuseVoice((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 38: { bool _r = _t->getuseBGM();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 39: _t->setuseBGM((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 40: { bool _r = _t->getserverCMD();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 41: _t->setserverCMD((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 42: { QString _r = _t->getRobotType();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 43: _t->setRobotType((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 44: _t->setDebugName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 45: { QString _r = _t->getDebugName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 46: { bool _r = _t->getDebugState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 47: _t->setDebugState((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 48: _t->requestCamera(); break;
        case 49: { QString _r = _t->getLeftCamera();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 50: { QString _r = _t->getRightCamera();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 51: _t->setCamera((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 52: { int _r = _t->getCameraNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 53: { QList<int> _r = _t->getCamera((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 54: { QString _r = _t->getCameraSerial((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 55: _t->pullGit(); break;
        case 56: { bool _r = _t->isNewVersion();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 57: { QString _r = _t->getLocalVersion();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 58: { QString _r = _t->getServerVersion();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 59: { bool _r = _t->isConnectServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 60: { bool _r = _t->isExistMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 61: { bool _r = _t->isExistRawMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 62: { bool _r = _t->isExistMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 63: { int _r = _t->getAvailableMap();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 64: { QString _r = _t->getAvailableMapPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 65: { int _r = _t->getMapFileSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 66: { QString _r = _t->getMapFile((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 67: { bool _r = _t->isExistAnnotation((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 68: _t->deleteAnnotation(); break;
        case 69: { bool _r = _t->loadMaptoServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 70: { bool _r = _t->isUSBFile();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 71: { QString _r = _t->getUSBFilename();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 72: { bool _r = _t->loadMaptoUSB();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 73: { bool _r = _t->isuseServerMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 74: _t->setuseServerMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 75: _t->removeMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 76: { bool _r = _t->isloadMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 77: _t->setloadMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 78: { bool _r = _t->isExistRobotINI();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 79: _t->makeRobotINI(); break;
        case 80: { bool _r = _t->rotate_map((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 81: { bool _r = _t->getLCMConnection();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 82: { bool _r = _t->getLCMRX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 83: { bool _r = _t->getLCMTX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 84: { bool _r = _t->getLCMProcess();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 85: { bool _r = _t->getIniRead();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 86: { int _r = _t->getUsbMapSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 87: { QString _r = _t->getUsbMapPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 88: { QString _r = _t->getUsbMapPathFull((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 89: _t->saveMapfromUsb((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 90: _t->setMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 91: _t->startMapping((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 92: _t->stopMapping(); break;
        case 93: _t->setSLAMMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 94: _t->saveMapping((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 95: _t->setInitPos((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 96: { float _r = _t->getInitPoseX();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 97: { float _r = _t->getInitPoseY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 98: { float _r = _t->getInitPoseTH();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 99: _t->slam_setInit(); break;
        case 100: _t->slam_run(); break;
        case 101: _t->slam_stop(); break;
        case 102: _t->slam_autoInit(); break;
        case 103: { bool _r = _t->is_slam_running();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 104: { bool _r = _t->getMappingflag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 105: _t->setMappingflag((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 106: { QPixmap _r = _t->getMappingImage();
            if (_a[0]) *reinterpret_cast< QPixmap*>(_a[0]) = std::move(_r); }  break;
        case 107: { QList<int> _r = _t->getListMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 108: { QList<int> _r = _t->getRawListMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 109: _t->pushMapData((*reinterpret_cast< QList<int>(*)>(_a[1]))); break;
        case 110: { bool _r = _t->isconnectJoy();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 111: { float _r = _t->getJoyAxis((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 112: { int _r = _t->getJoyButton((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 113: { QString _r = _t->getKeyboard((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 114: { QString _r = _t->getJoystick((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 115: _t->setRotateAngle((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 116: { int _r = _t->getCanvasSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 117: { int _r = _t->getRedoSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 118: { QVector<int> _r = _t->getLineX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 119: { QVector<int> _r = _t->getLineY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 120: { QString _r = _t->getLineColor((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 121: { float _r = _t->getLineWidth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 122: _t->startLine((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 123: _t->setLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 124: _t->stopLine(); break;
        case 125: _t->undo(); break;
        case 126: _t->redo(); break;
        case 127: _t->clear_all(); break;
        case 128: _t->setObjPose(); break;
        case 129: _t->setMarginObj(); break;
        case 130: _t->clearMarginObj(); break;
        case 131: _t->setMarginPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 132: { QVector<int> _r = _t->getMarginObj();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 133: { float _r = _t->getMargin();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 134: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 135: { int _r = _t->getLocationSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 136: { QString _r = _t->getLocationName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 137: { QString _r = _t->getLocationTypes((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 138: { float _r = _t->getLocationx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 139: { float _r = _t->getLocationy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 140: { float _r = _t->getLocationth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 141: { float _r = _t->getLidar((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 142: { int _r = _t->getObjectNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 143: { QString _r = _t->getObjectName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 144: { int _r = _t->getObjectPointSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 145: { float _r = _t->getObjectX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 146: { float _r = _t->getObjectY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 147: { int _r = _t->getTempObjectSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 148: { float _r = _t->getTempObjectX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 149: { float _r = _t->getTempObjectY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 150: { int _r = _t->getObjNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 151: { int _r = _t->getObjNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 152: { int _r = _t->getObjPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 153: { int _r = _t->getLocNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 154: { int _r = _t->getLocNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 155: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 156: _t->removeObjectPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 157: _t->removeObjectPointLast(); break;
        case 158: _t->clearObjectPoints(); break;
        case 159: { int _r = _t->getObjectSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 160: _t->addObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 161: _t->addObjectRect((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 162: _t->editObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4]))); break;
        case 163: _t->removeObject((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 164: _t->removeLocation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 165: _t->addLocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< float(*)>(_a[5]))); break;
        case 166: _t->moveLocationPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 167: { int _r = _t->getTlineSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 168: { int _r = _t->getTlineSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 169: { QString _r = _t->getTlineName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 170: { float _r = _t->getTlineX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 171: { float _r = _t->getTlineY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 172: _t->addTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< int(*)>(_a[5]))); break;
        case 173: _t->removeTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 174: { int _r = _t->getTlineNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 175: { bool _r = _t->saveAnnotation((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 176: { bool _r = _t->saveMetaData((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 177: _t->sendMaptoServer(); break;
        case 178: _t->acceptCall((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 179: _t->setTray((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 180: _t->confirmPickup(); break;
        case 181: { QVector<int> _r = _t->getPickuptrays();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 182: _t->moveTo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 183: _t->moveTo((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 184: _t->movePause(); break;
        case 185: _t->moveResume(); break;
        case 186: _t->moveStop(); break;
        case 187: _t->moveManual(); break;
        case 188: _t->moveToCharge(); break;
        case 189: _t->moveToWait(); break;
        case 190: { QString _r = _t->getcurLoc();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 191: { QString _r = _t->getcurTable();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 192: { QVector<float> _r = _t->getcurTarget();
            if (_a[0]) *reinterpret_cast< QVector<float>*>(_a[0]) = std::move(_r); }  break;
        case 193: _t->joyMoveXY((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 194: _t->joyMoveR((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 195: { float _r = _t->getJoyXY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 196: { float _r = _t->getJoyR();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 197: { float _r = _t->getBattery();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 198: { int _r = _t->getState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 199: { int _r = _t->getErrcode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 200: { QString _r = _t->getRobotName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 201: { float _r = _t->getRobotRadius();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 202: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 203: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 204: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 205: { int _r = _t->getRobotState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 206: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 207: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 208: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 209: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 210: { int _r = _t->getLocalPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 211: { float _r = _t->getLocalPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 212: { float _r = _t->getLocalPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 213: { int _r = _t->getuistate();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 214: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 215: { QString _r = _t->getMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 216: { QString _r = _t->getServerMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 217: { QString _r = _t->getServerMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 218: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 219: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 220: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 221: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 222: { QList<int> _r = _t->getMapData((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 223: { QObject* _r = _t->getMapping();
            if (_a[0]) *reinterpret_cast< QObject**>(_a[0]) = std::move(_r); }  break;
        case 224: { QObject* _r = _t->getMinimap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QObject**>(_a[0]) = std::move(_r); }  break;
        case 225: { QObject* _r = _t->getMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QObject**>(_a[0]) = std::move(_r); }  break;
        case 226: { QObject* _r = _t->getRawMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QObject**>(_a[0]) = std::move(_r); }  break;
        case 227: { QString _r = _t->getPatrolFileName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 228: _t->makePatrol(); break;
        case 229: _t->loadPatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 230: _t->savePatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 231: _t->addPatrol((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4])),(*reinterpret_cast< float(*)>(_a[5]))); break;
        case 232: { int _r = _t->getPatrolNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 233: { QString _r = _t->getPatrolType((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 234: { QString _r = _t->getPatrolLocation((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 235: { float _r = _t->getPatrolX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 236: { float _r = _t->getPatrolY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 237: { float _r = _t->getPatrolTH((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 238: _t->removePatrol((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 239: _t->movePatrolUp((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 240: _t->movePatrolDown((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 241: { int _r = _t->getPatrolMode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 242: _t->setPatrolMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 243: _t->startRecordPath(); break;
        case 244: _t->startcurPath(); break;
        case 245: _t->stopcurPath(); break;
        case 246: _t->pausecurPath(); break;
        case 247: _t->runRotateTables(); break;
        case 248: _t->stopRotateTables(); break;
        case 249: _t->startServingTest(); break;
        case 250: _t->stopServingTest(); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 109:
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
        if (_id < 251)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 251;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 251)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 251;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
