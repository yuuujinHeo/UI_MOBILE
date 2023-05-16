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
    QByteArrayData data[108];
    char stringdata0[1195];
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
QT_MOC_LITERAL(41, 445, 11), // "setInitPose"
QT_MOC_LITERAL(42, 457, 2), // "th"
QT_MOC_LITERAL(43, 460, 13), // "clearInitPose"
QT_MOC_LITERAL(44, 474, 9), // "rotateMap"
QT_MOC_LITERAL(45, 484, 5), // "angle"
QT_MOC_LITERAL(46, 490, 11), // "rotateMapCW"
QT_MOC_LITERAL(47, 502, 12), // "rotateMapCCW"
QT_MOC_LITERAL(48, 515, 9), // "showBrush"
QT_MOC_LITERAL(49, 525, 14), // "getDrawingFlag"
QT_MOC_LITERAL(50, 540, 18), // "getDrawingUndoFlag"
QT_MOC_LITERAL(51, 559, 12), // "startDrawing"
QT_MOC_LITERAL(52, 572, 12), // "addLinePoint"
QT_MOC_LITERAL(53, 585, 10), // "endDrawing"
QT_MOC_LITERAL(54, 596, 12), // "clearDrawing"
QT_MOC_LITERAL(55, 609, 8), // "undoLine"
QT_MOC_LITERAL(56, 618, 8), // "redoLine"
QT_MOC_LITERAL(57, 627, 11), // "startSpline"
QT_MOC_LITERAL(58, 639, 9), // "addSpline"
QT_MOC_LITERAL(59, 649, 10), // "drawSpline"
QT_MOC_LITERAL(60, 660, 9), // "endSpline"
QT_MOC_LITERAL(61, 670, 4), // "save"
QT_MOC_LITERAL(62, 675, 16), // "startDrawingLine"
QT_MOC_LITERAL(63, 692, 14), // "setDrawingLine"
QT_MOC_LITERAL(64, 707, 15), // "stopDrawingLine"
QT_MOC_LITERAL(65, 723, 12), // "setLineColor"
QT_MOC_LITERAL(66, 736, 5), // "color"
QT_MOC_LITERAL(67, 742, 12), // "setLineWidth"
QT_MOC_LITERAL(68, 755, 5), // "width"
QT_MOC_LITERAL(69, 761, 12), // "getObjectNum"
QT_MOC_LITERAL(70, 774, 17), // "getObjectPointNum"
QT_MOC_LITERAL(71, 792, 9), // "addObject"
QT_MOC_LITERAL(72, 802, 14), // "addObjectPoint"
QT_MOC_LITERAL(73, 817, 9), // "setObject"
QT_MOC_LITERAL(74, 827, 13), // "getObjectFlag"
QT_MOC_LITERAL(75, 841, 15), // "editObjectStart"
QT_MOC_LITERAL(76, 857, 10), // "editObject"
QT_MOC_LITERAL(77, 868, 10), // "saveObject"
QT_MOC_LITERAL(78, 879, 4), // "type"
QT_MOC_LITERAL(79, 884, 11), // "clearObject"
QT_MOC_LITERAL(80, 896, 10), // "undoObject"
QT_MOC_LITERAL(81, 907, 12), // "selectObject"
QT_MOC_LITERAL(82, 920, 15), // "getLocationFlag"
QT_MOC_LITERAL(83, 936, 12), // "saveLocation"
QT_MOC_LITERAL(84, 949, 13), // "clearLocation"
QT_MOC_LITERAL(85, 963, 14), // "selectLocation"
QT_MOC_LITERAL(86, 978, 11), // "addLocation"
QT_MOC_LITERAL(87, 990, 14), // "addLocationCur"
QT_MOC_LITERAL(88, 1005, 11), // "setLocation"
QT_MOC_LITERAL(89, 1017, 12), // "editLocation"
QT_MOC_LITERAL(90, 1030, 12), // "redoLocation"
QT_MOC_LITERAL(91, 1043, 14), // "getLocationNum"
QT_MOC_LITERAL(92, 1058, 9), // "initTline"
QT_MOC_LITERAL(93, 1068, 12), // "setTlineMode"
QT_MOC_LITERAL(94, 1081, 7), // "is_edit"
QT_MOC_LITERAL(95, 1089, 11), // "setMapTline"
QT_MOC_LITERAL(96, 1101, 7), // "saveMap"
QT_MOC_LITERAL(97, 1109, 9), // "saveTline"
QT_MOC_LITERAL(98, 1119, 10), // "setMapSize"
QT_MOC_LITERAL(99, 1130, 6), // "height"
QT_MOC_LITERAL(100, 1137, 6), // "zoomIn"
QT_MOC_LITERAL(101, 1144, 7), // "zoomOut"
QT_MOC_LITERAL(102, 1152, 8), // "scaledIn"
QT_MOC_LITERAL(103, 1161, 9), // "scaledOut"
QT_MOC_LITERAL(104, 1171, 4), // "move"
QT_MOC_LITERAL(105, 1176, 4), // "getX"
QT_MOC_LITERAL(106, 1181, 4), // "getY"
QT_MOC_LITERAL(107, 1186, 8) // "getScale"

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
    "setInitPose\0th\0clearInitPose\0rotateMap\0"
    "angle\0rotateMapCW\0rotateMapCCW\0showBrush\0"
    "getDrawingFlag\0getDrawingUndoFlag\0"
    "startDrawing\0addLinePoint\0endDrawing\0"
    "clearDrawing\0undoLine\0redoLine\0"
    "startSpline\0addSpline\0drawSpline\0"
    "endSpline\0save\0startDrawingLine\0"
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
      95,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,  489,    2, 0x08 /* Private */,

 // methods: name, argc, parameters, tag, flags
       3,    0,  490,    2, 0x02 /* Public */,
       4,    0,  491,    2, 0x02 /* Public */,
       5,    2,  492,    2, 0x02 /* Public */,
       4,    1,  497,    2, 0x02 /* Public */,
       9,    1,  500,    2, 0x02 /* Public */,
      11,    1,  503,    2, 0x02 /* Public */,
      13,    1,  506,    2, 0x02 /* Public */,
      14,    0,  509,    2, 0x02 /* Public */,
      15,    1,  510,    2, 0x02 /* Public */,
      16,    0,  513,    2, 0x02 /* Public */,
      17,    1,  514,    2, 0x02 /* Public */,
      19,    1,  517,    2, 0x02 /* Public */,
      20,    1,  520,    2, 0x02 /* Public */,
      21,    1,  523,    2, 0x02 /* Public */,
      22,    1,  526,    2, 0x02 /* Public */,
      23,    0,  529,    2, 0x02 /* Public */,
      24,    0,  530,    2, 0x02 /* Public */,
      25,    0,  531,    2, 0x02 /* Public */,
      26,    0,  532,    2, 0x02 /* Public */,
      27,    0,  533,    2, 0x02 /* Public */,
      28,    1,  534,    2, 0x02 /* Public */,
      30,    0,  537,    2, 0x02 /* Public */,
      31,    0,  538,    2, 0x02 /* Public */,
      32,    0,  539,    2, 0x02 /* Public */,
      33,    0,  540,    2, 0x02 /* Public */,
      34,    0,  541,    2, 0x02 /* Public */,
      35,    1,  542,    2, 0x02 /* Public */,
      37,    1,  545,    2, 0x02 /* Public */,
      38,    0,  548,    2, 0x02 /* Public */,
      38,    1,  549,    2, 0x02 /* Public */,
      39,    1,  552,    2, 0x02 /* Public */,
      40,    0,  555,    2, 0x02 /* Public */,
      41,    3,  556,    2, 0x02 /* Public */,
      43,    0,  563,    2, 0x02 /* Public */,
      44,    1,  564,    2, 0x02 /* Public */,
      46,    0,  567,    2, 0x02 /* Public */,
      47,    0,  568,    2, 0x02 /* Public */,
      48,    1,  569,    2, 0x02 /* Public */,
      49,    0,  572,    2, 0x02 /* Public */,
      50,    0,  573,    2, 0x02 /* Public */,
      51,    2,  574,    2, 0x02 /* Public */,
      52,    2,  579,    2, 0x02 /* Public */,
      53,    2,  584,    2, 0x02 /* Public */,
      54,    0,  589,    2, 0x02 /* Public */,
      55,    0,  590,    2, 0x02 /* Public */,
      56,    0,  591,    2, 0x02 /* Public */,
      57,    2,  592,    2, 0x02 /* Public */,
      58,    2,  597,    2, 0x02 /* Public */,
      59,    0,  602,    2, 0x02 /* Public */,
      60,    1,  603,    2, 0x02 /* Public */,
      62,    2,  606,    2, 0x02 /* Public */,
      63,    2,  611,    2, 0x02 /* Public */,
      64,    2,  616,    2, 0x02 /* Public */,
      65,    1,  621,    2, 0x02 /* Public */,
      67,    1,  624,    2, 0x02 /* Public */,
      69,    2,  627,    2, 0x02 /* Public */,
      70,    2,  632,    2, 0x02 /* Public */,
      71,    2,  637,    2, 0x02 /* Public */,
      72,    2,  642,    2, 0x02 /* Public */,
      73,    2,  647,    2, 0x02 /* Public */,
      74,    0,  652,    2, 0x02 /* Public */,
      75,    2,  653,    2, 0x02 /* Public */,
      76,    2,  658,    2, 0x02 /* Public */,
      77,    1,  663,    2, 0x02 /* Public */,
      79,    0,  666,    2, 0x02 /* Public */,
      80,    0,  667,    2, 0x02 /* Public */,
      81,    1,  668,    2, 0x02 /* Public */,
      82,    0,  671,    2, 0x02 /* Public */,
      83,    2,  672,    2, 0x02 /* Public */,
      84,    0,  677,    2, 0x02 /* Public */,
      85,    2,  678,    2, 0x02 /* Public */,
      85,    1,  683,    2, 0x22 /* Public | MethodCloned */,
      86,    3,  686,    2, 0x02 /* Public */,
      87,    3,  693,    2, 0x02 /* Public */,
      88,    3,  700,    2, 0x02 /* Public */,
      89,    3,  707,    2, 0x02 /* Public */,
      89,    0,  714,    2, 0x02 /* Public */,
      90,    0,  715,    2, 0x02 /* Public */,
      91,    2,  716,    2, 0x02 /* Public */,
      92,    1,  721,    2, 0x02 /* Public */,
      93,    1,  724,    2, 0x02 /* Public */,
      95,    0,  727,    2, 0x02 /* Public */,
      91,    1,  728,    2, 0x02 /* Public */,
      96,    0,  731,    2, 0x02 /* Public */,
      97,    0,  732,    2, 0x02 /* Public */,
      98,    2,  733,    2, 0x02 /* Public */,
     100,    2,  738,    2, 0x02 /* Public */,
     101,    2,  743,    2, 0x02 /* Public */,
     102,    2,  748,    2, 0x02 /* Public */,
     103,    2,  753,    2, 0x02 /* Public */,
     104,    2,  758,    2, 0x02 /* Public */,
     105,    0,  763,    2, 0x02 /* Public */,
     106,    0,  764,    2, 0x02 /* Public */,
     107,    0,  765,    2, 0x02 /* Public */,

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
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,    6,    7,   42,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   45,
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
    QMetaType::Void, QMetaType::Bool,   61,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int,   66,
    QMetaType::Void, QMetaType::Int,   68,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::QString,   78,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,    8,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   78,   12,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::QString,    8,   78,
    QMetaType::Void, QMetaType::Int,    8,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,    6,    7,   42,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,    6,    7,   42,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,    6,    7,   42,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,    6,    7,   42,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,    6,    7,
    QMetaType::Void, QMetaType::QString,   36,
    QMetaType::Void, QMetaType::Bool,   94,
    QMetaType::Void,
    QMetaType::Int, QMetaType::QString,   78,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   68,   99,
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
        case 33: _t->setInitPose((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 34: _t->clearInitPose(); break;
        case 35: _t->rotateMap((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 36: _t->rotateMapCW(); break;
        case 37: _t->rotateMapCCW(); break;
        case 38: _t->showBrush((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 39: { bool _r = _t->getDrawingFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 40: { bool _r = _t->getDrawingUndoFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 41: _t->startDrawing((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 42: _t->addLinePoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 43: _t->endDrawing((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 44: _t->clearDrawing(); break;
        case 45: _t->undoLine(); break;
        case 46: _t->redoLine(); break;
        case 47: _t->startSpline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 48: _t->addSpline((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 49: _t->drawSpline(); break;
        case 50: _t->endSpline((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 51: _t->startDrawingLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 52: _t->setDrawingLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 53: _t->stopDrawingLine((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 54: _t->setLineColor((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 55: _t->setLineWidth((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 56: { int _r = _t->getObjectNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 57: { int _r = _t->getObjectPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 58: _t->addObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 59: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 60: _t->setObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 61: { bool _r = _t->getObjectFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 62: _t->editObjectStart((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 63: _t->editObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 64: _t->saveObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 65: _t->clearObject(); break;
        case 66: _t->undoObject(); break;
        case 67: _t->selectObject((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 68: { bool _r = _t->getLocationFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 69: _t->saveLocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 70: _t->clearLocation(); break;
        case 71: _t->selectLocation((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 72: _t->selectLocation((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 73: _t->addLocation((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 74: _t->addLocationCur((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 75: _t->setLocation((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 76: _t->editLocation((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 77: _t->editLocation(); break;
        case 78: _t->redoLocation(); break;
        case 79: { int _r = _t->getLocationNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 80: _t->initTline((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 81: _t->setTlineMode((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 82: _t->setMapTline(); break;
        case 83: { int _r = _t->getLocationNum((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 84: _t->saveMap(); break;
        case 85: _t->saveTline(); break;
        case 86: _t->setMapSize((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 87: _t->zoomIn((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 88: _t->zoomOut((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 89: _t->scaledIn((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 90: _t->scaledOut((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 91: _t->move((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 92: { int _r = _t->getX();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 93: { int _r = _t->getY();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 94: { float _r = _t->getScale();
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
        if (_id < 95)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 95;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 95)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 95;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
