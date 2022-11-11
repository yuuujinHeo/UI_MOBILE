import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
//import QtQuick.Shapes 1.
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0
//import QtQuick.Templates 2.5
import "."
import io.qt.Supervisor 1.0
Item {
    id: page_charge
    objectName: "page_charge"
    width: 1280
    height: 800

    property double battery: 0
    property string robotName: "test"
    property date curDate: new Date()
    property string curTime: curDate.toLocaleTimeString()

    Text{
        id: text_mention
        text: "충전 중 입니다."
        font.pixelSize: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top : parent.top
        anchors.topMargin: 200
    }
    Rectangle{
        id: rect_moving
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: text_mention.bottom
        anchors.topMargin: 40
        width: ani_moving.width;
        height: ani_moving.height;
        AnimatedImage{
            id: ani_moving
            source: Qt.resolvedUrl("qrc:/image/robot_charging.gif")
            width: 350;
            height: 350;
        }
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            popup_start.visible = true;
        }
    }

    Rectangle{
        id: status_bar
        width: parent.width
        height: 50
        anchors.left: parent.left
        color: "gray"
        Text{
            id: textName
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            text: robotName

        }
        Text{
            id: textTime
            anchors.centerIn: parent
            anchors.leftMargin: 20
            text: curTime

        }
        Text{
            id: textBattery
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            text: battery.toFixed(1)+' V'
        }
    }

    Rectangle{
        id: popup_start
        width: 400
        height: 300
        visible: false
        anchors.centerIn: parent
        color: "gray"
        opacity: 0.6
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text: "DO START?"
            anchors.top: parent.top
            anchors.topMargin: 50
        }
        Rectangle{
            id: rect_ok
            width: 100
            height: 100
            radius: 10
            color: "yellow"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 30
            Text{
                anchors.centerIn: parent
                text: "ok"
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    popup_start.visible = false
                    supervisor.moveToWait();
                }
            }
        }
        Rectangle{
            id: rect_cancel
            width: 100
            height: 100
            radius: 10
            color: "yellow"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 30
            Text{
                anchors.centerIn: parent
                text: "cancel"
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    popup_start.visible = false;
                }
            }
        }
    }


}
