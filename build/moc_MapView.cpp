/****************************************************************************
** Meta object code from reading C++ file 'MapView.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.8)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../MapView.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'MapView.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.8. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_MapView_t {
    QByteArrayData data[109];
    char stringdata0[1214];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_MapView_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_MapView_t qt_meta_stringdata_MapView = {
    {
QT_MOC_LITERAL(0, 0, 7), // "MapView"
QT_MOC_LITERAL(1, 8, 7), // "onTimer"
QT_MOC_LITERAL(2, 16, 0), // ""
QT_MOC_LITERAL(3, 17, 19), // "checkRobotCollision"
QT_MOC_LITERAL(4, 37, 22), // "checkLocationCollision"
QT_MOC_LITERAL(5, 60, 11), // "isCollision"
QT_MOC_LITERAL(6, 72, 1), // "x"
QT_MOC_LITERAL(7, 74, 1), // "y"
QT_MOC_LITERAL(8, 76, 3), // "num"
QT_MOC_LITERAL(9, 80, 9), // "setEnable"
QT_MOC_LITERAL(10, 90, 2), // "en"
QT_MOC_LITERAL(11, 93, 7), // "setName"
QT_MOC_LITERAL(12, 101, 4), // "name"
QT_MOC_LITERAL(13, 106, 7), // "setTool"
QT_MOC_LITERAL(14, 114, 7), // "getTool"
QT_MOC_LITERAL(15, 122, 7), // "setMode"
QT_MOC_LITERAL(16, 130, 7), // "getMode"
QT_MOC_LITERAL(17, 138, 12), // "setlidarView"
QT_MOC_LITERAL(18, 151, 5), // "onoff"
QT_MOC_LITERAL(19, 157, 13), // "setobjectView"
QT_MOC_LITERAL(20, 171, 16), // "setobjectBoxView"
QT_MOC_LITERAL(21, 188, 15), // "setLocationView"
QT_MOC_LITERAL(22, 204, 17), // "setRobotFollowing"
QT_MOC_LITERAL(23, 222, 15), // "getlocationView"
QT_MOC_LITERAL(24, 238, 17), // "getRobotFollowing"
QT_MOC_LITERAL(25, 256, 12), // "getlidarView"
QT_MOC_LITERAL(26, 269, 13), // "getobjectView"
QT_MOC_LITERAL(27, 283, 16), // "getobjectBoxView"
QT_MOC_LITERAL(28, 300, 6), // "setMap"
QT_MOC_LITERAL(29, 307, 15), // "pixmapContainer"
QT_MOC_LITERAL(30, 323, 9), // "updateMap"
QT_MOC_LITERAL(31, 333, 7), // "moveMap"
QT_MOC_LITERAL(32, 341, 9), // "reloadMap"
QT_MOC_LITERAL(33, 351, 10), // "setMapping"
QT_MOC_LITERAL(34, 362, 12), // "setObjecting"
QT_MOC_LITERAL(35, 375, 9), // "setRawMap"
QT_MOC_LITERAL(36, 385, 8), // "filename"
QT_MOC_LITERAL(37, 394, 12), // "setEditedMap"
QT_MOC_LITERAL(38, 407, 10), // "setCostMap"
QT_MOC_LITERAL(39, 418, 12), // "setObjectMap"
QT_MOC_LITERAL(40, 431, 13), // "setFullScreen"
QT_MOC_LITERAL(41, 445, 18), // "setLocalizationMap"
QT_MOC_LITERAL(42, 464, 11), // "setInitPose"
QT_MOC_LITERAL(43, 476, 2), // "th"
QT_MOC_LITERAL(44, 479, 13), // "clearInitPose"
QT_MOC_LITERAL(45, 493, 9), // "rotateMap"
QT_MOC_LITERAL(46, 503, 5), // "angle"
QT_MOC_LITERAL(47, 509, 11), // "rotateMapCW"
QT_MOC_LITERAL(48, 521, 12), // "rotateMapCCW"
QT_MOC_LITERAL(49, 534, 9), // "showBrush"
QT_MOC_LITERAL(50, 544, 14), // "getDrawingFlag"
QT_MOC_LITERAL(51, 559, 18), // "getDrawingUndoFlag"
QT_MOC_LITERAL(52, 578, 12), // "startDrawing"
QT_MOC_LITERAL(53, 591, 12), // "addLinePoint"
QT_MOC_LITERAL(54, 604, 10), // "endDrawing"
QT_MOC_LITERAL(55, 615, 12), // "clearDrawing"
QT_MOC_LITERAL(56, 628, 8), // "undoLine"
QT_MOC_LITERAL(57, 637, 8), // "redoLine"
QT_MOC_LITERAL(58, 646, 11), // "startSpline"
QT_MOC_LITERAL(59, 658, 9), // "addSpline"
QT_MOC_LITERAL(60, 668, 10), // "drawSpline"
QT_MOC_LITERAL(61, 679, 9), // "endSpline"
QT_MOC_LITERAL(62, 689, 4), // "save"
QT_MOC_LITERAL(63, 694, 16), // "startDrawingLine"
QT_MOC_LITERAL(64, 711, 14), // "setDrawingLine"
QT_MOC_LITERAL(65, 726, 15), // "stopDrawingLine"
QT_MOC_LITERAL(66, 742, 12), // "setLineColor"
QT_MOC_LITERAL(67, 755, 5), // "color"
QT_MOC_LITERAL(68, 761, 12), // "setLineWidth"
QT_MOC_LITERAL(69, 774, 5), // "width"
QT_MOC_LITERAL(70, 780, 12), // "getObjectNum"
QT_MOC_LITERAL(71, 793, 17), // "getObjectPointNum"
QT_MOC_LITERAL(72, 811, 9), // "addObject"
QT_MOC_LITERAL(73, 821, 14), // "addObjectPoint"
QT_MOC_LITERAL(74, 836, 9), // "setObject"
QT_MOC_LITERAL(75, 846, 13), // "getObjectFlag"
QT_MOC_LITERAL(76, 860, 15), // "editObjectStart"
QT_MOC_LITERAL(77, 876, 10), // "editObject"
QT_MOC_LITERAL(78, 887, 10), // "saveObject"
QT_MOC_LITERAL(79, 898, 4), // "type"
QT_MOC_LITERAL(80, 903, 11), // "clearObject"
QT_MOC_LITERAL(81, 915, 10), // "undoObject"
QT_MOC_LITERAL(82, 926, 12), // "selectObject"
QT_MOC_LITERAL(83, 939, 15), // "getLocationFlag"
QT_MOC_LITERAL(84, 955, 12), // "saveLocation"
QT_MOC_LITERAL(85, 968, 13), // "clearLocation"
QT_MOC_LITERAL(86, 982, 14), // "selectLocation"
QT_MOC_LITERAL(87, 997, 11), // "addLocation"
QT_MOC_LITERAL(88, 1009, 14), // "addLocationCur"
QT_MOC_LITERAL(89, 1024, 11), // "setLocation"
QT_MOC_LITERAL(90, 1036, 12), // "editLocation"
QT_MOC_LITERAL(91, 1049, 12), // "redoLocation"
QT_MOC_LITERAL(92, 1062, 14), // "getLocationNum"
QT_MOC_LITERAL(93, 1077, 9), // "initTline"
QT_MOC_LITERAL(94, 1087, 12), // "setTlineMode"
QT_MOC_LITERAL(95, 1100, 7), // "is_edit"
QT_MOC_LITERAL(96, 1108, 11), // "setMapTline"
QT_MOC_LITERAL(97, 1120, 7), // "saveMap"
QT_MOC_LITERAL(98, 1128, 9), // "saveTline"
QT_MOC_LITERAL(99, 1138, 10), // "setMapSize"
QT_MOC_LITERAL(100, 1149, 6), // "height"
QT_MOC_LITERAL(101, 1156, 6), // "zoomIn"
QT_MOC_LITERAL(102, 1163, 7), // "zoomOut"
QT_MOC_LITERAL(103, 1171, 8), // "scaledIn"
QT_MOC_LITERAL(104, 1180, 9), // "scaledOut"
QT_MOC_LITERAL(105, 1190, 4), // "move"
QT_MOC_LITERAL(106, 1195, 4), // "getX"
QT_MOC_LITERAL(107, 1200, 4), // "getY"
QT_MOC_LITERAL(108, 1205, 8) // "getScale"

    },
    "MapView\0onTimer\0\0checkRobotCollision\0"
    "checkLocationCollision\0isCollision\0x\0"
    "y\0num\0setEnable\0en\0setName\0name\0setTool\0"
    "getTool\0setMode\0getMode\0setlidarView\0"
    "onoff\0setobjectView\0setobjectBoxView\0"
    "setLocationView\0setRobotFollowing\0"
    "getlocationView\0getRobotFollowing\0"
    "getlidarView\0getobjectView\0getobjectBoxView\0"
    "setMap\0pixmapContainer\0updateMap\0"
    "moveMap\0reloadMap\0setMapping\0setObjecting\0"
    "setRawMap\0filename\0setEditedMap\0"
    "setCostMap\0setObjectMap\0setFullScreen\0"
    "setLocalizationMap\0setInitPose\0th\0"
    "clearInitPose\0rotateMap\0angle\0rotateMapCW\0"
    "rotateMapCCW\0showBrush\0getDrawingFlag\0"
    "getDrawingUndoFlag\0startDrawing\0"
    "addLinePoint\0endDrawing\0clearDrawing\0"
    "undoLine\0redoLine\0startSpline\0addSpline\0"
    "drawSpline\0endSpline\0save\0startDrawingLine\0"
    "setDrawingLine\0stopDrawingLine\0"
    "setLineColor\0color\0setLineWidth\0width\0"
    "getObjectNum\0getObjectPointNum\0addObject\0"
    "addObjectPoint\0setObject\0getObjectFlag\0"
    "editObjectStart\0editObject\0saveObject\0"
    "type\0clearObject\0undoObject\0selectObject\0"
    "getLocationFlag\0saveLocation\0clearLocation\0"
    "selectLocation\0addLocation\0addLocationCur\0"
    "setLocation\0editLocation\0redoLocation\0"
    "getLocationNum\0initTline\0setTlineMode\0"
    "is_edit\0setMapTline\0saveMap\0saveTline\0"
    "setMapSize\0height\0zoomIn\0zoomOut\0"
    "scaledIn\0scaledOut\0move\0getX\0getY\0"
    "getScale"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_MapView[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      96,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,  494,    2, 0x08 /* Private */,

 // methods: name, argc, parameters, tag, flags
       3,    0,  495,    2, 0x02 /* Public */,
       4,    0,  496,    2, 0x02 /* Public */,
       5,    2,  497,    2, 0x02 /* Public */,
       4,    1,  502,    2, 0x02 /* Public */,
       9,    1,  505,    2, 0x02 /* Public */,
      11,    1,  508,    2, 0x02 /* Public */,
      13,    1,  511,    2, 0x02 /* Public */,
      14,    0,  514,    2, 0x02 /* Public */,
      15,    1,  515,    2, 0x02 /* Public */,
      16,    0,  518,    2, 0x02 /* Public */,
      17,    1,  519,    2, 0x02 /* Public */,
      19,    1,  522,    2, 0x02 /* Public */,
      20,    1,  525,    2, 0x02 /* Public */,
      21,    1,  528,    2, 0x02 /* Public */,
      22,    1,  531,    2, 0x02 /* Public */,
      23,    0,  534,    2, 0x02 /* Public */,
      24,    0,  535,    2, 0x02 /* Public */,
      25,    0,  536,    2, 0x02 /* Public */,
      26,    0,  537,    2, 0x02 /* Public */,
      27,    0,  538,    2, 0x02 /* Public */,
      28,    1,  539,    2, 0x02 /* Public */,
      30,    0,  542,    2, 0x02 /* Public */,
      31,    0,  543,    2, 0x02 /* Public */,
      32,    0,  544,    2, 0x02 /* Public */,
      33,    0,  545,    2, 0x02 /* Public */,
      34,    0,  546,    2, 0x02 /* Public */,
      35,    1,  547,    2, 0x02 /* Public */,
      37,    1,  550,    2, 0x02 /* Public */,
      38,    0,  553,    2, 0x02 /* Public */,
      38,    1,  554,    2, 0x02 /* Public */,
      39,    1,  557,    2, 0x02 /* Public */,
      40,    0,  560,    2, 0x02 /* Public */,
      41,    1,  561,    2, 0x02 /* Public */,
      42,    3,  564,    2, 0x02 /* Public */,
      44,    0,  571,    2, 0x02 /* Public */,
      45,    1,  572,    2, 0x02 /* Public */,
      47,    0,  575,    2, 0x02 /* Public */,
      48,    0,  576,    2, 0x02 /* Public */,
      49,    1,  577,    2, 0x02 /* Public */,
      50,    0,  580,    2, 0x02 /* Public */,
      51,    0,  581,    2, 0x02 /* Public */,
      52,    2,  582,    2, 0x02 /* Public */,
      53,    2,  587,    2, 0x02 /* Public */,
      54,    2,  592,    2, 0x02 /* Public */,
      55,    0,  597,    2, 0x02 /* Public */,
      56,    0,  598,    2, 0x02 /* Public */,
      57,    0,  599,    2, 0x02 /* Public */,
      58,    2,  600,    2, 0x02 /* Public */,
      59,    2,  605,    2, 0x02 /* Public */,
      60,    0,  610,    2, 0x02 /* Public */,
      61,    1,  611,    2, 0x02 /* Public */,
      63,    2,  614,    2, 0x02 /* Public */,
      64,    2,  619,    2, 0x02 /* Public */,
      65,    2,  624,    2, 0x02 /* Public */,
      66,    1,  629,    2, 0x02 /* Public */,
      68,    1,  632,    2, 0x02 /* Public */,
      70,    2,  635,    2, 0x02 /* Public */,
      71,    2,  640,    2, 0x02 /* Public */,
      72,    2,  645,    2, 0x02 /* Public */,
      73,    2,  650,    2, 0x02 /* Public */,
      74,    2,  655,    2, 0x02 /* Public */,
      75,    0,  660,    2, 0x02 /* Public */,
      76,    2,  661,    2, 0x02 /* Public */,
      77,    2,  666,    2, 0x02 /* Public */,
      78,    1,  671,    2, 0x02 /* Public */,
      80,    0,  674,    2, 0x02 /* Public */,
      81,    0,  675,    2, 0x02 /* Public */,
      82,    1,  676,    2, 0x02 /* Public */,
      83,    0,  679,    2, 0x02 /* Public */,
      84,    2,  680,    2, 0x02 /* Public */,
      85,    0,  685,    2, 0x02 /* Public */,
      86,    2,  686,    2, 0x02 /* Public */,
      86,    1,  691,    2, 0x22 /* Public | MethodCloned */,
      87,    3,  694,    2, 0x02 /* Public */,
      88,    3,  701,    2, 0x02 /* Public */,
      89,    3,  708,    2, 0x02 /* Public */,
      90,    3,  715,    2, 0x02 /* Public */,
      90,    0,  722,    2, 0x02 /* Public */,
      91,    0,  723,    2, 0x02 /* Public */,
      92,    2,  724,    2, 0x02 /* Public */,
      93,    1,  729,    2, 0x02 /* Public */,
      94,    1,  732,    2, 0x02 /* Public */,
      96,    0,  735,    2, 0x02 /* Public */,
      92,    1,  736,    2, 0x02 /* Public */,
      97,    0,  739,    2, 0x02 /* Public */,
      98,    0,  740,    2, 0x02 /* Public */,
      99,    2,  741,    2, 0x02 /* Public */,
     101,    2,  746,    2, 0x02 /* Public */,
     102,    2,  751,    2, 0x02 /* Public */,
     103,    2,  756,    2, 0x02 /* Public */,
     104,    2,  761,    2, 0x02 /* Public */,
     105,    2,  766,    2, 0x02 /* Public */,
     106,    0,  771,    2, 0x02 /* Public */,
     107,    0,  772,    2, 0x02 /* Public */,
     108,    0,  773,    2, 0x02 /* Public */,

 // slots: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Bool, QMetaType::Int,    8,
    QMetaType::Void, QMetaType::Bool,   10,
    QMetaType::Void, QMetaType::QString,   12,
    QMetaType::Void, QMetaType::QString,   12,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,   12,
    QMetaType::QString,
    QMetaType::Void, QMetaType::Bool,   18,
    QMetaType::Void, QMetaType::Bool,   18,
    QMetaType::Void, QMetaType::Bool,   18,
    QMetaType::Void, QMetaType::Bool,   18,
    QMetaType::Void, QMetaType::Bool,   18,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::QObjectStar,   29,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   36,
    QMetaType::Void, QMetaType::QString,   36,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   36,
    QMetaType::Void, QMetaType::QString,   36,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   36,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,    6,    7,   43,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   46,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,   18,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,   62,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int,   67,
    QMetaType::Void, QMetaType::Int,   69,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::QString,   79,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,    8,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   79,   12,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::QString,    8,   79,
    QMetaType::Void, QMetaType::Int,    8,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,    6,    7,   43,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,    6,    7,   43,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,    6,    7,   43,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,    6,    7,   43,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::QString,   36,
    QMetaType::Void, QMetaType::Bool,   95,
    QMetaType::Void,
    QMetaType::Int, QMetaType::QString,   79,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   69,  100,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Float,

       0        // eod
};

