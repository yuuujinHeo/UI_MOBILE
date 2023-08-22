import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import "."
import io.qt.Supervisor 1.0
import io.qt.CameraView 1.0
import QtQuick.Controls.Styles 1.4
import QtMultimedia 5.12

Item {
    id: page_setting
    objectName: "page_setting"
    width: 1280
    height: 800

    property bool debug_use_ip: true
    property bool debug_test_1: false

    property bool is_admin: true

    property string select_category: "status"
    property string platform_name: supervisor.getRobotName()
    property string debug_platform_name: ""
    property bool is_debug: false
    property int motor_left_id: 1
    property int motor_right_id: 0

    property bool is_reset_slam: false

    property bool use_tray: false
    property bool use_multirobot: false
    property bool is_realsense: false

    function update_camera(){
        if(popup_camera.opened)
            popup_camera.update();
    }
    Component.onCompleted: {
        statusbar.visible = true;
        is_admin = false;
        is_reset_slam = false;
        supervisor.getAllWifiList();
        supervisor.getWifiIP();
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

    Tool_KeyPad{
        id: keypad
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
                height: 50
                color: "#323744"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "설정"
                    font.pixelSize: 25
                }
                MouseArea{
                    anchors.fill: parent
                    onDoubleClicked:{
                        supervisor.sendServer();
//                        click_sound.play();
//                        popup_password.open();
                    }
                }
            }
            Rectangle{
                id: rect_category_1
                width: 240
                height: 50
                color: "#647087"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "현재상태"
                    font.pixelSize: 25
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        click_sound.play();
                       select_category = "status";
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 7
                    visible: select_category==="status" ? true : false
                    color: "#12d27c"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                }
            }
            Rectangle{
                id: rect_category_2
                width: 240
                height: 50
                color: "#647087"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "로봇"
                    font.pixelSize: 25
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        click_sound.play();
                       select_category = "robot";
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 7
                    visible: select_category === "robot" ? true : false
                    color: "#12d27c"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                }
            }
            Rectangle{
                id: rect_category_3
                width: 264
                height: 50
                visible: is_admin
                color: "#647087"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "주행"
                    font.pixelSize: 25
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        click_sound.play();
                       select_category = "moving";
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 7
                    visible: select_category === "moving" ? true : false
                    color: "#12d27c"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                }
            }
            Rectangle{
                id: rect_category_4
                width: 240
                height: 50
                color: "#647087"
                visible: is_admin
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "인식"
                    font.pixelSize: 25
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        click_sound.play();
                       select_category = "slam";
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 7
                    visible: select_category === "slam" ? true : false
                    color: "#12d27c"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                }
            }
        }

        Flickable{
            id: area_setting_robot
            visible: select_category === "robot" ? true : false
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
                spacing:10
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
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"플랫폼 이름 (*영문)"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("플랫폼 이름");
                                    popup_help_setting.addLine("플랫폼을 지칭하는 이름을 적어주세요.");
                                    popup_help_setting.addLine("반드시 영문이어야 합니다. ");
                                    popup_help_setting.addLine("한글이나 특수문자가 들어가면 로봇이 움직이지 않을 수 있습니다.");
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
                                id: platform_name
                                anchors.fill: parent
                                horizontalAlignment: TextField.AlignHCenter
                                text:supervisor.getSetting("ROBOT_HW","model");
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                }
                                focus:false
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
                    height: 50
                    visible: false
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"플랫폼 넘버 (중복 주의)"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("플랫폼 넘버");
                                    popup_help_setting.addLine("로봇을 여러대 구동하며 동일한 로봇 이름을 사용하는 경우 사용합니다.");
                                    popup_help_setting.addLine("로봇을 여러대 구동할 경우 각각 지정해줘야 합니다.");
                                    popup_help_setting.addLine("각 로봇의 이름을 다르게 지정한 경우 지정하지 않으셔도 됩니다.");
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
                    height: 50
                    visible: false
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"플랫폼 번호(중복 주의)"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"플랫폼 타입"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("플랫폼 타입");
                                    popup_help_setting.addLine("지정하기 전, 지원되는 모델인지 확인하세요.");
                                    popup_help_setting.addLine("서빙용 : 호출기능을 사용하지 않고 각 테이블을 서빙만 합니다.");
                                    popup_help_setting.addLine("호출용 : 서빙기능을 사용하지 않고 로봇이 대기하다가 호출이 울리면 이동합니다.");
                                    popup_help_setting.addLine("서빙+호출용 : 서빙기능과 호출기능을 동시에 사용합니다. 서빙을 우선적으로 진행합니다.");
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
                            ComboBox{
                                id: combo_platform_type
                                anchors.fill: parent
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                }
                                model:["서빙용","호출용","서빙+호출용"]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_robot_442
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"최대 호출 횟수"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("최대 호출 횟수");
                                    popup_help_setting.addLine("지정하기 전, 지원되는 모델인지 확인하세요.");
                                    popup_help_setting.addLine("로봇이 한 번 이동에 호출되는 최대 횟수입니다..");
                                    popup_help_setting.addLine("대기 위치에서 출발한 뒤 해당 횟수만큼 테이블을 이동하면");
                                    popup_help_setting.addLine("추가적인 호출명령이 있어도 우선 대기위치로 돌아옵니다.");
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
                            ComboBox{
                                id: combo_max_calling
                                anchors.fill: parent
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                }
                                model:[1,2,3,4,5,6,7,8,9]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_resting_lock
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"대기장소 모터 락 해제"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("대기장소 모터 락 해제");
                                    popup_help_setting.addLine("로봇이 대기장소에서 대기하고 있을 때 사람이 밀어서 움직일 수 있는지 설정합니다.");
                                    popup_help_setting.addLine("매장 바닥 상황에 따라 로봇이 굴러서 저절로 이동할 수 있으니 기본적으론 사용 안함으로 이용해주세요.");
                                    popup_help_setting.addLine("사용 시에도 서빙을 보내기 전 대기장소와 너무 떨어지지 않도록 유의해주세요.");
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
                            ComboBox{
                                id: combo_resting_lock
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
                    id: set_use_tray
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"트레이 별 서빙"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("트레이 별 서빙");
                                    popup_help_setting.addLine("트레이 별로 각각의 서빙위치를 지정하려면 사용하세요.");
                                    popup_help_setting.addLine("사용할 경우 서빙순서는 1번 트레이를 우선으로 이동합니다.");
                                    popup_help_setting.addLine("대기화면이 변경되며 그룹을 사용하지 않고 각 테이블 번호로 이동합니다.");
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
                            ComboBox{
                                id: combo_use_tray
                                anchors.fill: parent
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                    if(currentIndex == 0){
                                        use_tray = false;
                                    }else{
                                        use_tray = true;
                                    }
                                }
                                model:["사용안함", "사용"]

                            }
                        }
                    }
                }
                Rectangle{
                    id: set_tray_num
                    width: 840
                    height: 50
                    visible: use_tray
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"트레이 개수"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                            ComboBox{
                                id: combo_tray_num
                                anchors.fill: parent
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                }
                                model:[1,2,3]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_movingpage
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"이동 중 화면"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("이동 중 화면");
                                    popup_help_setting.addLine("로봇이 이동 중에 화면에 표시될 것을 고르세요.");
                                    popup_help_setting.addLine("목적지 표시 : 목적지가 화면에 표시됩니다.");
                                    popup_help_setting.addLine("귀여운 얼굴 : 귀여운 표정이 화면 가득 표시됩니다.");
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
                    id: set_comeback_preset
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"복귀 속도 지정"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("복귀 속도 지정");
                                    popup_help_setting.addLine("로봇이 서빙 후 대기위치로 이동할 때 속도를 지정합니다.");
                                    popup_help_setting.addLine("사용하지 않으면 서빙 때 지정한 속도 그대로 사용합니다.");
                                    popup_help_setting.addLine("안전속도 구간에 진입하면 속도가 자동으로 저하됩니다.");
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
                            ComboBox{
                                id: combo_comeback_preset
                                anchors.fill: parent
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                }
                                model:["사용 안함", "아주느리게","느리게","보통","빠르게","아주빠르게"]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_preset
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"이동 속도"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("이동 속도 (프리셋)");
                                    popup_help_setting.addLine("이동속도는 5단계로 분류됩니다");
                                    popup_help_setting.addLine("각각의 이동속도와 이름을 변경하실 수도 있습니다.");
                                    popup_help_setting.addLine("안전속도맵을 사용하시는 경우, 기본 프리셋 기준 아주느리게, 느리게로 지정됩니다.");
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
                            Row{
                                anchors.centerIn: parent
                                spacing: 10
                                Rectangle{
                                    width:70
                                    height: 50
                                    radius: 5
                                    border.width: 1
                                    Text{
                                        id: text_preset_name_1
                                        anchors.centerIn: parent
                                        text: "preset 1"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 13
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            click_sound.play();
                                            popup_preset.select_preset = 1;
                                            popup_preset.open();
                                        }
                                    }
                                }
                                Rectangle{
                                    width:70
                                    height: 50
                                    radius: 5
                                    border.width: 1
                                    Text{
                                        id: text_preset_name_2
                                        anchors.centerIn: parent
                                        text: "preset 2"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 13
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            click_sound.play();
                                            popup_preset.select_preset = 2;
                                            popup_preset.open();

                                        }
                                    }
                                }
                                Rectangle{
                                    width:70
                                    height: 50
                                    radius: 5
                                    border.width: 1
                                    Text{
                                        id: text_preset_name_3
                                        anchors.centerIn: parent
                                        text: "preset 3"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 13
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            click_sound.play();
                                            popup_preset.select_preset = 3;
                                            popup_preset.open();
                                        }
                                    }
                                }
                                Rectangle{
                                    width:70
                                    height: 50
                                    radius: 5
                                    border.width: 1
                                    Text{
                                        id: text_preset_name_4
                                        anchors.centerIn: parent
                                        text: "preset 4"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 13
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            click_sound.play();
                                            popup_preset.select_preset = 4;
                                            popup_preset.open();

                                        }
                                    }
                                }
                                Rectangle{
                                    width:70
                                    height: 50
                                    radius: 5
                                    border.width: 1
                                    Text{
                                        id: text_preset_name_5
                                        anchors.centerIn: parent
                                        text: "preset 5"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 13
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            click_sound.play();
                                            popup_preset.select_preset = 5;
                                            popup_preset.open();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_bgm_volume
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"음악 볼륨"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
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
                                            click_sound.play();
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
                                    height: 50
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
                                            click_sound.play();
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
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"음성 볼륨"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
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
                                            click_sound.play();
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
                                    height: 50
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
                                            click_sound.play();
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
                    id: set_voice_button
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"버튼클릭 볼륨"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }

                        Rectangle{
                            id: te3
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Image{
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "icon/icon_mute.png"
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            click_sound.play();
                                            if(slider_volume_button.value == 0){
                                                slider_volume_button.value  = Number(supervisor.getSetting("ROBOT_SW","volume_button"));
                                            }else{
                                                slider_volume_button.value  = 0;
                                            }
                                        }
                                    }
                                }
                                Slider{
                                    anchors.verticalCenter: parent.verticalCenter
                                    id: slider_volume_button
                                    width: te.width*0.7
                                    height: 50
                                    from: 0
                                    to: 100
                                    property bool ischanged: false
                                    onValueChanged: {
                                        ischanged = true;
                                        volume_button = value;
                                    }
                                    value: supervisor.getSetting("ROBOT_SW","volume_button")
                                }
                                Image{
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "icon/icon_test_play.png"
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            start_sound.play();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle{
                    id: set_tableview
                    width: 840
                    height: 50
                    visible: false
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"테이블 표시"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                            ComboBox{
                                id: combo_tableview
                                anchors.fill: parent
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                }
                                model:["테이블 번호로 표시", "테이블 별칭으로 표시", "테이블 맵으로 표시(설정 필요)"]
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
                        text:"멀티로봇"
                        color: "white"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    id: set_use_multirobot
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"멀티로봇 사용"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                            ComboBox{
                                id: combo_multirobot
                                anchors.fill: parent
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                    if(currentIndex == 0){
                                        use_multirobot = false;
                                    }else{
                                        use_multirobot = true;
                                    }
                                }
                                model:["사용안함","사용"]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_server_ip
                    width: 840
                    height: 50
                    visible: use_multirobot
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"서버 IP"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                TextField{
                                    id: server_ip_1
                                    width: 70
                                    height: 50
                                    focus:false
                                    onFocusChanged: {
                                        keyboard.owner = server_ip_1;
                                        server_ip_1.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            keyboard.close();
                                            server_ip_1.select(0,0);
                                        }
                                    }
                                    color: ischanged?color_red:"black"
                                    property bool ischanged: false
                                    onTextChanged: {
                                        ischanged = true;
                                        if(server_ip_1.text.split(".").length > 1){
                                            server_ip_1.text = server_ip_1.text.split(".")[0];
                                            server_ip_1.focus = false;
                                            server_ip_2.focus = true;
                                        }
                                        if(server_ip_1.text.length == 3){
                                            server_ip_1.focus = false;
                                            server_ip_2.focus = true;
                                        }
                                    }
                                }
                                Text{
                                    anchors.verticalCenter: parent.verticalCenter
                                    text:"."
                                }

                                TextField{
                                    id: server_ip_2
                                    width: 70
                                    height: 50
                                    focus:false
                                    onFocusChanged: {
                                        keyboard.owner = server_ip_2;
                                        server_ip_2.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            keyboard.close();
                                            server_ip_2.select(0,0);
                                        }
                                    }
                                    color: ischanged?color_red:"black"
                                    property bool ischanged: false
                                    onTextChanged: {
                                        ischanged = true;
                                        if(server_ip_2.text == "."){
                                            server_ip_2.text = server_ip_2.text.split(".")[0]
                                        }

                                        if(server_ip_2.text.split(".").length > 1){
                                            server_ip_2.text = server_ip_2.text.split(".")[0];
                                            server_ip_2.focus = false;
                                            server_ip_3.focus = true;
                                        }
                                        if(server_ip_2.text.length == 3){
                                            server_ip_2.focus = false;
                                            server_ip_3.focus = true;
                                        }
                                    }
                                }
                                Text{
                                    anchors.verticalCenter: parent.verticalCenter
                                    text:"."
                                }
                                TextField{
                                    id: server_ip_3
                                    width: 70
                                    height: 50
                                    focus:false
                                    onFocusChanged: {
                                        keyboard.owner = server_ip_3;
                                        server_ip_3.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            server_ip_3.select(0,0);
                                            keyboard.close();
                                        }
                                    }
                                    color: ischanged?color_red:"black"
                                    property bool ischanged: false
                                    onTextChanged: {
                                        ischanged = true;
                                        if(server_ip_3.text == "."){
                                            server_ip_3.text = server_ip_3.text.split(".")[0]
                                        }

                                        if(server_ip_3.text.split(".").length > 1){
                                            server_ip_3.text = server_ip_3.text.split(".")[0];
                                            server_ip_3.focus = false;
                                            server_ip_4.focus = true;
                                        }
                                        if(server_ip_3.text.length == 3){
                                            server_ip_3.focus = false;
                                            server_ip_4.focus = true;
                                        }
                                    }
                                }
                                Text{
                                    anchors.verticalCenter: parent.verticalCenter
                                    text:"."
                                }
                                TextField{
                                    id: server_ip_4
                                    width: 70
                                    height: 50
                                    focus:false
                                    onFocusChanged: {
                                        keyboard.owner = server_ip_4;
                                        server_ip_4.selectAll();
                                        if(focus){
                                            keyboard.open();
                                        }else{
                                            server_ip_4.select(0,0);
                                            keyboard.close();
                                        }
                                    }
                                    color: ischanged?color_red:"black"
                                    property bool ischanged: false
                                    onTextChanged: {
                                        ischanged = true;
                                        if(server_ip_4.text == "."){
                                            server_ip_4.text = server_ip_4.text.split(".")[0]
                                        }

                                        if(server_ip_4.text.split(".").length > 1){
                                            server_ip_4.text = server_ip_4.text.split(".")[0];
                                            server_ip_4.focus = false;
                                        }
                                        if(server_ip_4.text.length == 3){
                                            server_ip_4.focus = false;
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
                                            click_sound.play();
                                            server_ip_1.ischanged = false;
                                            server_ip_2.ischanged = false;
                                            server_ip_3.ischanged = false;
                                            server_ip_4.ischanged = false;
                                            var ip_str = server_ip_1.text + "." + server_ip_2.text + "." + server_ip_3.text + "." + server_ip_4.text;
                                            supervisor.setSetting("SERVER/fms_ip",ip_str);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_server_id
                    width: 840
                    height: 50
                    visible: use_multirobot
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"FMS 아이디"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: fms_id
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                focus:false
                                color: ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_HW","fms_id");
                                onFocusChanged: {
                                    keyboard.owner = fms_id;
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
                    id: set_server_pw
                    width: 840
                    height: 50
                    visible: use_multirobot
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"FMS 비밀번호"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: fms_pw
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                focus:false
                                color: ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_HW","fms_pw");
                                onFocusChanged: {
                                    keyboard.owner = fms_pw;
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
                    id: set_robot_radius
                    width: 840
                    visible: is_admin
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"로봇 반지름 반경 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: radius
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                focus:false
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
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"휠 베이스 반경 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: wheel_base
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                focus:false
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
                    height: 50
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"휠 반지름 반경 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: wheel_radius
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                }
                                focus:false
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
                    id: set_wifi_connection
                    width: 840
                    visible: is_admin && debug_use_ip
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"WIFI 연결상태"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            id: wifi_connection
                            width: parent.width - 351
                            height: parent.height
                            property int connection: 0
                            color: {
                                if(wifi_connection.connection === 1){
                                    color_yellow
                                }else if(wifi_connection.connection === 2){
                                    color_green
                                }else{
                                    color_red
                                }
                            }
                            Text{
                                anchors.centerIn: parent
                                font.family:font_noto_r.name
                                font.pixelSize:20
                                text:{
                                    if(wifi_connection.connection === 1){
                                        "연결중"
                                    }else if(wifi_connection.connection === 2){
                                        "연결됨"
                                    }else{
                                        "연결안됨"
                                    }
                                }
                                color: "white"
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_wifi_ssd
                    width: 840
                    visible: is_admin && debug_use_ip
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"WIFI SSD"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                            click_sound.play();
                                            //Debug
                                            supervisor.connectWifi("mobile_robot_test","rainbow2011");
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
                    visible: false
//                    visible: is_admin && debug_use_ip
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"WIFI Password"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                    focus:false
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
                                            click_sound.play();
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
                    height: 50
                    visible: is_admin && debug_use_ip
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"IP"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                TextField{
                                    id: ip_1
                                    width: 70
                                    height: 50
                                    focus:false
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
                                    height: 50
                                    focus:false
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
                                    height: 50
                                    focus:false
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
                                    height: 50
                                    focus:false
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
                                            supervisor.setSetting("ROBOT_SW/wifi_ip",ip_str);
                                            supervisor.setSetting("ROBOT_SW/wifi_gateway",gateway_str);
                                            supervisor.setSetting("ROBOT_SW/wifi_dnsmain",dns_str);
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
                    height: 50
                    visible: is_admin && debug_use_ip
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"Gateway"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                TextField{
                                    id: gateway_1
                                    width: 70
                                    height: 50
                                    focus:false
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
                                    height: 50
                                    focus:false
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
                                    height: 50
                                    focus:false
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
                                    height: 50
                                    focus:false
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
                                            supervisor.setSetting("ROBOT_SW/wifi_ip",ip_str);
                                            supervisor.setSetting("ROBOT_SW/wifi_gateway",gateway_str);
                                            supervisor.setSetting("ROBOT_SW/wifi_dnsmain",dns_str);
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
                    height: 50
                    visible: is_admin && debug_use_ip
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"DNS(Main)"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                TextField{
                                    id: dnsmain_1
                                    width: 70
                                    focus:false
                                    height: 50
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
                                    height: 50
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
                                    height: 50
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
                                    focus:false
                                    height: 50
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
                                            supervisor.setSetting("ROBOT_SW/wifi_ip",ip_str);
                                            supervisor.setSetting("ROBOT_SW/wifi_gateway",gateway_str);
                                            supervisor.setSetting("ROBOT_SW/wifi_dnsmain",dns_str);
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
                    height: 50
                    visible: false
//                    visible: is_admin && debug_use_ip
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"DNS(Serv)"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                TextField{
                                    id: dnsserv_1
                                    width: 70
                                    focus:false
                                    height: 50
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
                                    height: 50
                                    focus:false
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
                                    height: 50
                                    focus:false
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
                                    height: 50
                                    focus:false
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
                                            click_sound.play();
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
                    id: init_
                    width: 840
                    height: 50
                    visible: false//is_admin && debug_test_1
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"초기화"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                            Rectangle{
                                anchors.centerIn: parent
                                width: 300
                                height: 50
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
                                        click_sound.play();
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
            id: area_setting_slam
            visible: select_category==="slam"?true:false
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
                spacing:10
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
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > parent.width*0.8){
                                scale=scale-0.01;
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_camera_model
                    width: 840
                    height: 50
                    visible: false
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"카메라 모델"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                            ComboBox{
                                id: combo_camera_model
                                anchors.fill: parent
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                    is_reset_slam = true;
                                    if(currentIndex == 0){
                                        is_realsense = true;
                                    }else{
                                        is_realsense = false;
                                    }
                                }
                                model:["리얼센스","제미니"]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_cam_exposure
                    width: 840
                    height: 50
                    visible: is_realsense
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"노출 시간 [ms]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: cam_exposure
                                anchors.fill: parent
                                text:supervisor.getSetting("SENSOR","cam_exposure");
                                property bool ischanged: false
                                focus:false
                                color:ischanged?color_red:"black"
                                onFocusChanged: {
                                    keypad.owner = cam_exposure;
                                    cam_exposure.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        cam_exposure.select(0,0);
                                    }
                                }
                                onTextChanged: {
                                    if(focus){
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_left_camera
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"좌측 카메라 시리얼"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"우측 카메라 시리얼"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
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
                    id: set_left_camera_tf
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"좌측 카메라 TF"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"우측 카메라 TF"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                    id: set_obs_height_min
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"최소 인식 높이"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("최소 인식 높이");
                                    popup_help_setting.addLine("장애물 감지에 사용되는 카메라 3D 데이터값의 최소높이값입니다.");
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
                                id: obs_height_min
                                anchors.fill: parent
                                objectName: "obs_height_min"
                                text:supervisor.getSetting("ROBOT_SW","obs_height_min");
                                property bool ischanged: false
                                focus:false
                                color:ischanged?color_red:"black"
                                onFocusChanged: {
                                    keypad.owner = obs_height_min;
                                    obs_height_min.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        obs_height_min.select(0,0);
                                    }
                                }
                                onTextChanged: {
                                    if(focus){
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_obsheight_max
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"최대 인식 높이"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("최대 인식 높이");
                                    popup_help_setting.addLine("장애물 감지에 사용되는 카메라 3D 데이터값의 최대높이값입니다.");
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
                                id: obs_height_max
                                anchors.fill: parent
                                objectName: "obs_height_max"
                                text:supervisor.getSetting("ROBOT_SW","obs_height_max");
                                property bool ischanged: false
                                color:ischanged?color_red:"black"
                                focus:false
                                onFocusChanged: {
                                    keypad.owner = obs_height_max;
                                    obs_height_max.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        obs_height_max.select(0,0);
                                    }
                                }
                                onTextChanged: {
                                    if(focus){
                                        ischanged = true;
                                        is_reset_slam = true;
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
                        text:"라이다 설정"
                        color: "white"
                        font.pixelSize: 20
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > parent.width*0.8){
                                scale=scale-0.01;
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_max_range
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"데이터 최대 거리 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("데이터 최대 거리");
                                    popup_help_setting.addLine("연산에 사용되는 라이다 데이터의 최대값입니다.");
                                    popup_help_setting.addLine("이 값을 초과하는 라이다 데이터는 무시합니다.");
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
                                id: max_range
                                anchors.fill: parent
                                text:supervisor.getSetting("SENSOR","max_range");
                                property bool ischanged: false
                                focus:false
                                color:ischanged?color_red:"black"
                                onFocusChanged: {
                                    keypad.owner = max_range;
                                    max_range.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        max_range.select(0,0);
                                    }
                                }
                                onTextChanged: {
                                    if(focus){
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle{
                    id: set_icp_near
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"데이터 최소 거리 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("데이터 최소 거리");
                                    popup_help_setting.addLine("연산에 사용되는 라이다 데이터의 최소값(로봇 중심기준)입니다.");
                                    popup_help_setting.addLine("이 값보다 작은 라이다 데이터는 무시합니다.");
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
                                id: icp_near
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","icp_near");
                                onFocusChanged: {
                                    keypad.owner = icp_near;
                                    icp_near.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        icp_near.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_offset_X
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"오프셋 X [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("오프셋 X");
                                    popup_help_setting.addLine("로봇 중심기준으로 라이다센서의 X축 오프셋입니다.");
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
                                id: offset_x
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                color:ischanged?color_red:"black"
                                focus:false
                                text:supervisor.getSetting("SENSOR","offset_x");
                                onFocusChanged: {
                                    keypad.owner = offset_x;
                                    offset_x.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        offset_x.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_offset_y
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"오프셋 Y [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("오프셋 Y");
                                    popup_help_setting.addLine("로봇 중심기준으로 라이다센서의 Y축 오프셋입니다.");
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
                                id: offset_y
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                color:ischanged?color_red:"black"
                                focus:false
                                text:supervisor.getSetting("SENSOR","offset_y");
                                onFocusChanged: {
                                    keypad.owner = offset_y;
                                    offset_y.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        offset_y.select(0,0);
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
                        text:"주행 중 감지"
                        color: "white"
                        font.pixelSize: 20
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > parent.width*0.8){
                                scale=scale-0.01;
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_lookaheaddist
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"경로추종 최대거리 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("경로추종 최대거리");
                                    popup_help_setting.addLine("로봇과 로봇이 추종하는 경로 상 한 점 사이 최대 거리입니다.");
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
                                id: look_ahead_dist
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","look_ahead_dist");
                                onFocusChanged: {
                                    keypad.owner = look_ahead_dist;
                                    look_ahead_dist.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        look_ahead_dist.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_minlookaheaddist
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"경로추종 최소거리 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("경로추종 최대거리");
                                    popup_help_setting.addLine("로봇과 로봇이 추종하는 경로 상 한 점 사이 최소 거리입니다.");
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
                                id: min_look_ahead_dist
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","min_look_ahead_dist");
                                onFocusChanged: {
                                    keypad.owner = min_look_ahead_dist;
                                    min_look_ahead_dist.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        min_look_ahead_dist.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_decmargin
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"감지 거리 Level 1 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("감지 거리 Level 1");
                                    popup_help_setting.addLine("주행 중 장애물을 감지하는 범위의 level 1 값입니다.");
                                    popup_help_setting.addLine("로봇 중심 기준으로 동적장애물로 판단되는 것이 이 범위 안에 들어오면");
                                    popup_help_setting.addLine("감속하고 놀란 표정을 띄웁니다.(바닥의 LED 색은 보라색)");
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
                                id: obs_margin1
                                anchors.fill: parent
                                objectName: "obs_margin1"
                                text:supervisor.getSetting("ROBOT_SW","obs_margin1");
                                property bool ischanged: false
                                focus:false
                                color:ischanged?color_red:"black"
                                onFocusChanged: {
                                    keypad.owner = obs_margin1;
                                    obs_margin1.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        obs_margin1.select(0,0);
                                    }
                                }
                                onTextChanged: {
                                    if(focus){
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_decmargin0
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"감지 거리 Level 0 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("감지 거리 Level 0");
                                    popup_help_setting.addLine("주행 중 장애물을 감지하는 범위의 level 0 값입니다.");
                                    popup_help_setting.addLine("로봇 중심 기준으로 동적장애물로 판단되는 것이 이 범위 안에 들어오면");
                                    popup_help_setting.addLine("로봇을 즉시 정지하며 우는 표정을 띄웁니다.(바닥의 LED 색은 붉은색)");
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
                                id: obs_margin0
                                anchors.fill: parent
                                objectName: "obs_margin0"
                                text:supervisor.getSetting("ROBOT_SW","obs_margin0");
                                property bool ischanged: false
                                focus:false
                                color:ischanged?color_red:"black"
                                onFocusChanged: {
                                    keypad.owner = obs_margin0;
                                    obs_margin0.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        obs_margin0.select(0,0);
                                    }
                                }
                                onTextChanged: {
                                    if(focus){
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_obs_area
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"장애물 넓이 [pixel]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("장애물 넓이");
                                    popup_help_setting.addLine("감지되는 동적 센서 데이타가 이 값만큼 뭉쳐있다면 장애물로 판단합니다.");
                                    popup_help_setting.addLine("단위는 pixel로 현재 설정된 픽셀 당 크기 값을 참조하세요.");
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
                                id: obs_detect_area
                                anchors.fill: parent
                                objectName: "obs_detect_area"
                                text:supervisor.getSetting("ROBOT_SW","obs_detect_area");
                                property bool ischanged: false
                                focus:false
                                color:ischanged?color_red:"black"
                                onFocusChanged: {
                                    keypad.owner = obs_detect_area;
                                    obs_detect_area.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        obs_detect_area.select(0,0);
                                    }
                                }
                                onTextChanged: {
                                    if(focus){
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_obs_sensitivity
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"장애물 감지 민감도"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("장애물 감지 민감도");
                                    popup_help_setting.addLine("동적장애물로 판단하는 픽셀의 민감도 입니다.");
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
                                id: obs_detect_sensitivity
                                anchors.fill: parent
                                objectName: "obs_detect_sensitivity"
                                text:supervisor.getSetting("ROBOT_SW","obs_detect_sensitivity");
                                property bool ischanged: false
                                focus:false
                                color:ischanged?color_red:"black"
                                onFocusChanged: {
                                    keypad.owner = obs_detect_sensitivity;
                                    obs_detect_sensitivity.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        obs_detect_sensitivity.select(0,0);
                                    }
                                }
                                onTextChanged: {
                                    if(focus){
                                        ischanged = true;
                                        is_reset_slam = true;
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_obs_deadzone
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"즉시정지 거리 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("즉시정지 거리");
                                    popup_help_setting.addLine("로봇 중심 기준으로 동적장애물로 판단되는 것이 이 범위 안에 들어오면");
                                    popup_help_setting.addLine("로봇을 즉시 정지하며 우는 표정을 띄웁니다.(바닥의 LED 색은 붉은색)");
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
                                id: obs_deadzone
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","obs_deadzone");
                                onFocusChanged: {
                                    keypad.owner = obs_deadzone;
                                    obs_deadzone.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        obs_deadzone.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_obs_wait_time
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"감지 후 대기시간 [sec]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("감지 후 대기시간");
                                    popup_help_setting.addLine("장애물을 감지 후 로봇이 멈춘 뒤 다시 출발할 때 까지 걸리는 대기시간입니다.");
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
                                id: obs_wait_time
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","obs_wait_time");
                                onFocusChanged: {
                                    keypad.owner = obs_wait_time;
                                    obs_wait_time.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        obs_wait_time.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_path_out_dist
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"경로이탈 거리 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("경로이탈 거리");
                                    popup_help_setting.addLine("로봇이 경로에서 이 값 이상 떨어지면 경로를 이탈했다고 판단합니다.");
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
                                id: path_out_dist
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","path_out_dist");
                                onFocusChanged: {
                                    keypad.owner = path_out_dist;
                                    path_out_dist.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        path_out_dist.select(0,0);
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
                        text:"위치 추정"
                        color: "white"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    id: set_icp_dist
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"Inlier 판단거리 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:
                                {
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("Inlier 판단거리");
                                    popup_help_setting.addLine("로봇이 위치추정할 때, 실제 라이다데이터와 맵상 대응점과의 위치차이가");
                                    popup_help_setting.addLine("이 값보다 작다면 inlier(일치)한다고 판단합니다.");
                                    popup_help_setting.addLine("이 값이 작을 수록 위치추정이 정밀하지만 위치추정에 실패할 가능성도 높아집니다.");
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
                                id: icp_dist
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","icp_dist");
                                onFocusChanged: {
                                    keypad.owner = icp_dist;
                                    icp_dist.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        icp_dist.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_icp_error
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"평균오차 최소값 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:
                                {
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("평균오차 최소값(icp_error)");
                                    popup_help_setting.addLine("Inlier 판단된 데이터들의 실제 라이다데이터와 맵상 대응점과의 위치차이의 평균이");
                                    popup_help_setting.addLine("이 값보다 작다면 위치추정에 성공했다고 판단합니다.");
                                    popup_help_setting.addLine("위치추정은 평균오차의 최소값과 Inlier 비율이 모두 기준에 부합해야 성공으로 간주합니다.");
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
                                id: icp_error
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","icp_error");
                                onFocusChanged: {
                                    keypad.owner = icp_error;
                                    icp_error.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        icp_error.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_icp_ratio
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"Inlier 비율 [%]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:
                                {
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("Inlier 비율 (icp_ratio)");
                                    popup_help_setting.addLine("전체 라이다데이터 대비 lnlier 판단된 데이터 값의 비율입니다.");
                                    popup_help_setting.addLine("실제 값이 이 기준보다 높아야 위치추정에 성공했다고 판단합니다.");
                                    popup_help_setting.addLine("위치추정은 평균오차의 최소값과 Inlier 비율이 모두 기준에 부합해야 성공으로 간주합니다.");
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
                                id: icp_ratio
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","icp_ratio");
                                onFocusChanged: {
                                    keypad.owner = icp_ratio;
                                    icp_ratio.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        icp_ratio.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle{
                    id: set_icp_odometry_weight
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text: "모터 위치추정 비율 [%]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("모터 위치추정 비율");
                                    popup_help_setting.addLine("모터의 엔코더값으로 계산되는 위치추정 값을 얼마나 사용할지의 비율입니다.");
                                    popup_help_setting.addLine("값이 0에 가까울 수록 라이다데이타로 추정하는 ICP를 신뢰하고");
                                    popup_help_setting.addLine("값이 1에 가까울 수록 라이다데이타는 사용하지 않습니다.");
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
                                id: icp_odometry_weight
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","icp_odometry_weight");
                                onFocusChanged: {
                                    keypad.owner = icp_odometry_weight;
                                    icp_odometry_weight.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        icp_odometry_weight.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_icp_repeat_dist
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"위치추정 최소 거리 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("위치추정 최소 거리");
                                    popup_help_setting.addLine("로봇이 주행하며 이 거리 이상 움직이면 위치추정을 시도합니다.");
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
                                id: icp_repeat_dist
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","icp_repeat_dist");
                                onFocusChanged: {
                                    keypad.owner = icp_repeat_dist;
                                    icp_repeat_dist.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        icp_repeat_dist.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_icp_repeat_time
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"위치추정 최소 시간[sec]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("위치추정 최소 시간");
                                    popup_help_setting.addLine("로봇은 이 시간 간격으로 자동으로 위치추정을 시도합니다.");
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
                                id: icp_repeat_time
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","icp_repeat_time");
                                onFocusChanged: {
                                    keypad.owner = icp_repeat_time;
                                    icp_repeat_time.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        icp_repeat_time.select(0,0);
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
                        text:"도착점 판단"
                        color: "white"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    id: set_goal_dist
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"도착점 허용 오차 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("도착점 허용 오차");
                                    popup_help_setting.addLine("로봇의 현재 위치와 목적지의 위치차이가 이 값보다 작으면 목적지에 도착했다고 판단합니다.");
                                    popup_help_setting.addLine("값이 작을 수록 목작지에 정확하게 도달하지만 조금만 틀어져도 목적지에 도착했다고 판단하지 않아서");
                                    popup_help_setting.addLine("주행실패하거나 이상동작을 할 수 있습니다.");
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
                                id: goal_dist
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","goal_dist");
                                onFocusChanged: {
                                    keypad.owner = goal_dist;
                                    goal_dist.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        goal_dist.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_goal_th
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"도착점 허용 오차 [deg]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("도착점 허용 오차");
                                    popup_help_setting.addLine("로봇의 현재 위치와 목적지의 위치차이가 이 값보다 작으면 목적지에 도착했다고 판단합니다.");
                                    popup_help_setting.addLine("값이 작을 수록 목작지에 정확하게 도달하지만 조금만 틀어져도 목적지에 도착했다고 판단하지 않아서");
                                    popup_help_setting.addLine("주행실패하거나 이상동작을 할 수 있습니다.");
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
                                id: goal_th
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","goal_th");
                                onFocusChanged: {
                                    keypad.owner = goal_th;
                                    goal_th.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        goal_th.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_goal_near_dist
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"경로탐색 최소거리 [m]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("경로탐색 최소거리");
                                    popup_help_setting.addLine("출발점과 도착점이 이 값보다 작으면 경로를 탐색하지 않고");
                                    popup_help_setting.addLine("point to point 방식으로 이동합니다.");
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
                                id: goal_near_dist
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","goal_near_dist");
                                onFocusChanged: {
                                    keypad.owner = goal_near_dist;
                                    goal_near_dist.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        goal_near_dist.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Flickable{
            id: area_setting_moving
            visible: select_category==="moving"?true:false
            width: 880
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 120
            height: parent.height - 200
            contentHeight: column_setting45.height
            clip: true
            ScrollBar.vertical: ScrollBar{
                width: 20
                anchors.right: parent.right
                policy: ScrollBar.AlwaysOn
            }
            Column{
                id:column_setting45
                width: parent.width
                spacing:10
                Rectangle{
                    width: 1100
                    height: 40
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_b.name
                        text:"자동 일시정지"
                        color: "white"
                        font.pixelSize: 20
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > parent.width*0.8){
                                scale=scale-0.01;
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_use_current
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"모터전류 감지"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("모터전류 감지");
                                    popup_help_setting.addLine("로봇이 주행 중, 충돌했다고 판단할만큼 모터의 전류가 높다면 자동으로 일시정지합니다.");
                                    popup_help_setting.addLine("감도를 올리거나 내리고 싶다면 모터전류 제한값을 변경해 주세요.");
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
                            ComboBox{
                                id: combo_use_motorcurrent
                                anchors.fill: parent
                                property bool ischanged: false
                                onCurrentIndexChanged: {
                                    ischanged = true;
                                }
                                model:["사용안함","사용"]
                            }
                        }
                    }
                }

                Rectangle{
                    id: set_motor_current_margin
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"모터전류 제한값"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: pause_motor_current
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("MOTOR","pause_motor_current");
                                onFocusChanged: {
                                    keypad.owner = pause_motor_current;
                                    pause_motor_current.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        pause_motor_current.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"모터전류 제한시간 [ms]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: pause_check_ms
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("MOTOR","pause_check_ms");
                                onFocusChanged: {
                                    keypad.owner = pause_check_ms;
                                    pause_check_ms.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        pause_check_ms.select(0,0);
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
                        text:"속도 제한"
                        color: "white"
                        font.pixelSize: 20
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > parent.width*0.8){
                                scale=scale-0.01;
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limitpivot
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"제자리 회전속도 [deg/s]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("제자리 회전속도(limit_pivot)");
                                    popup_help_setting.addLine("로봇이 출발점에서 출발하기 전, 도착점에 도착 후 제자리 회전을 할때의 속도입니다.");
                                    popup_help_setting.addLine("속도 제한값으로 로봇이 제자리회전 시, 이 속도를 초과하지 않습니다.");
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
                                id: limit_pivot
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","limit_pivot");
                                focus:false
                                onFocusChanged: {
                                    keypad.owner = limit_pivot;
                                    limit_pivot.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        limit_pivot.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limitpivotacc
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"제자리 회전 가속도 [deg/s^2]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("제자리 회전가속도(limit_pivot_acc)");
                                    popup_help_setting.addLine("로봇이 출발점에서 출발하기 전, 도착점에 도착 후 제자리 회전을 할때의 가속도입니다.");
                                    popup_help_setting.addLine("속도 제한값으로 로봇이 제자리회전 시, 이 속도를 초과하지 않습니다.");
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
                                id: limit_pivot_acc
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                color:ischanged?color_red:"black"
                                focus:false
                                text:supervisor.getSetting("ROBOT_SW","limit_pivot_acc");
                                onFocusChanged: {
                                    keypad.owner = limit_pivot_acc;
                                    limit_pivot_acc.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        limit_pivot_acc.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limitv
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"주행 속도 [m/s]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("주행 속도(limit_v)");
                                    popup_help_setting.addLine("로봇이 주행할 때의 최대 속도입니다.");
                                    popup_help_setting.addLine("속도 제한값으로 로봇이 주행 시, 이 속도를 초과하지 않습니다.");
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
                                id: limit_v
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","limit_v");
                                onFocusChanged: {
                                    keypad.owner = limit_v;
                                    limit_v.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        limit_v.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limit_vacc
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"주행 가속도 [m/s^2]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("주행 가속도(limit_v)");
                                    popup_help_setting.addLine("로봇이 주행할 때의 최대 가속도입니다.");
                                    popup_help_setting.addLine("속도 제한값으로 로봇이 주행 시, 이 가속도를 초과하지 않습니다.");
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
                                id: limit_v_acc
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","limit_v_acc");
                                onFocusChanged: {
                                    keypad.owner = limit_v_acc;
                                    limit_v_acc.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        limit_v_acc.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limitw
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"주행 회전속도 [deg/s]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("주행 회전속도(limit_w)");
                                    popup_help_setting.addLine("로봇이 주행할 때의 최대 회전속도입니다.");
                                    popup_help_setting.addLine("속도 제한값으로 로봇이 주행 시, 이 회전속도를 초과하지 않습니다.");
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
                                id: limit_w
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","limit_w");
                                onFocusChanged: {
                                    keypad.owner = limit_w;
                                    limit_w.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        limit_w.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limitwacc
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"주행 회전 가속도 [deg/s^2]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("주행 회전 가속도(limit_w_acc)");
                                    popup_help_setting.addLine("로봇이 주행할 때의 최대 회전 가속도입니다.");
                                    popup_help_setting.addLine("속도 제한값으로 로봇이 주행 시, 이 회전 가속도를 초과하지 않습니다.");
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
                                id: limit_w_acc
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","limit_w_acc");
                                onFocusChanged: {
                                    keypad.owner = limit_w_acc;
                                    limit_w_acc.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        limit_w_acc.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: setlimitmanualv
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"JOG 속도 [m/s]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("JOG 속도(limit_manual_v)");
                                    popup_help_setting.addLine("로봇을 Joystick 혹은 JOG로 움직일 때의 최대 속도입니다.");
                                    popup_help_setting.addLine("속도 제한값으로 로봇이 주행 시, 이 속도를 초과하지 않습니다.");
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
                                id: limit_manual_v
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","limit_manual_v");
                                onFocusChanged: {
                                    keypad.owner = limit_manual_v;
                                    limit_manual_v.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        limit_manual_v.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: setlimitmanualw
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"JOG 회전속도 [deg/s]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("JOG 회전속도(limit_manual_v)");
                                    popup_help_setting.addLine("로봇을 Joystick 혹은 JOG로 움직일 때의 최대 회전속도입니다.");
                                    popup_help_setting.addLine("속도 제한값으로 로봇이 주행 시, 이 회전속도를 초과하지 않습니다.");
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
                                id: limit_manual_w
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","limit_manual_w");
                                onFocusChanged: {
                                    keypad.owner = limit_manual_w;
                                    limit_manual_w.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        limit_manual_w.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_st_v
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"출발 속도 [m/s]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("출발 속도(st_v)");
                                    popup_help_setting.addLine("로봇이 출발할 때, 처음으로 주어지는 속도값입니다.");
                                    popup_help_setting.addLine("작을 수록 천천히 출발합니다.");
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
                                id: st_v
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","st_v");
                                onFocusChanged: {
                                    keypad.owner = st_v;
                                    st_v.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        st_v.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle{
                    id: set_goal_v
                    width: 840
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"도착 속도 [m/s]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Item_buttons{
                                type: "circle_text"
                                width: parent.height*0.8
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                text: "?"
                                onClicked:{
                                    click_sound.play();
                                    popup_help_setting.open();
                                    popup_help_setting.setTitle("도착 속도(goal_v)");
                                    popup_help_setting.addLine("로봇이 목적지에 인접했을 때, 감속되는 최종 속도값입니다.");
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
                                id: goal_v
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("ROBOT_SW","goal_v");
                                onFocusChanged: {
                                    keypad.owner = goal_v;
                                    goal_v.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        goal_v.select(0,0);
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
                    height: 50
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"모터 방향"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                    height: 50
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"왼쪽 ID"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                    height: 50
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"오른쪽 ID"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                    height: 50
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"모터 기어비"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: gear_ratio
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("MOTOR","gear_ratio");
                                onFocusChanged: {
                                    keypad.owner = gear_ratio;
                                    gear_ratio.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        gear_ratio.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_kp
                    width: 840
                    height: 50
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"P 게인"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: k_p
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("MOTOR","k_p");
                                onFocusChanged: {
                                    keypad.owner = k_p;
                                    k_p.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        k_p.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_ki
                    width: 840
                    height: 50
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"I 게인"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: k_i
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("MOTOR","k_i");
                                onFocusChanged: {
                                    keypad.owner = k_i;
                                    k_i.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        k_i.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_kd
                    width: 840
                    height: 50
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"D 게인"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: k_d
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("MOTOR","k_d");
                                onFocusChanged: {
                                    keypad.owner = k_d;
                                    k_d.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        k_d.select(0,0);
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
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"최대 선속도 [m/s]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: motor_limit_v
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("MOTOR","limit_v");
                                onFocusChanged: {
                                    keypad.owner = motor_limit_v;
                                    motor_limit_v.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        motor_limit_v.select(0,0);
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
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"최대 선 가속도 [m/s^2]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: motor_limit_v_acc
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("MOTOR","limit_v_acc");
                                onFocusChanged: {
                                    keypad.owner = motor_limit_v_acc;
                                    motor_limit_v_acc.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        motor_limit_v_acc.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limit_w
                    width: 840
                    height: 50
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"최대 각속도 [deg/s]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: motor_limit_w
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("MOTOR","limit_w");
                                onFocusChanged: {
                                    keypad.owner = motor_limit_w;
                                    motor_limit_w.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        motor_limit_w.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_limit_wacc
                    width: 840
                    height: 50
                    visible: is_admin
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"최대 각가속도 [deg/s^2]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
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
                                id: motor_limit_w_acc
                                anchors.fill: parent
                                property bool ischanged: false
                                onTextChanged: {
                                    is_reset_slam = true;
                                    ischanged = true;
                                }
                                focus:false
                                color:ischanged?color_red:"black"
                                text:supervisor.getSetting("MOTOR","limit_w_acc");
                                onFocusChanged: {
                                    keypad.owner = motor_limit_w_acc;
                                    motor_limit_w_acc.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        motor_limit_w_acc.select(0,0);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }


        Rectangle{
            id: area_setting_motor
            visible: select_category==="status" ? true : false
            width: 950
            color:"transparent"
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.top: parent.top
            anchors.topMargin: 80
            height: parent.height - 130
            Column{
                Rectangle{
                    width: area_setting_motor.width
                    height: area_setting_motor.height*0.55
                    color: "transparent"
                    Rectangle{
                        width: 200
                        height: 40
                        color: "black"
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_b.name
                            text:"로봇 상태"
                            color: "white"
                            font.pixelSize: 20
                        }
                    }
                    Row{
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 20
                        spacing: 80
                        Column{
                            spacing: 5
                            Rectangle{
                                width: 200
                                height: 40
                                radius: 10
                                color: "transparent"
                                border.width:1
                                border.color: color_dark_gray
                                Text{
                                    text: "전 원"
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    font.pixelSize: 25
                                }
                            }
                            Rectangle{
                                width: 200
                                height: 200
                                color: "transparent"

                                Column{
                                    anchors.centerIn: parent
//                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 10

                                    Column{
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 5
                                        Item_ProgressBar{
                                            id: bar_battery
                                            width: 200
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            height: 40
                                            to:100
                                            from:0
                                            value: supervisor.getBattery();
                                            Text{
                                                id: text_battery
                                                anchors.centerIn: parent
                                                font.family: font_noto_r.name
                                                font.pixelSize: 20
                                                text: parent.value + " %"
                                                color: "white"
                                            }
                                        }
                                        Grid{
                                            id: grid_power
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            rows: 5
                                            columns: 3
                                            horizontalItemAlignment: Grid.AlignHCenter
                                            verticalItemAlignment: Grid.AlignVCenter
                                            spacing: 5
                                            Text{
                                                text: "입력전원"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_battery_in
                                                width: 100
                                                height: 25
                                                to: 56
                                                from: 0
                                                value: 0
                                                Text{
                                                    id: text_battery_in
                                                    anchors.centerIn: parent
                                                    text: parent.value + " V"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15
                                                }
                                            }
                                            Text{
                                                text: "출력전원"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_battery_out
                                                width: 100
                                                height: 25
                                                to: 56
                                                from: 0
                                                value: 0
                                                Text{
                                                    id: text_battery_out
                                                    anchors.centerIn: parent
                                                    text: parent.value + " V"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15
                                                }
                                            }
                                            Text{
                                                text: "전   류"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_battery_cur
                                                width: 100
                                                height: 25
                                                to: 20
                                                from: 0
                                                value: 0
                                                Text{
                                                    id: text_battery_cur
                                                    anchors.centerIn: parent
                                                    text: parent.value + " A"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15
                                                }
                                            }
                                            Text{
                                                text: "순간전력"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_power
                                                width: 100
                                                height: 25
                                                to: 1
                                                from: 0
                                                value: 0
                                                Text{
                                                    id: text_power
                                                    anchors.centerIn: parent
                                                    text: parent.value + " W"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15
                                                }
                                            }
                                            Text{
                                                text: "누적전력"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_powert
                                                width: 100
                                                height: 25
                                                to: 1
                                                from: 0
                                                value: 0
                                                Text{
                                                    id: text_powert
                                                    anchors.centerIn: parent
                                                    text: parent.value + " Wh"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15
                                                }
                                            }
                                        }
                                    }
                                }

                            }
                        }

                        Column{
                            spacing: 5
                            Rectangle{
                                width: 200
                                height: 40
                                radius: 10
                                color: "transparent"
                                border.width:1
                                border.color: color_dark_gray
                                Text{
                                    text: "로봇 상태"
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    font.pixelSize: 25
                                }
                            }
                            Rectangle{
                                width: 200
                                height: 200
                                color: "transparent"

                                Grid{
                                    anchors.centerIn: parent
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    rows: 8
                                    columns: 3
                                    horizontalItemAlignment: Grid.AlignHCenter
                                    verticalItemAlignment: Grid.AlignVCenter
                                    spacing: 5
                                    Text{
                                        text: "위치초기화"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Text{
                                        text: ":"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Item_ProgressBar{
                                        id: bar_localization
                                        width: 100
                                        height: 25
                                        color: color_gray
                                        Text{
                                            id: text_local
                                            anchors.centerIn: parent
                                            text: "초기화 안됨"
                                            font.family: font_noto_r.name
                                            font.pixelSize: 15
                                        }
                                    }
                                    Text{
                                        text: "주행 상태"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Text{
                                        text: ":"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Item_ProgressBar{
                                        id: bar_moving
                                        width: 100
                                        height: 25
                                        color: color_gray
                                        Text{
                                            id: text_moving
                                            anchors.centerIn: parent
                                            text: "준비 안됨"
                                            font.family: font_noto_r.name
                                            font.pixelSize: 15
                                        }
                                    }
                                    Text{
                                        text: "장애물감지"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Text{
                                        text: ":"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Item_ProgressBar{
                                        id: bar_obs
                                        width: 100
                                        height: 25
                                        color: color_gray
                                        Text{
                                            id: text_obs
                                            anchors.centerIn: parent
                                            text: "없음"
                                            font.family: font_noto_r.name
                                            font.pixelSize: 15
                                        }
                                    }
                                    Text{
                                        text: "로봇 표정"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Text{
                                        text: ":"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Item_ProgressBar{
                                        id: bar_face
                                        width: 100
                                        height: 25
                                        color: color_gray
                                        Text{
                                            id: text_face
                                            anchors.centerIn: parent
                                            text: "보통"
                                            font.family: font_noto_r.name
                                            font.pixelSize: 15
                                        }
                                    }
                                }

                            }
                        }

                        Column{
                            spacing: 5
                            Rectangle{
                                width: 200
                                height: 40
                                radius: 10
                                color: "transparent"
                                border.width:1
                                border.color: color_dark_gray
                                Text{
                                    text: "상태 값"
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    font.pixelSize: 25
                                }
                            }
                            Rectangle{
                                width: 200
                                height: 200
                                color: "transparent"
                                Grid{
                                    anchors.centerIn: parent
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    rows: 8
                                    columns: 3
                                    horizontalItemAlignment: Grid.AlignHCenter
                                    verticalItemAlignment: Grid.AlignVCenter
                                    spacing: 5
                                    Text{
                                        text: "충전 상태"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Text{
                                        text: ":"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Item_ProgressBar{
                                        id: bar_charging
                                        width: 100
                                        height: 25
                                        Text{
                                            id: text_charging
                                            anchors.centerIn: parent
                                            text: "연결 안됨"
                                            font.family: font_noto_r.name
                                            font.pixelSize: 15
                                        }
                                    }
                                    Text{
                                        text: "전원 공급"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Text{
                                        text: ":"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Item_ProgressBar{
                                        id: bar_powerstate
                                        width: 100
                                        height: 25
                                        color: color_gray
                                        Text{
                                            id: text_powerstate
                                            anchors.centerIn: parent
                                            text: "공급 안됨"
                                            font.family: font_noto_r.name
                                            font.pixelSize: 15
                                        }
                                    }
                                    Text{
                                        text: "비상스위치"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Text{
                                        text: ":"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Item_ProgressBar{
                                        id: bar_emo
                                        width: 100
                                        height: 25
                                        color: color_gray
                                        Text{
                                            id: text_emo
                                            anchors.centerIn: parent
                                            text: "안 눌림"
                                            font.family: font_noto_r.name
                                            font.pixelSize: 15
                                        }
                                    }
                                    Text{
                                        text: "원격스위치"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Text{
                                        text: ":"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Item_ProgressBar{
                                        id: bar_remote
                                        width: 100
                                        height: 25
                                        color: color_gray
                                        Text{
                                            id: text_remote
                                            anchors.centerIn: parent
                                            text: "안 눌림"
                                            font.family: font_noto_r.name
                                            font.pixelSize: 15
                                        }
                                    }
                                    Text{
                                        text: "모터 락"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Text{
                                        text: ":"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Item_ProgressBar{
                                        id: bar_motorlock
                                        width: 100
                                        height: 25
                                        color: color_gray
                                        Text{
                                            id: text_motorlock
                                            anchors.centerIn: parent
                                            text: "풀림"
                                            font.family: font_noto_r.name
                                            font.pixelSize: 15
                                        }
                                    }
                                    Text{
                                        text: "그리기"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Text{
                                        text: ":"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                    Item_ProgressBar{
                                        id: bar_drawing
                                        width: 100
                                        height: 25
                                        color: color_gray
                                        Text{
                                            id: text_drawing
                                            anchors.centerIn: parent
                                            text: "멈춤"
                                            font.family: font_noto_r.name
                                            font.pixelSize: 15
                                        }
                                    }
                                }
                            }
                        }

                    }
                }
                Rectangle{
                    width: area_setting_motor.width
                    height: area_setting_motor.height*0.45
                    color: "transparent"
                    Row{
                        Rectangle{
                            color: "transparent"
                            width: area_setting_motor.width*0.6
                            height: area_setting_motor.height*0.45

                            Rectangle{
                                width: 200
                                height: 40
                                color: "black"
                                Text{
                                    anchors.centerIn: parent
                                    font.family: font_noto_b.name
                                    text:"모터 상태"
                                    color: "white"
                                    font.pixelSize: 20
                                }
                            }
                            Row{
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: 20
                                spacing: 60

                                Column{
                                    spacing: 5
                                    Rectangle{
                                        width: 200
                                        height: 40
                                        color: "transparent"
                                        border.width:1
                                        border.color: color_dark_gray
                                        radius: 10
                                        Text{
                                            text: "모터 1"
                                            anchors.centerIn: parent
                                            font.family: font_noto_r.name
                                            font.pixelSize: 25
                                        }
                                    }
                                    Rectangle{
                                        width: 200
                                        height: 170
                                        color: "transparent"

                                        Grid{
                                            anchors.centerIn: parent
                                            rows: 8
                                            columns: 3
                                            horizontalItemAlignment: Grid.AlignHCenter
                                            verticalItemAlignment: Grid.AlignVCenter
                                            spacing: 5
                                            Text{
                                                text: "연결상태"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_con1
                                                width: 100
                                                height: 25
                                                color: color_red
                                                Text{
                                                    id: text_con1
                                                    anchors.centerIn: parent
                                                    text: "연결 안됨"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15
                                                }
                                            }
                                            Text{
                                                text: "상 태"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_status1
                                                width: 100
                                                height: 25
                                                color: color_gray
                                                Text{
                                                    id: text_status1
                                                    anchors.centerIn: parent
                                                    text: "준비 안됨"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15
                                                }
                                            }
                                            Text{
                                                text: "제어기 온도"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_temp1
                                                width: 100
                                                height: 25
                                                from: 20
                                                to: 70
                                                warning: true
                                                value_margin: 60
                                                Text{
                                                    id: text_temp1
                                                    anchors.centerIn: parent
                                                    text: parent.value + " 도"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15

                                                }
                                            }
                                            Text{
                                                text: "모터 온도"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_mtemp1
                                                width: 100
                                                height: 25
                                                from: 20
                                                to: 70
                                                warning: true
                                                value_margin: 60
                                                Text{
                                                    id: text_mtemp1
                                                    anchors.centerIn: parent
                                                    text: parent.value + " 도"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15

                                                }
                                            }
                                            Text{
                                                text: "전  류"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_cur1
                                                width: 100
                                                height: 25
                                                warning: true
                                                from: 0
                                                to: 15
                                                value_margin: 6
                                                Text{
                                                    id: text_cur1
                                                    anchors.centerIn: parent
                                                    text: parent.value + " A"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15
                                                }
                                            }
                                        }
                                    }
                                }

                                Column{
                                    spacing: 5
                                    Rectangle{
                                        width: 200
                                        height: 40
                                        radius: 10
                                        color: "transparent"
                                        border.width:1
                                        border.color: color_dark_gray
                                        Text{
                                            text: "모터 2"
                                            anchors.centerIn: parent
                                            font.family: font_noto_r.name
                                            font.pixelSize: 25
                                        }
                                    }
                                    Rectangle{
                                        width: 200
                                        height: 170
                                        color: "transparent"

                                        Grid{
                                            anchors.centerIn: parent
                                            rows: 8
                                            columns: 3
                                            horizontalItemAlignment: Grid.AlignHCenter
                                            verticalItemAlignment: Grid.AlignVCenter
                                            spacing: 5
                                            Text{
                                                text: "연결상태"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_con2
                                                width: 100
                                                height: 25
                                                color: color_red
                                                Text{
                                                    id: text_con2
                                                    anchors.centerIn: parent
                                                    text: "연결 안됨"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15
                                                }
                                            }
                                            Text{
                                                text: "상 태"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_status2
                                                width: 100
                                                height: 25
                                                color: color_gray
                                                Text{
                                                    id: text_status2
                                                    anchors.centerIn: parent
                                                    text: "준비 안됨"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15
                                                }
                                            }
                                            Text{
                                                text: "제어기 온도"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_temp2
                                                width: 100
                                                height: 25
                                                from: 20
                                                to: 70
                                                warning: true
                                                value_margin: 60
                                                Text{
                                                    id: text_temp2
                                                    anchors.centerIn: parent
                                                    text: parent.value + " 도"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15
                                                }
                                            }
                                            Text{
                                                text: "모터 온도"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_mtemp2
                                                width: 100
                                                height: 25
                                                from: 20
                                                to: 70
                                                warning: true
                                                value_margin: 60
                                                Text{
                                                    id: text_mtemp2
                                                    anchors.centerIn: parent
                                                    text: parent.value + " 도"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15
                                                }
                                            }
                                            Text{
                                                text: "전  류"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Text{
                                                text: ":"
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                            Item_ProgressBar{
                                                id: bar_cur2
                                                width: 100
                                                height: 25
                                                warning: true
                                                from: 0
                                                to: 15
                                                value_margin: 6
                                                Text{
                                                    id: text_cur2
                                                    anchors.centerIn: parent
                                                    text: parent.value + " A"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 15
                                                }
                                            }
                                        }
                                    }
                                }

                            }

                        }
                        Rectangle{
                            color: "transparent"
                            width: area_setting_motor.width*0.4
                            height: area_setting_motor.height*0.45
                            Rectangle{
                                width: 200
                                height: 40
                                color: "black"
                                Text{
                                    anchors.centerIn: parent
                                    font.family: font_noto_b.name
                                    text:"센서 상태"
                                    color: "white"
                                    font.pixelSize: 20
                                }
                            }
                            Item_buttons{
                                type: "round_text"
                                text:"뷰 어"
                                fontsize: 30
                                anchors.centerIn: parent
                                width: 150
                                height: 80
                                onClicked:{
                                    popup_sensorview.open();
                                }
                            }
                        }
                    }
                }
            }

            Column{
                id:column_setting4
                width: parent.width
                visible: false
//                anchors.top: rect_motor_2.bottom
                anchors.topMargin: 2
                spacing:10
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
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"모터 연결상태"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
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
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"모터 상태"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
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
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"모터 온도"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
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
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"모터 내부 온도"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
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
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"모터 전류"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
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
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                font.family: font_noto_r.name
                                text:"상태값"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
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
                    click_sound.play();
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

        if(combo_max_calling.ischanged){
            supervisor.setSetting("ROBOT_SW/call_maximum",combo_max_calling.currentText);
        }

        if(combo_multirobot.ischanged){
            if(combo_multirobot.currentIndex == 0){
                supervisor.setSetting("ROBOT_SW/use_multirobot","false");
            }else{
                supervisor.setSetting("ROBOT_SW/use_multirobot","true");
            }
        }

        if(combo_platform_type.ischanged){
            if(combo_platform_type.currentIndex == 0){
                supervisor.setSetting("ROBOT_HW/type","SERVING");
            }else if(combo_platform_type.currentIndex == 1){
                supervisor.setSetting("ROBOT_HW/type","CALLING");
            }else if(combo_platform_type.currentIndex == 2){
                supervisor.setSetting("ROBOT_HW/type","BOTH");
            }
        }

        if(combo_tray_num.ischanged){
            supervisor.setSetting("ROBOT_HW/tray_num",combo_tray_num.currentText);
        }

        if(slider_volume_bgm.ischanged){
            supervisor.setSetting("ROBOT_SW/volume_bgm",slider_volume_bgm.value.toFixed(0));
            volume_bgm = slider_volume_bgm.value.toFixed(0);
        }

        if(slider_volume_voice.ischanged){
            supervisor.setSetting("ROBOT_SW/volume_voice",slider_volume_voice.value.toFixed(0));
            volume_voice = slider_volume_voice.value.toFixed(0);
        }

        if(slider_volume_button.ischanged){
            supervisor.setSetting("ROBOT_SW/volume_button",slider_volume_button.value.toFixed(0));
            volume_button = slider_volume_button.value.toFixed(0);
        }
        if(combo_movingpage.ischanged){
            if(combo_movingpage.currentIndex == 0)
                supervisor.setSetting("ROBOT_SW/moving_face","false");
            else
                supervisor.setSetting("ROBOT_SW/moving_face","true");
        }

        if(combo_comeback_preset.ischanged){
            supervisor.setSetting("ROBOT_SW/comeback_preset",combo_comeback_preset.currentIndex.toString());
        }

        if(combo_use_tray.ischanged){
            if(combo_use_tray.currentIndex == 0)
                supervisor.setSetting("ROBOT_SW/use_tray","false");
            else
                supervisor.setSetting("ROBOT_SW/use_tray","true");
        }

        if(combo_resting_lock.ischanged){
            if(combo_resting_lock.currentIndex == 0){
                supervisor.setSetting("ROBOT_SW/resting_lock","false");
            }else{
                supervisor.setSetting("ROBOT_SW/resting_lock","true");
            }
        }

        if(wifi_passwd.ischanged){
            supervisor.setSetting("ROBOT_SW/wifi_passwd",wifi_passwd.text);
        }

        if(fms_id.ischanged){
            supervisor.setSetting("SERVER/fms_id",fms_id.text);
        }
        if(fms_pw.ischanged){
            supervisor.setSetting("SERVER/fms_pw",fms_pw.text);
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

        if(obs_height_min.ischanged){
            supervisor.setSetting("ROBOT_SW/obs_height_min",obs_height_min.text);
        }

        if(obs_height_max.ischanged){
            supervisor.setSetting("ROBOT_SW/obs_height_max",obs_height_max.text);
        }

        if(obs_margin1.ischanged){
            supervisor.setSetting("ROBOT_SW/obs_margin1",obs_margin1.text);
        }

        if(obs_detect_area.ischanged){
            supervisor.setSetting("ROBOT_SW/obs_detect_area",obs_detect_area.text);
        }
        if(obs_detect_sensitivity.ischanged){
            supervisor.setSetting("ROBOT_SW/obs_detect_sensitivity",obs_detect_sensitivity.text);
        }

        if(max_range.ischanged){
            supervisor.setSetting("SENSOR/max_range",max_range.text);
        }

        if(cam_exposure.ischanged){
            supervisor.setSetting("SENSOR/cam_exposure",cam_exposure.text);
        }

        if(offset_x.ischanged){
            supervisor.setSetting("SENSOR/offset_x",offset_x.text);
        }

        if(offset_y.ischanged){
            supervisor.setSetting("SENSOR/offset_y",offset_y.text);
        }

        if(limit_pivot.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_pivot"            ,limit_pivot.text);
        }

        if(limit_pivot_acc.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_pivot_acc"        ,limit_pivot_acc.text);
        }

        if(limit_v.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_v"                ,limit_v.text);
        }

        if(limit_v_acc.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_v_acc"            ,limit_v_acc.text);
        }

        if(limit_w.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_w"                ,limit_w.text);
        }

        if(limit_w_acc.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_w_acc"            ,limit_w_acc.text);
        }

        if(limit_manual_v.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_manual_v"          ,limit_manual_v.text);
        }

        if(limit_manual_w.ischanged){
            supervisor.setSetting("ROBOT_SW/limit_manual_w"          ,limit_manual_w.text);
        }

        if(st_v.ischanged){
            supervisor.setSetting("ROBOT_SW/st_v"                   ,st_v.text);
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

        if(combo_camera_model.ischanged){
            supervisor.setSetting("SENSOR/camera_model",Number(combo_camera_model.currentIndex));
        }

        if(combo_use_motorcurrent.ischanged){
            if(combo_use_motorcurrent.currentIndex == 0){
                supervisor.setSetitng("ROBOT_SW/use_pause_current","false");
            }else{
                supervisor.setSetitng("ROBOT_SW/use_pause_current","true");
            }
        }

        if(pause_check_ms.ischanged){
            supervisor.setSetting("MOTOR/pause_check_ms",pause_check_ms.text);
        }
        if(pause_motor_current.ischanged){
            supervisor.setSetting("MOTOR/pause_motor_current",pause_motor_current.text);
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

        if(motor_limit_v.ischanged){
            supervisor.setSetting("MOTOR/limit_v",motor_limit_v.text);
        }

        if(motor_limit_v_acc.ischanged){
            supervisor.setSetting("MOTOR/limit_v_acc",motor_limit_v_acc.text);
        }

        if(motor_limit_w.ischanged){
            supervisor.setSetting("MOTOR/limit_w",motor_limit_w.text);
        }

        if(motor_limit_w_acc.ischanged){
            supervisor.setSetting("MOTOR/limit_w_acc",motor_limit_w_acc.text);
        }

        if(look_ahead_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/look_ahead_dist"         ,look_ahead_dist.text);
        }

        if(min_look_ahead_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/min_look_ahead_dist"    ,min_look_ahead_dist.text);
        }

        if(obs_deadzone.ischanged){
            supervisor.setSetting("ROBOT_SW/obs_deadzone"           ,obs_deadzone.text);
        }

        if(obs_wait_time.ischanged){
            supervisor.setSetting("ROBOT_SW/obs_wait_time"          ,obs_wait_time.text);
        }

        if(path_out_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/path_out_dist"          ,path_out_dist.text);
        }

        if(icp_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/icp_dist"               ,icp_dist.text);
        }

        if(icp_error.ischanged){
            supervisor.setSetting("ROBOT_SW/icp_error"              ,icp_error.text);
        }

        if(icp_near.ischanged){
            supervisor.setSetting("ROBOT_SW/icp_near"               ,icp_near.text);
        }

        if(icp_odometry_weight.ischanged){
            supervisor.setSetting("ROBOT_SW/icp_odometry_weight"    ,icp_odometry_weight.text);
        }

        if(icp_ratio.ischanged){
            supervisor.setSetting("ROBOT_SW/icp_ratio"              ,icp_ratio.text);
        }

        if(icp_repeat_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/icp_repeat_dist"        ,icp_repeat_dist.text);
        }

        if(icp_repeat_time.ischanged){
            supervisor.setSetting("ROBOT_SW/icp_repeat_time"        ,icp_repeat_time.text);

        }

        if(goal_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/goal_dist"              ,goal_dist.text);
        }

        if(goal_v.ischanged){
            supervisor.setSetting("ROBOT_SW/goal_v"                 ,goal_v.text);
        }

        if(goal_th.ischanged){
            supervisor.setSetting("ROBOT_SW/goal_th"                ,goal_th.text);
        }

        if(goal_near_dist.ischanged){
            supervisor.setSetting("ROBOT_SW/goal_near_dist"         ,goal_near_dist.text);
        }

        if(is_reset_slam)
            supervisor.slam_ini_reload();
//            supervisor.restartSLAM();

        init();

    }

    function init(){
        supervisor.writelog("[QML] SETTING PAGE init");

        platform_name.text = supervisor.getSetting("ROBOT_HW","model");
        combo_platform_serial.currentIndex = parseInt(supervisor.getSetting("ROBOT_HW","serial_num"))
        combo_platform_id.currentIndex = parseInt(supervisor.getSetting("ROBOT_SW","robot_id"))
        radius.text = supervisor.getSetting("ROBOT_HW","radius");

        combo_tray_num.currentIndex = supervisor.getSetting("ROBOT_HW","tray_num")-1;

        if(supervisor.getSetting("ROBOT_SW","use_multirobot")==="true"){
            combo_multirobot.currentIndex = 1;
        }else{
            combo_multirobot.currentIndex = 0;
        }




        if(supervisor.getSetting("ROBOT_HW","type") === "SERVING"){
            combo_platform_type.currentIndex = 0;
        }else if(supervisor.getSetting("ROBOT_HW","type") === "CALLING"){
            combo_platform_type.currentIndex = 1;
        }else{
            combo_platform_type.currentIndex = 2;
        }


        fms_id.text = supervisor.getSetting("SERVER","fms_id");
        fms_pw.text = supervisor.getSetting("SERVER","fms_pw");
        combo_max_calling.currentIndex = parseInt(supervisor.getSetting("ROBOT_SW","call_maximum")) - 1;
        wheel_base.text = supervisor.getSetting("ROBOT_HW","wheel_base");
        wheel_radius.text = supervisor.getSetting("ROBOT_HW","wheel_radius");

        left_camera_tf.text = supervisor.getSetting("SENSOR","left_camera_tf");
        right_camera_tf.text = supervisor.getSetting("SENSOR","right_camera_tf");
        cam_exposure.text = supervisor.getSetting("SENSOR","cam_exposure");

        icp_dist.text = supervisor.getSetting("ROBOT_SW","icp_dist");
        icp_error.text = supervisor.getSetting("ROBOT_SW","icp_error");
        icp_near.text = supervisor.getSetting("ROBOT_SW","icp_near");
        icp_odometry_weight.text = supervisor.getSetting("ROBOT_SW","icp_odometry_weight");
        icp_ratio.text = supervisor.getSetting("ROBOT_SW","icp_ratio");
        icp_repeat_dist.text = supervisor.getSetting("ROBOT_SW","icp_repeat_dist");
        icp_repeat_time.text = supervisor.getSetting("ROBOT_SW","icp_repeat_time");
        obs_deadzone.text = supervisor.getSetting("ROBOT_SW","obs_deadzone");
        obs_wait_time.text = supervisor.getSetting("ROBOT_SW","obs_wait_time");
        path_out_dist.text = supervisor.getSetting("ROBOT_SW","path_out_dist");
        st_v.text = supervisor.getSetting("ROBOT_SW","st_v");
        min_look_ahead_dist.text = supervisor.getSetting("ROBOT_SW","min_look_ahead_dist");
        goal_dist.text = supervisor.getSetting("ROBOT_SW","goal_dist");
        goal_th.text = supervisor.getSetting("ROBOT_SW","goal_th");
        goal_v.text = supervisor.getSetting("ROBOT_SW","goal_v");
        goal_near_dist.text = supervisor.getSetting("ROBOT_SW","goal_near_dist");

        motor_limit_v.text = supervisor.getSetting("MOTOR","limit_v");
        motor_limit_v_acc.text = supervisor.getSetting("MOTOR","limit_v_acc");
        motor_limit_w.text = supervisor.getSetting("MOTOR","limit_w");
        motor_limit_w_acc.text = supervisor.getSetting("MOTOR","limit_w_acc");
        limit_pivot.text = supervisor.getSetting("ROBOT_SW","limit_pivot");
        limit_pivot_acc.text = supervisor.getSetting("ROBOT_SW","limit_pivot_acc");
        limit_manual_v.text = supervisor.getSetting("ROBOT_SW","limit_manual_v");
        limit_manual_w.text = supervisor.getSetting("ROBOT_SW","limit_manual_w");
        limit_v.text = supervisor.getSetting("ROBOT_SW","limit_v");
        limit_w.text = supervisor.getSetting("ROBOT_SW","limit_w");
        limit_v_acc.text = supervisor.getSetting("ROBOT_SW","limit_v_acc");
        limit_w_acc.text = supervisor.getSetting("ROBOT_SW","limit_w_acc");
        look_ahead_dist.text = supervisor.getSetting("ROBOT_SW","look_ahead_dist");

        slider_volume_bgm.value = Number(supervisor.getSetting("ROBOT_SW","volume_bgm"));
        slider_volume_voice.value = Number(supervisor.getSetting("ROBOT_SW","volume_voice"));
        slider_volume_button.value = Number(supervisor.getSetting("ROBOT_SW","volume_button"));

        text_preset_name_1.text = supervisor.getSetting("PRESET1","name");
        text_preset_name_2.text = supervisor.getSetting("PRESET2","name");
        text_preset_name_3.text = supervisor.getSetting("PRESET3","name");
        text_preset_name_4.text = supervisor.getSetting("PRESET4","name");
        text_preset_name_5.text = supervisor.getSetting("PRESET5","name");

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

        pause_motor_current.text = supervisor.getSetting("MOTOR","pause_motor_current");
        pause_check_ms.text = supervisor.getSetting("MOTOR","pause_check_ms");
        if(supervisor.getSetting("ROBOT_SW","use_pause_current") === "false"){
            combo_use_motorcurrent.currentIndex = 0;
        }else{
            combo_use_motorcurrent.currentIndex = 1;
        }

        if(supervisor.getSetting("SENSOR","camera_model") === "0"){
            combo_camera_model.currentIndex = 0;
        }else{
            combo_camera_model.currentIndex = 1;
        }

        if(supervisor.getSetting("ROBOT_SW","moving_face") === "true"){
            combo_movingpage.currentIndex = 1;
        }else{
            combo_movingpage.currentIndex = 0;
        }

        combo_comeback_preset.currentIndex = parseInt(supervisor.getSetting("ROBOT_SW","comeback_preset"));

        if(supervisor.getSetting("ROBOT_SW","use_tray") === "true"){
            combo_use_tray.currentIndex = 1;
        }else{
            combo_use_tray.currentIndex = 0;
        }

        if(supervisor.getSetting("ROBOT_SW","resting_lock") === "true"){
            combo_resting_lock.currentIndex = 1;
        }else{
            combo_resting_lock.currentIndex = 0;
        }
        obs_margin1.text = supervisor.getSetting("ROBOT_SW","obs_margin1");
        obs_detect_area.text = supervisor.getSetting("ROBOT_SW","obs_detect_area");
        obs_detect_sensitivity.text = supervisor.getSetting("ROBOT_SW","obs_detect_sensitivity");
        obs_height_min.text = supervisor.getSetting("ROBOT_SW","obs_height_min");
        max_range.text = supervisor.getSetting("SENSOR","max_range");
        offset_x.text = supervisor.getSetting("SENSOR","offset_x");
        offset_y.text = supervisor.getSetting("SENSOR","offset_y");
        right_camera.text = supervisor.getSetting("SENSOR","right_camera");
        left_camera.text = supervisor.getSetting("SENSOR","left_camera");

//        var ip = supervisor.getSetting("ROBOT_SW","wifi_ip").split(".");
        var ip = supervisor.getcurIP().split(".");
        if(ip.length >3){
            ip_1.text = ip[0];
            ip_2.text = ip[1];
            ip_3.text = ip[2];
            ip_4.text = ip[3];
        }

        ip = supervisor.getSetting("SERVER","fms_ip").split(".");
        if(ip.length >3){
            server_ip_1.text = ip[0];
            server_ip_2.text = ip[1];
            server_ip_3.text = ip[2];
            server_ip_4.text = ip[3];
        }
        ip = supervisor.getSetting("ROBOT_SW","wifi_gateway").split(".");
        ip = supervisor.getcurGateway().split(".");
        if(ip.length >3){
            gateway_1.text = ip[0];
            gateway_2.text = ip[1];
            gateway_3.text = ip[2];
            gateway_4.text = ip[3];
        }
        ip = supervisor.getSetting("ROBOT_SW","wifi_dnsmain").split(".");
        ip = supervisor.getcurDNS().split(".");
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

//        slider_vxy.ischanged = false;
        slider_volume_bgm.ischanged = false;
        slider_volume_voice.ischanged = false;
        slider_volume_button.ischanged = false;

        combo_movingpage.ischanged = false;
        combo_comeback_preset.ischanged = false;
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

        combo_multirobot.ischanged = false;
        server_ip_1.ischanged = false;
        server_ip_2.ischanged = false;
        server_ip_3.ischanged = false;
        server_ip_4.ischanged = false;
        fms_id.ischanged = false;
        fms_pw.ischanged = false;

        wheel_base.ischanged = false;
        wheel_radius.ischanged = false;
        radius.ischanged = false;


        max_range.ischanged = false;
        cam_exposure.ischanged = false;
        offset_x.ischanged = false;
        offset_y.ischanged = false;

        limit_pivot.ischanged = false;
        limit_pivot_acc.ischanged = false;
        limit_v.ischanged = false;
        limit_v_acc.ischanged = false;
        limit_w.ischanged = false;
        limit_w_acc.ischanged = false;
        limit_manual_v.ischanged = false;
        limit_manual_w.ischanged = false;
        st_v.ischanged = false;

        combo_wheel_dir.ischanged = false;
        combo_left_id.ischanged = false;
        combo_right_id.ischanged = false;
        gear_ratio.ischanged = false;
        k_p.ischanged = false;
        k_i.ischanged = false;
        k_d.ischanged = false;
        combo_use_motorcurrent.ischanged = false;
        combo_camera_model.ischanged = false;
        motor_limit_v.ischanged = false;
        motor_limit_v_acc.ischanged = false;
        motor_limit_w.ischanged = false;
        motor_limit_w_acc.ischanged = false;
        look_ahead_dist.ischanged = false;
        min_look_ahead_dist.ischanged = false;
        obs_deadzone.ischanged = false;
        obs_wait_time.ischanged = false;
        path_out_dist.ischanged = false;
        icp_dist.ischanged = false;
        icp_error.ischanged = false;
        icp_near.ischanged = false;
        icp_odometry_weight.ischanged = false;
        icp_ratio.ischanged = false;
        icp_repeat_dist.ischanged = false;
        icp_repeat_time.ischanged = false;
        goal_dist.ischanged = false;
        goal_v.ischanged = false;
        goal_th.ischanged = false;
        pause_motor_current.ischanged = false;
        pause_check_ms.ischanged = false;
        goal_near_dist.ischanged = false;
    }

    function check_update(){
        var is_changed = false;

        if(platform_name.ischanged) is_changed = true;
        if(combo_platform_serial.ischanged) is_changed = true;
        if(combo_platform_id.ischanged) is_changed = true;
        if(combo_platform_type.ischanged) is_changed = true;
        if(combo_tray_num.ischanged) is_changed = true;
//        if(slider_vxy.ischanged) is_changed = true;
        if(slider_volume_bgm.ischanged) is_changed = true;
        if(slider_volume_voice.ischanged) is_changed = true;
        if(slider_volume_button.ischanged) is_changed = true;
        if(wifi_passwd.ischanged) is_changed = true;
        if(ip_1.ischanged) is_changed = true;
        if(ip_2.ischanged) is_changed = true;
        if(ip_3.ischanged) is_changed = true;
        if(ip_4.ischanged) is_changed = true;
        if(combo_use_motorcurrent.ischanged) is_changed = true;
        if(pause_motor_current.ischanged) is_changed = true;
        if(pause_check_ms.ischanged) is_changed = true;
        if(combo_camera_model.ischanged) is_changed = true;
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
        if(max_range.ischanged) is_changed = true;
        if(cam_exposure.ischanged) is_changed = true;
        if(offset_x.ischanged) is_changed = true;
        if(offset_y.ischanged) is_changed = true;
        if(limit_pivot.ischanged) is_changed = true;
        if(limit_pivot_acc.ischanged) is_changed = true;
        if(limit_v.ischanged) is_changed = true;
        if(limit_v_acc.ischanged) is_changed = true;
        if(limit_w.ischanged) is_changed = true;
        if(limit_w_acc.ischanged) is_changed = true;
        if(limit_manual_v.ischanged) is_changed = true;
        if(limit_manual_w.ischanged) is_changed = true;
        if(st_v.ischanged) is_changed = true;
        if(combo_wheel_dir.ischanged) is_changed = true;
        if(combo_left_id.ischanged) is_changed = true;
        if(combo_right_id.ischanged) is_changed = true;
        if(gear_ratio.ischanged) is_changed = true;
        if(k_p.ischanged) is_changed = true;
        if(k_i.ischanged) is_changed = true;
        if(k_d.ischanged) is_changed = true;
        if(motor_limit_v.ischanged) is_changed = true;
        if(motor_limit_v_acc.ischanged) is_changed = true;
        if(motor_limit_w.ischanged) is_changed = true;
        if(motor_limit_w_acc.ischanged) is_changed = true;
        if(look_ahead_dist.ischanged) is_changed = true;
        if(min_look_ahead_dist.ischanged) is_changed = true;
        if(obs_deadzone.ischanged) is_changed = true;
        if(obs_wait_time.ischanged) is_changed = true;
        if(path_out_dist.ischanged) is_changed = true;
        if(icp_dist.ischanged) is_changed = true;
        if(icp_error.ischanged) is_changed = true;
        if(icp_near.ischanged) is_changed = true;
        if(icp_odometry_weight.ischanged) is_changed = true;
        if(icp_ratio.ischanged) is_changed = true;
        if(icp_repeat_dist.ischanged) is_changed = true;
        if(icp_repeat_time.ischanged) is_changed = true;
        if(goal_dist.ischanged) is_changed = true;
        if(goal_v.ischanged) is_changed = true;
        if(goal_th.ischanged) is_changed = true;
        if(goal_near_dist.ischanged) is_changed = true;

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

            wifi_connection.connection = supervisor.getWifiConnection("");

            motor_left_id = parseInt(supervisor.getSetting("MOTOR","left_id"));
            motor_right_id = parseInt(supervisor.getSetting("MOTOR","right_id"));

            //로봇 상태 - 전원
            bar_battery.value = supervisor.getBattery();
            bar_battery_in.value = supervisor.getBatteryIn().toFixed(2);
            bar_battery_out.value = supervisor.getBatteryOut().toFixed(2);
            bar_battery_cur.value = supervisor.getBatteryCurrent().toFixed(2);

            bar_power.value = supervisor.getPower().toFixed(3);
            bar_powert.value = supervisor.getPowerTotal().toFixed(3);


            //로봇 상태 - 상태 값
            if(supervisor.getChargeStatus() === 0){
                bar_charging.background_color = color_gray;
                text_charging.text = "연결 안됨";
            }else{
                bar_charging.background_color = color_blue;
                text_charging.text = "연결 됨";
            }
            if(supervisor.getPowerStatus() === 0){
                bar_powerstate.background_color = color_red;
                text_powerstate.text = "공급 안됨";
            }else{
                bar_powerstate.background_color = color_blue;
                text_powerstate.text = "공급 됨";
            }
            if(supervisor.getEmoStatus() === 0){
                bar_emo.background_color = color_gray;
                text_emo.text = "안 눌림"
            }else{
                bar_emo.background_color = color_red;
                text_emo.text = "눌림"
            }
            if(supervisor.getRemoteStatus() === 0){
                bar_remote.background_color = color_red;
                text_remote.text = "눌림";
            }else{
                bar_remote.background_color = color_gray;
                text_remote.text = "안 눌림";
            }

            //로봇 상태 - 로봇 상태
            var state = supervisor.getLocalizationState();
            if(state === 0){
                bar_localization.background_color = color_red;
                text_local.text = "초기화 안됨";
            }else if(state === 1){
                bar_localization.background_color = color_yellow;
                text_local.text = "초기화 중";
            }else if(state === 2){
                bar_localization.background_color = color_blue;
                text_local.text = "초기화 완료";
            }else if(state === 3){
                bar_localization.background_color = color_red;
                text_local.text = "초기화 실패";
            }

            state = supervisor.getStateMoving();
            if(state === 0){
                bar_moving.background_color = color_red;
                text_moving.text = "준비 안됨";
            }else if(state === 1){
                bar_moving.background_color = color_blue;
                text_moving.text = "준비";
            }else if(state === 2){
                bar_moving.background_color = color_green;
                text_moving.text = "이동 중";
            }else if(state === 3){
                bar_moving.background_color = color_yellow;
                text_moving.text = "대기 중";
            }else if(state === 4){
                bar_moving.background_color = color_yellow;
                text_moving.text = "일시정지 중";
            }
            state = supervisor.getObsState();
            if(state === 0){
                bar_obs.background_color = color_gray;
                text_obs.text = "없음"
            }else if(state === 1){
                bar_obs.background_color = color_red;
                text_obs.text = "장애물 겹침"
            }
            state = supervisor.getObsinPath();
            if(state === 0){
                text_face.text = "보통"
            }else if(state === 1){
                text_face.text = "놀람"
            }else if(state === 2){
                text_face.text = "운다"
            }
            state = supervisor.getLockStatus();
            if(state === 0){
                text_motorlock.text = "풀림"
                bar_motorlock.background_color  = color_red;
            }else{
                text_motorlock.text = "락 걸림"
                bar_motorlock.background_color = color_blue;
            }

            //모터 상태 - 모터 1
            state = supervisor.getMotorConnection(0);
            if(state === 0){
                bar_con1.background_color = color_gray;
                text_con1.text = "연결 안됨"
            }else{
                bar_con1.background_color = color_blue;
                text_con1.text = "연결 됨"
            }

            state = supervisor.getMotorStatus(0);
            if(state === 0){
                bar_status1.background_color = color_gray;
                text_status1.text = "준비 안됨"
            }else if(state === 1){
                bar_status1.background_color = color_blue;
                text_status1.text = "준비"
            }else{
                var str_error = "";
                if(state >= 128){
                    str_error += "Unknown ";
                    state -= 128;
                }
                if(state >= 64){
                    str_error += "PS1,2 ";
                    state -= 64;
                }
                if(state >= 32){
                    str_error += "INPUT ";
                    state -= 32;
                }
                if(state >= 16){
                    str_error += "BIG ";
                    state -= 16;
                }
                if(state >= 8){
                    str_error += "CUR ";
                    state -= 8;
                }
                if(state >= 4){
                    str_error += "JAM ";
                    state -= 4;
                }
                if(state >= 2){
                    str_error += "MOD ";
                    state -= 2;
                }

                bar_status1.background_color = color_red;
                text_status1.text = str_error;
            }

            bar_temp1.value = supervisor.getMotorTemperature(0);
            bar_mtemp1.value = supervisor.getMotorInsideTemperature(0);
            bar_cur1.value = supervisor.getMotorCurrent(0);


            //모터 상태 - 모터 2
            state = supervisor.getMotorConnection(1);
            if(state === 0){
                bar_con2.background_color = color_gray;
                text_con2.text = "연결 안됨"
            }else{
                bar_con2.background_color = color_blue;
                text_con2.text = "연결 됨"
            }

            state = supervisor.getMotorStatus(1);
            if(state === 0){
                bar_status2.background_color = color_gray;
                text_status2.text = "준비 안됨"
            }else if(state === 1){
                bar_status2.background_color = color_blue;
                text_status2.text = "준비"
            }else{
                var str_error = "";
                if(state >= 128){
                    str_error += "Unknown ";
                    state -= 128;
                }
                if(state >= 64){
                    str_error += "PS1,2 ";
                    state -= 64;
                }
                if(state >= 32){
                    str_error += "INPUT ";
                    state -= 32;
                }
                if(state >= 16){
                    str_error += "BIG ";
                    state -= 16;
                }
                if(state >= 8){
                    str_error += "CUR ";
                    state -= 8;
                }
                if(state >= 4){
                    str_error += "JAM ";
                    state -= 4;
                }
                if(state >= 2){
                    str_error += "MOD ";
                    state -= 2;
                }

                bar_status2.background_color = color_red;
                text_status2.text = str_error;
            }

            bar_temp2.value = supervisor.getMotorTemperature(1);
            bar_mtemp2.value = supervisor.getMotorInsideTemperature(1);
            bar_cur2.value = supervisor.getMotorCurrent(1);
        }
    }

    Popup_help{
        id: popup_help_setting
    }

    Popup{
        id: popup_sensorview
        anchors.centerIn: parent
        width: 850
        height: 650
        background:Rectangle{
            anchors.fill: parent
            color: "transparent"
        }
        Rectangle{
            width: parent.width
            height: parent.height
            radius: 10
            color: color_dark_navy
        }
    }

    Popup{
        id: popup_manager
        width: 500
        height: 500
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
            radius: 20
            clip: true
            anchors.centerIn: parent
            width: parent.width*0.99
            height: parent.height*0.99
            border.width: 3
            border.color: color_dark_navy
            Rectangle{
                radius: 20
                id: rect_prd_top
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
                    text: "관리자 메뉴"
                }
            }
            Grid{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 40
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
                        text: "프로그램 업데이트"
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
//                            supervisor.restartSLAM();
                        }
                    }
                }
            }
        }
    }
    Popup{
        id: popup_usb_notice
        anchors.centerIn: parent
        width: 500
        height: 500
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
                text_usb_state.color = "white"

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
                    text_usb_state.color = color_red;
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
            radius: 20
            color: color_dark_navy
            Column{
                anchors.centerIn: parent
                spacing: 10
                Text{
                    id: text_usb_state
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: font_noto_r.name
                    color: "white"
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    text:"잠시만 기다려주세요."
                }
                Repeater{
                    model: ListModel{id:model_usb_error}
                    Rectangle{
                        width: 400
                        height: 30
                        color: color_navy
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            font.pixelSize: 12
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            text:error
                        }
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
                    height: 50
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
                    height: 50
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
                    height: 50
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
        width: 500
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
            anchors.fill: parent
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
                }else if(popup_usb_select.index === 0){
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
            radius: 20
            clip: true
            anchors.centerIn: parent
            width: parent.width*0.99
            height: parent.height*0.99
            border.width: 3
            border.color: color_dark_navy
            Rectangle{
                radius: 20
                id: rect_ttt
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
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                    color: "white"
                    text: {
                        if(popup_usb_select.index === 0)
                            "저장소를 선택해주세요."
                        else if(popup_usb_select.index === 1)
                            "저장할 목록을 선택해주세요."
                    }
                }
            }
            Rectangle{
                width: parent.width
                color: "transparent"
                height: parent.height - rect_ttt.height
                anchors.top: rect_ttt.bottom
                Text{
                    id: text_no_usb
                    visible: false
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                    horizontalAlignment: Text.AlignHCenter
                    color: color_red
                    text: "** USB를 인식할 수 없습니다. **\nUSB를 뺏다 꼽아주시면 인식될 수 있습니다."
                }
                Column{
                    anchors.centerIn: parent
                    spacing: 30
                    Column{
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: popup_usb_select.index === 0
                        spacing: 10

                        Rectangle{
                            width: 400
                            height: 40
                            color: "black"
                            Text{
                                color: "white"
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                font.pixelSize: 15
                                text: "저장소 목록"
                            }
                        }
                        Repeater{
                            anchors.horizontalCenter: parent.horizontalCenter
                            model: ListModel{id:model_usb_list}
                            Rectangle{
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: 300
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
                                        text_no_usb.visible = false;
                                        popup_usb_select.index = 1;
                                        popup_usb_select.set_name = name;
                                    }
                                }
                            }
                        }
                    }
                    Column{
                        anchors.horizontalCenter: parent.horizontalCenter
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
                                text: "UI 실행파일"
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
                                text: "슬램 네비게이션 실행파일"
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
                                text: "설정파일"
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
                                text: "맵 폴더"
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
                                text: "로그"
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
                        anchors.horizontalCenter: parent.horizontalCenter
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
        width: 1280
        height: 400
        anchors.centerIn: parent
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }

        onOpened: {
            //버전 체크
            supervisor.checkUpdate();
            if(supervisor.getSetting("ROBOT_SW","update_auto")==="true"){
                if(supervisor.isNewVersion()){
                    supervisor.writelog("[USER INPUT] UPDATE PROGRAM -> ALREADY NEW VERSION")
                    //버전이 이미 최신임
                    rect_lastest.visible = true;
                    rect_need_update.visible = false;
                    text_version.text = "현재 버전 : " + supervisor.getLocalVersionDate()
                }else{
                    supervisor.writelog("[USER INPUT] UPDATE PROGRAM -> CHECK NEW VERSION")
                    //새로운 버전 확인됨
                    rect_lastest.visible = false;
                    rect_need_update.visible = true;
                    text_version1.text = "현재 버전 : " + supervisor.getLocalVersionDate()
                    text_version2.text = "최신 버전 : " + supervisor.getServerVersionDate()
                }
            }else{
                if(supervisor.checkNewUpdateProgram()){
                    supervisor.writelog("[USER INPUT] UPDATE PROGRAM -> CHECK NEW VERSION")
                    //새로운 버전 확인됨
                    rect_lastest.visible = false;
                    rect_need_update.visible = true;
                    text_version1.text = "현재 버전 : " + supervisor.getLocalVersionDate()
                    text_version2.text = "최신 버전 : " + supervisor.getProgramUpdateVersion()
                }else{
                    rect_lastest.visible = true;
                    rect_need_update.visible = false;
                    text_version.text = "현재 버전 : " + supervisor.getLocalVersionDate()
                }
            }


        }
        Rectangle{
            id: rect_lastest
            width: parent.width
            height: parent.height
            color: color_navy
            Column{
                anchors.centerIn: parent
                spacing: 40

                Text{
                    id: text_1
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 40
                    color: "white"
                    text:"프로그램이 이미 최신입니다."
                }
                Text{
                    id: text_version
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                    color: "white"
                    text: "현재 버전 : "+supervisor.getSetting("ROBOT_SW","version_date");
                }

                Rectangle{
                    width: 180
                    height: 60
                    radius: 10
                    color: "#12d27c"
                    border.width: 1
                    border.color: "#12d27c"
                    anchors.horizontalCenter: parent.horizontalCenter
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

        }
        Rectangle{
            id: rect_need_update
            anchors.fill: parent
            width: parent.width
            height: parent.height
            color: color_navy
            Column{
                anchors.centerIn: parent
                spacing: 30

                Text{
                    id: text_11
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 40
                    color: "white"
                    text:"새로운 버전이 확인되었습니다. 업데이트하시겠습니까?"
                }
                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        id: text_version1
                        font.family: font_noto_r.name
                        font.pixelSize: 25
                        color: "white"
                        text:"현재 버전 : "+supervisor.getSetting("ROBOT_SW","version_date")
                    }
                    Text{
                        id: text_version2
                        font.family: font_noto_r.name
                        font.pixelSize: 25
                        color: "white"
                        text:"최신 버전 : "+supervisor.getServerVersionDate()
                    }
                }
                Row{
                    spacing: 50
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle{
                        width: 180
                        height: 60
                        radius: 10
                        color:"transparent"
                        border.width: 1
                        border.color: "white"
                        Text{
                            anchors.centerIn: parent
                            text: "취소"
                            color: "white"
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
                                    if(supervisor.getSetting("ROBOT_SW","update_auto")==="true"){
                                        supervisor.updateNow();
                                    }else{
                                        supervisor.pullGit();
                                    }

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
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                                color: "white"
                            }

                            Text{
                                id: text_right
                                text: "Right"
                                font.family: font_noto_b.name
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
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
        width: 1280
        height: 800
        background: Rectangle{
            anchors.fill: parent
            color: color_dark_black
            opacity: 0.7
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
            text_preset_4.text = supervisor.getSetting("PRESET4","name");
            text_preset_5.text = supervisor.getSetting("PRESET5","name");
            preset_limit_pivot.text = supervisor.getSetting("PRESET"+Number(select_preset),"limit_pivot");
            preset_limit_pivot_acc.text = supervisor.getSetting("PRESET"+Number(select_preset),"limit_pivot_acc");
            preset_limit_v.text = supervisor.getSetting("PRESET"+Number(select_preset),"limit_v");
            preset_limit_vacc.text = supervisor.getSetting("PRESET"+Number(select_preset),"limit_v_acc");
            preset_limit_w.text = supervisor.getSetting("PRESET"+Number(select_preset),"limit_w");
            preset_limit_wacc.text = supervisor.getSetting("PRESET"+Number(select_preset),"limit_w_acc");
        }

        Rectangle{
            id: rect_preset
            width: 900
            height: 600
            anchors.centerIn: parent
            radius: 20
            Column{
                Rectangle{
                    id: rect_preset_t
                    width: rect_preset.width
                    height: 80
                    radius: 20
                    color: color_dark_navy
                    Text{
                        anchors.centerIn: parent
                        color: "white"
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        font.bold: true
                        text: "로봇 프리셋 설정"
                    }
                    Rectangle{
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: parent.radius
                        color: color_dark_navy
                    }
                }
                Row{
                    Rectangle{
                        id: rect_preset_l
                        width: 300
                        radius: 20
                        height: rect_preset.height - rect_preset_t.height
                        color: color_gray
                        Rectangle{
                            anchors.top: parent.top
                            width: parent.width
                            height: parent.radius
                            color: parent.color
                        }
                        Rectangle{
                            anchors.right: parent.right
                            width: parent.radius
                            height: parent.height
                            color: parent.color
                        }
                        Column{
                            anchors.centerIn: parent
                            spacing: 16
                            Row{
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 30
                                Rectangle{
                                    width: 90
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
                                    width: 90
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
                                    Component.onCompleted: {
                                        scale = 1;
                                        while(width*scale > parent.width*0.8){
                                            scale=scale-0.01;
                                        }
                                    }
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
                                    Component.onCompleted: {
                                        scale = 1;
                                        while(width*scale > parent.width*0.8){
                                            scale=scale-0.01;
                                        }
                                    }
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
                                    Component.onCompleted: {
                                        scale = 1;
                                        while(width*scale > parent.width*0.8){
                                            scale=scale-0.01;
                                        }
                                    }
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
                            Rectangle{
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: rect_preset_l.width*0.8
                                height: 70
                                radius: 5
                                border.width: popup_preset.select_preset===4?3:1
                                border.color: popup_preset.select_preset===4?color_green:"black"
                                Text{
                                    id: text_preset_4
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    font.pixelSize: 20
                                    Component.onCompleted: {
                                        scale = 1;
                                        while(width*scale > parent.width*0.8){
                                            scale=scale-0.01;
                                        }
                                    }
                                    font.bold: true
                                    text: "프리셋 4"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        popup_preset.select_preset = 4;
                                        popup_preset.update();
                                    }
                                }
                            }
                            Rectangle{
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: rect_preset_l.width*0.8
                                height: 70
                                radius: 5
                                border.width: popup_preset.select_preset===5?3:1
                                border.color: popup_preset.select_preset===5?color_green:"black"
                                Text{
                                    id: text_preset_5
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    font.pixelSize: 20
                                    Component.onCompleted: {
                                        scale = 1;
                                        while(width*scale > parent.width*0.8){
                                            scale=scale-0.01;
                                        }
                                    }
                                    font.bold: true
                                    text: "프리셋 5"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        popup_preset.select_preset = 5;
                                        popup_preset.update();
                                    }
                                }
                            }
                        }

                    }
                    Rectangle{
                        id: rect_preset_r
                        radius: 20
                        width: rect_preset.width - rect_preset_l.width
                        height:rect_preset_l.height
                        Rectangle{
                            anchors.top: parent.top
                            width: parent.width
                            height: parent.radius
                            color: parent.color
                        }
                        Row{
                            spacing: 30
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            anchors.rightMargin: 60
                            anchors.bottomMargin: 50
                            Rectangle{
                                width: 120
                                height: 60
                                radius: 10
                                border.width: 1
                                Text{
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    font.pixelSize: 15
                                    text: "나가기"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        popup_preset.close();
                                    }
                                }
                            }

                            Rectangle{
                                width: 120
                                height: 60
                                radius: 10
                                border.width: 1
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
                                        }else if(popup_preset.select_preset === 4){
                                            supervisor.setSetting("PRESET4/name",text_preset_4.text);
                                        }else if(popup_preset.select_preset === 5){
                                            supervisor.setSetting("PRESET5/name",text_preset_5.text);
                                        }

                                        supervisor.setSetting("PRESET"+Number(popup_preset.select_preset)+"/limit_pivot",preset_limit_pivot.text);

                                        supervisor.setSetting("PRESET"+Number(popup_preset.select_preset)+"/limit_pivot_acc",preset_limit_pivot_acc.text);
                                        supervisor.setSetting("PRESET"+Number(popup_preset.select_preset)+"/limit_v",preset_limit_v.text);
                                        supervisor.setSetting("PRESET"+Number(popup_preset.select_preset)+"/limit_v_acc",preset_limit_vacc.text);
                                        supervisor.setSetting("PRESET"+Number(popup_preset.select_preset)+"/limit_w",preset_limit_w.text);
                                        supervisor.setSetting("PRESET"+Number(popup_preset.select_preset)+"/limit_w_acc",preset_limit_wacc.text);
                                        popup_preset.close();
                                    }
                                }
                            }
                        }

                        Grid{
                            spacing: 15
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -50
                            rows: 6
                            columns: 3
                            horizontalItemAlignment: Grid.AlignHCenter
                            verticalItemAlignment: Grid.AlignVCenter
                            Text{
                                font.family: font_noto_r.name
                                text:"제자리 회전 속도 [deg/s]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Rectangle{
                                width: 1
                                height: 50
                                color: "#d0d0d0"
                            }
                            TextField{
                                id: preset_limit_pivot
                                width: 200
                                focus:false
                                height: 50
                                text:"";
                                onFocusChanged: {
                                    keypad.owner = preset_limit_pivot;
                                    preset_limit_pivot.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        preset_limit_pivot.select(0,0);
                                    }
                                }
                            }
                            Text{
                                font.family: font_noto_r.name
                                text:"제자리 회전 가속도 [deg/s^2]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Rectangle{
                                width: 1
                                height: 50
                                color: "#d0d0d0"
                            }
                            TextField{
                                id: preset_limit_pivot_acc
                                width: 200
                                height: 50
                                text:"";
                                focus:false
                                onFocusChanged: {
                                    keypad.owner = preset_limit_pivot_acc;
                                    preset_limit_pivot_acc.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        preset_limit_pivot_acc.select(0,0);
                                    }
                                }
                            }
                            Text{
                                font.family: font_noto_r.name
                                text:"주행 속도 [m/s]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Rectangle{
                                width: 1
                                height: 50
                                color: "#d0d0d0"
                            }
                            TextField{
                                id: preset_limit_v
                                width: 200
                                height: 50
                                focus:false
                                text:"";
                                onFocusChanged: {
                                    keypad.owner = preset_limit_v;
                                    preset_limit_v.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        preset_limit_v.select(0,0);
                                    }
                                }
                            }
                            Text{
                                font.family: font_noto_r.name
                                text:"주행 가속도 [m/s^2]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Rectangle{
                                width: 1
                                height: 50
                                color: "#d0d0d0"
                            }
                            TextField{
                                id: preset_limit_vacc
                                width: 200
                                height: 50
                                focus:false
                                text:"";
                                onFocusChanged: {
                                    keypad.owner = preset_limit_vacc;
                                    preset_limit_vacc.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        preset_limit_vacc.select(0,0);
                                    }
                                }
                            }
                            Text{
                                font.family: font_noto_r.name
                                text:"주행 회전속도 [deg/s]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Rectangle{
                                width: 1
                                height: 50
                                color: "#d0d0d0"
                            }
                            TextField{
                                id: preset_limit_w
                                width: 200
                                height: 50
                                focus:false
                                text:"";
                                onFocusChanged: {
                                    keypad.owner = preset_limit_w;
                                    preset_limit_w.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        preset_limit_w.select(0,0);
                                    }
                                }
                            }
                            Text{
                                font.family: font_noto_r.name
                                text:"주행 회전 가속도 [deg/s^2]"
                                font.pixelSize: 20
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > parent.width*0.8){
                                        scale=scale-0.01;
                                    }
                                }
                            }
                            Rectangle{
                                width: 1
                                height: 50
                                color: "#d0d0d0"
                            }
                            TextField{
                                id: preset_limit_wacc
                                width: 200
                                height: 50
                                focus:false
                                text:"";
                                onFocusChanged: {
                                    keypad.owner = preset_limit_wacc;
                                    preset_limit_wacc.selectAll();
                                    if(focus){
                                        keypad.open();
                                    }else{
                                        keypad.close();
                                        preset_limit_wacc.select(0,0);
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
                focus:false
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
            }else if(preset_num === 4){
                text_preset_name_set.text = "(  "+supervisor.getSetting("PRESET4","name") + "   )";
            }else if(preset_num === 5){
                text_preset_name_set.text = "(  "+supervisor.getSetting("PRESET5","name") + "   )";
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
                    height: 50
                    font.family: font_noto_r.name
                    focus:false
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
                    height: 50
                    font.family: font_noto_r.name
                    focus:false
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
                    height: 50
                    font.family: font_noto_r.name
                    focus:false
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
                    height: 50
                    font.family: font_noto_r.name
                    focus:false
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
                    height: 50
                    font.family: font_noto_r.name
                    focus:false
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
                    height: 50
                    font.family: font_noto_r.name
                    focus:false
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
                    height: 50
                    font.family: font_noto_r.name
                    focus:false
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
                    height: 50
                    font.family: font_noto_r.name
                    focus:false
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
                    height: 50
                    focus:false
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
                    height: 50
                    font.family: font_noto_r.name
                    focus:false
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
                    height: 50
                    font.family: font_noto_r.name
                    focus:false
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
                    height: 50
                    horizontalAlignment: Text.AlignHCenter
                    focus:false
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
            timer_update_wifi.start();
            supervisor.getAllWifiList();
            supervisor.readWifi();
        }
        onClosed:{
            timer_update_wifi.stop();
        }
        Timer{
            id: timer_update_wifi
            running: false
            repeat: true
            interval: 1000
            triggeredOnStart: true
            onTriggered: {
                supervisor.getAllWifiList();
                model_wifis.clear();
                for(var i=0; i<supervisor.getWifiNum(); i++){
                    model_wifis.append({"ssd":supervisor.getWifiSSD(i),"inuse":supervisor.getWifiInuse(i),"rate":supervisor.getWifiRate(i),"level":supervisor.getWifiLevel(i),"security":supervisor.getWifiSecurity(i)});
                }
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
                id: flickable_wifi
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
                            height: 50
                            radius: 5
                            border.width:4
                            border.color: col_wifis.select_wifi===index?color_green:"white"
                            Text{
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text: ssd
                            }
                            Text{
                                font.family: font_noto_r.name
                                text: "(사용중)"
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
                                width: 40
                                height: 50
                                ColorOverlay{
                                    anchors.fill: parent
                                    source: parent
                                    color: color_gray
                                }
                            }

                            Row{
                                spacing: 1
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 10
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
                            timer_update_wifi.stop();
                            if(model_wifis.get(col_wifis.select_wifi).inuse){
                                popup_wifi.close();
                            }else if(model_wifis.get(col_wifis.select_wifi).security){
                                popup_wifi_passwd.ssd = model_wifis.get(col_wifis.select_wifi).ssd;
                                popup_wifi_passwd.open();
                            }else{
                                print("check connect", model_wifis.get(col_wifis.select_wifi).ssd, "");
                                supervisor.connectWifi(model_wifis.get(col_wifis.select_wifi).ssd, "")
                                popup_loading.open();
                            }
                        }
                    }
                }
            }
        }
    }
    Popup{
        id: popup_loading
        anchors.centerIn: parent
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        bottomPadding: 0
        width: 1280
        height: 800
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
                width: 150
                height: 150
                anchors.right: parent.right
                anchors.bottom : parent.bottom
                z: 99
                property var password: 0
                onClicked: {
                    password++;
                    if(password > 4){
                        password = 0;
                        popup_loading.close();
                    }
                }
            }
        }
    }

    function wifi_con_failed(){
        print("wifi_con_failed")
        popup_loading.close();
        passwd_wifi.color = color_red;
        text_wifi76788.visible = true;
    }
    function wifi_con_success(){
        print("wifi_con_success")
        popup_loading.close();
        popup_wifi_passwd.close();
        popup_wifi.close();
        init();
    }

    Popup{
        id: popup_wifi_passwd
        property string ssd: ""
        property bool show_passwd: false
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
            text_wifi76788.visible = false;
            passwd_wifi.color = "black";
        }

        Rectangle{
            width: parent.width
            height: parent.height
            radius: 10
            color: color_dark_navy
            Text{
                id: text_wifi222
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 30
                text: "WIFI 설정"
                color: "white"
                font.family: font_noto_r.name
                font.pixelSize: 20
            }
            Text{
                id: text_wifi555
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_wifi222.bottom
                anchors.topMargin: 20
                text: "비밀번호를 입력해주세요."
                color: "white"
                font.family: font_noto_r.name
                font.pixelSize: 15
            }
            Rectangle{
                width: parent.width
                height: 250
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_wifi555.bottom
                anchors.topMargin: 15
                color: color_dark_navy
                Column{
                    anchors.centerIn: parent
                    spacing: 30
                    Text{
                        id: text_wifi75
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: popup_wifi_passwd.ssd
                        color: "white"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                    }
                    Text{
                        id: text_wifi76788
                        visible: false
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "비밀번호가 틀렸습니다."
                        color: color_red
                        font.family: font_noto_r.name
                        font.pixelSize: 17
                    }
                    Row{
                        spacing: 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        TextField{
                            id: passwd_wifi
                            width: 200
                            height: 50
                            focus:false
                            horizontalAlignment: Text.AlignHCenter
                            anchors.verticalCenter: parent.verticalCenter
                            echoMode: popup_wifi_passwd.show_passwd?TextInput.Normal:TextInput.Password
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
                        Rectangle{
                            width: 50
                            height: 50
                            radius: 5
                            color: "transparent"
                            border.color: "white"
                            border.width: 1
                            Image{
                                anchors.centerIn: parent
                                width: 35
                                height: 35
                                source:popup_wifi_passwd.show_passwd?"icon/icon_obj_yes.png":"icon/icon_obj_no.png"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
                                    if(popup_wifi_passwd.show_passwd){
                                        popup_wifi_passwd.show_passwd = false;
                                    }else{
                                        popup_wifi_passwd.show_passwd = true;
                                    }
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
                            popup_wifi_passwd.close();
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
                            print("check connect", popup_wifi_passwd.ssd, passwd_wifi.text);
                            supervisor.connectWifi(popup_wifi_passwd.ssd, passwd_wifi.text);
                            popup_loading.open();
                        }
                    }
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
//    SoundEffect{
//        id: click
//        source: "bgm/click.wav"
//    }
}
