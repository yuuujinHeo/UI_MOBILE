import QtQuick 2.0


Item {
    id: item_jog
    objectName: "item_jog"
    width: joystick_xy.width*2 + 30
    height: joystick_xy.height


    Image {
        id: joystick_xy
        x: 0
        y: 0
        property real angle : 0
        property real distance : 0

        source: "qrc:/image/joy_background.png"
//        anchors.centerIn: parent

        ParallelAnimation {
            id: returnAnimation_xy
            NumberAnimation { target: thumb_xy.anchors; property: "horizontalCenterOffset";
                to: 0; duration: 200; easing.type: Easing.OutSine }
            NumberAnimation { target: thumb_xy.anchors; property: "verticalCenterOffset";
                to: 0; duration: 200; easing.type: Easing.OutSine }
        }

        MouseArea {
            id: mouse_xy
            property bool verticalOnly : true
            property bool horizontalOnly : false
            property real mouseX2 : verticalOnly ? width * 0.5 : mouseX
            property real mouseY2 : horizontalOnly ? height * 0.5 : mouseY
            property real fingerAngle : Math.atan2(mouseX2, mouseY2)
            property int mcx : mouseX2 - width * 0.5
            property int mcy : mouseY2 - height * 0.5
            property bool fingerInBounds : fingerDistance2 < distanceBound2
            property real fingerDistance2 : mcx * mcx + mcy * mcy
            property real distanceBound : width * 0.5 - thumb_xy.width * 0.5
            property real distanceBound2 : distanceBound * distanceBound

            property double signal_x : (mouseX2 - joystick_xy.width/2) / distanceBound
            property double signal_y : -(mouseY2 - joystick_xy.height/2) / distanceBound

            anchors.fill: parent

            onPressed: {
                returnAnimation_xy.stop();
            }

            onReleased: {
                returnAnimation_xy.restart()
                supervisor.joyMoveXY(0, 0);
            }

            onPositionChanged: {
                if (fingerInBounds) {
                    thumb_xy.anchors.horizontalCenterOffset = mcx
                    thumb_xy.anchors.verticalCenterOffset = mcy
                } else {
                    var angle = Math.atan2(mcy, mcx)
                    thumb_xy.anchors.horizontalCenterOffset = Math.cos(angle) * distanceBound
                    thumb_xy.anchors.verticalCenterOffset = Math.sin(angle) * distanceBound
                }

                // Fire the signal to indicate the joystick has moved
                angle = Math.atan2(signal_y, signal_x)

                if(fingerInBounds) {
                    supervisor.joyMoveXY(
                        horizontalOnly ? 0 : Math.sin(angle) * Math.sqrt(fingerDistance2) / distanceBound,
                        verticalOnly ? 0 : Math.cos(angle) * Math.sqrt(fingerDistance2) / distanceBound
                    );
                } else {
                    supervisor.joyMoveXY(
                        horizontalOnly ? 0 : Math.sin(angle) * 1,
                        verticalOnly ? 0 : Math.cos(angle) * 1
                    );
                }
            }
        }

        Image {
            id: thumb_xy
            source: "qrc:/image/joy_finger.png"
            anchors.centerIn: parent
        }
    }

    Image {
        id: joystick_r

        anchors.left: joystick_xy.right
        anchors.leftMargin: 30
        y: 0


        property real angle : 0
        property real distance : 0

        source: "qrc:/image/joy_background.png"
//        anchors.centerIn: parent

        ParallelAnimation {
            id: returnAnimation_r
            NumberAnimation { target: thumb_r.anchors; property: "horizontalCenterOffset";
                to: 0; duration: 200; easing.type: Easing.OutSine }
            NumberAnimation { target: thumb_r.anchors; property: "verticalCenterOffset";
                to: 0; duration: 200; easing.type: Easing.OutSine }
        }

        MouseArea {
            id: mouse_r
            property bool verticalOnly : false
            property bool horizontalOnly : true
            property real mouseX2 : verticalOnly ? width * 0.5 : mouseX
            property real mouseY2 : horizontalOnly ? height * 0.5 : mouseY
            property real fingerAngle : Math.atan2(mouseX2, mouseY2)
            property int mcx : mouseX2 - width * 0.5
            property int mcy : mouseY2 - height * 0.5
            property bool fingerInBounds : fingerDistance2 < distanceBound2
            property real fingerDistance2 : mcx * mcx + mcy * mcy
            property real distanceBound : width * 0.5 - thumb_r.width * 0.5
            property real distanceBound2 : distanceBound * distanceBound

            property double signal_x : (mouseX2 - joystick_r.width/2) / distanceBound
            property double signal_y : -(mouseY2 - joystick_r.height/2) / distanceBound

            anchors.fill: parent

            onPressed: {
                returnAnimation_r.stop();
            }

            onReleased: {
                returnAnimation_r.restart()
                supervisor.joyMoveR(0, 0);
            }

            onPositionChanged: {
                if (fingerInBounds) {
                    thumb_r.anchors.horizontalCenterOffset = mcx
                    thumb_r.anchors.verticalCenterOffset = mcy
                } else {
                    var angle = Math.atan2(mcy, mcx)
                    thumb_r.anchors.horizontalCenterOffset = Math.cos(angle) * distanceBound
                    thumb_r.anchors.verticalCenterOffset = Math.sin(angle) * distanceBound
                }

                // Fire the signal to indicate the joystick has moved
                angle = Math.atan2(signal_y, signal_x)

                if(fingerInBounds) {
                    supervisor.joyMoveR(
                        verticalOnly ? 0 : -Math.cos(angle) * Math.sqrt(fingerDistance2) / distanceBound,
                        horizontalOnly ? 0 : Math.sin(angle) * Math.sqrt(fingerDistance2) / distanceBound
                    );
                } else {
                    supervisor.joyMoveR(
                        verticalOnly ? 0 : -Math.cos(angle) * 1,
                        horizontalOnly ? 0 : Math.sin(angle) * 1
                    );
                }
            }
        }

        Image {
            id: thumb_r
            source: "qrc:/image/joy_finger.png"
            anchors.centerIn: parent
        }
    }

}
