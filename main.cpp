#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "log.h"
#include "sqlite.h"
#include "configure.h"
#include "parkmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Universal");
    qSetMessagePattern("Time:%{time [yyyy-MM-dd hh:mm:ss]} Type:%{type} %{message}");
    qInstallMessageHandler(msgOutput);
    qmlRegisterType<Sqlite>("Sqlite", 1, 0, "Sqlite");
    qmlRegisterType<Configure>("Configure", 1, 0, "Configure");
    qmlRegisterType<ParkModel>("ParkModel", 1, 0, "ParkModel");
    QQmlApplicationEngine engine("qrc:/main.qml");
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
