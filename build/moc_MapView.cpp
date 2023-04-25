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
    QByteArrayData data[96];
    char stringdata0[1028];
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
QT_MOC_LITERAL(3, 17, 9), // "setEnable"
QT_MOC_LITERAL(4, 27, 2), // "en"
QT_MOC_LITERAL(5, 30, 7), // "setName"
QT_MOC_LITERAL(6, 38, 4), // "name"
QT_MOC_LITERAL(7, 43, 7), // "setTool"
QT_MOC_LITERAL(8, 51, 7), // "getTool"
QT_MOC_LITERAL(9, 59, 7), // "setMode"
QT_MOC_LITERAL(10, 67, 7), // "getMode"
QT_MOC_LITERAL(11, 75, 12), // "setlidarView"
QT_MOC_LITERAL(12, 88, 5), // "onoff"
QT_MOC_LITERAL(13, 94, 13), // "setobjectView"
QT_MOC_LITERAL(14, 108, 16), // "setobjectBoxView"
QT_MOC_LITERAL(15, 125, 15), // "setLocationView"
QT_MOC_LITERAL(16, 141, 17), // "setRobotFollowing"
QT_MOC_LITERAL(17, 159, 17), // "getRobotFollowing"
QT_MOC_LITERAL(18, 177, 12), // "getlidarView"
QT_MOC_LITERAL(19, 190, 13), // "getobjectView"
QT_MOC_LITERAL(20, 204, 16), // "getobjectBoxView"
QT_MOC_LITERAL(21, 221, 6), // "setMap"
QT_MOC_LITERAL(22, 228, 15), // "pixmapContainer"
QT_MOC_LITERAL(23, 244, 9), // "updateMap"
QT_MOC_LITERAL(24, 254, 7), // "moveMap"
QT_MOC_LITERAL(25, 262, 9), // "reloadMap"
QT_MOC_LITERAL(26, 272, 10), // "setMapping"
QT_MOC_LITERAL(27, 283, 12), // "setObjecting"
QT_MOC_LITERAL(28, 296, 9), // "setRawMap"
QT_MOC_LITERAL(29, 306, 8), // "filename"
QT_MOC_LITERAL(30, 315, 12), // "setEditedMap"
QT_MOC_LITERAL(31, 328, 10), // "setCostMap"
QT_MOC_LITERAL(32, 339, 12), // "setObjectMap"
QT_MOC_LITERAL(33, 352, 13), // "setFullScreen"
QT_MOC_LITERAL(34, 366, 11), // "setInitPose"
QT_MOC_LITERAL(35, 378, 1), // "x"
QT_MOC_LITERAL(36, 380, 1), // "y"
QT_MOC_LITERAL(37, 382, 2), // "th"
QT_MOC_LITERAL(38, 385, 13), // "clearInitPose"
QT_MOC_LITERAL(39, 399, 9), // "rotateMap"
QT_MOC_LITERAL(40, 409, 5), // "angle"
QT_MOC_LITERAL(41, 415, 11), // "rotateMapCW"
QT_MOC_LITERAL(42, 427, 12), // "rotateMapCCW"
QT_MOC_LITERAL(43, 440, 9), // "showBrush"
QT_MOC_LITERAL(44, 450, 14), // "getDrawingFlag"
QT_MOC_LITERAL(45, 465, 18), // "getDrawingUndoFlag"
QT_MOC_LITERAL(46, 484, 12), // "startDrawing"
QT_MOC_LITERAL(47, 497, 12), // "addLinePoint"
QT_MOC_LITERAL(48, 510, 10), // "endDrawing"
QT_MOC_LITERAL(49, 521, 12), // "clearDrawing"
QT_MOC_LITERAL(50, 534, 8), // "undoLine"
QT_MOC_LITERAL(51, 543, 8), // "redoLine"
QT_MOC_LITERAL(52, 552, 12), // "setLineColor"
QT_MOC_LITERAL(53, 565, 5), // "color"
QT_MOC_LITERAL(54, 571, 12), // "setLineWidth"
QT_MOC_LITERAL(55, 584, 5), // "width"
QT_MOC_LITERAL(56, 590, 12), // "getObjectNum"
QT_MOC_LITERAL(57, 603, 17), // "getObjectPointNum"
QT_MOC_LITERAL(58, 621, 9), // "addObject"
QT_MOC_LITERAL(59, 631, 14), // "addObjectPoint"
QT_MOC_LITERAL(60, 646, 9), // "setObject"
QT_MOC_LITERAL(61, 656, 13), // "getObjectFlag"
QT_MOC_LITERAL(62, 670, 15), // "editObjectStart"
QT_MOC_LITERAL(63, 686, 10), // "editObject"
QT_MOC_LITERAL(64, 697, 10), // "saveObject"
QT_MOC_LITERAL(65, 708, 4), // "type"
QT_MOC_LITERAL(66, 713, 11), // "clearObject"
QT_MOC_LITERAL(67, 725, 10), // "undoObject"
QT_MOC_LITERAL(68, 736, 12), // "selectObject"
QT_MOC_LITERAL(69, 749, 3), // "num"
QT_MOC_LITERAL(70, 753, 15), // "getLocationFlag"
QT_MOC_LITERAL(71, 769, 12), // "saveLocation"
QT_MOC_LITERAL(72, 782, 13), // "clearLocation"
QT_MOC_LITERAL(73, 796, 14), // "selectLocation"
QT_MOC_LITERAL(74, 811, 11), // "addLocation"
QT_MOC_LITERAL(75, 823, 14), // "addLocationCur"
QT_MOC_LITERAL(76, 838, 11), // "setLocation"
QT_MOC_LITERAL(77, 850, 12), // "editLocation"
QT_MOC_LITERAL(78, 863, 12), // "redoLocation"
QT_MOC_LITERAL(79, 876, 14), // "getLocationNum"
QT_MOC_LITERAL(80, 891, 9), // "initTline"
QT_MOC_LITERAL(81, 901, 12), // "setTlineMode"
QT_MOC_LITERAL(82, 914, 7), // "is_edit"
QT_MOC_LITERAL(83, 922, 11), // "setMapTline"
QT_MOC_LITERAL(84, 934, 7), // "saveMap"
QT_MOC_LITERAL(85, 942, 9), // "saveTline"
QT_MOC_LITERAL(86, 952, 10), // "setMapSize"
QT_MOC_LITERAL(87, 963, 6), // "height"
QT_MOC_LITERAL(88, 970, 6), // "zoomIn"
QT_MOC_LITERAL(89, 977, 7), // "zoomOut"
QT_MOC_LITERAL(90, 985, 8), // "scaledIn"
QT_MOC_LITERAL(91, 994, 9), // "scaledOut"
QT_MOC_LITERAL(92, 1004, 4), // "move"
QT_MOC_LITERAL(93, 1009, 4), // "getX"
QT_MOC_LITERAL(94, 1014, 4), // "getY"
QT_MOC_LITERAL(95, 1019, 8) // "getScale"

    },
    "MapView\0onTimer\0\0setEnable\0en\0setName\0"
    "name\0setTool\0getTool\0setMode\0getMode\0"
    "setlidarView\0onoff\0setobjectView\0"
    "setobjectBoxView\0setLocationView\0"
    "setRobotFollowing\0getRobotFollowing\0"
    "getlidarView\0getobjectView\0getobjectBoxView\0"
    "setMap\0pixmapContainer\0updateMap\0"
    "moveMap\0reloadMap\0setMapping\0setObjecting\0"
    "setRawMap\0filename\0setEditedMap\0"
    "setCostMap\0setObjectMap\0setFullScreen\0"
    "setInitPose\0x\0y\0th\0clearInitPose\0"
    "rotateMap\0angle\0rotateMapCW\0rotateMapCCW\0"
    "showBrush\0getDrawingFlag\0getDrawingUndoFlag\0"
    "startDrawing\0addLinePoint\0endDrawing\0"
    "clearDrawing\0undoLine\0redoLine\0"
    "setLineColor\0color\0setLineWidth\0width\0"
    "getObjectNum\0getObjectPointNum\0addObject\0"
    "addObjectPoint\0setObject\0getObjectFlag\0"
    "editObjectStart\0editObject\0saveObject\0"
    "type\0clearObject\0undoObject\0selectObject\0"
    "num\0getLocationFlag\0saveLocation\0"
    "clearLocation\0selectLocation\0addLocation\0"
    "addLocationCur\0setLocation\0editLocation\0"
    "redoLocation\0getLocationNum\0initTline\0"
    "setTlineMode\0is_edit\0setMapTline\0"
    "saveMap\0saveTline\0setMapSize\0height\0"
    "zoomIn\0zoomOut\0scaledIn\0scaledOut\0"
    "move\0getX\0getY\0getScale"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_MapView[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      80,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,  414,    2, 0x08 /* Private */,

 // methods: name, argc, parameters, tag, flags
       3,    1,  415,    2, 0x02 /* Public */,
       5,    1,  418,    2, 0x02 /* Public */,
       7,    1,  421,    2, 0x02 /* Public */,
       8,    0,  424,    2, 0x02 /* Public */,
       9,    1,  425,    2, 0x02 /* Public */,
      10,    0,  428,    2, 0x02 /* Public */,
      11,    1,  429,    2, 0x02 /* Public */,
      13,    1,  432,    2, 0x02 /* Public */,
      14,    1,  435,    2, 0x02 /* Public */,
      15,    1,  438,    2, 0x02 /* Public */,
      16,    1,  441,    2, 0x02 /* Public */,
      17,    0,  444,    2, 0x02 /* Public */,
      18,    0,  445,    2, 0x02 /* Public */,
      19,    0,  446,    2, 0x02 /* Public */,
      20,    0,  447,    2, 0x02 /* Public */,
      21,    1,  448,    2, 0x02 /* Public */,
      23,    0,  451,    2, 0x02 /* Public */,
      24,    0,  452,    2, 0x02 /* Public */,
      25,    0,  453,    2, 0x02 /* Public */,
      26,    0,  454,    2, 0x02 /* Public */,
      27,    0,  455,    2, 0x02 /* Public */,
      28,    1,  456,    2, 0x02 /* Public */,
      30,    1,  459,    2, 0x02 /* Public */,
      31,    1,  462,    2, 0x02 /* Public */,
      32,    1,  465,    2, 0x02 /* Public */,
      33,    0,  468,    2, 0x02 /* Public */,
      34,    3,  469,    2, 0x02 /* Public */,
      38,    0,  476,    2, 0x02 /* Public */,
      39,    1,  477,    2, 0x02 /* Public */,
      41,    0,  480,    2, 0x02 /* Public */,
      42,    0,  481,    2, 0x02 /* Public */,
      43,    1,  482,    2, 0x02 /* Public */,
      44,    0,  485,    2, 0x02 /* Public */,
      45,    0,  486,    2, 0x02 /* Public */,
      46,    2,  487,    2, 0x02 /* Public */,
      47,    2,  492,    2, 0x02 /* Public */,
      48,    2,  497,    2, 0x02 /* Public */,
      49,    0,  502,    2, 0x02 /* Public */,
      50,    0,  503,    2, 0x02 /* Public */,
      51,    0,  504,    2, 0x02 /* Public */,
      52,    1,  505,    2, 0x02 /* Public */,
      54,    1,  508,    2, 0x02 /* Public */,
      56,    2,  511,    2, 0x02 /* Public */,
      57,    2,  516,    2, 0x02 /* Public */,
      58,    2,  521,    2, 0x02 /* Public */,
      59,    2,  526,    2, 0x02 /* Public */,
      60,    2,  531,    2, 0x02 /* Public */,
      61,    0,  536,    2, 0x02 /* Public */,
      62,    2,  537,    2, 0x02 /* Public */,
      63,    2,  542,    2, 0x02 /* Public */,
      64,    1,  547,    2, 0x02 /* Public */,
      66,    0,  550,    2, 0x02 /* Public */,
      67,    0,  551,    2, 0x02 /* Public */,
      68,    1,  552,    2, 0x02 /* Public */,
      70,    0,  555,    2, 0x02 /* Public */,
      71,    2,  556,    2, 0x02 /* Public */,
      72,    0,  561,    2, 0x02 /* Public */,
      73,    1,  562,    2, 0x02 /* Public */,
      74,    3,  565,    2, 0x02 /* Public */,
      75,    3,  572,    2, 0x02 /* Public */,
      76,    3,  579,    2, 0x02 /* Public */,
      77,    3,  586,    2, 0x02 /* Public */,
      77,    0,  593,    2, 0x02 /* Public */,
      78,    0,  594,    2, 0x02 /* Public */,
      79,    2,  595,    2, 0x02 /* Public */,
      80,    1,  600,    2, 0x02 /* Public */,
      81,    1,  603,    2, 0x02 /* Public */,
      83,    0,  606,    2, 0x02 /* Public */,
      84,    0,  607,    2, 0x02 /* Public */,
      85,    0,  608,    2, 0x02 /* Public */,
      86,    2,  609,    2, 0x02 /* Public */,
      88,    2,  614,    2, 0x02 /* Public */,
      89,    2,  619,    2, 0x02 /* Public */,
      90,    2,  624,    2, 0x02 /* Public */,
      91,    2,  629,    2, 0x02 /* Public */,
      92,    2,  634,    2, 0x02 /* Public */,
      93,    0,  639,    2, 0x02 /* Public */,
      94,    0,  640,    2, 0x02 /* Public */,
      95,    0,  641,    2, 0x02 /* Public */,

 // slots: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void, QMetaType::Bool,    4,
    QMetaType::Void, QMetaType::QString,    6,
    QMetaType::Void, QMetaType::QString,    6,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,    6,
    QMetaType::QString,
    QMetaType::Void, QMetaType::Bool,   12,
    QMetaType::Void, QMetaType::Bool,   12,
    QMetaType::Void, QMetaType::Bool,   12,
    QMetaType::Void, QMetaType::Bool,   12,
    QMetaType::Void, QMetaType::Bool,   12,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::QObjectStar,   22,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   29,
    QMetaType::Void, QMetaType::QString,   29,
    QMetaType::Void, QMetaType::QString,   29,
    QMetaType::Void, QMetaType::QString,   29,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,   35,   36,   37,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   40,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,   12,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   53,
    QMetaType::Void, QMetaType::Int,   55,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Void, QMetaType::QString,   65,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   69,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   65,    6,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   69,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,   35,   36,   37,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,   35,   36,   37,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,   35,   36,   37,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Float,   35,   36,   37,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Void, QMetaType::QString,   29,
    QMetaType::Void, QMetaType::Bool,   82,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   55,   87,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,   36,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   35,   36,
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
        case 1: _t->setEnable((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 2: _t->setName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->setTool((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 4: { QString _r = _t->getTool();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 5: _t->setMode((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 6: { QString _r = _t->getMode();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 7: _t->setlidarView((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 8: _t->setobjectView((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 9: _t->setobjectBoxView((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 10: _t->setLocationView((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 11: _t->setRobotFollowing((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 12: { bool _r = _t->getRobotFollowing();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 13: { bool _r = _t->getlidarView();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 14: { bool _r = _t->getobjectView();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 15: { bool _r = _t->getobjectBoxView();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 16: _t->setMap((*reinterpret_cast< QObject*(*)>(_a[1]))); break;
        case 17: _t->updateMap(); break;
        case 18: _t->moveMap(); break;
        case 19: _t->reloadMap(); break;
        case 20: _t->setMapping(); break;
        case 21: _t->setObjecting(); break;
        case 22: _t->setRawMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 23: _t->setEditedMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 24: _t->setCostMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 25: _t->setObjectMap((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 26: _t->setFullScreen(); break;
        case 27: _t->setInitPose((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 28: _t->clearInitPose(); break;
        case 29: _t->rotateMap((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 30: _t->rotateMapCW(); break;
        case 31: _t->rotateMapCCW(); break;
        case 32: _t->showBrush((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 33: { bool _r = _t->getDrawingFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 34: { bool _r = _t->getDrawingUndoFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 35: _t->startDrawing((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 36: _t->addLinePoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 37: _t->endDrawing((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 38: _t->clearDrawing(); break;
        case 39: _t->undoLine(); break;
        case 40: _t->redoLine(); break;
        case 41: _t->setLineColor((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 42: _t->setLineWidth((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 43: { int _r = _t->getObjectNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 44: { int _r = _t->getObjectPointNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 45: _t->addObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 46: _t->addObjectPoint((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 47: _t->setObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 48: { bool _r = _t->getObjectFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 49: _t->editObjectStart((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 50: _t->editObject((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 51: _t->saveObject((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 52: _t->clearObject(); break;
        case 53: _t->undoObject(); break;
        case 54: _t->selectObject((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 55: { bool _r = _t->getLocationFlag();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 56: _t->saveLocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 57: _t->clearLocation(); break;
        case 58: _t->selectLocation((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 59: _t->addLocation((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 60: _t->addLocationCur((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 61: _t->setLocation((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 62: _t->editLocation((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 63: _t->editLocation(); break;
        case 64: _t->redoLocation(); break;
        case 65: { int _r = _t->getLocationNum((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 66: _t->initTline((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 67: _t->setTlineMode((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 68: _t->setMapTline(); break;
        case 69: _t->saveMap(); break;
        case 70: _t->saveTline(); break;
        case 71: _t->setMapSize((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 72: _t->zoomIn((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 73: _t->zoomOut((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 74: _t->scaledIn((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 75: _t->scaledOut((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 76: _t->move((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 77: { int _r = _t->getX();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 78: { int _r = _t->getY();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 79: { float _r = _t->getScale();
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
        if (_id < 80)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 80;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 80)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 80;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
