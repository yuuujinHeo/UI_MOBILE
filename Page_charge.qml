import QtQuick 2.12
import QtQuick.Controls 2.12
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
    onBatteryChanged: {
        if(battery == 100){
            timer_bat.stop();
            text_mention.text = "충전이 완료되었습니다."
            image_battery.source = "qrc:/icon/bat_full.png";
        }
    }

    Component.onCompleted: {
        init();
    }

    function init(){
        text_mention.text = "충전 중 입니다."
        image_battery.source = "qrc:/icon/bat_1.png";
        timer_bat.start();
    }

    Rectangle{
        id: rect_background
        anchors.fill: parent
        color: "#282828"
    }
    Image{
        id: image_battery
        source: "icon/bat_1.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 250
    }
    Text{
        id: text_bat
        text: battery + " %"
        font.pixelSize: 50
        color: "white"
        font.family: font_noto_b.name
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top : image_battery.bottom
        anchors.topMargin: 20
    }

    Timer{
        repeat: true
        interval: 500
        running: true
        onTriggered: {
            print("charge timer");
        }
    }
    Text{
        id: text_mention
        text: "충전 중 입니다."
        font.pixelSize: 50
        color: "white"
        font.family: font_noto_b.name
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top : text_bat.bottom
        anchors.topMargin: 30
    }
    Timer{
        id: timer_bat
        running: true
        interval: 1000
        repeat: true
        onTriggered: {
            if(image_battery.source == "qrc:/icon/bat_1.png"){
                image_battery.source = "qrc:/icon/bat_2.png";
            }else if(image_battery.source == "qrc:/icon/bat_2.png"){
                image_battery.source = "qrc:/icon/bat_3.png";
            }else if(image_battery.source == "qrc:/icon/bat_3.png"){
                image_battery.source = "qrc:/icon/bat_full.png";
            }else{
                image_battery.source = "qrc:/icon/bat_1.png";
            }
        }
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            timer_bat.stop();
            popup_question.visible = true;
        }
    }

    Item{
        id: popup_question
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "#282828"
            opacity: 0.8
        }
        Image{
            id: image_location
            source:"image/image_location.png"
            width: 160
            height: 160
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 200
        }
        Text{
            id: text_quest
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:image_location.bottom
            anchors.topMargin: 30
            font.family: font_noto_b.name
            font.pixelSize: 40
            color: "#12d27c"
            text: "대기 장소로 이동<font color=\"white\">하시겠습니까?</font>"
        }
        Rectangle{
            id: btn_no
            width: 250
            height: 90
            radius: 20
            color: "#d0d0d0"
            anchors.top: text_quest.bottom
            anchors.topMargin: 50
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 20
            Image{
                id: image_no
                source: "icon/btn_no.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
            }
            Text{
                id:text_nono
                text:"아니오"
                font.family: font_noto_b.name
                font.pixelSize: 30
                color:"#282828"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: image_no.right
                anchors.leftMargin : (parent.width - image_no.x - image_no.width)/2 - text_nono.width/2
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    timer_bat.start();
                    popup_question.visible = false;
                }
            }
        }
        Rectangle{
            id: btn_yes
            width: 250
            height: 90
            radius: 20
            color: "#d0d0d0"
            anchors.top: text_quest.bottom
            anchors.topMargin: 50
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 20
            Rectangle{
                color:"white"
                width: 240
                height: 80
                radius: 19
                anchors.centerIn: parent
            }
            Image{
                id: image_yes
                source: "icon/btn_yes.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
            }
            Text{
                text:"네"
                font.family: font_noto_b.name
                font.pixelSize: 30
                color:"#282828"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: image_yes.right
                anchors.leftMargin : (parent.width - image_yes.x - image_yes.width)/2 - width/2
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    supervisor.moveToWait();
                    popup_question.visible = false;
                }
            }
        }
    }

}
