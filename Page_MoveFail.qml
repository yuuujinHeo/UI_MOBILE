import QtQuick 2.12
import QtQuick.Controls 2.12
import "."
import io.qt.Supervisor 1.0

Item {
    id: page_movefail
    objectName: "page_movefail"
    width: 1280
    height: 800
    property bool joystick_connection: false
    property var joy_axis_left_ud: 0
    property var joy_axis_right_rl: 0

    function init(){
        statusbar.visible = true;
        notice.y = 0;
        area_swipe.enabled = true;
    }

    function loadmap(path){
//        map.loadmap_mini();
    }

    SequentialAnimation{
        id: ani_swipe
        running: true;
        loops: Animation.Infinite
        ParallelAnimation{
            NumberAnimation{target: image_swipe; property: "opacity"; to:1; duration: 1000; easing.type: Easing.OutCubic}
            NumberAnimation{target: image_swipe; property: "anchors.bottomMargin"; to:80; from: 40; duration: 1000; easing.type: Easing.OutCubic}
        }
        ParallelAnimation{
            NumberAnimation{target: image_swipe; property: "opacity"; to:0.2; duration: 600; easing.type: Easing.OutCubic}
            NumberAnimation{target: image_swipe; property: "anchors.bottomMargin"; to:40; duration: 600; easing.type: Easing.OutCubic}
        }
    }


    Item{
        id: manual
        width: 1280
        height: 800
        anchors.top: notice.bottom

        Rectangle{
            anchors.fill: parent
            color:"#282828"
        }
        Map_full{
            id: map
            width: 500
            height: 500
            anchors.top: parent.top
            anchors.topMargin: statusbar.height + 30
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Image{
            id: image_joy_up
            source: "icon/joy_up.png"
            width: 13
            height: 8
            anchors.horizontalCenter: joy_xy.horizontalCenter
            anchors.bottom: joy_xy.top
            anchors.bottomMargin: 8
        }
        Image{
            id: image_joy_down
            source: "icon/joy_down.png"
            width: 13
            height: 8
            anchors.horizontalCenter: joy_xy.horizontalCenter
            anchors.top: joy_xy.bottom
            anchors.topMargin: 8
        }
        Image{
            id: image_joy_left
            source: "icon/joy_left.png"
            width: 8
            height: 13
            anchors.verticalCenter: joy_th.verticalCenter
            anchors.right: joy_th.left
            anchors.rightMargin: 8
        }
        Image{
            id: image_joy_right
            source: "icon/joy_right.png"
            width: 8
            height: 13
            anchors.verticalCenter: joy_th.verticalCenter
            anchors.left: joy_th.right
            anchors.leftMargin: 8
        }
        Item_joystick{
            id: joy_xy
            anchors.right: map.left
            anchors.rightMargin: 80
            anchors.verticalCenter: parent.verticalCenter
            verticalOnly: true
            onUpdate_cntChanged: {
                if(update_cnt == 0 && angle != 0){
                    supervisor.joyMoveXY(0, 0);
                }else{
                    if(fingerInBounds) {
                        supervisor.joyMoveXY(Math.sin(angle) * Math.sqrt(fingerDistance2) / distanceBound);
                    }else{
                        supervisor.joyMoveXY(Math.sin(angle));
                    }
                }
            }
        }

        Item_joystick{
            id: joy_th
            anchors.left: map.right
            anchors.leftMargin: 80
            anchors.verticalCenter: parent.verticalCenter
            horizontalOnly: true
            onUpdate_cntChanged: {
                if(update_cnt == 0 && angle != 0){
                    supervisor.joyMoveR(0, 0);
                }else{
                    if(fingerInBounds) {
                        supervisor.joyMoveR(-Math.cos(angle) * Math.sqrt(fingerDistance2) / distanceBound);
                    } else {
                        supervisor.joyMoveR(-Math.cos(angle));
                    }
                }
            }
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: map.bottom
            anchors.topMargin: 50
            spacing: 40

            Rectangle{
                id: btn_stop
                width: 250
                height: 90
                radius: 10
                color: "#d0d0d0"
                Row{
                    spacing: 10
                    anchors.centerIn: parent
                    Image{
                        source:"icon/icon_cancelpath.png"
                        width: 46
                        anchors.verticalCenter: parent.verticalCenter
                        height: 40
                    }
                    Text{
                        text: "경로 취소"
                        font.family: font_noto_b.name
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 30
                        color:"#282828"
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        supervisor.moveStop();
                    }
                }
            }
            Rectangle{
                id: btn_resume
                width: 250
                height: 90
                radius: 10
                color: "#d0d0d0"
                Row{
                    spacing: 10
                    anchors.centerIn: parent
                    Image{
                        source:"icon/icon_researching.png"
                        width: 37
                        anchors.verticalCenter: parent.verticalCenter
                        height: 35
                    }
                    Text{
                        text: "경로 재탐색"
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: font_noto_b.name
                        font.pixelSize: 30
                        font.bold: true
                        color:"#282828"
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        timer_check_pause.start();
                    }
                }
            }
            Rectangle{
                id: btn_manual
                width: 250
                height: 90
                radius: 10
                color: "#d0d0d0"
                Row{
                    spacing: 10
                    anchors.centerIn: parent
                    Image{
                        anchors.verticalCenter: parent.verticalCenter
                        source:"icon/icon_manualmove.png"
                        width: 35
                        height: 40
                    }
                    Text{
                        text: "수동 제어"
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: font_noto_b.name
                        font.pixelSize: 30
                        font.bold: true
                        color:"#282828"
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        supervisor.moveManual();
                    }
                }
            }

        }

    }

    Item{
        id: notice
        width: 1280
        height: 800
        Behavior on y{
            NumberAnimation{
                duration: 500;
                easing.type: Easing.OutCubic
            }
        }

        Rectangle{
            anchors.fill: parent
            color:"#282828"
        }
        Image{
            id: icon_warn
            source: "icon/icon_warning.png"
            width: 130
            height: 130
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 200
        }

        Text{
            id: text
            text:"목적지로 이동하는데 실패하였습니다.\n주변에 방해되는 요소를 제거하거나 로봇을 수동으로 이동시켜주세요."
            anchors.top: icon_warn.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: font_noto_b.name
            font.pixelSize: 40
            color: "white"
        }
        Image{
            id: image_swipe
            source: "icon/joy_up.png"
            width: 60
            height: 40
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text{
            text: "위로 올리시면 메뉴가 나옵니다."
            font.family: font_noto_r.name
            color: "#e8e8e8"
            opacity: image_swipe.opacity
            anchors.verticalCenter: image_swipe.verticalCenter
            anchors.left: image_swipe.right
            anchors.leftMargin: 10
        }
    }
    MouseArea{
        id: area_swipe
        anchors.fill: parent
        property var firstX;
        property var firstY;
        onPressed: {
            firstX = mouseX;
            firstY = mouseY;
        }
        onReleased: {
            if(firstY - mouseY > 100){
                notice.y = -800;
                area_swipe.enabled = false;
                timer_get_joy.start();
            }else{
                notice.y = 0;
            }
        }

        onPositionChanged: {
            if(firstY - mouseY > 0){
                notice.y =  mouseY - firstY;
            }
        }
    }

    Timer{
        id: timer_check_pause
        interval: 500
        running: false
        repeat: true
        onTriggered: {
            if(supervisor.getRobotState() == 4){
                supervisor.moveResume();
            }else{
                backPage();
                loader_page.item.checkPaused();
                timer_check_pause.stop();
            }
        }
    }

    Timer{
        id: timer_get_joy
        interval: 100
        running: false
        repeat: true
        onTriggered: {
            joystick_connection = supervisor.isconnectJoy();
            if(joystick_connection){
                print(supervisor.getJoyAxis(1),supervisor.getJoyAxis(2))
                if(joy_axis_left_ud == supervisor.getJoyAxis(1) && joy_axis_right_rl == supervisor.getJoyAxis(2)){

                }else{
                    joy_axis_left_ud = supervisor.getJoyAxis(1);
                    joy_axis_right_rl = supervisor.getJoyAxis(2);
                    if(joy_axis_left_ud != 0){
                        joy_xy.remote_input(joy_axis_left_ud,0);
                    }else{
                        joy_xy.remote_stop();
                    }

                    if(joy_axis_right_rl != 0){
                        joy_th.remote_input(0,joy_axis_right_rl);
                    }else{
                        joy_th.remote_stop();
                    }
                }
            }else{
                joy_axis_left_ud = 0;
                joy_axis_right_rl = 0;
                joy_xy.remote_stop();
                joy_th.remote_stop();
            }
        }
    }
}
