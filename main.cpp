#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "speedometerData.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    EngineConfiguration *confPtr = new EngineConfiguration();
    const QUrl url(QStringLiteral("qrc:untitled12/Main.qml"));
    engine.rootContext()->setContextProperty("EngineConfigCPP", confPtr);
    engine.load(url);
    return app.exec();
}
