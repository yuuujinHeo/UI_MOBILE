#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QQmlContext>
#include "Supervisor.h"
#include "Logger.h"

Logger *plog;
QObject *object;
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    qmlRegisterType<Supervisor>("io.qt.Supervisor",1,0, "Supervisor");

    QApplication app(argc, argv);
    app.setOrganizationName("Mobile");
    app.setOrganizationDomain("Mobile");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    object = engine.rootObjects()[0];
//    Supervisor::getInstance().setObject(object);
//    Supervisor::getInstance().setWindow(qobject_cast<QQuickWindow *>(object));

//    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                     &app, [url](QObject *obj, const QUrl &objUrl) {
//        if (!obj && url == objUrl)
//            QCoreApplication::exit(-1);
//    }, Qt::QueuedConnection);
//    engine.load(url);

//    object = engine.rootObjects()[0];
    return app.exec();
}
