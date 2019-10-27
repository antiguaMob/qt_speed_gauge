#ifndef CANCOMMUNICATION_H
#define CANCOMMUNICATION_H

#include <QObject>
#include <QCanBusDevice>

class CANCommunication : public QObject
{
    Q_OBJECT

public:
    explicit CANCommunication(QObject *parent = 0);
    // Invokable so it can be called from QML
    Q_INVOKABLE void connectDevice(const QString &interface);
    Q_INVOKABLE void disconnectDevice();
    Q_INVOKABLE void sendFrame(const QCanBusFrame &frame) const;

public slots:
    void cppSlot(const QString &msg);

private Q_SLOTS:
    void checkMessages();
    void errorReceived(QCanBusDevice::CanBusError error);

private:


    QCanBusDevice *m_canDevice = nullptr;
    const int FRAME_ID_SPEED = 0x123;
    const int FRAME_SIZE_SPEED = 0x01;
    const QString CAN_BUS_PLUGIN = "socketcan";

Q_SIGNALS:
     void currSpeed(unsigned int speed);
     void notifyErr(QString str);

};

#endif // CANCOMMUNICATION_H
