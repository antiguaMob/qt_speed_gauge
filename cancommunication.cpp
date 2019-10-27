#include "cancommunication.h"

#include <QCanBus>
#include <QCanBusFrame>
#include <QVariant>

CANCommunication::CANCommunication(QObject *parent) : QObject(parent) {}

void CANCommunication::cppSlot(const QString &msg)
{

}

/*
 * Communicate CAN bus error to user.
 *
 * @param error     Error type.
 */
void CANCommunication::errorReceived(QCanBusDevice::CanBusError error)
{
    if (error != QCanBusDevice::NoError)
        emit notifyErr(m_canDevice->errorString());
}

/*
 * Create an instance of socketcan.
 *
 * @param interface   Interface name.
 *
 */
void CANCommunication::connectDevice(const QString &interface)
{
    // Create CAN bus instance
    QString errorString;
    m_canDevice = QCanBus::instance()->createDevice(CAN_BUS_PLUGIN, interface, &errorString);

    if (!m_canDevice) {
        // Notify error to QML
        emit notifyErr(errorString);
        return;
    }
    else
    {
        // Check errors and messages
        connect(m_canDevice, &QCanBusDevice::errorOccurred,
                this, &CANCommunication::errorReceived);
        connect(m_canDevice, &QCanBusDevice::framesReceived,
                this, &CANCommunication::checkMessages);
    }

    // Connect CAN bus to selected interface
    if (!m_canDevice->connectDevice()) {
        // Notify error to QML
        emit notifyErr(m_canDevice->errorString());
        delete m_canDevice;
        m_canDevice = nullptr;
    }
}

void CANCommunication::disconnectDevice()
{
    if (!m_canDevice)
        return;

    m_canDevice->disconnectDevice();
    delete m_canDevice;
    m_canDevice = nullptr;
}

/*
 * Check incoming CAN bus messages 
 */
void CANCommunication::checkMessages()
{
    if (!m_canDevice)
        return;

    while (m_canDevice->framesAvailable()) {
        const QCanBusFrame frame = m_canDevice->readFrame();

        if (frame.frameType() == QCanBusFrame::ErrorFrame)
            emit notifyErr(m_canDevice->interpretErrorFrame(frame));

        if (frame.frameId() == FRAME_ID_SPEED && frame.payload().size() == FRAME_SIZE_SPEED)
            emit currSpeed((unsigned int)frame.payload()[0]);
    }
}

void CANCommunication::sendFrame(const QCanBusFrame &frame) const
{
    if (!m_canDevice)
        return;

    m_canDevice->writeFrame(frame);
}
