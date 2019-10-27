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
    minimumWidth: 600
    minimumHeight: 600
    //maximumHeight: 700
    //maximumWidth: 700
    //signal qmlSignal(string msg)
    Connections {
        target:CANCommunication
        onCurrSpeed: {
            gauge.value = speed
        }
        
        onNotifyErr: {
            messageDialog.text = str
            messageDialog.visible = true
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
        color: "#ffffff"
        z: -1
    }
    
    Grid {
        id: grid1
        width: parent.width
        height: parent.height
        
        Column {
            id: column1
            width: parent.width
            height: parent.height
            //anchors.verticalCenter: parent.verticalCenter
            //anchors.horizontalCenter: parent.horizontalCenter
            
            Row {
                id: row
                width: parent.width
                height: (parent.height/3)/4
                anchors.horizontalCenterOffset: 0
               // anchors.top: parent.top
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true

                Column {
                    id: column5
                    width: parent.width/4
                    height: parent.height

                    Text {
                        id: interface_label
                        y: parent.height/2
                        text: qsTr("CAN interface")
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 29
                        //anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 12
                    }
                }

                Column {
                    id: column6
                    width: parent.width/4
                    height: parent.height

                    Rectangle {
                        id: interface_container
                        //width: 3*parent.width/4
                        width: 40
                        y: parent.height/2
                        height: 20
                        border.width: 1
                        border.color: "#000000"
                        radius: 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        TextInput {

                            //ToolTip.text: qsTr("Save the active project")
                            id: interface_text
                            enabled: true
                            text: qsTr("Type here CAN bus iterface (ex. vcan0)")
                            anchors.topMargin: 4
                            anchors.leftMargin: 10
                            anchors.fill: parent
                            renderType: Text.QtRendering
                            cursorVisible: false
                            font.wordSpacing: -6
                            font.family: "Courier"
                            font.pixelSize: 11
                            clip: true
                        }
                    }
                }

                Column {
                    id: column7
                    width: parent.width/4
                    height: parent.height

                    Button {
                        id: connect_button
                        y: parent.height/2
                        text: "Connect"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        onClicked: CANCommunication.connectDevice(interface_text.text)
                        //onClicked: window.qmlSignal("Hello from QML")
                    }
                }

                Column {
                    id: column8
                    width: parent.width/4
                    height: parent.height

                    Button {
                        id: disconnect_button
                        y: parent.height/2
                        text: qsTr("Disconnect")
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        onClicked: CANCommunication.disconnectDevice()
                    }
                }
                
            }
            
            Row {
                id: row1
                width: parent.width
                height: (parent.height/3)/4
                //anchors.top: row.bottom
                anchors.topMargin: 0
                spacing: 0

                Column {
                    id: column2
                    x: 0
                    width: parent.width/2
                    height: parent.height
                    //anchors.right: parent.right
                    anchors.rightMargin: parent.width/2

                    Text {
                        id: id_label
                        y: parent.height/2
                        text: qsTr("ID")
                        //anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 12
                    }
                }

                Column {
                    id: column3

                    width: parent.width/2
                    height: parent.height
                   // anchors.left: column2.right
                    anchors.leftMargin: 0

                    Rectangle {
                        id: frame_id_container
                        width: 200
                        height: 20
                        color: "#e8e4e4"
                        radius: 0
                        //anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        border.width: 1
                        border.color: "#000000"
                        y: parent.height/2

                        Text {
                            id: frame_id_random
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            clip: true
                            font.pixelSize: 12
                        }
                    }
                }

            }

            Row {
                id: row2
                //x: 0
                width: parent.width
                height: (parent.height/3)/4
                //anchors.top: row1.bottom
                anchors.topMargin: 0
                spacing: 0

                Column {
                    id: column
                    width: parent.width/2
                    height: parent.height
                    //anchors.right: parent.right
                    anchors.rightMargin: parent.width/2

                    Text {
                        id: data_label
                        y: parent.height/2
                        text: qsTr("Data")
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 12
                    }
                }

                Column {
                    id: column4
                    width: parent.width/2
                    height: parent.height
                    anchors.top: parent.top
                    //anchors.left: column.right
                    anchors.leftMargin: 0
                    anchors.topMargin: 0

                    Rectangle {
                        id: data_container
                        width: 200
                        height: 20
                        color: "#e8e4e4"
                        radius: 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        y: parent.height/2
                        //anchors.verticalCenter: parent.verticalCenter
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
                }
            }


            Row {
                id: row4
                width: parent.width
                height: (parent.height/3)/4
                //anchors.top: row2.bottom
                anchors.topMargin: 0

                Button {
                    id: send_button
                    x: parent.width/2 - width/2
                    text: qsTr("Send random data")
                    //anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked:  {
                        function randomArray(length, max) {
                            return Array.apply(null, new Array(length)).map(function() {
                                return Math.round(Math.random() * max);
                            });
                        }
                        var frameId = Math.floor(Math.random() * 255)
                        var arrayLen =  Math.floor(Math.random() * (9 - 1)) + 1
                        var myArray = randomArray(arrayLen, 255)
                        CANCommunication.sendFrame(frameId, myArray)
                        frame_id_random.text = frameId.toString()
                        data_random.text = myArray.toString()
                    }
                }
            }

            Row {
                id: row3
                x: 0
                width: parent.width
                height: 2*parent.height/3
                //anchors.top: row4.bottom
                anchors.topMargin: 0

                CircularGauge {
                    id: gauge
                    //anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    z: 3
                    x: parent.width/2 - width/2
                    y: parent.height/2 - height/2
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
            }
        }
        
    }



    
    
    
    
}
