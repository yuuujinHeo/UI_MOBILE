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
    QByteArrayData data[298];
    char stringdata0[3628];
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
QT_MOC_LITERAL(17, 240, 8), // "zip_done"
QT_MOC_LITERAL(18, 249, 10), // "unzip_done"
QT_MOC_LITERAL(19, 260, 10), // "zip_failed"
QT_MOC_LITERAL(20, 271, 12), // "unzip_failed"
QT_MOC_LITERAL(21, 284, 9), // "isIPCused"
QT_MOC_LITERAL(22, 294, 16), // "getLCMConnection"
QT_MOC_LITERAL(23, 311, 8), // "getLCMRX"
QT_MOC_LITERAL(24, 320, 8), // "getLCMTX"
QT_MOC_LITERAL(25, 329, 13), // "getLCMProcess"
QT_MOC_LITERAL(26, 343, 14), // "programRestart"
QT_MOC_LITERAL(27, 358, 11), // "programExit"
QT_MOC_LITERAL(28, 370, 11), // "programHide"
QT_MOC_LITERAL(29, 382, 8), // "writelog"
QT_MOC_LITERAL(30, 391, 3), // "msg"
QT_MOC_LITERAL(31, 395, 13), // "getRawMapPath"
QT_MOC_LITERAL(32, 409, 4), // "name"
QT_MOC_LITERAL(33, 414, 10), // "getMapPath"
QT_MOC_LITERAL(34, 425, 12), // "getAnnotPath"
QT_MOC_LITERAL(35, 438, 11), // "getMetaPath"
QT_MOC_LITERAL(36, 450, 16), // "getTravelRawPath"
QT_MOC_LITERAL(37, 467, 13), // "getTravelPath"
QT_MOC_LITERAL(38, 481, 11), // "getCostPath"
QT_MOC_LITERAL(39, 493, 10), // "getIniPath"
QT_MOC_LITERAL(40, 504, 10), // "setSetting"
QT_MOC_LITERAL(41, 515, 5), // "value"
QT_MOC_LITERAL(42, 521, 11), // "readSetting"
QT_MOC_LITERAL(43, 533, 8), // "map_name"
QT_MOC_LITERAL(44, 542, 10), // "getSetting"
QT_MOC_LITERAL(45, 553, 5), // "group"
QT_MOC_LITERAL(46, 559, 11), // "setVelocity"
QT_MOC_LITERAL(47, 571, 3), // "vel"
QT_MOC_LITERAL(48, 575, 11), // "getVelocity"
QT_MOC_LITERAL(49, 587, 10), // "getTrayNum"
QT_MOC_LITERAL(50, 598, 11), // "getTableNum"
QT_MOC_LITERAL(51, 610, 11), // "setTableNum"
QT_MOC_LITERAL(52, 622, 9), // "table_num"
QT_MOC_LITERAL(53, 632, 14), // "getTableColNum"
QT_MOC_LITERAL(54, 647, 14), // "setTableColNum"
QT_MOC_LITERAL(55, 662, 7), // "col_num"
QT_MOC_LITERAL(56, 670, 12), // "getRobotType"
QT_MOC_LITERAL(57, 683, 13), // "requestCamera"
QT_MOC_LITERAL(58, 697, 13), // "getLeftCamera"
QT_MOC_LITERAL(59, 711, 14), // "getRightCamera"
QT_MOC_LITERAL(60, 726, 9), // "setCamera"
QT_MOC_LITERAL(61, 736, 4), // "left"
QT_MOC_LITERAL(62, 741, 5), // "right"
QT_MOC_LITERAL(63, 747, 12), // "getCameraNum"
QT_MOC_LITERAL(64, 760, 9), // "getCamera"
QT_MOC_LITERAL(65, 770, 10), // "QList<int>"
QT_MOC_LITERAL(66, 781, 3), // "num"
QT_MOC_LITERAL(67, 785, 15), // "getCameraSerial"
QT_MOC_LITERAL(68, 801, 7), // "pullGit"
QT_MOC_LITERAL(69, 809, 12), // "isNewVersion"
QT_MOC_LITERAL(70, 822, 15), // "getLocalVersion"
QT_MOC_LITERAL(71, 838, 16), // "getServerVersion"
QT_MOC_LITERAL(72, 855, 19), // "getLocalVersionDate"
QT_MOC_LITERAL(73, 875, 20), // "getServerVersionDate"
QT_MOC_LITERAL(74, 896, 22), // "getLocalVersionMessage"
QT_MOC_LITERAL(75, 919, 23), // "getServerVersionMessage"
QT_MOC_LITERAL(76, 943, 8), // "readWifi"
QT_MOC_LITERAL(77, 952, 10), // "getWifiNum"
QT_MOC_LITERAL(78, 963, 10), // "getWifiSSD"
QT_MOC_LITERAL(79, 974, 11), // "connectWifi"
QT_MOC_LITERAL(80, 986, 3), // "ssd"
QT_MOC_LITERAL(81, 990, 6), // "passwd"
QT_MOC_LITERAL(82, 997, 6), // "setLog"
QT_MOC_LITERAL(83, 1004, 13), // "getLogLineNum"
QT_MOC_LITERAL(84, 1018, 10), // "getLogLine"
QT_MOC_LITERAL(85, 1029, 10), // "getLogDate"
QT_MOC_LITERAL(86, 1040, 10), // "getLogAuth"
QT_MOC_LITERAL(87, 1051, 13), // "getLogMessage"
QT_MOC_LITERAL(88, 1065, 11), // "readLogList"
QT_MOC_LITERAL(89, 1077, 7), // "readLog"
QT_MOC_LITERAL(90, 1085, 4), // "date"
QT_MOC_LITERAL(91, 1090, 4), // "year"
QT_MOC_LITERAL(92, 1095, 5), // "month"
QT_MOC_LITERAL(93, 1101, 8), // "isHasLog"
QT_MOC_LITERAL(94, 1110, 13), // "getLocaleDate"
QT_MOC_LITERAL(95, 1124, 9), // "updateUSB"
QT_MOC_LITERAL(96, 1134, 10), // "getusbsize"
QT_MOC_LITERAL(97, 1145, 11), // "readusbfile"
QT_MOC_LITERAL(98, 1157, 17), // "readusbrecentfile"
QT_MOC_LITERAL(99, 1175, 14), // "getusbfilesize"
QT_MOC_LITERAL(100, 1190, 10), // "getusbfile"
QT_MOC_LITERAL(101, 1201, 16), // "getusbrecentfile"
QT_MOC_LITERAL(102, 1218, 10), // "getusbname"
QT_MOC_LITERAL(103, 1229, 7), // "readusb"
QT_MOC_LITERAL(104, 1237, 15), // "isConnectServer"
QT_MOC_LITERAL(105, 1253, 10), // "isExistMap"
QT_MOC_LITERAL(106, 1264, 13), // "isExistRawMap"
QT_MOC_LITERAL(107, 1278, 15), // "getAvailableMap"
QT_MOC_LITERAL(108, 1294, 19), // "getAvailableMapPath"
QT_MOC_LITERAL(109, 1314, 14), // "getMapFileSize"
QT_MOC_LITERAL(110, 1329, 10), // "getMapFile"
QT_MOC_LITERAL(111, 1340, 16), // "isExistTravelRaw"
QT_MOC_LITERAL(112, 1357, 19), // "isExistTravelEdited"
QT_MOC_LITERAL(113, 1377, 17), // "isExistAnnotation"
QT_MOC_LITERAL(114, 1395, 16), // "deleteAnnotation"
QT_MOC_LITERAL(115, 1412, 15), // "loadMaptoServer"
QT_MOC_LITERAL(116, 1428, 9), // "isUSBFile"
QT_MOC_LITERAL(117, 1438, 14), // "getUSBFilename"
QT_MOC_LITERAL(118, 1453, 12), // "loadMaptoUSB"
QT_MOC_LITERAL(119, 1466, 14), // "isuseServerMap"
QT_MOC_LITERAL(120, 1481, 15), // "setuseServerMap"
QT_MOC_LITERAL(121, 1497, 3), // "use"
QT_MOC_LITERAL(122, 1501, 9), // "removeMap"
QT_MOC_LITERAL(123, 1511, 8), // "filename"
QT_MOC_LITERAL(124, 1520, 9), // "isloadMap"
QT_MOC_LITERAL(125, 1530, 10), // "setloadMap"
QT_MOC_LITERAL(126, 1541, 4), // "load"
QT_MOC_LITERAL(127, 1546, 15), // "isExistRobotINI"
QT_MOC_LITERAL(128, 1562, 12), // "makeRobotINI"
QT_MOC_LITERAL(129, 1575, 10), // "rotate_map"
QT_MOC_LITERAL(130, 1586, 4), // "_src"
QT_MOC_LITERAL(131, 1591, 4), // "_dst"
QT_MOC_LITERAL(132, 1596, 4), // "mode"
QT_MOC_LITERAL(133, 1601, 10), // "getIniRead"
QT_MOC_LITERAL(134, 1612, 14), // "saveMapfromUsb"
QT_MOC_LITERAL(135, 1627, 4), // "path"
QT_MOC_LITERAL(136, 1632, 7), // "loadMap"
QT_MOC_LITERAL(137, 1640, 6), // "setMap"
QT_MOC_LITERAL(138, 1647, 11), // "restartSLAM"
QT_MOC_LITERAL(139, 1659, 9), // "startSLAM"
QT_MOC_LITERAL(140, 1669, 12), // "startMapping"
QT_MOC_LITERAL(141, 1682, 4), // "grid"
QT_MOC_LITERAL(142, 1687, 11), // "stopMapping"
QT_MOC_LITERAL(143, 1699, 11), // "setSLAMMode"
QT_MOC_LITERAL(144, 1711, 11), // "saveMapping"
QT_MOC_LITERAL(145, 1723, 14), // "startObjecting"
QT_MOC_LITERAL(146, 1738, 13), // "stopObjecting"
QT_MOC_LITERAL(147, 1752, 13), // "saveObjecting"
QT_MOC_LITERAL(148, 1766, 10), // "setInitPos"
QT_MOC_LITERAL(149, 1777, 1), // "x"
QT_MOC_LITERAL(150, 1779, 1), // "y"
QT_MOC_LITERAL(151, 1781, 2), // "th"
QT_MOC_LITERAL(152, 1784, 12), // "getInitPoseX"
QT_MOC_LITERAL(153, 1797, 12), // "getInitPoseY"
QT_MOC_LITERAL(154, 1810, 13), // "getInitPoseTH"
QT_MOC_LITERAL(155, 1824, 12), // "slam_setInit"
QT_MOC_LITERAL(156, 1837, 8), // "slam_run"
QT_MOC_LITERAL(157, 1846, 9), // "slam_stop"
QT_MOC_LITERAL(158, 1856, 13), // "slam_autoInit"
QT_MOC_LITERAL(159, 1870, 15), // "is_slam_running"
QT_MOC_LITERAL(160, 1886, 14), // "getMappingflag"
QT_MOC_LITERAL(161, 1901, 14), // "setMappingflag"
QT_MOC_LITERAL(162, 1916, 4), // "flag"
QT_MOC_LITERAL(163, 1921, 16), // "getObjectingflag"
QT_MOC_LITERAL(164, 1938, 16), // "setObjectingflag"
QT_MOC_LITERAL(165, 1955, 13), // "getnewMapname"
QT_MOC_LITERAL(166, 1969, 11), // "getLastCall"
QT_MOC_LITERAL(167, 1981, 11), // "getCallSize"
QT_MOC_LITERAL(168, 1993, 7), // "getCall"
QT_MOC_LITERAL(169, 2001, 2), // "id"
QT_MOC_LITERAL(170, 2004, 11), // "getCallName"
QT_MOC_LITERAL(171, 2016, 11), // "setCallbell"
QT_MOC_LITERAL(172, 2028, 10), // "acceptCall"
QT_MOC_LITERAL(173, 2039, 3), // "yes"
QT_MOC_LITERAL(174, 2043, 10), // "removeCall"
QT_MOC_LITERAL(175, 2054, 13), // "removeCallAll"
QT_MOC_LITERAL(176, 2068, 12), // "isconnectJoy"
QT_MOC_LITERAL(177, 2081, 10), // "getJoyAxis"
QT_MOC_LITERAL(178, 2092, 12), // "getJoyButton"
QT_MOC_LITERAL(179, 2105, 11), // "getKeyboard"
QT_MOC_LITERAL(180, 2117, 11), // "getJoystick"
QT_MOC_LITERAL(181, 2129, 10), // "setObjPose"
QT_MOC_LITERAL(182, 2140, 14), // "getLocationNum"
QT_MOC_LITERAL(183, 2155, 4), // "type"
QT_MOC_LITERAL(184, 2160, 15), // "getLocationName"
QT_MOC_LITERAL(185, 2176, 15), // "getLocationType"
QT_MOC_LITERAL(186, 2192, 17), // "getLocationNumber"
QT_MOC_LITERAL(187, 2210, 17), // "setLocationNumber"
QT_MOC_LITERAL(188, 2228, 15), // "getLocationSize"
QT_MOC_LITERAL(189, 2244, 12), // "getLocationX"
QT_MOC_LITERAL(190, 2257, 12), // "getLocationY"
QT_MOC_LITERAL(191, 2270, 13), // "getLocationTH"
QT_MOC_LITERAL(192, 2284, 15), // "isExistLocation"
QT_MOC_LITERAL(193, 2300, 8), // "getLidar"
QT_MOC_LITERAL(194, 2309, 16), // "getAnnotEditFlag"
QT_MOC_LITERAL(195, 2326, 16), // "setAnnotEditFlag"
QT_MOC_LITERAL(196, 2343, 17), // "clearSharedMemory"
QT_MOC_LITERAL(197, 2361, 12), // "getObjectNum"
QT_MOC_LITERAL(198, 2374, 13), // "getObjectName"
QT_MOC_LITERAL(199, 2388, 18), // "getObjectPointSize"
QT_MOC_LITERAL(200, 2407, 10), // "getObjectX"
QT_MOC_LITERAL(201, 2418, 5), // "point"
QT_MOC_LITERAL(202, 2424, 10), // "getObjectY"
QT_MOC_LITERAL(203, 2435, 14), // "getObjPointNum"
QT_MOC_LITERAL(204, 2450, 7), // "obj_num"
QT_MOC_LITERAL(205, 2458, 9), // "getLocNum"
QT_MOC_LITERAL(206, 2468, 13), // "getObjectSize"
QT_MOC_LITERAL(207, 2482, 12), // "removeObject"
QT_MOC_LITERAL(208, 2495, 14), // "removeLocation"
QT_MOC_LITERAL(209, 2510, 14), // "saveAnnotation"
QT_MOC_LITERAL(210, 2525, 15), // "sendMaptoServer"
QT_MOC_LITERAL(211, 2541, 7), // "setTray"
QT_MOC_LITERAL(212, 2549, 8), // "tray_num"
QT_MOC_LITERAL(213, 2558, 13), // "confirmPickup"
QT_MOC_LITERAL(214, 2572, 14), // "getPickuptrays"
QT_MOC_LITERAL(215, 2587, 12), // "QVector<int>"
QT_MOC_LITERAL(216, 2600, 6), // "moveTo"
QT_MOC_LITERAL(217, 2607, 10), // "target_num"
QT_MOC_LITERAL(218, 2618, 10), // "moveToLast"
QT_MOC_LITERAL(219, 2629, 9), // "movePause"
QT_MOC_LITERAL(220, 2639, 10), // "moveResume"
QT_MOC_LITERAL(221, 2650, 8), // "moveStop"
QT_MOC_LITERAL(222, 2659, 10), // "moveManual"
QT_MOC_LITERAL(223, 2670, 12), // "moveToCharge"
QT_MOC_LITERAL(224, 2683, 10), // "moveToWait"
QT_MOC_LITERAL(225, 2694, 9), // "getcurLoc"
QT_MOC_LITERAL(226, 2704, 11), // "getcurTable"
QT_MOC_LITERAL(227, 2716, 9), // "joyMoveXY"
QT_MOC_LITERAL(228, 2726, 8), // "joyMoveR"
QT_MOC_LITERAL(229, 2735, 1), // "r"
QT_MOC_LITERAL(230, 2737, 8), // "getJoyXY"
QT_MOC_LITERAL(231, 2746, 7), // "getJoyR"
QT_MOC_LITERAL(232, 2754, 16), // "resetHomeFolders"
QT_MOC_LITERAL(233, 2771, 10), // "getBattery"
QT_MOC_LITERAL(234, 2782, 13), // "getMotorState"
QT_MOC_LITERAL(235, 2796, 20), // "getLocalizationState"
QT_MOC_LITERAL(236, 2817, 14), // "getStateMoving"
QT_MOC_LITERAL(237, 2832, 11), // "getObsState"
QT_MOC_LITERAL(238, 2844, 10), // "getErrcode"
QT_MOC_LITERAL(239, 2855, 12), // "getRobotName"
QT_MOC_LITERAL(240, 2868, 18), // "getMotorConnection"
QT_MOC_LITERAL(241, 2887, 14), // "getMotorStatus"
QT_MOC_LITERAL(242, 2902, 17), // "getMotorStatusStr"
QT_MOC_LITERAL(243, 2920, 19), // "getMotorTemperature"
QT_MOC_LITERAL(244, 2940, 25), // "getMotorInsideTemperature"
QT_MOC_LITERAL(245, 2966, 26), // "getMotorWarningTemperature"
QT_MOC_LITERAL(246, 2993, 15), // "getMotorCurrent"
QT_MOC_LITERAL(247, 3009, 14), // "getPowerStatus"
QT_MOC_LITERAL(248, 3024, 15), // "getRemoteStatus"
QT_MOC_LITERAL(249, 3040, 15), // "getChargeStatus"
QT_MOC_LITERAL(250, 3056, 12), // "getEmoStatus"
QT_MOC_LITERAL(251, 3069, 12), // "getBatteryIn"
QT_MOC_LITERAL(252, 3082, 13), // "getBatteryOut"
QT_MOC_LITERAL(253, 3096, 17), // "getBatteryCurrent"
QT_MOC_LITERAL(254, 3114, 8), // "getPower"
QT_MOC_LITERAL(255, 3123, 13), // "getPowerTotal"
QT_MOC_LITERAL(256, 3137, 14), // "getRobotRadius"
QT_MOC_LITERAL(257, 3152, 9), // "getRobotx"
QT_MOC_LITERAL(258, 3162, 9), // "getRoboty"
QT_MOC_LITERAL(259, 3172, 10), // "getRobotth"
QT_MOC_LITERAL(260, 3183, 13), // "getlastRobotx"
QT_MOC_LITERAL(261, 3197, 13), // "getlastRoboty"
QT_MOC_LITERAL(262, 3211, 14), // "getlastRobotth"
QT_MOC_LITERAL(263, 3226, 10), // "getPathNum"
QT_MOC_LITERAL(264, 3237, 8), // "getPathx"
QT_MOC_LITERAL(265, 3246, 8), // "getPathy"
QT_MOC_LITERAL(266, 3255, 9), // "getPathth"
QT_MOC_LITERAL(267, 3265, 15), // "getLocalPathNum"
QT_MOC_LITERAL(268, 3281, 13), // "getLocalPathx"
QT_MOC_LITERAL(269, 3295, 13), // "getLocalPathy"
QT_MOC_LITERAL(270, 3309, 10), // "getuistate"
QT_MOC_LITERAL(271, 3320, 8), // "initdone"
QT_MOC_LITERAL(272, 3329, 10), // "getMapname"
QT_MOC_LITERAL(273, 3340, 10), // "getMappath"
QT_MOC_LITERAL(274, 3351, 16), // "getServerMapname"
QT_MOC_LITERAL(275, 3368, 16), // "getServerMappath"
QT_MOC_LITERAL(276, 3385, 11), // "getMapWidth"
QT_MOC_LITERAL(277, 3397, 12), // "getMapHeight"
QT_MOC_LITERAL(278, 3410, 12), // "getGridWidth"
QT_MOC_LITERAL(279, 3423, 9), // "getOrigin"
QT_MOC_LITERAL(280, 3433, 15), // "runRotateTables"
QT_MOC_LITERAL(281, 3449, 16), // "stopRotateTables"
QT_MOC_LITERAL(282, 3466, 15), // "clearRotateList"
QT_MOC_LITERAL(283, 3482, 13), // "setRotateList"
QT_MOC_LITERAL(284, 3496, 11), // "startPatrol"
QT_MOC_LITERAL(285, 3508, 6), // "pickup"
QT_MOC_LITERAL(286, 3515, 16), // "startServingTest"
QT_MOC_LITERAL(287, 3532, 15), // "stopServingTest"
QT_MOC_LITERAL(288, 3548, 15), // "getusberrorsize"
QT_MOC_LITERAL(289, 3564, 11), // "getusberror"
QT_MOC_LITERAL(290, 3576, 11), // "getzipstate"
QT_MOC_LITERAL(291, 3588, 7), // "usbsave"
QT_MOC_LITERAL(292, 3596, 3), // "usb"
QT_MOC_LITERAL(293, 3600, 3), // "_ui"
QT_MOC_LITERAL(294, 3604, 5), // "_slam"
QT_MOC_LITERAL(295, 3610, 7), // "_config"
QT_MOC_LITERAL(296, 3618, 4), // "_map"
QT_MOC_LITERAL(297, 3623, 4) // "_log"

    },
    "Supervisor\0onTimer\0\0server_cmd_pause\0"
    "server_cmd_resume\0server_cmd_newtarget\0"
    "server_cmd_newcall\0server_cmd_setini\0"
    "server_get_map\0path_changed\0camera_update\0"
    "mapping_update\0objecting_update\0"
    "usb_detect\0git_pull_failed\0git_pull_success\0"
    "new_call\0zip_done\0unzip_done\0zip_failed\0"
    "unzip_failed\0isIPCused\0getLCMConnection\0"
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
    "getServerVersionMessage\0readWifi\0"
    "getWifiNum\0getWifiSSD\0connectWifi\0ssd\0"
    "passwd\0setLog\0getLogLineNum\0getLogLine\0"
    "getLogDate\0getLogAuth\0getLogMessage\0"
    "readLogList\0readLog\0date\0year\0month\0"
    "isHasLog\0getLocaleDate\0updateUSB\0"
    "getusbsize\0readusbfile\0readusbrecentfile\0"
    "getusbfilesize\0getusbfile\0getusbrecentfile\0"
    "getusbname\0readusb\0isConnectServer\0"
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
    "saveMapfromUsb\0path\0loadMap\0setMap\0"
    "restartSLAM\0startSLAM\0startMapping\0"
    "grid\0stopMapping\0setSLAMMode\0saveMapping\0"
    "startObjecting\0stopObjecting\0saveObjecting\0"
    "setInitPos\0x\0y\0th\0getInitPoseX\0"
    "getInitPoseY\0getInitPoseTH\0slam_setInit\0"
    "slam_run\0slam_stop\0slam_autoInit\0"
    "is_slam_running\0getMappingflag\0"
    "setMappingflag\0flag\0getObjectingflag\0"
    "setObjectingflag\0getnewMapname\0"
    "getLastCall\0getCallSize\0getCall\0id\0"
    "getCallName\0setCallbell\0acceptCall\0"
    "yes\0removeCall\0removeCallAll\0isconnectJoy\0"
    "getJoyAxis\0getJoyButton\0getKeyboard\0"
    "getJoystick\0setObjPose\0getLocationNum\0"
    "type\0getLocationName\0getLocationType\0"
    "getLocationNumber\0setLocationNumber\0"
    "getLocationSize\0getLocationX\0getLocationY\0"
    "getLocationTH\0isExistLocation\0getLidar\0"
    "getAnnotEditFlag\0setAnnotEditFlag\0"
    "clearSharedMemory\0getObjectNum\0"
    "getObjectName\0getObjectPointSize\0"
    "getObjectX\0point\0getObjectY\0getObjPointNum\0"
    "obj_num\0getLocNum\0getObjectSize\0"
    "removeObject\0removeLocation\0saveAnnotation\0"
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
    "getMotorTemperature\0getMotorInsideTemperature\0"
    "getMotorWarningTemperature\0getMotorCurrent\0"
    "getPowerStatus\0getRemoteStatus\0"
    "getChargeStatus\0getEmoStatus\0getBatteryIn\0"
    "getBatteryOut\0getBatteryCurrent\0"
    "getPower\0getPowerTotal\0getRobotRadius\0"
    "getRobotx\0getRoboty\0getRobotth\0"
    "getlastRobotx\0getlastRoboty\0getlastRobotth\0"
    "getPathNum\0getPathx\0getPathy\0getPathth\0"
    "getLocalPathNum\0getLocalPathx\0"
    "getLocalPathy\0getuistate\0initdone\0"
    "getMapname\0getMappath\0getServerMapname\0"
    "getServerMappath\0getMapWidth\0getMapHeight\0"
    "getGridWidth\0getOrigin\0runRotateTables\0"
    "stopRotateTables\0clearRotateList\0"
    "setRotateList\0startPatrol\0pickup\0"
    "startServingTest\0stopServingTest\0"
    "getusberrorsize\0getusberror\0getzipstate\0"
    "usbsave\0usb\0_ui\0_slam\0_config\0_map\0"
    "_log"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Supervisor[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
     268,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0, 1354,    2, 0x0a /* Public */,
       3,    0, 1355,    2, 0x0a /* Public */,
       4,    0, 1356,    2, 0x0a /* Public */,
       5,    0, 1357,    2, 0x0a /* Public */,
       6,    0, 1358,    2, 0x0a /* Public */,
       7,    0, 1359,    2, 0x0a /* Public */,
       8,    0, 1360,    2, 0x0a /* Public */,
       9,    0, 1361,    2, 0x0a /* Public */,
      10,    0, 1362,    2, 0x0a /* Public */,
      11,    0, 1363,    2, 0x0a /* Public */,
      12,    0, 1364,    2, 0x0a /* Public */,
      13,    0, 1365,    2, 0x0a /* Public */,
      14,    0, 1366,    2, 0x0a /* Public */,
      15,    0, 1367,    2, 0x0a /* Public */,
      16,    0, 1368,    2, 0x0a /* Public */,
      17,    0, 1369,    2, 0x0a /* Public */,
      18,    0, 1370,    2, 0x0a /* Public */,
      19,    0, 1371,    2, 0x0a /* Public */,
      20,    0, 1372,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      21,    0, 1373,    2, 0x02 /* Public */,
      22,    0, 1374,    2, 0x02 /* Public */,
      23,    0, 1375,    2, 0x02 /* Public */,
      24,    0, 1376,    2, 0x02 /* Public */,
      25,    0, 1377,    2, 0x02 /* Public */,
      26,    0, 1378,    2, 0x02 /* Public */,
      27,    0, 1379,    2, 0x02 /* Public */,
      28,    0, 1380,    2, 0x02 /* Public */,
      29,    1, 1381,    2, 0x02 /* Public */,
      31,    1, 1384,    2, 0x02 /* Public */,
      33,    1, 1387,    2, 0x02 /* Public */,
      34,    1, 1390,    2, 0x02 /* Public */,
      35,    1, 1393,    2, 0x02 /* Public */,
      36,    1, 1396,    2, 0x02 /* Public */,
      37,    1, 1399,    2, 0x02 /* Public */,
      38,    1, 1402,    2, 0x02 /* Public */,
      39,    0, 1405,    2, 0x02 /* Public */,
      40,    2, 1406,    2, 0x02 /* Public */,
      42,    1, 1411,    2, 0x02 /* Public */,
      42,    0, 1414,    2, 0x22 /* Public | MethodCloned */,
      44,    2, 1415,    2, 0x02 /* Public */,
      46,    1, 1420,    2, 0x02 /* Public */,
      48,    0, 1423,    2, 0x02 /* Public */,
      49,    0, 1424,    2, 0x02 /* Public */,
      50,    0, 1425,    2, 0x02 /* Public */,
      51,    1, 1426,    2, 0x02 /* Public */,
      53,    0, 1429,    2, 0x02 /* Public */,
      54,    1, 1430,    2, 0x02 /* Public */,
      56,    0, 1433,    2, 0x02 /* Public */,
      57,    0, 1434,    2, 0x02 /* Public */,
      58,    0, 1435,    2, 0x02 /* Public */,
      59,    0, 1436,    2, 0x02 /* Public */,
      60,    2, 1437,    2, 0x02 /* Public */,
      63,    0, 1442,    2, 0x02 /* Public */,
      64,    1, 1443,    2, 0x02 /* Public */,
      67,    1, 1446,    2, 0x02 /* Public */,
      68,    0, 1449,    2, 0x02 /* Public */,
      69,    0, 1450,    2, 0x02 /* Public */,
      70,    0, 1451,    2, 0x02 /* Public */,
      71,    0, 1452,    2, 0x02 /* Public */,
      72,    0, 1453,    2, 0x02 /* Public */,
      73,    0, 1454,    2, 0x02 /* Public */,
      74,    0, 1455,    2, 0x02 /* Public */,
      75,    0, 1456,    2, 0x02 /* Public */,
      76,    0, 1457,    2, 0x02 /* Public */,
      77,    0, 1458,    2, 0x02 /* Public */,
      78,    1, 1459,    2, 0x02 /* Public */,
      79,    2, 1462,    2, 0x02 /* Public */,
      82,    1, 1467,    2, 0x02 /* Public */,
      83,    0, 1470,    2, 0x02 /* Public */,
      84,    1, 1471,    2, 0x02 /* Public */,
      85,    1, 1474,    2, 0x02 /* Public */,
      86,    1, 1477,    2, 0x02 /* Public */,
      87,    1, 1480,    2, 0x02 /* Public */,
      88,    0, 1483,    2, 0x02 /* Public */,
      89,    1, 1484,    2, 0x02 /* Public */,
      89,    3, 1487,    2, 0x02 /* Public */,
      93,    1, 1494,    2, 0x02 /* Public */,
      93,    3, 1497,    2, 0x02 /* Public */,
      94,    3, 1504,    2, 0x02 /* Public */,
      95,    0, 1511,    2, 0x02 /* Public */,
      96,    0, 1512,    2, 0x02 /* Public */,
      97,    1, 1513,    2, 0x02 /* Public */,
      98,    0, 1516,    2, 0x02 /* Public */,
      99,    0, 1517,    2, 0x02 /* Public */,
     100,    1, 1518,    2, 0x02 /* Public */,
     101,    0, 1521,    2, 0x02 /* Public */,
     102,    1, 1522,    2, 0x02 /* Public */,
     103,    0, 1525,    2, 0x02 /* Public */,
     104,    0, 1526,    2, 0x02 /* Public */,
     105,    1, 1527,    2, 0x02 /* Public */,
     106,    1, 1530,    2, 0x02 /* Public */,
     105,    0, 1533,    2, 0x02 /* Public */,
     107,    0, 1534,    2, 0x02 /* Public */,
     108,    1, 1535,    2, 0x02 /* Public */,
     109,    1, 1538,    2, 0x02 /* Public */,
     110,    1, 1541,    2, 0x02 /* Public */,
     111,    1, 1544,    2, 0x02 /* Public */,
     112,    1, 1547,    2, 0x02 /* Public */,
     113,    1, 1550,    2, 0x02 /* Public */,
     114,    0, 1553,    2, 0x02 /* Public */,
     115,    0, 1554,    2, 0x02 /* Public */,
     116,    0, 1555,    2, 0x02 /* Public */,
     117,    0, 1556,    2, 0x02 /* Public */,
     118,    0, 1557,    2, 0x02 /* Public */,
     119,    0, 1558,    2, 0x02 /* Public */,
     120,    1, 1559,    2, 0x02 /* Public */,
     122,    1, 1562,    2, 0x02 /* Public */,
     124,    0, 1565,    2, 0x02 /* Public */,
     125,    1, 1566,    2, 0x02 /* Public */,
     127,    0, 1569,    2, 0x02 /* Public */,
     128,    0, 1570,    2, 0x02 /* Public */,
     129,    3, 1571,    2, 0x02 /* Public */,
     133,    0, 1578,    2, 0x02 /* Public */,
     134,    1, 1579,    2, 0x02 /* Public */,
     136,    1, 1582,    2, 0x02 /* Public */,
     137,    1, 1585,    2, 0x02 /* Public */,
     138,    0, 1588,    2, 0x02 /* Public */,
     139,    0, 1589,    2, 0x02 /* Public */,
     140,    1, 1590,    2, 0x02 /* Public */,
     142,    0, 1593,    2, 0x02 /* Public */,
     143,    1, 1594,    2, 0x02 /* Public */,
     144,    1, 1597,    2, 0x02 /* Public */,
     145,    0, 1600,    2, 0x02 /* Public */,
     146,    0, 1601,    2, 0x02 /* Public */,
     147,    0, 1602,    2, 0x02 /* Public */,
     148,    3, 1603,    2, 0x02 /* Public */,
     152,    0, 1610,    2, 0x02 /* Public */,
     153,    0, 1611,    2, 0x02 /* Public */,
     154,    0, 1612,    2, 0x02 /* Public */,
     155,    0, 1613,    2, 0x02 /* Public */,
     156,    0, 1614,    2, 0x02 /* Public */,
     157,    0, 1615,    2, 0x02 /* Public */,
     158,    0, 1616,    2, 0x02 /* Public */,
     159,    0, 1617,    2, 0x02 /* Public */,
     160,    0, 1618,    2, 0x02 /* Public */,
     161,    1, 1619,    2, 0x02 /* Public */,
     163,    0, 1622,    2, 0x02 /* Public */,
     164,    1, 1623,    2, 0x02 /* Public */,
     165,    0, 1626,    2, 0x02 /* Public */,
     166,    0, 1627,    2, 0x02 /* Public */,
     167,    0, 1628,    2, 0x02 /* Public */,
     168,    1, 1629,    2, 0x02 /* Public */,
     170,    1, 1632,    2, 0x02 /* Public */,
     171,    1, 1635,    2, 0x02 /* Public */,
     172,    1, 1638,    2, 0x02 /* Public */,
     174,    1, 1641,    2, 0x02 /* Public */,
     175,    0, 1644,    2, 0x02 /* Public */,
     176,    0, 1645,    2, 0x02 /* Public */,
     177,    1, 1646,    2, 0x02 /* Public */,
     178,    1, 1649,    2, 0x02 /* Public */,
     179,    1, 1652,    2, 0x02 /* Public */,
     180,    1, 1655,    2, 0x02 /* Public */,
     181,    0, 1658,    2, 0x02 /* Public */,
     182,    1, 1659,    2, 0x02 /* Public */,
     182,    0, 1662,    2, 0x22 /* Public | MethodCloned */,
     184,    2, 1663,    2, 0x02 /* Public */,
     184,    1, 1668,    2, 0x22 /* Public | MethodCloned */,
     185,    1, 1671,    2, 0x02 /* Public */,
     186,    1, 1674,    2, 0x02 /* Public */,
     187,    2, 1677,    2, 0x02 /* Public */,
     188,    1, 1682,    2, 0x02 /* Public */,
     189,    2, 1685,    2, 0x02 /* Public */,
     189,    1, 1690,    2, 0x22 /* Public | MethodCloned */,
     190,    2, 1693,    2, 0x02 /* Public */,
     190,    1, 1698,    2, 0x22 /* Public | MethodCloned */,
     191,    2, 1701,    2, 0x02 /* Public */,
     191,    1, 1706,    2, 0x22 /* Public | MethodCloned */,
     192,    1, 1709,    2, 0x02 /* Public */,
     193,    1, 1712,    2, 0x02 /* Public */,
     194,    0, 1715,    2, 0x02 /* Public */,
     195,    1, 1716,    2, 0x02 /* Public */,
     196,    0, 1719,    2, 0x02 /* Public */,
     197,    0, 1720,    2, 0x02 /* Public */,
     198,    1, 1721,    2, 0x02 /* Public */,
     199,    1, 1724,    2, 0x02 /* Public */,
     200,    2, 1727,    2, 0x02 /* Public */,
     202,    2, 1732,    2, 0x02 /* Public */,
     203,    3, 1737,    2, 0x02 /* Public */,
     205,    1, 1744,    2, 0x02 /* Public */,
     205,    2, 1747,    2, 0x02 /* Public */,
     206,    1, 1752,    2, 0x02 /* Public */,
     207,    1, 1755,    2, 0x02 /* Public */,
     208,    1, 1758,    2, 0x02 /* Public */,
     209,    1, 1761,    2, 0x02 /* Public */,
     210,    0, 1764,    2, 0x02 /* Public */,
     211,    2, 1765,    2, 0x02 /* Public */,
     213,    0, 1770,    2, 0x02 /* Public */,
     214,    0, 1771,    2, 0x02 /* Public */,
     216,    1, 1772,    2, 0x02 /* Public */,
     216,    3, 1775,    2, 0x02 /* Public */,
     218,    0, 1782,    2, 0x02 /* Public */,
     219,    0, 1783,    2, 0x02 /* Public */,
     220,    0, 1784,    2, 0x02 /* Public */,
     221,    0, 1785,    2, 0x02 /* Public */,
     222,    0, 1786,    2, 0x02 /* Public */,
     223,    0, 1787,    2, 0x02 /* Public */,
     224,    0, 1788,    2, 0x02 /* Public */,
     225,    0, 1789,    2, 0x02 /* Public */,
     226,    0, 1790,    2, 0x02 /* Public */,
     227,    1, 1791,    2, 0x02 /* Public */,
     228,    1, 1794,    2, 0x02 /* Public */,
     230,    0, 1797,    2, 0x02 /* Public */,
     231,    0, 1798,    2, 0x02 /* Public */,
     232,    0, 1799,    2, 0x02 /* Public */,
     233,    0, 1800,    2, 0x02 /* Public */,
     234,    0, 1801,    2, 0x02 /* Public */,
     235,    0, 1802,    2, 0x02 /* Public */,
     236,    0, 1803,    2, 0x02 /* Public */,
     237,    0, 1804,    2, 0x02 /* Public */,
     238,    0, 1805,    2, 0x02 /* Public */,
     239,    0, 1806,    2, 0x02 /* Public */,
     240,    1, 1807,    2, 0x02 /* Public */,
     241,    1, 1810,    2, 0x02 /* Public */,
     242,    1, 1813,    2, 0x02 /* Public */,
     243,    1, 1816,    2, 0x02 /* Public */,
     244,    1, 1819,    2, 0x02 /* Public */,
     245,    0, 1822,    2, 0x02 /* Public */,
     246,    1, 1823,    2, 0x02 /* Public */,
     247,    0, 1826,    2, 0x02 /* Public */,
     248,    0, 1827,    2, 0x02 /* Public */,
     249,    0, 1828,    2, 0x02 /* Public */,
     250,    0, 1829,    2, 0x02 /* Public */,
     251,    0, 1830,    2, 0x02 /* Public */,
     252,    0, 1831,    2, 0x02 /* Public */,
     253,    0, 1832,    2, 0x02 /* Public */,
     254,    0, 1833,    2, 0x02 /* Public */,
     255,    0, 1834,    2, 0x02 /* Public */,
     256,    0, 1835,    2, 0x02 /* Public */,
     257,    0, 1836,    2, 0x02 /* Public */,
     258,    0, 1837,    2, 0x02 /* Public */,
     259,    0, 1838,    2, 0x02 /* Public */,
     260,    0, 1839,    2, 0x02 /* Public */,
     261,    0, 1840,    2, 0x02 /* Public */,
     262,    0, 1841,    2, 0x02 /* Public */,
     263,    0, 1842,    2, 0x02 /* Public */,
     264,    1, 1843,    2, 0x02 /* Public */,
     265,    1, 1846,    2, 0x02 /* Public */,
     266,    1, 1849,    2, 0x02 /* Public */,
     267,    0, 1852,    2, 0x02 /* Public */,
     268,    1, 1853,    2, 0x02 /* Public */,
     269,    1, 1856,    2, 0x02 /* Public */,
     270,    0, 1859,    2, 0x02 /* Public */,
     271,    0, 1860,    2, 0x02 /* Public */,
     272,    0, 1861,    2, 0x02 /* Public */,
     273,    0, 1862,    2, 0x02 /* Public */,
     274,    0, 1863,    2, 0x02 /* Public */,
     275,    0, 1864,    2, 0x02 /* Public */,
     276,    0, 1865,    2, 0x02 /* Public */,
     277,    0, 1866,    2, 0x02 /* Public */,
     278,    0, 1867,    2, 0x02 /* Public */,
     279,    0, 1868,    2, 0x02 /* Public */,
     280,    0, 1869,    2, 0x02 /* Public */,
     281,    0, 1870,    2, 0x02 /* Public */,
     282,    0, 1871,    2, 0x02 /* Public */,
     283,    1, 1872,    2, 0x02 /* Public */,
     284,    2, 1875,    2, 0x02 /* Public */,
     286,    0, 1880,    2, 0x02 /* Public */,
     287,    0, 1881,    2, 0x02 /* Public */,
     288,    0, 1882,    2, 0x02 /* Public */,
     289,    1, 1883,    2, 0x02 /* Public */,
     290,    0, 1886,    2, 0x02 /* Public */,
     291,    6, 1887,    2, 0x02 /* Public */,
     291,    5, 1900,    2, 0x22 /* Public | MethodCloned */,
     291,    4, 1911,    2, 0x22 /* Public | MethodCloned */,
     291,    3, 1920,    2, 0x22 /* Public | MethodCloned */,
     291,    2, 1927,    2, 0x22 /* Public | MethodCloned */,
     291,    1, 1932,    2, 0x22 /* Public | MethodCloned */,
     291,    0, 1935,    2, 0x22 /* Public | MethodCloned */,

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
    QMetaType::Void, QMetaType::QString,   30,
    QMetaType::QString, QMetaType::QString,   32,
    QMetaType::QString, QMetaType::QString,   32,
    QMetaType::QString, QMetaType::QString,   32,
    QMetaType::QString, QMetaType::QString,   32,
    QMetaType::QString, QMetaType::QString,   32,
    QMetaType::QString, QMetaType::QString,   32,
    QMetaType::QString, QMetaType::QString,   32,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   32,   41,
    QMetaType::Void, QMetaType::QString,   43,
    QMetaType::Void,
    QMetaType::QString, QMetaType::QString, QMetaType::QString,   45,   32,
    QMetaType::Void, QMetaType::Float,   47,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   52,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   55,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   61,   62,
    QMetaType::Int,
    0x80000000 | 65, QMetaType::Int,   66,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   80,   81,
    QMetaType::Void, QMetaType::Int,   66,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QDateTime,   90,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int,   91,   92,   90,
    QMetaType::Bool, QMetaType::QDateTime,   90,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int, QMetaType::Int,   91,   92,   90,
    QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::Int,   91,   92,   90,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::Void, QMetaType::QString,   32,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::QString,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool, QMetaType::QString,   32,
    QMetaType::Bool, QMetaType::QString,   32,
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::Int, QMetaType::QString,   32,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::Bool, QMetaType::QString,   32,
    QMetaType::Bool, QMetaType::QString,   32,
    QMetaType::Bool, QMetaType::QString,   32,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  121,
    QMetaType::Void, QMetaType::QString,  123,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  126,
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString, QMetaType::Int,  130,  131,  132,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::QString,  135,
    QMetaType::Void, QMetaType::QString,   32,
    QMetaType::Void, QMetaType::QString,   32,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Float,  141,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,  132,
    QMetaType::Void, QMetaType::QString,   32,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,  149,  150,  151,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  162,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  162,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,  169,
    QMetaType::QString, QMetaType::QString,  169,
    QMetaType::Void, QMetaType::Int,  169,
    QMetaType::Void, QMetaType::Bool,  173,
    QMetaType::Void, QMetaType::Int,  169,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Float, QMetaType::Int,   66,
    QMetaType::Int, QMetaType::Int,   66,
    QMetaType::QString, QMetaType::Int,  132,
    QMetaType::QString, QMetaType::Int,  132,
    QMetaType::Void,
    QMetaType::Int, QMetaType::QString,  183,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int, QMetaType::QString,   66,  183,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::Int, QMetaType::Int,   66,
    QMetaType::Void, QMetaType::QString, QMetaType::Int,   32,   66,
    QMetaType::Int, QMetaType::QString,  183,
    QMetaType::Float, QMetaType::Int, QMetaType::QString,   66,  183,
    QMetaType::Float, QMetaType::Int,   66,
    QMetaType::Float, QMetaType::Int, QMetaType::QString,   66,  183,
    QMetaType::Float, QMetaType::Int,   66,
    QMetaType::Float, QMetaType::Int, QMetaType::QString,   66,  183,
    QMetaType::Float, QMetaType::Int,   66,
    QMetaType::Bool, QMetaType::Int,   66,
    QMetaType::Float, QMetaType::Int,   66,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,  162,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::Int, QMetaType::Int,   66,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   66,  201,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   66,  201,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  204,  149,  150,
    QMetaType::Int, QMetaType::QString,   32,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  149,  150,
    QMetaType::Int, QMetaType::QString,  183,
    QMetaType::Void, QMetaType::Int,   66,
    QMetaType::Void, QMetaType::QString,   32,
    QMetaType::Bool, QMetaType::QString,  123,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,  212,   52,
    QMetaType::Void,
    0x80000000 | 215,
    QMetaType::Void, QMetaType::QString,  217,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,  149,  150,  151,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Void, QMetaType::Float,  149,
    QMetaType::Void, QMetaType::Float,  229,
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
    QMetaType::Bool, QMetaType::Int,  169,
    QMetaType::Int, QMetaType::Int,  169,
    QMetaType::QString, QMetaType::Int,  169,
    QMetaType::Int, QMetaType::Int,  169,
    QMetaType::Int, QMetaType::Int,  169,
    QMetaType::Int,
    QMetaType::Int, QMetaType::Int,  169,
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
    QMetaType::Float, QMetaType::Int,   66,
    QMetaType::Float, QMetaType::Int,   66,
    QMetaType::Float, QMetaType::Int,   66,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   66,
    QMetaType::Float, QMetaType::Int,   66,
    QMetaType::Int,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float,
    0x80000000 | 215,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   32,
    QMetaType::Void, QMetaType::QString, QMetaType::Bool,  132,  285,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   66,
    QMetaType::Int,
    QMetaType::Void, QMetaType::QString, QMetaType::Bool, QMetaType::Bool, QMetaType::Bool, QMetaType::Bool, QMetaType::Bool,  292,  293,  294,  295,  296,  297,
    QMetaType::Void, QMetaType::QString, QMetaType::Bool, QMetaType::Bool, QMetaType::Bool, QMetaType::Bool,  292,  293,  294,  295,  296,
    QMetaType::Void, QMetaType::QString, QMetaType::Bool, QMetaType::Bool, QMetaType::Bool,  292,  293,  294,  295,
    QMetaType::Void, QMetaType::QString, QMetaType::Bool, QMetaType::Bool,  292,  293,  294,
    QMetaType::Void, QMetaType::QString, QMetaType::Bool,  292,  293,
    QMetaType::Void, QMetaType::QString,  292,
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
        case 15: _t->zip_done(); break;
        case 16: _t->unzip_done(); break;
        case 17: _t->zip_failed(); break;
        case 18: _t->unzip_failed(); break;
        case 19: { bool _r = _t->isIPCused();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 20: { bool _r = _t->getLCMConnection();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 21: { bool _r = _t->getLCMRX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 22: { bool _r = _t->getLCMTX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 23: { bool _r = _t->getLCMProcess();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 24: _t->programRestart(); break;
        case 25: _t->programExit(); break;
        case 26: _t->programHide(); break;
        case 27: _t->writelog((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 28: { QString _r = _t->getRawMapPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 29: { QString _r = _t->getMapPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 30: { QString _r = _t->getAnnotPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 31: { QString _r = _t->getMetaPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 32: { QString _r = _t->getTravelRawPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 33: { QString _r = _t->getTravelPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 34: { QString _r = _t->getCostPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 35: { QString _r = _t->getIniPath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 36: _t->setSetting((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 37: _t->readSetting((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 38: _t->readSetting(); break;
        case 39: { QString _r = _t->getSetting((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 40: _t->setVelocity((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 41: { float _r = _t->getVelocity();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 42: { int _r = _t->getTrayNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 43: { int _r = _t->getTableNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 44: _t->setTableNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 45: { int _r = _t->getTableColNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 46: _t->setTableColNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 47: { QString _r = _t->getRobotType();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
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
        case 63: _t->readWifi(); break;
        case 64: { int _r = _t->getWifiNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 65: { QString _r = _t->getWifiSSD((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 66: _t->connectWifi((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 67: _t->setLog((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 68: { int _r = _t->getLogLineNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 69: { QString _r = _t->getLogLine((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 70: { QString _r = _t->getLogDate((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 71: { QString _r = _t->getLogAuth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 72: { QString _r = _t->getLogMessage((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 73: _t->readLogList(); break;
        case 74: _t->readLog((*reinterpret_cast< QDateTime(*)>(_a[1]))); break;
        case 75: _t->readLog((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 76: { bool _r = _t->isHasLog((*reinterpret_cast< QDateTime(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 77: { bool _r = _t->isHasLog((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 78: { QString _r = _t->getLocaleDate((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 79: _t->updateUSB(); break;
        case 80: { int _r = _t->getusbsize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 81: _t->readusbfile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 82: _t->readusbrecentfile(); break;
        case 83: { int _r = _t->getusbfilesize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 84: { QString _r = _t->getusbfile((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 85: { QString _r = _t->getusbrecentfile();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 86: { QString _r = _t->getusbname((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 87: _t->readusb(); break;
        case 88: { bool _r = _t->isConnectServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 89: { bool _r = _t->isExistMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 90: { bool _r = _t->isExistRawMap((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 91: { bool _r = _t->isExistMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 92: { int _r = _t->getAvailableMap();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 93: { QString _r = _t->getAvailableMapPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 94: { int _r = _t->getMapFileSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 95: { QString _r = _t->getMapFile((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 96: { bool _r = _t->isExistTravelRaw((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 97: { bool _r = _t->isExistTravelEdited((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 98: { bool _r = _t->isExistAnnotation((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 99: _t->deleteAnnotation(); break;
        case 100: { bool _r = _t->loadMaptoServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 101: { bool _r = _t->isUSBFile();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 102: { QString _r = _t->getUSBFilename();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 103: { bool _r = _t->loadMaptoUSB();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 104: { bool _r = _t->isuseServerMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 105: _t->setuseServerMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 106: _t->removeMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 107: { bool _r = _t->isloadMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 108: _t->setloadMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 109: { bool _r = _t->isExistRobotINI();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 110: _t->makeRobotINI(); break;
        case 111: { bool _r = _t->rotate_map((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 112: { bool _r = _t->getIniRead();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 113: _t->saveMapfromUsb((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 114: _t->loadMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 115: _t->setMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 116: _t->restartSLAM(); break;
        case 117: _t->startSLAM(); break;
        case 118: _t->startMapping((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 119: _t->stopMapping(); break;
        case 120: _t->setSLAMMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 121: _t->saveMapping((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 122: _t->startObjecting(); break;
        case 123: _t->stopObjecting(); break;
        case 124: _t->saveObjecting(); break;
        case 125: _t->setInitPos((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 126: { float _r = _t->getInitPoseX();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 127: { float _r = _t->getInitPoseY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 128: { float _r = _t->getInitPoseTH();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 129: _t->slam_setInit(); break;
        case 130: _t->slam_run(); break;
        case 131: _t->slam_stop(); break;
        case 132: _t->slam_autoInit(); break;
        case 133: { bool _r = _t->is_slam_running();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 134: { bool _r = _t->getMappingflag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 135: _t->setMappingflag((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 136: { bool _r = _t->getObjectingflag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 137: _t->setObjectingflag((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 138: { QString _r = _t->getnewMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 139: { QString _r = _t->getLastCall();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 140: { int _r = _t->getCallSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 141: { QString _r = _t->getCall((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 142: { QString _r = _t->getCallName((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 143: _t->setCallbell((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 144: _t->acceptCall((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 145: _t->removeCall((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 146: _t->removeCallAll(); break;
        case 147: { bool _r = _t->isconnectJoy();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 148: { float _r = _t->getJoyAxis((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 149: { int _r = _t->getJoyButton((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 150: { QString _r = _t->getKeyboard((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 151: { QString _r = _t->getJoystick((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 152: _t->setObjPose(); break;
        case 153: { int _r = _t->getLocationNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 154: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 155: { QString _r = _t->getLocationName((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 156: { QString _r = _t->getLocationName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 157: { QString _r = _t->getLocationType((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 158: { int _r = _t->getLocationNumber((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 159: _t->setLocationNumber((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 160: { int _r = _t->getLocationSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 161: { float _r = _t->getLocationX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 162: { float _r = _t->getLocationX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 163: { float _r = _t->getLocationY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 164: { float _r = _t->getLocationY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 165: { float _r = _t->getLocationTH((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 166: { float _r = _t->getLocationTH((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 167: { bool _r = _t->isExistLocation((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 168: { float _r = _t->getLidar((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 169: { bool _r = _t->getAnnotEditFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 170: _t->setAnnotEditFlag((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 171: _t->clearSharedMemory(); break;
        case 172: { int _r = _t->getObjectNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 173: { QString _r = _t->getObjectName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 174: { int _r = _t->getObjectPointSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 175: { float _r = _t->getObjectX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 176: { float _r = _t->getObjectY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 177: { int _r = _t->getObjPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 178: { int _r = _t->getLocNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 179: { int _r = _t->getLocNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 180: { int _r = _t->getObjectSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 181: _t->removeObject((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 182: _t->removeLocation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 183: { bool _r = _t->saveAnnotation((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 184: _t->sendMaptoServer(); break;
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
        case 199: _t->joyMoveXY((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 200: _t->joyMoveR((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 201: { float _r = _t->getJoyXY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 202: { float _r = _t->getJoyR();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 203: _t->resetHomeFolders(); break;
        case 204: { float _r = _t->getBattery();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 205: { int _r = _t->getMotorState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 206: { int _r = _t->getLocalizationState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 207: { int _r = _t->getStateMoving();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 208: { int _r = _t->getObsState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 209: { int _r = _t->getErrcode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 210: { QString _r = _t->getRobotName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 211: { bool _r = _t->getMotorConnection((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 212: { int _r = _t->getMotorStatus((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 213: { QString _r = _t->getMotorStatusStr((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 214: { int _r = _t->getMotorTemperature((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 215: { int _r = _t->getMotorInsideTemperature((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 216: { int _r = _t->getMotorWarningTemperature();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 217: { int _r = _t->getMotorCurrent((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 218: { int _r = _t->getPowerStatus();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 219: { int _r = _t->getRemoteStatus();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 220: { int _r = _t->getChargeStatus();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 221: { int _r = _t->getEmoStatus();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 222: { float _r = _t->getBatteryIn();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 223: { float _r = _t->getBatteryOut();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 224: { float _r = _t->getBatteryCurrent();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 225: { float _r = _t->getPower();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 226: { float _r = _t->getPowerTotal();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 227: { float _r = _t->getRobotRadius();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 228: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 229: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 230: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 231: { float _r = _t->getlastRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 232: { float _r = _t->getlastRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 233: { float _r = _t->getlastRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 234: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 235: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 236: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 237: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 238: { int _r = _t->getLocalPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 239: { float _r = _t->getLocalPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 240: { float _r = _t->getLocalPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 241: { int _r = _t->getuistate();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 242: _t->initdone(); break;
        case 243: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 244: { QString _r = _t->getMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 245: { QString _r = _t->getServerMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 246: { QString _r = _t->getServerMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 247: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 248: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 249: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 250: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 251: _t->runRotateTables(); break;
        case 252: _t->stopRotateTables(); break;
        case 253: _t->clearRotateList(); break;
        case 254: _t->setRotateList((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 255: _t->startPatrol((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 256: _t->startServingTest(); break;
        case 257: _t->stopServingTest(); break;
        case 258: { int _r = _t->getusberrorsize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 259: { QString _r = _t->getusberror((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 260: { int _r = _t->getzipstate();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 261: _t->usbsave((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2])),(*reinterpret_cast< bool(*)>(_a[3])),(*reinterpret_cast< bool(*)>(_a[4])),(*reinterpret_cast< bool(*)>(_a[5])),(*reinterpret_cast< bool(*)>(_a[6]))); break;
        case 262: _t->usbsave((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2])),(*reinterpret_cast< bool(*)>(_a[3])),(*reinterpret_cast< bool(*)>(_a[4])),(*reinterpret_cast< bool(*)>(_a[5]))); break;
        case 263: _t->usbsave((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2])),(*reinterpret_cast< bool(*)>(_a[3])),(*reinterpret_cast< bool(*)>(_a[4]))); break;
        case 264: _t->usbsave((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2])),(*reinterpret_cast< bool(*)>(_a[3]))); break;
        case 265: _t->usbsave((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 266: _t->usbsave((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 267: _t->usbsave(); break;
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
        if (_id < 268)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 268;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 268)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 268;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
