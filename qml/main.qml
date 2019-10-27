import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Dialogs 1.1

ApplicationWindow {
    id: window
    width: 800
    height: 800
    visible: true

    //signal qmlSignal(string msg)
    Connections {
        target:CANCommunication
        onCurrSpeed: {
            mygaug.value = speed
        }

        onNotifyErr: {
            messageDialog.text = str
            messageDialog.visible = true
        }
    }

    Button {
        id: button1
        x: 134
        y: 221
        text: "Switch ON"


        onClicked: CANCommunication.connectDevice(textInput.text)
        //onClicked: window.qmlSignal("Hello from QML")
    }

    Button {
        id: button2
        x: 365
        y: 229
        text: qsTr("Switch OFF")
        onClicked: CANCommunication.disconnectDevice()
    }

    TextInput {
        id: textInput
        x: 261
        y: 236
        width: 80
        height: 20
        enabled: true
        text: qsTr("vcan0")
        renderType: Text.QtRendering
        cursorVisible: true
        font.wordSpacing: -6
        font.family: "Courier"
        font.pixelSize: 12
    }

    Text {
        id: text1
        x: 197
        y: 267
        text: qsTr("TT")
        font.pixelSize: 12
    }

    MessageDialog {
        id: messageDialog
        icon: StandardIcon.Critical
        title: "Error"
        Component.onCompleted: visible = false
    }

    Rectangle {
        x: 295
        y: 392
        width: 298
        height: 318
        color: "white"


        CircularGauge {
            id: mygaug
            anchors.centerIn: parent
            value: 4
            anchors.verticalCenterOffset: -7
            anchors.horizontalCenterOffset: 0
            maximumValue: 160

            style: CircularGaugeStyle {
                tickmarkLabel:  Text {
                    font.pixelSize: Math.max(6, outerRadius * 0.1)
                    text: styleData.value
                    color: styleData.value >= 120 ? "#e34c22" : "#000000"
                    antialiasing: true
                }

                needle: Rectangle {
                    y: outerRadius * 0.15
                    implicitWidth: outerRadius * 0.03
                    implicitHeight: outerRadius * 0.9
                    antialiasing: true
                    color: "black"
                }

                foreground: Item {
                    Rectangle {
                        width: outerRadius * 0.2
                        height: width
                        radius: width / 2
                        color: "black"
                        anchors.centerIn: parent
                    }
                }
                tickmark: Rectangle {
                    visible: styleData.value < 120 || styleData.value % 10 == 0
                    implicitWidth: outerRadius * 0.02
                    antialiasing: true
                    implicitHeight: outerRadius * 0.06
                    color: styleData.value >= 120 ? "#e34c22" : "#000000"

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        //text: styleData.index
                        font.pixelSize: 8
                        color: "blue"
                    }
                }

                minorTickmark: Rectangle {

                    visible: styleData.value < 120
                    implicitWidth: outerRadius * 0.01
                    antialiasing: true
                    implicitHeight: outerRadius * 0.03
                    color: "#000000"
                }

            }

            Behavior on value { NumberAnimation { duration: 1000 }}

        }
    }




}
