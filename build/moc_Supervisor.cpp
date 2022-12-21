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
    QByteArrayData data[247];
    char stringdata0[2870];
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
QT_MOC_LITERAL(30, 355, 11), // "getuseVoice"
QT_MOC_LITERAL(31, 367, 11), // "setuseVoice"
QT_MOC_LITERAL(32, 379, 9), // "getuseBGM"
QT_MOC_LITERAL(33, 389, 9), // "setuseBGM"
QT_MOC_LITERAL(34, 399, 12), // "getserverCMD"
QT_MOC_LITERAL(35, 412, 12), // "setserverCMD"
QT_MOC_LITERAL(36, 425, 12), // "getRobotType"
QT_MOC_LITERAL(37, 438, 12), // "setRobotType"
QT_MOC_LITERAL(38, 451, 4), // "type"
QT_MOC_LITERAL(39, 456, 12), // "setDebugName"
QT_MOC_LITERAL(40, 469, 4), // "name"
QT_MOC_LITERAL(41, 474, 12), // "getDebugName"
QT_MOC_LITERAL(42, 487, 13), // "getDebugState"
QT_MOC_LITERAL(43, 501, 13), // "setDebugState"
QT_MOC_LITERAL(44, 515, 7), // "isdebug"
QT_MOC_LITERAL(45, 523, 15), // "isConnectServer"
QT_MOC_LITERAL(46, 539, 10), // "isExistMap"
QT_MOC_LITERAL(47, 550, 15), // "loadMaptoServer"
QT_MOC_LITERAL(48, 566, 9), // "isUSBFile"
QT_MOC_LITERAL(49, 576, 14), // "getUSBFilename"
QT_MOC_LITERAL(50, 591, 12), // "loadMaptoUSB"
QT_MOC_LITERAL(51, 604, 14), // "isuseServerMap"
QT_MOC_LITERAL(52, 619, 15), // "setuseServerMap"
QT_MOC_LITERAL(53, 635, 12), // "removeRawMap"
QT_MOC_LITERAL(54, 648, 15), // "removeEditedMap"
QT_MOC_LITERAL(55, 664, 15), // "removeServerMap"
QT_MOC_LITERAL(56, 680, 9), // "isloadMap"
QT_MOC_LITERAL(57, 690, 10), // "setloadMap"
QT_MOC_LITERAL(58, 701, 4), // "load"
QT_MOC_LITERAL(59, 706, 15), // "isExistRobotINI"
QT_MOC_LITERAL(60, 722, 12), // "makeRobotINI"
QT_MOC_LITERAL(61, 735, 10), // "rotate_map"
QT_MOC_LITERAL(62, 746, 4), // "_src"
QT_MOC_LITERAL(63, 751, 4), // "_dst"
QT_MOC_LITERAL(64, 756, 4), // "mode"
QT_MOC_LITERAL(65, 761, 16), // "getLCMConnection"
QT_MOC_LITERAL(66, 778, 8), // "getLCMRX"
QT_MOC_LITERAL(67, 787, 8), // "getLCMTX"
QT_MOC_LITERAL(68, 796, 13), // "getLCMProcess"
QT_MOC_LITERAL(69, 810, 10), // "getIniRead"
QT_MOC_LITERAL(70, 821, 13), // "getUsbMapSize"
QT_MOC_LITERAL(71, 835, 13), // "getUsbMapPath"
QT_MOC_LITERAL(72, 849, 17), // "getUsbMapPathFull"
QT_MOC_LITERAL(73, 867, 14), // "saveMapfromUsb"
QT_MOC_LITERAL(74, 882, 4), // "path"
QT_MOC_LITERAL(75, 887, 12), // "startMapping"
QT_MOC_LITERAL(76, 900, 11), // "stopMapping"
QT_MOC_LITERAL(77, 912, 11), // "setSLAMMode"
QT_MOC_LITERAL(78, 924, 10), // "setInitPos"
QT_MOC_LITERAL(79, 935, 1), // "x"
QT_MOC_LITERAL(80, 937, 1), // "y"
QT_MOC_LITERAL(81, 939, 2), // "th"
QT_MOC_LITERAL(82, 942, 12), // "getInitPoseX"
QT_MOC_LITERAL(83, 955, 12), // "getInitPoseY"
QT_MOC_LITERAL(84, 968, 13), // "getInitPoseTH"
QT_MOC_LITERAL(85, 982, 12), // "slam_setInit"
QT_MOC_LITERAL(86, 995, 8), // "slam_run"
QT_MOC_LITERAL(87, 1004, 9), // "slam_stop"
QT_MOC_LITERAL(88, 1014, 13), // "slam_autoInit"
QT_MOC_LITERAL(89, 1028, 15), // "is_slam_running"
QT_MOC_LITERAL(90, 1044, 14), // "getMappingflag"
QT_MOC_LITERAL(91, 1059, 14), // "setMappingflag"
QT_MOC_LITERAL(92, 1074, 4), // "flag"
QT_MOC_LITERAL(93, 1079, 10), // "getMapping"
QT_MOC_LITERAL(94, 1090, 10), // "QList<int>"
QT_MOC_LITERAL(95, 1101, 11), // "pushMapData"
QT_MOC_LITERAL(96, 1113, 4), // "data"
QT_MOC_LITERAL(97, 1118, 12), // "isconnectJoy"
QT_MOC_LITERAL(98, 1131, 10), // "getJoyAxis"
QT_MOC_LITERAL(99, 1142, 12), // "getJoyButton"
QT_MOC_LITERAL(100, 1155, 11), // "getKeyboard"
QT_MOC_LITERAL(101, 1167, 11), // "getJoystick"
QT_MOC_LITERAL(102, 1179, 13), // "getCanvasSize"
QT_MOC_LITERAL(103, 1193, 11), // "getRedoSize"
QT_MOC_LITERAL(104, 1205, 8), // "getLineX"
QT_MOC_LITERAL(105, 1214, 12), // "QVector<int>"
QT_MOC_LITERAL(106, 1227, 5), // "index"
QT_MOC_LITERAL(107, 1233, 8), // "getLineY"
QT_MOC_LITERAL(108, 1242, 12), // "getLineColor"
QT_MOC_LITERAL(109, 1255, 12), // "getLineWidth"
QT_MOC_LITERAL(110, 1268, 9), // "startLine"
QT_MOC_LITERAL(111, 1278, 5), // "color"
QT_MOC_LITERAL(112, 1284, 5), // "width"
QT_MOC_LITERAL(113, 1290, 7), // "setLine"
QT_MOC_LITERAL(114, 1298, 8), // "stopLine"
QT_MOC_LITERAL(115, 1307, 4), // "undo"
QT_MOC_LITERAL(116, 1312, 4), // "redo"
QT_MOC_LITERAL(117, 1317, 9), // "clear_all"
QT_MOC_LITERAL(118, 1327, 10), // "setObjPose"
QT_MOC_LITERAL(119, 1338, 12), // "setMarginObj"
QT_MOC_LITERAL(120, 1351, 14), // "clearMarginObj"
QT_MOC_LITERAL(121, 1366, 14), // "setMarginPoint"
QT_MOC_LITERAL(122, 1381, 9), // "pixel_num"
QT_MOC_LITERAL(123, 1391, 12), // "getMarginObj"
QT_MOC_LITERAL(124, 1404, 9), // "getMargin"
QT_MOC_LITERAL(125, 1414, 14), // "getLocationNum"
QT_MOC_LITERAL(126, 1429, 16), // "getLocationTypes"
QT_MOC_LITERAL(127, 1446, 12), // "getLocationx"
QT_MOC_LITERAL(128, 1459, 12), // "getLocationy"
QT_MOC_LITERAL(129, 1472, 13), // "getLocationth"
QT_MOC_LITERAL(130, 1486, 8), // "getLidar"
QT_MOC_LITERAL(131, 1495, 12), // "getObjectNum"
QT_MOC_LITERAL(132, 1508, 13), // "getObjectName"
QT_MOC_LITERAL(133, 1522, 18), // "getObjectPointSize"
QT_MOC_LITERAL(134, 1541, 10), // "getObjectX"
QT_MOC_LITERAL(135, 1552, 5), // "point"
QT_MOC_LITERAL(136, 1558, 10), // "getObjectY"
QT_MOC_LITERAL(137, 1569, 17), // "getTempObjectSize"
QT_MOC_LITERAL(138, 1587, 14), // "getTempObjectX"
QT_MOC_LITERAL(139, 1602, 14), // "getTempObjectY"
QT_MOC_LITERAL(140, 1617, 9), // "getObjNum"
QT_MOC_LITERAL(141, 1627, 14), // "getObjPointNum"
QT_MOC_LITERAL(142, 1642, 7), // "obj_num"
QT_MOC_LITERAL(143, 1650, 9), // "getLocNum"
QT_MOC_LITERAL(144, 1660, 14), // "addObjectPoint"
QT_MOC_LITERAL(145, 1675, 15), // "editObjectPoint"
QT_MOC_LITERAL(146, 1691, 17), // "removeObjectPoint"
QT_MOC_LITERAL(147, 1709, 21), // "removeObjectPointLast"
QT_MOC_LITERAL(148, 1731, 17), // "clearObjectPoints"
QT_MOC_LITERAL(149, 1749, 9), // "addObject"
QT_MOC_LITERAL(150, 1759, 14), // "editObjectRect"
QT_MOC_LITERAL(151, 1774, 12), // "removeObject"
QT_MOC_LITERAL(152, 1787, 15), // "moveObjectPoint"
QT_MOC_LITERAL(153, 1803, 9), // "point_num"
QT_MOC_LITERAL(154, 1813, 14), // "removeLocation"
QT_MOC_LITERAL(155, 1828, 11), // "addLocation"
QT_MOC_LITERAL(156, 1840, 17), // "moveLocationPoint"
QT_MOC_LITERAL(157, 1858, 7), // "loc_num"
QT_MOC_LITERAL(158, 1866, 12), // "getTlineSize"
QT_MOC_LITERAL(159, 1879, 12), // "getTlineName"
QT_MOC_LITERAL(160, 1892, 9), // "getTlineX"
QT_MOC_LITERAL(161, 1902, 9), // "getTlineY"
QT_MOC_LITERAL(162, 1912, 8), // "addTline"
QT_MOC_LITERAL(163, 1921, 2), // "x1"
QT_MOC_LITERAL(164, 1924, 2), // "y1"
QT_MOC_LITERAL(165, 1927, 2), // "x2"
QT_MOC_LITERAL(166, 1930, 2), // "y2"
QT_MOC_LITERAL(167, 1933, 11), // "removeTline"
QT_MOC_LITERAL(168, 1945, 4), // "line"
QT_MOC_LITERAL(169, 1950, 11), // "getTlineNum"
QT_MOC_LITERAL(170, 1962, 14), // "saveAnnotation"
QT_MOC_LITERAL(171, 1977, 8), // "filename"
QT_MOC_LITERAL(172, 1986, 12), // "saveMetaData"
QT_MOC_LITERAL(173, 1999, 15), // "sendMaptoServer"
QT_MOC_LITERAL(174, 2015, 10), // "acceptCall"
QT_MOC_LITERAL(175, 2026, 3), // "yes"
QT_MOC_LITERAL(176, 2030, 7), // "setTray"
QT_MOC_LITERAL(177, 2038, 13), // "confirmPickup"
QT_MOC_LITERAL(178, 2052, 14), // "getPickuptrays"
QT_MOC_LITERAL(179, 2067, 6), // "moveTo"
QT_MOC_LITERAL(180, 2074, 10), // "target_num"
QT_MOC_LITERAL(181, 2085, 9), // "movePause"
QT_MOC_LITERAL(182, 2095, 10), // "moveResume"
QT_MOC_LITERAL(183, 2106, 8), // "moveStop"
QT_MOC_LITERAL(184, 2115, 10), // "moveManual"
QT_MOC_LITERAL(185, 2126, 12), // "moveToCharge"
QT_MOC_LITERAL(186, 2139, 10), // "moveToWait"
QT_MOC_LITERAL(187, 2150, 9), // "getcurLoc"
QT_MOC_LITERAL(188, 2160, 11), // "getcurTable"
QT_MOC_LITERAL(189, 2172, 12), // "getcurTarget"
QT_MOC_LITERAL(190, 2185, 14), // "QVector<float>"
QT_MOC_LITERAL(191, 2200, 9), // "joyMoveXY"
QT_MOC_LITERAL(192, 2210, 8), // "joyMoveR"
QT_MOC_LITERAL(193, 2219, 1), // "r"
QT_MOC_LITERAL(194, 2221, 8), // "getJoyXY"
QT_MOC_LITERAL(195, 2230, 7), // "getJoyR"
QT_MOC_LITERAL(196, 2238, 10), // "getBattery"
QT_MOC_LITERAL(197, 2249, 8), // "getState"
QT_MOC_LITERAL(198, 2258, 10), // "getErrcode"
QT_MOC_LITERAL(199, 2269, 12), // "getRobotName"
QT_MOC_LITERAL(200, 2282, 12), // "setRobotName"
QT_MOC_LITERAL(201, 2295, 14), // "getRobotRadius"
QT_MOC_LITERAL(202, 2310, 9), // "getRobotx"
QT_MOC_LITERAL(203, 2320, 9), // "getRoboty"
QT_MOC_LITERAL(204, 2330, 10), // "getRobotth"
QT_MOC_LITERAL(205, 2341, 13), // "getRobotState"
QT_MOC_LITERAL(206, 2355, 10), // "getPathNum"
QT_MOC_LITERAL(207, 2366, 8), // "getPathx"
QT_MOC_LITERAL(208, 2375, 8), // "getPathy"
QT_MOC_LITERAL(209, 2384, 9), // "getPathth"
QT_MOC_LITERAL(210, 2394, 15), // "getLocalPathNum"
QT_MOC_LITERAL(211, 2410, 13), // "getLocalPathx"
QT_MOC_LITERAL(212, 2424, 13), // "getLocalPathy"
QT_MOC_LITERAL(213, 2438, 10), // "getuistate"
QT_MOC_LITERAL(214, 2449, 10), // "getMapname"
QT_MOC_LITERAL(215, 2460, 10), // "getMappath"
QT_MOC_LITERAL(216, 2471, 11), // "getMapWidth"
QT_MOC_LITERAL(217, 2483, 12), // "getMapHeight"
QT_MOC_LITERAL(218, 2496, 12), // "getGridWidth"
QT_MOC_LITERAL(219, 2509, 9), // "getOrigin"
QT_MOC_LITERAL(220, 2519, 7), // "setGrid"
QT_MOC_LITERAL(221, 2527, 8), // "editGrid"
QT_MOC_LITERAL(222, 2536, 7), // "getGrid"
QT_MOC_LITERAL(223, 2544, 12), // "make_minimap"
QT_MOC_LITERAL(224, 2557, 17), // "getPatrolFileName"
QT_MOC_LITERAL(225, 2575, 10), // "makePatrol"
QT_MOC_LITERAL(226, 2586, 14), // "loadPatrolFile"
QT_MOC_LITERAL(227, 2601, 14), // "savePatrolFile"
QT_MOC_LITERAL(228, 2616, 9), // "addPatrol"
QT_MOC_LITERAL(229, 2626, 8), // "location"
QT_MOC_LITERAL(230, 2635, 12), // "getPatrolNum"
QT_MOC_LITERAL(231, 2648, 13), // "getPatrolType"
QT_MOC_LITERAL(232, 2662, 17), // "getPatrolLocation"
QT_MOC_LITERAL(233, 2680, 10), // "getPatrolX"
QT_MOC_LITERAL(234, 2691, 10), // "getPatrolY"
QT_MOC_LITERAL(235, 2702, 11), // "getPatrolTH"
QT_MOC_LITERAL(236, 2714, 12), // "removePatrol"
QT_MOC_LITERAL(237, 2727, 12), // "movePatrolUp"
QT_MOC_LITERAL(238, 2740, 14), // "movePatrolDown"
QT_MOC_LITERAL(239, 2755, 13), // "getPatrolMode"
QT_MOC_LITERAL(240, 2769, 13), // "setPatrolMode"
QT_MOC_LITERAL(241, 2783, 15), // "startRecordPath"
QT_MOC_LITERAL(242, 2799, 12), // "startcurPath"
QT_MOC_LITERAL(243, 2812, 11), // "stopcurPath"
QT_MOC_LITERAL(244, 2824, 12), // "pausecurPath"
QT_MOC_LITERAL(245, 2837, 15), // "runRotateTables"
QT_MOC_LITERAL(246, 2853, 16) // "stopRotateTables"

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
    "getLocationTypes\0getLocationx\0"
    "getLocationy\0getLocationth\0getLidar\0"
    "getObjectNum\0getObjectName\0"
    "getObjectPointSize\0getObjectX\0point\0"
    "getObjectY\0getTempObjectSize\0"
    "getTempObjectX\0getTempObjectY\0getObjNum\0"
    "getObjPointNum\0obj_num\0getLocNum\0"
    "addObjectPoint\0editObjectPoint\0"
    "removeObjectPoint\0removeObjectPointLast\0"
    "clearObjectPoints\0addObject\0editObjectRect\0"
    "removeObject\0moveObjectPoint\0point_num\0"
    "removeLocation\0addLocation\0moveLocationPoint\0"
    "loc_num\0getTlineSize\0getTlineName\0"
    "getTlineX\0getTlineY\0addTline\0x1\0y1\0"
    "x2\0y2\0removeTline\0line\0getTlineNum\0"
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
     210,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0, 1064,    2, 0x0a /* Public */,
       3,    0, 1065,    2, 0x0a /* Public */,
       4,    0, 1066,    2, 0x0a /* Public */,
       5,    0, 1067,    2, 0x0a /* Public */,
       6,    0, 1068,    2, 0x0a /* Public */,
       7,    0, 1069,    2, 0x0a /* Public */,
       8,    0, 1070,    2, 0x0a /* Public */,
       9,    0, 1071,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      10,    0, 1072,    2, 0x02 /* Public */,
      11,    0, 1073,    2, 0x02 /* Public */,
      12,    1, 1074,    2, 0x02 /* Public */,
      14,    0, 1077,    2, 0x02 /* Public */,
      15,    1, 1078,    2, 0x02 /* Public */,
      17,    0, 1081,    2, 0x02 /* Public */,
      18,    0, 1082,    2, 0x02 /* Public */,
      19,    1, 1083,    2, 0x02 /* Public */,
      21,    0, 1086,    2, 0x02 /* Public */,
      22,    1, 1087,    2, 0x02 /* Public */,
      24,    0, 1090,    2, 0x02 /* Public */,
      25,    1, 1091,    2, 0x02 /* Public */,
      27,    0, 1094,    2, 0x02 /* Public */,
      28,    1, 1095,    2, 0x02 /* Public */,
      30,    0, 1098,    2, 0x02 /* Public */,
      31,    1, 1099,    2, 0x02 /* Public */,
      32,    0, 1102,    2, 0x02 /* Public */,
      33,    1, 1103,    2, 0x02 /* Public */,
      34,    0, 1106,    2, 0x02 /* Public */,
      35,    1, 1107,    2, 0x02 /* Public */,
      36,    0, 1110,    2, 0x02 /* Public */,
      37,    1, 1111,    2, 0x02 /* Public */,
      39,    1, 1114,    2, 0x02 /* Public */,
      41,    0, 1117,    2, 0x02 /* Public */,
      42,    0, 1118,    2, 0x02 /* Public */,
      43,    1, 1119,    2, 0x02 /* Public */,
      45,    0, 1122,    2, 0x02 /* Public */,
      46,    0, 1123,    2, 0x02 /* Public */,
      47,    0, 1124,    2, 0x02 /* Public */,
      48,    0, 1125,    2, 0x02 /* Public */,
      49,    0, 1126,    2, 0x02 /* Public */,
      50,    0, 1127,    2, 0x02 /* Public */,
      51,    0, 1128,    2, 0x02 /* Public */,
      52,    1, 1129,    2, 0x02 /* Public */,
      53,    0, 1132,    2, 0x02 /* Public */,
      54,    0, 1133,    2, 0x02 /* Public */,
      55,    0, 1134,    2, 0x02 /* Public */,
      56,    0, 1135,    2, 0x02 /* Public */,
      57,    1, 1136,    2, 0x02 /* Public */,
      59,    0, 1139,    2, 0x02 /* Public */,
      60,    0, 1140,    2, 0x02 /* Public */,
      61,    3, 1141,    2, 0x02 /* Public */,
      65,    0, 1148,    2, 0x02 /* Public */,
      66,    0, 1149,    2, 0x02 /* Public */,
      67,    0, 1150,    2, 0x02 /* Public */,
      68,    0, 1151,    2, 0x02 /* Public */,
      69,    0, 1152,    2, 0x02 /* Public */,
      70,    0, 1153,    2, 0x02 /* Public */,
      71,    1, 1154,    2, 0x02 /* Public */,
      72,    1, 1157,    2, 0x02 /* Public */,
      73,    1, 1160,    2, 0x02 /* Public */,
      75,    0, 1163,    2, 0x02 /* Public */,
      76,    0, 1164,    2, 0x02 /* Public */,
      77,    1, 1165,    2, 0x02 /* Public */,
      78,    3, 1168,    2, 0x02 /* Public */,
      82,    0, 1175,    2, 0x02 /* Public */,
      83,    0, 1176,    2, 0x02 /* Public */,
      84,    0, 1177,    2, 0x02 /* Public */,
      85,    0, 1178,    2, 0x02 /* Public */,
      86,    0, 1179,    2, 0x02 /* Public */,
      87,    0, 1180,    2, 0x02 /* Public */,
      88,    0, 1181,    2, 0x02 /* Public */,
      89,    0, 1182,    2, 0x02 /* Public */,
      90,    0, 1183,    2, 0x02 /* Public */,
      91,    1, 1184,    2, 0x02 /* Public */,
      93,    0, 1187,    2, 0x02 /* Public */,
      95,    1, 1188,    2, 0x02 /* Public */,
      97,    0, 1191,    2, 0x02 /* Public */,
      98,    1, 1192,    2, 0x02 /* Public */,
      99,    1, 1195,    2, 0x02 /* Public */,
     100,    1, 1198,    2, 0x02 /* Public */,
     101,    1, 1201,    2, 0x02 /* Public */,
     102,    0, 1204,    2, 0x02 /* Public */,
     103,    0, 1205,    2, 0x02 /* Public */,
     104,    1, 1206,    2, 0x02 /* Public */,
     107,    1, 1209,    2, 0x02 /* Public */,
     108,    1, 1212,    2, 0x02 /* Public */,
     109,    1, 1215,    2, 0x02 /* Public */,
     110,    2, 1218,    2, 0x02 /* Public */,
     113,    2, 1223,    2, 0x02 /* Public */,
     114,    0, 1228,    2, 0x02 /* Public */,
     115,    0, 1229,    2, 0x02 /* Public */,
     116,    0, 1230,    2, 0x02 /* Public */,
     117,    0, 1231,    2, 0x02 /* Public */,
     118,    0, 1232,    2, 0x02 /* Public */,
     119,    0, 1233,    2, 0x02 /* Public */,
     120,    0, 1234,    2, 0x02 /* Public */,
     121,    1, 1235,    2, 0x02 /* Public */,
     123,    0, 1238,    2, 0x02 /* Public */,
     124,    0, 1239,    2, 0x02 /* Public */,
     125,    0, 1240,    2, 0x02 /* Public */,
     126,    1, 1241,    2, 0x02 /* Public */,
     127,    1, 1244,    2, 0x02 /* Public */,
     128,    1, 1247,    2, 0x02 /* Public */,
     129,    1, 1250,    2, 0x02 /* Public */,
     130,    1, 1253,    2, 0x02 /* Public */,
     131,    0, 1256,    2, 0x02 /* Public */,
     132,    1, 1257,    2, 0x02 /* Public */,
     133,    1, 1260,    2, 0x02 /* Public */,
     134,    2, 1263,    2, 0x02 /* Public */,
     136,    2, 1268,    2, 0x02 /* Public */,
     137,    0, 1273,    2, 0x02 /* Public */,
     138,    1, 1274,    2, 0x02 /* Public */,
     139,    1, 1277,    2, 0x02 /* Public */,
     140,    1, 1280,    2, 0x02 /* Public */,
     140,    2, 1283,    2, 0x02 /* Public */,
     141,    3, 1288,    2, 0x02 /* Public */,
     143,    1, 1295,    2, 0x02 /* Public */,
     143,    2, 1298,    2, 0x02 /* Public */,
     144,    2, 1303,    2, 0x02 /* Public */,
     145,    3, 1308,    2, 0x02 /* Public */,
     146,    1, 1315,    2, 0x02 /* Public */,
     147,    0, 1318,    2, 0x02 /* Public */,
     148,    0, 1319,    2, 0x02 /* Public */,
     149,    1, 1320,    2, 0x02 /* Public */,
     150,    4, 1323,    2, 0x02 /* Public */,
     151,    1, 1332,    2, 0x02 /* Public */,
     152,    4, 1335,    2, 0x02 /* Public */,
     154,    1, 1344,    2, 0x02 /* Public */,
     155,    4, 1347,    2, 0x02 /* Public */,
     156,    4, 1356,    2, 0x02 /* Public */,
     158,    0, 1365,    2, 0x02 /* Public */,
     158,    1, 1366,    2, 0x02 /* Public */,
     159,    1, 1369,    2, 0x02 /* Public */,
     160,    2, 1372,    2, 0x02 /* Public */,
     161,    2, 1377,    2, 0x02 /* Public */,
     162,    5, 1382,    2, 0x02 /* Public */,
     167,    2, 1393,    2, 0x02 /* Public */,
     169,    1, 1398,    2, 0x02 /* Public */,
     169,    2, 1401,    2, 0x02 /* Public */,
     170,    1, 1406,    2, 0x02 /* Public */,
     172,    1, 1409,    2, 0x02 /* Public */,
     173,    0, 1412,    2, 0x02 /* Public */,
     174,    1, 1413,    2, 0x02 /* Public */,
     176,    2, 1416,    2, 0x02 /* Public */,
     177,    0, 1421,    2, 0x02 /* Public */,
     178,    0, 1422,    2, 0x02 /* Public */,
     179,    1, 1423,    2, 0x02 /* Public */,
     179,    3, 1426,    2, 0x02 /* Public */,
     181,    0, 1433,    2, 0x02 /* Public */,
     182,    0, 1434,    2, 0x02 /* Public */,
     183,    0, 1435,    2, 0x02 /* Public */,
     184,    0, 1436,    2, 0x02 /* Public */,
     185,    0, 1437,    2, 0x02 /* Public */,
     186,    0, 1438,    2, 0x02 /* Public */,
     187,    0, 1439,    2, 0x02 /* Public */,
     188,    0, 1440,    2, 0x02 /* Public */,
     189,    0, 1441,    2, 0x02 /* Public */,
     191,    1, 1442,    2, 0x02 /* Public */,
     192,    1, 1445,    2, 0x02 /* Public */,
     194,    0, 1448,    2, 0x02 /* Public */,
     195,    0, 1449,    2, 0x02 /* Public */,
     196,    0, 1450,    2, 0x02 /* Public */,
     197,    0, 1451,    2, 0x02 /* Public */,
     198,    0, 1452,    2, 0x02 /* Public */,
     199,    0, 1453,    2, 0x02 /* Public */,
     200,    1, 1454,    2, 0x02 /* Public */,
     201,    0, 1457,    2, 0x02 /* Public */,
     202,    0, 1458,    2, 0x02 /* Public */,
     203,    0, 1459,    2, 0x02 /* Public */,
     204,    0, 1460,    2, 0x02 /* Public */,
     205,    0, 1461,    2, 0x02 /* Public */,
     206,    0, 1462,    2, 0x02 /* Public */,
     207,    1, 1463,    2, 0x02 /* Public */,
     208,    1, 1466,    2, 0x02 /* Public */,
     209,    1, 1469,    2, 0x02 /* Public */,
     210,    0, 1472,    2, 0x02 /* Public */,
     211,    1, 1473,    2, 0x02 /* Public */,
     212,    1, 1476,    2, 0x02 /* Public */,
     213,    0, 1479,    2, 0x02 /* Public */,
     214,    0, 1480,    2, 0x02 /* Public */,
     215,    0, 1481,    2, 0x02 /* Public */,
     216,    0, 1482,    2, 0x02 /* Public */,
     217,    0, 1483,    2, 0x02 /* Public */,
     218,    0, 1484,    2, 0x02 /* Public */,
     219,    0, 1485,    2, 0x02 /* Public */,
     220,    3, 1486,    2, 0x02 /* Public */,
     221,    3, 1493,    2, 0x02 /* Public */,
     222,    2, 1500,    2, 0x02 /* Public */,
     223,    0, 1505,    2, 0x02 /* Public */,
     224,    0, 1506,    2, 0x02 /* Public */,
     225,    0, 1507,    2, 0x02 /* Public */,
     226,    1, 1508,    2, 0x02 /* Public */,
     227,    1, 1511,    2, 0x02 /* Public */,
     228,    5, 1514,    2, 0x02 /* Public */,
     230,    0, 1525,    2, 0x02 /* Public */,
     231,    1, 1526,    2, 0x02 /* Public */,
     232,    1, 1529,    2, 0x02 /* Public */,
     233,    1, 1532,    2, 0x02 /* Public */,
     234,    1, 1535,    2, 0x02 /* Public */,
     235,    1, 1538,    2, 0x02 /* Public */,
     236,    1, 1541,    2, 0x02 /* Public */,
     237,    1, 1544,    2, 0x02 /* Public */,
     238,    1, 1547,    2, 0x02 /* Public */,
     239,    0, 1550,    2, 0x02 /* Public */,
     240,    1, 1551,    2, 0x02 /* Public */,
     241,    0, 1554,    2, 0x02 /* Public */,
     242,    0, 1555,    2, 0x02 /* Public */,
     243,    0, 1556,    2, 0x02 /* Public */,
     244,    0, 1557,    2, 0x02 /* Public */,
     245,    0, 1558,    2, 0x02 /* Public */,
     246,    0, 1559,    2, 0x02 /* Public */,

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
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   20,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   20,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   20,
    QMetaType::QString,
    QMetaType::Void, QMetaType::Int,   38,
    QMetaType::Void, QMetaType::QString,   40,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   44,
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
    QMetaType::Void, QMetaType::Bool,   58,
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString, QMetaType::Int,   62,   63,   64,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   23,
    QMetaType::QString, QMetaType::Int,   23,
    QMetaType::Void, QMetaType::QString,   74,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   64,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,   79,   80,   81,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Bool,   92,
    0x80000000 | 94,
    QMetaType::Void, 0x80000000 | 94,   96,
    QMetaType::Bool,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Int, QMetaType::Int,   23,
    QMetaType::QString, QMetaType::Int,   64,
    QMetaType::QString, QMetaType::Int,   64,
    QMetaType::Int,
    QMetaType::Int,
    0x80000000 | 105, QMetaType::Int,  106,
    0x80000000 | 105, QMetaType::Int,  106,
    QMetaType::QString, QMetaType::Int,  106,
    QMetaType::Float, QMetaType::Int,  106,
    QMetaType::Void, QMetaType::QString, QMetaType::Float,  111,  112,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   79,   80,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,  122,
    0x80000000 | 105,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   23,
    QMetaType::Int, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   23,  135,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   23,  135,
    QMetaType::Int,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int,   23,
    QMetaType::Int, QMetaType::QString,   40,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   79,   80,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  142,   79,   80,
    QMetaType::Int, QMetaType::QString,   40,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   79,   80,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   79,   80,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int,   23,   79,   80,
    QMetaType::Void, QMetaType::Int,   23,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   40,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   23,  135,   79,   80,
    QMetaType::Void, QMetaType::QString,   40,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  142,  153,   79,   80,
    QMetaType::Void, QMetaType::QString,   40,
    QMetaType::Void, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::Float,   40,   79,   80,   81,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Float,  157,   79,   80,   81,
    QMetaType::Int,
    QMetaType::Int, QMetaType::Int,   23,
    QMetaType::QString, QMetaType::Int,   23,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   23,  135,
    QMetaType::Float, QMetaType::Int, QMetaType::Int,   23,  135,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   23,  163,  164,  165,  166,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   23,  168,
    QMetaType::Int, QMetaType::QString,   40,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   79,   80,
    QMetaType::Void, QMetaType::QString,  171,
    QMetaType::Void, QMetaType::QString,  171,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,  175,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   26,   29,
    QMetaType::Void,
    0x80000000 | 105,
    QMetaType::Void, QMetaType::QString,  180,
    QMetaType::Void, QMetaType::Float, QMetaType::Float, QMetaType::Float,   79,   80,   81,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    0x80000000 | 190,
    QMetaType::Void, QMetaType::Float,   79,
    QMetaType::Void, QMetaType::Float,  193,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Float,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,   40,
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
    0x80000000 | 105,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QString,   79,   80,   40,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QString,   79,   80,   40,
    QMetaType::QString, QMetaType::Int, QMetaType::Int,   79,   80,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   74,
    QMetaType::Void, QMetaType::QString,   74,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Float, QMetaType::Float, QMetaType::Float,   38,  229,   79,   80,   81,
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
    QMetaType::Void, QMetaType::Int,   64,
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
        case 22: { bool _r = _t->getuseVoice();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 23: _t->setuseVoice((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 24: { bool _r = _t->getuseBGM();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 25: _t->setuseBGM((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 26: { bool _r = _t->getserverCMD();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 27: _t->setserverCMD((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 28: { QString _r = _t->getRobotType();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 29: _t->setRobotType((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 30: _t->setDebugName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 31: { QString _r = _t->getDebugName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 32: { bool _r = _t->getDebugState();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 33: _t->setDebugState((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 34: { bool _r = _t->isConnectServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 35: { int _r = _t->isExistMap();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 36: { bool _r = _t->loadMaptoServer();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 37: { bool _r = _t->isUSBFile();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 38: { QString _r = _t->getUSBFilename();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 39: { bool _r = _t->loadMaptoUSB();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 40: { bool _r = _t->isuseServerMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 41: _t->setuseServerMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 42: _t->removeRawMap(); break;
        case 43: _t->removeEditedMap(); break;
        case 44: _t->removeServerMap(); break;
        case 45: { bool _r = _t->isloadMap();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 46: _t->setloadMap((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 47: { bool _r = _t->isExistRobotINI();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 48: _t->makeRobotINI(); break;
        case 49: { bool _r = _t->rotate_map((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 50: { bool _r = _t->getLCMConnection();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 51: { bool _r = _t->getLCMRX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 52: { bool _r = _t->getLCMTX();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 53: { bool _r = _t->getLCMProcess();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 54: { bool _r = _t->getIniRead();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 55: { int _r = _t->getUsbMapSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 56: { QString _r = _t->getUsbMapPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 57: { QString _r = _t->getUsbMapPathFull((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 58: _t->saveMapfromUsb((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 59: _t->startMapping(); break;
        case 60: _t->stopMapping(); break;
        case 61: _t->setSLAMMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 62: _t->setInitPos((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 63: { float _r = _t->getInitPoseX();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 64: { float _r = _t->getInitPoseY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 65: { float _r = _t->getInitPoseTH();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 66: _t->slam_setInit(); break;
        case 67: _t->slam_run(); break;
        case 68: _t->slam_stop(); break;
        case 69: _t->slam_autoInit(); break;
        case 70: { bool _r = _t->is_slam_running();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 71: { bool _r = _t->getMappingflag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 72: _t->setMappingflag((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 73: { QList<int> _r = _t->getMapping();
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 74: _t->pushMapData((*reinterpret_cast< QList<int>(*)>(_a[1]))); break;
        case 75: { bool _r = _t->isconnectJoy();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 76: { float _r = _t->getJoyAxis((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 77: { int _r = _t->getJoyButton((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 78: { QString _r = _t->getKeyboard((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 79: { QString _r = _t->getJoystick((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 80: { int _r = _t->getCanvasSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 81: { int _r = _t->getRedoSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 82: { QVector<int> _r = _t->getLineX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 83: { QVector<int> _r = _t->getLineY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 84: { QString _r = _t->getLineColor((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 85: { float _r = _t->getLineWidth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 86: _t->startLine((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2]))); break;
        case 87: _t->setLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 88: _t->stopLine(); break;
        case 89: _t->undo(); break;
        case 90: _t->redo(); break;
        case 91: _t->clear_all(); break;
        case 92: _t->setObjPose(); break;
        case 93: _t->setMarginObj(); break;
        case 94: _t->clearMarginObj(); break;
        case 95: _t->setMarginPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 96: { QVector<int> _r = _t->getMarginObj();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 97: { float _r = _t->getMargin();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 98: { int _r = _t->getLocationNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 99: { QString _r = _t->getLocationTypes((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 100: { float _r = _t->getLocationx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 101: { float _r = _t->getLocationy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 102: { float _r = _t->getLocationth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 103: { float _r = _t->getLidar((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 104: { int _r = _t->getObjectNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 105: { QString _r = _t->getObjectName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 106: { int _r = _t->getObjectPointSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 107: { float _r = _t->getObjectX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 108: { float _r = _t->getObjectY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 109: { int _r = _t->getTempObjectSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 110: { float _r = _t->getTempObjectX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 111: { float _r = _t->getTempObjectY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 112: { int _r = _t->getObjNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 113: { int _r = _t->getObjNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 114: { int _r = _t->getObjPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 115: { int _r = _t->getLocNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 116: { int _r = _t->getLocNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 117: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 118: _t->editObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 119: _t->removeObjectPoint((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 120: _t->removeObjectPointLast(); break;
        case 121: _t->clearObjectPoints(); break;
        case 122: _t->addObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 123: _t->editObjectRect((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4]))); break;
        case 124: _t->removeObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 125: _t->moveObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4]))); break;
        case 126: _t->removeLocation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 127: _t->addLocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 128: _t->moveLocationPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4]))); break;
        case 129: { int _r = _t->getTlineSize();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 130: { int _r = _t->getTlineSize((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 131: { QString _r = _t->getTlineName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 132: { float _r = _t->getTlineX((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 133: { float _r = _t->getTlineY((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 134: _t->addTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< int(*)>(_a[5]))); break;
        case 135: _t->removeTline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 136: { int _r = _t->getTlineNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 137: { int _r = _t->getTlineNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 138: _t->saveAnnotation((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 139: _t->saveMetaData((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 140: _t->sendMaptoServer(); break;
        case 141: _t->acceptCall((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 142: _t->setTray((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 143: _t->confirmPickup(); break;
        case 144: { QVector<int> _r = _t->getPickuptrays();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 145: _t->moveTo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 146: _t->moveTo((*reinterpret_cast< float(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 147: _t->movePause(); break;
        case 148: _t->moveResume(); break;
        case 149: _t->moveStop(); break;
        case 150: _t->moveManual(); break;
        case 151: _t->moveToCharge(); break;
        case 152: _t->moveToWait(); break;
        case 153: { QString _r = _t->getcurLoc();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 154: { QString _r = _t->getcurTable();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 155: { QVector<float> _r = _t->getcurTarget();
            if (_a[0]) *reinterpret_cast< QVector<float>*>(_a[0]) = std::move(_r); }  break;
        case 156: _t->joyMoveXY((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 157: _t->joyMoveR((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 158: { float _r = _t->getJoyXY();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 159: { float _r = _t->getJoyR();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 160: { float _r = _t->getBattery();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 161: { int _r = _t->getState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 162: { int _r = _t->getErrcode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 163: { QString _r = _t->getRobotName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 164: _t->setRobotName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 165: { float _r = _t->getRobotRadius();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 166: { float _r = _t->getRobotx();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 167: { float _r = _t->getRoboty();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 168: { float _r = _t->getRobotth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 169: { int _r = _t->getRobotState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 170: { int _r = _t->getPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 171: { float _r = _t->getPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 172: { float _r = _t->getPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 173: { float _r = _t->getPathth((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 174: { int _r = _t->getLocalPathNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 175: { float _r = _t->getLocalPathx((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 176: { float _r = _t->getLocalPathy((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 177: { int _r = _t->getuistate();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 178: { QString _r = _t->getMapname();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 179: { QString _r = _t->getMappath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 180: { int _r = _t->getMapWidth();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 181: { int _r = _t->getMapHeight();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 182: { float _r = _t->getGridWidth();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 183: { QVector<int> _r = _t->getOrigin();
            if (_a[0]) *reinterpret_cast< QVector<int>*>(_a[0]) = std::move(_r); }  break;
        case 184: _t->setGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 185: _t->editGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 186: { QString _r = _t->getGrid((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 187: _t->make_minimap(); break;
        case 188: { QString _r = _t->getPatrolFileName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 189: _t->makePatrol(); break;
        case 190: _t->loadPatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 191: _t->savePatrolFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 192: _t->addPatrol((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3])),(*reinterpret_cast< float(*)>(_a[4])),(*reinterpret_cast< float(*)>(_a[5]))); break;
        case 193: { int _r = _t->getPatrolNum();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 194: { QString _r = _t->getPatrolType((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 195: { QString _r = _t->getPatrolLocation((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 196: { float _r = _t->getPatrolX((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 197: { float _r = _t->getPatrolY((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 198: { float _r = _t->getPatrolTH((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 199: _t->removePatrol((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 200: _t->movePatrolUp((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 201: _t->movePatrolDown((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 202: { int _r = _t->getPatrolMode();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 203: _t->setPatrolMode((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 204: _t->startRecordPath(); break;
        case 205: _t->startcurPath(); break;
        case 206: _t->stopcurPath(); break;
        case 207: _t->pausecurPath(); break;
        case 208: _t->runRotateTables(); break;
        case 209: _t->stopRotateTables(); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 74:
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
        if (_id < 210)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 210;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 210)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 210;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
