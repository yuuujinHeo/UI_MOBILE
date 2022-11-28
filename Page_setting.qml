import QtQuick 2.9
import QtQuick.Window 2.9
import QtQuick.Controls 2.9

Item {
    id: page_setting
    objectName: "page_setting"
    width: 1280
    height: 800

    Rectangle{
        width: 100
        height: 100
        color: "gray"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                stackview.pop();
            }
        }
    }
    property var rect_height: 70
    property string platform_name: supervisor.getRobotName()
    property string debug_platform_name: ""
    property bool is_debug: false

    function uiupdate(){
        platform_name = supervisor.getRobotName();
        print(platform_name);
        slider_vxy.value = supervisor.getVelocityXY();
        slider_vth.value = supervisor.getVelocityTH();
    }

    Column{
        y: 200
        width: parent.width
        height: parent.height - y - 100
        spacing:25

        Rectangle{
            width: parent.width
            height: rect_height
            color: "yellow"
            Text{
                anchors.left: parent.left
                anchors.leftMargin: 250
                font.pixelSize: 30
                anchors.verticalCenter: parent.verticalCenter
                text: "platform Name : "
            }
            Text{
                anchors.right: parent.right
                anchors.rightMargin: 400
                font.pixelSize: 30
                anchors.verticalCenter: parent.verticalCenter
                text: platform_name
            }
            Rectangle{
                width: rect_height
                height: rect_height
                anchors.right: parent.right
                anchors.rightMargin: 100
                color: "gray"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        print("change name");
                        popup_name.visible = true
                    }
                }
            }
        }
        Rectangle{
            width: parent.width
            height: rect_height
            color: "yellow"
            Text{
                anchors.left: parent.left
                anchors.leftMargin: 250
                font.pixelSize: 30
                anchors.verticalCenter: parent.verticalCenter
                text: "velocity x,y : "
            }
            Slider{
                id: slider_vxy
                anchors.right: parent.right
                anchors.rightMargin: 200
                width: 300
                height: 50
                from: 0
                to: 1
                value: supervisor.getVelocityXY()
            }
        }
        Rectangle{
            width: parent.width
            height: rect_height
            color: "yellow"
            Text{
                anchors.left: parent.left
                anchors.leftMargin: 250
                font.pixelSize: 30
                anchors.verticalCenter: parent.verticalCenter
                text: "velocity rot : "
            }
            Slider{
                id: slider_vth
                anchors.right: parent.right
                anchors.rightMargin: 200
                width: 300
                height: 50
                from: 0
                to: 1
                value: supervisor.getVelocityTH()
            }
        }
        Rectangle{
            width: parent.width
            height: rect_height
            color: "yellow"
            Text{
                id: text_dd
                anchors.left: parent.left
                anchors.leftMargin: 250
                font.pixelSize: 30
                anchors.verticalCenter: parent.verticalCenter
                text: "Debug : " + debug_platform_name
            }
            Rectangle{
                width: rect_height
                height: rect_height
                anchors.left: text_dd.right
                anchors.leftMargin: 200
                color: is_debug?"blue":"gray"
                Text{
                    anchors.centerIn: parent
                    text: is_debug?"OFF":"ON"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        is_debug = !is_debug;
                        debug_platform_name = textfield_debug.text
                    }
                }
            }
            TextField{
                id: textfield_debug
                width: 100
                height: rect_height
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 200
                placeholderText: "(debug name)"
                text: "C1"
                font.pointSize: 20

            }
        }
    }

    Timer{
        running: true
        interval: 1000
        repeat: true
        onTriggered: {
            if(is_debug != supervisor.getDebugState()){
                supervisor.setDebugState(is_debug);
            }
            if(debug_platform_name != supervisor.getDebugName()){
                supervisor.setDebugName(debug_platform_name);
            }
        }
    }


    Rectangle{
        id: rect_confirm
        width: 100
        height: 80
        color: "gray"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: 50
        Text{
            anchors.centerIn: parent
            font.pixelSize: 30
            text: "confirm"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                supervisor.setVelocity(slider_vxy.value, slider_vth.value)
            }
        }
    }
    Rectangle{
        id: rect_default
        width: 100
        height: 80
        color: "gray"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: 50
        Text{
            anchors.centerIn: parent
            font.pixelSize: 30
            text: "default"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                uiupdate();
            }
        }
    }

    Rectangle{
        id: popup_name
        width: 500
        height: 300
        color: "gray"
        visible: false
        anchors.centerIn: parent

        TextField{
            id: textfield_name
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
            width: 200
            height: 100
            placeholderText: qsTr(platform_name)
            font.pointSize: 20
        }
        Rectangle{
            width: 50
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: textfield_name.bottom
            anchors.topMargin: 50
            Text{
                anchors.centerIn: parent
                text:"confirm"
            }

            MouseArea{
                anchors.fill:parent
                onClicked:{
                    supervisor.setRobotName(textfield_name.text);
                    uiupdate();
                    popup_name.visible = false;
                }
            }
        }
        Rectangle{
            width: 50
            height: 50
            anchors.right: parent.right
            anchors.rightMargin: 100
            anchors.top: textfield_name.bottom
            anchors.topMargin: 50
            Text{
                anchors.centerIn: parent
                text:"cancel"
            }

            MouseArea{
                anchors.fill:parent
                onClicked:{
                    uiupdate();
                    textfield_name.text = supervisor.getRobotName();
                    popup_name.visible = false;
                }
            }
        }
    }










}
