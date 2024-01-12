import QtQuick 2.0

Item {
    property int direction: Qt.LeftArrow
    scale: direction === Qt.LeftArrow ? 1 : -1

    property bool isOn: false
    property bool blinking: false

    Timer {
        id: indicatorTimeId
        interval: 10000
        running: isOn
        repeat: false
        onTriggered: isOn = true
    }

    // every 500 milliseconds, arrow will blink
    Timer {
        id: blinkingTimerId
        interval: 500
        running: isOn
        repeat: true
        onTriggered: blinking = !blinking
    }

    // drawing the outer line of the arrow
    function drawArrow(ctr) {
        ctr.beginPath()
        ctr.moveTo(0, height * 0.5)
        ctr.lineTo(0.6 * width, 0)
        ctr.lineTo(0.6 * width, 0.28 * height)
        ctr.lineTo(width, 0.28 * height)
        ctr.lineTo(width, 0.72 * height)
        ctr.lineTo(0.6 * width, 0.72 * height)
        ctr.lineTo(0.6 * width, height)
        ctr.lineTo(0, height * 0.5)
    }

    // creates and renders a white arrow on the canvas
    Canvas {
        id: backgroundId
        anchors.fill: parent

        onPaint: {
            var ctr = getContext("2d")
            ctr.reset()

            drawArrow(ctr)
            ctr.lineWidth = 1
            ctr.strokeStyle = "white"
            ctr.stroke()
        }
    }

    // blinking the arrow with yellow-green
    Canvas {
        id: foregroundId
        anchors.fill: parent
        visible: isOn && blinking

        onPaint: {
            var ctr = getContext("2d")
            ctr.reset()

            drawArrow(ctr)
            ctr.fillStyle = "yellowgreen"
            ctr.fill()
        }
    }
}
