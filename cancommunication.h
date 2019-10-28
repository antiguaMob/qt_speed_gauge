#ifndef CANCOMMUNICATION_H
#define CANCOMMUNICATION_H

#include <QObject>
#include <QCanBusDevice>
#include <QVariantList>

class CANCommunication : public QObject
{
    Q_OBJECT

public:
    explicit CANCommunication(QObject *parent = 0);
    // Invokable so it can be called from QML
    Q_INVOKABLE void connectDevice(const QString &interface);
    Q_INVOKABLE void disconnectDevice();
    Q_INVOKABLE void sendFrame(const quint32 frameId, const QVariantList payload);

private Q_SLOTS:
    void checkMessages();
    void errorReceived(QCanBusDevice::CanBusError error);

private:
    bool isFrameValidSpeed(const QCanBusFrame frame);
    QCanBusDevice *m_canDevice = nullptr;
    const quint32 FRAME_ID_SPEED = 0x123;
    const int FRAME_SIZE_SPEED = 0x01;
    const int MIN_SPEED = 0;
    const int MAX_SPEED = 160;
    const QString CAN_BUS_PLUGIN = "socketcan";

Q_SIGNALS:
     void currSpeed(unsigned int speed);
     void notifyErr(QString str);
     void canConnected();
     void canDisconnected();
};

#endif // CANCOMMUNICATION_H
