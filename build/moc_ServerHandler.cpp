/****************************************************************************
** Meta object code from reading C++ file 'ServerHandler.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.8)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../ServerHandler.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ServerHandler.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.8. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_ServerHandler_t {
    QByteArrayData data[13];
    char stringdata0[180];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_ServerHandler_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_ServerHandler_t qt_meta_stringdata_ServerHandler = {
    {
QT_MOC_LITERAL(0, 0, 13), // "ServerHandler"
QT_MOC_LITERAL(1, 14, 12), // "server_pause"
QT_MOC_LITERAL(2, 27, 0), // ""
QT_MOC_LITERAL(3, 28, 13), // "server_resume"
QT_MOC_LITERAL(4, 42, 17), // "server_new_target"
QT_MOC_LITERAL(5, 60, 15), // "server_new_call"
QT_MOC_LITERAL(6, 76, 14), // "server_set_ini"
QT_MOC_LITERAL(7, 91, 11), // "onConnected"
QT_MOC_LITERAL(8, 103, 14), // "onDisconnected"
QT_MOC_LITERAL(9, 118, 21), // "onTextMessageReceived"
QT_MOC_LITERAL(10, 140, 7), // "message"
QT_MOC_LITERAL(11, 148, 23), // "onBinaryMessageReceived"
QT_MOC_LITERAL(12, 172, 7) // "onTimer"

    },
    "ServerHandler\0server_pause\0\0server_resume\0"
    "server_new_target\0server_new_call\0"
    "server_set_ini\0onConnected\0onDisconnected\0"
    "onTextMessageReceived\0message\0"
    "onBinaryMessageReceived\0onTimer"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_ServerHandler[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   64,    2, 0x06 /* Public */,
       3,    0,   65,    2, 0x06 /* Public */,
       4,    0,   66,    2, 0x06 /* Public */,
       5,    0,   67,    2, 0x06 /* Public */,
       6,    0,   68,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       7,    0,   69,    2, 0x0a /* Public */,
       8,    0,   70,    2, 0x0a /* Public */,
       9,    1,   71,    2, 0x0a /* Public */,
      11,    1,   74,    2, 0x0a /* Public */,
      12,    0,   77,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   10,
    QMetaType::Void, QMetaType::QByteArray,   10,
    QMetaType::Void,

       0        // eod
};

void ServerHandler::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ServerHandler *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->server_pause(); break;
        case 1: _t->server_resume(); break;
        case 2: _t->server_new_target(); break;
        case 3: _t->server_new_call(); break;
        case 4: _t->server_set_ini(); break;
        case 5: _t->onConnected(); break;
        case 6: _t->onDisconnected(); break;
        case 7: _t->onTextMessageReceived((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 8: _t->onBinaryMessageReceived((*reinterpret_cast< QByteArray(*)>(_a[1]))); break;
        case 9: _t->onTimer(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ServerHandler::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ServerHandler::server_pause)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (ServerHandler::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ServerHandler::server_resume)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (ServerHandler::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ServerHandler::server_new_target)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (ServerHandler::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ServerHandler::server_new_call)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (ServerHandler::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ServerHandler::server_set_ini)) {
                *result = 4;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject ServerHandler::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_ServerHandler.data,
    qt_meta_data_ServerHandler,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *ServerHandler::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ServerHandler::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ServerHandler.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int ServerHandler::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 10)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 10;
    }
    return _id;
}

// SIGNAL 0
void ServerHandler::server_pause()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void ServerHandler::server_resume()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void ServerHandler::server_new_target()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void ServerHandler::server_new_call()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void ServerHandler::server_set_ini()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
