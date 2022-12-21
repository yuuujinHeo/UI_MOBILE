import QtQuick 2.12

Item {
    id: item_keyboard
    objectName: "item_keyboard"

    property string color_default: "#383838"
    property string color_pushed: "#9F9F9F"

    property int btn_size: 50
    property int btn_dist: 5

    property bool pressed_up: false
    property bool pressed_down: false
    property bool pressed_left: false
    property bool pressed_right: false

    Rectangle{
        id: btn_up
        width: btn_size
        height: btn_size
        radius: btn_size/10
        color: pressed_up?color_pushed:color_default
        border.color: "#D0D0D0"
        border.width: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        Image{
            source: "icon/joy_up.png"
            width: 13
            height: 8
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onPressed: {
                pressed_up = true;
            }
            onReleased: {
                pressed_up = false;
            }
        }
    }
    Rectangle{
        id: btn_down
        width: btn_size
        height: btn_size
        radius: btn_size/10
        color: pressed_down?color_pushed:color_default
        border.color: "#D0D0D0"
        border.width: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: btn_dist
        anchors.top: btn_up.bottom
        Image{
            source: "icon/joy_down.png"
            width: 13
            height: 8
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onPressed: {
                pressed_down = true;
            }
            onReleased: {
                pressed_down = false;
            }
        }
    }
    Rectangle{
        id: btn_left
        width: btn_size
        height: btn_size
        radius: btn_size/10
        color: pressed_left?color_pushed:color_default
        border.color: "#D0D0D0"
        border.width: 3
        anchors.right: btn_down.left
        anchors.rightMargin: btn_dist
        anchors.top: btn_up.bottom
        anchors.topMargin: btn_dist
        Image{
            source: "icon/joy_left.png"
            width: 8
            height: 13
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onPressed: {
                pressed_left = true;
            }
            onReleased: {
                pressed_left = false;
            }
        }
    }
    Rectangle{
        id: btn_right
        width: btn_size
        height: btn_size
        radius: btn_size/10
        color: pressed_right?color_pushed:color_default
        border.color: "#D0D0D0"
        border.width: 3
        anchors.left: btn_down.right
        anchors.leftMargin: btn_dist
        anchors.top: btn_up.bottom
        anchors.topMargin: btn_dist
        Image{
            source: "icon/joy_right.png"
            width: 8
            height: 13
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onPressed: {
                pressed_right = true;
            }
            onReleased: {
                pressed_right = false;
            }
        }
    }
}
