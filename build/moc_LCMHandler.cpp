/****************************************************************************
** Meta object code from reading C++ file 'LCMHandler.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.8)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../LCMHandler.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'LCMHandler.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.8. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_LCMHandler_t {
    QByteArrayData data[6];
    char stringdata0[55];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_LCMHandler_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_LCMHandler_t qt_meta_stringdata_LCMHandler = {
    {
QT_MOC_LITERAL(0, 0, 10), // "LCMHandler"
QT_MOC_LITERAL(1, 11, 11), // "pathchanged"
QT_MOC_LITERAL(2, 23, 0), // ""
QT_MOC_LITERAL(3, 24, 12), // "cameraupdate"
QT_MOC_LITERAL(4, 37, 9), // "mappingin"
QT_MOC_LITERAL(5, 47, 7) // "onTimer"

    },
    "LCMHandler\0pathchanged\0\0cameraupdate\0"
    "mappingin\0onTimer"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_LCMHandler[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   34,    2, 0x06 /* Public */,
       3,    0,   35,    2, 0x06 /* Public */,
       4,    0,   36,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       5,    0,   37,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,

       0        // eod
};

void LCMHandler::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<LCMHandler *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->pathchanged(); break;
        case 1: _t->cameraupdate(); break;
        case 2: _t->mappingin(); break;
        case 3: _t->onTimer(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (LCMHandler::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&LCMHandler::pathchanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (LCMHandler::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&LCMHandler::cameraupdate)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (LCMHandler::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&LCMHandler::mappingin)) {
                *result = 2;
                return;
            }
        }
    }
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject LCMHandler::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_LCMHandler.data,
    qt_meta_data_LCMHandler,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *LCMHandler::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *LCMHandler::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_LCMHandler.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int LCMHandler::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void LCMHandler::pathchanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void LCMHandler::cameraupdate()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void LCMHandler::mappingin()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE