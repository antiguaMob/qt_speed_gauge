import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Dialogs 1.1
import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    id: window
    width: 600
    height: 600
    title: "Speed Gauge"
    visible: true
    minimumWidth: 500
    minimumHeight: 500

    Connections {
        target:CANCommunication

        onCurrSpeed: {
            gauge.value = speed
        }
        
        onNotifyErr: {
            messageDialog.text = str
            messageDialog.visible = true
        }

        onCanConnected: {
            send_button.enabled = true
        }

        onCanDisconnected: {
            send_button.enabled = false
        }
    }
    
    MessageDialog {
        id: messageDialog
        icon: StandardIcon.Critical
        title: "Error"
        Component.onCompleted: visible = false
    }

    Rectangle {
        id: rectangle
        width: parent.width
        height: parent.height
        color: "#f0eded"
        visible: true
        z: -1
    }

    Row {
        id: row
        x: 0
        y: 0
        width: parent.width
        height: 25
        spacing: 0

        ToolSeparator {
            id: toolSeparator
            width: parent.width/4
            height: parent.height
            opacity: 0
        }

        Text {
            id: interface_label
            y: 3
            width: parent.width/2
            height: 19
            text: qsTr("CAN interface")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: 29
            font.pixelSize: 12
        }

        ToolSeparator {
            id: toolSeparator1
            width: parent.width/4
            height: parent.height
            opacity: 0
        }
    }

    Row {
        id: row1
        x: 0
        y: 25
        width: parent.width
        height: 25

        ToolSeparator {
            id: toolSeparator2
            width: parent.width/4
            height: parent.height
            opacity: 0
        }

        Rectangle {
            id: interface_container
            y: 3
            width: parent.width/2
            height: 19
            border.width: 1
            border.color: "#000000"
            radius: 3

            TextInput {
                id: interface_text
                text: qsTr("Type here CAN bus iterface (ex. vcan0)")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.topMargin: 8
                anchors.leftMargin: 8
                font.wordSpacing: 0
                font.family: "Courier"
                font.pixelSize: 11
                clip: true
            }
        }

        ToolSeparator {
            id: toolSeparator3
            width: parent.width/4
            height: parent.height
            opacity: 0
        }

    }

    Row {
        id: row2
        x: 0
        y: 50
        width: parent.width
        height: 25
        spacing: 0

        ToolSeparator {
            id: toolSeparator4
            width: parent.width/9
            height: parent.height
            opacity: 0
        }

        Button {
            id: connect_button
            text: "Connect"
            anchors.verticalCenter: parent.verticalCenter
            width: 3*parent.width/9
            height: 20
            onClicked: CANCommunication.connectDevice(interface_text.text)
        }

        ToolSeparator {
            id: toolSeparator5
            width: parent.width/9
            height: parent.height
            opacity: 0
        }

        Button {
            id: disconnect_button
            width: 3*parent.width/9
            height: 20
            text: qsTr("Disconnect")
            anchors.verticalCenter: parent.verticalCenter
            onClicked: CANCommunication.disconnectDevice()
        }

        ToolSeparator {
            id: toolSeparator6
            width: parent.width/9
            height: parent.height
            opacity: 0
        }
    }

    Row {
        id: row3
        x: 0
        y: 75
        width: parent.width
        height: 15

        Rectangle {
            id: rectangle2
            x: 0
            width: parent.width
            height: 2
            anchors.verticalCenter: parent.verticalCenter
            border.width: 1
            border.color: "#bcbec3"
        }
    }

    Row {
        id: row4
        y: 90
        width:  parent.width
        height: 25

        ToolSeparator {
            id: toolSeparator8
            width: parent.width/4
            height: parent.height
            opacity: 0
        }

        Text {
            id: id_label
            y: 3
            width: parent.width/2
            height: 19
            text: qsTr("ID")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }

        ToolSeparator {
            id: toolSeparator9
            width: parent.width/4
            height: parent.height
            opacity: 0
        }
    }

    Row {
        id: row5
        y: 115
        width:  parent.width
        height: 25

        ToolSeparator {
            id: toolSeparator10
            width: parent.width/4
            height: parent.height
            opacity: 0
        }

        Rectangle {
            id: frame_id_container
            y: 3
            width: parent.width/2
            height: 19
            color: "#e8e4e4"
            radius: 3
            border.width: 1
            border.color: "#000000"

            Text {
                id: frame_id_random
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                font.pixelSize: 12
            }
        }

        ToolSeparator {
            id: toolSeparator11
            width: parent.width/4
            height: parent.height
            opacity: 0
        }
    }

    Row {
        id: row6
        y: 140
        width: parent.width
        height: 25

        ToolSeparator {
            id: toolSeparator12
            width: parent.width/4
            height: parent.height
            opacity: 0
        }

        Text {
            id: data_label
            y: 3
            width: parent.width/2
            height: 19
            text: qsTr("Data")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }

        ToolSeparator {
            id: toolSeparator13
            width: parent.width/4
            height: parent.height
            opacity: 0
        }
    }

    Row {
        id: row7
        y: 165
        width: parent.width
        height: 25

        ToolSeparator {
            id: toolSeparator14
            width: parent.width/4
            height: parent.height
            opacity: 0
        }

        Rectangle {
            id: data_container
            y: 3
            width: parent.width/2
            height: 19
            color: "#e8e4e4"
            radius: 3

            Text {
                id: data_random
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 12
                clip: true
            }
            border.color: "#000000"
            border.width: 1
        }

        ToolSeparator {
            id: toolSeparator15
            width: parent.width/4
            height: parent.height
            opacity: 0
        }
    }

    Row {
        id: row8
        x: 0
        y: 190
        width: parent.width
        height: 25

        ToolSeparator {
            id: toolSeparator16
            width: 3*parent.width/8
            height: parent.height
            opacity: 0
        }

        Button {
            id: send_button
            width: 2*parent.width/8
            height: 20
            text: qsTr("Send random data")
            enabled: false
            anchors.verticalCenter: parent.verticalCenter
            onClicked:  {
                // Function to create random hex array
                function randomArray(length, max) {
                    return Array.apply(null, new Array(length)).map(function() {
                        var randNum = Math.round(Math.random() * max)
                        // randNum to hex string
                        return ("00" + randNum.toString(16)).substr(-2)
                    });
                }

                // Random frame id
                var frameId = Math.floor(Math.random() * 255)
                // Random payload length [1,8]
                var arrayLen =  Math.floor(Math.random() * (9 - 1)) + 1
                var myArray = randomArray(arrayLen, 255)
                // Send frame to c++
                CANCommunication.sendFrame(frameId, myArray.join(''))
                // Update GUI with hex values sent
                frame_id_random.text = ("00" + frameId.toString(16)).substr(-2)
                data_random.text = myArray.toString()
            }
        }

        ToolSeparator {
            id: toolSeparator17
            width: 3*parent.width/8
            height: parent.height
            opacity: 0
        }

    }

    Row {
        id: row9
        x: 0
        y: 215
        width: parent.width
        height: 15

        Rectangle {
            id: rectangle1
            x: 0
            width: parent.width
            height: 2
            anchors.verticalCenter: parent.verticalCenter
            border.width: 1
            border.color: "#bcbec3"
        }
    }

    Row {
        id: row10
        x: 0
        y: 230
        width: parent.width
        height: parent.height - 230

        ToolSeparator {
            id: toolSeparator19
            width: (parent.width - 272)/2
            height: parent.height
            opacity: 0
        }

        CircularGauge {
            id: gauge
            x: parent.width + 200
            anchors.verticalCenter: parent.verticalCenter
            z: 3
            value: 4
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
                    color: "red"
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

            Text {
                id: unit_label
                y: 162
                text: "km/h"
                anchors.horizontalCenterOffset: 1
                anchors.bottomMargin: 93
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
            }

            Behavior on value { NumberAnimation { duration: 200 }}
        }

        ToolSeparator {
            id: toolSeparator20
            width: (parent.width - 272)/2
            height: parent.height
            opacity: 0
        }
    }
}