void MapView::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<MapView *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->onTimer(); break;
        case 1: { bool _r = _t->checkRobotCollision();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 2: { bool _r = _t->checkLocationCollision();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: { bool _r = _t->isCollision((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->checkLocationCollision((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 5: _t->setEnable((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 6: _t->setName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 7: _t->setTool((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 8: { QString _r = _t->getTool();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 9: _t->setMode((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 10: { QString _r = _t->getMode();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 11: _t->setlidarView((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 12: _t->setobjectView((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 13: _t->setobjectBoxView((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 14: _t->setLocationView((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 15: _t->setRobotFollowing((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 16: { bool _r = _t->getlocationView();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 17: { bool _r = _t->getRobotFollowing();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 18: { bool _r = _t->getlidarView();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 19: { bool _r = _t->getobjectView();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 20: { bool _r = _t->getobjectBoxView();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 21: _t->setMap((*reinterpret_cast< QObject*(*)>(_a[1]))); break;
        case 22: _t->updateMap(); break;
        case 23: _t->moveMap(); break;
        case 24: _t->reloadMap(); break;
        case 25: _t->setMapping(); break;
        case 26: _t->setObjecting(); break;
        case 27: _t->setRawMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 28: _t->setEditedMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 29: _t->setCostMap(); break;
        case 30: _t->setCostMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 31: _t->setObjectMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 32: _t->setFullScreen(); break;
        case 33: _t->setLocalizationMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 34: _t->setInitPose((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 35: _t->clearInitPose(); break;
        case 36: _t->rotateMap((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 37: _t->rotateMapCW(); break;
        case 38: _t->rotateMapCCW(); break;
        case 39: _t->showBrush((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 40: { bool _r = _t->getDrawingFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 41: { bool _r = _t->getDrawingUndoFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 42: _t->startDrawing((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 43: _t->addLinePoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 44: _t->endDrawing((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 45: _t->clearDrawing(); break;
        case 46: _t->undoLine(); break;
        case 47: _t->redoLine(); break;
        case 48: _t->startSpline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 49: _t->addSpline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 50: _t->drawSpline(); break;
        case 51: _t->endSpline((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 52: _t->startDrawingLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 53: _t->setDrawingLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 54: _t->stopDrawingLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 55: _t->setLineColor((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 56: _t->setLineWidth((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 57: { int _r = _t->getObjectNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 58: { int _r = _t->getObjectPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 59: _t->addObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 60: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 61: _t->setObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 62: { bool _r = _t->getObjectFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 63: _t->editObjectStart((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 64: _t->editObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 65: _t->saveObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 66: _t->clearObject(); break;
        case 67: _t->undoObject(); break;
        case 68: _t->selectObject((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 69: { bool _r = _t->getLocationFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 70: _t->saveLocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 71: _t->clearLocation(); break;
        case 72: _t->selectLocation((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 73: _t->selectLocation((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 74: _t->addLocation((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 75: _t->addLocationCur((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 76: _t->setLocation((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 77: _t->editLocation((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 78: _t->editLocation(); break;
        case 79: _t->redoLocation(); break;
        case 80: { int _r = _t->getLocationNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 81: _t->initTline((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 82: _t->setTlineMode((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 83: _t->setMapTline(); break;
        case 84: { int _r = _t->getLocationNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 85: _t->saveMap(); break;
        case 86: _t->saveTline(); break;
        case 87: _t->setMapSize((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 88: _t->zoomIn((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 89: _t->zoomOut((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 90: _t->scaledIn((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 91: _t->scaledOut((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 92: _t->move((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 93: { int _r = _t->getX();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 94: { int _r = _t->getY();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 95: { float _r = _t->getScale();
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject MapView::staticMetaObject = { {
    &QQuickPaintedItem::staticMetaObject,
    qt_meta_stringdata_MapView.data,
    qt_meta_data_MapView,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *MapView::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MapView::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_MapView.stringdata0))
        return static_cast<void*>(this);
    return QQuickPaintedItem::qt_metacast(_clname);
}

int MapView::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QQuickPaintedItem::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 96)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 96;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 96)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 96;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
