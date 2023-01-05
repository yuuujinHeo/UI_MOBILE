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
    QByteArrayData data[251];
    char stringdata0[2922];
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
QT_MOC_LITERAL(9, 126, 10), // "usb_detect"
QT_MOC_LITERAL(10, 137, 11), // "programExit"
QT_MOC_LITERAL(11, 149, 11), // "programHide"
QT_MOC_LITERAL(12, 161, 8), // "writelog"
QT_MOC_LITERAL(13, 170, 3), // "msg"
QT_MOC_LITERAL(14, 174, 11), // "readSetting"
QT_MOC_LITERAL(15, 186, 11), // "setVelocity"
QT_MOC_LITERAL(16, 198, 3), // "vel"
QT_MOC_LITERAL(17, 202, 11), // "getVelocity"
QT_MOC_LITERAL(18, 214, 16), // "getuseTravelline"
QT_MOC_LITERAL(19, 231, 16), // "setuseTravelline"
QT_MOC_LITERAL(20, 248, 3), // "use"
QT_MOC_LITERAL(21, 252, 16), // "getnumTravelline"
QT_MOC_LITERAL(22, 269, 16), // "setnumTravelline"
QT_MOC_LITERAL(23, 286, 3), // "num"
QT_MOC_LITERAL(24, 290, 10), // "getTrayNum"
QT_MOC_LITERAL(25, 301, 10), // "setTrayNum"
QT_MOC_LITERAL(26, 312, 8), // "tray_num"
QT_MOC_LITERAL(27, 321, 11), // "getTableNum"
QT_MOC_LITERAL(28, 333, 11), // "setTableNum"
QT_MOC_LITERAL(29, 345, 9), // "table_num"
QT_MOC_LITERAL(30, 355, 14), // "getTableColNum"
QT_MOC_LITERAL(31, 370, 14), // "setTableColNum"
QT_MOC_LITERAL(32, 385, 7), // "col_num"
QT_MOC_LITERAL(33, 393, 11), // "getuseVoice"
QT_MOC_LITERAL(34, 405, 11), // "setuseVoice"
QT_MOC_LITERAL(35, 417, 9), // "getuseBGM"
QT_MOC_LITERAL(36, 427, 9), // "setuseBGM"
QT_MOC_LITERAL(37, 437, 12), // "getserverCMD"
QT_MOC_LITERAL(38, 450, 12), // "setserverCMD"
QT_MOC_LITERAL(39, 463, 12), // "getRobotType"
QT_MOC_LITERAL(40, 476, 12), // "setRobotType"
QT_MOC_LITERAL(41, 489, 4), // "type"
QT_MOC_LITERAL(42, 494, 12), // "setDebugName"
QT_MOC_LITERAL(43, 507, 4), // "name"
QT_MOC_LITERAL(44, 512, 12), // "getDebugName"
QT_MOC_LITERAL(45, 525, 13), // "getDebugState"
QT_MOC_LITERAL(46, 539, 13), // "setDebugState"
QT_MOC_LITERAL(47, 553, 7), // "isdebug"
QT_MOC_LITERAL(48, 561, 15), // "isConnectServer"
QT_MOC_LITERAL(49, 577, 10), // "isExistMap"
QT_MOC_LITERAL(50, 588, 15), // "loadMaptoServer"
QT_MOC_LITERAL(51, 604, 9), // "isUSBFile"
QT_MOC_LITERAL(52, 614, 14), // "getUSBFilename"
QT_MOC_LITERAL(53, 629, 12), // "loadMaptoUSB"
QT_MOC_LITERAL(54, 642, 14), // "isuseServerMap"
QT_MOC_LITERAL(55, 657, 15), // "setuseServerMap"
QT_MOC_LITERAL(56, 673, 12), // "removeRawMap"
QT_MOC_LITERAL(57, 686, 15), // "removeEditedMap"
QT_MOC_LITERAL(58, 702, 15), // "removeServerMap"
QT_MOC_LITERAL(59, 718, 9), // "isloadMap"
QT_MOC_LITERAL(60, 728, 10), // "setloadMap"
QT_MOC_LITERAL(61, 739, 4), // "load"
QT_MOC_LITERAL(62, 744, 15), // "isExistRobotINI"
QT_MOC_LITERAL(63, 760, 12), // "makeRobotINI"
QT_MOC_LITERAL(64, 773, 10), // "rotate_map"
QT_MOC_LITERAL(65, 784, 4), // "_src"
QT_MOC_LITERAL(66, 789, 4), // "_dst"
QT_MOC_LITERAL(67, 794, 4), // "mode"
QT_MOC_LITERAL(68, 799, 16), // "getLCMConnection"
QT_MOC_LITERAL(69, 816, 8), // "getLCMRX"
QT_MOC_LITERAL(70, 825, 8), // "getLCMTX"
QT_MOC_LITERAL(71, 834, 13), // "getLCMProcess"
QT_MOC_LITERAL(72, 848, 10), // "getIniRead"
QT_MOC_LITERAL(73, 859, 13), // "getUsbMapSize"
QT_MOC_LITERAL(74, 873, 13), // "getUsbMapPath"
QT_MOC_LITERAL(75, 887, 17), // "getUsbMapPathFull"
QT_MOC_LITERAL(76, 905, 14), // "saveMapfromUsb"
QT_MOC_LITERAL(77, 920, 4), // "path"
QT_MOC_LITERAL(78, 925, 12), // "startMapping"
QT_MOC_LITERAL(79, 938, 11), // "stopMapping"
QT_MOC_LITERAL(80, 950, 11), // "setSLAMMode"
QT_MOC_LITERAL(81, 962, 10), // "setInitPos"
QT_MOC_LITERAL(82, 973, 1), // "x"
QT_MOC_LITERAL(83, 975, 1), // "y"
QT_MOC_LITERAL(84, 977, 2), // "th"
QT_MOC_LITERAL(85, 980, 12), // "getInitPoseX"
QT_MOC_LITERAL(86, 993, 12), // "getInitPoseY"
QT_MOC_LITERAL(87, 1006, 13), // "getInitPoseTH"
QT_MOC_LITERAL(88, 1020, 12), // "slam_setInit"
QT_MOC_LITERAL(89, 1033, 8), // "slam_run"
QT_MOC_LITERAL(90, 1042, 9), // "slam_stop"
QT_MOC_LITERAL(91, 1052, 13), // "slam_autoInit"
QT_MOC_LITERAL(92, 1066, 15), // "is_slam_running"
QT_MOC_LITERAL(93, 1082, 14), // "getMappingflag"
QT_MOC_LITERAL(94, 1097, 14), // "setMappingflag"
QT_MOC_LITERAL(95, 1112, 4), // "flag"
QT_MOC_LITERAL(96, 1117, 10), // "getMapping"
QT_MOC_LITERAL(97, 1128, 10), // "QList<int>"
QT_MOC_LITERAL(98, 1139, 11), // "pushMapData"
QT_MOC_LITERAL(99, 1151, 4), // "data"
QT_MOC_LITERAL(100, 1156, 12), // "isconnectJoy"
QT_MOC_LITERAL(101, 1169, 10), // "getJoyAxis"
QT_MOC_LITERAL(102, 1180, 12), // "getJoyButton"
QT_MOC_LITERAL(103, 1193, 11), // "getKeyboard"
QT_MOC_LITERAL(104, 1205, 11), // "getJoystick"
QT_MOC_LITERAL(105, 1217, 13), // "getCanvasSize"
QT_MOC_LITERAL(106, 1231, 11), // "getRedoSize"
QT_MOC_LITERAL(107, 1243, 8), // "getLineX"
QT_MOC_LITERAL(108, 1252, 12), // "QVector<int>"
QT_MOC_LITERAL(109, 1265, 5), // "index"
QT_MOC_LITERAL(110, 1271, 8), // "getLineY"
QT_MOC_LITERAL(111, 1280, 12), // "getLineColor"
QT_MOC_LITERAL(112, 1293, 12), // "getLineWidth"
QT_MOC_LITERAL(113, 1306, 9), // "startLine"
QT_MOC_LITERAL(114, 1316, 5), // "color"
QT_MOC_LITERAL(115, 1322, 5), // "width"
QT_MOC_LITERAL(116, 1328, 7), // "setLine"
QT_MOC_LITERAL(117, 1336, 8), // "stopLine"
QT_MOC_LITERAL(118, 1345, 4), // "undo"
QT_MOC_LITERAL(119, 1350, 4), // "redo"
QT_MOC_LITERAL(120, 1355, 9), // "clear_all"
QT_MOC_LITERAL(121, 1365, 10), // "setObjPose"
QT_MOC_LITERAL(122, 1376, 12), // "setMarginObj"
QT_MOC_LITERAL(123, 1389, 14), // "clearMarginObj"
QT_MOC_LITERAL(124, 1404, 14), // "setMarginPoint"
QT_MOC_LITERAL(125, 1419, 9), // "pixel_num"
QT_MOC_LITERAL(126, 1429, 12), // "getMarginObj"
QT_MOC_LITERAL(127, 1442, 9), // "getMargin"
QT_MOC_LITERAL(128, 1452, 14), // "getLocationNum"
QT_MOC_LITERAL(129, 1467, 15), // "getLocationSize"
QT_MOC_LITERAL(130, 1483, 15), // "getLocationName"
QT_MOC_LITERAL(131, 1499, 16), // "getLocationTypes"
QT_MOC_LITERAL(132, 1516, 12), // "getLocationx"
QT_MOC_LITERAL(133, 1529, 12), // "getLocationy"
QT_MOC_LITERAL(134, 1542, 13), // "getLocationth"
QT_MOC_LITERAL(135, 1556, 8), // "getLidar"
QT_MOC_LITERAL(136, 1565, 12), // "getObjectNum"
QT_MOC_LITERAL(137, 1578, 13), // "getObjectName"
QT_MOC_LITERAL(138, 1592, 18), // "getObjectPointSize"
QT_MOC_LITERAL(139, 1611, 10), // "getObjectX"
QT_MOC_LITERAL(140, 1622, 5), // "point"
QT_MOC_LITERAL(141, 1628, 10), // "getObjectY"
QT_MOC_LITERAL(142, 1639, 17), // "getTempObjectSize"
QT_MOC_LITERAL(143, 1657, 14), // "getTempObjectX"
QT_MOC_LITERAL(144, 1672, 14), // "getTempObjectY"
QT_MOC_LITERAL(145, 1687, 9), // "getObjNum"
QT_MOC_LITERAL(146, 1697, 14), // "getObjPointNum"
QT_MOC_LITERAL(147, 1712, 7), // "obj_num"
QT_MOC_LITERAL(148, 1720, 9), // "getLocNum"
QT_MOC_LITERAL(149, 1730, 14), // "addObjectPoint"
QT_MOC_LITERAL(150, 1745, 17), // "removeObjectPoint"
QT_MOC_LITERAL(151, 1763, 21), // "removeObjectPointLast"
QT_MOC_LITERAL(152, 1785, 17), // "clearObjectPoints"
QT_MOC_LITERAL(153, 1803, 13), // "getObjectSize"
QT_MOC_LITERAL(154, 1817, 9), // "addObject"
QT_MOC_LITERAL(155, 1827, 13), // "addObjectRect"
QT_MOC_LITERAL(156, 1841, 10), // "editObject"
QT_MOC_LITERAL(157, 1852, 12), // "removeObject"
QT_MOC_LITERAL(158, 1865, 14), // "removeLocation"
QT_MOC_LITERAL(159, 1880, 11), // "addLocation"
QT_MOC_LITERAL(160, 1892, 17), // "moveLocationPoint"
QT_MOC_LITERAL(161, 1910, 7), // "loc_num"
QT_MOC_LITERAL(162, 1918, 12), // "getTlineSize"
QT_MOC_LITERAL(163, 1931, 12), // "getTlineName"
QT_MOC_LITERAL(164, 1944, 9), // "getTlineX"
QT_MOC_LITERAL(165, 1954, 9), // "getTlineY"
QT_MOC_LITERAL(166, 1964, 8), // "addTline"
QT_MOC_LITERAL(167, 1973, 2), // "x1"
QT_MOC_LITERAL(168, 1976, 2), // "y1"
QT_MOC_LITERAL(169, 1979, 2), // "x2"
QT_MOC_LITERAL(170, 1982, 2), // "y2"
QT_MOC_LITERAL(171, 1985, 11), // "removeTline"
QT_MOC_LITERAL(172, 1997, 4), // "line"
QT_MOC_LITERAL(173, 2002, 11), // "getTlineNum"
QT_MOC_LITERAL(174, 2014, 14), // "saveAnnotation"
QT_MOC_LITERAL(175, 2029, 8), // "filename"
QT_MOC_LITERAL(176, 2038, 12), // "saveMetaData"
QT_MOC_LITERAL(177, 2051, 15), // "sendMaptoServer"
QT_MOC_LITERAL(178, 2067, 10), // "acceptCall"
QT_MOC_LITERAL(179, 2078, 3), // "yes"
QT_MOC_LITERAL(180, 2082, 7), // "setTray"
QT_MOC_LITERAL(181, 2090, 13), // "confirmPickup"
QT_MOC_LITERAL(182, 2104, 14), // "getPickuptrays"
QT_MOC_LITERAL(183, 2119, 6), // "moveTo"
QT_MOC_LITERAL(184, 2126, 10), // "target_num"
QT_MOC_LITERAL(185, 2137, 9), // "movePause"
QT_MOC_LITERAL(186, 2147, 10), // "moveResume"
QT_MOC_LITERAL(187, 2158, 8), // "moveStop"
QT_MOC_LITERAL(188, 2167, 10), // "moveManual"
QT_MOC_LITERAL(189, 2178, 12), // "moveToCharge"
QT_MOC_LITERAL(190, 2191, 10), // "moveToWait"
QT_MOC_LITERAL(191, 2202, 9), // "getcurLoc"
QT_MOC_LITERAL(192, 2212, 11), // "getcurTable"
QT_MOC_LITERAL(193, 2224, 12), // "getcurTarget"
QT_MOC_LITERAL(194, 2237, 14), // "QVector<float>"
QT_MOC_LITERAL(195, 2252, 9), // "joyMoveXY"
QT_MOC_LITERAL(196, 2262, 8), // "joyMoveR"
QT_MOC_LITERAL(197, 2271, 1), // "r"
QT_MOC_LITERAL(198, 2273, 8), // "getJoyXY"
QT_MOC_LITERAL(199, 2282, 7), // "getJoyR"
QT_MOC_LITERAL(200, 2290, 10), // "getBattery"
QT_MOC_LITERAL(201, 2301, 8), // "getState"
QT_MOC_LITERAL(202, 2310, 10), // "getErrcode"
QT_MOC_LITERAL(203, 2321, 12), // "getRobotName"
QT_MOC_LITERAL(204, 2334, 12), // "setRobotName"
QT_MOC_LITERAL(205, 2347, 14), // "getRobotRadius"
QT_MOC_LITERAL(206, 2362, 9), // "getRobotx"
QT_MOC_LITERAL(207, 2372, 9), // "getRoboty"
QT_MOC_LITERAL(208, 2382, 10), // "getRobotth"
QT_MOC_LITERAL(209, 2393, 13), // "getRobotState"
QT_MOC_LITERAL(210, 2407, 10), // "getPathNum"
QT_MOC_LITERAL(211, 2418, 8), // "getPathx"
QT_MOC_LITERAL(212, 2427, 8), // "getPathy"
QT_MOC_LITERAL(213, 2436, 9), // "getPathth"
QT_MOC_LITERAL(214, 2446, 15), // "getLocalPathNum"
QT_MOC_LITERAL(215, 2462, 13), // "getLocalPathx"
QT_MOC_LITERAL(216, 2476, 13), // "getLocalPathy"
QT_MOC_LITERAL(217, 2490, 10), // "getuistate"
QT_MOC_LITERAL(218, 2501, 10), // "getMapname"
QT_MOC_LITERAL(219, 2512, 10), // "getMappath"
QT_MOC_LITERAL(220, 2523, 11), // "getMapWidth"
QT_MOC_LITERAL(221, 2535, 12), // "getMapHeight"
QT_MOC_LITERAL(222, 2548, 12), // "getGridWidth"
QT_MOC_LITERAL(223, 2561, 9), // "getOrigin"
QT_MOC_LITERAL(224, 2571, 7), // "setGrid"
QT_MOC_LITERAL(225, 2579, 8), // "editGrid"
QT_MOC_LITERAL(226, 2588, 7), // "getGrid"
QT_MOC_LITERAL(227, 2596, 12), // "make_minimap"
QT_MOC_LITERAL(228, 2609, 17), // "getPatrolFileName"
QT_MOC_LITERAL(229, 2627, 10), // "makePatrol"
QT_MOC_LITERAL(230, 2638, 14), // "loadPatrolFile"
QT_MOC_LITERAL(231, 2653, 14), // "savePatrolFile"
QT_MOC_LITERAL(232, 2668, 9), // "addPatrol"
QT_MOC_LITERAL(233, 2678, 8), // "location"
QT_MOC_LITERAL(234, 2687, 12), // "getPatrolNum"
QT_MOC_LITERAL(235, 2700, 13), // "getPatrolType"
QT_MOC_LITERAL(236, 2714, 17), // "getPatrolLocation"
QT_MOC_LITERAL(237, 2732, 10), // "getPatrolX"
QT_MOC_LITERAL(238, 2743, 10), // "getPatrolY"
QT_MOC_LITERAL(239, 2754, 11), // "getPatrolTH"
QT_MOC_LITERAL(240, 2766, 12), // "removePatrol"
QT_MOC_LITERAL(241, 2779, 12), // "movePatrolUp"
QT_MOC_LITERAL(242, 2792, 14), // "movePatrolDown"
QT_MOC_LITERAL(243, 2807, 13), // "getPatrolMode"
QT_MOC_LITERAL(244, 2821, 13), // "setPatrolMode"
QT_MOC_LITERAL(245, 2835, 15), // "startRecordPath"
QT_MOC_LITERAL(246, 2851, 12), // "startcurPath"
QT_MOC_LITERAL(247, 2864, 11), // "stopcurPath"
QT_MOC_LITERAL(248, 2876, 12), // "pausecurPath"
QT_MOC_LITERAL(249, 2889, 15), // "runRotateTables"
QT_MOC_LITERAL(250, 2905, 16) // "stopRotateTables"

    },
    "Supervisor\0onTimer\0\0server_cmd_pause\0"
    "server_cmd_resume\0server_cmd_newtarget\0"
    "server_cmd_newcall\0server_cmd_setini\0"
    "path_changed\0usb_detect\0programExit\0"
    "programHide\0writelog\0msg\0readSetting\0"
    "setVelocity\0vel\0getVelocity\0"
    "getuseTravelline\0setuseTravelline\0use\0"
    "getnumTravelline\0setnumTravelline\0num\0"
    "getTrayNum\0setTrayNum\0tray_num\0"
    "getTableNum\0setTableNum\0table_num\0"
    "getTableColNum\0setTableColNum\0col_num\0"
    "getuseVoice\0setuseVoice\0getuseBGM\0"
    "setuseBGM\0getserverCMD\0setserverCMD\0"
    "getRobotType\0setRobotType\0type\0"
    "setDebugName\0name\0getDebugName\0"
    "getDebugState\0setDebugState\0isdebug\0"
    "isConnectServer\0isExistMap\0loadMaptoServer\0"
    "isUSBFile\0getUSBFilename\0loadMaptoUSB\0"
    "isuseServerMap\0setuseServerMap\0"
    "removeRawMap\0removeEditedMap\0"
    "removeServerMap\0isloadMap\0setloadMap\0"
    "load\0isExistRobotINI\0makeRobotINI\0"
    "rotate_map\0_src\0_dst\0mode\0getLCMConnection\0"
    "getLCMRX\0getLCMTX\0getLCMProcess\0"
    "getIniRead\0getUsbMapSize\0getUsbMapPath\0"
    "getUsbMapPathFull\0saveMapfromUsb\0path\0"
    "startMapping\0stopMapping\0setSLAMMode\0"
    "setInitPos\0x\0y\0th\0getInitPoseX\0"
    "getInitPoseY\0getInitPoseTH\0slam_setInit\0"
    "slam_run\0slam_stop\0slam_autoInit\0"
    "is_slam_running\0getMappingflag\0"
    "setMappingflag\0flag\0getMapping\0"
    "QList<int>\0pushMapData\0data\0isconnectJoy\0"
    "getJoyAxis\0getJoyButton\0getKeyboard\0"
    "getJoystick\0getCanvasSize\0getRedoSize\0"
    "getLineX\0QVector<int>\0index\0getLineY\0"
    "getLineColor\0getLineWidth\0startLine\0"
    "color\0width\0setLine\0stopLine\0undo\0"
    "redo\0clear_all\0setObjPose\0setMarginObj\0"
    "clearMarginObj\0setMarginPoint\0pixel_num\0"
    "getMarginObj\0getMargin\0getLocationNum\0"
    "getLocationSize\0getLocationName\0"
    "getLocationTypes\0getLocationx\0"
    "getLocationy\0getLocationth\0getLidar\0"
    "getObjectNum\0getObjectName\0"
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
    "saveAnnotation\0filename\0saveMetaData\0"
    "sendMaptoServer\0acceptCall\0yes\0setTray\0"
    "confirmPickup\0getPickuptrays\0moveTo\0"
    "target_num\0movePause\0moveResume\0"
    "moveStop\0moveManual\0moveToCharge\0"
    "moveToWait\0getcurLoc\0getcurTable\0"
    "getcurTarget\0QVector<float>\0joyMoveXY\0"
    "joyMoveR\0r\0getJoyXY\0getJoyR\0getBattery\0"
    "getState\0getErrcode\0getRobotName\0"
    "setRobotName\0getRobotRadius\0getRobotx\0"
    "getRoboty\0getRobotth\0getRobotState\0"
    "getPathNum\0getPathx\0getPathy\0getPathth\0"
    "getLocalPathNum\0getLocalPathx\0"
    "getLocalPathy\0getuistate\0getMapname\0"
    "getMappath\0getMapWidth\0getMapHeight\0"
    "getGridWidth\0getOrigin\0setGrid\0editGrid\0"
    "getGrid\0make_minimap\0getPatrolFileName\0"
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
     213,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0, 1079,    2, 0x0a /* Public */,
       3,    0, 1080,    2, 0x0a /* Public */,
       4,    0, 1081,    2, 0x0a /* Public */,
       5,    0, 1082,    2, 0x0a /* Public */,
       6,    0, 1083,    2, 0x0a /* Public */,
       7,    0, 1084,    2, 0x0a /* Public */,
       8,    0, 1085,    2, 0x0a /* Public */,
       9,    0, 1086,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      10,    0, 1087,    2, 0x02 /* Public */,
      11,    0, 1088,    2, 0x02 /* Public */,
      12,    1, 1089,    2, 0x02 /* Public */,
      14,    0, 1092,    2, 0x02 /* Public */,
      15,    1, 1093,    2, 0x02 /* Public */,
      17,    0, 1096,    2, 0x02 /* Public */,
      18,    0, 1097,    2, 0x02 /* Public */,
      19,    1, 1098,    2, 0x02 /* Public */,
      21,    0, 1101,    2, 0x02 /* Public */,
      22,    1, 1102,    2, 0x02 /* Public */,
      24,    0, 1105,    2, 0x02 /* Public */,
      25,    1, 1106,    2, 0x02 /* Public */,
      27,    0, 1109,    2, 0x02 /* Public */,
      28,    1, 1110,    2, 0x02 /* Public */,
      30,    0, 1113,    2, 0x02 /* Public */,
      31,    1, 1114,    2, 0x02 /* Public */,
      33,    0, 1117,    2, 0x02 /* Public */,
      34,    1, 1118,    2, 0x02 /* Public */,
      35,    0, 1121,    2, 0x02 /* Public */,
      36,    1, 1122,    2, 0x02 /* Public */,
      37,    0, 1125,    2, 0x02 /* Public */,
      38,    1, 1126,    2, 0x02 /* Public */,
      39,    0, 1129,    2, 0x02 /* Public */,
      40,    1, 1130,    2, 0x02 /* Public */,
      42,    1, 1133,    2, 0x02 /* Public */,
      44,    0, 1136,    2, 0x02 /* Public */,
      45,    0, 1137,    2, 0x02 /* Public */,
      46,    1, 1138,    2, 0x02 /* Public */,
      48,    0, 1141,    2, 0x02 /* Public */,
      49,    0, 1142,    2, 0x02 /* Public */,
      50,    0, 1143,    2, 0x02 /* Public */,
      51,    0, 1144,    2, 0x02 /* Public */,
      52,    0, 1145,    2, 0x02 /* Public */,
      53,    0, 1146,    2, 0x02 /* Public */,
      54,    0, 1147,    2, 0x02 /* Public */,
      55,    1, 1148,    2, 0x02 /* Public */,
      56,    0, 1151,    2, 0x02 /* Public */,
      57,    0, 1152,    2, 0x02 /* Public */,
      58,    0, 1153,    2, 0x02 /* Public */,
      59,    0, 1154,    2, 0x02 /* Public */,
      60,    1, 1155,    2, 0x02 /* Public */,
      62,    0, 1158,    2, 0x02 /* Public */,
      63,    0, 1159,    2, 0x02 /* Public */,
      64,    3, 1160,    2, 0x02 /* Public */,
      68,    0, 1167,    2, 0x02 /* Public */,
      69,    0, 1168,    2, 0x02 /* Public */,
      70,    0, 1169,    2, 0x02 /* Public */,
      71,    0, 1170,    2, 0x02 /* Public */,
      72,    0, 1171,    2, 0x02 /* Public */,
      73,    0, 1172,    2, 0x02 /* Public */,
      74,    1, 1173,    2, 0x02 /* Public */,
      75,    1, 1176,    2, 0x02 /* Public */,
      76,    1, 1179,    2, 0x02 /* Public */,
      78,    0, 1182,    2, 0x02 /* Public */,
      79,    0, 1183,    2, 0x02 /* Public */,
      80,    1, 1184,    2, 0x02 /* Public */,
      81,    3, 1187,    2, 0x02 /* Public */,
      85,    0, 1194,    2, 0x02 /* Public */,
      86,    0, 1195,    2, 0x02 /* Public */,
      87,    0, 1196,    2, 0x02 /* Public */,
      88,    0, 1197,    2, 0x02 /* Public */,
      89,    0, 1198,    2, 0x02 /* Public */,
      90,    0, 1199,    2, 0x02 /* Public */,
      91,    0, 1200,    2, 0x02 /* Public */,
      92,    0, 1201,    2, 0x02 /* Public */,
      93,    0, 1202,    2, 0x02 /* Public */,
      94,    1, 1203,    2, 0x02 /* Public */,
      96,    0, 1206,    2, 0x02 /* Public */,
      98,    1, 1207,    2, 0x02 /* Public */,
     100,    0, 1210,    2, 0x02 /* Public */,
     101,    1, 1211,    2, 0x02 /* Public */,
     102,    1, 1214,    2, 0x02 /* Public */,
     103,    1, 1217,    2, 0x02 /* Public */,
     104,    1, 1220,    2, 0x02 /* Public */,
     105,    0, 1223,    2, 0x02 /* Public */,
     106,    0, 1224,    2, 0x02 /* Public */,
     107,    1, 1225,    2, 0x02 /* Public */,
     110,    1, 1228,    2, 0x02 /* Public */,
     111,    1, 1231,    2, 0x02 /* Public */,
     112,    1, 1234,    2, 0x02 /* Public */,
     113,    2, 1237,    2, 0x02 /* Public */,
     116,    2, 1242,    2, 0x02 /* Public */,
     117,    0, 1247,    2, 0x02 /* Public */,
     118,    0, 1248,    2, 0x02 /* Public */,
     119,    0, 1249,    2, 0x02 /* Public */,
     120,    0, 1250,    2, 0x02 /* Public */,
     121,    0, 1251,    2, 0x02 /* Public */,
     122,    0, 1252,    2, 0x02 /* Public */,
     123,    0, 1253,    2, 0x02 /* Public */,
     124,    1, 1254,    2, 0x02 /* Public */,
     126,    0, 1257,    2, 0x02 /* Public */,
     127,    0, 1258,    2, 0x02 /* Public */,
     128,    0, 1259,    2, 0x02 /* Public */,
     129,    1, 1260,    2, 0x02 /* Public */,
     130,    1, 1263,    2, 0x02 /* Public */,
     131,    1, 1266,    2, 0x02 /* Public */,
     132,    1, 1269,    2, 0x02 /* Public */,
     133,    1, 1272,    2, 0x02 /* Public */,
     134,    1, 1275,    2, 0x02 /* Public */,
     135,    1, 1278,    2, 0x02 /* Public */,
     136,    0, 1281,    2, 0x02 /* Public */,
     137,    1, 1282,    2, 0x02 /* Public */,
     138,    1, 1285,    2, 0x02 /* Public */,
     139,    2, 1288,    2, 0x02 /* Public */,
     141,    2, 1293,    2, 0x02 /* Public */,
     142,    0, 1298,    2, 0x02 /* Public */,
     143,    1, 1299,    2, 0x02 /* Public */,
     144,    1, 1302,    2, 0x02 /* Public */,
     145,    1, 1305,    2, 0x02 /* Public */,
     145,    2, 1308,    2, 0x02 /* Public */,
     146,    3, 1313,    2, 0x02 /* Public */,
     148,    1, 1320,    2, 0x02 /* Public */,
     148,    2, 1323,    2, 0x02 /* Public */,
     149,    2, 1328,    2, 0x02 /* Public */,
     150,    1, 1333,    2, 0x02 /* Public */,
     151,    0, 1336,    2, 0x02 /* Public */,
     152,    0, 1337,    2, 0x02 /* Public */,
     153,    1, 1338,    2, 0x02 /* Public */,
     154,    1, 1341,    2, 0x02 /* Public */,
     155,    1, 1344,    2, 0x02 /* Public */,
     156,    4, 1347,    2, 0x02 /* Public */,
     157,    1, 1356,    2, 0x02 /* Public */,
     158,    1, 1359,    2, 0x02 /* Public */,
     159,    5, 1362,    2, 0x02 /* Public */,
     160,    4, 1373,    2, 0x02 /* Public */,
     162,    0, 1382,    2, 0x02 /* Public */,
     162,    1, 1383,    2, 0x02 /* Public */,
     163,    1, 1386,    2, 0x02 /* Public */,
     164,    2, 1389,    2, 0x02 /* Public */,
     165,    2, 1394,    2, 0x02 /* Public */,
     166,    5, 1399,    2, 0x02 /* Public */,
     171,    2, 1410,    2, 0x02 /* Public */,
     173,    2, 1415,    2, 0x02 /* Public */,
     174,    1, 1420,    2, 0x02 /* Public */,
     176,    1, 1423,    2, 0x02 /* Public */,
     177,    0, 1426,    2, 0x02 /* Public */,
     178,    1, 1427,    2, 0x02 /* Public */,
     180,    2, 1430,    2, 0x02 /* Public */,
     181,    0, 1435,    2, 0x02 /* Public */,
     182,    0, 1436,    2, 0x02 /* Public */,
     183,    1, 1437,    2, 0x02 /* Public */,
     183,    3, 1440,    2, 0x02 /* Public */,
     185,    0, 1447,    2, 0x02 /* Public */,
     186,    0, 1448,    2, 0x02 /* Public */,
     187,    0, 1449,    2, 0x02 /* Public */,
     188,    0, 1450,    2, 0x02 /* Public */,
     189,    0, 1451,    2, 0x02 /* Public */,
     190,    0, 1452,    2, 0x02 /* Public */,
     191,    0, 1453,    2, 0x02 /* Public */,
     192,    0, 1454,    2, 0x02 /* Public */,
     193,    0, 1455,    2, 0x02 /* Public */,
     195,    1, 1456,    2, 0x02 /* Public */,
     196,    1, 1459,    2, 0x02 /* Public */,
     198,    0, 1462,    2, 0x02 /* Public */,
     199,    0, 1463,    2, 0x02 /* Public */,
     200,    0, 1464,    2, 0x02 /* Public */,
     201,    0, 1465,    2, 0x02 /* Public */,
     202,    0, 1466,    2, 0x02 /* Public */,
     203,    0, 1467,    2, 0x02 /* Public */,
     204,    1, 1468,    2, 0x02 /* Public */,
     205,    0, 1471,    2, 0x02 /* Public */,
     206,    0, 1472,    2, 0x02 /* Public */,
     207,    0, 1473,    2, 0x02 /* Public */,
     208,    0, 1474,    2, 0x02 /* Public */,
     209,    0, 1475,    2, 0x02 /* Public */,
     210,    0, 1476,    2, 0x02 /* Public */,
     211,    1, 1477,    2, 0x02 /* Public */,
     212,    1, 1480,    2, 0x02 /* Public */,
     213,    1, 1483,    2, 0x02 /* Public */,
     214,    0, 1486,    2, 0x02 /* Public */,
     215,    1, 1487,    2, 0x02 /* Public */,
     216,    1, 1490,    2, 0x02 /* Public */,
     217,    0, 1493,    2, 0x02 /* Public */,
     218,    0, 1494,    2, 0x02 /* Public */,
     219,    0, 1495,    2, 0x02 /* Public */,
     220,    0, 1496,    2, 0x02 /* Public */,
     221,    0, 1497,    2, 0x02 /* Public */,
     222,    0, 1498,    2, 0x02 /* Public */,
     223,    0, 1499,    2, 0x02 /* Public */,
     224,    3, 1500,    2, 0x02 /* Public */,
     225,    3, 1507,    2, 0x02 /* Public */,
     226,    2, 1514,    2, 0x02 /* Public */,
     227,    0, 1519,    2, 0x02 /* Public */,
     228,    0, 1520,    2, 0x02 /* Public */,
     229,    0, 1521,    2, 0x02 /* Public */,
     230,    1, 1522,    2, 0x02 /* Public */,
     231,    1, 1525,    2, 0x02 /* Public */,
     232,    5, 1528,    2, 0x02 /* Public */,
     234,    0, 1539,    2, 0x02 /* Public */,
     235,    1, 1540,    2, 0x02 /* Public */,
     236,    1, 1543,    2, 0x02 /* Public */,
     237,    1, 1546,    2, 0x02 /* Public */,
     238,    1, 1549,    2, 0x02 /* Public */,
     239,    1, 1552,    2, 0x02 /* Public */,
     240,    1, 1555,    2, 0x02 /* Public */,
     241,    1, 1558,    2, 0x02 /* Public */,
     242,    1, 1561,    2, 0x02 /* Public */,
     243,    0, 1564,    2, 0x02 /* Public */,
     244,    1, 1565,    2, 0x02 /* Public */,
     245,    0, 1568,    2, 0x02 /* Public */,
     246,    0, 1569,    2, 0x02 /* Public */,
     247,    0, 1570,    2, 0x02 /* Public */,
     248,    0, 1571,    2, 0x02 /* Public */,
     249,    0, 1572,    2, 0x02 /* Public */,
     250,    0, 1573,    2, 0x02 /* Public */,

 // slots: parameters
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
    QMetaType::Void, QMetaType::QString,   13,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Float,   16,
    QMetaType::Float,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   20,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   23,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   26,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   29,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   32,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   20,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   20,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   20,
    QMetaType::QString,
    QMetaType::Void, QMetaType::Int,   41,
    QMetaType::Void, QMetaType::QString,   43,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   47,
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   20,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   61,
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString, QMetaType::Int,   65,   66,   67,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   23,
    QMetaType::QString, QMetaType::Int,   23,
    QMetaType::Void, QMetaType::QString,   77,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   67,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,   82,   83,   84,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   95,
    0x80000000 | 97,
    QMetaType::Void, 0x80000000 | 97,   99,
    QMetaType::Bool,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Int, QMetaType::Int,   23,
    QMetaType::QString, QMetaType::Int,   67,
    QMetaType::QString, QMetaType::Int,   67,
    QMetaType::Int,
    QMetaType::Int,
    0x80000000 | 108, QMetaType::Int,  109,
    0x80000000 | 108, QMetaType::Int,  109,
    QMetaType::QString, QMetaType::Int,  109,
    QMetaType::Float, QMetaType::Int,  109,
    QMetaType::Void, QMetaType::QString, QMetaType::Float,  114,  115,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   82,   83,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,  125,
    0x80000000 | 108,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int, QMetaType::QString,   41,
    QMetaType::QString, QMetaType::Int,   23,
    QMetaType::QString, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   23,
    QMetaType::Int, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   23,  140,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   23,  140,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Int, QMetaType::QString,   43,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   82,   83,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  147,   82,   83,
    QMetaType::Int, QMetaType::QString,   43,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   82,   83,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   82,   83,
    QMetaType::Void, QMetaType::Int,   23,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int, QMetaType::QString,   41,
    QMetaType::Void, QMetaType::QString,   41,
    QMetaType::Void, QMetaType::QString,   41,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   23,  140,   82,   83,
    QMetaType::Void, QMetaType::Int,   23,
    QMetaType::Void, QMetaType::QString,   43,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::Float,   41,   43,   82,   83,   84,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Float,  161,   82,   83,   84,
    QMetaType::Int,
    QMetaType::Int, QMetaType::Int,   23,
    QMetaType::QString, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   23,  140,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   23,  140,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   23,  167,  168,  169,  170,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   23,  172,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   82,   83,
    QMetaType::Bool, QMetaType::QString,  175,
    QMetaType::Bool, QMetaType::QString,  175,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,  179,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   26,   29,
    QMetaType::Void,
    0x80000000 | 108,
    QMetaType::Void, QMetaType::QString,  184,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,   82,   83,   84,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    0x80000000 | 194,
    QMetaType::Void, QMetaType::Float,   82,
    QMetaType::Void, QMetaType::Float,  197,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,   43,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Int,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float,
    0x80000000 | 108,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QString,   82,   83,   43,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QString,   82,   83,   43,
    QMetaType::QString, QMetaType::Int, QMetaType::Int,   82,   83,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   77,
    QMetaType::Void, QMetaType::QString,   77,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Float, QMetaType::Float, QMetaType::Float,   41,  233,   82,   83,   84,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   23,
    QMetaType::QString, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Void, QMetaType::Int,   23,
    QMetaType::Void, QMetaType::Int,   23,
    QMetaType::Void, QMetaType::Int,   23,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,   67,
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
        case 6: _t->path_changed(); break;
        case 7: _t->usb_detect(); break;
        case 8: _t->programExit(); break;
        case 9: _t->programHide(); break;
        case 10: _t->writelog((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 11: _t->readSetting(); break;
        case 12: _t->setVelocity((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 13: { float _r = _t->getVelocity();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 14: { bool _r = _t->getuseTravelline();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 15: _t->setuseTravelline((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 16: { int _r = _t->getnumTravelline();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 17: _t->setnumTravelline((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 18: { int _r = _t->getTrayNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 19: _t->setTrayNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 20: { int _r = _t->getTableNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 21: _t->setTableNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 22: { int _r = _t->getTableColNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 23: _t->setTableColNum((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 24: { bool _r = _t->getuseVoice();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 25: _t->setuseVoice((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 26: { bool _r = _t->getuseBGM();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 27: _t->setuseBGM((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 28: { bool _r = _t->getserverCMD();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 29: _t->setserverCMD((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 30: { QString _r = _t->getRobotType();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 31: _t->setRobotType((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 32: _t->setDebugName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 33: { QString _r = _t->getDebugName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 34: { bool _r = _t->getDebugState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 35: _t->setDebugState((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 36: { bool _r = _t->isConnectServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 37: { int _r = _t->isExistMap();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 38: { bool _r = _t->loadMaptoServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 39: { bool _r = _t->isUSBFile();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 40: { QString _r = _t->getUSBFilename();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 41: { bool _r = _t->loadMaptoUSB();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 42: { bool _r = _t->isuseServerMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 43: _t->setuseServerMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 44: _t->removeRawMap(); break;
        case 45: _t->removeEditedMap(); break;
        case 46: _t->removeServerMap(); break;
        case 47: { bool _r = _t->isloadMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 48: _t->setloadMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 49: { bool _r = _t->isExistRobotINI();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 50: _t->makeRobotINI(); break;
        case 51: { bool _r = _t->rotate_map((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 52: { bool _r = _t->getLCMConnection();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 53: { bool _r = _t->getLCMRX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 54: { bool _r = _t->getLCMTX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 55: { bool _r = _t->getLCMProcess();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 56: { bool _r = _t->getIniRead();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 57: { int _r = _t->getUsbMapSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 58: { QString _r = _t->getUsbMapPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 59: { QString _r = _t->getUsbMapPathFull((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 60: _t->saveMapfromUsb((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 61: _t->startMapping(); break;
        case 62: _t->stopMapping(); break;
        case 63: _t->setSLAMMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 64: _t->setInitPos((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 65: { float _r = _t->getInitPoseX();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 66: { float _r = _t->getInitPoseY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 67: { float _r = _t->getInitPoseTH();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 68: _t->slam_setInit(); break;
        case 69: _t->slam_run(); break;
        case 70: _t->slam_stop(); break;
        case 71: _t->slam_autoInit(); break;
        case 72: { bool _r = _t->is_slam_running();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 73: { bool _r = _t->getMappingflag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 74: _t->setMappingflag((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 75: { QList<int> _r = _t->getMapping();
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 76: _t->pushMapData((*reinterpret_cast< QList<int>(*)>(_a[1]))); break;
        case 77: { bool _r = _t->isconnectJoy();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 78: { float _r = _t->getJoyAxis((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 79: { int _r = _t->getJoyButton((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 80: { QString _r = _t->getKeyboard((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 81: { QString _r = _t->getJoystick((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 82: { int _r = _t->getCanvasSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 83: { int _r = _t->getRedoSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 84: { QVector<int> _r = _t->getLineX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 85: { QVector<int> _r = _t->getLineY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 86: { QString _r = _t->getLineColor((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 87: { float _r = _t->getLineWidth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 88: _t->startLine((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 89: _t->setLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 90: _t->stopLine(); break;
        case 91: _t->undo(); break;
        case 92: _t->redo(); break;
        case 93: _t->clear_all(); break;
        case 94: _t->setObjPose(); break;
        case 95: _t->setMarginObj(); break;
        case 96: _t->clearMarginObj(); break;
        case 97: _t->setMarginPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 98: { QVector<int> _r = _t->getMarginObj();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 99: { float _r = _t->getMargin();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 100: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 101: { int _r = _t->getLocationSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 102: { QString _r = _t->getLocationName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 103: { QString _r = _t->getLocationTypes((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 104: { float _r = _t->getLocationx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 105: { float _r = _t->getLocationy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 106: { float _r = _t->getLocationth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 107: { float _r = _t->getLidar((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 108: { int _r = _t->getObjectNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 109: { QString _r = _t->getObjectName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 110: { int _r = _t->getObjectPointSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 111: { float _r = _t->getObjectX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 112: { float _r = _t->getObjectY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 113: { int _r = _t->getTempObjectSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 114: { float _r = _t->getTempObjectX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 115: { float _r = _t->getTempObjectY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 116: { int _r = _t->getObjNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 117: { int _r = _t->getObjNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 118: { int _r = _t->getObjPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 119: { int _r = _t->getLocNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 120: { int _r = _t->getLocNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 121: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 122: _t->removeObjectPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 123: _t->removeObjectPointLast(); break;
        case 124: _t->clearObjectPoints(); break;
        case 125: { int _r = _t->getObjectSize((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 126: _t->addObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 127: _t->addObjectRect((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 128: _t->editObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4]))); break;
        case 129: _t->removeObject((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 130: _t->removeLocation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 131: _t->addLocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< float(*)>(_a[5]))); break;
        case 132: _t->moveLocationPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 133: { int _r = _t->getTlineSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 134: { int _r = _t->getTlineSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 135: { QString _r = _t->getTlineName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 136: { float _r = _t->getTlineX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 137: { float _r = _t->getTlineY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 138: _t->addTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< int(*)>(_a[5]))); break;
        case 139: _t->removeTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 140: { int _r = _t->getTlineNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 141: { bool _r = _t->saveAnnotation((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 142: { bool _r = _t->saveMetaData((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 143: _t->sendMaptoServer(); break;
        case 144: _t->acceptCall((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 145: _t->setTray((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 146: _t->confirmPickup(); break;
        case 147: { QVector<int> _r = _t->getPickuptrays();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 148: _t->moveTo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 149: _t->moveTo((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 150: _t->movePause(); break;
        case 151: _t->moveResume(); break;
        case 152: _t->moveStop(); break;
        case 153: _t->moveManual(); break;
        case 154: _t->moveToCharge(); break;
        case 155: _t->moveToWait(); break;
        case 156: { QString _r = _t->getcurLoc();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 157: { QString _r = _t->getcurTable();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 158: { QVector<float> _r = _t->getcurTarget();
            if (_a[0]) *reinterpret_cast< QVector<float>*>(_a[0]) = std::move(_r); }  break;
        case 159: _t->joyMoveXY((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 160: _t->joyMoveR((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 161: { float _r = _t->getJoyXY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 162: { float _r = _t->getJoyR();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 163: { float _r = _t->getBattery();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 164: { int _r = _t->getState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 165: { int _r = _t->getErrcode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 166: { QString _r = _t->getRobotName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 167: _t->setRobotName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 168: { float _r = _t->getRobotRadius();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 169: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 170: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 171: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 172: { int _r = _t->getRobotState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 173: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 174: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 175: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 176: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 177: { int _r = _t->getLocalPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 178: { float _r = _t->getLocalPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 179: { float _r = _t->getLocalPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 180: { int _r = _t->getuistate();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 181: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 182: { QString _r = _t->getMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 183: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 184: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 185: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 186: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 187: _t->setGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 188: _t->editGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 189: { QString _r = _t->getGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 190: _t->make_minimap(); break;
        case 191: { QString _r = _t->getPatrolFileName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 192: _t->makePatrol(); break;
        case 193: _t->loadPatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 194: _t->savePatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 195: _t->addPatrol((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4])),(*reinterpret_cast< float(*)>(_a[5]))); break;
        case 196: { int _r = _t->getPatrolNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 197: { QString _r = _t->getPatrolType((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 198: { QString _r = _t->getPatrolLocation((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 199: { float _r = _t->getPatrolX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 200: { float _r = _t->getPatrolY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 201: { float _r = _t->getPatrolTH((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 202: _t->removePatrol((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 203: _t->movePatrolUp((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 204: _t->movePatrolDown((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 205: { int _r = _t->getPatrolMode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 206: _t->setPatrolMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 207: _t->startRecordPath(); break;
        case 208: _t->startcurPath(); break;
        case 209: _t->stopcurPath(); break;
        case 210: _t->pausecurPath(); break;
        case 211: _t->runRotateTables(); break;
        case 212: _t->stopRotateTables(); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 76:
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
        if (_id < 213)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 213;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 213)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 213;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
