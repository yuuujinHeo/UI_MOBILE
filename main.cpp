#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QQmlContext>
#include "MapView.h"
#include "Supervisor.h"
#include "Logger.h"

Logger *plog;
QObject *object;
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    qmlRegisterType<Supervisor>("io.qt.Supervisor",1,0, "Supervisor");
    qmlRegisterType<MapView>("io.qt.MapView",1,0, "MapView");

    QApplication app(argc, argv);
    app.setOrganizationName("Mobile");
    app.setOrganizationDomain("Mobile");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());
    engine.rootContext()->setContextProperty("homePath", QDir::homePath());
//    QGuiApplication::setOverrideCursor(QCursor(Qt::BlankCursor));
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    object = engine.rootObjects()[0];
    return app.exec();
}
