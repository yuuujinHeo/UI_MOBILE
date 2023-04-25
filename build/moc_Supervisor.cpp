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
    QByteArrayData data[254];
    char stringdata0[3189];
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
QT_MOC_LITERAL(12, 170, 16), // "objecting_update"
QT_MOC_LITERAL(13, 187, 10), // "usb_detect"
QT_MOC_LITERAL(14, 198, 15), // "git_pull_failed"
QT_MOC_LITERAL(15, 214, 16), // "git_pull_success"
QT_MOC_LITERAL(16, 231, 8), // "new_call"
QT_MOC_LITERAL(17, 240, 9), // "isIPCused"
QT_MOC_LITERAL(18, 250, 16), // "getLCMConnection"
QT_MOC_LITERAL(19, 267, 8), // "getLCMRX"
QT_MOC_LITERAL(20, 276, 8), // "getLCMTX"
QT_MOC_LITERAL(21, 285, 13), // "getLCMProcess"
QT_MOC_LITERAL(22, 299, 14), // "programRestart"
QT_MOC_LITERAL(23, 314, 11), // "programExit"
QT_MOC_LITERAL(24, 326, 11), // "programHide"
QT_MOC_LITERAL(25, 338, 8), // "writelog"
QT_MOC_LITERAL(26, 347, 3), // "msg"
QT_MOC_LITERAL(27, 351, 13), // "getRawMapPath"
QT_MOC_LITERAL(28, 365, 4), // "name"
QT_MOC_LITERAL(29, 370, 10), // "getMapPath"
QT_MOC_LITERAL(30, 381, 12), // "getAnnotPath"
QT_MOC_LITERAL(31, 394, 11), // "getMetaPath"
QT_MOC_LITERAL(32, 406, 16), // "getTravelRawPath"
QT_MOC_LITERAL(33, 423, 13), // "getTravelPath"
QT_MOC_LITERAL(34, 437, 11), // "getCostPath"
QT_MOC_LITERAL(35, 449, 10), // "getIniPath"
QT_MOC_LITERAL(36, 460, 10), // "setSetting"
QT_MOC_LITERAL(37, 471, 5), // "value"
QT_MOC_LITERAL(38, 477, 11), // "readSetting"
QT_MOC_LITERAL(39, 489, 8), // "map_name"
QT_MOC_LITERAL(40, 498, 10), // "getSetting"
QT_MOC_LITERAL(41, 509, 5), // "group"
QT_MOC_LITERAL(42, 515, 11), // "setVelocity"
QT_MOC_LITERAL(43, 527, 3), // "vel"
QT_MOC_LITERAL(44, 531, 11), // "getVelocity"
QT_MOC_LITERAL(45, 543, 10), // "getTrayNum"
QT_MOC_LITERAL(46, 554, 11), // "getTableNum"
QT_MOC_LITERAL(47, 566, 11), // "setTableNum"
QT_MOC_LITERAL(48, 578, 9), // "table_num"
QT_MOC_LITERAL(49, 588, 14), // "getTableColNum"
QT_MOC_LITERAL(50, 603, 14), // "setTableColNum"
QT_MOC_LITERAL(51, 618, 7), // "col_num"
QT_MOC_LITERAL(52, 626, 12), // "getRobotType"
QT_MOC_LITERAL(53, 639, 13), // "requestCamera"
QT_MOC_LITERAL(54, 653, 13), // "getLeftCamera"
QT_MOC_LITERAL(55, 667, 14), // "getRightCamera"
QT_MOC_LITERAL(56, 682, 9), // "setCamera"
QT_MOC_LITERAL(57, 692, 4), // "left"
QT_MOC_LITERAL(58, 697, 5), // "right"
QT_MOC_LITERAL(59, 703, 12), // "getCameraNum"
QT_MOC_LITERAL(60, 716, 9), // "getCamera"
QT_MOC_LITERAL(61, 726, 10), // "QList<int>"
QT_MOC_LITERAL(62, 737, 3), // "num"
QT_MOC_LITERAL(63, 741, 15), // "getCameraSerial"
QT_MOC_LITERAL(64, 757, 7), // "pullGit"
QT_MOC_LITERAL(65, 765, 12), // "isNewVersion"
QT_MOC_LITERAL(66, 778, 15), // "getLocalVersion"
QT_MOC_LITERAL(67, 794, 16), // "getServerVersion"
QT_MOC_LITERAL(68, 811, 19), // "getLocalVersionDate"
QT_MOC_LITERAL(69, 831, 20), // "getServerVersionDate"
QT_MOC_LITERAL(70, 852, 22), // "getLocalVersionMessage"
QT_MOC_LITERAL(71, 875, 23), // "getServerVersionMessage"
QT_MOC_LITERAL(72, 899, 15), // "isConnectServer"
QT_MOC_LITERAL(73, 915, 10), // "isExistMap"
QT_MOC_LITERAL(74, 926, 13), // "isExistRawMap"
QT_MOC_LITERAL(75, 940, 15), // "getAvailableMap"
QT_MOC_LITERAL(76, 956, 19), // "getAvailableMapPath"
QT_MOC_LITERAL(77, 976, 14), // "getMapFileSize"
QT_MOC_LITERAL(78, 991, 10), // "getMapFile"
QT_MOC_LITERAL(79, 1002, 16), // "isExistTravelRaw"
QT_MOC_LITERAL(80, 1019, 19), // "isExistTravelEdited"
QT_MOC_LITERAL(81, 1039, 17), // "isExistAnnotation"
QT_MOC_LITERAL(82, 1057, 16), // "deleteAnnotation"
QT_MOC_LITERAL(83, 1074, 15), // "loadMaptoServer"
QT_MOC_LITERAL(84, 1090, 9), // "isUSBFile"
QT_MOC_LITERAL(85, 1100, 14), // "getUSBFilename"
QT_MOC_LITERAL(86, 1115, 12), // "loadMaptoUSB"
QT_MOC_LITERAL(87, 1128, 14), // "isuseServerMap"
QT_MOC_LITERAL(88, 1143, 15), // "setuseServerMap"
QT_MOC_LITERAL(89, 1159, 3), // "use"
QT_MOC_LITERAL(90, 1163, 9), // "removeMap"
QT_MOC_LITERAL(91, 1173, 8), // "filename"
QT_MOC_LITERAL(92, 1182, 9), // "isloadMap"
QT_MOC_LITERAL(93, 1192, 10), // "setloadMap"
QT_MOC_LITERAL(94, 1203, 4), // "load"
QT_MOC_LITERAL(95, 1208, 15), // "isExistRobotINI"
QT_MOC_LITERAL(96, 1224, 12), // "makeRobotINI"
QT_MOC_LITERAL(97, 1237, 10), // "rotate_map"
QT_MOC_LITERAL(98, 1248, 4), // "_src"
QT_MOC_LITERAL(99, 1253, 4), // "_dst"
QT_MOC_LITERAL(100, 1258, 4), // "mode"
QT_MOC_LITERAL(101, 1263, 10), // "getIniRead"
QT_MOC_LITERAL(102, 1274, 13), // "getUsbMapSize"
QT_MOC_LITERAL(103, 1288, 13), // "getUsbMapPath"
QT_MOC_LITERAL(104, 1302, 17), // "getUsbMapPathFull"
QT_MOC_LITERAL(105, 1320, 14), // "saveMapfromUsb"
QT_MOC_LITERAL(106, 1335, 4), // "path"
QT_MOC_LITERAL(107, 1340, 7), // "loadMap"
QT_MOC_LITERAL(108, 1348, 6), // "setMap"
QT_MOC_LITERAL(109, 1355, 11), // "restartSLAM"
QT_MOC_LITERAL(110, 1367, 9), // "startSLAM"
QT_MOC_LITERAL(111, 1377, 12), // "startMapping"
QT_MOC_LITERAL(112, 1390, 4), // "grid"
QT_MOC_LITERAL(113, 1395, 11), // "stopMapping"
QT_MOC_LITERAL(114, 1407, 11), // "setSLAMMode"
QT_MOC_LITERAL(115, 1419, 11), // "saveMapping"
QT_MOC_LITERAL(116, 1431, 14), // "startObjecting"
QT_MOC_LITERAL(117, 1446, 13), // "stopObjecting"
QT_MOC_LITERAL(118, 1460, 13), // "saveObjecting"
QT_MOC_LITERAL(119, 1474, 10), // "setInitPos"
QT_MOC_LITERAL(120, 1485, 1), // "x"
QT_MOC_LITERAL(121, 1487, 1), // "y"
QT_MOC_LITERAL(122, 1489, 2), // "th"
QT_MOC_LITERAL(123, 1492, 12), // "getInitPoseX"
QT_MOC_LITERAL(124, 1505, 12), // "getInitPoseY"
QT_MOC_LITERAL(125, 1518, 13), // "getInitPoseTH"
QT_MOC_LITERAL(126, 1532, 12), // "slam_setInit"
QT_MOC_LITERAL(127, 1545, 8), // "slam_run"
QT_MOC_LITERAL(128, 1554, 9), // "slam_stop"
QT_MOC_LITERAL(129, 1564, 13), // "slam_autoInit"
QT_MOC_LITERAL(130, 1578, 15), // "is_slam_running"
QT_MOC_LITERAL(131, 1594, 14), // "getMappingflag"
QT_MOC_LITERAL(132, 1609, 14), // "setMappingflag"
QT_MOC_LITERAL(133, 1624, 4), // "flag"
QT_MOC_LITERAL(134, 1629, 16), // "getObjectingflag"
QT_MOC_LITERAL(135, 1646, 16), // "setObjectingflag"
QT_MOC_LITERAL(136, 1663, 13), // "getnewMapname"
QT_MOC_LITERAL(137, 1677, 11), // "getLastCall"
QT_MOC_LITERAL(138, 1689, 11), // "getCallSize"
QT_MOC_LITERAL(139, 1701, 7), // "getCall"
QT_MOC_LITERAL(140, 1709, 2), // "id"
QT_MOC_LITERAL(141, 1712, 11), // "getCallName"
QT_MOC_LITERAL(142, 1724, 11), // "setCallbell"
QT_MOC_LITERAL(143, 1736, 10), // "acceptCall"
QT_MOC_LITERAL(144, 1747, 3), // "yes"
QT_MOC_LITERAL(145, 1751, 10), // "removeCall"
QT_MOC_LITERAL(146, 1762, 13), // "removeCallAll"
QT_MOC_LITERAL(147, 1776, 12), // "isconnectJoy"
QT_MOC_LITERAL(148, 1789, 10), // "getJoyAxis"
QT_MOC_LITERAL(149, 1800, 12), // "getJoyButton"
QT_MOC_LITERAL(150, 1813, 11), // "getKeyboard"
QT_MOC_LITERAL(151, 1825, 11), // "getJoystick"
QT_MOC_LITERAL(152, 1837, 10), // "setObjPose"
QT_MOC_LITERAL(153, 1848, 14), // "getLocationNum"
QT_MOC_LITERAL(154, 1863, 15), // "getLocationSize"
QT_MOC_LITERAL(155, 1879, 4), // "type"
QT_MOC_LITERAL(156, 1884, 15), // "getLocationName"
QT_MOC_LITERAL(157, 1900, 16), // "getLocationTypes"
QT_MOC_LITERAL(158, 1917, 12), // "getLocationx"
QT_MOC_LITERAL(159, 1930, 12), // "getLocationy"
QT_MOC_LITERAL(160, 1943, 13), // "getLocationth"
QT_MOC_LITERAL(161, 1957, 19), // "getRestingLocationx"
QT_MOC_LITERAL(162, 1977, 19), // "getRestingLocationy"
QT_MOC_LITERAL(163, 1997, 20), // "getRestingLocationth"
QT_MOC_LITERAL(164, 2018, 15), // "isExistLocation"
QT_MOC_LITERAL(165, 2034, 8), // "getLidar"
QT_MOC_LITERAL(166, 2043, 16), // "getAnnotEditFlag"
QT_MOC_LITERAL(167, 2060, 16), // "setAnnotEditFlag"
QT_MOC_LITERAL(168, 2077, 12), // "getObjectNum"
QT_MOC_LITERAL(169, 2090, 13), // "getObjectName"
QT_MOC_LITERAL(170, 2104, 18), // "getObjectPointSize"
QT_MOC_LITERAL(171, 2123, 10), // "getObjectX"
QT_MOC_LITERAL(172, 2134, 5), // "point"
QT_MOC_LITERAL(173, 2140, 10), // "getObjectY"
QT_MOC_LITERAL(174, 2151, 14), // "getObjPointNum"
QT_MOC_LITERAL(175, 2166, 7), // "obj_num"
QT_MOC_LITERAL(176, 2174, 9), // "getLocNum"
QT_MOC_LITERAL(177, 2184, 13), // "getObjectSize"
QT_MOC_LITERAL(178, 2198, 12), // "removeObject"
QT_MOC_LITERAL(179, 2211, 14), // "removeLocation"
QT_MOC_LITERAL(180, 2226, 14), // "saveAnnotation"
QT_MOC_LITERAL(181, 2241, 15), // "sendMaptoServer"
QT_MOC_LITERAL(182, 2257, 7), // "setTray"
QT_MOC_LITERAL(183, 2265, 8), // "tray_num"
QT_MOC_LITERAL(184, 2274, 13), // "confirmPickup"
QT_MOC_LITERAL(185, 2288, 14), // "getPickuptrays"
QT_MOC_LITERAL(186, 2303, 12), // "QVector<int>"
QT_MOC_LITERAL(187, 2316, 6), // "moveTo"
QT_MOC_LITERAL(188, 2323, 10), // "target_num"
QT_MOC_LITERAL(189, 2334, 10), // "moveToLast"
QT_MOC_LITERAL(190, 2345, 9), // "movePause"
QT_MOC_LITERAL(191, 2355, 10), // "moveResume"
QT_MOC_LITERAL(192, 2366, 8), // "moveStop"
QT_MOC_LITERAL(193, 2375, 10), // "moveManual"
QT_MOC_LITERAL(194, 2386, 12), // "moveToCharge"
QT_MOC_LITERAL(195, 2399, 10), // "moveToWait"
QT_MOC_LITERAL(196, 2410, 9), // "getcurLoc"
QT_MOC_LITERAL(197, 2420, 11), // "getcurTable"
QT_MOC_LITERAL(198, 2432, 9), // "joyMoveXY"
QT_MOC_LITERAL(199, 2442, 8), // "joyMoveR"
QT_MOC_LITERAL(200, 2451, 1), // "r"
QT_MOC_LITERAL(201, 2453, 8), // "getJoyXY"
QT_MOC_LITERAL(202, 2462, 7), // "getJoyR"
QT_MOC_LITERAL(203, 2470, 16), // "resetHomeFolders"
QT_MOC_LITERAL(204, 2487, 10), // "getBattery"
QT_MOC_LITERAL(205, 2498, 13), // "getMotorState"
QT_MOC_LITERAL(206, 2512, 20), // "getLocalizationState"
QT_MOC_LITERAL(207, 2533, 14), // "getStateMoving"
QT_MOC_LITERAL(208, 2548, 11), // "getObsState"
QT_MOC_LITERAL(209, 2560, 10), // "getErrcode"
QT_MOC_LITERAL(210, 2571, 12), // "getRobotName"
QT_MOC_LITERAL(211, 2584, 18), // "getMotorConnection"
QT_MOC_LITERAL(212, 2603, 14), // "getMotorStatus"
QT_MOC_LITERAL(213, 2618, 17), // "getMotorStatusStr"
QT_MOC_LITERAL(214, 2636, 19), // "getMotorTemperature"
QT_MOC_LITERAL(215, 2656, 26), // "getMotorWarningTemperature"
QT_MOC_LITERAL(216, 2683, 15), // "getMotorCurrent"
QT_MOC_LITERAL(217, 2699, 14), // "getPowerStatus"
QT_MOC_LITERAL(218, 2714, 15), // "getRemoteStatus"
QT_MOC_LITERAL(219, 2730, 15), // "getChargeStatus"
QT_MOC_LITERAL(220, 2746, 12), // "getEmoStatus"
QT_MOC_LITERAL(221, 2759, 12), // "getBatteryIn"
QT_MOC_LITERAL(222, 2772, 13), // "getBatteryOut"
QT_MOC_LITERAL(223, 2786, 17), // "getBatteryCurrent"
QT_MOC_LITERAL(224, 2804, 8), // "getPower"
QT_MOC_LITERAL(225, 2813, 13), // "getPowerTotal"
QT_MOC_LITERAL(226, 2827, 14), // "getRobotRadius"
QT_MOC_LITERAL(227, 2842, 9), // "getRobotx"
QT_MOC_LITERAL(228, 2852, 9), // "getRoboty"
QT_MOC_LITERAL(229, 2862, 10), // "getRobotth"
QT_MOC_LITERAL(230, 2873, 13), // "getlastRobotx"
QT_MOC_LITERAL(231, 2887, 13), // "getlastRoboty"
QT_MOC_LITERAL(232, 2901, 14), // "getlastRobotth"
QT_MOC_LITERAL(233, 2916, 10), // "getPathNum"
QT_MOC_LITERAL(234, 2927, 8), // "getPathx"
QT_MOC_LITERAL(235, 2936, 8), // "getPathy"
QT_MOC_LITERAL(236, 2945, 9), // "getPathth"
QT_MOC_LITERAL(237, 2955, 15), // "getLocalPathNum"
QT_MOC_LITERAL(238, 2971, 13), // "getLocalPathx"
QT_MOC_LITERAL(239, 2985, 13), // "getLocalPathy"
QT_MOC_LITERAL(240, 2999, 10), // "getuistate"
QT_MOC_LITERAL(241, 3010, 8), // "initdone"
QT_MOC_LITERAL(242, 3019, 10), // "getMapname"
QT_MOC_LITERAL(243, 3030, 10), // "getMappath"
QT_MOC_LITERAL(244, 3041, 16), // "getServerMapname"
QT_MOC_LITERAL(245, 3058, 16), // "getServerMappath"
QT_MOC_LITERAL(246, 3075, 11), // "getMapWidth"
QT_MOC_LITERAL(247, 3087, 12), // "getMapHeight"
QT_MOC_LITERAL(248, 3100, 12), // "getGridWidth"
QT_MOC_LITERAL(249, 3113, 9), // "getOrigin"
QT_MOC_LITERAL(250, 3123, 15), // "runRotateTables"
QT_MOC_LITERAL(251, 3139, 16), // "stopRotateTables"
QT_MOC_LITERAL(252, 3156, 16), // "startServingTest"
QT_MOC_LITERAL(253, 3173, 15) // "stopServingTest"

    },
    "Supervisor\0onTimer\0\0server_cmd_pause\0"
    "server_cmd_resume\0server_cmd_newtarget\0"
    "server_cmd_newcall\0server_cmd_setini\0"
    "server_get_map\0path_changed\0camera_update\0"
    "mapping_update\0objecting_update\0"
    "usb_detect\0git_pull_failed\0git_pull_success\0"
    "new_call\0isIPCused\0getLCMConnection\0"
    "getLCMRX\0getLCMTX\0getLCMProcess\0"
    "programRestart\0programExit\0programHide\0"
    "writelog\0msg\0getRawMapPath\0name\0"
    "getMapPath\0getAnnotPath\0getMetaPath\0"
    "getTravelRawPath\0getTravelPath\0"
    "getCostPath\0getIniPath\0setSetting\0"
    "value\0readSetting\0map_name\0getSetting\0"
    "group\0setVelocity\0vel\0getVelocity\0"
    "getTrayNum\0getTableNum\0setTableNum\0"
    "table_num\0getTableColNum\0setTableColNum\0"
    "col_num\0getRobotType\0requestCamera\0"
    "getLeftCamera\0getRightCamera\0setCamera\0"
    "left\0right\0getCameraNum\0getCamera\0"
    "QList<int>\0num\0getCameraSerial\0pullGit\0"
    "isNewVersion\0getLocalVersion\0"
    "getServerVersion\0getLocalVersionDate\0"
    "getServerVersionDate\0getLocalVersionMessage\0"
    "getServerVersionMessage\0isConnectServer\0"
    "isExistMap\0isExistRawMap\0getAvailableMap\0"
    "getAvailableMapPath\0getMapFileSize\0"
    "getMapFile\0isExistTravelRaw\0"
    "isExistTravelEdited\0isExistAnnotation\0"
    "deleteAnnotation\0loadMaptoServer\0"
    "isUSBFile\0getUSBFilename\0loadMaptoUSB\0"
    "isuseServerMap\0setuseServerMap\0use\0"
    "removeMap\0filename\0isloadMap\0setloadMap\0"
    "load\0isExistRobotINI\0makeRobotINI\0"
    "rotate_map\0_src\0_dst\0mode\0getIniRead\0"
    "getUsbMapSize\0getUsbMapPath\0"
    "getUsbMapPathFull\0saveMapfromUsb\0path\0"
    "loadMap\0setMap\0restartSLAM\0startSLAM\0"
    "startMapping\0grid\0stopMapping\0setSLAMMode\0"
    "saveMapping\0startObjecting\0stopObjecting\0"
    "saveObjecting\0setInitPos\0x\0y\0th\0"
    "getInitPoseX\0getInitPoseY\0getInitPoseTH\0"
    "slam_setInit\0slam_run\0slam_stop\0"
    "slam_autoInit\0is_slam_running\0"
    "getMappingflag\0setMappingflag\0flag\0"
    "getObjectingflag\0setObjectingflag\0"
    "getnewMapname\0getLastCall\0getCallSize\0"
    "getCall\0id\0getCallName\0setCallbell\0"
    "acceptCall\0yes\0removeCall\0removeCallAll\0"
    "isconnectJoy\0getJoyAxis\0getJoyButton\0"
    "getKeyboard\0getJoystick\0setObjPose\0"
    "getLocationNum\0getLocationSize\0type\0"
    "getLocationName\0getLocationTypes\0"
    "getLocationx\0getLocationy\0getLocationth\0"
    "getRestingLocationx\0getRestingLocationy\0"
    "getRestingLocationth\0isExistLocation\0"
    "getLidar\0getAnnotEditFlag\0setAnnotEditFlag\0"
    "getObjectNum\0getObjectName\0"
    "getObjectPointSize\0getObjectX\0point\0"
    "getObjectY\0getObjPointNum\0obj_num\0"
    "getLocNum\0getObjectSize\0removeObject\0"
    "removeLocation\0saveAnnotation\0"
    "sendMaptoServer\0setTray\0tray_num\0"
    "confirmPickup\0getPickuptrays\0QVector<int>\0"
    "moveTo\0target_num\0moveToLast\0movePause\0"
    "moveResume\0moveStop\0moveManual\0"
    "moveToCharge\0moveToWait\0getcurLoc\0"
    "getcurTable\0joyMoveXY\0joyMoveR\0r\0"
    "getJoyXY\0getJoyR\0resetHomeFolders\0"
    "getBattery\0getMotorState\0getLocalizationState\0"
    "getStateMoving\0getObsState\0getErrcode\0"
    "getRobotName\0getMotorConnection\0"
    "getMotorStatus\0getMotorStatusStr\0"
    "getMotorTemperature\0getMotorWarningTemperature\0"
    "getMotorCurrent\0getPowerStatus\0"
    "getRemoteStatus\0getChargeStatus\0"
    "getEmoStatus\0getBatteryIn\0getBatteryOut\0"
    "getBatteryCurrent\0getPower\0getPowerTotal\0"
    "getRobotRadius\0getRobotx\0getRoboty\0"
    "getRobotth\0getlastRobotx\0getlastRoboty\0"
    "getlastRobotth\0getPathNum\0getPathx\0"
    "getPathy\0getPathth\0getLocalPathNum\0"
    "getLocalPathx\0getLocalPathy\0getuistate\0"
    "initdone\0getMapname\0getMappath\0"
    "getServerMapname\0getServerMappath\0"
    "getMapWidth\0getMapHeight\0getGridWidth\0"
    "getOrigin\0runRotateTables\0stopRotateTables\0"
    "startServingTest\0stopServingTest"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Supervisor[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
     223,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0, 1129,    2, 0x0a /* Public */,
       3,    0, 1130,    2, 0x0a /* Public */,
       4,    0, 1131,    2, 0x0a /* Public */,
       5,    0, 1132,    2, 0x0a /* Public */,
       6,    0, 1133,    2, 0x0a /* Public */,
       7,    0, 1134,    2, 0x0a /* Public */,
       8,    0, 1135,    2, 0x0a /* Public */,
       9,    0, 1136,    2, 0x0a /* Public */,
      10,    0, 1137,    2, 0x0a /* Public */,
      11,    0, 1138,    2, 0x0a /* Public */,
      12,    0, 1139,    2, 0x0a /* Public */,
      13,    0, 1140,    2, 0x0a /* Public */,
      14,    0, 1141,    2, 0x0a /* Public */,
      15,    0, 1142,    2, 0x0a /* Public */,
      16,    0, 1143,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      17,    0, 1144,    2, 0x02 /* Public */,
      18,    0, 1145,    2, 0x02 /* Public */,
      19,    0, 1146,    2, 0x02 /* Public */,
      20,    0, 1147,    2, 0x02 /* Public */,
      21,    0, 1148,    2, 0x02 /* Public */,
      22,    0, 1149,    2, 0x02 /* Public */,
      23,    0, 1150,    2, 0x02 /* Public */,
      24,    0, 1151,    2, 0x02 /* Public */,
      25,    1, 1152,    2, 0x02 /* Public */,
      27,    1, 1155,    2, 0x02 /* Public */,
      29,    1, 1158,    2, 0x02 /* Public */,
      30,    1, 1161,    2, 0x02 /* Public */,
      31,    1, 1164,    2, 0x02 /* Public */,
      32,    1, 1167,    2, 0x02 /* Public */,
      33,    1, 1170,    2, 0x02 /* Public */,
      34,    1, 1173,    2, 0x02 /* Public */,
      35,    0, 1176,    2, 0x02 /* Public */,
      36,    2, 1177,    2, 0x02 /* Public */,
      38,    1, 1182,    2, 0x02 /* Public */,
      38,    0, 1185,    2, 0x22 /* Public | MethodCloned */,
      40,    2, 1186,    2, 0x02 /* Public */,
      42,    1, 1191,    2, 0x02 /* Public */,
      44,    0, 1194,    2, 0x02 /* Public */,
      45,    0, 1195,    2, 0x02 /* Public */,
      46,    0, 1196,    2, 0x02 /* Public */,
      47,    1, 1197,    2, 0x02 /* Public */,
      49,    0, 1200,    2, 0x02 /* Public */,
      50,    1, 1201,    2, 0x02 /* Public */,
      52,    0, 1204,    2, 0x02 /* Public */,
      53,    0, 1205,    2, 0x02 /* Public */,
      54,    0, 1206,    2, 0x02 /* Public */,
      55,    0, 1207,    2, 0x02 /* Public */,
      56,    2, 1208,    2, 0x02 /* Public */,
      59,    0, 1213,    2, 0x02 /* Public */,
      60,    1, 1214,    2, 0x02 /* Public */,
      63,    1, 1217,    2, 0x02 /* Public */,
      64,    0, 1220,    2, 0x02 /* Public */,
      65,    0, 1221,    2, 0x02 /* Public */,
      66,    0, 1222,    2, 0x02 /* Public */,
      67,    0, 1223,    2, 0x02 /* Public */,
      68,    0, 1224,    2, 0x02 /* Public */,
      69,    0, 1225,    2, 0x02 /* Public */,
      70,    0, 1226,    2, 0x02 /* Public */,
      71,    0, 1227,    2, 0x02 /* Public */,
      72,    0, 1228,    2, 0x02 /* Public */,
      73,    1, 1229,    2, 0x02 /* Public */,
      74,    1, 1232,    2, 0x02 /* Public */,
      73,    0, 1235,    2, 0x02 /* Public */,
      75,    0, 1236,    2, 0x02 /* Public */,
      76,    1, 1237,    2, 0x02 /* Public */,
      77,    1, 1240,    2, 0x02 /* Public */,
      78,    1, 1243,    2, 0x02 /* Public */,
      79,    1, 1246,    2, 0x02 /* Public */,
      80,    1, 1249,    2, 0x02 /* Public */,
      81,    1, 1252,    2, 0x02 /* Public */,
      82,    0, 1255,    2, 0x02 /* Public */,
      83,    0, 1256,    2, 0x02 /* Public */,
      84,    0, 1257,    2, 0x02 /* Public */,
      85,    0, 1258,    2, 0x02 /* Public */,
      86,    0, 1259,    2, 0x02 /* Public */,
      87,    0, 1260,    2, 0x02 /* Public */,
      88,    1, 1261,    2, 0x02 /* Public */,
      90,    1, 1264,    2, 0x02 /* Public */,
      92,    0, 1267,    2, 0x02 /* Public */,
      93,    1, 1268,    2, 0x02 /* Public */,
      95,    0, 1271,    2, 0x02 /* Public */,
      96,    0, 1272,    2, 0x02 /* Public */,
      97,    3, 1273,    2, 0x02 /* Public */,
     101,    0, 1280,    2, 0x02 /* Public */,
     102,    0, 1281,    2, 0x02 /* Public */,
     103,    1, 1282,    2, 0x02 /* Public */,
     104,    1, 1285,    2, 0x02 /* Public */,
     105,    1, 1288,    2, 0x02 /* Public */,
     107,    1, 1291,    2, 0x02 /* Public */,
     108,    1, 1294,    2, 0x02 /* Public */,
     109,    0, 1297,    2, 0x02 /* Public */,
     110,    0, 1298,    2, 0x02 /* Public */,
     111,    1, 1299,    2, 0x02 /* Public */,
     113,    0, 1302,    2, 0x02 /* Public */,
     114,    1, 1303,    2, 0x02 /* Public */,
     115,    1, 1306,    2, 0x02 /* Public */,
     116,    0, 1309,    2, 0x02 /* Public */,
     117,    0, 1310,    2, 0x02 /* Public */,
     118,    0, 1311,    2, 0x02 /* Public */,
     119,    3, 1312,    2, 0x02 /* Public */,
     123,    0, 1319,    2, 0x02 /* Public */,
     124,    0, 1320,    2, 0x02 /* Public */,
     125,    0, 1321,    2, 0x02 /* Public */,
     126,    0, 1322,    2, 0x02 /* Public */,
     127,    0, 1323,    2, 0x02 /* Public */,
     128,    0, 1324,    2, 0x02 /* Public */,
     129,    0, 1325,    2, 0x02 /* Public */,
     130,    0, 1326,    2, 0x02 /* Public */,
     131,    0, 1327,    2, 0x02 /* Public */,
     132,    1, 1328,    2, 0x02 /* Public */,
     134,    0, 1331,    2, 0x02 /* Public */,
     135,    1, 1332,    2, 0x02 /* Public */,
     136,    0, 1335,    2, 0x02 /* Public */,
     137,    0, 1336,    2, 0x02 /* Public */,
     138,    0, 1337,    2, 0x02 /* Public */,
     139,    1, 1338,    2, 0x02 /* Public */,
     141,    1, 1341,    2, 0x02 /* Public */,
     142,    1, 1344,    2, 0x02 /* Public */,
     143,    1, 1347,    2, 0x02 /* Public */,
     145,    1, 1350,    2, 0x02 /* Public */,
     146,    0, 1353,    2, 0x02 /* Public */,
     147,    0, 1354,    2, 0x02 /* Public */,
     148,    1, 1355,    2, 0x02 /* Public */,
     149,    1, 1358,    2, 0x02 /* Public */,
     150,    1, 1361,    2, 0x02 /* Public */,
     151,    1, 1364,    2, 0x02 /* Public */,
     152,    0, 1367,    2, 0x02 /* Public */,
     153,    0, 1368,    2, 0x02 /* Public */,
     154,    1, 1369,    2, 0x02 /* Public */,
     156,    1, 1372,    2, 0x02 /* Public */,
     157,    1, 1375,    2, 0x02 /* Public */,
     158,    1, 1378,    2, 0x02 /* Public */,
     159,    1, 1381,    2, 0x02 /* Public */,
     160,    1, 1384,    2, 0x02 /* Public */,
     161,    0, 1387,    2, 0x02 /* Public */,
     162,    0, 1388,    2, 0x02 /* Public */,
     163,    0, 1389,    2, 0x02 /* Public */,
     164,    1, 1390,    2, 0x02 /* Public */,
     165,    1, 1393,    2, 0x02 /* Public */,
     166,    0, 1396,    2, 0x02 /* Public */,
     167,    1, 1397,    2, 0x02 /* Public */,
     168,    0, 1400,    2, 0x02 /* Public */,
     169,    1, 1401,    2, 0x02 /* Public */,
     170,    1, 1404,    2, 0x02 /* Public */,
     171,    2, 1407,    2, 0x02 /* Public */,
     173,    2, 1412,    2, 0x02 /* Public */,
     174,    3, 1417,    2, 0x02 /* Public */,
     176,    1, 1424,    2, 0x02 /* Public */,
     176,    2, 1427,    2, 0x02 /* Public */,
     177,    1, 1432,    2, 0x02 /* Public */,
     178,    1, 1435,    2, 0x02 /* Public */,
     179,    1, 1438,    2, 0x02 /* Public */,
     180,    1, 1441,    2, 0x02 /* Public */,
     181,    0, 1444,    2, 0x02 /* Public */,
     182,    2, 1445,    2, 0x02 /* Public */,
     184,    0, 1450,    2, 0x02 /* Public */,
     185,    0, 1451,    2, 0x02 /* Public */,
     187,    1, 1452,    2, 0x02 /* Public */,
     187,    3, 1455,    2, 0x02 /* Public */,
     189,    0, 1462,    2, 0x02 /* Public */,
     190,    0, 1463,    2, 0x02 /* Public */,
     191,    0, 1464,    2, 0x02 /* Public */,
     192,    0, 1465,    2, 0x02 /* Public */,
     193,    0, 1466,    2, 0x02 /* Public */,
     194,    0, 1467,    2, 0x02 /* Public */,
     195,    0, 1468,    2, 0x02 /* Public */,
     196,    0, 1469,    2, 0x02 /* Public */,
     197,    0, 1470,    2, 0x02 /* Public */,
     198,    1, 1471,    2, 0x02 /* Public */,
     199,    1, 1474,    2, 0x02 /* Public */,
     201,    0, 1477,    2, 0x02 /* Public */,
     202,    0, 1478,    2, 0x02 /* Public */,
     203,    0, 1479,    2, 0x02 /* Public */,
     204,    0, 1480,    2, 0x02 /* Public */,
     205,    0, 1481,    2, 0x02 /* Public */,
     206,    0, 1482,    2, 0x02 /* Public */,
     207,    0, 1483,    2, 0x02 /* Public */,
     208,    0, 1484,    2, 0x02 /* Public */,
     209,    0, 1485,    2, 0x02 /* Public */,
     210,    0, 1486,    2, 0x02 /* Public */,
     211,    1, 1487,    2, 0x02 /* Public */,
     212,    1, 1490,    2, 0x02 /* Public */,
     213,    1, 1493,    2, 0x02 /* Public */,
     214,    1, 1496,    2, 0x02 /* Public */,
     215,    0, 1499,    2, 0x02 /* Public */,
     216,    1, 1500,    2, 0x02 /* Public */,
     217,    0, 1503,    2, 0x02 /* Public */,
     218,    0, 1504,    2, 0x02 /* Public */,
     219,    0, 1505,    2, 0x02 /* Public */,
     220,    0, 1506,    2, 0x02 /* Public */,
     221,    0, 1507,    2, 0x02 /* Public */,
     222,    0, 1508,    2, 0x02 /* Public */,
     223,    0, 1509,    2, 0x02 /* Public */,
     224,    0, 1510,    2, 0x02 /* Public */,
     225,    0, 1511,    2, 0x02 /* Public */,
     226,    0, 1512,    2, 0x02 /* Public */,
     227,    0, 1513,    2, 0x02 /* Public */,
     228,    0, 1514,    2, 0x02 /* Public */,
     229,    0, 1515,    2, 0x02 /* Public */,
     230,    0, 1516,    2, 0x02 /* Public */,
     231,    0, 1517,    2, 0x02 /* Public */,
     232,    0, 1518,    2, 0x02 /* Public */,
     233,    0, 1519,    2, 0x02 /* Public */,
     234,    1, 1520,    2, 0x02 /* Public */,
     235,    1, 1523,    2, 0x02 /* Public */,
     236,    1, 1526,    2, 0x02 /* Public */,
     237,    0, 1529,    2, 0x02 /* Public */,
     238,    1, 1530,    2, 0x02 /* Public */,
     239,    1, 1533,    2, 0x02 /* Public */,
     240,    0, 1536,    2, 0x02 /* Public */,
     241,    0, 1537,    2, 0x02 /* Public */,
     242,    0, 1538,    2, 0x02 /* Public */,
     243,    0, 1539,    2, 0x02 /* Public */,
     244,    0, 1540,    2, 0x02 /* Public */,
     245,    0, 1541,    2, 0x02 /* Public */,
     246,    0, 1542,    2, 0x02 /* Public */,
     247,    0, 1543,    2, 0x02 /* Public */,
     248,    0, 1544,    2, 0x02 /* Public */,
     249,    0, 1545,    2, 0x02 /* Public */,
     250,    0, 1546,    2, 0x02 /* Public */,
     251,    0, 1547,    2, 0x02 /* Public */,
     252,    0, 1548,    2, 0x02 /* Public */,
     253,    0, 1549,    2, 0x02 /* Public */,

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
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   26,
    QMetaType::QString, QMetaType::QString,   28,
    QMetaType::QString, QMetaType::QString,   28,
    QMetaType::QString, QMetaType::QString,   28,
    QMetaType::QString, QMetaType::QString,   28,
    QMetaType::QString, QMetaType::QString,   28,
    QMetaType::QString, QMetaType::QString,   28,
    QMetaType::QString, QMetaType::QString,   28,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   28,   37,
    QMetaType::Void, QMetaType::QString,   39,
    QMetaType::Void,
    QMetaType::QString, QMetaType::QString, QMetaType::QString,   41,   28,
    QMetaType::Void, QMetaType::Float,   43,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   48,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   51,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   57,   58,
    QMetaType::Int,
    0x80000000 | 61, QMetaType::Int,   62,
    QMetaType::QString, QMetaType::Int,   62,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool, QMetaType::QString,   28,
    QMetaType::Bool, QMetaType::QString,   28,
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   62,
    QMetaType::Int, QMetaType::QString,   28,
    QMetaType::QString, QMetaType::Int,   62,
    QMetaType::Bool, QMetaType::QString,   28,
    QMetaType::Bool, QMetaType::QString,   28,
    QMetaType::Bool, QMetaType::QString,   28,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   89,
    QMetaType::Void, QMetaType::QString,   91,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   94,
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString, QMetaType::Int,   98,   99,  100,
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   62,
    QMetaType::QString, QMetaType::Int,   62,
    QMetaType::Void, QMetaType::QString,  106,
    QMetaType::Void, QMetaType::QString,   28,
    QMetaType::Void, QMetaType::QString,   28,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Float,  112,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,  100,
    QMetaType::Void, QMetaType::QString,   28,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,  120,  121,  122,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  133,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  133,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,  140,
    QMetaType::QString, QMetaType::QString,  140,
    QMetaType::Void, QMetaType::Int,  140,
    QMetaType::Void, QMetaType::Bool,  144,
    QMetaType::Void, QMetaType::Int,  140,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Float, QMetaType::Int,   62,
    QMetaType::Int, QMetaType::Int,   62,
    QMetaType::QString, QMetaType::Int,  100,
    QMetaType::QString, QMetaType::Int,  100,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::Int, QMetaType::QString,  155,
    QMetaType::QString, QMetaType::Int,   62,
    QMetaType::QString, QMetaType::Int,   62,
    QMetaType::Float, QMetaType::Int,   62,
    QMetaType::Float, QMetaType::Int,   62,
    QMetaType::Float, QMetaType::Int,   62,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Bool, QMetaType::Int,   62,
    QMetaType::Float, QMetaType::Int,   62,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  133,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   62,
    QMetaType::Int, QMetaType::Int,   62,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   62,  172,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   62,  172,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  175,  120,  121,
    QMetaType::Int, QMetaType::QString,   28,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  120,  121,
    QMetaType::Int, QMetaType::QString,  155,
    QMetaType::Void, QMetaType::Int,   62,
    QMetaType::Void, QMetaType::QString,   28,
    QMetaType::Bool, QMetaType::QString,   91,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,  183,   48,
    QMetaType::Void,
    0x80000000 | 186,
    QMetaType::Void, QMetaType::QString,  188,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,  120,  121,  122,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Void, QMetaType::Float,  120,
    QMetaType::Void, QMetaType::Float,  200,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Void,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::QString,
    QMetaType::Bool, QMetaType::Int,  140,
    QMetaType::Int, QMetaType::Int,  140,
    QMetaType::QString, QMetaType::Int,  140,
    QMetaType::Int, QMetaType::Int,  140,
    QMetaType::Int,
    QMetaType::Int, QMetaType::Int,  140,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   62,
    QMetaType::Float, QMetaType::Int,   62,
    QMetaType::Float, QMetaType::Int,   62,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   62,
    QMetaType::Float, QMetaType::Int,   62,
    QMetaType::Int,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float,
    0x80000000 | 186,
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
        case 10: _t->objecting_update(); break;
        case 11: _t->usb_detect(); break;
        case 12: _t->git_pull_failed(); break;
        case 13: _t->git_pull_success(); break;
        case 14: _t->new_call(); break;
        case 15: { bool _r = _t->isIPCused();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 16: { bool _r = _t->getLCMConnection();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 17: { bool _r = _t->getLCMRX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 18: { bool _r = _t->getLCMTX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 19: { bool _r = _t->getLCMProcess();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 20: _t->programRestart(); break;
        case 21: _t->programExit(); break;
        case 22: _t->programHide(); break;
        case 23: _t->writelog((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 24: { QString _r = _t->getRawMapPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 25: { QString _r = _t->getMapPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 26: { QString _r = _t->getAnnotPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 27: { QString _r = _t->getMetaPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 28: { QString _r = _t->getTravelRawPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 29: { QString _r = _t->getTravelPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 30: { QString _r = _t->getCostPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 31: { QString _r = _t->getIniPath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 32: _t->setSetting((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 33: _t->readSetting((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 34: _t->readSetting(); break;
        case 35: { QString _r = _t->getSetting((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 36: _t->setVelocity((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 37: { float _r = _t->getVelocity();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 38: { int _r = _t->getTrayNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 39: { int _r = _t->getTableNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 40: _t->setTableNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 41: { int _r = _t->getTableColNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 42: _t->setTableColNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 43: { QString _r = _t->getRobotType();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 44: _t->requestCamera(); break;
        case 45: { QString _r = _t->getLeftCamera();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 46: { QString _r = _t->getRightCamera();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 47: _t->setCamera((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 48: { int _r = _t->getCameraNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 49: { QList<int> _r = _t->getCamera((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 50: { QString _r = _t->getCameraSerial((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 51: _t->pullGit(); break;
        case 52: { bool _r = _t->isNewVersion();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 53: { QString _r = _t->getLocalVersion();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 54: { QString _r = _t->getServerVersion();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 55: { QString _r = _t->getLocalVersionDate();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 56: { QString _r = _t->getServerVersionDate();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 57: { QString _r = _t->getLocalVersionMessage();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 58: { QString _r = _t->getServerVersionMessage();
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
        case 67: { bool _r = _t->isExistTravelRaw((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 68: { bool _r = _t->isExistTravelEdited((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 69: { bool _r = _t->isExistAnnotation((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 70: _t->deleteAnnotation(); break;
        case 71: { bool _r = _t->loadMaptoServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 72: { bool _r = _t->isUSBFile();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 73: { QString _r = _t->getUSBFilename();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 74: { bool _r = _t->loadMaptoUSB();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 75: { bool _r = _t->isuseServerMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 76: _t->setuseServerMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 77: _t->removeMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 78: { bool _r = _t->isloadMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 79: _t->setloadMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 80: { bool _r = _t->isExistRobotINI();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 81: _t->makeRobotINI(); break;
        case 82: { bool _r = _t->rotate_map((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 83: { bool _r = _t->getIniRead();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 84: { int _r = _t->getUsbMapSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 85: { QString _r = _t->getUsbMapPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 86: { QString _r = _t->getUsbMapPathFull((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 87: _t->saveMapfromUsb((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 88: _t->loadMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 89: _t->setMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 90: _t->restartSLAM(); break;
        case 91: _t->startSLAM(); break;
        case 92: _t->startMapping((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 93: _t->stopMapping(); break;
        case 94: _t->setSLAMMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 95: _t->saveMapping((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 96: _t->startObjecting(); break;
        case 97: _t->stopObjecting(); break;
        case 98: _t->saveObjecting(); break;
        case 99: _t->setInitPos((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 100: { float _r = _t->getInitPoseX();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 101: { float _r = _t->getInitPoseY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 102: { float _r = _t->getInitPoseTH();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 103: _t->slam_setInit(); break;
        case 104: _t->slam_run(); break;
        case 105: _t->slam_stop(); break;
        case 106: _t->slam_autoInit(); break;
        case 107: { bool _r = _t->is_slam_running();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 108: { bool _r = _t->getMappingflag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 109: _t->setMappingflag((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 110: { bool _r = _t->getObjectingflag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 111: _t->setObjectingflag((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 112: { QString _r = _t->getnewMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 113: { QString _r = _t->getLastCall();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 114: { int _r = _t->getCallSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 115: { QString _r = _t->getCall((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 116: { QString _r = _t->getCallName((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 117: _t->setCallbell((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 118: _t->acceptCall((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 119: _t->removeCall((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 120: _t->removeCallAll(); break;
        case 121: { bool _r = _t->isconnectJoy();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 122: { float _r = _t->getJoyAxis((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 123: { int _r = _t->getJoyButton((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 124: { QString _r = _t->getKeyboard((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 125: { QString _r = _t->getJoystick((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 126: _t->setObjPose(); break;
        case 127: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 128: { int _r = _t->getLocationSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 129: { QString _r = _t->getLocationName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 130: { QString _r = _t->getLocationTypes((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 131: { float _r = _t->getLocationx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 132: { float _r = _t->getLocationy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 133: { float _r = _t->getLocationth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 134: { float _r = _t->getRestingLocationx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 135: { float _r = _t->getRestingLocationy();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 136: { float _r = _t->getRestingLocationth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 137: { bool _r = _t->isExistLocation((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 138: { float _r = _t->getLidar((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 139: { bool _r = _t->getAnnotEditFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 140: _t->setAnnotEditFlag((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 141: { int _r = _t->getObjectNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 142: { QString _r = _t->getObjectName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 143: { int _r = _t->getObjectPointSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 144: { float _r = _t->getObjectX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 145: { float _r = _t->getObjectY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 146: { int _r = _t->getObjPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 147: { int _r = _t->getLocNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 148: { int _r = _t->getLocNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 149: { int _r = _t->getObjectSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 150: _t->removeObject((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 151: _t->removeLocation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 152: { bool _r = _t->saveAnnotation((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 153: _t->sendMaptoServer(); break;
        case 154: _t->setTray((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 155: _t->confirmPickup(); break;
        case 156: { QVector<int> _r = _t->getPickuptrays();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 157: _t->moveTo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 158: _t->moveTo((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 159: _t->moveToLast(); break;
        case 160: _t->movePause(); break;
        case 161: _t->moveResume(); break;
        case 162: _t->moveStop(); break;
        case 163: _t->moveManual(); break;
        case 164: _t->moveToCharge(); break;
        case 165: _t->moveToWait(); break;
        case 166: { QString _r = _t->getcurLoc();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 167: { QString _r = _t->getcurTable();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 168: _t->joyMoveXY((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 169: _t->joyMoveR((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 170: { float _r = _t->getJoyXY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 171: { float _r = _t->getJoyR();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 172: _t->resetHomeFolders(); break;
        case 173: { float _r = _t->getBattery();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 174: { int _r = _t->getMotorState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 175: { int _r = _t->getLocalizationState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 176: { int _r = _t->getStateMoving();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 177: { int _r = _t->getObsState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 178: { int _r = _t->getErrcode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 179: { QString _r = _t->getRobotName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 180: { bool _r = _t->getMotorConnection((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 181: { int _r = _t->getMotorStatus((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 182: { QString _r = _t->getMotorStatusStr((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 183: { int _r = _t->getMotorTemperature((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 184: { int _r = _t->getMotorWarningTemperature();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 185: { int _r = _t->getMotorCurrent((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 186: { int _r = _t->getPowerStatus();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 187: { int _r = _t->getRemoteStatus();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 188: { int _r = _t->getChargeStatus();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 189: { int _r = _t->getEmoStatus();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 190: { float _r = _t->getBatteryIn();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 191: { float _r = _t->getBatteryOut();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 192: { float _r = _t->getBatteryCurrent();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 193: { float _r = _t->getPower();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 194: { float _r = _t->getPowerTotal();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 195: { float _r = _t->getRobotRadius();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 196: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 197: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 198: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 199: { float _r = _t->getlastRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 200: { float _r = _t->getlastRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 201: { float _r = _t->getlastRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 202: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 203: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 204: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 205: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 206: { int _r = _t->getLocalPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 207: { float _r = _t->getLocalPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 208: { float _r = _t->getLocalPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 209: { int _r = _t->getuistate();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 210: _t->initdone(); break;
        case 211: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 212: { QString _r = _t->getMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 213: { QString _r = _t->getServerMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 214: { QString _r = _t->getServerMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 215: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 216: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 217: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 218: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 219: _t->runRotateTables(); break;
        case 220: _t->stopRotateTables(); break;
        case 221: _t->startServingTest(); break;
        case 222: _t->stopServingTest(); break;
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
        if (_id < 223)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 223;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 223)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 223;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
