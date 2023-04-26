import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import "."
import io.qt.Supervisor 1.0
import io.qt.CameraView 1.0
import QtMultimedia 5.12
Item {
    id: page_setting
    objectName: "page_setting"
    width: 1280
    height: 800
    property bool is_admin: false
    property int select_category: 4
    property string platform_name: supervisor.getRobotName()
    property string debug_platform_name: ""
    property bool is_debug: false
    property int motor_left_id: 1
    property int motor_right_id: 0
    function update_camera(){
        if(popup_camera.opened)
            popup_camera.update();
    }

    Component.onCompleted: {
        is_admin = false;
        init();
    }

    function set_category(num){
        select_category = num;
    }

    function set_call_done(){
//        init();
        model_callbell.clear();
        for(var i=0; i<combo_call_num.currentIndex; i++){
            model_callbell.append({name:supervisor.getSetting("CALLING","call_"+Number(i))});
        }
        popup_change_call.close();
    }

    Tool_Keyboard{
        id: keyboard
    }
    Audio{
        id: voice_test
        autoPlay: false
        volume: slider_volume_voice.value/100
        source: "bgm/voice_start_serving.mp3"
    }
    Audio{
        id: bgm_test
        property bool isplaying: false
        autoPlay: false
        volume: slider_volume_bgm.value/100
        source: "bgm/song.mp3"
        onPlaying: {
            isplaying = true;
        }
        onStopped: {
            isplaying = false;
        }
    }
    Rectangle{
        width: parent.width
        height: parent.height-statusbar.height
        anchors.bottom: parent.bottom
        color: "#f4f4f4"
        //카테고리 바
        Row{
            spacing: 5
            Rectangle{
                width: 250
                height: 40
                color: "#323744"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "설정"
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onDoubleClicked:{
                        popup_password.open();
                    }
                }
            }
            Rectangle{
                id: rect_category_1
                width: 240
                height: 40
                color: "#647087"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "로봇"
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                       select_category = 1;
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 7
                    visible: select_category==1?true:false
                    color: "#12d27c"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                }
            }
            Rectangle{
                id: rect_category_2
                width: 240
                height: 40
                color: "#647087"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "맵"
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                       select_category = 2;
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 7
                    visible: select_category==2?true:false
                    color: "#12d27c"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                }
            }
            Rectangle{
                id: rect_category_3
                width: 264
                height: 40
                visible: is_admin
                color: "#647087"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "주행"
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                       select_category = 3;
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 7
                    visible: select_category==3?true:false
                    color: "#12d27c"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                }
            }
            Rectangle{
                id: rect_category_4
                width: 240
                height: 40
                color: "#647087"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "상태"
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                       select_category = 4;
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 7
                    visible: select_category==4?true:false
                    color: "#12d27c"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                }
            }
        }

        Flickable{
            id: area_setting_robot
            visible: select_category==1?true:false
            width: 880
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 120
            height: parent.height - 200
            contentHeight: column_setting.height
            clip: true
            ScrollBar.vertical: ScrollBar{
                width: 20
                anchors.right: parent.right
                policy: ScrollBar.AlwaysOn
            }
            Column{
                id:column_setting
                width: parent.width
                spacing:25

                Rectangle{
                    width: 1100
                    height: 40
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_b.name
                        text:"로봇 기본 정보"
                        color: "white"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    id: set_robot_1
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"플랫폼 이름(*영문)"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: platform_name
                                anchors.fill: parent
                                text:supervisor.getSetting("ROBOT_HW","model");
                                onFocusChanged: {
                                    keyboard.owner = platform_name;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_robot_1_serial
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"플랫폼 넘버(중복 주의)"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_platform_serial
                                anchors.fill: parent
                                model:[0,1,2,3,4,5,6,7,8,9,10]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_robot_1_id
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"플랫폼 번호(중복 주의)"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_platform_id
                                anchors.fill: parent
                                model:[0,1,2,3,4,5,6,7,8,9,10]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_robot_2
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"플랫폼 타입"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_platform_type
                                anchors.fill: parent
                                model:["서빙용","호출용"]
                            }
                        }
                    }
                }
                Rectangle{
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"preset"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                anchors.centerIn: parent
                                spacing: 25
                                Rectangle{
                                    width:80
                                    height: 40
                                    radius: 5
                                    border.width: 1
                                    Text{
                                        id: text_preset_name_1
                                        anchors.centerIn: parent
                                        text: "preset 1"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            if(text_preset_name_1.text !== ""){
                                                popup_preset_set.preset_num = 1;
                                                popup_preset_set.open();
                                            }

                                        }
                                    }
                                }
                                Rectangle{
                                    width:80
                                    height: 40
                                    radius: 5
                                    border.width: 1
                                    Text{
                                        id: text_preset_name_2
                                        anchors.centerIn: parent
                                        text: "preset 2"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            if(text_preset_name_2.text !== ""){
                                                popup_preset_set.preset_num = 2;
                                                popup_preset_set.open();
                                            }

                                        }
                                    }
                                }
                                Rectangle{
                                    width:80
                                    height: 40
                                    radius: 5
                                    border.width: 1
                                    Text{
                                        id: text_preset_name_3
                                        anchors.centerIn: parent
                                        text: "preset 3"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            if(text_preset_name_3.text !== ""){
                                                popup_preset_set.preset_num = 3;
                                                popup_preset_set.open();
                                            }
                                        }
                                    }
                                }
                                Rectangle{
                                    width:80
                                    height: 40
                                    radius: 5
                                    color: "black"
                                    visible: is_admin
                                    Text{
                                        anchors.centerIn: parent
                                        text: "edit"
                                        color: "white"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            popup_preset.open();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_tray_num
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"트레이 개수"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_tray_num
                                anchors.fill: parent
                                model:[1,2,3,4,5]
                            }
                        }
                    }

                }

                Rectangle{
                    width: 1100
                    height: 40
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_b.name
                        text:"로봇 설정"
                        color: "white"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    id: set_velocity
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"이동 속도"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            id: rr
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_velocity
                                        anchors.centerIn: parent
                                        text: slider_vxy.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_vxy
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0
                                    to: 1
                                    value: supervisor.getVelocity()
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_bgm_volume
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"음악 볼륨"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            id: tt
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Image{
                                    id: ttet1
                                    source: "icon/icon_mute.png"
                                    anchors.verticalCenter: parent.verticalCenter
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            if(slider_volume_bgm.value == 0){
                                                slider_volume_bgm.value  = Number(supervisor.getSetting("ROBOT_SW","volume_bgm"));
                                            }else{
                                                slider_volume_bgm.value  = 0;
                                            }

                                        }
                                    }
                                }
                                Slider{
                                    anchors.verticalCenter: parent.verticalCenter
                                    id: slider_volume_bgm
//                                    anchors.centerIn: parent
                                    width: tt.width*0.7
                                    height: 40
                                    from: 0
                                    to: 100
                                    value: supervisor.getSetting("ROBOT_SW","volume_bgm")
                                }

                                Image{
                                    id: ttet
                                    source: "icon/icon_test_play.png"
                                    anchors.verticalCenter: parent.verticalCenter
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            if(bgm_test.isplaying){
                                                bgm_test.stop();
                                                ttet.source = "icon/icon_test_play.png";
                                            }else{
                                                bgm_test.play();
                                                ttet.source = "icon/icon_test_stop.png";
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_voice_volume
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"음성 볼륨"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }

                        Rectangle{
                            id: te
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Image{
                                    id: ttet12
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "icon/icon_mute.png"
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            if(slider_volume_voice.value == 0){
                                                slider_volume_voice.value  = Number(supervisor.getSetting("ROBOT_SW","volume_voice"));
                                            }else{
                                                slider_volume_voice.value  = 0;
                                            }
                                        }
                                    }
                                }
                                Slider{
                                    anchors.verticalCenter: parent.verticalCenter
                                    id: slider_volume_voice
                                    width: te.width*0.7
                                    height: 40
                                    from: 0
                                    to: 100
                                    value: supervisor.getSetting("ROBOT_SW","volume_voice")
                                }
                                Image{
                                    id: ttet14
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "icon/icon_test_play.png"
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            print("test play")
                                            voice_test.play();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle{
                    width: 1100
                    height: 40
                    visible: is_admin
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_b.name
                        text:"로봇 설정(전문가용)"
                        color: "white"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    id: set_ip
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
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
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                TextField{
                                    id: ip_1
                                    width: 50
                                    height: 30
                                    onFocusChanged: {
                                        keyboard.owner = ip_1;
                                        ip_1.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            keyboard.close();
                                            ip_1.select(0,0);
                                        }
                                    }
                                    onTextChanged: {
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
                                    width: 50
                                    height: 30
                                    onFocusChanged: {
                                        keyboard.owner = ip_2;
                                        ip_2.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            keyboard.close();
                                            ip_2.select(0,0);
                                        }
                                    }
                                    onTextChanged: {
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
                                    width: 50
                                    height: 30
                                    onFocusChanged: {
                                        keyboard.owner = ip_3;
                                        ip_3.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            ip_3.select(0,0);
                                            keyboard.close();
                                        }
                                    }
                                    onTextChanged: {
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
                                    width: 50
                                    height: 30
                                    onFocusChanged: {
                                        keyboard.owner = ip_4;
                                        ip_4.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            ip_4.select(0,0);
                                            keyboard.close();
                                        }
                                    }
                                    onTextChanged: {
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
                }

                Rectangle{
                    id: set_robot_radius
                    width: 840
                    visible: is_admin
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"로봇 반지름 반경"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: radius
                                anchors.fill: parent
                                text:supervisor.getSetting("ROBOT_HW","radius");
                                onFocusChanged: {
                                    keyboard.owner = radius;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_wheelbase
                    width: 840
                    visible: is_admin
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"wheel_base"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: wheel_base
                                anchors.fill: parent
                                text:supervisor.getSetting("ROBOT","wheel_base");
                                onFocusChanged: {
                                    keyboard.owner = wheel_base;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_wheelradius
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"wheel_radius"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: wheel_radius
                                anchors.fill: parent
                                text:supervisor.getSetting("ROBOT","wheel_radius");
                                onFocusChanged: {
                                    keyboard.owner = wheel_radius;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_auto_init
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"실행 시 자동 초기화"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_autoinit
                                anchors.fill: parent
                                model:["사용안함","사용"]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_use_Avoid
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"대기 후 경로재탐색"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_avoid
                                anchors.fill: parent
                                model:["사용안함","사용"]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_use_multirobot
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"멀티 로봇"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_multirobot
                                anchors.fill: parent
                                model:["사용안함","사용"]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_ui_cmd
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"UI 명령 활성"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_use_uicmd
                                anchors.fill: parent
                                model:["비활성화","활성화"]
                            }
                        }
                    }
                }
                Rectangle{
                    id: init_
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"초기화"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Rectangle{
                                anchors.centerIn: parent
                                width: 300
                                height: 40
                                color: "black"
                                Text{
                                    anchors.centerIn: parent
                                    color: "white"
                                    font.family: font_noto_r.name
                                    font.pixelSize: 15
                                    text: "공용폴더 덮어씌우기"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        popup_reset.open();
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }

        Flickable{
            id: area_setting_map
            visible: select_category==2?true:false
            width: 880
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 120
            height: parent.height - 200
            contentHeight: column_setting2.height
            clip: true
            ScrollBar.vertical: ScrollBar{
                width: 20
                anchors.right: parent.right
                policy: ScrollBar.AlwaysOn
            }
            Column{
                id:column_setting2
                width: parent.width
                spacing:25
                Rectangle{
                    width: 1100
                    height: 40
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_b.name
                        text:"매장 설정"
                        color: "white"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    id: set_cur_map
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"현재 설정된 맵"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 30
                                anchors.centerIn: parent
                                TextField{
                                    id: map_name
                                    height: parent.height
                                    width: 300
                                    text:supervisor.getMapname();
                                    onFocusChanged: {
                                        keyboard.owner = map_name;
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            keyboard.close();
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 100
                                    height: 40
                                    radius: 5
                                    color: "black"
                                    anchors.verticalCenter: parent.verticalCenter
                                    Text{
                                        font.family: font_noto_r.name
                                        color: "white"
                                        anchors.centerIn: parent
                                        text: "변경"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            popup_maplist.open();
                                            init();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_map_size
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"맵 크기"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: map_size
                                anchors.fill: parent
                                text:supervisor.getSetting("ROBOT_SW","map_size");
                                onFocusChanged: {
                                    keyboard.owner = map_size;
                                    if(focus){
                                        keyboard.open();
                                        map_size.selectAll();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_grid_size
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"맵 단위 크기"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: grid_size
                                anchors.fill: parent
                                text:supervisor.getSetting("ROBOT_SW","grid_size");
                                onFocusChanged: {
                                    keyboard.owner = grid_size;
                                    if(focus){
                                        keyboard.open();
                                        grid_size.selectAll();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_table_num
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"테이블 개수"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_table_num
                                anchors.fill: parent
                                model:30
//                                model:[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]

                            }
                        }
                    }
                }
                Rectangle{
                    id: set_max_call
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"최대 호출 횟수"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_call_max
                                anchors.fill: parent
                                model:[1,2,3,4,5]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_call_num
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"호출벨 개수"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_call_num
                                anchors.fill: parent
                                model:20
                                onCurrentIndexChanged: {
                                    model_callbell.clear();
                                    for(var i=0; i<combo_call_num.currentIndex; i++){
                                        model_callbell.append({name:supervisor.getSetting("CALLING","call_"+Number(i))});
                                    }
                                }
                            }
                        }
                    }

                }
                Repeater{
                    model: ListModel{id:model_callbell}//combo_call_num.currentIndex
                    Rectangle{
                        width: 840
                        height: 40
                        Row{
                            anchors.fill: parent
                            Rectangle{
                                width: 350
                                height: parent.height
                                Text{
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 50
                                    font.family: font_noto_r.name
                                    text:"호출벨 "+Number(index)
                                    font.pixelSize: 20
                                }
                            }
                            Rectangle{
                                width: 1
                                height: parent.height
                                color: "#d0d0d0"
                            }
                            Rectangle{
                                width: parent.width - 351
                                height: parent.height
                                Row{
                                    anchors.centerIn: parent
                                    spacing: 20
                                    TextField{
                                        id: call_id
                                        width: 300
                                        height: parent.height
                                        text: name//supervisor.getSetting("CALLING","call_"+Number(index))
                                    }
                                    Rectangle{
                                        width: 100
                                        height: 40
                                        anchors.verticalCenter: parent.verticalCenter
                                        color: "black"
                                        radius: 5
                                        Text{
                                            anchors.centerIn: parent
                                            text: "변경"
                                            font.family: font_noto_r.name
                                            font.pixelSize: 10
                                            color: "white"
                                        }
                                        MouseArea{
                                            anchors.fill: parent
                                            onClicked: {
                                                popup_change_call.callid = index
                                                popup_change_call.open();
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Flickable{
            id: area_setting_slam
            visible: select_category==3?true:false
            width: 880
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 120
            height: parent.height - 200
            contentHeight: column_setting3.height
            clip: true
            ScrollBar.vertical: ScrollBar{
                width: 20
                anchors.right: parent.right
                policy: ScrollBar.AlwaysOn
            }
            Column{
                id:column_setting3
                width: parent.width
                spacing:25
                Rectangle{
                    width: 1100
                    height: 40
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_b.name
                        text:"카메라 설정"
                        color: "white"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    id: set_left_camera
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"left_camera"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: left_camera
                                height: parent.height
                                anchors.left: parent.left
                                anchors.right: btn_view_cam.left
                                text:supervisor.getSetting("SENSOR","left_camera");
                                readOnly: true
                            }
                            Rectangle{
                                id: btn_view_cam
                                width: 100
                                height: parent.height
                                anchors.right: parent.right
                                radius: 5
                                color: "#d0d0d0"
                                Text{
                                    anchors.centerIn: parent
                                    text: "viewer"
                                    font.pixelSize: 15
                                    font.family: font_noto_r.name

                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        popup_camera.open();

                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_right_camera
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"right_camera"
                                font.pixelSize: 20
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {

                                }
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: right_camera
                                height: parent.height
                                anchors.left: parent.left
                                anchors.right: btn_view_camr.left
                                text:supervisor.getSetting("SENSOR","right_camera");
                                readOnly: true
                            }
                            Rectangle{
                                id: btn_view_camr
                                width: 100
                                height: parent.height
                                anchors.right: parent.right
                                radius: 5
                                color: "#d0d0d0"
                                Text{
                                    anchors.centerIn: parent
                                    text: "viewer"
                                    font.pixelSize: 15
                                    font.family: font_noto_r.name
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            popup_camera.open();

                                        }
                                    }

                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_baudrate
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"baudrate"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_baudrate
                                anchors.fill: parent
                                model:[115200,256000]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_mask
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"mask"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_mask
                                        anchors.centerIn: parent
                                        text: slider_mask.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_mask
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0
                                    to: 15.0
                                    value: 10.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_max_range
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"max_range"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_max_range
                                        anchors.centerIn: parent
                                        text: slider_max_range.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_max_range
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 10.0
                                    to: 50.0
                                    value: 40.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_cam_exposure
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"cam_exposure"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_cam_exposure
                                        anchors.centerIn: parent
                                        text: slider_mask.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_cam_exposure
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0
                                    to: 4000
                                    value: 2000
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_offset_X
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"offset_x"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: offset_x
                                anchors.fill: parent
                                text:supervisor.getSetting("SENSOR","offset_x");
                                onFocusChanged: {
                                    keyboard.owner = offset_x;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_offset_y
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"offset_y"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: offset_y
                                anchors.fill: parent
                                text:supervisor.getSetting("SENSOR","offset_y");
                                onFocusChanged: {
                                    keyboard.owner = offset_y;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_left_camera_tf
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"left_camera_tf"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                anchors.fill: parent
                                TextField{
                                    id: left_camera_tf
                                    width: parent.width*0.7
                                    height: parent.height
    //                                anchors.fill: parent
                                    text:supervisor.getSetting("SENSOR","left_camera_tf");
                                }
                                Rectangle{
                                    width: parent.widht*0.2
                                    height: parent.height
                                    radius: 5
                                    color: "black"
                                    Text{
                                        anchors.centerIn: parent
                                        text: "change"
                                        color: "white"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{

                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_right_camera_tf
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"right_camera_tf"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                anchors.fill: parent
                                TextField{
                                    id: right_camera_tf
                                    width: parent.width*0.7
                                    height: parent.height
    //                                anchors.fill: parent
                                    text:supervisor.getSetting("SENSOR","right_camera_tf");
                                }
                                Rectangle{
                                    width: parent.widht*0.2
                                    height: parent.height
                                    radius: 5
                                    color: "black"
                                    Text{
                                        anchors.centerIn: parent
                                        text: "change"
                                        color: "white"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{

                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    width: 1100
                    height: 40
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_b.name
                        text:"속도 설정"
                        color: "white"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    id: set_limitpivot
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"limit_pivot"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_pivot
                                        anchors.centerIn: parent
                                        text: slider_limit_pivot.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_pivot
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 5.0
                                    to: 90.0
                                    value: 45.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limitv
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"limit_v"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_v
                                        anchors.centerIn: parent
                                        text: slider_limit_v.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_v
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.1
                                    to: 2.0
                                    value: 1.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limit_vacc
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"limit_v_acc"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_v_acc
                                        anchors.centerIn: parent
                                        text: slider_limit_v_acc.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_v_acc
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.1
                                    to: 2.0
                                    value: 1.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limitw
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"limit_w"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_w
                                        anchors.centerIn: parent
                                        text: slider_limit_w.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_w
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 5.0
                                    to: 120.0
                                    value: 120.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limitwacc
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"limit_w_acc"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_w_acc
                                        anchors.centerIn: parent
                                        text: slider_limit_w_acc.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_w_acc
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 5.0
                                    to: 360.0
                                    value: 360.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: setlimitmanualv
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"limit_manual_v"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_manual_v
                                        anchors.centerIn: parent
                                        text: slider_limit_manual_v.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_manual_v
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.1
                                    to: 2.0
                                    value: 0.3
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: setlimitmanualw
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"limit_manual_w"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_manual_w
                                        anchors.centerIn: parent
                                        text: slider_limit_manual_w.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_manual_w
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 5.0
                                    to: 120.0
                                    value: 120.0
                                }
                            }
                        }
                    }
                }

                Rectangle{
                    id: set_st_v
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"st_v"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_st_v
                                        anchors.centerIn: parent
                                        text: slider_st_v.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_st_v
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 1.0
                                    value: 0.3
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    width: 1100
                    height: 40
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_b.name
                        text:"SLAM 설정"
                        color: "white"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    id: set_kv
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"k_v"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_k_v
                                        anchors.centerIn: parent
                                        text: slider_k_v.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_k_v
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.1
                                    to: 2.0
                                    value: 0.7
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_kw
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"k_w"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_k_w
                                        anchors.centerIn: parent
                                        text: slider_k_w.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_k_w
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 1.0
                                    to: 5.0
                                    value: 2.5
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_lookaheaddist
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"look_ahead_dist"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_look_ahead_dist
                                        anchors.centerIn: parent
                                        text: slider_look_ahead_dist.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_look_ahead_dist
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.3
                                    to: 1.0
                                    value: 0.45
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_minlookaheaddist
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"min_look_ahead_dist"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_min_look_ahead_dist
                                        anchors.centerIn: parent
                                        text: slider_min_look_ahead_dist.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_min_look_ahead_dist
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 0.5
                                    value: 0.1
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_narrow_decel_ratio
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"narrow_decel_ratio"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_narrow_decel_ratio
                                        anchors.centerIn: parent
                                        text: slider_narrow_decel_ratio.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_narrow_decel_ratio
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 1.0
                                    value: 0.5
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_obs_deadzone
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"obs_deadzone"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_obs_deadzone
                                        anchors.centerIn: parent
                                        text: slider_obs_deadzone.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_obs_deadzone
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 1.0
                                    value: 0.4
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_obs_wait_time
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"obs_wait_time"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_obs_wait_time
                                        anchors.centerIn: parent
                                        text: slider_obs_wait_time.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_obs_wait_time
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 20.0
                                    value: 5.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_path_out_dist
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"path_out_dist"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_path_out_dist
                                        anchors.centerIn: parent
                                        text: slider_path_out_dist.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_path_out_dist
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 3.0
                                    value: 1.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    width: 1100
                    height: 40
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_b.name
                        text:"ICP 설정"
                        color: "white"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    id: set_icp_dist
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"icp_dist"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_icp_dist
                                        anchors.centerIn: parent
                                        text: slider_icp_dist.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_dist
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 1.0
                                    value: 0.5
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_icp_error
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"icp_error"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_icp_error
                                        anchors.centerIn: parent
                                        text: slider_icp_error.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_error
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 1.0
                                    value: 0.1
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_icp_near
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"icp_near"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_icp_near
                                        anchors.centerIn: parent
                                        text: slider_icp_near.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_near
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 2.0
                                    value: 1.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_icp_odometry_weight
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"icp_odometry_weight"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_icp_odometry_weight
                                        anchors.centerIn: parent
                                        text: slider_icp_odometry_weight.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_odometry_weight
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 1.0
                                    value: 0.5
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_icp_ratio
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"icp_ratio"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_icp_ratio
                                        anchors.centerIn: parent
                                        text: slider_icp_ratio.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_ratio
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 1.0
                                    value: 0.5
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_icp_repeat_dist
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"icp_repeat_dist"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_icp_repeat_dist
                                        anchors.centerIn: parent
                                        text: slider_icp_repeat_dist.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_repeat_dist
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 0.3
                                    value: 0.15
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_icp_repeat_time
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"icp_repeat_time"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_icp_repeat_time
                                        anchors.centerIn: parent
                                        text: slider_icp_repeat_time.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_repeat_time
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 5.0
                                    value: 1.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    width: 1100
                    height: 40
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_b.name
                        text:"GOAL 설정"
                        color: "white"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    id: set_goal_dist
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"goal_dist"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_goal_dist
                                        anchors.centerIn: parent
                                        text: slider_goal_dist.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_goal_dist
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 0.5
                                    value: 0.1
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_goal_v
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"goal_v"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_goal_v
                                        anchors.centerIn: parent
                                        text: slider_goal_v.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_goal_v
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 0.3
                                    value: 0.05
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_goal_th
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"goal_th"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_goal_th
                                        anchors.centerIn: parent
                                        text: slider_goal_th.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_goal_th
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 1.0
                                    to: 10.0
                                    value: 3.0
                                }
                            }
                        }
                    }
                }

                Rectangle{
                    id: set_goal_near_dist
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"goal_near_dist"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_goal_near_dist
                                        anchors.centerIn: parent
                                        text: slider_goal_near_dist.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_goal_near_dist
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 3.0
                                    value: 0.5
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_goal_near_th
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"goal_near_th"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_goal_near_th
                                        anchors.centerIn: parent
                                        text: slider_goal_near_th.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_goal_near_th
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.0
                                    to: 10.0
                                    value: 3.0
                                }
                            }
                        }
                    }
                }
            }
        }

        Flickable{
            id: area_setting_motor
            visible: select_category==4?true:false
            width: 880
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 120
            height: parent.height - 200
            contentHeight: column_setting4.height
            clip: true
            ScrollBar.vertical: ScrollBar{
                width: 20
                anchors.right: parent.right
                policy: ScrollBar.AlwaysOn
            }

            Rectangle{
                id: rect_motor_1
                width: 1100
                height: 40
                color: "black"
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_b.name
                    text:"모터 상태"
                    color: "white"
                    font.pixelSize: 20
                }
            }
            Rectangle{
                id: rect_motor_2
                anchors.top: rect_motor_1.bottom
                anchors.topMargin: 3
                width: 840
                color: "transparent"
                height: 20
                Row{
                    anchors.fill: parent
                    Rectangle{
                        width: 350
                        color: "transparent"
                        height: parent.height
                    }
                    Rectangle{
                        width: 1
                        height: parent.height
                        color: "transparent"
                    }
                    Rectangle{
                        width: (parent.width - 351)/2
                        height: parent.height
                        color: "transparent"
                        Rectangle{
                            anchors.centerIn: parent
                            height: parent.height
                            width: parent.width*0.8
                            color: color_navy
                            Text{
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:"모터 좌측"
                                color: "white"
                                font.pixelSize: 15
                            }
                        }

                    }
                    Rectangle{
                        width: (parent.width - 351)/2
                        height: parent.height
                        color: "transparent"
                        Rectangle{
                            anchors.centerIn: parent
                            height: parent.height
                            width: parent.width*0.8
                            color: color_navy
                            Text{
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:"모터 우측"
                                color: "white"
                                font.pixelSize: 15
                            }
                        }
                    }
                }
            }
            Column{
                id:column_setting4
                width: parent.width
                anchors.top: rect_motor_2.bottom
                anchors.topMargin: 2
                spacing:25
                Rectangle{
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"모터 연결상태"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: (parent.width - 351)/2
                            height: parent.height
                            color: "transparent"
                            Rectangle{
                                id: rect_connection_0
                                height: parent.height
                                anchors.centerIn: parent
                                width: parent.width*0.8
                                color: supervisor.getMotorConnection(motor_left_id)?color_green:color_red
                                Text{
                                    id: text_connection_0
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    text:supervisor.getMotorConnection(motor_left_id)?"연결됨":"연결안됨"
                                    font.pixelSize: 15
                                }
                            }
                        }
                        Rectangle{
                            width: (parent.width - 351)/2
                            height: parent.height
                            color: "transparent"
                            Rectangle{
                                id: rect_connection_1
                                height: parent.height
                                anchors.centerIn: parent
                                width: parent.width*0.8
                                color: supervisor.getMotorConnection(motor_right_id)?color_green:color_red
                                Text{
                                    id: text_connection_1
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    text:supervisor.getMotorConnection(motor_right_id)?"연결됨":"연결안됨"
                                    font.pixelSize: 15
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"모터 상태"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: (parent.width - 351)/2
                            height: parent.height
                            Text{
                                id: text_status_0
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:supervisor.getMotorStatus(0).toString()
                                font.pixelSize: 15
                            }
                        }
                        Rectangle{
                            width: (parent.width - 351)/2
                            height: parent.height
                            Text{
                                id: text_status_1
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:supervisor.getMotorStatus(1).toString()
                                font.pixelSize: 15
                            }
                        }
                    }
                }
                Rectangle{
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"모터 온도"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: (parent.width - 351)/2
                            height: parent.height
                            Text{
                                id: text_temp_0
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:supervisor.getMotorTemperature(0).toString()
                                font.pixelSize: 15
                            }
                        }
                        Rectangle{
                            width: (parent.width - 351)/2
                            height: parent.height
                            Text{
                                id: text_temp_1
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:supervisor.getMotorTemperature(1).toString()
                                font.pixelSize: 15
                            }
                        }
                    }
                }
                Rectangle{
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"모터 내부 온도"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: (parent.width - 351)/2
                            height: parent.height
                            Text{
                                id: text_temp_0_1
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:supervisor.getMotorInsideTemperature(0).toString()
                                font.pixelSize: 15
                            }
                        }
                        Rectangle{
                            width: (parent.width - 351)/2
                            height: parent.height
                            Text{
                                id: text_temp_1_1
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:supervisor.getMotorInsideTemperature(1).toString()
                                font.pixelSize: 15
                            }
                        }
                    }
                }
                Rectangle{
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"모터 전류"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: (parent.width - 351)/2
                            height: parent.height
                            Text{
                                id: text_cur_0
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:supervisor.getMotorCurrent(0).toString()
                                font.pixelSize: 15
                            }
                        }
                        Rectangle{
                            width: (parent.width - 351)/2
                            height: parent.height
                            Text{
                                id: text_cur_1
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:supervisor.getMotorCurrent(1).toString()
                                font.pixelSize: 15
                            }
                        }
                    }
                }

                Rectangle{
                    width: 1100
                    height: 40
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_b.name
                        text:"로봇 상태"
                        color: "white"
                        font.pixelSize: 20
                    }
                }

                Rectangle{
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"상태값"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: (parent.width - 351)/4
                            height: parent.height
                            Text{
                                id: text_status_charging
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:"Charging : "+supervisor.getChargeStatus().toString()
                                font.pixelSize: 15
                            }
                        }
                        Rectangle{
                            width: (parent.width - 351)/4
                            height: parent.height
                            Text{
                                id: text_status_power
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:"Power : "+supervisor.getPowerStatus().toString()
                                font.pixelSize: 15
                            }
                        }
                        Rectangle{
                            width: (parent.width - 351)/4
                            height: parent.height
                            Text{
                                id: text_status_emo
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:"Emo : "+supervisor.getEmoStatus().toString()
                                font.pixelSize: 15
                            }
                        }
                        Rectangle{
                            width: (parent.width - 351)/4
                            height: parent.height
                            Text{
                                id: text_status_remote
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:"Remote : "+supervisor.getRemoteStatus().toString()
                                font.pixelSize: 15
                            }
                        }
                    }
                }
                Rectangle{
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"배터리"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: (parent.width - 351)/3
                            height: parent.height
                            Text{
                                id: text_battery_in
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:"In : "+supervisor.getBatteryIn().toString()
                                font.pixelSize: 15
                            }
                        }
                        Rectangle{
                            width: (parent.width - 351)/3
                            height: parent.height
                            Text{
                                id: text_battery_out
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:"Out : "+supervisor.getBatteryOut().toString()
                                font.pixelSize: 15
                            }
                        }
                        Rectangle{
                            width: (parent.width - 351)/3
                            height: parent.height
                            Text{
                                id: text_battery_current
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:"Current : "+supervisor.getBatteryCurrent().toString()
                                font.pixelSize: 15
                            }
                        }
                    }
                }
                Rectangle{
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"Power"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: (parent.width - 351)/2
                            height: parent.height
                            Text{
                                id: text_power
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:"Power : "+supervisor.getPower().toString()
                                font.pixelSize: 15
                            }
                        }
                        Rectangle{
                            width: (parent.width - 351)/2
                            height: parent.height
                            Text{
                                id: text_power_total
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:"Total : "+supervisor.getPowerTotal().toString()
                                font.pixelSize: 15
                            }
                        }
                    }
                }

                Rectangle{
                    width: 1100
                    height: 40
                    color: "black"
                    visible: is_admin
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_b.name
                        text:"세팅 값"
                        color: "white"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    id: set_wheel_dir
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"모터 방향"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_wheel_dir
                                anchors.fill: parent
                                model: [-1,1]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_left_id
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"left_id"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_left_id
                                anchors.fill: parent
                                model:[0,1]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_right_id
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"right_id"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_right_id
                                anchors.fill: parent
                                model:[0,1]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_gear_ratio
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"gear_ratio"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: gear_ratio
                                anchors.fill: parent
                                text: supervisor.getSetting("MOTOR","gear_ratio");
                                onFocusChanged: {
                                    keyboard.owner = gear_ratio;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_kp
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"k_p"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: k_p
                                anchors.fill: parent
                                text: supervisor.getSetting("MOTOR","k_p");
                                onFocusChanged: {
                                    keyboard.owner = k_p;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_ki
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"k_i"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: k_i
                                anchors.fill: parent
                                text: supervisor.getSetting("MOTOR","k_i");
                                onFocusChanged: {
                                    keyboard.owner = k_i;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_kd
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"k_d"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: k_d
                                anchors.fill: parent
                                text: supervisor.getSetting("MOTOR","k_d");
                                onFocusChanged: {
                                    keyboard.owner = k_d;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limit_v
                    width: 840
                    visible: is_admin
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"limit_v"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: limit_v
                                anchors.fill: parent
                                text: supervisor.getSetting("MOTOR","limit_v");
                                onFocusChanged: {
                                    keyboard.owner = limit_v;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limitv_acc
                    width: 840
                    visible: is_admin
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"limit_v_acc"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: limit_v_acc
                                anchors.fill: parent
                                text: supervisor.getSetting("MOTOR","limit_v_acc");
                                onFocusChanged: {
                                    keyboard.owner = limit_v_acc;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limit_w
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"limit_w"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: limit_w
                                anchors.fill: parent
                                text: supervisor.getSetting("MOTOR","limit_w");
                                onFocusChanged: {
                                    keyboard.owner = limit_w;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limit_wacc
                    width: 840
                    height: 40
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"limit_w_acc"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: limit_w_acc
                                anchors.fill: parent
                                text: supervisor.getSetting("MOTOR","limit_w_acc");
                                onFocusChanged: {
                                    keyboard.owner = limit_w_acc;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Rectangle{
            id: btn_menu
            width: 120
            height: width
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.top: parent.top
            anchors.topMargin: 50
            color: "transparent"
            radius: 30
            Behavior on width{
                NumberAnimation{
                    duration: 500;
                }
            }
            Image{
                id: image_btn_menu
                source:"icon/btn_reset2.png"
                scale: 1-(120-parent.width)/120
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    supervisor.writelog("[USER INPUT] SETTING PAGE -> BACKPAGE");
                    backPage();
                }
            }
        }

        Column{
            anchors.bottom: area_setting_robot.bottom
            anchors.right: parent.right
            anchors.rightMargin: (parent.width - area_setting_robot.width - area_setting_robot.x - btn_default.width)/2
            spacing: 30
            Rectangle{
                id: btn_update
                width: 180
                height: 60
                radius: 10
                color:"transparent"
                border.width: 1
                border.color: "#7e7e7e"
                Text{
                    anchors.centerIn: parent
                    text: "Program Update"
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        supervisor.writelog("[USER INPUT] SETTING PAGE -> PROGRAM UPDATE");
                        popup_update.open();
                    }
                }
            }
            Rectangle{
                id: btn_log
                width: 180
                height: 60
                radius: 10
                color:"transparent"
                border.width: 1
                border.color: "#7e7e7e"
                Text{
                    anchors.centerIn: parent
                    text: "Log"
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        supervisor.writelog("[USER INPUT] SETTING PAGE -> LOG");
                        loader_page.source = plog;
                    }
                }
            }
            Rectangle{
                id: btn_reset_slam
                width: 180
                height: 60
                radius: 10
                color:"transparent"
                border.width: 1
                border.color: "#7e7e7e"
                Text{
                    anchors.centerIn: parent
                    text: "SLAM restart"
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        supervisor.writelog("[USER INPUT] SETTING PAGE -> RESTART SLAM");
                        supervisor.restartSLAM();
                    }
                }
            }
            Rectangle{
                id: btn_default
                width: 180
                height: 60
                radius: 10
                color:"transparent"
                border.width: 1
                border.color: "#7e7e7e"
                Text{
                    anchors.centerIn: parent
                    text: "초기화"
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        supervisor.writelog("[USER INPUT] SETTING PAGE -> RESET DEFAULT");
                        init();
                    }
                }
            }
            Rectangle{
                id: btn_confirm
                width: 180
                height: 60
                radius: 10
                color: "#12d27c"
                border.width: 1
                border.color: "#12d27c"
                Text{
                    anchors.centerIn: parent
                    text: "Confirm"
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                    color: "white"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        supervisor.writelog("[USER INPUT] SETTING PAGE -> SETTING CHANGE");
                        supervisor.setSetting("ROBOT_HW/model",platform_name.text);
                        supervisor.setSetting("ROBOT_HW/serial_num",combo_platform_serial.currentText);
                        supervisor.setSetting("ROBOT_SW/robot_id",combo_platform_id.currentText);
                        supervisor.setSetting("ROBOT_HW/radius",radius.text);
                        supervisor.setSetting("ROBOT_HW/tray_num",combo_tray_num.currentText);

                        if(combo_platform_type.currentIndex == 0){
                            supervisor.setSetting("ROBOT_HW/type","SERVING");
                        }else if(combo_platform_type.currentIndex == 1){
                            supervisor.setSetting("ROBOT_HW/type","CALLING");
                        }

                        supervisor.setSetting("ROBOT_HW/wheel_base",wheel_base.text);
                        supervisor.setSetting("ROBOT_HW/wheel_radius",wheel_radius.text);

//                        supervisor.setSetting("ROBOT_SW/k_curve",text_k_curve.text);
                        supervisor.setSetting("ROBOT_SW/k_v",text_k_v.text);
                        supervisor.setSetting("ROBOT_SW/k_w",text_k_w.text);
                        supervisor.setSetting("ROBOT_SW/limit_pivot",text_limit_pivot.text);
                        supervisor.setSetting("ROBOT_SW/limit_v",text_limit_v.text);
                        supervisor.setSetting("ROBOT_SW/limit_w",text_limit_w.text);
                        supervisor.setSetting("ROBOT_SW/limit_v_acc",text_limit_v_acc.text);
                        supervisor.setSetting("ROBOT_SW/limit_w_acc",text_limit_w_acc.text);

                        supervisor.setSetting("ROBOT_SW/limit_manual_v",text_limit_manual_v.text);
                        supervisor.setSetting("ROBOT_SW/limit_manual_w",text_limit_manual_w.text);
                        supervisor.setSetting("ROBOT_SW/look_ahead_dist",text_look_ahead_dist.text);

                        supervisor.setSetting("ROBOT_SW/icp_dist",text_icp_dist.text);
                        supervisor.setSetting("ROBOT_SW/icp_error",text_icp_error.text);
                        supervisor.setSetting("ROBOT_SW/icp_near",text_icp_near.text);
                        supervisor.setSetting("ROBOT_SW/icp_odometry_weight",text_icp_odometry_weight.text);
                        supervisor.setSetting("ROBOT_SW/icp_ratio",text_icp_ratio.text);
                        supervisor.setSetting("ROBOT_SW/icp_repeat_dist",text_icp_repeat_dist.text);
                        supervisor.setSetting("ROBOT_SW/icp_repeat_time",text_icp_repeat_time.text);
                        supervisor.setSetting("ROBOT_SW/obs_deadzone",text_obs_deadzone.text);
                        supervisor.setSetting("ROBOT_SW/narrow_decel_ratio",text_narrow_decel_ratio.text);
                        supervisor.setSetting("ROBOT_SW/obs_wait_time",text_obs_wait_time.text);
                        supervisor.setSetting("ROBOT_SW/path_out_dist",text_path_out_dist.text);
                        supervisor.setSetting("ROBOT_SW/st_v",text_st_v.text);
                        supervisor.setSetting("ROBOT_SW/min_look_ahead_dist",text_min_look_ahead_dist.text);
                        supervisor.setSetting("ROBOT_SW/goal_dist",text_goal_dist.text);
                        supervisor.setSetting("ROBOT_SW/goal_th",text_goal_th.text);
                        supervisor.setSetting("ROBOT_SW/goal_v",text_goal_v.text);
                        supervisor.setSetting("ROBOT_SW/goal_near_dist",text_goal_near_dist.text);
                        supervisor.setSetting("ROBOT_SW/goal_near_th",text_goal_near_th.text);

                        supervisor.setSetting("ROBOT_SW/grid_size",grid_size.text);

                        supervisor.setSetting("ROBOT_SW/map_size",map_size.text);

                        supervisor.setSetting("ROBOT_SW/volume_bgm",slider_volume_bgm.value.toFixed(0));
                        supervisor.setSetting("ROBOT_SW/volume_voice",slider_volume_voice.value.toFixed(0));

                        if(combo_use_uicmd.currentIndex == 0)
                            supervisor.setSetting("ROBOT_SW/use_uicmd","false");
                        else
                            supervisor.setSetting("ROBOT_SW/use_uicmd","true");

                        if(combo_multirobot.currentIndex == 0)
                            supervisor.setSetting("ROBOT_SW/use_multirobot","false");
                        else
                            supervisor.setSetting("ROBOT_SW/use_multirobot","true");


                        supervisor.setSetting("ROBOT_SW/velocity",text_velocity.text);

                        if(combo_autoinit.currentIndex == 0)
                            supervisor.setSetting("ROBOT_SW/use_autoinit","false");
                        else
                            supervisor.setSetting("ROBOT_SW/use_autoinit","true");

                        if(combo_avoid.currentIndex == 0)
                            supervisor.setSetting("ROBOT_SW/use_avoid","false");
                        else
                            supervisor.setSetting("ROBOT_SW/use_avoid","true");

                        supervisor.setSetting("SENSOR/baudrate",combo_baudrate.currentText);
                        supervisor.setSetting("SENSOR/mask",text_mask.text);
                        supervisor.setSetting("SENSOR/max_range",text_max_range.text);
                        supervisor.setSetting("SENSOR/offset_x",offset_x.text);
                        supervisor.setSetting("SENSOR/offset_y",offset_y.text);
                        supervisor.setSetting("SENSOR/right_camera",right_camera.text);
                        supervisor.setSetting("SENSOR/left_camera",left_camera.text);
                        supervisor.setSetting("SENSOR/left_camera_tf",left_camera_tf.text);
                        supervisor.setSetting("SENSOR/right_camera_tf",right_camera_tf.text);
                        supervisor.setSetting("SENSOR/cam_exposure",text_cam_exposure.text);


                        supervisor.setSetting("MOTOR/gear_ratio",gear_ratio.text);
                        supervisor.setSetting("MOTOR/k_d",k_d.text);
                        supervisor.setSetting("MOTOR/k_i",k_i.text);
                        supervisor.setSetting("MOTOR/k_p",k_p.text);

                        supervisor.setSetting("MOTOR/limit_v",limit_v.text);
                        supervisor.setSetting("MOTOR/limit_v_acc",limit_v_acc.text);
                        supervisor.setSetting("MOTOR/limit_w",limit_w.text);
                        supervisor.setSetting("MOTOR/limit_w_acc",limit_w_acc.text);

                        supervisor.setSetting("MOTOR/left_id",combo_left_id.currentText);
                        supervisor.setSetting("MOTOR/right_id",combo_right_id.currentText);
                        supervisor.setSetting("MOTOR/wheel_dir",combo_wheel_dir.currentText);
                        supervisor.setTableNum(combo_table_num.currentIndex);

                        supervisor.setSetting("CALLING/call_num",combo_call_num.currentText);
                        supervisor.setSetting("CALLING/call_maximum",combo_call_max.currentText);

                        supervisor.readSetting();
                        supervisor.restartSLAM();
                        init();
                    }
                }
            }
        }
    }


    function init(){
        supervisor.writelog("[QML] SETTING PAGE init");
        platform_name.text = supervisor.getSetting("ROBOT_HW","model");
        combo_platform_serial.currentIndex = parseInt(supervisor.getSetting("ROBOT_HW","serial_num"))
        combo_platform_id.currentIndex = parseInt(supervisor.getSetting("ROBOT_SW","robot_id"))
        radius.text = supervisor.getSetting("ROBOT_HW","radius");

        combo_tray_num.currentIndex = supervisor.getSetting("ROBOT_HW","tray_num")-1;

        if(supervisor.getSetting("ROBOT_HW","type") === "SERVING"){
            combo_platform_type.currentIndex = 0;
        }else{
            combo_platform_type.currentIndex = 1;
        }
        wheel_base.text = supervisor.getSetting("ROBOT_HW","wheel_base");
        wheel_radius.text = supervisor.getSetting("ROBOT_HW","wheel_radius");

        map_name.text = supervisor.getMapname();
        grid_size.text = supervisor.getSetting("ROBOT_SW","grid_size");
        map_size.text = supervisor.getSetting("ROBOT_SW","map_size");


        left_camera_tf.text = supervisor.getSetting("SENSOR","left_camera_tf");
        right_camera_tf.text = supervisor.getSetting("SENSOR","right_camera_tf");
        slider_cam_exposure.value = parseFloat(supervisor.getSetting("SENSOR","cam_exposure"));

        slider_icp_dist.value = parseFloat(supervisor.getSetting("ROBOT_SW","icp_dist"));
        slider_icp_error.value = parseFloat(supervisor.getSetting("ROBOT_SW","icp_error"));
        slider_icp_near.value = parseFloat(supervisor.getSetting("ROBOT_SW","icp_near"));
        slider_icp_odometry_weight.value = parseFloat(supervisor.getSetting("ROBOT_SW","icp_odometry_weight"));
        slider_icp_ratio.value = parseFloat(supervisor.getSetting("ROBOT_SW","icp_ratio"));
        slider_icp_repeat_dist.value = parseFloat(supervisor.getSetting("ROBOT_SW","icp_repeat_dist"));
        slider_icp_repeat_time.value = parseFloat(supervisor.getSetting("ROBOT_SW","icp_repeat_time"));
        slider_narrow_decel_ratio.value = parseFloat(supervisor.getSetting("ROBOT_SW","narrow_decel_ratio"));
        slider_obs_deadzone.value = parseFloat(supervisor.getSetting("ROBOT_SW","obs_deadzone"));
        slider_obs_wait_time.value = parseFloat(supervisor.getSetting("ROBOT_SW","obs_wait_time"));
        slider_path_out_dist.value = parseFloat(supervisor.getSetting("ROBOT_SW","path_out_dist"));
        slider_st_v.value = parseFloat(supervisor.getSetting("ROBOT_SW","st_v"));
        slider_min_look_ahead_dist.value = parseFloat(supervisor.getSetting("ROBOT_SW","min_look_ahead_dist"));
        slider_goal_dist.value = parseFloat(supervisor.getSetting("ROBOT_SW","goal_dist"));
        slider_goal_th.value = parseFloat(supervisor.getSetting("ROBOT_SW","goal_th"));
        slider_goal_v.value = parseFloat(supervisor.getSetting("ROBOT_SW","goal_v"));
        slider_goal_near_dist.value = parseFloat(supervisor.getSetting("ROBOT_SW","goal_near_dist"));
        slider_goal_near_th.value = parseFloat(supervisor.getSetting("ROBOT_SW","goal_near_th"));


//        slider_k_curve.value = parseFloat(supervisor.getSetting("ROBOT_SW","k_curve"));
        slider_k_v.value = parseFloat(supervisor.getSetting("ROBOT_SW","k_v"));
        slider_k_w.value = parseFloat(supervisor.getSetting("ROBOT_SW","k_w"));
        slider_limit_pivot.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_pivot"));
        slider_limit_manual_v.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_manual_v"));
        slider_limit_manual_w.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_manual_w"));
        slider_limit_v.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_v"));
        slider_limit_w.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_w"));
        slider_limit_v_acc.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_v_acc"));
        slider_limit_w_acc.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_w_acc"));
        slider_look_ahead_dist.value = parseFloat(supervisor.getSetting("ROBOT_SW","look_ahead_dist"));

        slider_volume_bgm.value = Number(supervisor.getSetting("ROBOT_SW","volume_bgm"));
        slider_volume_voice.value = Number(supervisor.getSetting("ROBOT_SW","volume_voice"));


        text_preset_name_1.text = supervisor.getSetting("PRESET1","name");
        text_preset_name_2.text = supervisor.getSetting("PRESET2","name");
        text_preset_name_3.text = supervisor.getSetting("PRESET3","name");

        if(supervisor.getSetting("ROBOT_SW","use_uicmd") === "true"){
            combo_use_uicmd.currentIndex = 1;
        }else{
            combo_use_uicmd.currentIndex = 0;
        }
        if(supervisor.getSetting("ROBOT_SW","use_multirobot") === "true"){
            combo_multirobot.currentIndex = 1;
        }else{
            combo_multirobot.currentIndex = 0;
        }

        slider_vxy.value = parseFloat(supervisor.getSetting("ROBOT_SW","velocity"));
        combo_table_num.currentIndex = supervisor.getTableNum();

        gear_ratio.text = supervisor.getSetting("MOTOR","gear_ratio");
        k_d.text = supervisor.getSetting("MOTOR","k_d");
        k_i.text = supervisor.getSetting("MOTOR","k_i");
        k_p.text = supervisor.getSetting("MOTOR","k_p");

        limit_v.text = supervisor.getSetting("MOTOR","limit_v");
        limit_v_acc.text = supervisor.getSetting("MOTOR","limit_v_acc");
        limit_w.text = supervisor.getSetting("MOTOR","limit_w");
        limit_w_acc.text = supervisor.getSetting("MOTOR","limit_w_acc");

        combo_left_id.currentIndex = parseInt(supervisor.getSetting("MOTOR","left_id"));
        combo_right_id.currentIndex = parseInt(supervisor.getSetting("MOTOR","right_id"));

        if(supervisor.getSetting("MOTOR","wheel_dir") === "-1"){
            combo_wheel_dir.currentIndex = 0;
        }else{
            combo_wheel_dir.currentIndex = 1;
        }

        if(supervisor.getSetting("ROBOT_SW","use_autoinit") === "true"){
            combo_autoinit.currentIndex = 1;
        }else{
            combo_autoinit.currentIndex = 0;
        }

        if(supervisor.getSetting("ROBOT_SW","use_avoid") === "true"){
            combo_avoid.currentIndex = 1;
        }else{
            combo_avoid.currentIndex = 0;
        }

        if(supervisor.getSetting("SENSOR","baudrate") === "115200"){
            combo_baudrate.currentIndex = 0;
        }else if(supervisor.getSetting("SENSOR","baudrate") === "256000"){
            combo_baudrate.currentIndex = 1;
        }

        combo_call_max.currentIndex = parseInt(supervisor.getSetting("CALLING","call_maximum"))-1;
        combo_call_num.currentIndex = parseInt(supervisor.getSetting("CALLING","call_num"));

        model_callbell.clear();
        for(var i=0; i<combo_call_num.currentIndex; i++){
            model_callbell.append({name:supervisor.getSetting("CALLING","call_"+Number(i))});
        }



        slider_mask.value = parseFloat(supervisor.getSetting("SENSOR","mask"));
        slider_max_range.value = parseFloat(supervisor.getSetting("SENSOR","max_range"));
        offset_x.text = supervisor.getSetting("SENSOR","offset_x");
        offset_y.text = supervisor.getSetting("SENSOR","offset_y");
        right_camera.text = supervisor.getSetting("SENSOR","right_camera");
        left_camera.text = supervisor.getSetting("SENSOR","left_camera");
    }

    Timer{
        running: true
        interval: 500
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            motor_left_id = parseInt(supervisor.getSetting("MOTOR","left_id"));
            motor_right_id = parseInt(supervisor.getSetting("MOTOR","right_id"));

            if(supervisor.getMotorConnection(motor_left_id)){
                rect_connection_0.color = color_green;
                text_connection_0.text = "연결됨"
            }else{
                rect_connection_0.color = color_red;
                text_connection_0.text = "연결안됨"
            }
            if(supervisor.getMotorConnection(motor_right_id)){
                rect_connection_1.color = color_green;
                text_connection_1.text = "연결됨"
            }else{
                rect_connection_1.color = color_red;
                text_connection_1.text = "연결안됨"
            }
            text_status_0.text = supervisor.getMotorStatus(motor_left_id).toString();
            text_status_1.text = supervisor.getMotorStatus(motor_right_id).toString();

            text_temp_0.text = supervisor.getMotorTemperature(motor_left_id).toString();
            text_temp_1.text = supervisor.getMotorTemperature(motor_right_id).toString();
            text_cur_0.text = supervisor.getMotorCurrent(motor_left_id).toString();
            text_cur_1.text = supervisor.getMotorCurrent(motor_right_id).toString();

            text_status_charging.text = "Charge : " + supervisor.getChargeStatus().toString();
            text_status_power.text = "Power : " + supervisor.getPowerStatus().toString();
            text_status_emo.text = "Emo : " + supervisor.getEmoStatus().toString();
            text_status_remote.text = "Remote : " + supervisor.getRemoteStatus().toString();

            text_battery_in.text = "In : " + supervisor.getBatteryIn().toFixed(1).toString();
            text_battery_out.text = "Out : " + supervisor.getBatteryOut().toFixed(1).toString();
            text_battery_current.text = "Current : " + supervisor.getBatteryCurrent().toFixed(1).toString();

            text_power.text = "Power : " + supervisor.getPower().toString();
            text_power_total.text = "Total : " + supervisor.getPowerTotal().toString();

        }
    }

    Popup{
        id: popup_change_call
        width: 400
        height: 300
        anchors.centerIn: parent
        leftPadding: 0
        topPadding: 0
        bottomPadding: 0
        rightPadding: 0
        property var callid: 0
        onOpened: {
//            timer_popup_call.start();
            supervisor.setCallbell(callid);
        }
        onClosed: {
            supervisor.setCallbell(-1);
//            timer_popup_call.stop();
        }

        Rectangle{
            anchors.fill: parent
            Text{
                anchors.centerIn: parent
                text: "변경하실 호출벨을 눌러주세요."
                font.family: font_noto_r.name
                font.pixelSize: 25
            }
        }
        Timer{
            id: timer_popup_call
            interval: 300
            running: false
            repeat: true
            onTriggered: {
                print("hello " + Number(popup_change_call.callid))
            }
        }
    }

    Popup{
        id: popup_reset
        width: 400
        height: 300
        anchors.centerIn: parent
        leftPadding: 0
        topPadding: 0
        bottomPadding: 0
        rightPadding: 0
        Rectangle{
            anchors.fill: parent
            Column{
                anchors.centerIn: parent
                spacing: 20
                Text{
                    text: "정말 덮어씌우시겠습니까?"
                    font.family: font_noto_b.name
                    font.pixelSize: 20

                }
                Rectangle{
                    width: 100
                    height: 50
                    border.width: 1
                    radius: 5
                    Text{
                        anchors.centerIn: parent
                        text: "확인"
                        font.family: font_noto_r.name
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            supervisor.writelog("[USER INPUT] RESET HOME FOLDERS")
                            supervisor.resetHomeFolders();
                            popup_reset.close();
                        }
                    }
                }
            }
        }
    }

    Popup{
        id: popup_update
        width: 600
        height: 400
        anchors.centerIn: parent

        onOpened: {
            //버전 체크
            if(supervisor.isNewVersion()){
                supervisor.writelog("[USER INPUT] UPDATE PROGRAM -> ALREADY NEW VERSION")
                //버전이 이미 최신임
                rect_lastest.visible = true;
                rect_need_update.visible = false;
                text_version.text = supervisor.getLocalVersionDate()
            }else{
                supervisor.writelog("[USER INPUT] UPDATE PROGRAM -> CHECK NEW VERSION")
                //새로운 버전 확인됨
                rect_lastest.visible = false;
                rect_need_update.visible = true;
                text_version1.text = "현재 : " + supervisor.getLocalVersionDate()
                text_version2.text = "최신 : " + supervisor.getServerVersionDate()
            }
        }

        Rectangle{
            id: rect_lastest
            anchors.fill: parent
            radius: 5
            Text{
                id: text_1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
                font.family: font_noto_r.name
                font.pixelSize: 20
                text:"프로그램이 이미 최신입니다."
            }
            Text{
                id: text_version
                anchors.centerIn: parent
                anchors.topMargin: 50
                font.family: font_noto_r.name
                font.pixelSize: 20
                text:supervisor.getLocalVersionDate()
            }

            Rectangle{
                width: 180
                height: 60
                radius: 10
                color: "#12d27c"
                border.width: 1
                border.color: "#12d27c"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                Text{
                    anchors.centerIn: parent
                    text: "확인"
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                    color: "white"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        popup_update.close();
                    }
                }
            }
        }
        Rectangle{
            id: rect_need_update
            anchors.fill: parent
            radius: 5
            Text{
                id: text_11
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
                font.family: font_noto_r.name
                font.pixelSize: 20
                text:"새로운 버전이 확인되었습니다. 업데이트하시겠습니까?"
            }
            Column{
                anchors.centerIn: parent
                Text{
                    id: text_version1
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                    text:"현재 : "+supervisor.getLocalVersionDate()
                }
                Text{
                    id: text_version2
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                    text:"최신 : "+supervisor.getServerVersionDate()
                }
            }
            Row{
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20

                Rectangle{
                    width: 180
                    height: 60
                    radius: 10
                    color:"transparent"
                    border.width: 1
                    border.color: "#7e7e7e"
                    Text{
                        anchors.centerIn: parent
                        text: "취소"
                        font.family: font_noto_r.name
                        font.pixelSize: 25
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            popup_update.close();
                        }
                    }
                }
                Rectangle{
                    width: 180
                    height: 60
                    radius: 10
                    color: "#12d27c"
                    border.width: 1
                    border.color: "#12d27c"
                    Text{
                        anchors.centerIn: parent
                        text: "확인"
                        font.family: font_noto_r.name
                        font.pixelSize: 25
                        color: "white"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.writelog("[USER INPUT] UPDATE PROGRAM -> UPDATE START")
                            supervisor.pullGit();
                            popup_update.close();
                        }
                    }
                }
            }
        }

    }
    Popup{
        id: popup_camera
        width: parent.width
        height: parent.height
        background: Rectangle{
            opacity: 0.8
            color: "#282828"
        }
        property bool is_load: false
        property bool is_switched: false
        property var left_id: 0
        property var right_id: 1

        onOpened: {
            timer_load.start();
        }

        onClosed: {
            timer_load.stop();
        }

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
            }
        }

        Timer{
            id: timer_load
            interval: 500
            repeat: true
            running: popup_camera.opened
            onTriggered:{
                //카메라 정보 요청
                supervisor.requestCamera();
                update();
            }
        }
        Rectangle{
            anchors.centerIn: parent
            width: 800
            height: 700
            Rectangle{
                id: rect_title
                width: parent.width
                height: 70
                color: "#323744"
                Text{
                    anchors.centerIn: parent
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                    text: "카메라 정보를 확인한 후, 위치를 지정하여주세요."
                }
            }
            Rectangle{
                id: rect_remain
                width: parent.width
                height: parent.height - rect_title.height
                anchors.top: rect_title.bottom
                Column{
                    anchors.centerIn: parent
                    Rectangle{
                        width: rect_remain.width
                        height: 450
                        color: "black"
                        Grid{
                            anchors.centerIn: parent
                            columns: 2
                            rows: 3
                            horizontalItemAlignment: Grid.AlignHCenter
                            verticalItemAlignment: Grid.AlignVCenter
                            spacing: 20

                            Text{
                                id: text_left
                                text: "Left"
                                font.family: font_noto_b.name
                                font.pixelSize: 20
                                color: "white"
                            }

                            Text{
                                id: text_right
                                text: "Right"
                                font.family: font_noto_b.name
                                font.pixelSize: 20
                                color: "white"
                            }

                            CameraView{
                                id: cameraview_1
                                width: 300
                                height: 250
                            }
                            CameraView{
                                id: cameraview_2
                                width: 300
                                height: 250
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
                    Rectangle{
                        width: rect_remain.width
                        height: rect_remain.height - 450
                        Row{
                            spacing: 50
                            anchors.centerIn: parent
                            Rectangle{
                                width: 180
                                height: 60
                                radius: 10
                                color: enabled?"#12d27c":"#e9e9e9"
                                border.width: enabled?1:0
                                border.color: "#12d27c"
                                enabled: popup_camera.is_load
                                Text{
                                    anchors.centerIn: parent
                                    text: "확인"
                                    font.family: font_noto_r.name
                                    font.pixelSize: 25
                                    color: "white"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        if(popup_camera.is_switched){
                                            supervisor.writelog("[USER INPUT] SETTING PAGE : CAMERA SWITCH LEFT("+text_camera_1.text+") RIGHT("+text_camera_2.text+")");
                                            supervisor.setCamera(text_camera_1.text,text_camera_2.text);
                                        }
                                        supervisor.readSetting();
                                        init();
                                        popup_camera.close();
                                    }
                                }
                            }
                            Rectangle{
                                width: 180
                                height: 60
                                radius: 10
                                color:"transparent"
                                border.width: 1
                                border.color: "#7e7e7e"
                                Text{
                                    anchors.centerIn: parent
                                    text: "위치 바꾸기"
                                    font.family: font_noto_r.name
                                    font.pixelSize: 25
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        supervisor.writelog("[USER INPUT] SETTING PAGE : CAMERA Position Switch")
                                        popup_camera.is_switched = true;
                                        var temp_id = popup_camera.left_id;
                                        popup_camera.left_id = popup_camera.right_id;
                                        popup_camera.right_id = temp_id;
                                    }
                                }
                            }
                            Rectangle{
                                width: 180
                                height: 60
                                radius: 10
                                color:"transparent"
                                border.width: 1
                                border.color: "#7e7e7e"
                                Text{
                                    anchors.centerIn: parent
                                    text: "취소"
                                    font.family: font_noto_r.name
                                    font.pixelSize: 25
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        popup_camera.close();
                                    }
                                }
                            }
                        }
                    }

                }


            }
        }
    }

    Popup{
        id: popup_preset
        anchors.centerIn: parent
        width: 900
        height: 500
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }
        property var select_preset: 1
        onOpened:{
            update();
        }
        onClosed:{
            init();
        }

        function update(){
            text_preset_1.text = supervisor.getSetting("PRESET1","name");
            text_preset_2.text = supervisor.getSetting("PRESET2","name");
            text_preset_3.text = supervisor.getSetting("PRESET3","name");
            slider_preset_limit_pivot.value = parseFloat(supervisor.getSetting("PRESET"+Number(select_preset),"limit_pivot"));
            slider_preset_limit_v.value = parseFloat(supervisor.getSetting("PRESET"+Number(select_preset),"limit_v"));
            slider_preset_limit_vacc.value = parseFloat(supervisor.getSetting("PRESET"+Number(select_preset),"limit_v_acc"));
            slider_preset_limit_w.value = parseFloat(supervisor.getSetting("PRESET"+Number(select_preset),"limit_w"));
            slider_preset_limit_wacc.value = parseFloat(supervisor.getSetting("PRESET"+Number(select_preset),"limit_w_acc"));
        }

        Rectangle{
            width: parent.width
            height: parent.height
            radius: 10
            Column{
                Rectangle{
                    id: rect_preset_t
                    width: popup_preset.width
                    height: 80
                    color: color_dark_navy
                    Text{
                        anchors.centerIn: parent
                        color: "white"
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        font.bold: true
                        text: "로봇 프리셋 설정"
                    }
                }
                Row{
                    Rectangle{
                        id: rect_preset_l
                        width: 300
                        height: popup_preset.height - rect_preset_t.height
                        color: color_gray
                        Column{
                            anchors.centerIn: parent
                            spacing: 40
                            Row{
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 10
                                Rectangle{
                                    width: 80
                                    height: 50
                                    radius: 10
                                    Text{
                                        anchors.centerIn: parent
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                        text: "초기화"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            popup_preset.update();
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 80
                                    height: 50
                                    radius: 10
                                    Text{
                                        anchors.centerIn: parent
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                        text: "이름변경"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            popup_preset_name.open();
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 80
                                    height: 50
                                    radius: 10
                                    Text{
                                        anchors.centerIn: parent
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                        text: "저장"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            if(popup_preset.select_preset === 1){
                                                supervisor.setSetting("PRESET1/name",text_preset_1.text);
                                            }else if(popup_preset.select_preset === 2){
                                                supervisor.setSetting("PRESET2/name",text_preset_2.text);

                                            }else if(popup_preset.select_preset === 3){
                                                supervisor.setSetting("PRESET3/name",text_preset_3.text);

                                            }

                                            supervisor.setSetting("PRESET"+Number(popup_preset.select_preset)+"/limit_pivot",text_preset_limit_pivot.text);
                                            supervisor.setSetting("PRESET"+Number(popup_preset.select_preset)+"/limit_v",text_preset_limit_v.text);
                                            supervisor.setSetting("PRESET"+Number(popup_preset.select_preset)+"/limit_v_acc",text_preset_limit_vacc.text);
                                            supervisor.setSetting("PRESET"+Number(popup_preset.select_preset)+"/limit_w",text_preset_limit_w.text);
                                            supervisor.setSetting("PRESET"+Number(popup_preset.select_preset)+"/limit_w_acc",text_preset_limit_wacc.text);
                                            popup_preset.close();
                                        }
                                    }
                                }
                            }
                            Rectangle{
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: rect_preset_l.width*0.8
                                height: 70
                                radius: 5
                                border.width: popup_preset.select_preset===1?3:1
                                border.color: popup_preset.select_preset===1?color_green:"black"
                                Text{
                                    id: text_preset_1
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    font.pixelSize: 20
                                    font.bold: true
                                    text: "프리셋 1"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        popup_preset.select_preset = 1;
                                        popup_preset.update();
                                    }
                                }
                            }
                            Rectangle{
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: rect_preset_l.width*0.8
                                height: 70
                                radius: 5
                                border.width: popup_preset.select_preset===2?3:1
                                border.color: popup_preset.select_preset===2?color_green:"black"
                                Text{
                                    id: text_preset_2
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    font.pixelSize: 20
                                    font.bold: true
                                    text: "프리셋 2"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        popup_preset.select_preset = 2;
                                        popup_preset.update();
                                    }
                                }
                            }
                            Rectangle{
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: rect_preset_l.width*0.8
                                height: 70
                                radius: 5
                                border.width: popup_preset.select_preset===3?3:1
                                border.color: popup_preset.select_preset===3?color_green:"black"
                                Text{
                                    id: text_preset_3
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    font.pixelSize: 20
                                    font.bold: true
                                    text: "프리셋 3"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        popup_preset.select_preset = 3;
                                        popup_preset.update();
                                    }
                                }
                            }
                        }
                    }
                    Rectangle{
                        id: rect_preset_r
                        width: popup_preset.width - rect_preset_l.width
                        height:rect_preset_l.height
                        Column{
                            spacing: 15
                            anchors.centerIn: parent
                            Rectangle{
                                width: rect_preset_r.width*0.9
                                height: 40
                                Row{
                                    anchors.fill: parent
                                    Rectangle{
                                        width: 200
                                        height: parent.height
                                        Text{
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: parent.left
                                            anchors.leftMargin: 50
                                            font.family: font_noto_r.name
                                            text:"limit_pivot"
                                            font.pixelSize: 20
                                        }
                                    }
                                    Rectangle{
                                        width: 1
                                        height: parent.height
                                        color: "#d0d0d0"
                                    }
                                    Rectangle{
                                        width: parent.width - 200
                                        height: parent.height
                                        Row{
                                            spacing: 10
                                            anchors.centerIn: parent
                                            Rectangle{
                                                width: rr.width*0.1
                                                height: 40
                                                Text{
                                                    id: text_preset_limit_pivot
                                                    anchors.centerIn: parent
                                                    text: slider_preset_limit_pivot.value.toFixed(1)
                                                    font.pixelSize: 15
                                                    font.family: font_noto_r.name
                                                }
                                            }
                                            Slider{
                                                id: slider_preset_limit_pivot
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: rr.width*0.6
                                                height: 40
                                                from: 5.0
                                                to: 90.0
                                                value: 45.0
                                            }
                                        }
                                    }
                                }
                            }
                            Rectangle{
                                width: rect_preset_r.width*0.9
                                height: 40
                                Row{
                                    anchors.fill: parent
                                    Rectangle{
                                        width: 200
                                        height: parent.height
                                        Text{
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: parent.left
                                            anchors.leftMargin: 50
                                            font.family: font_noto_r.name
                                            text:"limit_v"
                                            font.pixelSize: 20
                                        }
                                    }
                                    Rectangle{
                                        width: 1
                                        height: parent.height
                                        color: "#d0d0d0"
                                    }
                                    Rectangle{
                                        width: parent.width - 200
                                        height: parent.height
                                        Row{
                                            spacing: 10
                                            anchors.centerIn: parent
                                            Rectangle{
                                                width: rr.width*0.1
                                                height: 40
                                                Text{
                                                    id: text_preset_limit_v
                                                    anchors.centerIn: parent
                                                    text: slider_preset_limit_v.value.toFixed(1)
                                                    font.pixelSize: 15
                                                    font.family: font_noto_r.name
                                                }
                                            }
                                            Slider{
                                                id: slider_preset_limit_v
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: rr.width*0.6
                                                height: 40
                                                from: 0.1
                                                to: 2.0
                                                value: 1.0
                                            }
                                        }
                                    }
                                }
                            }
                            Rectangle{
                                width: rect_preset_r.width*0.9
                                height: 40
                                Row{
                                    anchors.fill: parent
                                    Rectangle{
                                        width: 200
                                        height: parent.height
                                        Text{
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: parent.left
                                            anchors.leftMargin: 50
                                            font.family: font_noto_r.name
                                            text:"limit_v_acc"
                                            font.pixelSize: 20
                                        }
                                    }
                                    Rectangle{
                                        width: 1
                                        height: parent.height
                                        color: "#d0d0d0"
                                    }
                                    Rectangle{
                                        width: parent.width - 200
                                        height: parent.height
                                        Row{
                                            spacing: 10
                                            anchors.centerIn: parent
                                            Rectangle{
                                                width: rr.width*0.1
                                                height: 40
                                                Text{
                                                    id: text_preset_limit_vacc
                                                    anchors.centerIn: parent
                                                    text: slider_preset_limit_vacc.value.toFixed(1)
                                                    font.pixelSize: 15
                                                    font.family: font_noto_r.name
                                                }
                                            }
                                            Slider{
                                                id: slider_preset_limit_vacc
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: rr.width*0.6
                                                height: 40
                                                from: 0.1
                                                to: 2.0
                                                value: 1.0
                                            }
                                        }
                                    }
                                }
                            }
                            Rectangle{
                                width: rect_preset_r.width*0.9
                                height: 40
                                Row{
                                    anchors.fill: parent
                                    Rectangle{
                                        width: 200
                                        height: parent.height
                                        Text{
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: parent.left
                                            anchors.leftMargin: 50
                                            font.family: font_noto_r.name
                                            text:"limit_w"
                                            font.pixelSize: 20
                                        }
                                    }
                                    Rectangle{
                                        width: 1
                                        height: parent.height
                                        color: "#d0d0d0"
                                    }
                                    Rectangle{
                                        width: parent.width - 200
                                        height: parent.height
                                        Row{
                                            spacing: 10
                                            anchors.centerIn: parent
                                            Rectangle{
                                                width: rr.width*0.1
                                                height: 40
                                                Text{
                                                    id: text_preset_limit_w
                                                    anchors.centerIn: parent
                                                    text: slider_preset_limit_w.value.toFixed(1)
                                                    font.pixelSize: 15
                                                    font.family: font_noto_r.name
                                                }
                                            }
                                            Slider{
                                                id: slider_preset_limit_w
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: rr.width*0.6
                                                height: 40
                                                from: 5.0
                                                to: 120.0
                                                value: 120.0
                                            }
                                        }
                                    }
                                }
                            }
                            Rectangle{
                                width: rect_preset_r.width*0.9
                                height: 40
                                Row{
                                    anchors.fill: parent
                                    Rectangle{
                                        width: 200
                                        height: parent.height
                                        Text{
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: parent.left
                                            anchors.leftMargin: 50
                                            font.family: font_noto_r.name
                                            text:"limit_wacc"
                                            font.pixelSize: 20
                                        }
                                    }
                                    Rectangle{
                                        width: 1
                                        height: parent.height
                                        color: "#d0d0d0"
                                    }
                                    Rectangle{
                                        width: parent.width - 200
                                        height: parent.height
                                        Row{
                                            spacing: 10
                                            anchors.centerIn: parent
                                            Rectangle{
                                                width: rr.width*0.1
                                                height: 40
                                                Text{
                                                    id: text_preset_limit_wacc
                                                    anchors.centerIn: parent
                                                    text: slider_preset_limit_wacc.value.toFixed(1)
                                                    font.pixelSize: 15
                                                    font.family: font_noto_r.name
                                                }
                                            }
                                            Slider{
                                                id: slider_preset_limit_wacc
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: rr.width*0.6
                                                height: 40
                                                from: 5.0
                                                to: 360.0
                                                value: 360.0
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }

    }
    Popup{
        id: popup_preset_name
        anchors.centerIn: parent
        width: 300
        height: 200
        background: Rectangle{
            anchors.fill: parent
            color: color_dark_navy
        }
        Column{
            anchors.centerIn: parent
            spacing: 20
            TextField{
                id: preset_name
                width: 200
                height: 70
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: supervisor.getSetting("PRESET"+Number(popup_preset.select_preset),"name");
                onFocusChanged: {
                    keyboard.owner = preset_name;
                    preset_name.selectAll();
                    if(focus){
                        keyboard.open();
                    }else{
                        keyboard.close();
                        preset_name.select(0,0);
                    }
                }
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Rectangle{
                    width: 100
                    height: 50
                    radius: 5
                    Text{
                        anchors.centerIn: parent
                        text: "취소"
                        font.family: font_noto_r.name
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            popup_preset_name.close();
                        }
                    }
                }
                Rectangle{
                    width: 100
                    height: 50
                    radius: 5
                    Text{
                        anchors.centerIn: parent
                        text: "확인"
                        font.family: font_noto_r.name
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            supervisor.setSetting("PRESET"+Number(popup_preset.select_preset)+"/name",preset_name.text);
                            popup_preset.update();
                            popup_preset_name.close();
                        }
                    }
                }
            }
        }
    }

    Popup{
        id: popup_preset_set
        width: 400
        height: 300
        anchors.centerIn: parent
        property var preset_num: 0
        onOpened:{
            if(preset_num === 1){
                text_preset_name_set.text = "(  "+supervisor.getSetting("PRESET1","name") + "   )";
            }else if(preset_num === 2){
                text_preset_name_set.text = "(  "+supervisor.getSetting("PRESET2","name") + "   )";
            }else if(preset_num === 3){
                text_preset_name_set.text = "(  "+supervisor.getSetting("PRESET3","name") + "   )";
            }
        }

        background:Rectangle{
            anchors.fill: parent
        }
        Column{
            anchors.centerIn: parent
            spacing: 10
            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                text: "선택하신 프리셋으로 세팅을 변경하시겠습니까?"
                font.family: font_noto_r.name
                font.pixelSize: 25
            }
            Text{
                id: text_preset_name_set
                anchors.horizontalCenter: parent.horizontalCenter
                text: "(        )"
                font.family: font_noto_r.name
                font.pixelSize: 20
            }
            Row{
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    width: 100
                    height: 60
                    color: color_navy
                    Text{
                        anchors.centerIn: parent
                        text: "취소"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        color: "white"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            popup_preset_set.close();
                        }
                    }
            }

                Rectangle{
                    width: 100
                    height: 60
                    color: color_navy
                    Text{
                        anchors.centerIn: parent
                        text: "확인"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        color: "white"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            var name = "PRESET"+Number(popup_preset_set.preset_num);
                            print("setting! ",name,supervisor.getSetting(name,"limit_pivot"))
                            supervisor.setSetting("ROBOT_SW/limit_pivot",supervisor.getSetting(name,"limit_pivot"));
                            supervisor.setSetting("ROBOT_SW/limit_v",supervisor.getSetting(name,"limit_v"));
                            supervisor.setSetting("ROBOT_SW/limit_v_acc",supervisor.getSetting(name,"limit_v_acc"));
                            supervisor.setSetting("ROBOT_SW/limit_w",supervisor.getSetting(name,"limit_w"));
                            supervisor.setSetting("ROBOT_SW/limit_w_acc",supervisor.getSetting(name,"limit_w_acc"));
                            popup_preset_set.close();
                            init();
                        }
                    }
                }
            }
        }


    }

    Popup{
        id: popup_password
        anchors.centerIn: parent
        width: 400
        height: 600
        background: Rectangle{
            anchors.fill: parent
            color: color_dark_navy
        }
        property string passwd: "2011"
        property string answer: ""
        property var input_len: 0
        onOpened:{
            model_passwd.clear();
            model_passwd.append({"show":false})
            model_passwd.append({"show":false})
            model_passwd.append({"show":false})
            model_passwd.append({"show":false})

            model_pad.clear();
            model_pad.append({"name":"1"});
            model_pad.append({"name":"2"});
            model_pad.append({"name":"3"});
            model_pad.append({"name":"4"});
            model_pad.append({"name":"5"});
            model_pad.append({"name":"6"});
            model_pad.append({"name":"7"});
            model_pad.append({"name":"8"});
            model_pad.append({"name":"9"});
            model_pad.append({"name":"clear"});
            model_pad.append({"name":"0"});
            model_pad.append({"name":"<-"});
            answer = "";
            input_len = 0;
        }

        Rectangle{
            anchors.centerIn: parent
            width: parent.width*0.99
            height: parent.height*0.99
            Rectangle{
                id: rect_password_top
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
//                anchors.topMargin: 50
                height: 80
                color: color_dark_navy
                Text{
                    anchors.centerIn: parent
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    text: "패스워드를 입력하세요."
                }
            }
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_password_top.bottom
                anchors.topMargin: 50
                spacing: 50
                Rectangle{
                    width: 300
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 60
                    border.width: 1
                    border.color: color_dark_navy
                    Row{
                        anchors.centerIn: parent
                        spacing: 10
                        Repeater{
                            model: ListModel{id: model_passwd}
                            Rectangle{
                                width: 50
                                height: 55
                                color: "transparent"
                                Rectangle{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.top: parent.top
                                    anchors.topMargin: 5
                                    visible: show
                                    width: 40
                                    height: width
                                    radius: width
                                    color: color_green
                                }
                                Rectangle{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 3
                                    width: 50
                                    height: 2
                                    color: color_dark_navy
                                }
                            }
                        }
                    }
                }
            }

            Grid{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                spacing: 15
                rows: 4
                columns: 3
                Repeater{
                    model: ListModel{id: model_pad}
                    Rectangle{
                        width: 60
                        height: width
                        color: color_navy
                        Text{
                            text: name
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            anchors.centerIn: parent
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(name==="clear"){
                                    popup_password.input_len = 0;
                                    model_passwd.set(0,{"show":false});
                                    model_passwd.set(1,{"show":false});
                                    model_passwd.set(2,{"show":false});
                                    model_passwd.set(3,{"show":false});
                                    popup_password.answer = "";
                                }else if(name==="<-"){
                                    if(popup_password.input_len === 0){

                                    }else{
                                        popup_password.input_len--;
                                        model_passwd.set(popup_password.input_len,{"show":false});
                                        popup_password.answer = popup_password.answer.slice(0,popup_password.input_len);
                                    }
                                }else{
                                    if(popup_password.input_len === 4){
                                        is_admin = false;
                                        supervisor.writelog("[USER INPUT] SETTING PAGE -> ADMIN LOGIN FAILED "+popup_password.answer);
                                    }else{
                                        popup_password.answer += name;
                                        model_passwd.set(popup_password.input_len,{"show":true});
                                        popup_password.input_len++;
                                        if(popup_password.answer===popup_password.passwd){
                                            supervisor.writelog("[USER INPUT] SETTING PAGE -> ADMIN LOGIN SUCCESS");
                                            is_admin = true;
                                            popup_password.close();
                                        }else{
                                            is_admin = false;
                                            supervisor.writelog("[USER INPUT] SETTING PAGE -> ADMIN LOGIN FAILED "+popup_password.answer);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }

    }

    Popup_map_list{
        id: popup_maplist
    }
}
