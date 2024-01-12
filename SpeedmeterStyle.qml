import QtQuick 2.0

Item {
    id: id_root
    property int value: 0

    Rectangle {
        id: id_speed

        property int numberIndexs: 15
        property int startAngle: 234
        property int angleLength: 18
        property int maxSpeed: 280

        anchors.centerIn: parent
        height: Math.min(300, 300)
        width: height
        radius: width/2

        color: dashboardId.color
        border.color: "#7077A1"
        border.width: id_speed.height * 0.01

        Canvas {
            id:canvas
            anchors.fill: parent
            contextType: "2d"
            rotation: 145
            antialiasing: true

            onPaint: {
                var context = canvas.getContext('2d');
                context.strokeStyle = "white";
                context.lineWidth = id_speed.height * 0.05 / 4;
                context.beginPath();
                context.arc(id_speed.height / 2, id_speed.height / 2, id_speed.height / 2 - id_speed.height * 0.05, 0, Math.PI * 1.1, false);
                context.stroke();

                context.strokeStyle = "red";
                context.lineWidth = id_speed.height * 0.05 / 4;
                context.beginPath();
                context.arc(id_speed.height / 2, id_speed.height / 2, id_speed.height / 2 - id_speed.height * 0.05, Math.PI * 1.1, Math.PI * 1.4, false);
                context.stroke();
            }
        }
                Repeater {
                    model: id_speed.numberIndexs

                    Item {
                        height: id_speed.height/2
                        transformOrigin: Item.Bottom
                        rotation: index * id_speed.angleLength + id_speed.startAngle
                        x: id_speed.width/2

                        Rectangle {
                            height: id_speed.height * 0.05
                            width: height / 4
                            color: "white"
                            antialiasing: true
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: id_speed.height * 0.03
                        }

                        Text {
                            anchors {
                                horizontalCenter: parent.horizontalCenter
                            }
                            x: 0
                            y: id_speed.height * 0.09
                            color: "white"
                            rotation: 360 - (index * id_speed.angleLength + id_speed.startAngle)
                            text: index * (id_speed.maxSpeed / (id_speed.numberIndexs - 1))
                            font.pixelSize: id_speed.height * 0.05
                            font.family: "Comic Sans MS"
                        }
                    }
                }
            }

            Rectangle {
                id: id_center

                anchors.centerIn: parent
                height: id_speed.height*0.4
                width: height
                radius: width/2
                color: "#7077A1"
                z:2
            }
            Text {
                id: speedTextId
                color: "#ffffff"
                font.pixelSize: 25
                horizontalAlignment: Text.AlignRight
                text: id_speedNeedle.value.toString()
                anchors.centerIn: parent
                z:2
                font.bold : true

            }
            Text {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: id_speed.verticalCenter
                    topMargin: id_speed.height * 0.2
                }
                text: "km/h"
                color: "white"

                font.pixelSize: id_speed.height * 0.1
                font.bold : true
            }

            SpeedNeedle {
                id: id_speedNeedle
                value: EngineConfigCPP.getSpeed

                startAngle: id_speed.startAngle
                angleLength: id_speed.angleLength / (id_speed.maxSpeed / (id_speed.numberIndexs - 1))
                anchors {
                    top: id_speed.top
                    bottom: id_speed.bottom
                    horizontalCenter: parent.horizontalCenter
                }

            }

    }

