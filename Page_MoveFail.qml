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


    //0: no path /1: local fail /2: emergency /3: user stop /4: motor error
    property int notice_num: 0
    onNotice_numChanged: {
        if(notice_num === 0){
            text_reason.text = "패스를 찾을 수 없음";

        }else if(notice_num === 1){
            text_reason.text = "로봇 초기화 틀어짐";

        }else if(notice_num === 2){
            text_reason.text = "수동모드로 전환됨";

        }else if(notice_num === 3){
            text_reason.text = "사용자에 의해 정지됨";

        }else if(notice_num === 4){
            text_reason.text = "모터 초기화 틀어짐";

        }
    }

    property bool select_localmode: false
    onSelect_localmodeChanged: {
        map.init_mode();
        map.show_buttons = true;
        map.show_connection = true;
        map.robot_following = true;
        map.show_lidar = true;
        map.show_path = true;
        map.show_object = true;
        if(select_localmode)
            map.show_location = true;
        map.show_robot = true;
    }

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
        if(select_localmode)
            map.show_location = true;
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
            height: parent.height
            width: parent.width - rect_menu1.width - map.width
            anchors.top: parent.top
            anchors.topMargin: statusbar.height
            color: color_dark_navy
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
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
                    border.width: select_localmode?3:0
                    border.color: color_green
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
                            font.pixelSize: 15
                            text: "Localization"
                            font.family: font_noto_r.name
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    DropShadow{
                        anchors.fill: parent
                        radius: 3
                        color: color_navy
                        source: parent
                        z: -1
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(select_localmode)
                                select_localmode = false;
                            else
                                select_localmode = true;
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
        }
        Rectangle{
            id: rect_menu1
            width: 400
            height: parent.height - statusbar.height
            anchors.left: rect_state.right
            anchors.topMargin: statusbar.height
            anchors.top: parent.top
            color: "#f4f4f4"
            visible: select_localmode?false:true
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                spacing: 30
                Rectangle{
                    width: rect_menu1.width
                    height: 80
                    color: color_dark_navy
                    Text{
                        id: text_reason
                        anchors.centerIn : parent
                        font.family: font_noto_b.name
                        font.pixelSize: 30
                        color: "white"
                        text:"수동모드로 전환됨"
                    }
                }
                Rectangle{
                    id: rect_annot_box
                    width: rect_menu1.width*0.9
                    height: 120
                    radius: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#e8e8e8"
                    Row{
                        anchors.centerIn: parent
                        spacing: 30
                        Item_button{
                            id: btn_manual
                            width: 80
                            shadow_color: color_gray
                            icon: "icon/icon_manualmove.png"
                            name: "수동조작 중"
                            running: supervisor.getEmoStatus()
                        }
                    }
                }


                Grid{
                    id: grid_status
                    rows: 20
                    columns: 3
                    horizontalItemAlignment: Grid.AlignHCenter
                    verticalItemAlignment: Grid.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 5
                    property var led_size: 15
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: "Charging"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: ":"
                        width: 30
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Rectangle{
                        id: rect_charging
                        width: parent.led_size
                        height: width
                        radius: width
                        color: color_light_gray
                        border.width:1
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: "Emergency"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: ":"
                        width: 30
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Rectangle{
                        id: rect_emo
                        width: parent.led_size
                        height: width
                        radius: width
                        color: color_light_gray
                        border.width:1
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: "Power"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: ":"
                        width: 30
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Rectangle{
                        id: rect_power
                        width: parent.led_size
                        height: width
                        radius: width
                        color: color_light_gray
                        border.width:1
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: "Remote"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: ":"
                        width: 30
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Rectangle{
                        id: rect_remote
                        width: parent.led_size
                        height: width
                        radius: width
                        color: color_light_gray
                        border.width:1
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: "Battery"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: ":"
                        width: 30
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Rectangle{
                        color: "transparent"
                        width: parent.led_size*2 + 30
                        height: parent.led_size
                        Row{
                            spacing: 30
                            Text{
                                id: text_battery_in
                                font.pixelSize: 12
                                text: "0V"
                                horizontalAlignment: Text.AlignHCenter
                            }
                            Text{
                                id: text_battery_out
                                font.pixelSize: 12
                                text: "0V"
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: "Current"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: ":"
                        width: 30
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        id: text_current
                        font.pixelSize: 12
                        text: "0A"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: "Power"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: ":"
                        width: 30
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        id: text_power
                        font.pixelSize: 12
                        text: "0W"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: "Power(Total)"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: ":"
                        width: 30
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        id: text_power_total
                        font.pixelSize: 12
                        text: "0W"
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: "Motor Connection"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        width: 30
                        text: ":"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Rectangle{
                        color: "transparent"
                        width: parent.led_size*2 + 30
                        height: parent.led_size
                        Row{
                            spacing: 30
                            Rectangle{
                                id: rect_motor_con1
                                width: grid_status.led_size
                                height: width
                                radius: width
                                color: color_light_gray
                                border.width:1
                            }
                            Rectangle{
                                id: rect_motor_con2
                                width: grid_status.led_size
                                height: width
                                radius: width
                                color: color_light_gray
                                border.width:1
                            }
                        }
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: "Motor Status 0"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: ":"
                        width: 30
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        id: text_motor_stat1
                        color: "white"
                        font.pixelSize: 10
                        font.family: font_noto_r.name
                    }

                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: "Motor Status 1"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: ":"
                        width: 30
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Text{
                        id: text_motor_stat2
                        color: "white"
                        font.pixelSize: 10
                        font.family: font_noto_r.name
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: "Motor Temperature"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 12
                        text: ":"
                        width: 30
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Rectangle{
                        color: "transparent"
                        width: parent.led_size*2 + 30
                        height: parent.led_size
                        Row{
                            anchors.centerIn: parent
                            spacing: 30
                            Text{
                                id: text_motor_temp1
                                font.pixelSize: 13
                                text: "0"
                                font.family: font_noto_r.name
                            }
                            Text{
                                id: text_motor_temp2
                                font.pixelSize: 13
                                text: "0"
                                font.family: font_noto_r.name
                            }
                        }
                    }
                }
            }
        }
        Rectangle{
            id: rect_menu2
            width: 400
            height: parent.height - statusbar.height
            anchors.left: rect_state.right
            anchors.topMargin: statusbar.height
            anchors.top: parent.top
            visible: select_localmode?true:false
            color: "#f4f4f4"
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                spacing: 30
                Rectangle{
                    width: rect_menu1.width
                    height: 80
                    color: color_dark_navy
                    Text{
                        anchors.centerIn : parent
                        font.family: font_noto_b.name
                        font.pixelSize: 30
                        color: "white"
                        text:"Localization"
                    }
                }
                Rectangle{
                    width: rect_menu1.width*0.9
                    height: 120
                    radius: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#e8e8e8"
                    Row{
                        anchors.centerIn: parent
                        spacing: 30
                        Item_button{
                            id: btn_move
                            width: 80
                            shadow_color: color_gray
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
                            width: 80
                            shadow_color: color_gray
                            highlight: map.tool=="SLAM_INIT"
                            icon: "icon/icon_point.png"
                            name: "수동 초기화"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "SLAM_INIT";
                                }
                            }
                        }
                        Item_button{
                            id: btn_auto_init
                            width: 78
                            shadow_color: color_gray
                            icon:"icon/icon_auto_init.png"
                            name:"자동 초기화"
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
                    width: rect_menu1.width - 60
                    height: 100
                    visible: map.tool==="SLAM_INIT"?true:false
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    Row{
                        anchors.centerIn: parent
                        spacing: 20
                        Item_button{
                            id: btn_run
                            width: 78
                            icon:"icon/icon_run.png"
                            name:"Run"
                            shadow_color: color_gray
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
                            shadow_color: color_gray
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
                            shadow_color: color_gray
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
                    }
                }

            }
            Rectangle{
                width: parent.width*0.9
                height: 200
                radius: 10
//                anchors.bottom: parent.bottom
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
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
                        rows: 6
                        columns: 2
                        Text{
                            text: "1."
                            font.pixelSize: 13
                            font.family: font_noto_r.name
                            color: color_red
                        }
                        Text{
                            text: "Emergency가 눌려있다면 풀어주세요."
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
                            text: "자동 초기화 버튼을 눌러 초기화를 시작합니다. (약 3-5초 소요)"
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
                            text: "라이다 데이터가 맵과 일치하는 지 확인해주세요."
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
                            text: "일치하지 않는다면 수동 초기화 버튼을 누르세요."
                            font.pixelSize: 13
                            font.family: font_noto_r.name
                            color: color_red
                        }
                        Text{
                            text: "5."
                            font.pixelSize: 13
                            font.family: font_noto_r.name
                            color: color_red
                        }
                        Text{
                            text: "맵 상에서 로봇의 현재 위치와 방향대로 표시해주세요."
                            font.pixelSize: 13
                            font.family: font_noto_r.name
                            color: color_red
                        }
                        Text{
                            text: "6."
                            font.pixelSize: 13
                            font.family: font_noto_r.name
                            color: color_red
                        }
                        Text{
                            text: "Set Init 버튼을 누르고 라이다가 맵과 일치하는 지 확인해주세요."
                            font.pixelSize: 13
                            font.family: font_noto_r.name
                            color: color_red
                        }
                    }
                }
            }

        }

        Map_full{
            id: map
            width: 740
            height: width
            show_robot: true
            show_path: true
            robot_following: true
            show_lidar: true
            show_buttons: true
            show_connection: true
            show_location: true
            show_object: true
            anchors.right: parent.right
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
                btn_manual.running = true;
            }else{
                btn_manual.running = false;
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
                text_motor_stat1.color = color_light_gray;
                text_motor_stat1.text = supervisor.getMotorStatusStr(0);
            }else if(supervisor.getMotorStatus(0)===1){
                text_motor_stat1.color = color_green;
                text_motor_stat1.text = supervisor.getMotorStatusStr(0);
            }else{
                text_motor_stat1.color = color_red;
                text_motor_stat1.text = supervisor.getMotorStatusStr(0);
            }
            if(supervisor.getMotorStatus(1)===0){
                text_motor_stat2.color = color_light_gray;
                text_motor_stat2.text = supervisor.getMotorStatusStr(1);
            }else if(supervisor.getMotorStatus(1)===1){
                text_motor_stat2.color = color_green;
                text_motor_stat2.text = supervisor.getMotorStatusStr(1);
            }else{
                text_motor_stat2.color = color_red;
                text_motor_stat2.text = supervisor.getMotorStatusStr(1);
            }

            if(supervisor.getMotorTemperature(0) > supervisor.getMotorWarningTemperature()){
                text_motor_temp1.color = color_red;
            }else{
                text_motor_temp1.color = "black";
            }
            if(supervisor.getMotorTemperature(1) > supervisor.getMotorWarningTemperature()){
                text_motor_temp2.color = color_red;
            }else{
                text_motor_temp2.color = "black";
            }

            text_motor_temp1.text = supervisor.getMotorTemperature(0).toFixed(0).toString();
            text_motor_temp2.text = supervisor.getMotorTemperature(1).toFixed(0).toString();

            text_battery_in.text = supervisor.getBatteryIn().toFixed(1).toString() + "V";
            text_battery_out.text = supervisor.getBatteryOut().toFixed(1).toString() + "V";
            text_current.text = supervisor.getBatteryCurrent().toFixed(1).toString() + "A";

            text_power.text = supervisor.getPower(0).toFixed(0).toString() + "W";
            text_power_total.text = supervisor.getPowerTotal(1).toFixed(0).toString() + "W";

        }

    }
}
