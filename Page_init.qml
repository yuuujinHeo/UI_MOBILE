import QtQuick 2.12
import QtQuick.Controls 2.12
import "."
import io.qt.Supervisor 1.0
import io.qt.MapViewer 1.0
import QtGraphicalEffects 1.0
import io.qt.Supervisor 1.0
import io.qt.CameraView 1.0
import QtMultimedia 5.12


Item {
    id: page_init
    objectName: "page_init"
    width: 1280
    height: 800

    //0:inifile, 1:mapfile, 2:connection, 3:slam, 4:done
    property int init_mode: 0

    property bool show_debug: false

    Component.onCompleted: {
        init_mode = 0;
        update_timer.start();
        supervisor.clearSharedMemory();
        supervisor.setUiState(1);
//        supervisor.checkUpdate();
    }

    function init(){
        if(loader_init.item.objectName == "init_init"){
            popup_loading.close();
            loader_init.item.ip_update();
        }
    }

    function wifistatein(){
        popup_loading.close();
        loader_init.item.updatewifiState();
    }
    function wifi_con_failed(){
        popup_loading.close();
        loader_init.item.connect_fail();
    }
    function wifi_con_success(){
        popup_loading.close();
        loader_init.item.updatewifiState();
        loader_init.item.ip_update();
    }

    //init page main window
    Loader{
        id: loader_init
        anchors.fill: parent
        sourceComponent: page_loading
    }

    //로딩화면
    Component{
        id: page_loading
        Item {
            objectName: "page_logo"
            anchors.fill: parent
            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
                OpacityAnimator{
                    target: image_logo1;
                    from: 0;
                    to: 1;
                    duration: 3000
                    running: true
                }
                Image{
                    id: image_logo1
                    sourceSize.width: 2245/4
                    sourceSize.height: 1004/4
                    source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
                    anchors.horizontalCenter:  parent.horizontalCenter
                    y: 220
                }
                Text{
                    id: text_copyright
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 130
                    text: "Copyrights Rainbow Robotics Inc. All rights reserved."
                    color: "#7e7e7e"
                    font.family: font_noto_b.name
                    font.pixelSize: 15
                }
            }
        }
    }

    //0. 새로운 업데이트
    Component{
        id: item_program_update
        Item{
            objectName: "item_program_update"
            anchors.fill: parent
            Component.onCompleted: {
                statusbar.visible = true;
            }
            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }
            Column{
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -80
                Text{
                    font.family: font_noto_r.name
                    color: "#7e7e7e"
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("새로운 업데이트가 있습니다")
                    font.pixelSize: 60
                }
                Text{
                    font.family: font_noto_r.name
                    color: "#7e7e7e"
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("업데이트를 진행하면 프로그램이 재시작됩니다")
                    font.pixelSize: 40
                }
            }

            Column{
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 50
                anchors.bottomMargin: 50
                spacing: 5
                Text{
                    font.family: font_noto_r.name
                    color: "#7e7e7e"
                    text: qsTr("최신 버전 : ")+supervisor.getProgramUpdateVersion()
                    font.pixelSize: 20
                }
                Text{
                    font.family: font_noto_r.name
                    color: "#7e7e7e"
                    text: qsTr("현재 버전 : ")+supervisor.getProgramVersion()
                    font.pixelSize: 20
                }
            }


            Row{
                spacing: 40
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 140
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    id: btn_update
                    width: 230
                    height: 130
                    radius: 40
                    color: color_navy
                    Row{
                        spacing: 15
                        anchors.centerIn: parent
                        Row{
                            id: image_robot_con
                            anchors.verticalCenter: parent.verticalCenter
                            Image{
                                id: image_tx
                                width: 15
                                height: 28
                                mipmap: true
                                antialiasing: true
                                sourceSize.width: 15
                                sourceSize.height: 28
                                source: "icon/data_gray.png"
                            }
                            Image{
                                id: image_rx
                                mipmap: true
                                antialiasing: true
                                width: 15
                                height: 28
                                sourceSize.width: 15
                                sourceSize.height: 28
                                anchors.top: image_tx.top
                                anchors.topMargin: 1
                                rotation: 180
                                source: "icon/data_green.png"
                            }
                        }
                        Text{
                            text: qsTr("업데이트")
                            anchors.verticalCenter: parent.verticalCenter
                            color: "white"
                            font.family: font_noto_r.name
                            font.pixelSize: 30
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            start_sound.play();
                            supervisor.writelog("[INIT] PROGRAM UPDATE")
                            supervisor.updateProgram();
                            parent.color = color_navy;
                        }
                    }
                }
                Rectangle{
                    id: btn_lcm_pass
                    width: 230
                    height: 130
                    radius: 40
                    color: "transparent"
                    border.width: 2
                    border.color: color_navy
                    Row{
                        spacing: 15
                        anchors.centerIn: parent
                        Image{
                            id: image_charge1
                            width: 40
                            height: 40
                            source:"icon/icon_remove.png"
                            anchors.verticalCenter: parent.verticalCenter
                            ColorOverlay{
                                source: parent
                                anchors.fill: parent
                                color: color_navy
                            }
                        }
                        Text{
                            id: text_slam_pass
                            text: qsTr("넘어가기")
                            color: color_navy
                            font.family: font_noto_r.name
                            font.pixelSize: 30
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_gray;
                        }
                        onReleased: {
                            click_sound.play();
                            supervisor.writelog("[INIT] Program Update Pass")
                            init_mode = 1;
                            parent.color = "transparent";
                        }
                    }
                }

            }


        }
    }

    //1. 로봇과 연결 되지 않을 때
    Component{
        id: item_ipc
        Item{
            objectName: "item_ipc"
            anchors.fill: parent
            Component.onCompleted: {
                statusbar.visible = true;
            }

            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }

            Text{
                font.family: font_noto_r.name
                color: "#7e7e7e"
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -100
                text: qsTr("로봇과 연결이 되지 않습니다\n재시작 후에도 연결이 되지 않으면 로봇을 재부팅해주세요")
                font.pixelSize: 40
            }

            Row{
                spacing: 40
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 140
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    id: btn_minimize
                    width: 230
                    height: 130
                    radius: 40
                    color: color_navy
                    Row{
                        spacing: 15
                        anchors.centerIn: parent
                        Image{
                            id: image_charge
                            width: 40
                            height: 40
                            source:"icon/btn_minimize.png"
                            anchors.verticalCenter: parent.verticalCenter
                            ColorOverlay{
                                source: parent
                                anchors.fill: parent
                                color: "white"
                            }
                        }
                        Text{
                            text: qsTr("재시작")
                            anchors.verticalCenter: parent.verticalCenter
                            color: "white"
                            font.family: font_noto_r.name
                            font.pixelSize: 30
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            start_sound.play();
                            supervisor.writelog("[INIT] PROGRAM RESTART")
                            supervisor.programRestart();
                            parent.color = color_navy;
                        }
                    }
                }
                Rectangle{
                    id: btn_lcm_pass
                    width: 230
                    height: 130
                    radius: 40
                    color: "transparent"
                    border.width: 2
                    border.color: color_navy
                    visible: show_debug
                    Row{
                        spacing: 15
                        anchors.centerIn: parent
                        Image{
                            id: image_charge1
                            width: 40
                            height: 40
                            source:"icon/icon_remove.png"
                            anchors.verticalCenter: parent.verticalCenter
                            ColorOverlay{
                                source: parent
                                anchors.fill: parent
                                color: color_navy
                            }
                        }
                        Text{
                            id: text_slam_pass
                            text: qsTr("넘어가기")
                            color: color_navy
                            font.family: font_noto_r.name
                            font.pixelSize: 30
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_gray;
                        }
                        onReleased: {
                            click_sound.play();
                            supervisor.writelog("[INIT] PASS IPC Connection")
                            supervisor.passInit();
                            debug_mode = true;
                            loadPage(pkitchen);
//                            loader_page.item.setDebug(true);
                            parent.color = "transparent";
                        }
                    }
                }

            }


            MouseArea{
                id: area_debug
                width: 100
                height: 100
                anchors.right: parent.right
                anchors.bottom : parent.bottom
                z: 99
                property var password: 0
                onClicked: {
                    click_sound2.play();
                    password++;
                    if(password > 4){
                        password = 0;
                        show_debug = true;
                    }
                }
            }
        }
    }

    //2. robot_config 확인 안될 때
    Component{
        id: item_robot_config
        Item{
            objectName: "item_robot_config"
            anchors.fill: parent
            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }
            Component.onCompleted: {
                statusbar.visible = true;
                supervisor.makeRobotINI();
            }
            function updatewifiState(){
                wizard_ip.connection = supervisor.getWifiConnection(wizard_ip.select_ssd);

            }
            function connect_fail(){
                text_wifi76788.visible = true;
            }

            function ip_update(){
                var ip = supervisor.getcurIP().split(".");
                if(ip.length >3){
                    ip_1.text = ip[0];
                    ip_2.text = ip[1];
                    ip_3.text = ip[2];
                    ip_4.text = ip[3];
                }else{
                    ip_1.text = "";
                    ip_2.text = "";
                    ip_3.text = "";
                    ip_4.text = "";
                }

                ip = supervisor.getcurGateway().split(".");
                if(ip.length >3){
                    gateway_1.text = ip[0];
                    gateway_2.text = ip[1];
                    gateway_3.text = ip[2];
                    gateway_4.text = ip[3];
                }else{
                    gateway_1.text = "";
                    gateway_2.text = "";
                    gateway_3.text = "";
                    gateway_4.text = "";
                }
                ip = supervisor.getcurGateway().split(".");
                if(ip.length >3){
                    dnsmain_1.text = ip[0];
                    dnsmain_2.text = ip[1];
                    dnsmain_3.text = ip[2];
                    dnsmain_4.text = ip[3];
                }else{
                    dnsmain_1.text = "";
                    dnsmain_2.text = "";
                    dnsmain_3.text = "";
                    dnsmain_4.text = "";
                }
                ip_1.ischanged = false;
                ip_2.ischanged = false;
                ip_3.ischanged = false;
                ip_4.ischanged = false;
                gateway_1.ischanged = false;
                gateway_2.ischanged = false;
                gateway_3.ischanged = false;
                gateway_4.ischanged = false;
                dnsmain_1.ischanged = false;
                dnsmain_2.ischanged = false;
                dnsmain_3.ischanged = false;
                dnsmain_4.ischanged = false;
                ip_1.focus = false;
                ip_2.focus = false;
                ip_3.focus = false;
                ip_4.focus = false;
                gateway_1.focus = false;
                gateway_2.focus = false;
                gateway_3.focus = false;
                gateway_4.focus = false;
                dnsmain_1.focus = false;
                dnsmain_2.focus = false;
                dnsmain_3.focus = false;
                dnsmain_4.focus = false;
                print("ip_update");
            }

            SwipeView{
                id: swipeview_wizard
                anchors.fill: parent
                currentIndex: 0
                interactive: false
                onCurrentIndexChanged: {
                    currentItem.init();
                }

                clip: true
                Item{
                    id: wizard_intro
                    function init(){
                    }
                    Column{
                        anchors.top: parent.top
                        anchors.topMargin: 200
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing:80
                        Row{
                            spacing: 60
                            anchors.horizontalCenter: parent.horizontalCenter
                            Image{
                                width: 150
                                height: 220
                                source: "image/robot_callme.png"
                            }
                            Column{
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 30
                                Text{
                                    text: qsTr("로봇이 처음 시작된 것 같습니다")
                                    color: color_dark_black
                                    font.pixelSize: 40
                                    font.family: font_noto_b.name
                                }
                                Text{
                                    text: qsTr("<font color=\"#12d27c\">첫 실행 마법사</font>를 시작할까요?");
                                    color: color_dark_black
                                    font.pixelSize: 50
                                    font.family: font_noto_b.name
                                }
                            }
                        }
                        Row{
                            spacing: 50
                            anchors.horizontalCenter: parent.horizontalCenter
                            Rectangle{
                                id: btn_usb_load
                                width: 230
                                height: 100
                                radius: 60
                                border.width: 3
                                border.color: enabled?color_green:color_gray
                                enabled: supervisor.getusbsize()>0?true:false
                                color: "transparent"
                                Text{
                                    text: qsTr("USB에서 가져오기")
                                    font.pixelSize: 23
                                    font.family: font_noto_r.name
                                    color:btn_usb_load.enabled?color_dark_black:color_gray
                                    anchors.centerIn: parent
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        click_sound.play();
                                        supervisor.writelog("[USER INPUT] INIT PAGE : LOAD MAP FROM USB")
                                        popup_usb_download.open();
                                    }
                                }
                            }
                            Rectangle{
                                id: btn_yes
                                width: 230
                                height: 100
                                radius: 60
                                color: color_green
                                Text{
                                    anchors.centerIn: parent
                                    text: qsTr("시작")
                                    font.pixelSize: 35
                                    font.family: font_noto_r.name
                                    color: "white"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        start_sound.play();
                                        supervisor.writelog("[USER INPUT] INIT PAGE : NEXT")
                                        swipeview_wizard.currentIndex++;
                                    }
                                }
                            }
                            Rectangle{
                                id: btn_lcm_pass
                                width: 188
                                height: 100
                                radius: 60
                                color: "transparent"
                                border.width: 3
                                border.color: "#e5e5e5"
                                visible: show_debug
                                Column{
                                    spacing: 5
                                    anchors.centerIn: parent
                                    Image{
                                        id: image_charge1
                                        width: 30
                                        height: 30
                                        source:"icon/icon_remove.png"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }
                                    Text{
                                        id: text_slam_pass
                                        text: qsTr("넘어가기 (DEBUG)")
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        click_sound.play();
                                        supervisor.passInit();
                                        debug_mode = true;
                                        supervisor.writelog("[USER INPUT] INIT PAGE : PASS CONNECTION")
                                        loadPage(pkitchen);
//                                        loader_page.item.setDebug(true);
                                        update_timer.stop();
                                    }
                                }
                            }
                        }
                    }

                }
                Item{
                    id: wizard_type
                    function init(){
                    }
                    Column{
                        anchors.centerIn: parent
                        spacing:80
                        Text{
                            text: qsTr("이 로봇은 어떤 목적으로 사용됩니까?");
                            color: color_dark_black
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 50
                            font.family: font_noto_b.name
                        }
                        Row{
                            spacing: 80
                            anchors.horizontalCenter: parent.horizontalCenter
                            Rectangle{
                                width: 230
                                height: 110
                                radius: 60
                                color: "transparent"
                                border.width: 3
                                border.color : color_green
                                Text{
                                    anchors.centerIn: parent
                                    text: qsTr("서빙용")
                                    font.pixelSize: 35
                                    font.family: font_noto_r.name
                                    color: color_dark_black
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        click_sound.play();
                                        supervisor.writelog("[USER INPUT] INIT PAGE : SET ROBOT TYPE TO Serving")
                                        supervisor.setSetting("ROBOT_HW/type","SERVING");
                                        swipeview_wizard.currentIndex++;
                                    }
                                }
                            }
                            Rectangle{
                                width: 230
                                height: 110
                                radius: 60
                                color: "transparent"
                                border.width: 3
                                border.color : color_green
                                Text{
                                    anchors.centerIn: parent
                                    text: qsTr("호출용")
                                    font.pixelSize: 35
                                    font.family: font_noto_r.name
                                    color: color_dark_black
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        click_sound.play();
                                        supervisor.writelog("[USER INPUT] INIT PAGE : SET ROBOT TYPE TO CALLING")
                                        supervisor.setSetting("ROBOT_HW/type","CALLING");
                                        swipeview_wizard.currentIndex++;
                                    }
                                }
                            }
                            Rectangle{
                                width: 230
                                height: 110
                                radius: 60
                                color: "transparent"
                                border.width: 3
                                border.color : color_green
                                Text{
                                    anchors.centerIn: parent
                                    text: qsTr("서빙+호출용")
                                    font.pixelSize: 35
                                    font.family: font_noto_r.name
                                    color: color_dark_black
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        click_sound.play();
                                        supervisor.writelog("[USER INPUT] INIT PAGE : SET ROBOT TYPE TO BOTH")
                                        supervisor.setSetting("ROBOT_HW/type","BOTH");
                                        swipeview_wizard.currentIndex++;
                                    }
                                }
                            }
                        }
                    }

                }

                Item{
                    id: wizard_name
                    function init(){
                    }
                    Column{
                        anchors.centerIn: parent
                        spacing:80
                        Grid{
                            columns:3
                            rows:3
                            horizontalItemAlignment: Grid.AlignHCenter
                            verticalItemAlignment: Grid.AlignVCenter
                            spacing: 40
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text{
                                text: qsTr("로봇의 이름")
                                color: color_dark_black
                                font.pixelSize: 30
                                font.family: font_noto_b.name
                            }
                            Rectangle{
                                width: 2
                                height: 80
                                radius: 2
                                color: color_dark_black
                            }
                            TextField{
                                id: textfield_name
                                width: 400
                                height: 80
                                font.family: font_noto_r.name
                                font.pixelSize: 25
                                horizontalAlignment: TextField.AlignHCenter
                                text: supervisor.getSetting("ROBOT_HW","model")
                                background: Rectangle{
                                    radius: 10
                                    border.width: 2
                                    border.color: color_dark_black
                                }

                                onFocusChanged: {
                                    keyboard.owner = textfield_name;
                                    textfield_name.selectAll();
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        textfield_name.select(0,0)
                                        keyboard.close();
                                    }
                                }
                            }
                            Text{
                                text: qsTr("로봇의 번호")
                                color: color_dark_black
                                font.pixelSize: 30
                                font.family: font_noto_b.name
                            }
                            Rectangle{
                                width: 2
                                height: 80
                                radius: 2
                                color: color_dark_black
                            }
                            ComboBox{
                                width: 400
                                height: 80
                                id: combobox_serialnum

                                background: Rectangle{
                                    radius: 10
                                    border.width: 2
                                    border.color: color_dark_black
                                }
                                contentItem: Text{
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    font.pixelSize: 25
                                    text:combobox_serialnum.displayText
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                delegate: ItemDelegate{
                                    contentItem: Rectangle{
                                        width: parent.implicitWidth
                                        height: 60
                                        Text{
                                            anchors.centerIn: parent
                                            font.family: font_noto_r.name
                                            font.pixelSize: 20
                                            text:modelData
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }

                                currentIndex: parseInt(supervisor.getSetting("ROBOT_HW","serial_num"))-1
                                model:[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
                            }
                        }

                    }

                    Rectangle{
                        width: 230
                        height: 100
                        radius: 60
                        color: "transparent"
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 50
                        anchors.left: parent.left
                        anchors.leftMargin: 50
                        border.width: 2
                        border.color: color_green
                        Text{
                            anchors.centerIn: parent
                            text: qsTr("이전")
                            font.pixelSize: 35
                            font.family: font_noto_r.name
                            color: color_dark_black
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                click_sound.play();
                                supervisor.writelog("[USER INPUT] INIT PAGE : PREV")
                                swipeview_wizard.currentIndex--;
                            }
                        }
                    }
                    Rectangle{
                        width: 230
                        height: 100
                        radius: 60
                        color: color_green
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 50
                        anchors.right: parent.right
                        anchors.rightMargin: 50
                        Text{
                            anchors.centerIn: parent
                            text: qsTr("다음")
                            font.pixelSize: 35
                            font.family: font_noto_r.name
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                click_sound.play();
                                supervisor.setSetting("ROBOT_HW/model",textfield_name.text);
                                supervisor.setSetting("ROBOT_HW/serial_num",combobox_serialnum.currentText);
                                supervisor.writelog("[USER INPUT] INIT PAGE : NEXT")
                                swipeview_wizard.currentIndex++;
                            }
                        }
                    }
                }

                Item{
                    id: wizard_camera
                    function update(){
                        //카메라 대수에 따라 UI 업데이트
                        if(supervisor.getCameraNum() === 2){
                            print(supervisor.getCameraNum(),supervisor.getCameraSerial(left_id));
                            is_load = true;
                            if(is_switched){
                                cameraview_1.setCamera(left_id);
                                cameraview_2.setCamera(right_id);
                                text_camera_1.text = supervisor.getCameraSerial(left_id);
                                text_camera_2.text = supervisor.getCameraSerial(right_id);
                            }else{
                                if(supervisor.getLeftCamera()===supervisor.getCameraSerial(0)){
                                    left_id = 0;
                                    right_id = 1;
                                }else if(supervisor.getLeftCamera() === supervisor.getCameraSerial(1)){
                                    left_id = 1;
                                    right_id = 0;
                                }else{
                                    if(supervisor.getRightCamera()===supervisor.getCameraSerial(0)){
                                        left_id = 1;
                                        right_id = 0;
                                    }else if(supervisor.getRightCamera() === supervisor.getCameraSerial(1)){
                                        left_id = 0;
                                        right_id = 1;
                                    }else{
                                        left_id = 0;
                                        right_id = 1;
                                    }
                                }
                                cameraview_1.setCamera(left_id);
                                cameraview_2.setCamera(right_id);
                                text_camera_1.text = supervisor.getCameraSerial(left_id);
                                text_camera_2.text = supervisor.getCameraSerial(right_id);
                            }
                        }else{
                            is_load = false;
                            text_camera_1.text = "";
                            text_camera_2.text = "";
                            rect_no_camera.visible = true;
                        }
                    }
                    function init(){
//                        timer_load.start();
                    }
                    Component.onCompleted: {
//                        timer_load.start();
                    }
                    Component.onDestruction: {
                        timer_load.stop();
                    }

                    property bool is_load: false
                    property bool is_switched: false
                    property var left_id: 0
                    property var right_id: 1
                    Timer{
                        id: timer_load
                        interval: 500
                        repeat: true
                        running: swipeview_wizard.currentIndex === 3
                        onTriggered:{
                            //카메라 정보 요청
                            supervisor.requestCamera();
                            wizard_camera.update();
                        }
                    }
                    Column{
                        spacing: 10
                        anchors.top: parent.top
                        anchors.topMargin: 50 + statusbar.height
                        Text{
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: color_dark_black
                            font.family: font_noto_r.name
                            font.pixelSize: 40
                            text: qsTr("카메라의 왼/오른쪽(로봇 기준)이 일치하도록 위치를 지정해주세요")
                        }
                        Rectangle{
                            width: 1280
                            height: 450
                            color: color_dark_navy
                            Row{
                                anchors.centerIn: parent
                                spacing: 20
                                Column{
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 30
                                    Text{
                                        id: text_left
                                        text: qsTr("왼쪽")
                                        color: "white"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.family: font_noto_b.name
                                        font.pixelSize: 30
//                                        color: color_dark_black
                                    }
                                    CameraView{
                                        id: cameraview_1
                                        width: 250
                                        height: 250
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }
                                    Rectangle{
                                        width: 350
                                        height: 50
                                        color: "white"
        //                                radius: 5
                                        Row{
                                            spacing: 10
                                            anchors.centerIn: parent
                                            Text{
                                                text: "Serial : "
                                                font.family: font_noto_r.name

                                            }
                                            Text{
                                                id: text_camera_1
                                                text: {
                                                    if(supervisor.getCameraNum() > 0){
                                                        supervisor.getCameraSerial(0);
                                                    }else{
                                                        ""
                                                    }
                                                }
                                                font.family: font_noto_r.name
                                            }
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 150
                                    height: 100
                                    radius: 10
                                    anchors.verticalCenter: parent.verticalCenter
                                    color:"transparent"
                                    Row{
                                        spacing: 20
                                        anchors.centerIn: parent
                                        Image{
                                            source: "icon/joy_left.png"
                                            anchors.verticalCenter: parent.verticalCenter
                                            ColorOverlay{
                                                anchors.fill: parent
                                                source: parent
                                                color: "white"
                                            }
                                        }
                                        Text{
                                            anchors.verticalCenter: parent.verticalCenter
                                            text: qsTr("위치\n바꾸기")
                                            color: "white"
                                            horizontalAlignment: Text.AlignHCenter
                                            font.family: font_noto_r.name
                                            font.pixelSize: 25
                                        }
                                        Image{
                                            source: "icon/joy_right.png"
                                            anchors.verticalCenter: parent.verticalCenter
//                                            ColorOverlay{
//                                                anchors.fill: parent
//                                                source: parent
//                                                color: "white"
//                                            }
                                        }
                                    }

                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            click_sound.play();
                                            supervisor.writelog("[USER INPUT] SETTING PAGE : CAMERA Position Switch")
                                            wizard_camera.is_switched = true;
                                            var temp_id = wizard_camera.left_id;
                                            wizard_camera.left_id = wizard_camera.right_id;
                                            wizard_camera.right_id = temp_id;
                                        }
                                    }
                                }
                                Column{
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 20
                                    Text{
                                        id: text_right
                                        text: qsTr("오른쪽")
                                        color: "white"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.family: font_noto_b.name
                                        font.pixelSize: 30
//                                        color: color_dark_black
                                    }
                                    CameraView{
                                        id: cameraview_2
                                        width: 250
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        height: 250
                                    }
                                    Rectangle{
                                        width: 350
                                        height: 50
                                        color: "white"
                                        Row{
                                            spacing: 10
                                            anchors.centerIn: parent
                                            Text{
                                                text: "Serial : "
                                                font.family: font_noto_r.name
                                            }
                                            Text{
                                                id: text_camera_2
                                                text: {
                                                    if(supervisor.getCameraNum() > 0){
                                                        supervisor.getCameraSerial(1);
                                                    }else{
                                                        ""
                                                    }
                                                }
                                                font.family: font_noto_r.name
                                            }
                                        }
                                    }
                                }
                            }

                        }
                    }

                    Rectangle{
                        id: rect_no_camera
                        visible: false
                        anchors.centerIn: parent
                        width: 1280
                        height: 300
                        color: color_red
                        Text{
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            font.pixelSize: 30
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            font.family: font_noto_b.name
                            text: qsTr("카메라를 찾을 수 없습니다\n건너뛰기를 누르시면 로봇이 제대로 동작하지 않으며, 계속 이 페이지가 뜹니다")
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Row{
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 30
                            spacing: 30
                            Rectangle{
                                width: 150
                                height: 80
                                radius: 20
                                Text{
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    font.pixelSize: 20
                                    text: qsTr("건너뛰기")

                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        click_sound.play();
                                        supervisor.writelog("[USER INPUT] INIT PAGE : PASS SETTING CAMERA");
                                        swipeview_wizard.currentIndex++;
                                    }
                                }
                            }
                        }
                    }

                    Rectangle{
                        width: 230
                        height: 100
                        radius: 60
                        color: "transparent"
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 50
                        anchors.left: parent.left
                        anchors.leftMargin: 50
                        border.width: 2
                        border.color: color_green
                        Text{
                            anchors.centerIn: parent
                            text: qsTr("이전")
                            font.pixelSize: 35
                            font.family: font_noto_r.name
                            color: color_dark_black
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                click_sound.play();
                                supervisor.writelog("[USER INPUT] INIT PAGE : PREV")
                                swipeview_wizard.currentIndex--;
                            }
                        }
                    }
                    Rectangle{
                        width: 230
                        height: 100
                        radius: 60
                        color: color_green
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 50
                        anchors.right: parent.right
                        anchors.rightMargin: 50
                        Text{
                            anchors.centerIn: parent
                            text: qsTr("다음")
                            font.pixelSize: 35
                            font.family: font_noto_r.name
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                click_sound.play();
                                if(!rect_no_camera.visible){
                                    supervisor.writelog("[USER INPUT] INIT PAGE : NEXT")
                                    supervisor.setCamera(text_camera_1.text,text_camera_2.text);
                                    swipeview_wizard.currentIndex++;
                                }
                            }
                        }
                    }
                }

                Item{
                    id: wizard_ip
                    property var connection : 0
                    property bool show_passwd: false
                    property var setting_step: 0
                    property string select_ssd: ""
                    property bool select_inuse: false
                    property var select_level: 0
                    property bool select_security: false
                    onSetting_stepChanged: {
                        if(setting_step === 0){
                            timer_update_wifi.start();
                            timer_update_state.stop();
                        }
                    }

                    function init(){
                        timer_update_wifi.start();
                    }
                    Component.onCompleted: {
                        timer_update_wifi.start();
                    }
                    Component.onDestruction: {
                        timer_update_wifi.stop();
                        timer_update_state.stop();
                    }

                    Timer{
                        id: timer_update_wifi
                        running: false
                        repeat: true
                        interval: 3000
                        triggeredOnStart: true
                        onTriggered: {
                            supervisor.getAllWifiList();
                            model_wifis.clear();

                            for(var i=0; i<supervisor.getWifiNum(); i++){
                                var ssid = supervisor.getWifiSSID(i);
                                model_wifis.append({"ssid":ssid,"inuse":supervisor.getWifiInuse(ssid),"rate":supervisor.getWifiRate(ssid),"level":supervisor.getWifiLevel(ssid),"security":supervisor.getWifiSecurity(ssid)});
                            }
                        }
                    }
                    Timer{
                        id: timer_update_state
                        running: false
                        repeat: true
                        interval: 500
                        triggeredOnStart: true
                        onTriggered: {
                            wizard_ip.connection = supervisor.getWifiConnection(wizard_ip.select_ssd);
                        }
                    }
                    Column{
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -50
                        spacing:40
                        visible: wizard_ip.setting_step ===0
                        Text{
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: color_dark_black
                            font.family: font_noto_r.name
                            font.pixelSize: 40
                            text: qsTr("무선 WIFI를 설정해주세요")
                        }
                        Rectangle{
                            width: 800
                            height: 400
                            radius: 20
                            Flickable{
                                id: flickable_wifi
                                anchors.fill: parent
                                clip: true
                                contentHeight: col_wifis.height
                                Column{
                                    id: col_wifis
                                    anchors.centerIn: parent
                                    property var select_wifi: -1
                                    spacing: 10
                                    Repeater{
                                        model : ListModel{id: model_wifis}
                                        Rectangle{
                                            width: 800
                                            height: 50
                                            radius: 20
                                            color:col_wifis.select_wifi===index?color_green:"white"
                                            Rectangle{
                                                width: 600
                                                height: 50
                                                anchors.centerIn: parent
                                                color: "transparent"
                                                Text{
                                                    anchors.centerIn: parent
                                                    font.family: font_noto_r.name
                                                    color:col_wifis.select_wifi===index?"white":"black"
                                                    text: ssid
                                                }
                                                Text{
                                                    font.family: font_noto_r.name
                                                    text: qsTr("(사용중)")
                                                    color: color_red
                                                    visible: inuse
                                                    font.pixelSize: 15
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    anchors.right: parent.right
                                                    anchors.rightMargin: 10
                                                }
                                                Image{
                                                    visible: !inuse && security
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    anchors.right: parent.right
                                                    source: "icon/icon_lock_2.png"
                                                    width: 50
                                                    height: 50
                                                    ColorOverlay{
                                                        anchors.fill: parent
                                                        source: parent
                                                        color: color_gray
                                                    }
                                                }
                                                Rectangle{
                                                    width: 30
                                                    height: 30
                                                    radius: 5
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    anchors.left: parent.left
                                                    anchors.leftMargin: 10
                                                    Row{
                                                        spacing: 1
                                                        anchors.centerIn: parent
                                                        Rectangle{
                                                            width: 5
                                                            anchors.bottom: parent.bottom
                                                            height:level<1?2:5
                                                            color:{
                                                                if(level==0){
                                                                    color_red
                                                                }else if(level==1){
                                                                    color_red
                                                                }else if(level==2){
                                                                    color_yellow
                                                                }else if(level==3){
                                                                    color_green
                                                                }else if(level==4){
                                                                    color_green
                                                                }
                                                            }
                                                        }
                                                        Rectangle{
                                                            width: 5
                                                            anchors.bottom: parent.bottom
                                                            height:level<2?2:10
                                                            color:{
                                                                if(level==0){
                                                                    color_red
                                                                }else if(level==1){
                                                                    color_red
                                                                }else if(level==2){
                                                                    color_yellow
                                                                }else if(level==3){
                                                                    color_green
                                                                }else if(level==4){
                                                                    color_green
                                                                }
                                                            }
                                                        }
                                                        Rectangle{
                                                            width: 5
                                                            anchors.bottom: parent.bottom
                                                            height:level<3?2:15
                                                            color:{
                                                                if(level==0){
                                                                    color_red
                                                                }else if(level==1){
                                                                    color_red
                                                                }else if(level==2){
                                                                    color_yellow
                                                                }else if(level==3){
                                                                    color_green
                                                                }else if(level==4){
                                                                    color_green
                                                                }
                                                            }
                                                        }
                                                        Rectangle{
                                                            width: 5
                                                            anchors.bottom: parent.bottom
                                                            height:level<4?2:20
                                                            color:{
                                                                if(level==0){
                                                                    color_red
                                                                }else if(level==1){
                                                                    color_red
                                                                }else if(level==2){
                                                                    color_yellow
                                                                }else if(level==3){
                                                                    color_green
                                                                }else if(level==4){
                                                                    color_green
                                                                }
                                                            }
                                                        }
                                                    }

                                                }
                                            }

                                            MouseArea{
                                                anchors.fill: parent
                                                onClicked:{
                                                    click_sound.play();
                                                    col_wifis.select_wifi = index;
                                                    wizard_ip.select_ssd = ssid;
                                                    wizard_ip.select_inuse = inuse;
                                                    wizard_ip.select_security = security;
                                                    wizard_ip.select_level = level;
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Text{
//                                visible: false
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.bottom
                                anchors.topMargin: 10
                                color: color_dark_black
                                font.family: font_noto_r.name
                                font.pixelSize: 15
                                text: qsTr("(사용 가능한 WIFI를 찾고 있습니다.)")
                            }
                        }
                    }

                    Column{
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -50
                        spacing:40
                        visible: wizard_ip.setting_step ===1
                        Text{
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: color_dark_black
                            font.family: font_noto_r.name
                            font.pixelSize: 40
                            text: qsTr("무선 WIFI에 연결합니다")
                        }
                        Rectangle{
                            width: 800
                            height: 400
                            radius: 20
                            Rectangle{
                                width: 800
                                height: 50
                                radius: 20
                                Rectangle{
                                    width: 600
                                    height: 50
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: "transparent"
                                    Text{
                                        anchors.centerIn: parent
                                        font.family: font_noto_r.name
                                        text: wizard_ip.select_ssd
                                    }
                                    Text{
                                        font.family: font_noto_r.name
                                        text: qsTr("(사용중)")
                                        color: color_red
                                        visible: wizard_ip.select_inuse
                                        font.pixelSize: 15
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.right: parent.right
                                        anchors.rightMargin: 10
                                    }
                                    Image{
                                        visible: !wizard_ip.select_inuse && wizard_ip.select_security
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.right: parent.right
                                        source: "icon/icon_lock_2.png"
                                        width: 50
                                        height: 50
                                        ColorOverlay{
                                            anchors.fill: parent
                                            source: parent
                                            color: color_gray
                                        }
                                    }
                                    Rectangle{
                                        width: 30
                                        height: 30
                                        radius: 5
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.left: parent.left
                                        anchors.leftMargin: 10
                                        Row{
                                            spacing: 1
                                            anchors.centerIn: parent
                                            Rectangle{
                                                width: 5
                                                anchors.bottom: parent.bottom
                                                height:wizard_ip.select_level<1?2:5
                                                color:{
                                                    if(wizard_ip.select_level==0){
                                                        color_red
                                                    }else if(wizard_ip.select_level==1){
                                                        color_red
                                                    }else if(wizard_ip.select_level==2){
                                                        color_yellow
                                                    }else if(wizard_ip.select_level==3){
                                                        color_green
                                                    }else if(wizard_ip.select_level==4){
                                                        color_green
                                                    }
                                                }
                                            }
                                            Rectangle{
                                                width: 5
                                                anchors.bottom: parent.bottom
                                                height:wizard_ip.select_level<2?2:10
                                                color:{
                                                    if(wizard_ip.select_level==0){
                                                        color_red
                                                    }else if(wizard_ip.select_level==1){
                                                        color_red
                                                    }else if(wizard_ip.select_level==2){
                                                        color_yellow
                                                    }else if(wizard_ip.select_level==3){
                                                        color_green
                                                    }else if(wizard_ip.select_level==4){
                                                        color_green
                                                    }
                                                }
                                            }
                                            Rectangle{
                                                width: 5
                                                anchors.bottom: parent.bottom
                                                height:wizard_ip.select_level<3?2:15
                                                color:{
                                                    if(wizard_ip.select_level==0){
                                                        color_red
                                                    }else if(wizard_ip.select_level==1){
                                                        color_red
                                                    }else if(wizard_ip.select_level==2){
                                                        color_yellow
                                                    }else if(wizard_ip.select_level==3){
                                                        color_green
                                                    }else if(wizard_ip.select_level==4){
                                                        color_green
                                                    }
                                                }
                                            }
                                            Rectangle{
                                                width: 5
                                                anchors.bottom: parent.bottom
                                                height:wizard_ip.select_level<4?2:20
                                                color:{
                                                    if(wizard_ip.select_level==0){
                                                        color_red
                                                    }else if(wizard_ip.select_level==1){
                                                        color_red
                                                    }else if(wizard_ip.select_level==2){
                                                        color_yellow
                                                    }else if(wizard_ip.select_level==3){
                                                        color_green
                                                    }else if(wizard_ip.select_level==4){
                                                        color_green
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Column{
                                visible: !popup_loading.visible
                                anchors.centerIn: parent
                                spacing: 30
                                Rectangle{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible:{
                                        if(wizard_ip.select_security){
                                            if(wizard_ip.connection === 1){
                                                false
                                            }else if(wizard_ip.connection === 2){
                                                true
                                            }else{
                                                false
                                            }
                                        }else{
                                            true
                                        }
                                    }
                                    color:wizard_ip.connection===0?color_red:wizard_ip.connection===1?color_yellow:color_green
                                    width: 500
                                    height: 50
                                    radius: 5
                                    Text{
                                        anchors.centerIn: parent
                                        font.family: font_noto_r.name
                                        color:wizard_ip.connection===0?"black":"white"
                                        text:wizard_ip.connection===0?qsTr("연결 안됨"):wizard_ip.connection===1?qsTr("연결 중"):qsTr("연결 성공")
                                        font.pixelSize: 20
                                    }
                                }
                                Text{
                                    visible: !wizard_ip.connection&&wizard_ip.select_security
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: qsTr("비밀번호를 입력해주세요")
                                    font.family: font_noto_r.name
                                    font.pixelSize: 20
                                }

                                Row{
                                    visible: !wizard_ip.connection&&wizard_ip.select_security
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.horizontalCenterOffset: 35
                                    spacing: 20
                                    Column{
                                        anchors.verticalCenter: parent.verticalCenter
                                        Text{
                                            id: text_wifi76788
                                            visible: false
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: qsTr("비밀번호가 틀렸습니다")
                                            color: color_red
                                            font.family: font_noto_r.name
                                            font.pixelSize: 17
                                        }
                                        TextField{
                                            id: passwd_wifi
                                            width: 400
                                            height: 50
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            echoMode: wizard_ip.show_passwd?TextInput.Normal:TextInput.Password
                                            onFocusChanged: {
                                                keyboard.owner = passwd_wifi;
                                                passwd_wifi.selectAll();
                                                if(focus){
                                                    keyboard.open();
                                                }else{
                                                    keyboard.close();
                                                    passwd_wifi.select(0,0);
                                                }
                                            }
                                            onTextChanged: {
                                                color = "black"
                                                text_wifi76788.visible = false;
                                            }
                                        }
                                    }
                                    Rectangle{
                                        anchors.verticalCenter: parent.verticalCenter
                                        width: 50
                                        height: 50
                                        radius: 5
                                        color: color_dark_navy
                                        border.color: "white"
                                        border.width: 1
                                        Image{
                                            anchors.centerIn: parent
                                            width: 35
                                            height: 35
                                            source:wizard_ip.show_passwd?"icon/icon_obj_yes.png":"icon/icon_obj_no.png"
                                        }
                                        MouseArea{
                                            anchors.fill: parent
                                            onClicked:{
                                                click_sound.play();
                                                if(wizard_ip.show_passwd){
                                                    wizard_ip.show_passwd = false;
                                                }else{
                                                    wizard_ip.show_passwd = true;
                                                }
                                            }
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 200
                                    height: 80
                                    radius: 40
                                    visible: !wizard_ip.connection
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: "black"
                                    Text{
                                        anchors.centerIn: parent
                                        text: qsTr("연결")
                                        font.pixelSize: 35
                                        font.family: font_noto_r.name
                                        color: "white"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            click_sound.play();
                                            if(wizard_ip.select_security){
                                                if(passwd_wifi.text == ""){
                                                    text_wifi76788.visible = true;
                                                }else{
                                                    print("check connect", wizard_ip.select_ssd, passwd_wifi.text);
                                                    supervisor.connectWifi(wizard_ip.select_ssd, passwd_wifi.text);
                                                    popup_loading.open();
                                                }
                                            }else{
                                                print("check connect", wizard_ip.select_ssd, passwd_wifi.text);
                                                supervisor.connectWifi(wizard_ip.select_ssd, passwd_wifi.text);
                                                popup_loading.open();
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Column{
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -50
                        spacing:40
                        visible: wizard_ip.setting_step ===2
                        Text{
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: color_dark_black
                            font.family: font_noto_r.name
                            font.pixelSize: 40
                            text: qsTr("무선 WIFI의 IP를 세팅합니다")
                        }
                        Rectangle{
                            width: 800
                            height: 400
                            radius: 20
                            Column{
                                visible: !popup_loading.visible
                                anchors.centerIn: parent
                                spacing: 30
                                Row{
                                    width: 700
                                    height: 50
                                    Rectangle{
                                        width: 200
                                        height: parent.height
                                        Text{
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: parent.left
                                            anchors.leftMargin: 50
                                            font.family: font_noto_r.name
                                            text:"IP"
                                            font.pixelSize: 20
                                        }
                                    }
                                    Rectangle{
                                        width: 1
                                        height: parent.height
                                        color: "#d0d0d0"
                                    }
                                    Rectangle{
                                        width: parent.width - 201
                                        height: parent.height
                                        Row{
                                            spacing: 10
                                            anchors.centerIn: parent
                                            TextField{
                                                id: ip_1
                                                width: 70
                                                height: 40
                                                onFocusChanged: {
                                                    keypad.owner = ip_1;
                                                    ip_1.selectAll();
                                                    if(focus){
                                                        keypad.open();
                                                    }else{
                                                        keypad.close();
                                                        ip_1.select(0,0);
                                                    }
                                                }
                                                color: ischanged?color_red:"black"
                                                property bool ischanged: false
                                                onTextChanged: {
                                                    ischanged = true;
                                                    if(ip_1.text.split(".").length > 1){
                                                        ip_1.text = ip_1.text.split(".")[0];
                                                        ip_1.focus = false;
                                                        ip_2.focus = true;
                                                    }
                                                    if(ip_1.text.length == 3){
                                                        ip_1.focus = false;
                                                        ip_2.focus = true;
                                                    }
                                                }
                                            }
                                            Text{
                                                anchors.verticalCenter: parent.verticalCenter
                                                text:"."
                                            }

                                            TextField{
                                                id: ip_2
                                                width: 70
                                                height: 40
                                                onFocusChanged: {
                                                    keypad.owner = ip_2;
                                                    ip_2.selectAll();
                                                    if(focus){
                                                        keypad.open();
                                                    }else{
                                                        keypad.close();
                                                        ip_2.select(0,0);
                                                    }
                                                }
                                                color: ischanged?color_red:"black"
                                                property bool ischanged: false
                                                onTextChanged: {
                                                    ischanged = true;
                                                    if(ip_2.text == "."){
                                                        ip_2.text = ip_2.text.split(".")[0]
                                                    }

                                                    if(ip_2.text.split(".").length > 1){
                                                        ip_2.text = ip_2.text.split(".")[0];
                                                        ip_2.focus = false;
                                                        ip_3.focus = true;
                                                    }
                                                    if(ip_2.text.length == 3){
                                                        ip_2.focus = false;
                                                        ip_3.focus = true;
                                                    }
                                                }
                                            }
                                            Text{
                                                anchors.verticalCenter: parent.verticalCenter
                                                text:"."
                                            }
                                            TextField{
                                                id: ip_3
                                                width: 70
                                                height: 40
                                                onFocusChanged: {
                                                    keypad.owner = ip_3;
                                                    ip_3.selectAll();
                                                    if(focus){
                                                        keypad.open();
                                                    }else{
                                                        ip_3.select(0,0);
                                                        keypad.close();
                                                    }
                                                }
                                                color: ischanged?color_red:"black"
                                                property bool ischanged: false
                                                onTextChanged: {
                                                    ischanged = true;
                                                    if(ip_3.text == "."){
                                                        ip_3.text = ip_3.text.split(".")[0]
                                                    }

                                                    if(ip_3.text.split(".").length > 1){
                                                        ip_3.text = ip_3.text.split(".")[0];
                                                        ip_3.focus = false;
                                                        ip_4.focus = true;
                                                    }
                                                    if(ip_3.text.length == 3){
                                                        ip_3.focus = false;
                                                        ip_4.focus = true;
                                                    }
                                                }
                                            }
                                            Text{
                                                anchors.verticalCenter: parent.verticalCenter
                                                text:"."
                                            }
                                            TextField{
                                                id: ip_4
                                                width: 70
                                                height: 40
                                                onFocusChanged: {
                                                    keypad.owner = ip_4;
                                                    ip_4.selectAll();
                                                    if(focus){
                                                        print("ip_4 focus on")
                                                        keypad.open();
                                                    }else{
                                                        ip_4.select(0,0);
                                                        keypad.close();
                                                    }
                                                }
                                                color: ischanged?color_red:"black"
                                                property bool ischanged: false
                                                onTextChanged: {
                                                    ischanged = true;
                                                    if(ip_4.text == "."){
                                                        ip_4.text = ip_4.text.split(".")[0]
                                                    }

                                                    if(ip_4.text.split(".").length > 1){
                                                        ip_4.text = ip_4.text.split(".")[0];
                                                        ip_4.focus = false;
                                                    }
                                                    if(ip_4.text.length == 3){
                                                        ip_4.focus = false;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                                Row{
                                    width: 700
                                    height: 50
                                    Rectangle{
                                        width: 200
                                        height: parent.height
                                        Text{
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: parent.left
                                            anchors.leftMargin: 50
                                            font.family: font_noto_r.name
                                            text:"Gateway"
                                            font.pixelSize: 20
                                        }
                                    }
                                    Rectangle{
                                        width: 1
                                        height: parent.height
                                        color: "#d0d0d0"
                                    }

                                    Rectangle{
                                        width: parent.width - 201
                                        height: parent.height
                                        Row{
                                            spacing: 10
                                            anchors.centerIn: parent
                                            TextField{
                                                id: gateway_1
                                                width: 70
                                                height: 40
                                                onFocusChanged: {
                                                    keypad.owner = gateway_1;
                                                    gateway_1.selectAll();
                                                    if(focus){
                                                        keypad.open();
                                                    }else{
                                                        keypad.close();
                                                        gateway_1.select(0,0);
                                                    }
                                                }
                                                color: ischanged?color_red:"black"
                                                property bool ischanged: false
                                                onTextChanged: {
                                                    ischanged = true;
                                                    if(gateway_1.text.split(".").length > 1){
                                                        gateway_1.text = gateway_1.text.split(".")[0];
                                                        gateway_1.focus = false;
                                                        gateway_2.focus = true;
                                                    }
                                                    if(gateway_1.text.length == 3){
                                                        gateway_1.focus = false;
                                                        gateway_2.focus = true;
                                                    }
                                                }
                                            }
                                            Text{
                                                anchors.verticalCenter: parent.verticalCenter
                                                text:"."
                                            }

                                            TextField{
                                                id: gateway_2
                                                width: 70
                                                height: 40
                                                onFocusChanged: {
                                                    keypad.owner = gateway_2;
                                                    gateway_2.selectAll();
                                                    if(focus){
                                                        keypad.open();
                                                    }else{
                                                        keypad.close();
                                                        gateway_2.select(0,0);
                                                    }
                                                }
                                                color: ischanged?color_red:"black"
                                                property bool ischanged: false
                                                onTextChanged: {
                                                    ischanged = true;
                                                    if(gateway_2.text == "."){
                                                        gateway_2.text = gateway_2.text.split(".")[0]
                                                    }

                                                    if(gateway_2.text.split(".").length > 1){
                                                        gateway_2.text = gateway_2.text.split(".")[0];
                                                        gateway_2.focus = false;
                                                        gateway_3.focus = true;
                                                    }
                                                    if(gateway_2.text.length == 3){
                                                        gateway_2.focus = false;
                                                        gateway_3.focus = true;
                                                    }
                                                }
                                            }
                                            Text{
                                                anchors.verticalCenter: parent.verticalCenter
                                                text:"."
                                            }
                                            TextField{
                                                id: gateway_3
                                                width: 70
                                                height: 40
                                                onFocusChanged: {
                                                    keypad.owner = gateway_3;
                                                    gateway_3.selectAll();
                                                    if(focus){
                                                        keypad.open();
                                                    }else{
                                                        gateway_3.select(0,0);
                                                        keypad.close();
                                                    }
                                                }
                                                color: ischanged?color_red:"black"
                                                property bool ischanged: false
                                                onTextChanged: {
                                                    ischanged = true;
                                                    if(gateway_3.text == "."){
                                                        gateway_3.text = gateway_3.text.split(".")[0]
                                                    }

                                                    if(gateway_3.text.split(".").length > 1){
                                                        gateway_3.text = gateway_3.text.split(".")[0];
                                                        gateway_3.focus = false;
                                                        gateway_4.focus = true;
                                                    }
                                                    if(gateway_3.text.length == 3){
                                                        gateway_3.focus = false;
                                                        gateway_4.focus = true;
                                                    }
                                                }
                                            }
                                            Text{
                                                anchors.verticalCenter: parent.verticalCenter
                                                text:"."
                                            }
                                            TextField{
                                                id: gateway_4
                                                width: 70
                                                height: 40
                                                onFocusChanged: {
                                                    keypad.owner = gateway_4;
                                                    gateway_4.selectAll();
                                                    if(focus){
                                                        keypad.open();
                                                    }else{
                                                        gateway_4.select(0,0);
                                                        keypad.close();
                                                    }
                                                }
                                                color: ischanged?color_red:"black"
                                                property bool ischanged: false
                                                onTextChanged: {
                                                    ischanged = true;
                                                    if(gateway_4.text == "."){
                                                        gateway_4.text = gateway_4.text.split(".")[0]
                                                    }

                                                    if(gateway_4.text.split(".").length > 1){
                                                        gateway_4.text = gateway_4.text.split(".")[0];
                                                        gateway_4.focus = false;
                                                    }
                                                    if(gateway_4.text.length == 3){
                                                        gateway_4.focus = false;
                                                    }
                                                }
                                            }
                                        }
                                    }

                                }

                                Row{
                                    width: 700
                                    height: 50
                                    Rectangle{
                                        width: 200
                                        height: 50
                                        Text{
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: parent.left
                                            anchors.leftMargin: 50
                                            font.family: font_noto_r.name
                                            text:"DNS"
                                            font.pixelSize: 20
                                        }
                                    }
                                    Rectangle{
                                        width: 1
                                        height: parent.height
                                        color: "#d0d0d0"
                                    }

                                    Rectangle{
                                        width: parent.width - 201
                                        height: parent.height
                                        Row{
                                            spacing: 10
                                            anchors.centerIn: parent
                                            TextField{
                                                id: dnsmain_1
                                                width: 70
                                                height: 40
                                                onFocusChanged: {
                                                    keypad.owner = dnsmain_1;
                                                    dnsmain_1.selectAll();
                                                    if(focus){
                                                        keypad.open();
                                                    }else{
                                                        keypad.close();
                                                        dnsmain_1.select(0,0);
                                                    }
                                                }
                                                color: ischanged?color_red:"black"
                                                property bool ischanged: false
                                                onTextChanged: {
                                                    ischanged = true;
                                                    if(dnsmain_1.text.split(".").length > 1){
                                                        dnsmain_1.text = dnsmain_1.text.split(".")[0];
                                                        dnsmain_1.focus = false;
                                                        dnsmain_2.focus = true;
                                                    }
                                                    if(dnsmain_1.text.length == 3){
                                                        dnsmain_1.focus = false;
                                                        dnsmain_2.focus = true;
                                                    }
                                                }
                                            }
                                            Text{
                                                anchors.verticalCenter: parent.verticalCenter
                                                text:"."
                                            }

                                            TextField{
                                                id: dnsmain_2
                                                width: 70
                                                height: 40
                                                onFocusChanged: {
                                                    keypad.owner = dnsmain_2;
                                                    dnsmain_2.selectAll();
                                                    if(focus){
                                                        keypad.open();
                                                    }else{
                                                        keypad.close();
                                                        dnsmain_2.select(0,0);
                                                    }
                                                }
                                                color: ischanged?color_red:"black"
                                                property bool ischanged: false
                                                onTextChanged: {
                                                    ischanged = true;
                                                    if(dnsmain_2.text == "."){
                                                        dnsmain_2.text = dnsmain_2.text.split(".")[0]
                                                    }

                                                    if(dnsmain_2.text.split(".").length > 1){
                                                        dnsmain_2.text = dnsmain_2.text.split(".")[0];
                                                        dnsmain_2.focus = false;
                                                        dnsmain_3.focus = true;
                                                    }
                                                    if(dnsmain_2.text.length == 3){
                                                        dnsmain_2.focus = false;
                                                        dnsmain_3.focus = true;
                                                    }
                                                }
                                            }
                                            Text{
                                                anchors.verticalCenter: parent.verticalCenter
                                                text:"."
                                            }
                                            TextField{
                                                id: dnsmain_3
                                                width: 70
                                                height: 40
                                                onFocusChanged: {
                                                    keypad.owner = dnsmain_3;
                                                    dnsmain_3.selectAll();
                                                    if(focus){
                                                        keypad.open();
                                                    }else{
                                                        dnsmain_3.select(0,0);
                                                        keypad.close();
                                                    }
                                                }
                                                color: ischanged?color_red:"black"
                                                property bool ischanged: false
                                                onTextChanged: {
                                                    ischanged = true;
                                                    if(dnsmain_3.text == "."){
                                                        dnsmain_3.text = dnsmain_3.text.split(".")[0]
                                                    }

                                                    if(dnsmain_3.text.split(".").length > 1){
                                                        dnsmain_3.text = dnsmain_3.text.split(".")[0];
                                                        dnsmain_3.focus = false;
                                                        dnsmain_4.focus = true;
                                                    }
                                                    if(dnsmain_3.text.length == 3){
                                                        dnsmain_3.focus = false;
                                                        dnsmain_4.focus = true;
                                                    }
                                                }
                                            }
                                            Text{
                                                anchors.verticalCenter: parent.verticalCenter
                                                text:"."
                                            }
                                            TextField{
                                                id: dnsmain_4
                                                width: 70
                                                height: 40
                                                onFocusChanged: {
                                                    keypad.owner = dnsmain_4;
                                                    dnsmain_4.selectAll();
                                                    if(focus){
                                                        keypad.open();
                                                    }else{
                                                        dnsmain_4.select(0,0);
                                                        keypad.close();
                                                    }
                                                }
                                                color: ischanged?color_red:"black"
                                                property bool ischanged: false
                                                onTextChanged: {
                                                    ischanged = true;
                                                    if(dnsmain_4.text == "."){
                                                        dnsmain_4.text = dnsmain_4.text.split(".")[0]
                                                    }

                                                    if(dnsmain_4.text.split(".").length > 1){
                                                        dnsmain_4.text = dnsmain_4.text.split(".")[0];
                                                        dnsmain_4.focus = false;
                                                    }
                                                    if(dnsmain_4.text.length == 3){
                                                        dnsmain_4.focus = false;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                                Row{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    spacing: 30
                                    Rectangle{
                                        width: 200
                                        height: 80
                                        radius: 40
                                        border.width: 1
                                        Text{
                                            anchors.centerIn: parent
                                            text: qsTr("초기화")
                                            font.pixelSize: 35
                                            font.family: font_noto_r.name
                                        }
                                        MouseArea{
                                            anchors.fill: parent
                                            onClicked: {
                                                click_sound.play();
                                                if(supervisor.getcurIP() === "")
                                                    supervisor.getWifiIP();

                                                loader_init.item.ip_update();
                                            }
                                        }
                                    }

                                    Rectangle{
                                        width: 200
                                        height: 80
                                        radius: 40
                                        color: "black"
                                        Text{
                                            anchors.centerIn: parent
                                            text: qsTr("변경")
                                            font.pixelSize: 35
                                            font.family: font_noto_r.name
                                            color: "white"
                                        }
                                        MouseArea{
                                            anchors.fill: parent
                                            onClicked: {
                                                click_sound.play();
                                                ip_1.ischanged = false;
                                                ip_2.ischanged = false;
                                                ip_3.ischanged = false;
                                                ip_4.ischanged = false;
                                                var ip_str = ip_1.text + "." + ip_2.text + "." + ip_3.text + "." + ip_4.text;
                                                gateway_1.ischanged = false;
                                                gateway_2.ischanged = false;
                                                gateway_3.ischanged = false;
                                                gateway_4.ischanged = false;
                                                var gateway_str = gateway_1.text + "." + gateway_2.text + "." + gateway_3.text + "." + gateway_4.text;
                                                dnsmain_1.ischanged = false;
                                                dnsmain_2.ischanged = false;
                                                dnsmain_3.ischanged = false;
                                                dnsmain_4.ischanged = false;
                                                var dns_str = dnsmain_1.text + "." + dnsmain_2.text + "." + dnsmain_3.text + "." + dnsmain_4.text;
                                                supervisor.setWifi(ip_str,gateway_str,dns_str);
                                                supervisor.setSetting("NETWORK/wifi_ip",ip_str);
                                                supervisor.setSetting("NETWORK/wifi_gateway",gateway_str);
                                                supervisor.setSetting("NETWORK/wifi_dnsmain",dns_str);
                                                wizard_ip.connection = false;
                                                popup_loading.open();
                                            }
                                        }
                                    }

                                }
                            }
                        }
                    }

                    Rectangle{
                        width: 230
                        height: 100
                        radius: 60
                        color: "transparent"
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 50
                        anchors.left: parent.left
                        anchors.leftMargin: 50
                        border.width: 2
                        border.color: color_green
                        Text{
                            anchors.centerIn: parent
                            text: qsTr("이전")
                            font.pixelSize: 35
                            font.family: font_noto_r.name
                            color: color_dark_black
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                click_sound.play();
                                if(wizard_ip.setting_step > 0){
                                    wizard_ip.setting_step--;
                                }else{
                                    supervisor.writelog("[USER INPUT] INIT PAGE : PREV")
                                    swipeview_wizard.currentIndex--;
                                }
                            }
                        }
                    }
                    Rectangle{
                        width: 230
                        height: 100
                        radius: 60
                        visible: wizard_ip.setting_step === 0
                        border.width: 1
                        border.color: color_gray
                        color: "transparent"
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 50
                        anchors.right: parent.right
                        anchors.rightMargin: 50 + 230 + 20
                        Text{
                            anchors.centerIn: parent
                            text: qsTr("건너뛰기")
                            font.pixelSize: 35
                            font.family: font_noto_r.name
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                click_sound.play();
                                supervisor.writelog("[USER INPUT] INIT PAGE : SKIP WIFI SETTING");
                                swipeview_wizard.currentIndex++;
                            }
                        }
                    }
                    Rectangle{
                        width: 230
                        height: 100
                        radius: 60
                        enabled:{
                            if(wizard_ip.setting_step == 0){
                                if(col_wifis.select_wifi > -1){
                                    true
                                }else{
                                    false
                                }
                            }else{
                                wizard_ip.connection
                            }
                        }
                        color: enabled?color_green:color_gray
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 50
                        anchors.right: parent.right
                        anchors.rightMargin: 50
                        Text{
                            anchors.centerIn: parent
                            text: wizard_ip.setting_step < 2 ?qsTr("다음"):qsTr("설정 완료")
                            font.pixelSize: 35
                            font.family: font_noto_r.name
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onPressed:{
                                click_sound.play();
                                parent.color = color_mid_green;
                            }
                            onReleased: {
                                parent.color = color_green;
                            }
                            onClicked: {
                                if(wizard_ip.setting_step == 0){
                                    supervisor.readWifiState(wizard_ip.select_ssd);
                                    supervisor.writelog("[USER INPUT] INIT PAGE : IP SETTING NEXT 1");
                                    wizard_ip.setting_step++;
                                    popup_loading.open();
                                    timer_update_wifi.stop();
//                                    timer_update_state.start();
                                }else if(wizard_ip.setting_step == 1){
                                    supervisor.writelog("[USER INPUT] INIT PAGE : IP SETTING NEXT 2");
                                    supervisor.getWifiIP();
                                    wizard_ip.setting_step++;
                                }else{
//                                    supervisor.save
                                    supervisor.writelog("[USER INPUT] INIT PAGE : SETTING DONE");
                                    swipeview_wizard.currentIndex++;
                                }
                            }
                        }
                    }
                }
                Item{
                    id: wizard_final
                    function init(){
                        ani_wizard_final.start();
                        timer_2sec.start();
                    }

                    SequentialAnimation{
                        id:ani_wizard_final
                        NumberAnimation{
                            target: tnke
                            property: "opacity"
                            to: 1
                            from: 0
                            duration: 500
                        }
                    }

                    Timer{
                        id: timer_2sec
                        interval: 2000
                        onTriggered: {
                            init_mode = 2;
                        }
                    }

                    Text{
                        id: tnke
                        text: qsTr("초기 세팅이 완료되었습니다")
                        anchors.centerIn: parent
                        color: color_dark_black
                        font.pixelSize: 50
                        opacity: 0
                        font.family: font_noto_b.name
                    }
                }
            }
            MouseArea{
                id: area_debug
                width: 100
                height: 100
                anchors.right: parent.right
                anchors.bottom : parent.bottom
                z: 99
                property var password: 0
                onClicked: {
                    click_sound2.play();
                    password++;
                    if(password > 4){
                        password = 0;
                        show_debug = true;
                    }
                }
            }
        }
    }

    //3. 맵을 찾을 수 없을 때
    Component{
        id: item_map
        Item{
            objectName: "item_map"
            anchors.fill: parent
            Component.onCompleted: {
                statusbar.visible = true;
            }
            function enable_rawmap(){
//                notice_map_raw.enabled = true;
            }
            function disable_rawmap(){
                notice_map_raw.enabled = false;
            }
            function enable_availablemap(){
//                notice_map_edited.enabled = true;
            }
            function disable_availablemap(){
                notice_map_edited.enabled = false;
            }

            function enable_usb(){
                btn_usb_load.enabled = true;
            }
            function disable_usb(){
                btn_usb_load.enabled = false;
            }
            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }
            Timer{
                running: true
                interval: 500
                repeat: true
                onTriggered:{
                    if(supervisor.getIPCConnection()){
                        btn_slam_start.enabled = true;
                    }else{
                        btn_slam_start.enabled = false;
                    }
                }
            }

            Text{
                font.family: font_noto_r.name
                color: "#7e7e7e"
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -100
                text: qsTr("맵 파일을 찾을 수 없습니다")
                font.pixelSize: 40
            }

            Row{
                spacing: 40
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 140
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    id: btn_slam_start
                    width: 230
                    height: 130
                    radius: 40
                    color: enabled?color_navy:color_mid_gray
                    Column{
                        spacing: 15
                        anchors.centerIn: parent
                        Image{
                            width: 40
                            height: 40
                            source:"icon/icon_add.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            ColorOverlay{
                                source: parent
                                anchors.fill: parent
                                color: "white"
                            }
                        }
                        Text{
                            text: qsTr("맵 새로만들기")
                            Component.onCompleted: {
                                scale = 1;
                                while(width*scale > 200){
                                    scale=scale-0.01;
                                }
                            }
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "white"
                            font.family: font_noto_r.name
                            font.pixelSize: 30
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            start_sound.play();
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            supervisor.writelog("[INIT] MAPPING")
                            loadPage(pmapping);
                            parent.color = color_navy;
                        }
                    }
                }
                Rectangle{
                    width: 230
                    height: 130
                    radius: 40
                    color: enabled?color_navy:color_mid_gray
                    Column{
                        spacing: 15
                        anchors.centerIn: parent
                        Image{
                            width: 40
                            height: 40
                            source:"icon/icon_open.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            ColorOverlay{
                                source: parent
                                anchors.fill: parent
                                color: "white"
                            }
                        }
                        Text{
                            text: qsTr("맵 불러오기")
                            Component.onCompleted: {
                                scale = 1;
                                while(width*scale > 200){
                                    scale=scale-0.01;
                                }
                            }
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "white"
                            font.family: font_noto_r.name
                            font.pixelSize: 30
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            start_sound.play();
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            supervisor.writelog("[INIT] LOAD MAP LOCAL")
                            popup_map_list.open();
                            parent.color = color_navy;
                        }
                    }
                }
                Rectangle{
                    id: btn_usb_load
                    width: 230
                    height: 130
                    radius: 40
                    color: enabled?color_navy:color_mid_gray
                    enabled: supervisor.getusbsize()>0?true:false
                    Column{
                        spacing: 15
                        anchors.centerIn: parent
                        Image{
                            width: 40
                            height: 40
                            source:"icon/icon_open.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            ColorOverlay{
                                source: parent
                                anchors.fill: parent
                                color: "white"
                            }
                        }
                        Text{
                            id: text_slam_pass
                            Component.onCompleted: {
                                scale = 1;
                                while(width*scale > 200){
                                    scale=scale-0.01;
                                }
                            }
                            color: "white"
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: qsTr("USB에서 가져오기")
                            font.family: font_noto_r.name
                            font.pixelSize: 30
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            click_sound.play();
                            parent.color = color_gray;
                        }
                        onReleased: {
                            supervisor.writelog("[INIT] USB GET")
                            popup_usb_download.open();
                            parent.color = "transparent";
                        }
                    }
                }
                Rectangle{
                    id: btn_lcm_pass
                    width: 230
                    height: 130
                    radius: 40
                    color: "transparent"
                    border.width: 2
                    border.color: color_navy
                    visible: show_debug
                    Column{
                        spacing: 15
                        anchors.centerIn: parent
                        Image{
                            id: image_charge1
                            width: 40
                            height: 40
                            source:"icon/icon_remove.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            ColorOverlay{
                                source: parent
                                anchors.fill: parent
                                color: color_navy
                            }
                        }
                        Text{
                            text: qsTr("넘어가기")
                            color: color_navy
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.family: font_noto_r.name
                            font.pixelSize: 30
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            click_sound.play();
                            parent.color = color_gray;
                        }
                        onReleased: {
                            supervisor.passInit();
                            debug_mode = true;
                            supervisor.writelog("[INIT] PASS IPC Connection")
                            loadPage(pkitchen);
//                            loader_page.item.setDebug(true);
                            parent.color = "transparent";
                        }
                    }
                }

            }

            MouseArea{
                id: area_debug
                width: 100
                height: 100
                anchors.right: parent.right
                anchors.bottom : parent.bottom
                z: 99
                property var password: 0
                onClicked: {
                    click_sound2.play();
                    password++;
                    if(password > 4){
                        password = 0;
                        show_debug = true;
                    }
                }
            }

            Rectangle{
                id: notice_map_edited
                width: 250
                height: 60
                radius: 10
                border.width: 3
                border.color: "#E7584D"
                color: "white"
                enabled: false
                anchors.right: parent.right
                anchors.rightMargin: -20
                visible: (y<300)?true:false
                y: enabled?200:800
                Behavior on y{
                    SpringAnimation{
                        duration: 1000
                        spring: 1
                        damping: 0.2
                    }
                }

                Image{
                    width: 30
                    height: 27
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    source: "icon/icon_error.png"
                }
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10 + 20
                    color: "#E7584D"
                    font.family: font_noto_b.name
                    text: qsTr("설정중이던 맵이 있습니다")
                    font.bold: true
                    font.pixelSize: 15
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        supervisor.writelog("[USER INPUT] INIT PAGE : OPEN MAP LIST")
                        popup_map_list.open();
                    }
                }
            }
            Rectangle{
                id: notice_map_raw
                width: 250
                height: 60
                radius: 10
                border.width: 3
                border.color: "#E7584D"
                color: "white"
                enabled: false
                anchors.right: parent.right
                anchors.rightMargin: -20
                visible: (y<400)?true:false
                y: enabled?300:800
                Behavior on y{
                    SpringAnimation{
                        duration: 1000
                        spring: 1
                        damping: 0.2
                    }
                }
                Image{
                    width: 30
                    height: 27
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    source: "icon/icon_error.png"
                }
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10 + 20
                    color: "#E7584D"
                    font.family: font_noto_b.name
                    text: qsTr("사용가능한 맵이 있습니다")
                    font.bold: true
                    font.pixelSize: 12
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        supervisor.writelog("[USER INPUT] INIT PAGE : SHOW UNSETTING MAP")
                        //popup_show_map.is_server = false;
                        //popup_show_map.open();
                    }
                }
            }
        }
    }

    //4. 로봇과 연결은 되었으나 init되지 않을 때
    Component{
        id: item_slam_init
        Item{
            objectName: "init_slam"
            anchors.fill: parent
            property var local_find_state: -1
            Component.onCompleted: {
                statusbar.visible = true;
            }
            Component.onDestruction: {
                map.setEnable(false);
            }

            function show_auto(){
                btn_slam_fullauto.visible = true;
            }

            SequentialAnimation{
                id: ani_logo_up
                running: true
                ParallelAnimation{
                    NumberAnimation{
                        target: image_logo4;
                        property: "anchors.topMargin";
                        to: 100
                        duration: 500
                        easing.type: Easing.InCurve
                    }
                }
                ParallelAnimation{
                    NumberAnimation{
                        target: text_notice4;
                        property: "opacity";
                        to: 1
                        duration: 500
                        easing.type: Easing.InCurve
                    }
                    NumberAnimation{
                        target: btn_slam_do_init;
                        property: "opacity";
                        to: 1
                        duration: 500
                        easing.type: Easing.InCurve
                    }
                }
            }

            Timer{
                id: timer_check_localization
                running: false
                repeat: true
                interval: 500
                onTriggered: {
                    local_find_state = supervisor.getLocalizationState();

                    if(local_find_state > 0 && !map.enabled)
                        map.setEnable(true);

                    if(local_find_state===0){//not ready
                    }else if(local_find_state === 1){
                        if(!popup_loading.opened)
                            popup_loading.open();
                    }else if(local_find_state === 2){//success
                        popup_loading.close();
                        map.setViewer("local_view");
                        timer_check_localization.stop();
                    }else if(local_find_state === 3){//failed
                        popup_loading.close();
                        map.setViewer("localization");
                        timer_check_localization2.start();
                        timer_check_localization.stop();
                    }

                    if(!supervisor.getIPCConnection()){
                        local_find_state = 10;
                        popup_loading.close();
                        timer_check_localization.stop();
                    }
                }
            }
            Timer{
                id: timer_check_localization2
                running: false
                repeat: true
                interval: 500
                onTriggered: {
                    if(supervisor.getLocalizationState() === 2){//success
                        btn_right2.enabled = true;
                        btn_do_autoinit.running = false;
                    }else if(supervisor.getLocalizationState() === 1){
                        btn_do_autoinit.running = true;
                        btn_right2.enabled = false;
                    }else{
                        btn_do_autoinit.running = false;
                        btn_right2.enabled = false;
                    }
                }
            }

            Rectangle{
                visible: local_find_state === -1 || local_find_state === 0
                anchors.fill: parent
                color: color_light_gray
                Image{
                    id: image_logo4
                    sourceSize.width: 2245/6
                    sourceSize.height: 1004/6
                    anchors.top: parent.top
                    anchors.topMargin: 200
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
                }
                Text{
                    id: text_notice4
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: image_logo4.bottom
                    anchors.topMargin: 80
                    opacity: 0
                    horizontalAlignment: Text.AlignHCenter
                    color: color_dark_gray
                    font.family: font_noto_b.name
                    text: qsTr("로봇을 지정된 대기위치로 이동시켜 주세요\n이동하신 후 시작버튼을 눌러주세요")
                    font.pixelSize: 50
                }
                Rectangle{
                    id: btn_slam_do_init
                    width: 300
                    height: 120
                    radius: 60
                    opacity: 0
                    color: color_green
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 100
                    Text{
                        id: text_slam_do_init
                        anchors.centerIn: parent
                        text: qsTr("시   작")
                        color: "white"
                        font.family: font_noto_r.name
                        font.pixelSize: 40
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            start_sound.play();
                            parent.color = color_mid_green;
                        }
                        onReleased: {
                            parent.color = color_green;
                        }
                        onClicked: {
                            timer_check_localization.start();
                            supervisor.writelog("[USER INPUT] INIT PAGE : DO LOCALIZATION")
                            supervisor.slam_autoInit();
                            update_timer.stop();
                        }
                    }
                }
                DropShadow{
                    anchors.fill: btn_slam_do_init
                    radius: 10
                    color: color_dark_gray
                    source: btn_slam_do_init
                }
                Rectangle{
                    id: btn_slam_manual_init
                    width: 188
                    height: 100
                    radius: 60
                    color: "transparent"
                    border.width: 3
                    visible: show_debug
                    border.color: "#e5e5e5"
                    anchors.left: btn_slam_do_init.right
                    anchors.leftMargin: 30
                    anchors.verticalCenter: btn_slam_do_init.verticalCenter
                    Column{
                        spacing: 5
                        anchors.centerIn: parent
                        Image{
                            width: 30
                            height: 30
                            source:"icon/btn_wait.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            id: text_slam_pass
                            text: qsTr("맵 새로만들기")
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            start_sound.play();
                            supervisor.writelog("[USER INPUT] INIT PAGE : NEW MAPPING")
                            loadPage(pmapping);
                        }
                    }
                }
                Rectangle{
                    id: btn_slam_pass
                    width: 188
                    height: 100
                    radius: 60
                    color: "transparent"
                    border.width: 3
                    visible: show_debug
                    border.color: "#e5e5e5"
                    anchors.left: btn_slam_manual_init.right
                    anchors.leftMargin: 30
                    anchors.verticalCenter: btn_slam_do_init.verticalCenter
                    Column{
                        spacing: 5
                        anchors.centerIn: parent
                        Image{
                            id: image_charge1
                            width: 30
                            height: 30
                            source:"icon/icon_remove.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            text: qsTr("넘어가기 (DEBUG)")
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            click_sound.play();
                            supervisor.passInit();
                            debug_mode = true;
                            supervisor.writelog("[USER INPUT] INIT PAGE : PASS LOCALIZATION")
                            loadPage(pkitchen);
                        }
                    }
                }

                MouseArea{
                    id: area_debug
                    width: 100
                    height: 100
                    anchors.right: parent.right
                    anchors.bottom : parent.bottom
                    z: 99
                    property var password: 0
                    onClicked: {
                        click_sound2.play();
                        password++;
                        if(password > 4){
                            password = 0;
                            show_debug = true;
                        }
                    }
                }

            }

            Rectangle{
                visible: local_find_state === 1
                width: parent.width
                height: parent.height - statusbar.height
                anchors.bottom: parent.bottom
                color: color_navy
                Text{
                    id: text_finding
                    text: qsTr("로봇의 위치를 찾고 있습니다")
                    color: "white"
                    opacity: 0
                    Behavior on opacity {
                        NumberAnimation{
                            duration : 500
                        }
                    }
                    font.pixelSize: 60
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 140
                    font.family: font_noto_b.name
                }
            }

            Rectangle{
                visible: local_find_state === 2
                width: parent.width
                height: parent.height - statusbar.height
                anchors.bottom: parent.bottom
                color: color_navy
                Text{
                    text:qsTr("로봇의 위치를 찾았습니다. 로봇의 위치가 정확합니까?")
                    font.pixelSize: 40
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    color: "white"
                    font.family: font_noto_b.name
                }
                Item_buttons{
                    id: btn_right
                    visible: local_find_state===2
                    width: 200
                    height: 80
                    type: "round_text"
                    text:qsTr("일치 합니다")
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.bottomMargin: 50
                    anchors.rightMargin: 50
                    onClicked: {
                        click_sound.play();
                        supervisor.writelog("[ANNOTATION] Localization : Success");
                        supervisor.confirmLocalization();
                        update_timer.start();
                    }
                }
                Item_buttons{
                    id: btn_left
                    visible: local_find_state===2
                    width: 200
                    height: 80
                    type: "round_text"
                    text: qsTr("틀립니다.\n(수동초기화)")
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.bottomMargin: 50
                    anchors.leftMargin: 50
                    onClicked: {
                        click_sound.play();
                        supervisor.writelog("[ANNOTATION] Localization : Failed")
                        local_find_state = 3;
                        map.setViewer("localization");
                        timer_check_localization2.start();
                    }
                }
            }
            Rectangle{
                visible: local_find_state === 3
                width: parent.width
                height: parent.height - statusbar.height
                anchors.bottom: parent.bottom
                color: color_navy
                Text{
                    text:qsTr("로봇의 위치를 찾을 수 없습니다 로봇의 위치를 맵 상에서 표시해주세요")
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    color: "white"
                    font.family: font_noto_b.name
                }
                Item_buttons{
                    id: btn_right2
                    width: 200
                    height: 80
                    type: "round_text"
                    text: qsTr("일치 합니다")
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.bottomMargin: 50
                    anchors.rightMargin: 50
                    enabled: false
                    onClicked: {
                        click_sound.play();
                        supervisor.writelog("[INIT] Localization : Success");
                        supervisor.confirmLocalization();
                        update_timer.start();
                    }
                }
                Column{
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 100
                    spacing: 50
                    Item_buttons{
                        width: 200
                        height: 80
                        type: "round_text"
                        selected: map.tool==="move"
                        text: qsTr("이 동")
                        onClicked: {
                            click_sound.play();
                            map.setTool("move");
                        }
                    }
                    Item_buttons{
                        width: 200
                        height: 80
                        type: "round_text"
                        selected: map.tool==="slam_init"
                        text:  qsTr("수동 지정")
                        onClicked: {
                            click_sound.play();
                            map.setTool("slam_init");
                            supervisor.setInitCurPos();
                            supervisor.slam_setInit();
                        }
                    }
                    Item_buttons{
                        width: 200
                        height: 80
                        type: "round_text"
                        text:  qsTr("다시 시도")
                        onClicked: {
                            click_sound.play();
                            map.setTool("move");
                            supervisor.slam_autoInit();
                            timer_check_localization2.start();
                        }
                    }
                    Item_buttons{
                        id: btn_do_autoinit
                        width: 200
                        height: 100
                        running: false
                        type: "start_progress"
                        text: qsTr("자동위치찾기\n(1분소요)")
                        shadowcolor: color_dark_black
                        onClicked: {
                            click_sound.play();
                            print("init autoinit");
                            map.setTool("move");
                            supervisor.slam_fullautoInit();
                            timer_check_localization2.start();
                        }
                    }
                }
            }
            Rectangle{
                visible: local_find_state === 10
                width: parent.width
                height: parent.height - statusbar.height
                anchors.bottom: parent.bottom
                color: color_navy
                Text{
                    id: text_failed_connection
                    text: qsTr("로봇과 연결이 되지 않았습니다")
                    color: "white"
                    font.pixelSize: 60
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 140
                    font.family: font_noto_b.name
                }
                Item_buttons{
                    id: btn_right3
                    visible: local_find_state===10
                    width: 200
                    height: 80
                    type: "round_text"
                    text: qsTr("프로그램 다시시작")
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.bottomMargin: 50
                    anchors.rightMargin: 50
                    onClicked: {
                        click_sound.play();
                        supervisor.writelog("[ANNOTATION] Localization : Connection Failed. Restart");
                        supervisor.programRestart();
                    }
                }
            }

            MAP_FULL2{
                id: map
                enabled: false
                objectName: "annot_local"
                visible: local_find_state>1 && local_find_state<10
                onVisibleChanged: {
                    print("map visible changed",visible,x,y,width,height);
                }
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                anchors.horizontalCenter: parent.horizontalCenter
                width: 600
                height: 600
            }

        }
    }

    //5. 로봇과 연결은 되었으나 init되지 않을 때
    Component{
        id: item_motor_init
        Item{
            objectName: "init_motor"
            anchors.fill: parent
            Component.onCompleted: {
                statusbar.visible = true;
                supervisor.setMotorLock(true);
            }
            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }

            SequentialAnimation{
                id: ani_logo_up
                running: true
                ParallelAnimation{
                    NumberAnimation{
                        target: image_logo4;
                        property: "anchors.topMargin";
                        to: 100
                        duration: 500
                        easing.type: Easing.InCurve
                    }
                }
                ParallelAnimation{
                    NumberAnimation{
                        target: text_notice4;
                        property: "opacity";
                        to: 1
                        duration: 500
                        easing.type: Easing.InCurve
                    }
                }
            }

            Image{
                id: image_logo4
                sourceSize.width: 2245/6
                sourceSize.height: 1004/6
                anchors.top: parent.top
                anchors.topMargin: 200
                anchors.horizontalCenter: parent.horizontalCenter
                source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
            }
            Text{
                id: text_notice4
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: image_logo4.bottom
                anchors.topMargin: 80
                opacity: 0
                horizontalAlignment: Text.AlignHCenter
                color: color_dark_gray
                font.family: font_noto_b.name
                text: qsTr("모터가 초기화되지 않았습니다.\n비상 스위치를 눌렀다가 풀어주세요.")
                font.pixelSize: 50
            }
            Rectangle{
                id: btn_slam_pass
                width: 188
                height: 100
                radius: 60
                color: "transparent"
                border.width: 3
                visible: show_debug
                border.color: "#e5e5e5"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_notice4.bottom
                anchors.topMargin: 80
                Column{
                    spacing: 5
                    anchors.centerIn: parent
                    Image{
                        id: image_charge1
                        width: 30
                        height: 30
                        source:"icon/icon_remove.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        id: text_slam_pass
                        text: qsTr("넘어가기 (DEBUG)")
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        click_sound.play();
                        supervisor.passInit();
                        debug_mode = true;
                        supervisor.writelog("[USER INPUT] INIT PAGE : PASS ROBOT INIT")
                        loadPage(pkitchen);
//                        loader_page.item.setDebug(true);
    //                    update_timer.stop();
                    }
                }
            }
            MouseArea{
                id: area_debug
                width: 100
                height: 100
                anchors.right: parent.right
                anchors.bottom : parent.bottom
                z: 99
                property var password: 0
                onClicked: {
                    click_sound2.play();
                    password++;
                    if(password > 4){
                        password = 0;
                        show_debug = true;
                    }
                }
            }
        }

    }

    Popup{
        id: popup_loading
        y: statusbar.height
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        bottomPadding: 0
        width: 1280
        height: 800 - statusbar.height
        closePolicy: Popup.NoAutoClose
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }
        onOpened:{
            loadi.play("image/loading_rb.gif");
        }
        onClosed:{
            loadi.stop();
        }

        AnimatedImage{
            id: loadi
            cache: false
            function play(name){
                source = name;
                visible = true;
            }
            function stop(){
                visible = false;
                source = "";
            }
            source:  ""
            MouseArea{
                id: area_debug
                width: 100
                height: 100
                anchors.right: parent.right
                anchors.bottom : parent.bottom
                z: 99
                property var password: 0
                onClicked: {
                    click_sound2.play();
                    password++;
                    if(password > 4){
                        password = 0;
                        popup_loading.close();
                    }
                }
            }
        }
    }

    Popup{
        id: popup_usb_download
        anchors.centerIn: parent
        width: 400
        height: 500
        leftPadding: 0
        topPadding: 0
        bottomPadding: 0
        rightPadding: 0
        background: Rectangle{
            color: "transparent"
        }
        property var index: 0
        property bool is_ui: false
        property bool is_slam: false
        property bool is_map: false
        property bool is_log: false
        property bool is_config: false
        property string set_name: ""
        onOpened:{
            timer_usb_new.start();

            model_usb_file_list.clear();
            for(var i=0; i<supervisor.getusbfilesize(); i++){
                model_usb_file_list.append({"name":supervisor.getusbfile(i)});
            }

            text_recent_file.text = supervisor.getusbrecentfile();
            if(text_recent_file.text == ""){
                notice_recent.visible = false;
                btn_recent_confirm.visible = false;
            }else{
                notice_recent.visible = true;
                btn_recent_confirm.visible = true;
            }
        }
        onClosed:{
            timer_usb_new.stop();
        }

        Rectangle{
            anchors.fill: parent
            Rectangle{
//                id: rect_1
                width: parent.width
                height: 50
                color: color_dark_navy
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    color: "white"
                    text: {
                        if(popup_usb_download.index === 0)
                            qsTr("가져오실 파일 목록을 선택해주세요")
                        else if(popup_usb_download.index === 1)
                            qsTr("가져오실 목록을 선택해주세요")
                    }
                }
            }

            Column{
                anchors.centerIn: parent
                visible: popup_usb_download.index === 0
                spacing: 10
                Rectangle{
                    id: notice_recent
                    width: 200
                    height: 40
                    color: color_navy
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: qsTr("가장 최신 파일")
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: "white"
                    }
                }
                Rectangle{
                    width: 280
                    radius: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 50
                    color: color_light_gray
                    Text{
                        id: text_recent_file
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: ""
                    }
                }
                Rectangle{
                    id: btn_recent_confirm
                    visible: false
                    width: 100
                    radius: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 40
                    border.width:1
                    color: "white"//color_light_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: qsTr("확인")
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            click_sound.play();
                            supervisor.writelog("[USER INPUT] GET RECENT USB FILE : "+supervisor.getusbrecentfile());
                            popup_usb_notice.mode = "extract_recent";
                            popup_usb_notice.open();
//                            supervisor.readusbrecentfile();
                        }
                    }
                }

                Rectangle{
                    width: 200
                    height: 40
                    color: color_navy
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: qsTr("그 외 발견한 파일 목록")
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: "white"
                    }
                }
                Repeater{
                    model: ListModel{id:model_usb_file_list}
                    Rectangle{
                        width: 280
                        radius: 10
                        height: 50
                        color: color_light_gray
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            font.pixelSize: 10
                            text: name
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                click_sound.play();
//                                popup_usb_download.index = 1;
//                                popup_usb_download.set_name = name;
                            }
                        }
                    }
                }
            }
            Column{
                anchors.centerIn: parent
                spacing: 10
                visible: popup_usb_download.index === 1
                Rectangle{
                    width: 280
                    radius: 10
                    height: 50
                    color: popup_usb_download.is_ui?color_green:color_light_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: "UI"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            click_sound.play();
                            popup_usb_download.is_ui = !popup_usb_download.is_ui;
                        }
                    }
                }
                Rectangle{
                    width: 280
                    radius: 10
                    height: 50
                    color: popup_usb_download.is_slam?color_green:color_light_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: "SLAMNAV"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            click_sound.play();
                            popup_usb_download.is_slam = !popup_usb_download.is_slam;
                        }
                    }
                }
                Rectangle{
                    width: 280
                    radius: 10
                    height: 50
                    color: popup_usb_download.is_config?color_green:color_light_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: "robot_config"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            click_sound.play();
                            popup_usb_download.is_config = !popup_usb_download.is_config;
                        }
                    }
                }
                Rectangle{
                    width: 280
                    radius: 10
                    height: 50
                    color: popup_usb_download.is_map?color_green:color_light_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: "maps"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            click_sound.play();
                            popup_usb_download.is_map = !popup_usb_download.is_map;
                        }
                    }
                }
                Rectangle{
                    width: 280
                    radius: 10
                    height: 50
                    color: popup_usb_download.is_log?color_green:color_light_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: "Log"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            click_sound.play();
                            popup_usb_download.is_log = !popup_usb_download.is_log;
                        }
                    }
                }
            }
            Rectangle{
                width: 250
                radius: 10
                height: 50
                color: "black"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 30
                visible: popup_usb_download.index === 1
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    color:"white"
                    text: qsTr("확인")
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        click_sound.play();
                        popup_usb_notice.setProperty("compress",popup_usb_download.set_name,popup_usb_download.is_ui,popup_usb_download.is_slam,popup_usb_download.is_config,popup_usb_download.is_map,popup_usb_download.is_log);
                        popup_usb_download.close();
                        popup_usb_notice.open();
                    }
                }
            }

        }
        Timer{
            id: timer_usb_new
            interval: 500
            running: false
            repeat: true
            onTriggered: {
                if(supervisor.getusbsize() > 0){
                }else{
                }
            }
        }
    }

    Popup{
        id: popup_usb_notice
        anchors.centerIn: parent
        width: 400
        height: 300
        leftPadding: 0
        topPadding: 0
        bottomPadding: 0
        rightPadding: 0
        background: Rectangle{
            anchors.fill: parent
            color : "transparent"
        }
        function setProperty(mo,na,ui,slam,config,map,log){
            mode = mo;
            name = na;
            is_ui = ui;
            is_slam = slam;
            is_map = map;
            is_log = log;
            is_config = config;
        }

        property bool is_ui: false
        property bool is_slam: false
        property bool is_map: false
        property bool is_log: false
        property bool is_config: false
        property string name: "Desktop"
        property string mode: "compress";
        property bool is_new: true
        Timer{
            id: timer_usb_check
            running: false
            repeat: true
            interval: 300
            onTriggered: {
                if(popup_usb_notice.is_new){
                    popup_usb_notice.is_new = false;
                    if(popup_usb_notice.mode == "compress"){
                        supervisor.usbsave(popup_usb_notice.name, popup_usb_notice.is_ui, popup_usb_notice.is_slam, popup_usb_notice.is_config, popup_usb_notice.is_map, popup_usb_notice.is_log);
                    }else if(popup_usb_notice.mode == "extract_recent"){
                        supervisor.readusbrecentfile();
                    }else if(popup_usb_notice.mode == "extract"){

                    }
                }
                if(supervisor.getzipstate() === 1){
                    if(popup_usb_notice.mode== "compress"){
                        text_usb_state.text = qsTr("파일을 압축하여 저장 중..");
                    }else{
                        text_usb_state.text = qsTr("파일을 가져오는 중..");
                    }
                }else if(supervisor.getzipstate() === 2){
                    if(popup_usb_notice.mode== "compress"){
                        text_usb_state.text = qsTr("저장에 성공하였습니다");
                    }else{
                        btn_usb_confirm.visible = true;
                        text_usb_state.text = qsTr("파일을 성공적으로 가져왔습니다\n확인을 누르시면 업데이트를 진행합니다");
                    }

                }else if(supervisor.getzipstate() === 3){
                    if(popup_usb_notice.mode== "compress"){
                        text_usb_state.text = qsTr("저장에 성공하였지만 일부 과정에서 에러가 발생했습니다");
                    }else{
                        text_usb_state.text = qsTr("파일을 성공적으로 가져왔습니다만 일부 과정에서 에러가 발생했습니다\n확인을 누르시면 업데이트를 진행합니다");
                        btn_usb_confirm.visible = true;
                    }
                    model_usb_error.clear();
                    for(var i=0; i<supervisor.getusberrorsize(); i++){
                        model_usb_error.append({"error":supervisor.getusberror(i)});
                    }
                }else if(supervisor.getzipstate() === 4){
                    if(popup_usb_notice.mode== "compress"){
                        text_usb_state.text = qsTr("저장에 실패했습니다");
                    }else{
                        text_usb_state.text = qsTr("파일을 가져오지 못했습니다");
                    }
                    model_usb_error.clear();
                    for(var i=0; i<supervisor.getusberrorsize(); i++){
                        model_usb_error.append({"error":supervisor.getusberror(i)});
                    }
                }else{
                    print(supervisor.getzipstate());
                    text_usb_state.text = qsTr("잠시만 기다려주세요");
                }
            }
        }
        onOpened:{
            timer_usb_check.start();
            model_usb_error.clear();
            btn_usb_confirm.visible = false;
            text_usb_state.text = qsTr("잠시만 기다려주세요");
            is_new = true;
        }
        onClosed: {
            timer_usb_check.stop();
        }
        Rectangle{
            width: parent.width
            height: parent.height
            radius: 10
            color: color_dark_navy
            Column{
                anchors.centerIn: parent
                spacing: 10
                Text{
                    id: text_usb_state
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: font_noto_r.name
                    color: "white"
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    text:qsTr("잠시만 기다려주세요")
                }
                Repeater{
                    model: ListModel{id:model_usb_error}
                    Text{
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 10
                        color: color_red
                        horizontalAlignment: Text.AlignHCenter
                        text:error
                    }
                }

                Rectangle{
                    id: btn_usb_confirm
                    visible: false
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 100
                    height: 50
                    radius: 5
                    border.width: 1
                    Text{
                        anchors.centerIn: parent
                        font.family:font_noto_r.name
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{

                            click_sound.play();
                            if(popup_usb_notice.mode== "compress"){

                            }else{
                                supervisor.updateUSB();
                            }
                        }
                    }
                }
            }
        }
    }

    Popup_map_list{
        id: popup_map_list
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Timer{
        id: failload_timer
        interval: 2000
        running: false
        repeat: false
        onTriggered: {
            loader_init.item.disable_failload();
        }
    }
    Timer{
        id: timer_wait_lcm
        interval: 3000
        running: false
        repeat: false
        onTriggered: {
            supervisor.writelog("[INIT] IPC not Connected.");
            loader_init.sourceComponent = item_ipc;

        }
    }
    Timer{
        id: timer_check_version
        interval: 1000
        running: false
        repeat: true
        property var count: 0
        onTriggered: {
            if(init_mode == 0){
                if(count < 2){
                    count++;
                }else{
                    init_mode = 1;
                    supervisor.writelog("[INIT] Program version check : None");
                }
            }

        }

    }

    Timer{
        id: update_timer
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            if(init_mode == 0){
                //=============================== Init Check 0 : Program Update ==============================//
                if(supervisor.checkNewUpdateProgram()){
                    if(loader_init.item.objectName != "item_program_update"){
                        supervisor.writelog("[INIT] Program version check : New Version ("+supervisor.getProgramUpdateVersion()+")");
                        loader_init.sourceComponent = item_program_update;
                    }
                }else{
                    if(!timer_check_version.running){
                        timer_check_version.count = 0;
                        timer_check_version.start();
                    }
                }
            }else if(init_mode == 1){
                //=============================== Init Check 1 : IPC ==============================//
                if(supervisor.getIPCConnection()){
                    supervisor.writelog("[INIT] IPC Connection Check : Success");
                    init_mode = 2;
//                    timer_wait_lcm.stop();
                }else if(loader_init.item.objectName != "item_ipc"){
                    loader_init.sourceComponent = item_ipc;
                    supervisor.writelog("[INIT] IPC Connection Check : Failed");
                }
            }else if(init_mode == 2){
                //========================== Init Check 2 : Robot Config ==============================//
                if(supervisor.checkINI() && loader_init.item.objectName != "item_robot_config"){
                    supervisor.writelog("[INIT] Robot_config Check : Success");
                    init_mode = 3;
                }else{
                    if(loader_init.item.objectName != "item_robot_config"){
                        loader_init.sourceComponent = item_robot_config
                        supervisor.writelog("[INIT] Robot_config Check : Failed");
                    }
                }
            }else if(init_mode == 3){
                if(supervisor.getLockStatus()===1){
                    supervisor.setMotorLock(false);
                }
                //=============================== Init Check 3 : 맵 확인 ==============================//
                var map_name = supervisor.getMapname();
                //annotation과 map 존재여부 확인
                if(supervisor.isExistAnnotation(map_name) && supervisor.isLoadMap()){
                    //이미 설정확인된 맵이 존재한다면 다음으로 넘어감
                    supervisor.writelog("[INIT] Map Check : Success");
                    init_mode = 4;
                }else{
                    //annotation, map 둘 중 하나라도 없으면 안내페이지 표시
                    if(loader_init.item.objectName != "item_map"){
                        supervisor.writelog("[INIT] Map Check : Failed (" + map_name+")");
                        loader_init.sourceComponent = item_map
                    }else{
                        //USB연결 확인
                        if(supervisor.getusbsize() > 0){
                            loader_init.item.enable_usb();
                        }else{
                            loader_init.item.disable_usb();
                        }

                        //설정 된 맵은 있지만 annotation은 없는 경우
                        if(supervisor.isLoadMap()){
                            loader_init.item.enable_rawmap();
                        }else{
                            loader_init.item.disable_rawmap();
                        }

                        //가능한 다른 맵이 있는 경우
                        var available_map_num = supervisor.getAvailableMap();
                        if(available_map_num > 0){
                            loader_init.item.enable_availablemap();
                        }else{
                            loader_init.item.disable_availablemap();
                        }
                    }
                }
            }else if(init_mode == 4){
                if(supervisor.getLockStatus()===1){
                    supervisor.setMotorLock(false);
                }
                //======================= Init Check 4 : 로봇 상태 확인(Charging. Localization) =========================//
                if(supervisor.getChargeStatus() === 1){
                    dochargeininit();
                    supervisor.writelog("[INIT] Charging Detected");
                }else if(loader_init.item.objectName != "init_slam"){
                    supervisor.writelog("[INIT] Localization Check : Failed");
                    loader_init.sourceComponent = item_slam_init
                }else if(supervisor.getIPCConnection() && supervisor.getLocalizationConfirm() === 2){
                    init_mode = 5;
                    supervisor.writelog("[INIT] Localization Check : Success");
                }else{
//                    print("check localization",supervisor.getLocalizationConfirm());
                }
            }else if(init_mode == 5){
                //=============================== Init Check 5 : 로봇 상태 확인(Motor) ==============================//
                if(supervisor.getLockStatus()===0){
                    supervisor.setMotorLock(true);
                }

                if(supervisor.getChargeStatus() === 1){
                    dochargeininit();
                    supervisor.writelog("[INIT] Charging Detected");
                }else if(supervisor.getIPCConnection() && supervisor.getMotorState() === 1){
                    supervisor.writelog("[INIT] Motor Check : Success");
                    init_mode = 6;
                    update_timer.stop();
                    loadPage(pkitchen);
                }else{
                    if(loader_init.item.objectName != "init_motor"){
                        supervisor.writelog("[INIT] Motor Check : Failed");
                        loader_init.sourceComponent = item_motor_init
                    }
                }
            }
        }
    }


    Tool_Keyboard{
        id: keyboard
    }

    Tool_KeyPad{
        id: keypad
    }

//    SoundEffect{
//        id: click_sound
//        source: "bgm/click.wav"
//    }

//    SoundEffect{
//        id: click_start
//        source: "bgm/click_start.wav"
//    }
}
