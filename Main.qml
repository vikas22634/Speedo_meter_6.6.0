import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 6.6

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("SpeedoMeter")

    Rectangle {
        id: dashboardId
        height: 500
        width: 1000
        color: "#232332" // background color
        anchors.centerIn: parent

        // change background color
        Button {
            id: myButton
            text: "Change Color"

            anchors {
                top: parent.top
                topMargin: 50
                horizontalCenter: parent.horizontalCenter
            }

                Text {
                    anchors.centerIn: parent
                    text: myButton.text
                    color: "white" // Set the text color
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // Change the background color of the ApplicationWindow
                        dashboardId.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1);
                    }
                }

        }

        // left and right indicator
        Row {
            id: rowIndicator
            spacing: dashboardId.width * 0.2
            anchors.top: dashboardId.top
            anchors.topMargin: dashboardId.width * 0.06
            anchors.horizontalCenter: parent.horizontalCenter

            ArrowIndicator {
                id: leftIndicatorId
                height: dashboardId.height * 0.05
                width: height * 1.5
                direction: Qt.LeftArrow
            }

            Rectangle {
                height: dashboardId.height * 0.05
                width: height
                color: "transparent"
            }

            ArrowIndicator {
                id: rightIndicatorId
                height: dashboardId.height * 0.05
                width: height * 1.5
                direction: Qt.RightArrow
            }
        }

        Item {
            focus: true
            Keys.onPressed: {
                if (event.key === Qt.Key_Left) {
                    leftIndicatorId.isOn = true
                    rightIndicatorId.isOn = false
                } else if (event.key === Qt.Key_Right) {
                    rightIndicatorId.isOn = true
                    leftIndicatorId.isOn = false
                }
            }

            Keys.onReleased: {
                if (event.key === Qt.Key_Up) {
                    EngineConfigCPP.applyBrake(true);
                    EngineConfigCPP.accelerate(false);
                }
            }

            Keys.onUpPressed: {
                EngineConfigCPP.applyBrake(false);
                EngineConfigCPP.accelerate(true);
            }

            Keys.onDownPressed: {
                EngineConfigCPP.applyBrake(true);
                EngineConfigCPP.accelerate(false);
            }

            Keys.onDigit0Pressed: {
                rightIndicatorId.isOn = false
                leftIndicatorId.isOn = false
            }
        }

        Row {
            id: dashboardRowId
            anchors.top: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

           //it is the speedometer arcCircle
            SpeedmeterStyle {
                id: speedometerId
            }
        }

           // Distance Digit in KM
        Rectangle {
            id: speedrect
            height: dashboardId.height * 0.05
            width: dashboardId.width * 0.1
            color: "transparent"
            radius: height * 0.2

            anchors.right: parent.right
            anchors.rightMargin: 250
            anchors.top: dashboardRowId.bottom

            Text {
                id: speedrectText
                text: EngineConfigCPP.getDistance + " km"
                font.pointSize: 25
                color: "white"
                font.bold: true

            }
        }

        // It is the code of EventHandler like for speed you have to press upKey
        Loader {
            id: centralPanelLoader
            anchors.centerIn: parent
            width: parent.width
        }
    }
}
