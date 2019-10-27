#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "cancommunication.h"

#include <QQuickView>
#include <QtQuick>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    // Object holding CAN communication
    CANCommunication canCom;

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));

    // Enable CANCommunication canCom object on qml
    engine.rootContext()->setContextProperty("CANCommunication",
                                             &canCom);

    // Connect qml SIGNAL with canCom SLOT
    QObject *rootObject = engine.rootObjects().first();
    QObject::connect(rootObject, SIGNAL(qmlSignal(QString)),
                     &canCom, SLOT(cppSlot(QString)));

    return a.exec();
}
