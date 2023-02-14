import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0 as Platform
import QtQuick.Shapes 1.12
import QtGraphicalEffects 1.0
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

    Component.onCompleted: {
        init();
    }

    function init(){
        statusbar.visible = true;
        notice.y = 0;
        area_swipe.enabled = true;
        map.init_mode();
        map.show_buttons = true;
        map.show_connection = true;
        map.robot_following = true;
        map.show_lidar = true;
        map.show_path = true;
        map.show_object = true;
        map.show_robot = true;
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
        Rectangle{
            id: rect_menu
            width: 400
            height: parent.height - statusbar.height
            anchors.top: parent.top
            anchors.topMargin: statusbar.height
            color: "#f4f4f4"

            Rectangle{
                id: rect_box
                width: parent.width - 60
                height: 150
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 30
                color: "#e8e8e8"

                Row{
                    anchors.centerIn: parent
                    spacing: 30
                    Rectangle{
                        width: 90
                        height: 120
                        radius: 5
                        Rectangle{
                            id: btn_cancel
                            width: 90
                            height: 120
                            radius: 5
                            color:"white"
                            Column{
                                anchors.centerIn: parent
                                spacing: 20
                                Image{
                                    source: "icon/icon_cancelpath.png"
                                    sourceSize.width: 40
                                    sourceSize.height: 40
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "경로 취소"
                                    font.family: font_noto_r.name
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    supervisor.moveStop();
                                }
                            }
                        }
                        DropShadow{
                            anchors.fill: parent
                            radius: 10
                            color: "#dfdfdf"
                            source: btn_cancel
                        }

                    }
                    Rectangle{
                        width: 90
                        height: 120
                        radius: 5
                        Rectangle{
                            id: btn_research
                            width: 90
                            height: 120
                            radius: 5
                            Column{
                                anchors.centerIn: parent
                                spacing: 20
                                Image{
                                    source: "icon/icon_researching.png"
                                    sourceSize.width: 40
                                    sourceSize.height: 40
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "경로 재탐색"
                                    font.family: font_noto_r.name
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    supervisor.moveToLast();
                                }
                            }
                        }
                        DropShadow{
                            anchors.fill: parent
                            radius: 10
                            color: "#dfdfdf"
                            source: btn_research
                        }
                    }

                }
            }
            Rectangle{
                id: rect_annot_box2
                width: parent.width - 60
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_box.bottom
                anchors.topMargin: 30
                color: "transparent"
                Row{
                    anchors.centerIn: parent
                    spacing: 30
                    Rectangle{
                        width: 90
                        height: 90
                        radius: 90
                        Rectangle{
                            id: btn_manual
                            width: 90
                            height: 90
                            radius: 90
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    source: "icon/icon_manualmove.png"
                                    sourceSize.width: 30
                                    sourceSize.height: 30
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "수동 제어"
                                    font.family: font_noto_r.name
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    supervisor.moveStop();
                                }
                            }
                        }
                        DropShadow{
                            anchors.fill: parent
                            radius: 10
                            color: "#dfdfdf"
                            source: btn_manual
                        }
                    }
                    Rectangle{
                        width: 90
                        height: 90
                        radius: 90
                        Rectangle{
                            id: btn_auto
                            width: 90
                            height: 90
                            radius: 90
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    source: "icon/icon_auto_init.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "자동 초기화"
                                    font.family: font_noto_r.name
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    btn_auto.running = true;
                                    supervisor.slam_autoInit();
                                }
                            }
                        }
                        DropShadow{
                            anchors.fill: parent
                            radius: 10
                            color: "#dfdfdf"
                            source: btn_auto
                        }
                    }
                    Rectangle{
                        width: 90
                        height: 90
                        radius: 90
                        Rectangle{
                            id: btn_stop
                            width: 90
                            height: 90
                            radius: 90
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    source: "icon/icon_stop.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "정지"
                                    font.family: font_noto_r.name
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    supervisor.moveStop();
                                }
                            }
                        }
                        DropShadow{
                            anchors.fill: parent
                            radius: 10
                            color: "#dfdfdf"
                            source: btn_stop
                        }
                    }

                }
            }

            Rectangle{
                width: parent.width
                height: 400
                anchors.bottom: parent.bottom
                color: "#d0d0d0"

                Row{
                    id: fnke
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 50
                    Item_joystick{
                        id: joy_xy
                        verticalOnly: true
                        onUpdate_cntChanged: {
                            if(update_cnt == 0 && supervisor.getJoyXY() != 0){
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
                        horizontalOnly: true
                        onUpdate_cntChanged: {
                            if(update_cnt == 0 && supervisor.getJoyR() != 0){
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
                }


                Item_keyboard{
                    id: keyboard
                    //focus: true
                    btn_size: 65
                    btn_dist: 2
                    anchors.top: fnke.bottom
                    anchors.topMargin: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        Map_full{
            id: map
            width: 740
            height: width
            anchors.left: rect_menu.right
            anchors.top: parent.top
            anchors.topMargin: statusbar.height
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
//                joy_xy.remote_stop();
//                joy_th.remote_stop();
            }
        }
    }
}
