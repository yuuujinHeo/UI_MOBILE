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

    property bool is_reset_slam: false

    function update_camera(){
        if(popup_camera.opened)
            popup_camera.update();
    }

    Component.onCompleted: {
        is_admin = false;
        is_reset_slam = false;
        init();
    }

    function set_category(num){
        select_category = num;
    }

    function set_call_done(){
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
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                }
                                onFocusChanged: {
                                    keyboard.owner = platform_name;
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        if(ischanged){
                                            is_reset_slam = true;
                                        }
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                }
                                model:["서빙용","호출용"]
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                }
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
                                text:"속도 프리셋"
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
                                        text: "변경"
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
                                    width: rr.width*0.2
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
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0
                                    to: 1
                                    property bool ischanged: false
                                    onValueChanged: {
                                        if(pressed){
                                            ischanged = true;
                                            is_reset_slam = true;
                                        }else{

                                        }
                                    }


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
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                    }
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
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                    }
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
                    id: set_movingpage
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
                                text:"이동 중 화면"
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
                                id: combo_movingpage
                                anchors.fill: parent
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                }
                                model:["목적지 표시", "귀여운 얼굴"]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_use_tray
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
                                text:"트레이별 지정"
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
                                id: combo_use_tray
                                anchors.fill: parent
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                }
                                model:["사용안함", "사용"]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_use_help
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
                                text:"도움말 표시"
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
                                id: combo_use_help
                                anchors.fill: parent
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                }
                                model:["사용안함", "사용"]
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
                    id: set_wifi_ssd
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
                                text:"WIFI SSD"
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
                                    id: wifi_ssd
                                    height: parent.height
                                    width: parent.width*0.8
                                    text:supervisor.getSetting("ROBOT_SW","wifi_ssd");
                                }
                                Rectangle{
                                    height: parent.height
                                    width: parent.width*0.2
                                    radius: 5
                                    color: "black"
                                    Text{
                                        anchors.centerIn: parent
                                        color: "white"
                                        font.family: font_noto_r.name
                                        text: "변경"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            popup_wifi.open();
                                        }
                                    }
                                }
                            }

                        }
                    }
                }
                Rectangle{
                    id: set_wifi_passwd
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
                                text:"WIFI Password"
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
                                    id: wifi_passwd
                                    height: parent.height
                                    width: parent.width*0.8
                                    property bool ischanged: false
                                    onTextChanged: {
                                        ischanged = true;
                                    }
                                    color: ischanged?color_red:"black"
                                    text:supervisor.getSetting("ROBOT_SW","wifi_passwd");
                                    onFocusChanged: {
                                        keyboard.owner = wifi_passwd;
                                        wifi_passwd.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            keyboard.close();
                                            wifi_passwd.select(0,0);
                                        }
                                    }
                                }
                                Rectangle{
                                    height: parent.height
                                    width: parent.width*0.2
                                    radius: 5
                                    color: "black"
                                    Text{
                                        anchors.centerIn: parent
                                        color: "white"
                                        font.family: font_noto_r.name
                                        text: "변경"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            wifi_passwd.ischanged = false;
                                            supervisor.setSetting("ROBOT_SW/wifi_passwd",wifi_passwd.text);
                                        }
                                    }
                                }
                            }
                        }
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
                                    width: 70
                                    height: 40
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
                                        keyboard.owner = ip_2;
                                        ip_2.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            keyboard.close();
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
                                        keyboard.owner = ip_3;
                                        ip_3.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            ip_3.select(0,0);
                                            keyboard.close();
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
                                        keyboard.owner = ip_4;
                                        ip_4.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            ip_4.select(0,0);
                                            keyboard.close();
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

                                Rectangle{
                                    height: parent.height
                                    width: parent.width*0.2
                                    radius: 5
                                    color: "black"
                                    Text{
                                        anchors.centerIn: parent
                                        color: "white"
                                        font.family: font_noto_r.name
                                        text: "변경"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            ip_1.ischanged = false;
                                            ip_2.ischanged = false;
                                            ip_3.ischanged = false;
                                            ip_4.ischanged = false;
                                            var ip_str = ip_1.text + "." + ip_2.text + "." + ip_3.text + "." + ip_4.text;
                                            supervisor.setSetting("ROBOT_SW/wifi_ip",ip_str);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_gateway
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
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                TextField{
                                    id: gateway_1
                                    width: 70
                                    height: 40
                                    onFocusChanged: {
                                        keyboard.owner = gateway_1;
                                        gateway_1.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            keyboard.close();
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
                                        keyboard.owner = gateway_2;
                                        gateway_2.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            keyboard.close();
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
                                        keyboard.owner = gateway_3;
                                        gateway_3.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            gateway_3.select(0,0);
                                            keyboard.close();
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
                                        keyboard.owner = gateway_4;
                                        gateway_4.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            gateway_4.select(0,0);
                                            keyboard.close();
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
                                Rectangle{
                                    height: parent.height
                                    width: parent.width*0.2
                                    radius: 5
                                    color: "black"
                                    Text{
                                        anchors.centerIn: parent
                                        color: "white"
                                        font.family: font_noto_r.name
                                        text: "변경"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            gateway_1.ischanged = false;
                                            gateway_2.ischanged = false;
                                            gateway_3.ischanged = false;
                                            gateway_4.ischanged = false;
                                            var ip_str = gateway_1.text + "." + gateway_2.text + "." + gateway_3.text + "." + gateway_4.text;
                                            supervisor.setSetting("ROBOT_SW/wifi_gateway",ip_str);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_dnsmain
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
                                text:"DNS(Main)"
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
                                    id: dnsmain_1
                                    width: 70
                                    height: 40
                                    onFocusChanged: {
                                        keyboard.owner = dnsmain_1;
                                        dnsmain_1.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            keyboard.close();
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
                                        keyboard.owner = dnsmain_2;
                                        dnsmain_2.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            keyboard.close();
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
                                        keyboard.owner = dnsmain_3;
                                        dnsmain_3.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            dnsmain_3.select(0,0);
                                            keyboard.close();
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
                                        keyboard.owner = dnsmain_4;
                                        dnsmain_4.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            dnsmain_4.select(0,0);
                                            keyboard.close();
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
                                Rectangle{
                                    height: parent.height
                                    width: parent.width*0.2
                                    radius: 5
                                    color: "black"
                                    Text{
                                        anchors.centerIn: parent
                                        color: "white"
                                        font.family: font_noto_r.name
                                        text: "변경"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            dnsmain_1.ischanged = false;
                                            dnsmain_2.ischanged = false;
                                            dnsmain_3.ischanged = false;
                                            dnsmain_4.ischanged = false;
                                            var ip_str = dnsmain_1.text + "." + dnsmain_2.text + "." + dnsmain_3.text + "." + dnsmain_4.text;
                                            supervisor.setSetting("ROBOT_SW/wifi_dnsmain",ip_str);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_dnsserve
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
                                text:"DNS(Serv)"
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
                                    id: dnsserv_1
                                    width: 70
                                    height: 40
                                    onFocusChanged: {
                                        keyboard.owner = dnsserv_1;
                                        dnsserv_1.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            keyboard.close();
                                            dnsserv_1.select(0,0);
                                        }
                                    }
                                    color: ischanged?color_red:"black"
                                    property bool ischanged: false
                                    onTextChanged: {
                                        ischanged = true;
                                        if(dnsserv_1.text.split(".").length > 1){
                                            dnsserv_1.text = dnsserv_1.text.split(".")[0];
                                            dnsserv_1.focus = false;
                                            dnsserv_2.focus = true;
                                        }
                                        if(dnsserv_1.text.length == 3){
                                            dnsserv_1.focus = false;
                                            dnsserv_2.focus = true;
                                        }
                                    }
                                }
                                Text{
                                    anchors.verticalCenter: parent.verticalCenter
                                    text:"."
                                }

                                TextField{
                                    id: dnsserv_2
                                    width: 70
                                    height: 40
                                    onFocusChanged: {
                                        keyboard.owner = dnsserv_2;
                                        dnsserv_2.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            keyboard.close();
                                            dnsserv_2.select(0,0);
                                        }
                                    }
                                    color: ischanged?color_red:"black"
                                    property bool ischanged: false
                                    onTextChanged: {
                                        ischanged = true;
                                        if(dnsserv_2.text == "."){
                                            dnsserv_2.text = dnsserv_2.text.split(".")[0]
                                        }

                                        if(dnsserv_2.text.split(".").length > 1){
                                            dnsserv_2.text = dnsserv_2.text.split(".")[0];
                                            dnsserv_2.focus = false;
                                            dnsserv_3.focus = true;
                                        }
                                        if(dnsserv_2.text.length == 3){
                                            dnsserv_2.focus = false;
                                            dnsserv_3.focus = true;
                                        }
                                    }
                                }
                                Text{
                                    anchors.verticalCenter: parent.verticalCenter
                                    text:"."
                                }
                                TextField{
                                    id: dnsserv_3
                                    width: 70
                                    height: 40
                                    onFocusChanged: {
                                        keyboard.owner = dnsserv_3;
                                        dnsserv_3.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            dnsserv_3.select(0,0);
                                            keyboard.close();
                                        }
                                    }
                                    color: ischanged?color_red:"black"
                                    property bool ischanged: false
                                    onTextChanged: {
                                        ischanged = true;
                                        if(dnsserv_3.text == "."){
                                            dnsserv_3.text = dnsserv_3.text.split(".")[0]
                                        }

                                        if(dnsserv_3.text.split(".").length > 1){
                                            dnsserv_3.text = dnsserv_3.text.split(".")[0];
                                            dnsserv_3.focus = false;
                                            dnsserv_4.focus = true;
                                        }
                                        if(dnsserv_3.text.length == 3){
                                            dnsserv_3.focus = false;
                                            dnsserv_4.focus = true;
                                        }
                                    }
                                }
                                Text{
                                    anchors.verticalCenter: parent.verticalCenter
                                    text:"."
                                }
                                TextField{
                                    id: dnsserv_4
                                    width: 70
                                    height: 40
                                    onFocusChanged: {
                                        keyboard.owner = dnsserv_4;
                                        dnsserv_4.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            dnsserv_4.select(0,0);
                                            keyboard.close();
                                        }
                                    }
                                    color: ischanged?color_red:"black"
                                    property bool ischanged: false
                                    onTextChanged: {
                                        ischanged = true;
                                        if(dnsserv_4.text == "."){
                                            dnsserv_4.text = dnsserv_4.text.split(".")[0]
                                        }

                                        if(dnsserv_4.text.split(".").length > 1){
                                            dnsserv_4.text = dnsserv_4.text.split(".")[0];
                                            dnsserv_4.focus = false;
                                        }
                                        if(dnsserv_4.text.length == 3){
                                            dnsserv_4.focus = false;
                                        }
                                    }
                                }
                                Rectangle{
                                    height: parent.height
                                    width: parent.width*0.2
                                    radius: 5
                                    color: "black"
                                    Text{
                                        anchors.centerIn: parent
                                        color: "white"
                                        font.family: font_noto_r.name
                                        text: "변경"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            dnsserv_1.ischanged = false;
                                            dnsserv_2.ischanged = false;
                                            dnsserv_3.ischanged = false;
                                            dnsserv_4.ischanged = false;
                                            var ip_str = dnsserv_1.text + "." + dnsserv_2.text + "." + dnsserv_3.text + "." + dnsserv_4.text;
                                            supervisor.setSetting("ROBOT_SW/wifi_dnsserv",ip_str);
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
                                text:"로봇 반지름 반경 [m]"
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
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                color: ischanged?color_red:"black"
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
                                text:"휠 베이스 반경 [m]"
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
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                color: ischanged?color_red:"black"
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
                                text:"휠 반지름 반경 [m]"
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
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                color: ischanged?color_red:"black"
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                font.family: font_noto_r.name
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
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
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                color: ischanged?color_red:"black"
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
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                color: ischanged?color_red:"black"
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                }
                                anchors.fill: parent
                                model:30
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                }
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
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
                                        text: name
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }

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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_mask
                                        anchors.centerIn: parent
                                        color: slider_mask.ischanged?color_red:"black"
                                        text: slider_mask.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_mask
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_max_range
                                        anchors.centerIn: parent
                                        color: slider_max_range.ischanged?color_red:"black"
                                        text: slider_max_range.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_max_range
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_cam_exposure
                                        color: slider_cam_exposure.ischanged?color_red:"black"
                                        anchors.centerIn: parent
                                        text: slider_cam_exposure.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_cam_exposure
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 500
                                    to: 8000
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
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                color:ischanged?color_red:"black"
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
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                color:ischanged?color_red:"black"
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
                                    width: parent.width*0.2
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
                                            popup_tf.open();
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
                                    width: parent.width*0.2
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
                                            popup_tf.open();
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_limit_pivot
                                        anchors.centerIn: parent
                                        color: slider_limit_pivot.ischanged?color_red:"black"
                                        text: slider_limit_pivot.value.toFixed(2) + " [deg/s]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_pivot
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 1.0
                                    to: 360.0
                                    value: 30.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limitpivotacc
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
                                text:"limit_pivot_acc"
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_limit_pivot_acc
                                        anchors.centerIn: parent
                                        color: slider_limit_pivot_acc.ischanged?color_red:"black"
                                        text: slider_limit_pivot_acc.value.toFixed(2) + " [deg/s^2]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_pivot_acc
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 1.0
                                    to: 360.0
                                    value: 10.0
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_limit_v
                                        anchors.centerIn: parent
                                        color: slider_limit_v.ischanged?color_red:"black"
                                        text: slider_limit_v.value.toFixed(2) + " [m/s]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_v
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_limit_v_acc
                                        anchors.centerIn: parent



                                        color: slider_limit_v_acc.ischanged?color_red:"black"



                                        text: slider_limit_v_acc.value.toFixed(2) + " [m/s^2]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_v_acc
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.01
                                    to: 2.0
                                    value: 0.5
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_limit_w
                                        anchors.centerIn: parent
                                        color: slider_limit_w.ischanged?color_red:"black"
                                        text: slider_limit_w.value.toFixed(2) + " [deg/s]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_w
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 1.0
                                    to: 360.0
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_limit_w_acc
                                        anchors.centerIn: parent
                                        color: slider_limit_w_acc.ischanged?color_red:"black"
                                        text: slider_limit_w_acc.value.toFixed(2) + " [deg/s^2]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_w_acc
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 1.0
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_limit_manual_v
                                        anchors.centerIn: parent
                                        color: slider_limit_manual_v.ischanged?color_red:"black"
                                        text: slider_limit_manual_v.value.toFixed(2) + " [m/s]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_manual_v
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_limit_manual_w
                                        anchors.centerIn: parent
                                        color: slider_limit_manual_w.ischanged?color_red:"black"
                                        text: slider_limit_manual_w.value.toFixed(2) + " [deg/s]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_manual_w
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 1.0
                                    to: 360.0
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_st_v
                                        anchors.centerIn: parent
                                        color: slider_st_v.ischanged?color_red:"black"
                                        text: slider_st_v.value.toFixed(2) + " [m/s]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_st_v
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
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
                    width: 1100
                    height: 40
                    color: "black"
                    visible: is_admin
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_b.name
                        text:"모터 세팅 값"
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
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
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
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
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                color: ischanged?color_red:"black"
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
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                color: ischanged?color_red:"black"
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
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                color: ischanged?color_red:"black"
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
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                color: ischanged?color_red:"black"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_motor_limit_v
                                        color: slider_motor_limit_v.ischanged?color_red:"black"
                                        anchors.centerIn: parent
                                        text: slider_motor_limit_v.value.toFixed(2) + " [m/s]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_motor_limit_v
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.10
                                    to: 2.00
                                    value: 1.00
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_motor_limit_v_acc
                                        anchors.centerIn: parent
                                        color: slider_motor_limit_v_acc.ischanged?color_red:"black"
                                        text: slider_motor_limit_v_acc.value.toFixed(2) + " [m/s^2]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_motor_limit_v_acc
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.01
                                    to: 2.00
                                    value: 1.00
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_motor_limit_w
                                        anchors.centerIn: parent
                                        color: slider_motor_limit_w.ischanged?color_red:"black"

                                        text: slider_motor_limit_w.value.toFixed(2) + " [deg/s]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_motor_limit_w
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 1.0
                                    to: 360.0
                                    value: 180.00
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_motor_limit_w_acc
                                        anchors.centerIn: parent
                                        color: slider_motor_limit_w_acc.ischanged?color_red:"black"

                                        text: slider_motor_limit_w_acc.value.toFixed(2) + " [deg/s^2]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_motor_limit_w_acc
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 1.0
                                    to: 360.0
                                    value: 180.00
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_k_v
                                        anchors.centerIn: parent
                                        color: slider_k_v.ischanged?color_red:"black"

                                        text: slider_k_v.value.toFixed(2) + " [gain]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_k_v
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.0
                                    to: 10.0
                                    value: 1.0
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_k_w
                                        anchors.centerIn: parent
                                        color: slider_k_w.ischanged?color_red:"black"

                                        text: slider_k_w.value.toFixed(2) + " [gain]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_k_w
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.0
                                    to: 10.0
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_look_ahead_dist
                                        anchors.centerIn: parent
                                        color: slider_look_ahead_dist.ischanged?color_red:"black"
                                        text: slider_look_ahead_dist.value.toFixed(2) + " [m]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_look_ahead_dist
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.0
                                    to: 2.0
                                    value: 0.5
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_min_look_ahead_dist
                                        anchors.centerIn: parent
                                        color: slider_min_look_ahead_dist.ischanged?color_red:"black"
                                        text: slider_min_look_ahead_dist.value.toFixed(2) + " [m]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_min_look_ahead_dist
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.0
                                    to: 2.0
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_narrow_decel_ratio
                                        anchors.centerIn: parent
                                        color: slider_narrow_decel_ratio.ischanged?color_red:"black"
                                        text: slider_narrow_decel_ratio.value.toFixed(2) + " [ratio, %]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_narrow_decel_ratio
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.00
                                    to: 1.00
                                    value: 0.7
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_obs_deadzone
                                        anchors.centerIn: parent
                                        text: slider_obs_deadzone.value.toFixed(2) + " [m]"
                                        font.pixelSize: 15
                                        color: slider_obs_deadzone.ischanged?color_red:"black"
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_obs_deadzone
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.1
                                    to: 2.0
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_obs_wait_time
                                        anchors.centerIn: parent
                                        color: slider_obs_wait_time.ischanged?color_red:"black"

                                        text: slider_obs_wait_time.value.toFixed(2) + " [sec]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_obs_wait_time
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.0
                                    to: 5.0
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_path_out_dist
                                        anchors.centerIn: parent
                                        color: slider_path_out_dist.ischanged?color_red:"black"
                                        text: slider_path_out_dist.value.toFixed(2) + " [m]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_path_out_dist
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_icp_dist
                                        anchors.centerIn: parent
                                        text: slider_icp_dist.value.toFixed(2) + " [m]"
                                        font.pixelSize: 15
                                        color: slider_icp_dist.ischanged?color_red:"black"

                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_dist
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.30
                                    to: 1.00
                                    value: 0.3
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_icp_error
                                        anchors.centerIn: parent
                                        color: slider_icp_error.ischanged?color_red:"black"

                                        text: slider_icp_error.value.toFixed(2) + " [m]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_error
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.00
                                    to: 0.50
                                    value: 0.2
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_icp_near
                                        anchors.centerIn: parent
                                        color: slider_icp_near.ischanged?color_red:"black"

                                        text: slider_icp_near.value.toFixed(2) + " [m]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_near
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.10
                                    to: 2.00
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_icp_odometry_weight
                                        anchors.centerIn: parent
                                        color: slider_icp_odometry_weight.ischanged?color_red:"black"

                                        text: slider_icp_odometry_weight.value.toFixed(2) + " [ratio, %]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_odometry_weight
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.00
                                    to: 1.00
                                    value: 0.75
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_icp_ratio
                                        anchors.centerIn: parent
                                        color: slider_icp_ratio.ischanged?color_red:"black"

                                        text: slider_icp_ratio.value.toFixed(2) + " [ratio, %]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_ratio
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_icp_repeat_dist
                                        anchors.centerIn: parent
                                        text: slider_icp_repeat_dist.value.toFixed(2) + " [m]"
                                        font.pixelSize: 15
                                        color: slider_icp_repeat_dist.ischanged?color_red:"black"

                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_repeat_dist
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.00
                                    to: 1.00
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_icp_repeat_time
                                        anchors.centerIn: parent
                                        color: slider_icp_repeat_time.ischanged?color_red:"black"

                                        text: slider_icp_repeat_time.value.toFixed(2) + " [sec]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_icp_repeat_time
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.0
                                    to: 5.0
                                    value: 0.5
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_goal_dist
                                        anchors.centerIn: parent
                                        text: slider_goal_dist.value.toFixed(2) + " [m]"
                                        font.pixelSize: 15
                                        color: slider_goal_dist.ischanged?color_red:"black"


                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_goal_dist
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.0
                                    to: 1.0
                                    value: 0.03
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_goal_v
                                        color: slider_goal_v.ischanged?color_red:"black"

                                        anchors.centerIn: parent
                                        text: slider_goal_v.value.toFixed(2) + " [m/s]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_goal_v
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.0
                                    to: 2.0
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_goal_th
                                        anchors.centerIn: parent
                                        color: slider_goal_th.ischanged?color_red:"black"

                                        text: slider_goal_th.value.toFixed(2) + " [deg]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_goal_th
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.0
                                    to: 30.0
                                    value: 2.0
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_goal_near_dist
                                        color: slider_goal_near_dist.ischanged?color_red:"black"

                                        anchors.centerIn: parent
                                        text: slider_goal_near_dist.value.toFixed(2) + " [m]"
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_goal_near_dist
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
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
                                    width: rr.width*0.2
                                    height: 40
                                    Text{
                                        id: text_goal_near_th
                                        anchors.centerIn: parent
                                        text: slider_goal_near_th.value.toFixed(2) + " [deg]"
                                        font.pixelSize: 15
                                        color: slider_goal_near_th.ischanged?color_red:"black"

                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_goal_near_th
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.7
                                    height: 40
                                    from: 0.0
                                    to: 30.0
                                    value: 10.0
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
                    if(check_update()){
                        popup_changed.open();
                    }else{
                        backPage();
                    }

                }
            }
        }

        Column{
            anchors.bottom: area_setting_robot.bottom
            anchors.right: parent.right
            anchors.rightMargin: (parent.width - area_setting_robot.width - area_setting_robot.x - btn_default.width)/2
            spacing: 30
            Rectangle{
                id: btn_manager
                width: 180
                height: 60
                radius: 10
                color:"transparent"
                border.width: 1
                border.color: "#7e7e7e"
                Text{
                    anchors.centerIn: parent
                    text: "관리자 메뉴"
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        supervisor.writelog("[USER INPUT] SETTING PAGE -> SHOW MANAGER MENU");
                        if(is_admin){
                            popup_manager.open();
                        }else{
                            popup_password.open();
                        }

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
                    text: "설정 초기화"
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
                        save();
                    }
                }
            }
        }
    }

    function save(){
        supervisor.writelog("[USER INPUT] SETTING PAGE -> SETTING CHANGE");
        if(platform_name.ischanged){
            supervisor.setSetting("ROBOT_HW/model",platform_name.text);
        }

        if(combo_platform_serial.ischanged){
            supervisor.setSetting("ROBOT_HW/serial_num",combo_platform_serial.currentText);
        }

        if(combo_platform_id.ischanged){
            supervisor.setSetting("ROBOT_SW/robot_id",combo_platform_id.currentText);
        }

        if(combo_platform_type.ischanged){
            if(combo_platform_type.currentIndex == 0){
                supervisor.setSetting("ROBOT_HW/type","SERVING");
            }else if(combo_platform_type.currentIndex == 1){
                supervisor.setSetting("ROBOT_HW/type","CALLING");
            }
        }

        if(combo_tray_num.ischanged){
            supervisor.setSetting("ROBOT_HW/tray_num",combo_tray_num.currentText);
        }

        if(slider_vxy.ischanged){
            supervisor.setSetting("ROBOT_SW/velocity",slider_vxy.value.toFixed(2));
        }

        if(slider_volume_bgm.ischanged){
            supervisor.setSetting("ROBOT_SW/volume_bgm",slider_volume_bgm.value.toFixed(0));
        }

        if(slider_volume_voice.ischanged){
            supervisor.setSetting("ROBOT_SW/volume_voice",slider_volume_voice.value.toFixed(0));
        }

        if(combo_use_help.ischanged){
            if(combo_use_help.currentIndex == 0)
                supervisor.setSetting("ROBOT_SW/use_help","false");
            else
                supervisor.setSetting("ROBOT_SW/use_help","true");
        }
        if(combo_movingpage.ischanged){
            if(combo_movingpage.currentIndex == 0)
                supervisor.setSetting("ROBOT_SW/moving_face","false");
            else
                supervisor.setSetting("ROBOT_SW/moving_face","true");
        }
        if(combo_use_tray.ischanged){
            if(combo_use_tray.currentIndex == 0)
                supervisor.setSetting("ROBOT_SW/use_tray","false");
            else
                supervisor.setSetting("ROBOT_SW/use_tray","true");
        }

        if(wifi_passwd.ischanged){
            supervisor.setSetting("ROBOT_SW/wifi_passwd",wifi_passwd.text);
        }

        if(ip_1.ischanged||ip_2.ischanged||ip_3.ischanged||ip_4.ischanged){
            var ip_str = ip_1.text + "." + ip_2.text + "." + ip_3.text + "." + ip_4.text;
            supervisor.setSetting("ROBOT_SW/wifi_ip",ip_str);
        }

        if(gateway_1.ischanged||gateway_2.ischanged||gateway_3.ischanged||gateway_4.ischanged){
            var ip_str = gateway_1.text + "." + gateway_2.text + "." + gateway_3.text + "." + gateway_4.text;
            supervisor.setSetting("ROBOT_SW/wifi_gateway",ip_str);
        }

        if(dnsmain_1.ischanged||dnsmain_2.ischanged||dnsmain_3.ischanged||dnsmain_4.ischanged){
            var ip_str = dnsmain_1.text + "." + dnsmain_2.text + "." + dnsmain_3.text + "." + dnsmain_4.text;
            supervisor.setSetting("ROBOT_SW/wifi_dnsmain",ip_str);
        }

        if(dnsserv_1.ischanged||dnsserv_2.ischanged||dnsserv_3.ischanged||dnsserv_4.ischanged){
            var ip_str = dnsserv_1.text + "." + dnsserv_2.text + "." + dnsserv_3.text + "." + dnsserv_4.text;
            supervisor.setSetting("ROBOT_SW/wifi_dnsserv",ip_str);

        }

        if(wheel_base.ischanged){
            supervisor.setSetting("ROBOT_HW/wheel_base",wheel_base.text);
        }
        if(wheel_radius.ischanged){
            supervisor.setSetting("ROBOT_HW/wheel_radius",wheel_radius.text);
        }
        if(radius.ischanged){
            supervisor.setSetting("ROBOT_HW/radius",radius.text);
        }

        if(combo_autoinit.ischanged){
            if(combo_autoinit.currentIndex == 0)
                supervisor.setSetting("ROBOT_SW/use_autoinit","false");
            else
                supervisor.setSetting("ROBOT_SW/use_autoinit","true");
        }

        if(combo_avoid.ischanged){
            if(combo_avoid.currentIndex == 0)
                supervisor.setSetting("ROBOT_SW/use_avoid","false");
            else
                supervisor.setSetting("ROBOT_SW/use_avoid","true");
        }

        if(combo_multirobot.ischanged){
            if(combo_multirobot.currentIndex == 0)
                supervisor.setSetting("ROBOT_SW/use_multirobot","false");
            else
                supervisor.setSetting("ROBOT_SW/use_multirobot","true");
        }

        if(combo_use_uicmd.ischanged){
            if(combo_use_uicmd.currentIndex == 0)
                supervisor.setSetting("ROBOT_SW/use_uicmd","false");
            else
                supervisor.setSetting("ROBOT_SW/use_uicmd","true");
        }

        if(map_size.ischanged){
            supervisor.setSetting("ROBOT_SW/map_size",map_size.text);
        }

        if(grid_size.ischanged){
            supervisor.setSetting("ROBOT_SW/grid_size",grid_size.text);
        }

        if(combo_table_num.ischanged){
            supervisor.setTableNum(combo_table_num.currentIndex);
        }

        if(combo_call_max.ischanged){
            supervisor.setSetting("CALLING/call_maximum",combo_call_max.currentText);
        }

        if(combo_call_num.ischanged){
            supervisor.setSetting("CALLING/call_num",combo_call_num.currentText);
        }

        if(combo_baudrate.ischanged){
            supervisor.setSetting("SENSOR/baudrate",combo_baudrate.currentText);
        }

        if(slider_mask.ischanged){
            supervisor.setSetting("SENSOR/mask",slider_mask.value.toFixed(2));
        }

        if(slider_max_range.ischanged){
            supervisor.setSetting("SENSOR/max_range",slider_max_range.value.toFixed(2));
        }

        if(slider_cam_exposure.ischanged){
            supervisor.setSetting("SENSOR/cam_exposure",slider_cam_exposure.value.toFixed(2));
        }

        if(offset_x.ischanged){
            supervisor.setSetting("SENSOR/offset_x",offset_x.text);
        }

        if(offset_y.ischanged){
            supervisor.setSetting("SENSOR/offset_y",offset_y.text);
        }

        if(slider_limit_pivot.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_pivot"            ,slider_limit_pivot.value.toFixed(2));
        }

        if(slider_limit_pivot_acc.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_pivot_acc"        ,slider_limit_pivot_acc.value.toFixed(2));
        }

        if(slider_limit_v.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_v"                ,slider_limit_v.value.toFixed(2));
        }

        if(slider_limit_v_acc.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_v_acc"            ,slider_limit_v_acc.value.toFixed(2));
        }

        if(slider_limit_w.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_w"                ,slider_limit_w.value.toFixed(2));
        }

        if(slider_limit_w_acc.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_w_acc"            ,slider_limit_w_acc.value.toFixed(2));
        }

        if(slider_limit_manual_v.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_manual_v"          ,slider_limit_manual_v.value.toFixed(2));
        }

        if(slider_limit_manual_w.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_manual_w"          ,slider_limit_manual_w.value.toFixed(2));
        }

        if(slider_st_v.ischanged){
            supervisor.setSetting("ROBOT_SW/st_v"                   ,slider_st_v.value.toFixed(2));
        }

        if(combo_wheel_dir.ischanged){
            supervisor.setSetting("MOTOR/wheel_dir",combo_wheel_dir.currentText);
        }

        if(combo_left_id.ischanged){
            supervisor.setSetting("MOTOR/left_id",combo_left_id.currentText);
        }

        if(combo_right_id.ischanged){
            supervisor.setSetting("MOTOR/right_id",combo_right_id.currentText);
        }

        if(gear_ratio.ischanged){
            supervisor.setSetting("MOTOR/gear_ratio",gear_ratio.text);
        }

        if(k_p.ischanged){
            supervisor.setSetting("MOTOR/k_p",k_p.text);
        }

        if(k_i.ischanged){
            supervisor.setSetting("MOTOR/k_i",k_i.text);
        }

        if(k_d.ischanged){
            supervisor.setSetting("MOTOR/k_d",k_d.text);
        }

        if(slider_motor_limit_v.ischanged){
            supervisor.setSetting("MOTOR/limit_v",slider_motor_limit_v.value.toFixed(2));
        }

        if(slider_motor_limit_v_acc.ischanged){
            supervisor.setSetting("MOTOR/limit_v_acc",slider_motor_limit_v_acc.value.toFixed(2));
        }

        if(slider_motor_limit_w.ischanged){
            supervisor.setSetting("MOTOR/limit_w",slider_motor_limit_w.value.toFixed(2));
        }

        if(slider_motor_limit_w_acc.ischanged){
            supervisor.setSetting("MOTOR/limit_w_acc",slider_motor_limit_w_acc.value.toFixed(2));
        }

        if(slider_k_v.ischanged){
            supervisor.setSetting("ROBOT_SW/k_v"                    ,slider_k_v.value.toFixed(2));
        }

        if(slider_k_w.ischanged){
            supervisor.setSetting("ROBOT_SW/k_w"                    ,slider_k_w.value.toFixed(2));
        }

        if(slider_look_ahead_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/look_ahead_dist"         ,slider_look_ahead_dist.value.toFixed(2));
        }

        if(slider_min_look_ahead_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/min_look_ahead_dist"    ,slider_min_look_ahead_dist.value.toFixed(2));
        }

        if(slider_narrow_decel_ratio.ischanged){
            supervisor.setSetting("ROBOT_SW/narrow_decel_ratio"     ,slider_narrow_decel_ratio.value.toFixed(2));
        }

        if(slider_obs_deadzone.ischanged){
            supervisor.setSetting("ROBOT_SW/obs_deadzone"           ,slider_obs_deadzone.value.toFixed(2));
        }

        if(slider_obs_wait_time.ischanged){
            supervisor.setSetting("ROBOT_SW/obs_wait_time"          ,slider_obs_wait_time.value.toFixed(2));
        }

        if(slider_path_out_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/path_out_dist"          ,slider_path_out_dist.value.toFixed(2));
        }

        if(slider_icp_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/icp_dist"               ,slider_icp_dist.value.toFixed(2));
        }

        if(slider_icp_error.ischanged){
            supervisor.setSetting("ROBOT_SW/icp_error"              ,slider_icp_error.value.toFixed(2));
        }

        if(slider_icp_near.ischanged){
            supervisor.setSetting("ROBOT_SW/icp_near"               ,slider_icp_near.value.toFixed(2));

        }

        if(slider_icp_odometry_weight.ischanged){
            supervisor.setSetting("ROBOT_SW/icp_odometry_weight"    ,slider_icp_odometry_weight.value.toFixed(2));

        }

        if(slider_icp_ratio.ischanged){

            supervisor.setSetting("ROBOT_SW/icp_ratio"              ,slider_icp_ratio.value.toFixed(2));
        }

        if(slider_icp_repeat_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/icp_repeat_dist"        ,slider_icp_repeat_dist.value.toFixed(2));

        }

        if(slider_icp_repeat_time.ischanged){
            supervisor.setSetting("ROBOT_SW/icp_repeat_time"        ,slider_icp_repeat_time.value.toFixed(2));

        }

        if(slider_goal_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/goal_dist"              ,slider_goal_dist.value.toFixed(2));
        }

        if(slider_goal_v.ischanged){
            supervisor.setSetting("ROBOT_SW/goal_v"                 ,slider_goal_v.value.toFixed(2));
        }

        if(slider_goal_th.ischanged){
            supervisor.setSetting("ROBOT_SW/goal_th"                ,slider_goal_th.value.toFixed(2));
        }

        if(slider_goal_near_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/goal_near_dist"         ,slider_goal_near_dist.value.toFixed(2));
        }

        if(slider_goal_near_th.ischanged){
            supervisor.setSetting("ROBOT_SW/goal_near_th"           ,slider_goal_near_th.value.toFixed(2));
        }

        if(is_reset_slam)
            supervisor.restartSLAM();

        init();

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

        slider_motor_limit_v.value = parseFloat(supervisor.getSetting("MOTOR","limit_v"));
        slider_motor_limit_v_acc.value = parseFloat(supervisor.getSetting("MOTOR","limit_v_acc"));
        slider_motor_limit_w.value = parseFloat(supervisor.getSetting("MOTOR","limit_w"));
        slider_motor_limit_w_acc.value = parseFloat(supervisor.getSetting("MOTOR","limit_w_acc"));
//        slider_k_curve.value = parseFloat(supervisor.getSetting("ROBOT_SW","k_curve"));
        slider_k_v.value = parseFloat(supervisor.getSetting("ROBOT_SW","k_v"));
        slider_k_w.value = parseFloat(supervisor.getSetting("ROBOT_SW","k_w"));
        slider_limit_pivot.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_pivot"));
        slider_limit_pivot_acc.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_pivot_acc"));
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

        wifi_ssd.text = supervisor.getSetting("ROBOT_SW","wifi_ssd");
        wifi_passwd.text = supervisor.getSetting("ROBOT_SW","wifi_passwd");

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

        if(supervisor.getSetting("ROBOT_SW","use_help") === "true"){
            combo_use_help.currentIndex = 1;
        }else{
            combo_use_help.currentIndex = 0;
        }
        if(supervisor.getSetting("ROBOT_SW","moving_face") === "true"){
            combo_movingpage.currentIndex = 1;
        }else{
            combo_movingpage.currentIndex = 0;
        }
        if(supervisor.getSetting("ROBOT_SW","use_tray") === "true"){
            combo_use_tray.currentIndex = 1;
        }else{
            combo_use_tray.currentIndex = 0;
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

        var ip = supervisor.getSetting("ROBOT_SW","wifi_ip").split(".");
        if(ip.length >3){
            ip_1.text = ip[0];
            ip_2.text = ip[1];
            ip_3.text = ip[2];
            ip_4.text = ip[3];
        }

        ip = supervisor.getSetting("ROBOT_SW","wifi_gateway").split(".");
        if(ip.length >3){
            gateway_1.text = ip[0];
            gateway_2.text = ip[1];
            gateway_3.text = ip[2];
            gateway_4.text = ip[3];
        }
        ip = supervisor.getSetting("ROBOT_SW","wifi_dnsmain").split(".");
        if(ip.length >3){
            dnsmain_1.text = ip[0];
            dnsmain_2.text = ip[1];
            dnsmain_3.text = ip[2];
            dnsmain_4.text = ip[3];
        }
        ip = supervisor.getSetting("ROBOT_SW","wifi_dnsserv").split(".");
        if(ip.length >3){
            dnsserv_1.text = ip[0];
            dnsserv_2.text = ip[1];
            dnsserv_3.text = ip[2];
            dnsserv_4.text = ip[3];
        }


        //변수 초기화
        is_reset_slam = false;

        platform_name.ischanged = false;
        combo_platform_serial.ischanged = false;
        combo_platform_id.ischanged = false;
        combo_platform_type.ischanged = false;
        combo_tray_num.ischanged = false;

        slider_vxy.ischanged = false;
        slider_volume_bgm.ischanged = false;
        slider_volume_voice.ischanged = false;
        combo_use_help.ischanged = false;


        wifi_passwd.ischanged = false;
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
        dnsserv_1.ischanged = false;
        dnsserv_2.ischanged = false;
        dnsserv_3.ischanged = false;
        dnsserv_4.ischanged = false;

        wheel_base.ischanged = false;
        wheel_radius.ischanged = false;
        radius.ischanged = false;
        combo_autoinit.ischanged = false;
        combo_avoid.ischanged = false;
        combo_multirobot.ischanged = false;
        combo_use_uicmd.ischanged = false;

        map_size.ischanged = false;
        grid_size.ischanged = false;
        combo_table_num.ischanged = false;
        combo_call_max.ischanged = false;
        combo_call_num.ischanged = false;

        combo_baudrate.ischanged = false;
        slider_mask.ischanged = false;
        slider_max_range.ischanged = false;
        slider_cam_exposure.ischanged = false;
        offset_x.ischanged = false;
        offset_y.ischanged = false;

        slider_limit_pivot.ischanged = false;
        slider_limit_pivot_acc.ischanged = false;
        slider_limit_v.ischanged = false;
        slider_limit_v_acc.ischanged = false;
        slider_limit_w.ischanged = false;
        slider_limit_w_acc.ischanged = false;
        slider_limit_manual_v.ischanged = false;
        slider_limit_manual_w.ischanged = false;
        slider_st_v.ischanged = false;

        combo_wheel_dir.ischanged = false;
        combo_left_id.ischanged = false;
        combo_right_id.ischanged = false;
        gear_ratio.ischanged = false;
        k_p.ischanged = false;
        k_i.ischanged = false;
        k_d.ischanged = false;
        slider_motor_limit_v.ischanged = false;
        slider_motor_limit_v_acc.ischanged = false;
        slider_motor_limit_w.ischanged = false;
        slider_motor_limit_w_acc.ischanged = false;
        slider_k_v.ischanged = false;
        slider_k_w.ischanged = false;
        slider_look_ahead_dist.ischanged = false;
        slider_min_look_ahead_dist.ischanged = false;
        slider_narrow_decel_ratio.ischanged = false;
        slider_obs_deadzone.ischanged = false;
        slider_obs_wait_time.ischanged = false;
        slider_path_out_dist.ischanged = false;
        slider_icp_dist.ischanged = false;
        slider_icp_error.ischanged = false;
        slider_icp_near.ischanged = false;
        slider_icp_odometry_weight.ischanged = false;
        slider_icp_ratio.ischanged = false;
        slider_icp_repeat_dist.ischanged = false;
        slider_icp_repeat_time.ischanged = false;
        slider_goal_dist.ischanged = false;
        slider_goal_v.ischanged = false;
        slider_goal_th.ischanged = false;
        slider_goal_near_dist.ischanged = false;
        slider_goal_near_th.ischanged = false;
    }

    function check_update(){
        var is_changed = false;

        if(platform_name.ischanged) is_changed = true;
        if(combo_platform_serial.ischanged) is_changed = true;
        if(combo_platform_id.ischanged) is_changed = true;
        if(combo_platform_type.ischanged) is_changed = true;
        if(combo_tray_num.ischanged) is_changed = true;
        if(slider_vxy.ischanged) is_changed = true;
        if(slider_volume_bgm.ischanged) is_changed = true;
        if(slider_volume_voice.ischanged) is_changed = true;
        if(combo_use_help.ischanged) is_changed = true;
        if(wifi_passwd.ischanged) is_changed = true;
        if(ip_1.ischanged) is_changed = true;
        if(ip_2.ischanged) is_changed = true;
        if(ip_3.ischanged) is_changed = true;
        if(ip_4.ischanged) is_changed = true;
        if(gateway_1.ischanged) is_changed = true;
        if(gateway_2.ischanged) is_changed = true;
        if(gateway_3.ischanged) is_changed = true;
        if(gateway_4.ischanged) is_changed = true;
        if(dnsmain_1.ischanged) is_changed = true;
        if(dnsmain_2.ischanged) is_changed = true;
        if(dnsmain_3.ischanged) is_changed = true;
        if(dnsmain_4.ischanged) is_changed = true;
        if(dnsserv_1.ischanged) is_changed = true;
        if(dnsserv_2.ischanged) is_changed = true;
        if(dnsserv_3.ischanged) is_changed = true;
        if(dnsserv_4.ischanged) is_changed = true;
        if(wheel_base.ischanged) is_changed = true;
        if(wheel_radius.ischanged) is_changed = true;
        if(radius.ischanged) is_changed = true;
        if(combo_autoinit.ischanged) is_changed = true;
        if(combo_avoid.ischanged) is_changed = true;
        if(combo_multirobot.ischanged) is_changed = true;
        if(combo_use_uicmd.ischanged) is_changed = true;
        if(map_size.ischanged) is_changed = true;
        if(grid_size.ischanged) is_changed = true;
        if(combo_table_num.ischanged) is_changed = true;
        if(combo_call_max.ischanged) is_changed = true;
        if(combo_call_num.ischanged) is_changed = true;
        if(combo_baudrate.ischanged) is_changed = true;
        if(slider_mask.ischanged) is_changed = true;
        if(slider_max_range.ischanged) is_changed = true;
        if(slider_cam_exposure.ischanged) is_changed = true;
        if(offset_x.ischanged) is_changed = true;
        if(offset_y.ischanged) is_changed = true;
        if(slider_limit_pivot.ischanged) is_changed = true;
        if(slider_limit_pivot_acc.ischanged) is_changed = true;
        if(slider_limit_v.ischanged) is_changed = true;
        if(slider_limit_v_acc.ischanged) is_changed = true;
        if(slider_limit_w.ischanged) is_changed = true;
        if(slider_limit_w_acc.ischanged) is_changed = true;
        if(slider_limit_manual_v.ischanged) is_changed = true;
        if(slider_limit_manual_w.ischanged) is_changed = true;
        if(slider_st_v.ischanged) is_changed = true;
        if(combo_wheel_dir.ischanged) is_changed = true;
        if(combo_left_id.ischanged) is_changed = true;
        if(combo_right_id.ischanged) is_changed = true;
        if(gear_ratio.ischanged) is_changed = true;
        if(k_p.ischanged) is_changed = true;
        if(k_i.ischanged) is_changed = true;
        if(k_d.ischanged) is_changed = true;
        if(slider_motor_limit_v.ischanged) is_changed = true;
        if(slider_motor_limit_v_acc.ischanged) is_changed = true;
        if(slider_motor_limit_w.ischanged) is_changed = true;
        if(slider_motor_limit_w_acc.ischanged) is_changed = true;
        if(slider_k_v.ischanged) is_changed = true;
        if(slider_k_w.ischanged) is_changed = true;
        if(slider_look_ahead_dist.ischanged) is_changed = true;
        if(slider_min_look_ahead_dist.ischanged) is_changed = true;
        if(slider_narrow_decel_ratio.ischanged) is_changed = true;
        if(slider_obs_deadzone.ischanged) is_changed = true;
        if(slider_obs_wait_time.ischanged) is_changed = true;
        if(slider_path_out_dist.ischanged) is_changed = true;
        if(slider_icp_dist.ischanged) is_changed = true;
        if(slider_icp_error.ischanged) is_changed = true;
        if(slider_icp_near.ischanged) is_changed = true;
        if(slider_icp_odometry_weight.ischanged) is_changed = true;
        if(slider_icp_ratio.ischanged) is_changed = true;
        if(slider_icp_repeat_dist.ischanged) is_changed = true;
        if(slider_icp_repeat_time.ischanged) is_changed = true;
        if(slider_goal_dist.ischanged) is_changed = true;
        if(slider_goal_v.ischanged) is_changed = true;
        if(slider_goal_th.ischanged) is_changed = true;
        if(slider_goal_near_dist.ischanged) is_changed = true;
        if(slider_goal_near_th.ischanged) is_changed = true;

        return is_changed;
    }

    Timer{
        running: true
        interval: 500
        repeat: true
        triggeredOnStart: true
        onTriggered: {

            if(supervisor.getusbsize() > 0){
                btn_usb_download.enabled = true;
            }else{
                btn_usb_download.enabled = false;
            }

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

            text_battery_in.text = "In : " + supervisor.getBatteryIn().toFixed(2).toString();
            text_battery_out.text = "Out : " + supervisor.getBatteryOut().toFixed(2).toString();
            text_battery_current.text = "Current : " + supervisor.getBatteryCurrent().toFixed(2).toString();

            text_power.text = "Power : " + supervisor.getPower().toString();
            text_power_total.text = "Total : " + supervisor.getPowerTotal().toString();

        }
    }

    Popup{
        id: popup_manager
        width: 500
        height: 400
        anchors.centerIn: parent
        leftPadding: 0
        topPadding: 0
        bottomPadding: 0
        rightPadding: 0
        background: Rectangle{
            anchors.fill: parent
            color : "transparent"
        }

        Rectangle{
            width: parent.width
            height: parent.height
            radius: 5
            Grid{
                anchors.centerIn: parent
                rows: 3
                columns: 2
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
                    id: btn_usb_upload
                    width: 180
                    height: 60
                    radius: 10
                    color: enabled?"white":color_light_gray
                    border.width: 1
                    border.color: "#7e7e7e"
                    Text{
                        anchors.centerIn: parent
                        text: "USB에 저장하기"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        color: btn_usb_upload.enabled?"black":color_gray
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            supervisor.writelog("[USER INPUT] SETTING PAGE -> SAVE TO USB");
                            popup_usb_select.open();
                        }
                    }
                }
                Rectangle{
                    id: btn_usb_download
                    width: 180
                    height: 60
                    radius: 10
                    enabled: false
                    color:enabled?"white":color_light_gray
                    border.width: 1
                    border.color: "#7e7e7e"
                    Text{
                        anchors.centerIn: parent
                        text: "USB에서 받아오기"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        color: btn_usb_download.enabled?"black":color_gray
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            supervisor.writelog("[USER INPUT] SETTING PAGE -> DOWNLOAD FROM USB");
                            if(is_admin){
                                popup_usb_download.open();
                            }else{
                                popup_password.open();
                            }
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
                        text_usb_state.text = "파일을 압축하여 저장 중..";
                    }else{
                        text_usb_state.text = "파일을 가져오는 중..";
                    }
                }else if(supervisor.getzipstate() === 2){
                    if(popup_usb_notice.mode== "compress"){
                        text_usb_state.text = "저장에 성공하였습니다.";
                    }else{
                        btn_usb_confirm.visible = true;
                        text_usb_state.text = "파일을 성공적으로 가져왔습니다.\n확인을 누르시면 업데이트를 진행합니다.";
                    }

                }else if(supervisor.getzipstate() === 3){
                    if(popup_usb_notice.mode== "compress"){
                        text_usb_state.text = "저장에 성공하였지만 일부 과정에서 에러가 발생했습니다.";
                    }else{
                        text_usb_state.text = "파일을 성공적으로 가져왔습니다만 일부 과정에서 에러가 발생했습니다.\n확인을 누르시면 업데이트를 진행합니다.";
                        btn_usb_confirm.visible = true;
                    }
                    model_usb_error.clear();
                    for(var i=0; i<supervisor.getusberrorsize(); i++){
                        model_usb_error.append({"error":supervisor.getusberror(i)});
                    }
                }else if(supervisor.getzipstate() === 4){
                    if(popup_usb_notice.mode== "compress"){
                        text_usb_state.text = "저장에 실패했습니다.";
                    }else{
                        text_usb_state.text = "파일을 가져오지 못했습니다.";
                    }
                    model_usb_error.clear();
                    for(var i=0; i<supervisor.getusberrorsize(); i++){
                        model_usb_error.append({"error":supervisor.getusberror(i)});
                    }
                }else{
                    print(supervisor.getzipstate());
                    text_usb_state.text = "잠시만 기다려주세요.";
                }
            }
        }
        onOpened:{
            timer_usb_check.start();
            model_usb_error.clear();
            btn_usb_confirm.visible = false;
            text_usb_state.text = "잠시만 기다려주세요.";
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
                    text:"잠시만 기다려주세요."
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
                            "가져오실 파일 목록을 선택해주세요."
                        else if(popup_usb_download.index === 1)
                            "가져오실 목록을 선택해주세요."
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
                        text: "가장 최신 파일"
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
                        text: "확인"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
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
                        text: "그 외 발견한 파일 목록"
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
                    text: "확인"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
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
        id: popup_usb_select
        anchors.centerIn: parent
        width: 400
        height: 500
        leftPadding: 0
        topPadding: 0
        bottomPadding: 0
        rightPadding: 0
        property int usb_size: 0
        property int index: 0
        property bool is_ui: false
        property bool is_slam: false
        property bool is_map: false
        property bool is_log: false
        property bool is_config: false
        property string set_name: "Desktop"
        background: Rectangle{
            color: "transparent"
        }
        onOpened: {
            if(supervisor.getusbsize() > 0){
                text_no_usb.visible =false;
            }else{
                text_no_usb.visible = true;
            }

            timer_check_usb_new.start();
            index = 0;
            is_ui = true;
            is_slam = true;
            is_map = false;
            is_log = false;
            is_config = true;
            model_usb_list.clear();
            for(var i=0; i<supervisor.getusbsize(); i++){
                print(i, supervisor.getusbname(i));
                model_usb_list.append({"name":supervisor.getusbname(i)});
            }
            model_usb_list.append({"name":"Desktop"});
        }
        onClosed: {
            timer_check_usb_new.stop();
        }

        Timer{
            id: timer_check_usb_new
            interval: 500
            running: false
            repeat: true
            onTriggered: {
                if(supervisor.getusbsize() > 0){
                    text_no_usb.visible =false;
                }else{
                    text_no_usb.visible = true;
                }
                model_usb_list.clear();
                for(var i=0; i<supervisor.getusbsize(); i++){
                    model_usb_list.append({"name":supervisor.getusbname(i)});
                }
                model_usb_list.append({"name":"Desktop"});
            }
        }

        Rectangle{
            anchors.fill: parent
            Rectangle{
                id: rect_1
                width: parent.width
                height: 50
                color: color_dark_navy
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    color: "white"
                    text: {
                        if(popup_usb_select.index === 0)
                            "저장할 USB 이름(혹은 Desktop)을 선택해주세요."
                        else if(popup_usb_select.index === 1)
                            "저장할 목록을 선택해주세요."
                    }
                }
            }
            Text{
                id: text_no_usb
                anchors.top: rect_1.bottom
                anchors.topMargin: 30
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: font_noto_r.name
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                color: color_red
                text: "** USB를 인식할 수 없습니다. **\n(USB를 뺏다 꼽아주시면 인식될 수 있습니다.)"
            }

            Column{
                anchors.centerIn: parent
                visible: popup_usb_select.index === 0
                spacing: 10
                Repeater{
                    model: ListModel{id:model_usb_list}
                    Rectangle{
                        width: 280
                        radius: 10
                        height: 50
                        color: color_light_gray
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: name
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                popup_usb_select.index = 1;
                                popup_usb_select.set_name = name;
                            }
                        }
                    }
                }
            }
            Column{
                anchors.centerIn: parent
                spacing: 10
                visible: popup_usb_select.index === 1
                Rectangle{
                    width: 280
                    radius: 10
                    height: 50
                    color: popup_usb_select.is_ui?color_green:color_light_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: "UI"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            popup_usb_select.is_ui = !popup_usb_select.is_ui;
                        }
                    }
                }
                Rectangle{
                    width: 280
                    radius: 10
                    height: 50
                    color: popup_usb_select.is_slam?color_green:color_light_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: "SLAMNAV"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            popup_usb_select.is_slam = !popup_usb_select.is_slam;
                        }
                    }
                }
                Rectangle{
                    width: 280
                    radius: 10
                    height: 50
                    color: popup_usb_select.is_config?color_green:color_light_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: "robot_config"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            popup_usb_select.is_config = !popup_usb_select.is_config;
                        }
                    }
                }
                Rectangle{
                    width: 280
                    radius: 10
                    height: 50
                    color: popup_usb_select.is_map?color_green:color_light_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: "maps"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            popup_usb_select.is_map = !popup_usb_select.is_map;
                        }
                    }
                }
                Rectangle{
                    width: 280
                    radius: 10
                    height: 50
                    color: popup_usb_select.is_log?color_green:color_light_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: "Log"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            popup_usb_select.is_log = !popup_usb_select.is_log;
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
                visible: popup_usb_select.index === 1
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    color:"white"
                    text: "확인"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        popup_usb_notice.setProperty("compress",popup_usb_select.set_name,popup_usb_select.is_ui,popup_usb_select.is_slam,popup_usb_select.is_config,popup_usb_select.is_map,popup_usb_select.is_log);
                        popup_usb_select.close();
                        popup_usb_notice.open();
                    }
                }
            }


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
            supervisor.setCallbell(callid);
        }
        onClosed: {
            supervisor.setCallbell(-1);
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
                            if(is_admin){
                                supervisor.pullGit();
                                popup_update.close();
                            }else{
                                popup_password.open();
                            }
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
                                            is_reset_slam = true;
                                            supervisor.writelog("[USER INPUT] SETTING PAGE : CAMERA SWITCH LEFT("+text_camera_1.text+") RIGHT("+text_camera_2.text+")");
                                            supervisor.setCamera(text_camera_1.text,text_camera_2.text);
                                        }
                                        left_camera.text = supervisor.getSetting("SENSOR","left_camera");
                                        right_camera.text = supervisor.getSetting("SENSOR","right_camera");
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
                                                width: rr.width*0.2
                                                height: 40
                                                Text{
                                                    id: text_preset_limit_pivot
                                                    anchors.centerIn: parent
                                                    text: slider_preset_limit_pivot.value.toFixed(2)
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
                                                width: rr.width*0.2
                                                height: 40
                                                Text{
                                                    id: text_preset_limit_v
                                                    anchors.centerIn: parent
                                                    text: slider_preset_limit_v.value.toFixed(2)
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
                                                width: rr.width*0.2
                                                height: 40
                                                Text{
                                                    id: text_preset_limit_vacc
                                                    anchors.centerIn: parent
                                                    text: slider_preset_limit_vacc.value.toFixed(2)
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
                                                width: rr.width*0.2
                                                height: 40
                                                Text{
                                                    id: text_preset_limit_w
                                                    anchors.centerIn: parent
                                                    text: slider_preset_limit_w.value.toFixed(2)
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
                                                width: rr.width*0.2
                                                height: 40
                                                Text{
                                                    id: text_preset_limit_wacc
                                                    anchors.centerIn: parent
                                                    text: slider_preset_limit_wacc.value.toFixed(2)
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
        anchors.centerIn: parent
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        bottomPadding: 0
        width: 450
        height: 300
        property var preset_num: 0
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }
        onOpened:{
            if(preset_num === 1){
                text_preset_name_set.text = "(  "+supervisor.getSetting("PRESET1","name") + "   )";
            }else if(preset_num === 2){
                text_preset_name_set.text = "(  "+supervisor.getSetting("PRESET2","name") + "   )";
            }else if(preset_num === 3){
                text_preset_name_set.text = "(  "+supervisor.getSetting("PRESET3","name") + "   )";
            }
        }
        Rectangle{
            width: parent.width
            height: parent.height
            radius: 10
            color: color_dark_navy
            Column{
                anchors.centerIn: parent
                spacing: 30

                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "선택하신 프리셋으로 세팅을 변경하시겠습니까?"
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                }
                Text{
                    id: text_preset_name_set
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                }

                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 30
                    Rectangle{
                        width: 150
                        height: 50
                        radius: 5
                        color: "transparent"
                        border.width: 2
                        border.color: "white"
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            text: "취소"
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
                        width: 150
                        height: 50
                        radius: 5
                        color: "white"
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            text: "확인"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                var name = "PRESET"+Number(popup_preset_set.preset_num);
                                supervisor.setSetting("ROBOT_SW/limit_pivot",supervisor.getSetting(name,"limit_pivot"));
                                supervisor.setSetting("ROBOT_SW/limit_v",supervisor.getSetting(name,"limit_v"));
                                supervisor.setSetting("ROBOT_SW/limit_v_acc",supervisor.getSetting(name,"limit_v_acc"));
                                supervisor.setSetting("ROBOT_SW/limit_w",supervisor.getSetting(name,"limit_w"));
                                supervisor.setSetting("ROBOT_SW/limit_w_acc",supervisor.getSetting(name,"limit_w_acc"));

                                slider_limit_pivot.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_pivot"));
                                slider_limit_v.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_v"));
                                slider_limit_v_acc.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_v_acc"));
                                slider_limit_w.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_w"));
                                slider_limit_w_acc.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_w_acc"));
                                slider_limit_pivot.ischanged = false;
                                slider_limit_v.ischanged = false;
                                slider_limit_v_acc.ischanged = false;
                                slider_limit_w.ischanged = false;
                                slider_limit_w_acc.ischanged = false;
                                is_reset_slam = true;
                                popup_preset_set.close();
                            }
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
            color: "transparent"
        }
        property string passwd: "2011"
        property string answer: ""
        property bool is_fail: false
        property var input_len: 0
        onIs_failChanged: {
            if(is_fail){
                setfailed();
            }else{
                setfailclear();
            }
        }

        onOpened:{
            model_passwd.clear();
            is_fail = false
            model_passwd.append({"show":false,"failed":false})
            model_passwd.append({"show":false,"failed":false})
            model_passwd.append({"show":false,"failed":false})
            model_passwd.append({"show":false,"failed":false})

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
        function setfailed(){
            for(var i=0; i<model_passwd.count; i++){
                model_passwd.get(i).failed = true;
            }
        }
        function setfailclear(){
            for(var i=0; i<model_passwd.count; i++){
                model_passwd.get(i).failed = false;
            }
        }

        onClosed:{
            if(is_admin && popup_update.opened){
                supervisor.writelog("[USER INPUT] Program Update : Password Correct -> pull start")
                supervisor.pullGit();
                popup_update.close();
            }
        }

        Rectangle{
            radius: 20
            clip: true
            anchors.centerIn: parent
            width: parent.width*0.99
            height: parent.height*0.99
            border.width: 3
            border.color: color_dark_navy
            Rectangle{
                radius: 20
                id: rect_password_top
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                Rectangle{
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    height: 20
                    color: color_dark_navy
                }
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
                anchors.topMargin: 30
                spacing: 50
                Rectangle{
                    width: 260
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
                                radius: 5
                                color: "transparent"
                                Rectangle{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.top: parent.top
                                    anchors.topMargin: 5
                                    visible: show
                                    width: 40
                                    height: width
                                    radius: width
                                    color: failed ? color_red : color_green
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
                anchors.bottomMargin: 40
                spacing: 17
                rows: 4
                columns: 3
                Repeater{
                    model: ListModel{id: model_pad}
                    Rectangle{
                        width: 68
                        height: width
                        radius: 5
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
                                    popup_password.setfailclear();
                                    popup_password.is_fail = false;
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
                                    popup_password.is_fail = false;
                                }else{
                                    if(popup_password.input_len === 4){
                                        is_admin = false;
                                        popup_password.is_fail = true;
                                        supervisor.writelog("[USER INPUT] SETTING PAGE -> ADMIN LOGIN FAILED "+popup_password.answer);
                                    }else{
                                        popup_password.is_fail = false;
                                        popup_password.answer += name;
                                        model_passwd.set(popup_password.input_len,{"show":true});
                                        popup_password.input_len++;
                                        if(popup_password.answer===popup_password.passwd){
                                            supervisor.writelog("[USER INPUT] SETTING PAGE -> ADMIN LOGIN SUCCESS");
                                            is_admin = true;
                                            popup_password.is_fail = true;
                                            popup_password.close();
                                        }else if(popup_password.input_len === 4){
                                            is_admin = false;
                                            popup_password.is_fail = true;
                                            supervisor.writelog("[USER INPUT] SETTING PAGE -> ADMIN LOGIN FAILED "+popup_password.answer);
                                        }else{
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
        id: popup_tf
        anchors.centerIn: parent
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        bottomPadding: 0
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }
        onOpened:{
            var left_str = supervisor.getSetting("SENSOR","left_camera_tf");
            var left_strs = left_str.split(",");
            tf_left_x.text = left_strs[0];
            tf_left_y.text = left_strs[1];
            tf_left_z.text = left_strs[2];
            tf_left_rx.text = left_strs[3];
            tf_left_ry.text = left_strs[4];
            tf_left_rz.text = left_strs[5];
            var right_str = supervisor.getSetting("SENSOR","right_camera_tf");
            var right_strs = right_str.split(",");
            tf_right_x.text = right_strs[0];
            tf_right_y.text = right_strs[1];
            tf_right_z.text = right_strs[2];
            tf_right_rx.text = right_strs[3];
            tf_right_ry.text = right_strs[4];
            tf_right_rz.text = right_strs[5];
        }

        width: 400
        height: 500
        Rectangle{
            width: parent.width
            height: parent.height
            radius: 10
            color: color_dark_navy
            Text{
                id: text_tf
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 30
                text: "카메라 TF 설정"
                color: "white"
                font.family: font_noto_r.name
                font.pixelSize: 20
            }

            Grid{
                id: grid_tf
                columns: 3
                rows: 6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_tf.bottom
                anchors.topMargin: 20
                horizontalItemAlignment: Grid.AlignHCenter
                verticalItemAlignment: Grid.AlignVCenter
                spacing: 15
                TextField{
                    id: tf_left_x
                    width: 80
                    height: 40
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    onFocusChanged: {
                        keyboard.owner = tf_left_x;
                        tf_left_x.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            keyboard.close();
                            tf_left_x.select(0,0);
                        }
                    }
                }
                Text{
                    text: "X"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 18
                }
                TextField{
                    id: tf_right_x
                    width: 80
                    height: 40
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    onFocusChanged: {
                        keyboard.owner = tf_right_x;
                        tf_right_x.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            keyboard.close();
                            tf_right_x.select(0,0);
                        }
                    }
                }
                TextField{
                    id: tf_left_y
                    width: 80
                    height: 40
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    onFocusChanged: {
                        keyboard.owner = tf_left_y;
                        tf_left_y.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            keyboard.close();
                            tf_left_y.select(0,0);
                        }
                    }
                }
                Text{
                    text: "Y"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 18
                }
                TextField{
                    id: tf_right_y
                    width: 80
                    height: 40
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    onFocusChanged: {
                        keyboard.owner = tf_right_y;
                        tf_right_y.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            keyboard.close();
                            tf_right_y.select(0,0);
                        }
                    }
                }
                TextField{
                    id: tf_left_z
                    width: 80
                    height: 40
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    onFocusChanged: {
                        keyboard.owner = tf_left_z;
                        tf_left_z.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            keyboard.close();
                            tf_left_z.select(0,0);
                        }
                    }
                }
                Text{
                    text: "Z"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 18
                }
                TextField{
                    id: tf_right_z
                    width: 80
                    height: 40
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    onFocusChanged: {
                        keyboard.owner = tf_right_z;
                        tf_right_z.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            keyboard.close();
                            tf_right_z.select(0,0);
                        }
                    }
                }
                TextField{
                    id: tf_left_rx
                    width: 80
                    height: 40
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    onFocusChanged: {
                        keyboard.owner = tf_left_rx;
                        tf_left_rx.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            keyboard.close();
                            tf_left_rx.select(0,0);
                        }
                    }
                }
                Text{
                    text: "RX"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 18
                }
                TextField{
                    id: tf_right_rx
                    width: 80
                    height: 40
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    onFocusChanged: {
                        keyboard.owner = tf_right_rx;
                        tf_right_rx.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            keyboard.close();
                            tf_right_rx.select(0,0);
                        }
                    }
                }
                TextField{
                    id: tf_left_ry
                    width: 80
                    horizontalAlignment: Text.AlignHCenter
                    height: 40
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    onFocusChanged: {
                        keyboard.owner = tf_left_ry;
                        tf_left_ry.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            keyboard.close();
                            tf_left_ry.select(0,0);
                        }
                    }
                }
                Text{
                    text: "RY"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 18
                }
                TextField{
                    id: tf_right_ry
                    width: 80
                    height: 40
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    onFocusChanged: {
                        keyboard.owner = tf_right_ry;
                        tf_right_ry.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            keyboard.close();
                            tf_right_ry.select(0,0);
                        }
                    }
                }
                TextField{
                    id: tf_left_rz
                    width: 80
                    height: 40
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    onFocusChanged: {
                        keyboard.owner = tf_left_rz;
                        tf_left_rz.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            keyboard.close();
                            tf_left_rz.select(0,0);
                        }
                    }
                }
                Text{
                    text: "RZ"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 18
                }
                TextField{
                    id: tf_right_rz
                    width: 80
                    height: 40
                    horizontalAlignment: Text.AlignHCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    onFocusChanged: {
                        keyboard.owner = tf_right_rz;
                        tf_right_rz.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            keyboard.close();
                            tf_right_rz.select(0,0);
                        }
                    }
                }
            }

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: grid_tf.bottom
                anchors.topMargin: 30
                spacing: 30
                Rectangle{
                    width: 100
                    height: 50
                    radius: 5
                    border.width: 1
                    border.color: color_gray
                    Text{
                        anchors.centerIn: parent
                        color: color_dark_navy
                        font.family: font_noto_r.name
                        font.pixelSize: 16
                        text: "취소"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            popup_tf.close();
                        }
                    }
                }
                Rectangle{
                    width: 100
                    height: 50
                    radius: 5
                    border.width: 1
                    border.color: color_gray
                    Text{
                        anchors.centerIn: parent
                        color: color_dark_navy
                        font.family: font_noto_r.name
                        font.pixelSize: 16
                        text: "확인"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            supervisor.writelog("[USER INPUT] SETTING CAMERA TF CHANGED");

                            var left_str = tf_left_x.text + "," + tf_left_y.text + "," + tf_left_z.text + "," + tf_left_rx.text + "," + tf_left_ry.text  + "," + tf_left_rz.text;
                            var right_str = tf_right_x.text + "," + tf_right_y.text + "," + tf_right_z.text + "," + tf_right_rx.text + "," + tf_right_ry.text  + "," + tf_right_rz.text;

                            supervisor.setSetting("SENSOR/left_camera_tf",left_str);
                            supervisor.setSetting("SENSOR/right_camera_tf",right_str);

                            popup_tf.close();
                        }
                    }
                }
            }
        }
    }

    Popup{
        id: popup_wifi
        anchors.centerIn: parent
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        bottomPadding: 0
        width: 400
        height: 500
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }
        onOpened:{
            supervisor.readWifi();
            model_wifis.clear();
            for(var i=0; i<supervisor.getWifiNum(); i++){
                model_wifis.append({"ssd":supervisor.getWifiSSD(i)});
            }
        }

        Rectangle{
            width: parent.width
            height: parent.height
            radius: 10
            color: color_dark_navy
            Text{
                id: text_wifi
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 30
                text: "WIFI 설정"
                color: "white"
                font.family: font_noto_r.name
                font.pixelSize: 20
            }

            Text{
                id: text_wifi2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_wifi.bottom
                anchors.topMargin: 20
                text: "하단의 리스트에서 연결할 WIFI를 선택해주세요."
                color: "white"
                font.family: font_noto_r.name
                font.pixelSize: 15
            }
            Flickable{
                width: parent.width
                height: 250
                clip: true
                contentHeight: col_wifis.height
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_wifi2.bottom
                anchors.topMargin: 15

                Column{
                    id: col_wifis
                    anchors.centerIn: parent
                    property var select_wifi: -1
                    spacing: 10
                    Repeater{
                        model : ListModel{id: model_wifis}
                        Rectangle{
                            width: 330
                            height: 40
                            radius: 5
                            color: col_wifis.select_wifi===index?color_green:"white"
                            Text{
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text: ssd
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
                                    col_wifis.select_wifi = index;
                                }
                            }
                        }
                    }
                }
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                spacing: 30
                Rectangle{
                    width: 150
                    height: 50
                    radius: 5
                    color: "transparent"
                    border.width: 2
                    border.color: "white"
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        text: "취소"
                        color: "white"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            popup_wifi.close();
                        }
                    }
                }
                Rectangle{
                    width: 150
                    height: 50
                    radius: 5
                    color: "white"
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        text: "확인"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            supervisor.setSetting("ROBOT_SW/wifi_ssd",model_wifis.get(col_wifis.select_wifi).ssd);
//                            popup_wifi_passwd.ssd = model_wifis.get(col_wifis.select_wifi).ssd;
//                            popup_wifi_passwd.open();
                            wifi_ssd.text = supervisor.getSetting("ROBOT_SW","wifi_ssd");
                            popup_wifi.close();
                        }
                    }
                }
            }
        }
    }
    Popup{
        id: popup_wifi_passwd
        anchors.centerIn: parent
        width: 200
        height: 150
        property string ssd: ""

        TextField{
            id: passwd_wifi
            anchors.centerIn: parent
            width: 100
            height: 50
            onFocusChanged: {
                keyboard.owner = passwd_wifi;
                passwd_wifi.selectAll();
                if(focus){
                    keyboard.open();
                }else{
                    keyboard.close();
                    passwd_wifi.select(0,0);
                    print("check connect", popup_wifi_passwd.ssd, passwd_wifi.text);
                    supervisor.connectWifi(popup_wifi_passwd.ssd, passwd_wifi.text)
                }
            }
        }
    }

    Popup{
        id: popup_changed
        anchors.centerIn: parent
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        bottomPadding: 0
        width: 450
        height: 300
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }
        Rectangle{
            width: parent.width
            height: parent.height
            radius: 10
            color: color_dark_navy
            Column{
                anchors.centerIn: parent
                spacing: 30

                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "세팅값 변경 감지"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                }

                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "변경한 값으로 저장하시려면 확인 버튼을 눌러주세요.\n취소하시면 저장되지 않습니다."
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 30
                    Rectangle{
                        width: 150
                        height: 50
                        radius: 5
                        color: "transparent"
                        border.width: 2
                        border.color: "white"
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            text: "취소"
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                backPage();
                            }
                        }
                    }
                    Rectangle{
                        width: 150
                        height: 50
                        radius: 5
                        color: "white"
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            text: "확인"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                save();
                                backPage();
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
