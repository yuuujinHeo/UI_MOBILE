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
