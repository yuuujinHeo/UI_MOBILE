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
    QByteArrayData data[304];
    char stringdata0[3590];
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
QT_MOC_LITERAL(76, 894, 19), // "getLocalVersionDate"
QT_MOC_LITERAL(77, 914, 20), // "getServerVersionDate"
QT_MOC_LITERAL(78, 935, 22), // "getLocalVersionMessage"
QT_MOC_LITERAL(79, 958, 23), // "getServerVersionMessage"
QT_MOC_LITERAL(80, 982, 15), // "isConnectServer"
QT_MOC_LITERAL(81, 998, 10), // "isExistMap"
QT_MOC_LITERAL(82, 1009, 13), // "isExistRawMap"
QT_MOC_LITERAL(83, 1023, 15), // "getAvailableMap"
QT_MOC_LITERAL(84, 1039, 19), // "getAvailableMapPath"
QT_MOC_LITERAL(85, 1059, 14), // "getMapFileSize"
QT_MOC_LITERAL(86, 1074, 10), // "getMapFile"
QT_MOC_LITERAL(87, 1085, 17), // "isExistAnnotation"
QT_MOC_LITERAL(88, 1103, 16), // "deleteAnnotation"
QT_MOC_LITERAL(89, 1120, 15), // "loadMaptoServer"
QT_MOC_LITERAL(90, 1136, 9), // "isUSBFile"
QT_MOC_LITERAL(91, 1146, 14), // "getUSBFilename"
QT_MOC_LITERAL(92, 1161, 12), // "loadMaptoUSB"
QT_MOC_LITERAL(93, 1174, 14), // "isuseServerMap"
QT_MOC_LITERAL(94, 1189, 15), // "setuseServerMap"
QT_MOC_LITERAL(95, 1205, 9), // "removeMap"
QT_MOC_LITERAL(96, 1215, 8), // "filename"
QT_MOC_LITERAL(97, 1224, 9), // "isloadMap"
QT_MOC_LITERAL(98, 1234, 10), // "setloadMap"
QT_MOC_LITERAL(99, 1245, 4), // "load"
QT_MOC_LITERAL(100, 1250, 15), // "isExistRobotINI"
QT_MOC_LITERAL(101, 1266, 12), // "makeRobotINI"
QT_MOC_LITERAL(102, 1279, 10), // "rotate_map"
QT_MOC_LITERAL(103, 1290, 4), // "_src"
QT_MOC_LITERAL(104, 1295, 4), // "_dst"
QT_MOC_LITERAL(105, 1300, 4), // "mode"
QT_MOC_LITERAL(106, 1305, 16), // "getLCMConnection"
QT_MOC_LITERAL(107, 1322, 8), // "getLCMRX"
QT_MOC_LITERAL(108, 1331, 8), // "getLCMTX"
QT_MOC_LITERAL(109, 1340, 13), // "getLCMProcess"
QT_MOC_LITERAL(110, 1354, 10), // "getIniRead"
QT_MOC_LITERAL(111, 1365, 13), // "getUsbMapSize"
QT_MOC_LITERAL(112, 1379, 13), // "getUsbMapPath"
QT_MOC_LITERAL(113, 1393, 17), // "getUsbMapPathFull"
QT_MOC_LITERAL(114, 1411, 14), // "saveMapfromUsb"
QT_MOC_LITERAL(115, 1426, 4), // "path"
QT_MOC_LITERAL(116, 1431, 7), // "loadMap"
QT_MOC_LITERAL(117, 1439, 6), // "setMap"
QT_MOC_LITERAL(118, 1446, 12), // "startMapping"
QT_MOC_LITERAL(119, 1459, 4), // "grid"
QT_MOC_LITERAL(120, 1464, 11), // "stopMapping"
QT_MOC_LITERAL(121, 1476, 11), // "setSLAMMode"
QT_MOC_LITERAL(122, 1488, 11), // "saveMapping"
QT_MOC_LITERAL(123, 1500, 10), // "setInitPos"
QT_MOC_LITERAL(124, 1511, 1), // "x"
QT_MOC_LITERAL(125, 1513, 1), // "y"
QT_MOC_LITERAL(126, 1515, 2), // "th"
QT_MOC_LITERAL(127, 1518, 12), // "getInitPoseX"
QT_MOC_LITERAL(128, 1531, 12), // "getInitPoseY"
QT_MOC_LITERAL(129, 1544, 13), // "getInitPoseTH"
QT_MOC_LITERAL(130, 1558, 12), // "slam_setInit"
QT_MOC_LITERAL(131, 1571, 8), // "slam_run"
QT_MOC_LITERAL(132, 1580, 9), // "slam_stop"
QT_MOC_LITERAL(133, 1590, 13), // "slam_autoInit"
QT_MOC_LITERAL(134, 1604, 15), // "is_slam_running"
QT_MOC_LITERAL(135, 1620, 14), // "getMappingflag"
QT_MOC_LITERAL(136, 1635, 14), // "setMappingflag"
QT_MOC_LITERAL(137, 1650, 4), // "flag"
QT_MOC_LITERAL(138, 1655, 15), // "getMappingImage"
QT_MOC_LITERAL(139, 1671, 10), // "getListMap"
QT_MOC_LITERAL(140, 1682, 13), // "getRawListMap"
QT_MOC_LITERAL(141, 1696, 11), // "pushMapData"
QT_MOC_LITERAL(142, 1708, 4), // "data"
QT_MOC_LITERAL(143, 1713, 12), // "isconnectJoy"
QT_MOC_LITERAL(144, 1726, 10), // "getJoyAxis"
QT_MOC_LITERAL(145, 1737, 12), // "getJoyButton"
QT_MOC_LITERAL(146, 1750, 11), // "getKeyboard"
QT_MOC_LITERAL(147, 1762, 11), // "getJoystick"
QT_MOC_LITERAL(148, 1774, 14), // "setRotateAngle"
QT_MOC_LITERAL(149, 1789, 5), // "angle"
QT_MOC_LITERAL(150, 1795, 13), // "getCanvasSize"
QT_MOC_LITERAL(151, 1809, 11), // "getRedoSize"
QT_MOC_LITERAL(152, 1821, 8), // "getLineX"
QT_MOC_LITERAL(153, 1830, 12), // "QVector<int>"
QT_MOC_LITERAL(154, 1843, 5), // "index"
QT_MOC_LITERAL(155, 1849, 8), // "getLineY"
QT_MOC_LITERAL(156, 1858, 12), // "getLineColor"
QT_MOC_LITERAL(157, 1871, 12), // "getLineWidth"
QT_MOC_LITERAL(158, 1884, 7), // "saveMap"
QT_MOC_LITERAL(159, 1892, 3), // "src"
QT_MOC_LITERAL(160, 1896, 3), // "dst"
QT_MOC_LITERAL(161, 1900, 5), // "alpha"
QT_MOC_LITERAL(162, 1906, 9), // "startLine"
QT_MOC_LITERAL(163, 1916, 5), // "color"
QT_MOC_LITERAL(164, 1922, 5), // "width"
QT_MOC_LITERAL(165, 1928, 7), // "setLine"
QT_MOC_LITERAL(166, 1936, 8), // "stopLine"
QT_MOC_LITERAL(167, 1945, 4), // "undo"
QT_MOC_LITERAL(168, 1950, 4), // "redo"
QT_MOC_LITERAL(169, 1955, 9), // "clear_all"
QT_MOC_LITERAL(170, 1965, 10), // "setObjPose"
QT_MOC_LITERAL(171, 1976, 12), // "setMarginObj"
QT_MOC_LITERAL(172, 1989, 14), // "clearMarginObj"
QT_MOC_LITERAL(173, 2004, 14), // "setMarginPoint"
QT_MOC_LITERAL(174, 2019, 9), // "pixel_num"
QT_MOC_LITERAL(175, 2029, 12), // "getMarginObj"
QT_MOC_LITERAL(176, 2042, 9), // "getMargin"
QT_MOC_LITERAL(177, 2052, 14), // "getLocationNum"
QT_MOC_LITERAL(178, 2067, 15), // "getLocationSize"
QT_MOC_LITERAL(179, 2083, 15), // "getLocationName"
QT_MOC_LITERAL(180, 2099, 16), // "getLocationTypes"
QT_MOC_LITERAL(181, 2116, 12), // "getLocationx"
QT_MOC_LITERAL(182, 2129, 12), // "getLocationy"
QT_MOC_LITERAL(183, 2142, 13), // "getLocationth"
QT_MOC_LITERAL(184, 2156, 8), // "getLidar"
QT_MOC_LITERAL(185, 2165, 12), // "getObjectNum"
QT_MOC_LITERAL(186, 2178, 13), // "getObjectName"
QT_MOC_LITERAL(187, 2192, 18), // "getObjectPointSize"
QT_MOC_LITERAL(188, 2211, 10), // "getObjectX"
QT_MOC_LITERAL(189, 2222, 5), // "point"
QT_MOC_LITERAL(190, 2228, 10), // "getObjectY"
QT_MOC_LITERAL(191, 2239, 17), // "getTempObjectSize"
QT_MOC_LITERAL(192, 2257, 14), // "getTempObjectX"
QT_MOC_LITERAL(193, 2272, 14), // "getTempObjectY"
QT_MOC_LITERAL(194, 2287, 9), // "getObjNum"
QT_MOC_LITERAL(195, 2297, 14), // "getObjPointNum"
QT_MOC_LITERAL(196, 2312, 7), // "obj_num"
QT_MOC_LITERAL(197, 2320, 9), // "getLocNum"
QT_MOC_LITERAL(198, 2330, 14), // "addObjectPoint"
QT_MOC_LITERAL(199, 2345, 17), // "removeObjectPoint"
QT_MOC_LITERAL(200, 2363, 21), // "removeObjectPointLast"
QT_MOC_LITERAL(201, 2385, 17), // "clearObjectPoints"
QT_MOC_LITERAL(202, 2403, 13), // "getObjectSize"
QT_MOC_LITERAL(203, 2417, 9), // "addObject"
QT_MOC_LITERAL(204, 2427, 13), // "addObjectRect"
QT_MOC_LITERAL(205, 2441, 10), // "editObject"
QT_MOC_LITERAL(206, 2452, 12), // "removeObject"
QT_MOC_LITERAL(207, 2465, 14), // "removeLocation"
QT_MOC_LITERAL(208, 2480, 11), // "addLocation"
QT_MOC_LITERAL(209, 2492, 17), // "moveLocationPoint"
QT_MOC_LITERAL(210, 2510, 7), // "loc_num"
QT_MOC_LITERAL(211, 2518, 12), // "getTlineSize"
QT_MOC_LITERAL(212, 2531, 12), // "getTlineName"
QT_MOC_LITERAL(213, 2544, 9), // "getTlineX"
QT_MOC_LITERAL(214, 2554, 9), // "getTlineY"
QT_MOC_LITERAL(215, 2564, 8), // "addTline"
QT_MOC_LITERAL(216, 2573, 2), // "x1"
QT_MOC_LITERAL(217, 2576, 2), // "y1"
QT_MOC_LITERAL(218, 2579, 2), // "x2"
QT_MOC_LITERAL(219, 2582, 2), // "y2"
QT_MOC_LITERAL(220, 2585, 11), // "removeTline"
QT_MOC_LITERAL(221, 2597, 4), // "line"
QT_MOC_LITERAL(222, 2602, 11), // "getTlineNum"
QT_MOC_LITERAL(223, 2614, 14), // "saveAnnotation"
QT_MOC_LITERAL(224, 2629, 12), // "saveMetaData"
QT_MOC_LITERAL(225, 2642, 15), // "sendMaptoServer"
QT_MOC_LITERAL(226, 2658, 10), // "acceptCall"
QT_MOC_LITERAL(227, 2669, 3), // "yes"
QT_MOC_LITERAL(228, 2673, 7), // "setTray"
QT_MOC_LITERAL(229, 2681, 13), // "confirmPickup"
QT_MOC_LITERAL(230, 2695, 14), // "getPickuptrays"
QT_MOC_LITERAL(231, 2710, 6), // "moveTo"
QT_MOC_LITERAL(232, 2717, 10), // "target_num"
QT_MOC_LITERAL(233, 2728, 10), // "moveToLast"
QT_MOC_LITERAL(234, 2739, 9), // "movePause"
QT_MOC_LITERAL(235, 2749, 10), // "moveResume"
QT_MOC_LITERAL(236, 2760, 8), // "moveStop"
QT_MOC_LITERAL(237, 2769, 10), // "moveManual"
QT_MOC_LITERAL(238, 2780, 12), // "moveToCharge"
QT_MOC_LITERAL(239, 2793, 10), // "moveToWait"
QT_MOC_LITERAL(240, 2804, 9), // "getcurLoc"
QT_MOC_LITERAL(241, 2814, 11), // "getcurTable"
QT_MOC_LITERAL(242, 2826, 12), // "getcurTarget"
QT_MOC_LITERAL(243, 2839, 14), // "QVector<float>"
QT_MOC_LITERAL(244, 2854, 9), // "joyMoveXY"
QT_MOC_LITERAL(245, 2864, 8), // "joyMoveR"
QT_MOC_LITERAL(246, 2873, 1), // "r"
QT_MOC_LITERAL(247, 2875, 8), // "getJoyXY"
QT_MOC_LITERAL(248, 2884, 7), // "getJoyR"
QT_MOC_LITERAL(249, 2892, 10), // "getBattery"
QT_MOC_LITERAL(250, 2903, 8), // "getState"
QT_MOC_LITERAL(251, 2912, 10), // "getErrcode"
QT_MOC_LITERAL(252, 2923, 12), // "getRobotName"
QT_MOC_LITERAL(253, 2936, 14), // "getRobotRadius"
QT_MOC_LITERAL(254, 2951, 9), // "getRobotx"
QT_MOC_LITERAL(255, 2961, 9), // "getRoboty"
QT_MOC_LITERAL(256, 2971, 10), // "getRobotth"
QT_MOC_LITERAL(257, 2982, 13), // "getRobotState"
QT_MOC_LITERAL(258, 2996, 10), // "getPathNum"
QT_MOC_LITERAL(259, 3007, 8), // "getPathx"
QT_MOC_LITERAL(260, 3016, 8), // "getPathy"
QT_MOC_LITERAL(261, 3025, 9), // "getPathth"
QT_MOC_LITERAL(262, 3035, 15), // "getLocalPathNum"
QT_MOC_LITERAL(263, 3051, 13), // "getLocalPathx"
QT_MOC_LITERAL(264, 3065, 13), // "getLocalPathy"
QT_MOC_LITERAL(265, 3079, 10), // "getuistate"
QT_MOC_LITERAL(266, 3090, 10), // "getMapname"
QT_MOC_LITERAL(267, 3101, 10), // "getMappath"
QT_MOC_LITERAL(268, 3112, 16), // "getServerMapname"
QT_MOC_LITERAL(269, 3129, 16), // "getServerMappath"
QT_MOC_LITERAL(270, 3146, 11), // "getMapWidth"
QT_MOC_LITERAL(271, 3158, 12), // "getMapHeight"
QT_MOC_LITERAL(272, 3171, 12), // "getGridWidth"
QT_MOC_LITERAL(273, 3184, 9), // "getOrigin"
QT_MOC_LITERAL(274, 3194, 10), // "getMapData"
QT_MOC_LITERAL(275, 3205, 10), // "getMapping"
QT_MOC_LITERAL(276, 3216, 10), // "getMinimap"
QT_MOC_LITERAL(277, 3227, 6), // "getMap"
QT_MOC_LITERAL(278, 3234, 9), // "getRawMap"
QT_MOC_LITERAL(279, 3244, 17), // "getPatrolFileName"
QT_MOC_LITERAL(280, 3262, 10), // "makePatrol"
QT_MOC_LITERAL(281, 3273, 14), // "loadPatrolFile"
QT_MOC_LITERAL(282, 3288, 14), // "savePatrolFile"
QT_MOC_LITERAL(283, 3303, 9), // "addPatrol"
QT_MOC_LITERAL(284, 3313, 8), // "location"
QT_MOC_LITERAL(285, 3322, 12), // "getPatrolNum"
QT_MOC_LITERAL(286, 3335, 13), // "getPatrolType"
QT_MOC_LITERAL(287, 3349, 17), // "getPatrolLocation"
QT_MOC_LITERAL(288, 3367, 10), // "getPatrolX"
QT_MOC_LITERAL(289, 3378, 10), // "getPatrolY"
QT_MOC_LITERAL(290, 3389, 11), // "getPatrolTH"
QT_MOC_LITERAL(291, 3401, 12), // "removePatrol"
QT_MOC_LITERAL(292, 3414, 12), // "movePatrolUp"
QT_MOC_LITERAL(293, 3427, 14), // "movePatrolDown"
QT_MOC_LITERAL(294, 3442, 13), // "getPatrolMode"
QT_MOC_LITERAL(295, 3456, 13), // "setPatrolMode"
QT_MOC_LITERAL(296, 3470, 15), // "startRecordPath"
QT_MOC_LITERAL(297, 3486, 12), // "startcurPath"
QT_MOC_LITERAL(298, 3499, 11), // "stopcurPath"
QT_MOC_LITERAL(299, 3511, 12), // "pausecurPath"
QT_MOC_LITERAL(300, 3524, 15), // "runRotateTables"
QT_MOC_LITERAL(301, 3540, 16), // "stopRotateTables"
QT_MOC_LITERAL(302, 3557, 16), // "startServingTest"
QT_MOC_LITERAL(303, 3574, 15) // "stopServingTest"

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
    "getLocalVersionDate\0getServerVersionDate\0"
    "getLocalVersionMessage\0getServerVersionMessage\0"
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
    "loadMap\0setMap\0startMapping\0grid\0"
    "stopMapping\0setSLAMMode\0saveMapping\0"
    "setInitPos\0x\0y\0th\0getInitPoseX\0"
    "getInitPoseY\0getInitPoseTH\0slam_setInit\0"
    "slam_run\0slam_stop\0slam_autoInit\0"
    "is_slam_running\0getMappingflag\0"
    "setMappingflag\0flag\0getMappingImage\0"
    "getListMap\0getRawListMap\0pushMapData\0"
    "data\0isconnectJoy\0getJoyAxis\0getJoyButton\0"
    "getKeyboard\0getJoystick\0setRotateAngle\0"
    "angle\0getCanvasSize\0getRedoSize\0"
    "getLineX\0QVector<int>\0index\0getLineY\0"
    "getLineColor\0getLineWidth\0saveMap\0src\0"
    "dst\0alpha\0startLine\0color\0width\0setLine\0"
    "stopLine\0undo\0redo\0clear_all\0setObjPose\0"
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
    "moveToLast\0movePause\0moveResume\0"
    "moveStop\0moveManual\0moveToCharge\0"
    "moveToWait\0getcurLoc\0getcurTable\0"
    "getcurTarget\0QVector<float>\0joyMoveXY\0"
    "joyMoveR\0r\0getJoyXY\0getJoyR\0getBattery\0"
    "getState\0getErrcode\0getRobotName\0"
    "getRobotRadius\0getRobotx\0getRoboty\0"
    "getRobotth\0getRobotState\0getPathNum\0"
    "getPathx\0getPathy\0getPathth\0getLocalPathNum\0"
    "getLocalPathx\0getLocalPathy\0getuistate\0"
    "getMapname\0getMappath\0getServerMapname\0"
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
     258,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0, 1304,    2, 0x0a /* Public */,
       3,    0, 1305,    2, 0x0a /* Public */,
       4,    0, 1306,    2, 0x0a /* Public */,
       5,    0, 1307,    2, 0x0a /* Public */,
       6,    0, 1308,    2, 0x0a /* Public */,
       7,    0, 1309,    2, 0x0a /* Public */,
       8,    0, 1310,    2, 0x0a /* Public */,
       9,    0, 1311,    2, 0x0a /* Public */,
      10,    0, 1312,    2, 0x0a /* Public */,
      11,    0, 1313,    2, 0x0a /* Public */,
      12,    0, 1314,    2, 0x0a /* Public */,
      13,    0, 1315,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      14,    0, 1316,    2, 0x02 /* Public */,
      15,    0, 1317,    2, 0x02 /* Public */,
      16,    1, 1318,    2, 0x02 /* Public */,
      18,    1, 1321,    2, 0x02 /* Public */,
      20,    1, 1324,    2, 0x02 /* Public */,
      21,    1, 1327,    2, 0x02 /* Public */,
      22,    1, 1330,    2, 0x02 /* Public */,
      23,    0, 1333,    2, 0x02 /* Public */,
      24,    2, 1334,    2, 0x02 /* Public */,
      26,    1, 1339,    2, 0x02 /* Public */,
      26,    0, 1342,    2, 0x22 /* Public | MethodCloned */,
      28,    2, 1343,    2, 0x02 /* Public */,
      30,    1, 1348,    2, 0x02 /* Public */,
      32,    0, 1351,    2, 0x02 /* Public */,
      33,    0, 1352,    2, 0x02 /* Public */,
      34,    1, 1353,    2, 0x02 /* Public */,
      36,    0, 1356,    2, 0x02 /* Public */,
      37,    1, 1357,    2, 0x02 /* Public */,
      39,    0, 1360,    2, 0x02 /* Public */,
      40,    1, 1361,    2, 0x02 /* Public */,
      42,    0, 1364,    2, 0x02 /* Public */,
      43,    1, 1365,    2, 0x02 /* Public */,
      45,    0, 1368,    2, 0x02 /* Public */,
      46,    1, 1369,    2, 0x02 /* Public */,
      48,    0, 1372,    2, 0x02 /* Public */,
      49,    1, 1373,    2, 0x02 /* Public */,
      50,    0, 1376,    2, 0x02 /* Public */,
      51,    1, 1377,    2, 0x02 /* Public */,
      52,    0, 1380,    2, 0x02 /* Public */,
      53,    1, 1381,    2, 0x02 /* Public */,
      54,    0, 1384,    2, 0x02 /* Public */,
      55,    1, 1385,    2, 0x02 /* Public */,
      57,    1, 1388,    2, 0x02 /* Public */,
      58,    0, 1391,    2, 0x02 /* Public */,
      59,    0, 1392,    2, 0x02 /* Public */,
      60,    1, 1393,    2, 0x02 /* Public */,
      62,    0, 1396,    2, 0x02 /* Public */,
      63,    0, 1397,    2, 0x02 /* Public */,
      64,    0, 1398,    2, 0x02 /* Public */,
      65,    2, 1399,    2, 0x02 /* Public */,
      68,    0, 1404,    2, 0x02 /* Public */,
      69,    1, 1405,    2, 0x02 /* Public */,
      71,    1, 1408,    2, 0x02 /* Public */,
      72,    0, 1411,    2, 0x02 /* Public */,
      73,    0, 1412,    2, 0x02 /* Public */,
      74,    0, 1413,    2, 0x02 /* Public */,
      75,    0, 1414,    2, 0x02 /* Public */,
      76,    0, 1415,    2, 0x02 /* Public */,
      77,    0, 1416,    2, 0x02 /* Public */,
      78,    0, 1417,    2, 0x02 /* Public */,
      79,    0, 1418,    2, 0x02 /* Public */,
      80,    0, 1419,    2, 0x02 /* Public */,
      81,    1, 1420,    2, 0x02 /* Public */,
      82,    1, 1423,    2, 0x02 /* Public */,
      81,    0, 1426,    2, 0x02 /* Public */,
      83,    0, 1427,    2, 0x02 /* Public */,
      84,    1, 1428,    2, 0x02 /* Public */,
      85,    1, 1431,    2, 0x02 /* Public */,
      86,    1, 1434,    2, 0x02 /* Public */,
      87,    1, 1437,    2, 0x02 /* Public */,
      88,    0, 1440,    2, 0x02 /* Public */,
      89,    0, 1441,    2, 0x02 /* Public */,
      90,    0, 1442,    2, 0x02 /* Public */,
      91,    0, 1443,    2, 0x02 /* Public */,
      92,    0, 1444,    2, 0x02 /* Public */,
      93,    0, 1445,    2, 0x02 /* Public */,
      94,    1, 1446,    2, 0x02 /* Public */,
      95,    1, 1449,    2, 0x02 /* Public */,
      97,    0, 1452,    2, 0x02 /* Public */,
      98,    1, 1453,    2, 0x02 /* Public */,
     100,    0, 1456,    2, 0x02 /* Public */,
     101,    0, 1457,    2, 0x02 /* Public */,
     102,    3, 1458,    2, 0x02 /* Public */,
     106,    0, 1465,    2, 0x02 /* Public */,
     107,    0, 1466,    2, 0x02 /* Public */,
     108,    0, 1467,    2, 0x02 /* Public */,
     109,    0, 1468,    2, 0x02 /* Public */,
     110,    0, 1469,    2, 0x02 /* Public */,
     111,    0, 1470,    2, 0x02 /* Public */,
     112,    1, 1471,    2, 0x02 /* Public */,
     113,    1, 1474,    2, 0x02 /* Public */,
     114,    1, 1477,    2, 0x02 /* Public */,
     116,    1, 1480,    2, 0x02 /* Public */,
     117,    1, 1483,    2, 0x02 /* Public */,
     118,    1, 1486,    2, 0x02 /* Public */,
     120,    0, 1489,    2, 0x02 /* Public */,
     121,    1, 1490,    2, 0x02 /* Public */,
     122,    1, 1493,    2, 0x02 /* Public */,
     123,    3, 1496,    2, 0x02 /* Public */,
     127,    0, 1503,    2, 0x02 /* Public */,
     128,    0, 1504,    2, 0x02 /* Public */,
     129,    0, 1505,    2, 0x02 /* Public */,
     130,    0, 1506,    2, 0x02 /* Public */,
     131,    0, 1507,    2, 0x02 /* Public */,
     132,    0, 1508,    2, 0x02 /* Public */,
     133,    0, 1509,    2, 0x02 /* Public */,
     134,    0, 1510,    2, 0x02 /* Public */,
     135,    0, 1511,    2, 0x02 /* Public */,
     136,    1, 1512,    2, 0x02 /* Public */,
     138,    0, 1515,    2, 0x02 /* Public */,
     139,    1, 1516,    2, 0x02 /* Public */,
     140,    1, 1519,    2, 0x02 /* Public */,
     141,    1, 1522,    2, 0x02 /* Public */,
     143,    0, 1525,    2, 0x02 /* Public */,
     144,    1, 1526,    2, 0x02 /* Public */,
     145,    1, 1529,    2, 0x02 /* Public */,
     146,    1, 1532,    2, 0x02 /* Public */,
     147,    1, 1535,    2, 0x02 /* Public */,
     148,    1, 1538,    2, 0x02 /* Public */,
     150,    0, 1541,    2, 0x02 /* Public */,
     151,    0, 1542,    2, 0x02 /* Public */,
     152,    1, 1543,    2, 0x02 /* Public */,
     155,    1, 1546,    2, 0x02 /* Public */,
     156,    1, 1549,    2, 0x02 /* Public */,
     157,    1, 1552,    2, 0x02 /* Public */,
     158,    5, 1555,    2, 0x02 /* Public */,
     162,    2, 1566,    2, 0x02 /* Public */,
     165,    2, 1571,    2, 0x02 /* Public */,
     166,    0, 1576,    2, 0x02 /* Public */,
     167,    0, 1577,    2, 0x02 /* Public */,
     168,    0, 1578,    2, 0x02 /* Public */,
     169,    0, 1579,    2, 0x02 /* Public */,
     170,    0, 1580,    2, 0x02 /* Public */,
     171,    0, 1581,    2, 0x02 /* Public */,
     172,    0, 1582,    2, 0x02 /* Public */,
     173,    1, 1583,    2, 0x02 /* Public */,
     175,    0, 1586,    2, 0x02 /* Public */,
     176,    0, 1587,    2, 0x02 /* Public */,
     177,    0, 1588,    2, 0x02 /* Public */,
     178,    1, 1589,    2, 0x02 /* Public */,
     179,    1, 1592,    2, 0x02 /* Public */,
     180,    1, 1595,    2, 0x02 /* Public */,
     181,    1, 1598,    2, 0x02 /* Public */,
     182,    1, 1601,    2, 0x02 /* Public */,
     183,    1, 1604,    2, 0x02 /* Public */,
     184,    1, 1607,    2, 0x02 /* Public */,
     185,    0, 1610,    2, 0x02 /* Public */,
     186,    1, 1611,    2, 0x02 /* Public */,
     187,    1, 1614,    2, 0x02 /* Public */,
     188,    2, 1617,    2, 0x02 /* Public */,
     190,    2, 1622,    2, 0x02 /* Public */,
     191,    0, 1627,    2, 0x02 /* Public */,
     192,    1, 1628,    2, 0x02 /* Public */,
     193,    1, 1631,    2, 0x02 /* Public */,
     194,    1, 1634,    2, 0x02 /* Public */,
     194,    2, 1637,    2, 0x02 /* Public */,
     195,    3, 1642,    2, 0x02 /* Public */,
     197,    1, 1649,    2, 0x02 /* Public */,
     197,    2, 1652,    2, 0x02 /* Public */,
     198,    2, 1657,    2, 0x02 /* Public */,
     199,    1, 1662,    2, 0x02 /* Public */,
     200,    0, 1665,    2, 0x02 /* Public */,
     201,    0, 1666,    2, 0x02 /* Public */,
     202,    1, 1667,    2, 0x02 /* Public */,
     203,    1, 1670,    2, 0x02 /* Public */,
     204,    1, 1673,    2, 0x02 /* Public */,
     205,    4, 1676,    2, 0x02 /* Public */,
     206,    1, 1685,    2, 0x02 /* Public */,
     207,    1, 1688,    2, 0x02 /* Public */,
     208,    5, 1691,    2, 0x02 /* Public */,
     209,    4, 1702,    2, 0x02 /* Public */,
     211,    0, 1711,    2, 0x02 /* Public */,
     211,    1, 1712,    2, 0x02 /* Public */,
     212,    1, 1715,    2, 0x02 /* Public */,
     213,    2, 1718,    2, 0x02 /* Public */,
     214,    2, 1723,    2, 0x02 /* Public */,
     215,    5, 1728,    2, 0x02 /* Public */,
     220,    2, 1739,    2, 0x02 /* Public */,
     222,    2, 1744,    2, 0x02 /* Public */,
     223,    1, 1749,    2, 0x02 /* Public */,
     224,    1, 1752,    2, 0x02 /* Public */,
     225,    0, 1755,    2, 0x02 /* Public */,
     226,    1, 1756,    2, 0x02 /* Public */,
     228,    2, 1759,    2, 0x02 /* Public */,
     229,    0, 1764,    2, 0x02 /* Public */,
     230,    0, 1765,    2, 0x02 /* Public */,
     231,    1, 1766,    2, 0x02 /* Public */,
     231,    3, 1769,    2, 0x02 /* Public */,
     233,    0, 1776,    2, 0x02 /* Public */,
     234,    0, 1777,    2, 0x02 /* Public */,
     235,    0, 1778,    2, 0x02 /* Public */,
     236,    0, 1779,    2, 0x02 /* Public */,
     237,    0, 1780,    2, 0x02 /* Public */,
     238,    0, 1781,    2, 0x02 /* Public */,
     239,    0, 1782,    2, 0x02 /* Public */,
     240,    0, 1783,    2, 0x02 /* Public */,
     241,    0, 1784,    2, 0x02 /* Public */,
     242,    0, 1785,    2, 0x02 /* Public */,
     244,    1, 1786,    2, 0x02 /* Public */,
     245,    1, 1789,    2, 0x02 /* Public */,
     247,    0, 1792,    2, 0x02 /* Public */,
     248,    0, 1793,    2, 0x02 /* Public */,
     249,    0, 1794,    2, 0x02 /* Public */,
     250,    0, 1795,    2, 0x02 /* Public */,
     251,    0, 1796,    2, 0x02 /* Public */,
     252,    0, 1797,    2, 0x02 /* Public */,
     253,    0, 1798,    2, 0x02 /* Public */,
     254,    0, 1799,    2, 0x02 /* Public */,
     255,    0, 1800,    2, 0x02 /* Public */,
     256,    0, 1801,    2, 0x02 /* Public */,
     257,    0, 1802,    2, 0x02 /* Public */,
     258,    0, 1803,    2, 0x02 /* Public */,
     259,    1, 1804,    2, 0x02 /* Public */,
     260,    1, 1807,    2, 0x02 /* Public */,
     261,    1, 1810,    2, 0x02 /* Public */,
     262,    0, 1813,    2, 0x02 /* Public */,
     263,    1, 1814,    2, 0x02 /* Public */,
     264,    1, 1817,    2, 0x02 /* Public */,
     265,    0, 1820,    2, 0x02 /* Public */,
     266,    0, 1821,    2, 0x02 /* Public */,
     267,    0, 1822,    2, 0x02 /* Public */,
     268,    0, 1823,    2, 0x02 /* Public */,
     269,    0, 1824,    2, 0x02 /* Public */,
     270,    0, 1825,    2, 0x02 /* Public */,
     271,    0, 1826,    2, 0x02 /* Public */,
     272,    0, 1827,    2, 0x02 /* Public */,
     273,    0, 1828,    2, 0x02 /* Public */,
     274,    1, 1829,    2, 0x02 /* Public */,
     275,    0, 1832,    2, 0x02 /* Public */,
     276,    1, 1833,    2, 0x02 /* Public */,
     277,    1, 1836,    2, 0x02 /* Public */,
     278,    1, 1839,    2, 0x02 /* Public */,
     279,    0, 1842,    2, 0x02 /* Public */,
     280,    0, 1843,    2, 0x02 /* Public */,
     281,    1, 1844,    2, 0x02 /* Public */,
     282,    1, 1847,    2, 0x02 /* Public */,
     283,    5, 1850,    2, 0x02 /* Public */,
     285,    0, 1861,    2, 0x02 /* Public */,
     286,    1, 1862,    2, 0x02 /* Public */,
     287,    1, 1865,    2, 0x02 /* Public */,
     288,    1, 1868,    2, 0x02 /* Public */,
     289,    1, 1871,    2, 0x02 /* Public */,
     290,    1, 1874,    2, 0x02 /* Public */,
     291,    1, 1877,    2, 0x02 /* Public */,
     292,    1, 1880,    2, 0x02 /* Public */,
     293,    1, 1883,    2, 0x02 /* Public */,
     294,    0, 1886,    2, 0x02 /* Public */,
     295,    1, 1887,    2, 0x02 /* Public */,
     296,    0, 1890,    2, 0x02 /* Public */,
     297,    0, 1891,    2, 0x02 /* Public */,
     298,    0, 1892,    2, 0x02 /* Public */,
     299,    0, 1893,    2, 0x02 /* Public */,
     300,    0, 1894,    2, 0x02 /* Public */,
     301,    0, 1895,    2, 0x02 /* Public */,
     302,    0, 1896,    2, 0x02 /* Public */,
     303,    0, 1897,    2, 0x02 /* Public */,

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
    QMetaType::QString,
    QMetaType::QString,
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
    QMetaType::Void, QMetaType::QString,   96,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   99,
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString, QMetaType::Int,  103,  104,  105,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::Void, QMetaType::QString,  115,
    QMetaType::Void, QMetaType::QString,   19,
    QMetaType::Void, QMetaType::QString,   19,
    QMetaType::Void, QMetaType::Float,  119,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,  105,
    QMetaType::Void, QMetaType::QString,   19,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,  124,  125,  126,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  137,
    QMetaType::QPixmap,
    0x80000000 | 70, QMetaType::QString,   96,
    0x80000000 | 70, QMetaType::QString,   96,
    QMetaType::Void, 0x80000000 | 70,  142,
    QMetaType::Bool,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Int, QMetaType::Int,   38,
    QMetaType::QString, QMetaType::Int,  105,
    QMetaType::QString, QMetaType::Int,  105,
    QMetaType::Void, QMetaType::Float,  149,
    QMetaType::Int,
    QMetaType::Int,
    0x80000000 | 153, QMetaType::Int,  154,
    0x80000000 | 153, QMetaType::Int,  154,
    QMetaType::QString, QMetaType::Int,  154,
    QMetaType::Float, QMetaType::Int,  154,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, 0x80000000 | 70, 0x80000000 | 70,  105,  159,  160,  142,  161,
    QMetaType::Void, QMetaType::QString, QMetaType::Float,  163,  164,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,  124,  125,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,  174,
    0x80000000 | 153,
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
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   38,  189,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   38,  189,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int,   38,
    QMetaType::Int, QMetaType::QString,   19,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  124,  125,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  196,  124,  125,
    QMetaType::Int, QMetaType::QString,   19,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  124,  125,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,  124,  125,
    QMetaType::Void, QMetaType::Int,   38,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int, QMetaType::QString,   56,
    QMetaType::Void, QMetaType::QString,   56,
    QMetaType::Void, QMetaType::QString,   56,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   38,  189,  124,  125,
    QMetaType::Void, QMetaType::Int,   38,
    QMetaType::Void, QMetaType::QString,   19,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::Float,   56,   19,  124,  125,  126,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Float,  210,  124,  125,  126,
    QMetaType::Int,
    QMetaType::Int, QMetaType::Int,   38,
    QMetaType::QString, QMetaType::Int,   38,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   38,  189,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   38,  189,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   38,  216,  217,  218,  219,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   38,  221,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  124,  125,
    QMetaType::Bool, QMetaType::QString,   96,
    QMetaType::Bool, QMetaType::QString,   96,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,  227,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   41,   44,
    QMetaType::Void,
    0x80000000 | 153,
    QMetaType::Void, QMetaType::QString,  232,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,  124,  125,  126,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    0x80000000 | 243,
    QMetaType::Void, QMetaType::Float,  124,
    QMetaType::Void, QMetaType::Float,  246,
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
    0x80000000 | 153,
    0x80000000 | 70, QMetaType::QString,   96,
    QMetaType::QObjectStar,
    QMetaType::QObjectStar, QMetaType::QString,   96,
    QMetaType::QObjectStar, QMetaType::QString,   96,
    QMetaType::QObjectStar, QMetaType::QString,   96,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,  115,
    QMetaType::Void, QMetaType::QString,  115,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Float, QMetaType::Float, QMetaType::Float,   56,  284,  124,  125,  126,
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
    QMetaType::Void, QMetaType::Int,  105,
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
        case 59: { QString _r = _t->getLocalVersionDate();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 60: { QString _r = _t->getServerVersionDate();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 61: { QString _r = _t->getLocalVersionMessage();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 62: { QString _r = _t->getServerVersionMessage();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 63: { bool _r = _t->isConnectServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 64: { bool _r = _t->isExistMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 65: { bool _r = _t->isExistRawMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 66: { bool _r = _t->isExistMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 67: { int _r = _t->getAvailableMap();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 68: { QString _r = _t->getAvailableMapPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 69: { int _r = _t->getMapFileSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 70: { QString _r = _t->getMapFile((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 71: { bool _r = _t->isExistAnnotation((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 72: _t->deleteAnnotation(); break;
        case 73: { bool _r = _t->loadMaptoServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 74: { bool _r = _t->isUSBFile();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 75: { QString _r = _t->getUSBFilename();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 76: { bool _r = _t->loadMaptoUSB();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 77: { bool _r = _t->isuseServerMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 78: _t->setuseServerMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 79: _t->removeMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 80: { bool _r = _t->isloadMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 81: _t->setloadMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 82: { bool _r = _t->isExistRobotINI();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 83: _t->makeRobotINI(); break;
        case 84: { bool _r = _t->rotate_map((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 85: { bool _r = _t->getLCMConnection();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 86: { bool _r = _t->getLCMRX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 87: { bool _r = _t->getLCMTX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 88: { bool _r = _t->getLCMProcess();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 89: { bool _r = _t->getIniRead();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 90: { int _r = _t->getUsbMapSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 91: { QString _r = _t->getUsbMapPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 92: { QString _r = _t->getUsbMapPathFull((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 93: _t->saveMapfromUsb((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 94: _t->loadMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 95: _t->setMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 96: _t->startMapping((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 97: _t->stopMapping(); break;
        case 98: _t->setSLAMMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 99: _t->saveMapping((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 100: _t->setInitPos((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 101: { float _r = _t->getInitPoseX();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 102: { float _r = _t->getInitPoseY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 103: { float _r = _t->getInitPoseTH();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 104: _t->slam_setInit(); break;
        case 105: _t->slam_run(); break;
        case 106: _t->slam_stop(); break;
        case 107: _t->slam_autoInit(); break;
        case 108: { bool _r = _t->is_slam_running();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 109: { bool _r = _t->getMappingflag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 110: _t->setMappingflag((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 111: { QPixmap _r = _t->getMappingImage();
            if (_a[0]) *reinterpret_cast< QPixmap*>(_a[0]) = std::move(_r); }  break;
        case 112: { QList<int> _r = _t->getListMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 113: { QList<int> _r = _t->getRawListMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 114: _t->pushMapData((*reinterpret_cast< QList<int>(*)>(_a[1]))); break;
        case 115: { bool _r = _t->isconnectJoy();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 116: { float _r = _t->getJoyAxis((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 117: { int _r = _t->getJoyButton((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 118: { QString _r = _t->getKeyboard((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 119: { QString _r = _t->getJoystick((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 120: _t->setRotateAngle((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 121: { int _r = _t->getCanvasSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 122: { int _r = _t->getRedoSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 123: { QVector<int> _r = _t->getLineX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 124: { QVector<int> _r = _t->getLineY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 125: { QString _r = _t->getLineColor((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 126: { float _r = _t->getLineWidth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 127: _t->saveMap((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QList<int>(*)>(_a[4])),(*reinterpret_cast< QList<int>(*)>(_a[5]))); break;
        case 128: _t->startLine((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 129: _t->setLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 130: _t->stopLine(); break;
        case 131: _t->undo(); break;
        case 132: _t->redo(); break;
        case 133: _t->clear_all(); break;
        case 134: _t->setObjPose(); break;
        case 135: _t->setMarginObj(); break;
        case 136: _t->clearMarginObj(); break;
        case 137: _t->setMarginPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 138: { QVector<int> _r = _t->getMarginObj();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 139: { float _r = _t->getMargin();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 140: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 141: { int _r = _t->getLocationSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 142: { QString _r = _t->getLocationName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 143: { QString _r = _t->getLocationTypes((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 144: { float _r = _t->getLocationx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 145: { float _r = _t->getLocationy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 146: { float _r = _t->getLocationth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 147: { float _r = _t->getLidar((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 148: { int _r = _t->getObjectNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 149: { QString _r = _t->getObjectName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 150: { int _r = _t->getObjectPointSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 151: { float _r = _t->getObjectX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 152: { float _r = _t->getObjectY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 153: { int _r = _t->getTempObjectSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 154: { float _r = _t->getTempObjectX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 155: { float _r = _t->getTempObjectY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 156: { int _r = _t->getObjNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 157: { int _r = _t->getObjNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 158: { int _r = _t->getObjPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 159: { int _r = _t->getLocNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 160: { int _r = _t->getLocNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 161: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 162: _t->removeObjectPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 163: _t->removeObjectPointLast(); break;
        case 164: _t->clearObjectPoints(); break;
        case 165: { int _r = _t->getObjectSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 166: _t->addObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 167: _t->addObjectRect((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 168: _t->editObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4]))); break;
        case 169: _t->removeObject((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 170: _t->removeLocation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 171: _t->addLocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< float(*)>(_a[5]))); break;
        case 172: _t->moveLocationPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 173: { int _r = _t->getTlineSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 174: { int _r = _t->getTlineSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 175: { QString _r = _t->getTlineName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 176: { float _r = _t->getTlineX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 177: { float _r = _t->getTlineY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 178: _t->addTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< int(*)>(_a[5]))); break;
        case 179: _t->removeTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 180: { int _r = _t->getTlineNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 181: { bool _r = _t->saveAnnotation((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 182: { bool _r = _t->saveMetaData((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 183: _t->sendMaptoServer(); break;
        case 184: _t->acceptCall((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 185: _t->setTray((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 186: _t->confirmPickup(); break;
        case 187: { QVector<int> _r = _t->getPickuptrays();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 188: _t->moveTo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 189: _t->moveTo((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 190: _t->moveToLast(); break;
        case 191: _t->movePause(); break;
        case 192: _t->moveResume(); break;
        case 193: _t->moveStop(); break;
        case 194: _t->moveManual(); break;
        case 195: _t->moveToCharge(); break;
        case 196: _t->moveToWait(); break;
        case 197: { QString _r = _t->getcurLoc();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 198: { QString _r = _t->getcurTable();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 199: { QVector<float> _r = _t->getcurTarget();
            if (_a[0]) *reinterpret_cast< QVector<float>*>(_a[0]) = std::move(_r); }  break;
        case 200: _t->joyMoveXY((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 201: _t->joyMoveR((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 202: { float _r = _t->getJoyXY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 203: { float _r = _t->getJoyR();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 204: { float _r = _t->getBattery();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 205: { int _r = _t->getState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 206: { int _r = _t->getErrcode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 207: { QString _r = _t->getRobotName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 208: { float _r = _t->getRobotRadius();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 209: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 210: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 211: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 212: { int _r = _t->getRobotState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 213: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 214: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 215: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 216: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 217: { int _r = _t->getLocalPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 218: { float _r = _t->getLocalPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 219: { float _r = _t->getLocalPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 220: { int _r = _t->getuistate();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 221: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 222: { QString _r = _t->getMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 223: { QString _r = _t->getServerMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 224: { QString _r = _t->getServerMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 225: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 226: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 227: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 228: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 229: { QList<int> _r = _t->getMapData((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 230: { QObject* _r = _t->getMapping();
            if (_a[0]) *reinterpret_cast< QObject**>(_a[0]) = std::move(_r); }  break;
        case 231: { QObject* _r = _t->getMinimap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QObject**>(_a[0]) = std::move(_r); }  break;
        case 232: { QObject* _r = _t->getMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QObject**>(_a[0]) = std::move(_r); }  break;
        case 233: { QObject* _r = _t->getRawMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QObject**>(_a[0]) = std::move(_r); }  break;
        case 234: { QString _r = _t->getPatrolFileName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 235: _t->makePatrol(); break;
        case 236: _t->loadPatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 237: _t->savePatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 238: _t->addPatrol((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4])),(*reinterpret_cast< float(*)>(_a[5]))); break;
        case 239: { int _r = _t->getPatrolNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 240: { QString _r = _t->getPatrolType((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 241: { QString _r = _t->getPatrolLocation((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 242: { float _r = _t->getPatrolX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 243: { float _r = _t->getPatrolY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 244: { float _r = _t->getPatrolTH((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 245: _t->removePatrol((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 246: _t->movePatrolUp((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 247: _t->movePatrolDown((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 248: { int _r = _t->getPatrolMode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 249: _t->setPatrolMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 250: _t->startRecordPath(); break;
        case 251: _t->startcurPath(); break;
        case 252: _t->stopcurPath(); break;
        case 253: _t->pausecurPath(); break;
        case 254: _t->runRotateTables(); break;
        case 255: _t->stopRotateTables(); break;
        case 256: _t->startServingTest(); break;
        case 257: _t->stopServingTest(); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 114:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 127:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 4:
            case 3:
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
        if (_id < 258)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 258;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 258)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 258;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
