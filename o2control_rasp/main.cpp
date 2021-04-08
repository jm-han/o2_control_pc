#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "serialport.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
#if true
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    SerialPort serial;    // Create the application core with signals and slots
    QString strPath = QCoreApplication::applicationDirPath();
    //serial.SetPath(strPath);
    // serial.SetPath("/home/pi/log");     // 라즈베리 로그저장
    serial.SetPath("d:/log_txt");

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();

    /* We load the object into the context to establish the connection,
     * and also define the name "appCore" by which the connection will occur
     * */
    context->setContextProperty("serialPort", &serial);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
#else
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //qmlRegisterType<SerialPort>("com.dawn.com", 0, 1, "SerialPort");
    {
        QString strPath = QCoreApplication::applicationDirPath();
        SerialPort serial;
        engine.rootContext()->setContextProperty("com.dawn.com", &serial);
        serial.SetPath(strPath);
    }
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
#endif
    return app.exec();
}
