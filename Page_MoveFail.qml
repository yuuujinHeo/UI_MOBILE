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
    //0: no path /1: local fail /2: emergency /3:
    property int notice_num: 0

    Component.onCompleted: {
        init();
    }

    function init(){
        notice_num = 0;
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
            id: rect_state
            width: parent.width
            height: 100
            anchors.top: parent.top
            anchors.topMargin: statusbar.height
            color: color_dark_navy
            Row{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 15
                spacing: 30
                Rectangle{
                    width: 90
                    height: 80
                    radius: 5
                    color:"white"
                    Column{
                        anchors.centerIn: parent
                        spacing: 5
                        Image{
                            source: "icon/icon_cancelpath.png"
                            sourceSize.width: 40
                            sourceSize.height: 40
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            text: "다시 시작"
                            font.family: font_noto_r.name
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    DropShadow{
                        anchors.fill: parent
                        radius: 5
                        color: color_navy
                        source: parent
                        z: -1
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.moveStop();
                        }
                    }
                }
                Rectangle{
                    width: 90
                    height: 80
                    radius: 5
                    Column{
                        anchors.centerIn: parent
                        spacing: 5
                        Image{
                            source: "image/image_localization.png"
                            sourceSize.width: 40
                            sourceSize.height: 40
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            text: "Localization"
                            font.family: font_noto_r.name
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    DropShadow{
                        anchors.fill: parent
                        radius: 5
                        color: color_navy
                        source: parent
                        z: -1
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
//                                    supervisor.moveToLast();
                        }
                    }
                }
                Rectangle{
                    width: 90
                    height: 80
                    radius: 5
                    Column{
                        anchors.centerIn: parent
                        spacing: 5
                        Image{
                            source: "icon/icon_power.png"
                            sourceSize.width: 40
                            sourceSize.height: 40
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            text: "SLAM 재부팅"
                            font.family: font_noto_r.name
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    DropShadow{
                        anchors.fill: parent
                        z: -1
                        radius: 5
                        color: color_navy
                        source: parent
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.restartSLAM();
                        }
                    }
                }
            }

            Text{
                id: text_reason
                anchors.centerIn: parent
                font.family: font_noto_b.name
                font.pixelSize: 40
                color: "white"
                text:"수동모드로 전환됨"
            }
            Row{
                id: rect_leds
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 18
                property var led_size: 18
                spacing: 18
                Rectangle{
                    id: rect_charging
                    width: rect_leds.led_size
                    height: width
                    radius: width
                    color: color_light_gray
                    border.width:1
                }
                Rectangle{
                    id: rect_emo
                    width: rect_leds.led_size
                    height: width
                    radius: width
                    color: color_light_gray
                    border.width:1
                }
                Rectangle{
                    id: rect_power
                    width: rect_leds.led_size
                    height: width
                    radius: width
                    color: color_light_gray
                    border.width:1
                }
                Rectangle{
                    id: rect_remote
                    width: rect_leds.led_size
                    height: width
                    radius: width
                    color: color_light_gray
                    border.width:1
                }
                Rectangle{
                    id: rect_motor_con1
                    width: rect_leds.led_size
                    height: width
                    radius: width
                    color: color_light_gray
                    border.width:1
                }
                Rectangle{
                    id: rect_motor_con2
                    width: rect_leds.led_size
                    height: width
                    radius: width
                    color: color_light_gray
                    border.width:1
                }
                Rectangle{
                    id: rect_motor_stat1
                    width: rect_leds.led_size
                    height: width
                    radius: width
                    color: color_light_gray
                    border.width:1
                    Text{
                        id: text_motor_stat1
                        anchors.centerIn: parent
                        color: "white"
                        font.pixelSize: 10
                        font.family: font_noto_r.name
                    }
                }
                Rectangle{
                    id: rect_motor_stat2
                    width: rect_leds.led_size
                    height: width
                    radius: width
                    color: color_light_gray
                    border.width:1
                    Text{
                        id: text_motor_stat2
                        anchors.centerIn: parent
                        color: "white"
                        font.pixelSize: 10
                        font.family: font_noto_r.name
                    }
                }
            }
        }
        Rectangle{
            id: rect_menu
            width: 450
            height: parent.height - statusbar.height - rect_state.height
            anchors.top: rect_state.bottom
            color: "#f4f4f4"
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
                spacing: 30
                Rectangle{
                    id: rect_annot_box
                    width: rect_menu.width
                    height: 120
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#e8e8e8"
                    Row{
                        anchors.centerIn: parent
                        spacing: 40
                        Item_button{
                            id: btn_move
                            width: 90
                            highlight: map.tool=="MOVE"
                            icon: "icon/icon_move.png"
                            name: "Move"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "MOVE";
                                }
                            }
                        }
                        Item_button{
                            width: 90
                            highlight: map.tool=="SLAM_INIT"
                            icon: "icon/icon_point.png"
                            name: "Point"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "SLAM_INIT";
                                }
                            }
                        }
                        Item_button{
                            id: btn_manual
                            width: 90
                            icon: "icon/icon_manualmove.png"
                            name: "수동조작 중"
                            running: supervisor.getEmoStatus()
                        }
                    }
                }
                Rectangle{
                    width: rect_menu.width - 60
                    height: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    Row{
                        anchors.centerIn: parent
                        spacing: 30
                        Item_button{
                            id: btn_run
                            width: 78
                            icon:"icon/icon_run.png"
                            name:"Run"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    btn_run.show_ani();
                                    map.tool = "MOVE";
                                    supervisor.slam_run();
                                }
                            }
                        }
                        Item_button{
                            id: btn_stop
                            width: 78
                            icon:"icon/icon_stop.png"
                            name:"Stop"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "MOVE";
                                    btn_stop.show_ani();
                                    supervisor.slam_stop();
                                }
                            }
                        }
                        Item_button{
                            id: btn_init
                            width: 78
                            icon:"icon/icon_set_init.png"
                            name:"Set Init"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(map.new_slam_init){
                                        btn_init.show_ani();
                                        supervisor.slam_setInit();
                                    }
                                }
                            }
                        }
                        Item_button{
                            id: btn_auto_init
                            width: 78
                            icon:"icon/icon_auto_init.png"
                            name:"Auto Init"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(supervisor.getStateInit() !== 2){
                                        btn_auto_init.running = true;
                                        supervisor.slam_autoInit();
                                    }

                                }
                            }
                        }
                    }
                }
                Rectangle{
                    width: 400
                    height: 200
                    radius: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    Column{
                        anchors.centerIn: parent
                        spacing: 10
                        Text{
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "* 안 내 사 항 *"
                            font.pixelSize: 18
                            font.bold: true
                            font.family: font_noto_b.name
                            color: color_red
                        }
                        Grid{
                            rows: 4
                            columns: 2
                            Text{
                                text: "1."
                                font.pixelSize: 13
                                font.family: font_noto_r.name
                                color: color_red
                            }
                            Text{
                                text: "로봇 상단의 Emergency 버튼을 눌러 수동모드로 전환하세요."
                                font.pixelSize: 13
                                font.family: font_noto_r.name
                                color: color_red
                            }
                            Text{
                                text: "2."
                                font.pixelSize: 13
                                font.family: font_noto_r.name
                                color: color_red
                            }
                            Text{
                                text: "로봇을 매장의 중심에 최대한 가깝게 이동시켜주세요."
                                font.pixelSize: 13
                                font.family: font_noto_r.name
                                color: color_red
                            }
                            Text{
                                text: "3."
                                font.pixelSize: 13
                                font.family: font_noto_r.name
                                color: color_red
                            }
                            Text{
                                text: "Start 버튼을 누르고 로봇을 끌면서 맵을 생성합니다."
                                font.pixelSize: 13
                                font.family: font_noto_r.name
                                color: color_red
                            }
                            Text{
                                text: "4."
                                font.pixelSize: 13
                                font.family: font_noto_r.name
                                color: color_red
                            }
                            Text{
                                text: "끝나면 Stop 버튼을 누르고 Save를 해주세요."
                                font.pixelSize: 13
                                font.family: font_noto_r.name
                                color: color_red
                            }
                        }
                    }
                }
            }
        }

        Map_full{
            id: map
            width: 640
            height: width
            anchors.left: rect_menu.right
            anchors.top: rect_state.bottom
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
//                timer_get_joy.start();
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
            if(supervisor.getStateMoving() === 4){
                supervisor.moveResume();
            }else{
                backPage();
                loader_page.item.checkPaused();
                timer_check_pause.stop();
            }
        }
    }

    Timer{
        id: timer_update
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            if(supervisor.getEmoStatus()){
                text_reason.text = "Emergency 눌림(수동모드)"
                rect_emo.color = color_green;
            }else{
                rect_emo.color = color_light_gray;
            }
            if(supervisor.getRemoteStatus()){
                rect_remote.color = color_green;
            }else{
                rect_remote.color = color_light_gray;
            }
            if(supervisor.getPowerStatus()){
                rect_power.color = color_green;
            }else{
                rect_power.color = color_light_gray;
            }
            if(supervisor.getChargeStatus()){
                rect_charging.color = color_green;
            }else{
                rect_charging.color = color_light_gray;
            }
            if(supervisor.getMotorConnection(0)){
                rect_motor_con1.color = color_green;
            }else{
                rect_motor_con1.color = color_red;
            }

            if(supervisor.getMotorConnection(1)){
                rect_motor_con2.color = color_green;
            }else{
                rect_motor_con2.color = color_red;
            }
            if(supervisor.getMotorStatus(0)===0){
                rect_motor_stat1.color = color_light_gray;
                text_motor_stat1.text = "";
            }else if(supervisor.getMotorStatus(0)===1){
                rect_motor_stat1.color = color_green;
                text_motor_stat1.text = "";
            }else{
                rect_motor_stat1.color = color_red;
                text_motor_stat1.text = supervisor.getMotorStatus(0).toString();
            }
            if(supervisor.getMotorStatus(1)===0){
                rect_motor_stat2.color = color_light_gray;
                text_motor_stat2.text = "";
            }else if(supervisor.getMotorStatus(1)===1){
                rect_motor_stat2.color = color_green;
                text_motor_stat2.text = "";
            }else{
                rect_motor_stat2.color = color_red;
                text_motor_stat2.text = supervisor.getMotorStatus(1).toString();
            }
        }
    }
}
