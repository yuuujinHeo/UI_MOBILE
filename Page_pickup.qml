import QtQuick 2.12
import QtQuick.Controls 2.12
import "."
import io.qt.Supervisor 1.0
import QtMultimedia 5.12

Item {
    id: page_pickup
    objectName: "page_pickup"
    width: 1280
    height: 800

    property string pos: "1번"
    property bool pickup_1: false
    property bool pickup_2: false
    property bool pickup_3: false

    function init(){
        pickup_1 = false;
        pickup_2 = false;
        pickup_3 = false;
        text_mention.visible = true;
        text_mention3.visible = true;
        target_pos.visible = true;
        btn_confirm.visible = true;
        voice_pickup.play();
        text_hello.visible = false;
        timer_hello.stop();
    }

    Rectangle{
        id: rect_background
        anchors.fill: parent
        color: "#282828"
    }
    Image{
        id: image_robot
        source: "image/robot_pickup.png"
        width: 221
        height: 452
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 200
    }
    Rectangle{
        id: rect_tray_1
        color: pickup_1?"#12d27c":"#525252"
        width: 187
        height: 50
        anchors.top: parent.top
        anchors.topMargin: 339
        anchors.horizontalCenter: image_robot.horizontalCenter
        Text{
            anchors.centerIn: parent
            color:"white"
            text:"1"
            font.family: font_noto_r.name
            font.pixelSize: 15
        }
    }
    Rectangle{
        id: rect_tray_2
        color: pickup_2?"#12d27c":"#525252"
        width: 187
        height: 50
        anchors.top: rect_tray_1.bottom
        anchors.topMargin: 45
        anchors.horizontalCenter: image_robot.horizontalCenter
        Text{
            anchors.centerIn: parent
            color:"white"
            text:"2"
            font.family: font_noto_r.name
            font.pixelSize: 15
        }
    }
    Rectangle{
        id: rect_tray_3
        color: pickup_3?"#12d27c":"#525252"
        width: 187
        height: 50
        anchors.top: rect_tray_2.bottom
        anchors.topMargin: 43
        anchors.horizontalCenter: image_robot.horizontalCenter
        Text{
            anchors.centerIn: parent
            color:"white"
            text:"3"
            font.family: font_noto_r.name
            font.pixelSize: 15
        }
    }

    Column{
        id: column_pickup
        anchors.left: image_robot.right
        anchors.leftMargin: 100
        anchors.verticalCenter: image_robot.verticalCenter
        Text{
            id: target_pos
            text: pos + " 트레이 <font color=\"white\">의</font>"
            font.pixelSize: 50
            font.bold: true
            font.family: font_noto_b.name
            color: "#12d27c"
        }
        Text{
            id: text_mention
            text: "제품을 수령해주세요."
            font.pixelSize: 50
            font.family: font_noto_b.name
            color: "white"
        }
        Rectangle{
            color:"transparent"
            width: parent.width
            height: 30
        }
        Text{
            id: text_mention3
            text: "수령 후 아래 <font color=\"#12d27c\">확인버튼</font>을 눌러주세요."
            font.pixelSize: 35
            font.family: font_noto_b.name
            color: "white"
        }
        Rectangle{
            color:"transparent"
            width: parent.width
            height: 20
        }
        Image{
            id: btn_confirm
            source:"icon/btn_confirm.png"
            anchors.horizontalCenter: parent.horizontalCenter
            width: 250
            height: 90
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log("UI : CONFIRM");
                    text_mention.visible = false;
                    text_mention3.visible = false;
                    target_pos.visible = false;
                    btn_confirm.visible = false;
                    text_hello.visible = true;
                    timer_hello.start();
                }
            }
        }
    }


    Text{
        id: text_hello
        text:"감사합니다."
        visible: false
        font.pixelSize: 50
        font.family: font_noto_b.name
        color: "white"
        anchors.left: image_robot.right
        anchors.leftMargin: 100
        anchors.verticalCenter: image_robot.verticalCenter
    }
    Audio{
        id: voice_pickup
        autoPlay: false
        source: "bgm/voice_pickup.mp3"
    }

    Timer{
        id: timer_hello
        interval: 3000
        running: false
        repeat: false
        onTriggered: {
            supervisor.confirmPickup();
            console.log("UI : MOVE NEXT");
        }
    }
}
