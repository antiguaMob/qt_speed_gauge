#include "cancommunication.h"

#include <QCanBus>

/*
 * CANCommunicaion constructor
 */
CANCommunication::CANCommunication(QObject *parent) : QObject(parent) {}

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
 * Create an instance of socketcan and connect.
 *
 * @param interface   Interface name.
 *
 */
void CANCommunication::connectDevice(const QString &interface)
{
    /* Create CAN bus instance */
    QString errorString;
    m_canDevice = QCanBus::instance()->createDevice(CAN_BUS_PLUGIN, interface, &errorString);

    if (!m_canDevice) {
        /* Notify error to user */
        emit notifyErr(errorString);
        return;
    }
    else
    {
        /* Check errors and messages */
        connect(m_canDevice, &QCanBusDevice::errorOccurred,
                this, &CANCommunication::errorReceived);
        connect(m_canDevice, &QCanBusDevice::framesReceived,
                this, &CANCommunication::checkMessages);
    }

    /* Connect CAN bus to selected interface */
    if (!m_canDevice->connectDevice()) {
        /* Notify error to QML */
        emit notifyErr(m_canDevice->errorString());
        delete m_canDevice;
        m_canDevice = nullptr;
        return;
    }
    /* Notify QML of disconnection */
    emit canConnected();
}

/*
 * Delete and disconnect CAN communication.
 */
void CANCommunication::disconnectDevice()
{
    /* Notify QML of disconnection */
    emit canDisconnected();

    if (!m_canDevice)
        return;

    m_canDevice->disconnectDevice();
    delete m_canDevice;
    m_canDevice = nullptr;
}

/*
 * Check if the frame contains valid speed.
 *
 * @param frame     Received CAN frame
 *
 * @return          True if frame contains valid speed.
 */
bool CANCommunication::isFrameValidSpeed(const QCanBusFrame frame) {
    /* Check that message is of vehicle speed type and length */
    if (frame.frameId() == FRAME_ID_SPEED && frame.payload().size() == FRAME_SIZE_SPEED) {
        const int speed_value = frame.payload()[0];
        /* Discard value if speed is out of bounds */
        if (speed_value >= MIN_SPEED && speed_value <= MAX_SPEED)
            return true;
    }

    return false;
}

/*
 * Check incoming CAN bus messages.
 */
void CANCommunication::checkMessages()
{
    if (!m_canDevice)
        return;

    while (m_canDevice->framesAvailable()) {
        const QCanBusFrame frame = m_canDevice->readFrame();

        if (frame.frameType() == QCanBusFrame::ErrorFrame)
            emit notifyErr(m_canDevice->interpretErrorFrame(frame));

        if (isFrameValidSpeed(frame))
            emit currSpeed((unsigned int)frame.payload()[0]);
    }
}

/*
 * Send data over CAN bus.
 *
 * @param frameId   Frame id of the message to be sent
 * @param payload   Data to be sent
 */
void CANCommunication::sendFrame(const quint32 frameId, const QVariantList payload)
{
    if (!m_canDevice) {
        emit notifyErr("Cannot send frames, try connecting with the CAN bus first.");
        return;
    }

    /* Convert QVariantList to QByteArray */
    QByteArray framePayload;
    foreach (QVariant item, payload) {
        framePayload.append(item.toInt());
    }

    /* Create frame to be sent */
    QCanBusFrame frame = QCanBusFrame(frameId, framePayload);

    m_canDevice->writeFrame(frame);
}
