import QtQuick 2.0


Item {
    id: item_jog
    objectName: "item_jog"
    width: joystick.width
    height: joystick.height

    property real angle : 0//mousearea.angle
    property real distance : 0

    property bool pressed: mousearea.pressed
    property int update_cnt: 0

    property bool verticalOnly : false
    property bool horizontalOnly : false
    property real mouseX2 : verticalOnly ? width * 0.5 : mousearea.mouseX
    property real mouseY2 : horizontalOnly ? height * 0.5 : mousearea.mouseY
    property real fingerAngle : Math.atan2(mouseX2, mouseY2)
    property int mcx : mouseX2 - width * 0.5
    property int mcy : mouseY2 - height * 0.5
    property bool fingerInBounds : fingerDistance2 < distanceBound2
    property real fingerDistance2 : mcx * mcx + mcy * mcy
    property real distanceBound : width * 0.5 - thumb.width * 0.5
    property real distanceBound2 : distanceBound * distanceBound
    property double signal_x : (mouseX2 - joystick.width/2) / distanceBound
    property double signal_y : -(mouseY2 - joystick.height/2) / distanceBound

    Image {
        id: joystick
        x: 0
        y: 0
        source: "icon/joystick_back.png"
    }
    ParallelAnimation {
        id: returnAnimation
        NumberAnimation { target: thumb.anchors; property: "horizontalCenterOffset";
            to: 0; duration: 200; easing.type: Easing.OutSine }
        NumberAnimation { target: thumb.anchors; property: "verticalCenterOffset";
            to: 0; duration: 200; easing.type: Easing.OutSine }
    }
    function remote_input(re_x, re_y){
        returnAnimation.stop();
        update_cnt++;
        if(verticalOnly){
            mcy = (width/2)*re_x/32767;
            mcx = 0;
        }else if(horizontalOnly){
            mcx = (width/2)*re_y/32767;
            mcy = 0;
        }
        if (fingerInBounds) {
            thumb.anchors.horizontalCenterOffset = mcx
            thumb.anchors.verticalCenterOffset = mcy
        } else {
            angle = Math.atan2(mcy, mcx)
            thumb.anchors.horizontalCenterOffset = Math.cos(angle) * distanceBound
            thumb.anchors.verticalCenterOffset = Math.sin(angle) * distanceBound
        }
    }
    function remote_stop(){
        mcx = 0
        mcy = 0
        update_cnt = 0;
        returnAnimation.restart();
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        property var angle: 0
        onPressed: {
            returnAnimation.stop();
        }
        onReleased: {
            update_cnt = 0;
            parent.pressed = false;
            returnAnimation.restart()
        }
        onPositionChanged: {
            update_cnt++;
            mcx =mouseX2 - width * 0.5
            mcy =mouseY2 - height * 0.5
            if (fingerInBounds) {
                thumb.anchors.horizontalCenterOffset = mcx
                thumb.anchors.verticalCenterOffset = mcy
            } else {
                angle = Math.atan2(mcy, mcx)
                thumb.anchors.horizontalCenterOffset = Math.cos(angle) * distanceBound
                thumb.anchors.verticalCenterOffset = Math.sin(angle) * distanceBound
            }

            // Fire the signal to indicate the joystick has moved
            angle = Math.atan2(signal_y, signal_x)
        }
    }

    Image {
        id: thumb
        source: "icon/joystick_thumb.png"
        anchors.centerIn: parent
    }
}
