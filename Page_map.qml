import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0 as Platform
import QtQuick.Shapes 1.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12
import "."
import io.qt.Supervisor 1.0

Item {
    id: page_map
    objectName: "page_map"
    width: 1280
    height: 800
    property int width_menu: 400
    //slam
    property bool slam_initializing: false
    property bool joystick_connection: false
    property bool joy_init: false
    property var joy_axis_left_ud: 0
    property var joy_axis_right_rl: 0

    property bool edit_flag: false
    property int state_meta: 0
    property int state_annot: 0
    property int state_map: 0

    //mode : 0(mapview) 1:(slam-mapping) 2:(annotation) 3:(patrol) 4: (slam-localization)
    property int map_mode: 0

    property bool is_mapping: false
    property bool is_objecting: false

    //0: location 1: record 2: random
    property int patrol_mode: 2
    property bool recording: false

    property bool is_init_state: false
    property bool is_save_annot: false

    property var last_robot_x: supervisor.getOrigin()[0]
    property var last_robot_y: supervisor.getOrigin()[1]
    property var last_robot_th: 0

    //annotation
    property string select_object_type: "Wall"
    property string select_location_type: "Serving"
    property int select_tline_num: -1
    property int select_tline_category: -1
    property int select_patrol_num: -1
    property var select_preset: 1

    property var cur_group: 0

    Tool_Keyboard{
        id: keyboard
    }

    Tool_KeyPad{
        id: keypad
    }

    function set_call_done(){
        popup_location_number.update_callbell();
        popup_add_callbell.close();
    }

    function update_mapping(){
        if(map_mode == 1){
            map.loadmapping();
        }
    }
    function update_objecting(){
        map.loadobjecting();

    }

    Component.onCompleted: {
        init_map();
        statusbar.visible = true;

        if(supervisor.isExistAnnotation(supervisor.getMapname())){
            state_annot = 1;
        }else{
            state_annot = 0;
        }

        if(supervisor.isExistMap(supervisor.getMapname())){
            state_map = 1;
            state_meta = 1;
        }else{
            state_map = 0;
            state_meta = 0;
        }
    }

    Component.onDestruction:  {
        if(supervisor.getJoyXY() !== 0){
            supervisor.joyMoveXY(0,0);
        }
        if(supervisor.getJoyR() !== 0){
            supervisor.joyMoveR(0,0);
        }
        is_init_state = false;
    }

    onMap_modeChanged: {
        if(map_mode == 0){
            if(!is_init_state)
                modeinit();
        }else{
            if(is_init_state){
                map_cur.visible = false;
                map_annot.visible = true;
                rect_menus.width = 500;
                init_map();
            }else{
                ani_mode_change.start();
            }
        }
    }

    Item{
        enabled: map_mode == 1?true:false
        focus: true
        Keys.onReleased: {
            if(!event.isAutoRepeat){
                if(event.key === Qt.Key_Up){
                    print("release2 key_up")
                    loader_menu.item.setKeyUp(false);
                }
                if(event.key === Qt.Key_Down){
                    loader_menu.item.setKeyDown(false);
                }
                if(event.key === Qt.Key_Left){
                    loader_menu.item.setKeyLeft(false);
                }
                if(event.key === Qt.Key_Right){
                    loader_menu.item.setKeyRight(false);
                }
            }
        }
        Keys.onPressed: {
            if(!event.isAutoRepeat){
                if(event.key === Qt.Key_Up){
                    print("press2 key_up")
                    loader_menu.item.setKeyUp(true);
                }
                if(event.key === Qt.Key_Down){
                    loader_menu.item.setKeyDown(true);
                }
                if(event.key === Qt.Key_Left){
                    loader_menu.item.setKeyLeft(true);
                }
                if(event.key === Qt.Key_Right){
                    loader_menu.item.setKeyRight(true);
                }
            }
        }
    }

    SequentialAnimation{
        id: ani_mode_change
        running: false
        onStarted: {
            loader_menu.item.disappear();
            map_annot.enabled = false;
            map_cur.enabled = false;
            map_annot.opacity = 0;
            map_annot.visible = true;
            rect_menu_dump.visible = true;
        }
        ParallelAnimation{
            NumberAnimation{target: rect_menus; property: "width"; to: 450; duration: 500}
            NumberAnimation{target: map_cur; property: "opacity"; to: 0; duration: 500}
        }
        ParallelAnimation{
            NumberAnimation{target: map_annot; property: "opacity"; to: 1; duration: 500}
            NumberAnimation{target: text_menu_title; property: "opacity"; to: 1; duration: 500}
            NumberAnimation{target: rect_menu_dump; property: "anchors.topMargin"; from: 0; to: -loader_menu.height; duration: 500}
        }
        onFinished: {
            init_map();
            rect_menu_dump.visible = false;
            rect_menu_dump.anchors.topMargin = 0;
            map_annot.enabled = true;
            map_cur.enabled = true;
            map_cur.visible = false;
        }
    }
    function init(){

    }
    function setLocalizationInit(){
        map_mode = 4;
        is_init_state = true;
    }

    function modeinit(){
        init_map();
        map_cur.visible = true;
        map_annot.visible = false;
        map_cur.opacity = 1;

        rect_menus.width = 300;
        btn_menu.width = 120;
    }

    function updatepath(){
        map_current.update_path();
    }

    function updatecanvas(){
        map.update_canvas();
    }

    Rectangle{
        id: status_bar
        width: parent.width
        height: 60
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        color: "white"
    }

    Rectangle{
        id: rect_menus
        width: 300
        height: parent.height - status_bar.height
        anchors.left: parent.left
        anchors.top: status_bar.bottom
        color: "#323744"
        Behavior on width{
            NumberAnimation{
                duration :500;
            }
        }
        Rectangle{
            id: rect_menu_title
            width: parent.width
            height: 50
            color: "#323744"
            Text{
                id: text_menu_title
                visible: map_mode==0?false:true
                opacity: map_mode==0?0:0
                anchors.centerIn: parent
                color: "white"
                font.family: font_noto_b.name
                font.pixelSize: 20
                text: {
                    if(map_mode == 1){
                        "SLAM"
                    }else if(map_mode == 2){
                        "Annotation"
                    }else if(map_mode == 3){
                        "Patrol"
                    }else if(map_mode == 4){
                        "Localization"
                    }else{
                        ""
                    }
                }
            }
        }
        Loader{
            id: loader_menu
            width: parent.width
            height: parent.height - rect_menu_title.height
            anchors.top: rect_menu_title.bottom
            sourceComponent: menu_main
        }
        Rectangle{
            id: rect_menu_dump
            width: loader_menu.width
            height: loader_menu.height
            anchors.top: parent.bottom
            color: "#f4f4f4"
        }
    }

    ////////************************ITEM :: MAP **********************************************************
    Item{
        id: map_cur
        objectName: "map_current"
        width: parent.width - rect_menus.width
        height: parent.height - status_bar.height
        anchors.left: rect_menus.right
        anchors.top: status_bar.bottom

        onVisibleChanged: {
            if(visible){
                map_current.setEnable(true);
            }else{
                map_current.setEnable(false);
            }
        }

        Rectangle{
            id: rect_mapview
            anchors.fill: parent
            color: "#282828"
            Text{
                id: text_curmap
                color:"white"
                text: "현재 맵"
                font.pixelSize: 25
                font.family: font_noto_b.name
                anchors.horizontalCenterOffset: -70
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 20
            }
            Map_full{
                id: map_current
                objectName: "CURRENT"
                enabled: false
                width: 600
                height: 600
                show_button_following: true
                show_button_lidar: true
                show_button_object: true
                Component.onCompleted: {
//                    supervisor.readSetting()
                    loadmap(supervisor.getMapname(),"EDITED")
                    setViewer("current");
                }
                anchors.horizontalCenter: text_curmap.horizontalCenter
                anchors.top: text_curmap.bottom
                anchors.topMargin: 20
            }
        }
    }

    Item{
        id: map_annot
        visible: false
        width: parent.width - rect_menus.width
        height: parent.height - status_bar.height
        anchors.left: rect_menus.right
        anchors.top: status_bar.bottom
        Component.onCompleted: {
            print("map_annot completed");
            map.setEnable(true);

        }
        Component.onDestruction: {
            print("map_annot destruction");
            map.setEnable(false);
        }

        onVisibleChanged: {
            if(visible){
                map.setEnable(true);
            }else{
                map.setEnable(false);
            }
        }
        Rectangle{
            anchors.fill: parent
            color: "#282828"
            Map_full{
                id: map
                objectName: "ANNOT"
                height: parent.height
                width: height
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                clip: true
                Component.onCompleted: {
                    supervisor.readSetting();
                    map.loadmap(supervisor.getMapname());
                    map.setViewer("current")
                }
            }
            Rectangle{
                id: rect_init_notice
                width: 400
                height: 140
                visible: slam_initializing
                radius: 10
                anchors.centerIn: map
                color: "#4F5666"
                Text{
                    anchors.centerIn: parent
                    text:"초기화 중입니다.\n잠시만 기다려 주세요."
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }

    Component{
        id: menu_main
        Item{
            function disappear(){
                opacity = 0;
            }
            function appear(){
                opacity = 1;
            }

            Behavior on opacity {
                OpacityAnimator{
                    duration: 500;
                }
            }
            Column{
                spacing: 40
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -text_menu_title.height
//                anchors.horizontalCenter: parent.horizontalCenter

                Repeater{
                    model: ["맵 새로만들기","현재맵 수정하기","위치 초기화","지정 순회"]
                    Rectangle{
                        property int btn_size: 135
                        width: btn_size
                        height: btn_size
                        radius: btn_size
                        color: "white"
                        Rectangle{
                            id: rect_btn
                            width: btn_size
                            height: btn_size
                            radius: 13
                            color: "white"
                            Column{
                                anchors.centerIn: parent
                                spacing: 8
                                Image{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width: 50
                                    height: 48
                                    sourceSize.width: 50
                                    sourceSize.height: 48
                                    source: {
                                        if(modelData == "맵 새로만들기"){
                                            "image/image_slam.png"
                                        }else if(modelData == "위치 초기화"){
                                            "image/image_localization_reset.png"
                                        }else if(modelData == "현재맵 수정하기"){
                                            "image/image_annot.png"
                                        }else if(modelData == "지정 순회"){
                                            "image/image_patrol.png"
                                        }
                                    }
                                }
                                Text{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: font_noto_r.name
                                    font.pixelSize: 18
                                    color: "#323744"
                                    text:modelData
                                }
                            }
                        }
//                        DropShadow{
//                            anchors.fill: parent
//                            radius: 15
//                            color: "#d0d0d0"
//                            source: rect_btn
//                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "맵 새로만들기"){
                                    loadPage(pmapping);
//                                    map_mode = 1;
//                                    supervisor.writelog("[USER INPUT] MAP PAGE -> MOVE TO MAPPING")
                                }else if(modelData == "현재맵 수정하기"){
                                    map_mode = 2;
                                    supervisor.writelog("[USER INPUT] MAP PAGE -> MOVE TO ANNOTATION")
                                    edit_flag = true;
                                    supervisor.setAnnotEditFlag(true);
                                }else if(modelData == "위치 초기화"){
                                    supervisor.writelog("[USER INPUT] MAP PAGE -> MOVE TO LOCALIZATION")
                                    map_mode = 4;
                                }else if(modelData == "지정 순회"){
                                    supervisor.writelog("[USER INPUT] MAP PAGE -> MOVE TO PATROL")
                                    map_mode = 3;
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
        anchors.top: status_bar.bottom
        anchors.topMargin: 50
        color: map_mode==0?"white":"transparent"
        radius: 30
        property bool is_restart: false
        Behavior on width{
            NumberAnimation{
                duration: 500;
            }
        }
        Image{
            id: image_btn_menu
            source:map_mode==0?"icon/btn_menu.png":"icon/btn_reset2.png"
            scale: 1-(120-parent.width)/120
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(map_mode==0 || is_init_state){
                    supervisor.writelog("[USER INPUT] MAP PAGE -> MOVE TO BACKPAGE "+Number(map_mode) + "," + Number(is_init_state))
                    backPage();
                }else if(map_mode == 1){
                    if(btn_menu.is_restart){
                        supervisor.stopMapping();
                        supervisor.restartSLAM();
                        supervisor.setMap(supervisor.getMapname());
                        map.setViewer("current");
                        map.loadmap(supervisor.getMapname(),"EDITED");
                        loadPage(pinit);
                    }else{
                        supervisor.writelog("[USER INPUT] MAP PAGE -> MOVE TO MAIN")
                        map_mode = 0;
                    }
                }else{
                    supervisor.writelog("[USER INPUT] MAP PAGE -> MOVE TO MAIN")
                    map_mode = 0;
                }
            }
        }
    }


    ////////************************ITEM :: MENU**********************************************************
    Component{
        id: menu_slam
        Item{
            anchors.fill: parent
            Component.onCompleted: {
                btn_menu.is_restart = false;
                help_image.source = "video/slam_help.gif"
                if(supervisor.getSetting("ROBOT_SW","use_help") === "true"){
                    popup_help.open();
                }
            }

            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }
            Rectangle{
                id: rect_annot_state
                width: parent.width
                height: 50
                anchors.top: parent.top
                anchors.topMargin: 2
                color: "#4F5666"
                Text{
                    anchors.centerIn: parent
                    color: "white"
                    font.family: font_noto_b.name
                    font.pixelSize: 20
                    text: "맵 새로만들기"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id: rect_annot_box_map
                width: parent.width - 60
                height: 100
                radius: 5
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 30
                color: "#e8e8e8"
                Row{
                    anchors.centerIn: parent
                    spacing: 30
                    Rectangle{
                        id: state_manual
                        width: 100
                        height: 80
                        radius: 10
                        color: "white"
                        enabled: supervisor.getEmoStatus()
                        border.color:color_green
                        border.width: enabled?3:0
                        Column{
                            spacing: 3
                            anchors.centerIn: parent
                            Image{
                                source: "icon/image_emergency.png"
                                Component.onCompleted: {
                                    if(sourceSize.width > 30)
                                        sourceSize.width = 30

                                    if(sourceSize.height > 30)
                                        sourceSize.height = 30
                                }
                                anchors.horizontalCenter: parent.horizontalCenter
                                ColorOverlay{
                                    id: emo_light
                                    anchors.fill: parent
                                    source: parent
                                    color: color_green
                                    visible: state_manual.enabled
                                }
                            }

                            Text{
                                font.family: font_noto_r.name
                                font.pixelSize: 12
                                text: "비상스위치 눌림"
                                anchors.horizontalCenter: parent.horizontalCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }
                    Rectangle{
                        id: state_mapping
                        width: 100
                        height: 80
                        radius: 10
                        color: "white"
                        border.color:color_green
                        border.width: is_mapping?3:0
                        Column{
                            spacing: 3
                            anchors.centerIn: parent
                            Image{
                                source: is_mapping?"icon/icon_mapping.png":"icon/icon_mapping_start.png"
                                Component.onCompleted: {
                                    if(sourceSize.width > 30)
                                        sourceSize.width = 30

                                    if(sourceSize.height > 30)
                                        sourceSize.height = 30
                                }
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                font.family: font_noto_r.name
                                font.pixelSize: 12
                                text: is_mapping?"맵 생성 중":"맵 생성하기"
                                anchors.horizontalCenter: parent.horizontalCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                if(supervisor.getLCMConnection()){
                                    if(is_mapping){
                                        popup_reset_mapping.open();
                                    }else{
                                        btn_menu.is_restart = true;
                                        supervisor.writelog("[USER INPUT] MAPPING PAGE : START MAPPING " + supervisor.getSetting("ROBOT_SW","grid_size"))
//                                        map.grid_size = parseFloat(supervisor.getSetting("ROBOT_SW","grid_size"));
                                        supervisor.startMapping(0);
                                    }
                                }else{
                                    supervisor.writelog("[USER INPUT] MAPPING PAGE : START MAPPING -> BUT SLAM NOT CONNECTED")
                                }
                            }
                        }
                    }
                }
            }
            Rectangle{
                id: rect_annot_box_map_2
                width: parent.width - 60
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_box_map.bottom
                anchors.topMargin: 5
                color: "white"
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 50
                    spacing: 10
                    Text{
                        text: "맵 크기 : "
                        font.family: font_noto_r.name
                        font.pixelSize: 15
//                            anchors.verticalCenter: parent.verticalCenter
//                            anchors.left: parent.left
//                            anchors.leftMargin: 50
                    }
                    Text{
                        id: map_size
                        text: supervisor.getSetting("ROBOT_SW","map_size");
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                    Text{
                        text: "pixel"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                }
                Rectangle{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 50
                    width: 80
                    height: 30
                    radius: 5
                    color: "black"
                    Text{
                        text: "변경하기"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: "white"
                        anchors.centerIn: parent
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            popup_changed_mapping_variable.initvalue = supervisor.getSetting("ROBOT_SW","map_size");
                            popup_changed_mapping_variable.mode = 1;
                            popup_changed_mapping_variable.open();
                        }
                    }
                }
            }
            Popup{
                id: popup_changed_mapping_variable
                anchors.centerIn: parent
                width: 400
                height: 300
                property string initvalue:""
                property var mode:0
                background: Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                }
                onOpened:{
                    textfield_changed.text = initvalue;
                }

                Rectangle{
                    width: parent.width
                    height: parent.height
                    radius: 20
                    color: color_dark_navy
                    Column{
                        anchors.centerIn: parent
                        spacing: 20
                        Text{
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.family: font_noto_r.name
                            text: "변경하실 값을 입력해주세요."
                            color: "white"
                        }
                        TextField{
                            id: textfield_changed
                            width: 250
                            height: 50

                            onFocusChanged: {
                                keyboard.owner = textfield_changed;
                                textfield_changed.selectAll();
                                if(focus){
                                    keyboard.open();
                                }else{
                                    keyboard.close();
                                    textfield_changed.select(0,0);
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
                                color: "transparent"
                                border.width: 5
                                border.color: "white"
                                Text{
                                    anchors.centerIn: parent
                                    text: "취소"
                                    font.family: font_noto_r.name
                                    color: "white"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        popup_changed_mapping_variable.close();
                                    }
                                }
                            }
                            Rectangle{
                                width: 100
                                height: 50
                                radius: 5
                                color: "transparent"
                                border.width: 5
                                border.color: "white"
                                Text{
                                    anchors.centerIn: parent
                                    text: "확인"
                                    font.family: font_noto_r.name
                                    color: "white"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        if(popup_changed_mapping_variable.mode == 1){
                                            supervisor.setSetting("ROBOT_SW/map_size",textfield_changed.text);
                                            map_size.text = supervisor.getSetting("ROBOT_SW","map_size");
                                        }else if(popup_changed_mapping_variable.mode == 2){
                                            supervisor.setSetting("ROBOT_SW/grid_size",textfield_changed.text);
                                            grid_size.text = supervisor.getSetting("ROBOT_SW","grid_size");
                                        }
                                        supervisor.readSetting();
                                        popup_changed_mapping_variable.close();
                                    }
                                }
                            }
                        }
                    }
                }

            }

            Rectangle{
                id: rect_annot_box444
                width: parent.width - 60
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_box_map_2.bottom
                anchors.topMargin: 5
                color: "white"

                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 50
                    spacing: 10
                    Text{
                        text: "단위 크기 : "
                        font.family: font_noto_r.name
                        font.pixelSize: 15
//                            anchors.verticalCenter: parent.verticalCenter
//                            anchors.left: parent.left
//                            anchors.leftMargin: 50
                    }
                    Text{
                        id: grid_size
                        text: supervisor.getSetting("ROBOT_SW","grid_size");
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                    Text{
                        text: "m"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                }
                Rectangle{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 50
                    width: 80
                    height: 30
                    radius: 5
                    color: "black"
                    Text{
                        text: "변경하기"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: "white"
                        anchors.centerIn: parent
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            popup_changed_mapping_variable.initvalue = supervisor.getSetting("ROBOT_SW","grid_size");
                            popup_changed_mapping_variable.mode = 2;
                            popup_changed_mapping_variable.open();
                        }
                    }
                }

            }
            Timer{
                id: update_timer
                interval: 500
                running: true
                repeat: true
                onTriggered:{
//                    print(supervisor.getMappingflag())
                    if(supervisor.getMappingflag()){
                        if(!is_mapping){
                            voice_stop_mapping.stop();
                            voice_start_mapping.play();
                            is_mapping = true;
                        }
                    }else{
                        if(is_mapping){
                            voice_start_mapping.stop();
//                            voice_stop_mapping.play();
                            is_mapping = false;
                        }
                    }

                    if(supervisor.getEmoStatus()){
                        state_manual.enabled = true;
//                        timer_check_keyboard.stop();
//                        timer_get_joy.stop();
                    }else{
                        state_manual.enabled = false;
                    }

                }
            }
            Column{
                id: cols
                anchors.top: rect_annot_box444.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Rectangle{
                    width: 400
                    height: 200
                    radius: 10

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
                                text: "로봇 상단의 비상스위치를 눌러 수동모드로 전환하세요."
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
                                text: "매핑 시작하기 버튼을 누르고 로봇을 끌면서 맵을 생성합니다."
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
                                text: "끝나면 저장 버튼을 눌러 저장해주세요."
                                font.pixelSize: 13
                                font.family: font_noto_r.name
                                color: color_red
                            }
                        }

                    }
                }//                        Row{
                //                            spacing: 30
                //                            anchors.horizontalCenter: parent.horizontalCenter
                //                            Rectangle{
                //                                width: 100
                //                                height: 40
                //                                radius: 5
                //                                color: "black"
                //                                Text{
                //                                    anchors.centerIn: parent
                //                                    color: "white"
                //                                    text: "가상 조이스틱"
                //                                    font.pixelSize: 15
                //                                    font.family: font_noto_r.name
                //                                }
                //                                MouseArea{
                //                                    anchors.fill: parent
                //                                    onClicked:{
                //                                        row_joysticks.visible = true;
                //                                        col_manual.visible = false;
                //                                        keyboard_arrow.visible = false;
                //                                    }
                //                                }
                //                            }
                //                            Rectangle{
                //                                width: 100
                //                                height: 40
                //                                radius: 5
                //                                color: "black"
                //                                Text{
                //                                    anchors.centerIn: parent
                //                                    color: "white"
                //                                    text: "가상 키보드"
                //                                    font.pixelSize: 15
                //                                    font.family: font_noto_r.name
                //                                }
                //                                MouseArea{
                //                                    anchors.fill: parent
                //                                    onClicked:{
                //                                        row_joysticks.visible = false;
                //                                        col_manual.visible = false;
                //                                        keyboard_arrow.visible = true;
                //                                    }
                //                                }
                //                            }
                //                        }

//                Row{
//                    id: row_joysticks
//                    visible: false
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    spacing: 60
//                    Item_joystick{
//                        id: joy_xy
//                        verticalOnly: true
//                        bold: true
//                        onUpdate_cntChanged: {
//                            if(update_cnt == 0 && supervisor.getJoyXY() != 0){
//                                supervisor.joyMoveXY(0, 0);
//                            }else if(update_cnt > 2){
//                                if(fingerInBounds) {
//                                    supervisor.joyMoveXY(Math.sin(angle) * Math.sqrt(fingerDistance2) / distanceBound);
//                                }else{
//                                    supervisor.joyMoveXY(Math.sin(angle));
//                                }
//                            }
//                        }
//                    }
//                    Item_joystick{
//                        id: joy_th
//                        horizontalOnly: true
//                        bold: true
//                        onUpdate_cntChanged: {
//                            if(update_cnt == 0 && supervisor.getJoyR() != 0){
//                                supervisor.joyMoveR(0, 0);
//                            }else if(update_cnt > 2){
//                                if(fingerInBounds) {
//                                    supervisor.joyMoveR(-Math.cos(angle) * Math.sqrt(fingerDistance2) / distanceBound);
//                                } else {
//                                    supervisor.joyMoveR(-Math.cos(angle));
//                                }
//                            }
//                        }
//                    }
//                }

//                Item_keyboard{
//                    id: keyboard_arrow
//                    visible : false
//                    anchors.horizontalCenter: parent.horizontalCenter
//                }
//                Column{
//                    id: col_manual
//                    visible: true
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    spacing: 5
//                    Item_switch{
//                        id: switch_joy
//                        enabled: supervisor.getLCMConnection()
//                        onoff: supervisor.getEmoStatus()?true:false
//                        touchEnabled: false
//                        anchors.horizontalCenter: parent.horizontalCenter
//                    }
//                    Text{
//                        anchors.horizontalCenter: parent.horizontalCenter
//                        text: "수동 조작"
//                        font.family: font_noto_r.name
//                        font.pixelSize: 10
//                        horizontalAlignment: Text.AlignHCenter
//                    }
//                }

            }
            Rectangle{
                id: btn_save_map
                width: 200
                height: 80
                radius: 5
                enabled: is_mapping
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: cols.bottom
                anchors.topMargin : 20
//                anchors.left: rect_annot_box_map.left
                color: is_mapping?"black":color_gray
                Text{
                    anchors.centerIn: parent
                    text: "저장"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        popup_save_mapping.open();
                    }
                }
            }
        }
    }

    Component{
        id: menu_localization
        Item{
            width: rect_menus.width
            height: rect_menus.height
            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }

            Timer{
                id: timer_check_localization
                running: false
                repeat: true
                interval: 500
                onTriggered:{
                    if(supervisor.is_slam_running()){
                        btn_auto_init.running = false;
                        map.clear("all");
                        timer_check_localization.stop();
                        supervisor.writelog("[QML] CHECK LOCALIZATION -> STARTED")
                    }else if(supervisor.getLocalizationState() === 0 || supervisor.getLocalizationState() === 3){
                        timer_check_localization.stop();
                        btn_auto_init.running = false;
                        supervisor.writelog("[QML] CHECK LOCALIZATION -> NOT WORKING "+Number(supervisor.getLocalizationState()));
                    }
                }
            }

            Rectangle{
                id: rect_annot_box
                width: parent.width - 60
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
                color: "#e8e8e8"
                Row{
                    anchors.centerIn: parent
                    spacing: 20
                    Item_button{
                        id: btn_move
                        width: 80
                        shadow_color: color_gray
                        highlight: map.tool=="move"
                        icon: "icon/icon_move.png"
                        name: "이동"
                        MouseArea{
                            anchors.fill: parent
                            onPressed: {
                                parent.pressed();
                            }
                            onReleased:{
                                parent.released();
                            }

                            onClicked: {
                                supervisor.writelog("[QML] MAP PAGE (LOCAL) -> MOVE")
                                map.setTool("move");
                            }
                        }
                    }
                    Item_button{
                        width: 80
                        visible: false
                        shadow_color: color_gray
                        icon: "icon/icon_local_manual.png"
                        name: "대기위치로\n초기화"
                        MouseArea{
                            anchors.fill: parent
                            onPressed: {
                                parent.pressed();
                            }
                            onReleased:{
                                parent.released();
                            }

                            onClicked: {
                                supervisor.slam_stop();
                                if(supervisor.getGridWidth() > 0){
                                    var init_x = supervisor.getLocationx("Resting");
                                    var init_y = supervisor.getLocationy("Resting");
                                    var init_th  = supervisor.getLocationth("Resting");
                                    map.setAutoInit(init_x,init_y,init_th);
                                }
                                supervisor.writelog("[QML] MAP PAGE (LOCAL) -> LOCALIZATION MANUAL ")
                                supervisor.slam_setInit();
                            }
                        }
                    }
                    Item_button{
                        width: 80
                        shadow_color: color_gray
                        highlight: map.tool=="slam_init"
                        icon: "icon/icon_local_manual.png"
                        name: "수동 초기화"
                        MouseArea{
                            anchors.fill: parent
                            onPressed: {
                                parent.pressed();
                            }
                            onReleased:{
                                parent.released();
                            }

                            onClicked: {
                                supervisor.slam_stop();
                                map.setTool("slam_init");
                                if(supervisor.getGridWidth() > 0){
                                    var init_x = supervisor.getlastRobotx();
                                    var init_y = supervisor.getlastRoboty();
                                    var init_th  = supervisor.getlastRobotth();
//                                    print(supervisor.getlastRobotx(),supervisor.getGridWidth(),supervisor.getOrigin()[0],init_x);
                                    map.setAutoInit(init_x,init_y,init_th);
                                }
                                supervisor.writelog("[QML] MAP PAGE (LOCAL) -> LOCALIZATION MANUAL ")
                                supervisor.slam_setInit();
                            }
                        }
                    }
                    Item_button{
                        id: btn_auto_init
                        width: 78
                        shadow_color: color_gray
                        icon:"icon/icon_local_auto.png"
                        name:"자동 초기화"
                        MouseArea{
                            anchors.fill: parent
                            onPressed: {
                                parent.pressed();
                            }
                            onReleased:{
                                parent.released();
                            }
                            onClicked: {
                                if(supervisor.getLocalizationState() !== 1){
                                    btn_auto_init.running = true;
                                    supervisor.slam_autoInit();
                                    timer_check_localization.start();
                                    supervisor.writelog("[QML] MAP PAGE (LOCAL) -> LOCALIZATION AUTO ")
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
                anchors.top: rect_annot_box.bottom
                anchors.topMargin: 30
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
                            text: "비상스위치가 눌려있다면 풀어주세요."
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
                            text: "라이다가 맵과 일치하는 지 확인해주세요."
                            font.pixelSize: 13
                            font.family: font_noto_r.name
                            color: color_red
                        }
                    }
                }
            }
        }
    }

    Component{
        id: menu_annot
        Item{
            StackView{
                id: stackview_annot_menu
                width: rect_menus.width
                height: rect_menus.height
                initialItem: menu_state
            }
        }
    }

    //Annotation Menu ITEM===================================================
    Component{
        id: menu_annot_state
        Item{
            id: menu_state
            objectName: "menu_init"
            width: rect_menus.width
            height: rect_menus.height
            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }
            Component.onCompleted: {
                map.setViewer("current")
                text_menu_title.text = "Annotation";
                text_menu_title.visible = true;
                map.show_connection = false;
                map.show_button_following = false;
                map.show_button_lidar = false;
                map.show_button_object = false;
                map.show_button_location = false;
                loader_menu.sourceComponent = menu_annot_state;
            }

            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 2
                spacing: 20
                Rectangle{
                    id: rect_annot_state
                    width: menu_state.width
                    height: 50
                    color: "#4F5666"
                    Text{
                        anchors.centerIn: parent
                        color: "white"
                        font.family: font_noto_b.name
                        font.pixelSize: 20
                        text: "설정된 맵 정보"
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Rectangle{
                    id: rect_annot_map_name
                    width: menu_state.width*0.9
                    radius: 5
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "white"
                    Text{
                        anchors.centerIn: parent
                        color: "#282828"
                        font.family: font_noto_b.name
                        font.pixelSize: 20
                        text: is_init_state?"맵 이름 : " + map.map_name:"맵 이름 : " + supervisor.getMapname();
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Rectangle{
                    width: menu_state.width
                    height: 100
                    color: "#e8e8e8"
                    Row{
                        anchors.centerIn: parent
                        spacing: 30
                        Text{
                            font.pixelSize: 12
                            anchors.verticalCenter: parent.verticalCenter
                            text: "바로\n가기"
                            color: color_navy
                            font.family: font_noto_r.name
                        }
                        Rectangle{
                            width: 100
                            height: 60
                            radius: 5
                            DropShadow{
                                anchors.fill: parent
                                radius: 6
                                color: color_light_gray
                                source: parent
                            }
                            Rectangle{
                                width: 100
                                height: 60
                                radius: 5
                                color: color_gray
                                border.width: 1
                                border.color: "white"
                                Text{
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "노이즈 제거"
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed:{
                                        parent.color = color_mid_gray
                                    }
                                    onReleased: {
                                        parent.color = color_gray
                                    }

                                    onClicked: {
                                        supervisor.writelog("[QML] MAP PAGE (ANNOT) -> PASS TO DRAWING")
                                        map.init();
                                        map.setViewer("annot_drawing");
                                        loader_menu.sourceComponent = menu_annot_draw;
                                    }
                                }
                            }
                        }
                        Rectangle{
                            width: 100
                            height: 60
                            radius: 5
                            DropShadow{
                                anchors.fill: parent
                                radius: 6
                                color: color_light_gray
                                source: parent
                            }
                            Rectangle{
                                width: 100
                                height: 60
                                radius: 5
                                color: color_gray
                                border.width: 1
                                border.color: "white"
                                Text{
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "위치지정"
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed:{
                                        parent.color = color_mid_gray
                                    }
                                    onReleased: {
                                        parent.color = color_gray
                                    }

                                    onClicked: {
                                        supervisor.writelog("[QML] MAP PAGE (ANNOT) -> PASS TO OBJECT")
                                        map.init();
                                        map.setViewer("annot_object");
                                        loader_menu.sourceComponent = menu_annot_object;
                                    }
                                }
                            }
                        }
                        Rectangle{
                            width: 90
                            height: 60
                            radius: 5
//                            enabled: supervisor.isExistTravelRaw(supervisor.getMapname())||supervisor.isExistTravelEdited(supervisor.getMapname())

                            DropShadow{
                                anchors.fill: parent
                                radius: 6
                                color: color_light_gray
                                source: parent
                            }
                            Rectangle{
                                width: 90
                                height: 60
                                radius: 5
                                color: color_gray
                                border.width: 1
                                border.color: "white"
                                Text{
                                    text: "이동경로"
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed:{
                                        parent.color = color_mid_gray
                                    }
                                    onReleased: {
                                        parent.color = color_gray
                                    }

                                    onClicked: {
                                        supervisor.writelog("[QML] MAP PAGE (ANNOT) -> PASS TO TRAVELLINE")
                                        map.init();
                                        map.setViewer("annot_tline");
                                        loader_menu.sourceComponent = menu_annot_tline;
                                    }
                                }
                            }
                        }
                    }
                }

                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    Grid{
                        anchors.horizontalCenter: parent.horizontalCenter
                        rows: 4
                        columns: 3
                        spacing: 10
                        horizontalItemAlignment: Grid.AlignHCenter
                        verticalItemAlignment: Grid.AlignVCenter
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "맵 이름"
                            width: 150
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: ":"
                        }
                        Text{
                            id: text_map_name
                            width: 150
                            horizontalAlignment: Text.AlignHCenter
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: supervisor.getMapname();
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "가로길이"
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: ":"
                        }
                        Text{
                            id: text_map_width
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: supervisor.getMapWidth() + " px";
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "세로길이"
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: ":"
                        }
                        Text{
                            id: text_map_height
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: supervisor.getMapHeight() + " px";
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "단위크기"
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: ":"
                        }
                        Text{
                            id: text_map_gridwidth
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: supervisor.getGridWidth().toFixed(2) + " m";
                        }
                    }
                    Rectangle{
                        width: parent.width
                        height: 1
                        color: color_gray
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Grid{
                        rows: 6
                        columns: 3
                        spacing: 10
                        horizontalItemAlignment: Grid.AlignHCenter
                        verticalItemAlignment: Grid.AlignVCenter

                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "대기위치"
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: ":"
                        }
                        Text{
                            id: text_resting_num
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: supervisor.getLocationName(0,"Resting");
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "충전위치"
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: ":"
                        }
                        Text{
                            id: text_charging_num
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: supervisor.getLocationName(0,"Charging");
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "서빙위치"
                            width: 150
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: ":"
                        }
                        Text{
                            id: text_serving_num
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            width: 150
                            horizontalAlignment: Text.AlignHCenter
                            text: supervisor.getLocationNum("Serving") + " 개";
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "가상벽 개수"
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: ":"
                        }
                        Text{
                            id: text_object_num
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: supervisor.getObjectNum() + " 개";
                        }
                    }
                }
            }

            //prev, next button
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                spacing: 30
                PageIndicator{
                    id: indicator_annot
                    count: 8
                    currentIndex: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    delegate: Rectangle{
                        implicitWidth: index===indicator_annot.currentIndex?10:8
                        implicitHeight: implicitWidth
                        anchors.verticalCenter: parent.verticalCenter
                        radius: width
                        color: index===indicator_annot.currentIndex?"black":"#d0d0d0"
                        Behavior on color{
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Rectangle{
                        id: btn_prev_0
                        width: 180
                        height: 60
                        radius: 10
                        color:"transparent"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "이전"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                supervisor.writelog("[QML] MAP PAGE (ANNOT) -> PREV (BACKPAGE)")
                                map_mode = 0;
                            }
                        }
                    }
                    Rectangle{
                        id: btn_next_0
                        width: 180
                        height: 60
                        radius: 10
                        color: "black"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "다음"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                supervisor.writelog("[QML] MAP PAGE (ANNOT) -> NEXT (ROTATE)")
                                map.setTool("move");
                                map.setViewer("annot_rotate");
                                loader_menu.sourceComponent = menu_annot_rotate;
                            }
                        }
                    }
                }
            }
        }
    }

    Component{
        id: menu_annot_rotate
        Item{
            id: menu_load_rotate
            objectName: "menu_load_rotate"
            width: rect_menus.width
            height: rect_menus.height

            function valuezero(){
                slider_rotate.value = 0;
            }

            Component.onCompleted: {

                help_image.source = "video/rotate_help.gif"
                if(supervisor.getSetting("ROBOT_SW","use_help") === "true"){
                    popup_help.open();
                }
            }

            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }
            Rectangle{
                id: rect_annot_state
                width: parent.width
                height: 50
                anchors.top: parent.top
                anchors.topMargin: 2
                color: "#4F5666"
                Text{
                    anchors.centerIn: parent
                    color: "white"
                    font.family: font_noto_b.name
                    font.pixelSize: 20
                    text: "1. 맵 회전"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
//            Rectangle{
//                id: btn_load_map
//                width: 100
//                height: 40
//                radius: 5
//                anchors.top: rect_annot_state.bottom
//                anchors.topMargin: 30
//                anchors.left: parent.left
//                anchors.leftMargin: 30
//                color: "black"
//                Text{
//                    anchors.centerIn: parent
//                    text: "Load"
//                    color: "white"
//                    font.family: font_noto_r.name
//                    font.pixelSize: 15
//                }
//                MouseArea{
//                    anchors.fill: parent
//                    onClicked:{
//                        fileload.open();
//                    }
//                }
//            }

            Rectangle{
                id: rect_annot_map_name
                width: parent.width*0.9
                radius: 5
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.top: btn_load_map.bottom
//                anchors.topMargin: 20
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 50
                color: "white"
                Text{
                    anchors.centerIn: parent
                    color: "#282828"
                    font.family: font_noto_b.name
                    font.pixelSize: 20
                    text: is_init_state?"맵 이름 : " + map.map_name:"맵 이름 : " + supervisor.getMapname();
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id: rect_annot_box44
                width: parent.width*0.9
                height: 50
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_map_name.bottom
                anchors.topMargin: 10
                Text{
                    text: "회전"
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                }
                Rectangle{
                    id: rect_rotate_clear
                    width: 50
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: slider_rotate.left
                    anchors.rightMargin: 10
                    color: "black"
                    radius: 5
                    Text{
                        anchors.centerIn: parent
                        text: "초기화"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: "white"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            map.rotate("clear");
                            slider_rotate.value = 0;
                        }
                    }
                }

                Slider {
                    id: slider_rotate
                    x: 300
                    y: 330
                    value: 0
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 30
                    width: 170
                    height: 18
                    from: -180
                    to : 180
                    property var angle_init: 0
                    onValueChanged: {
                        if(pressed){
                            map.rotate(value - angle_init);
                            print("slider rotate : ",value,angle_init,value-angle_init);

                        }
                    }
                    onPressedChanged: {
                        if(pressed){
                            angle_init = value;
                        }else{
                            //released
                            angle_init = 0;
                            map.rotate(value - angle_init);
//                                    print(value, angle_init);
                        }
                    }

                }
            }

            Timer{
                id: timer_rotate
                running: false
                repeat: true
                interval: 100
                property bool isplus: false
                onTriggered: {
                    if(isplus){
                        slider_rotate.value++;
                        map.rotate("cw");
                    }else{
                        slider_rotate.value--;
                        map.rotate("ccw");
                    }
                }
            }
            Rectangle{
                id: rect_annot_box55
                width: parent.width*0.9
                height: 50
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_box44.bottom
                anchors.topMargin: 10
                Text{
                    text: "회전 (1도단위)"
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                }

                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 60
                    spacing: 20
                    Rectangle{
                        width: 80
                        height: 30
                        color: "black"
                        radius: 5
                        Text{
                            anchors.centerIn: parent
                            text: "반시계방향"
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                slider_rotate.value--;
                                map.rotate("ccw");
                            }
                            onPressAndHold: {
                                timer_rotate.isplus = false;
                                timer_rotate.start();
                            }
                            onReleased: {
                                timer_rotate.stop();
                            }
                        }
                    }
                    Rectangle{
                        width: 80
                        height: 30
                        color: "black"
                        radius: 5
                        Text{
                            anchors.centerIn: parent
                            text: "시계방향"
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                slider_rotate.value++;
                                map.rotate("cw");
                            }
                            onPressAndHold: {
                                timer_rotate.isplus = true;
                                timer_rotate.start();
                            }
                            onReleased: {
                                timer_rotate.stop();
                            }
                        }
                    }
                }

            }
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                spacing: 30
                PageIndicator{
                    id: indicator_annot
                    count: 8
                    currentIndex: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    delegate: Rectangle{
                        implicitWidth: index===indicator_annot.currentIndex?10:8
                        implicitHeight: implicitWidth
                        anchors.verticalCenter: parent.verticalCenter
                        radius: width
                        color: index===indicator_annot.currentIndex?"black":"#d0d0d0"
                        Behavior on color{
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Rectangle{
                        id: btn_prev_0
                        width: 180
                        height: 60
                        radius: 10
                        color:"transparent"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "이전"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                supervisor.writelog("[QML] MAP PAGE (ANNOT) -> PREV (ROTATE)")
                                map.init();
                                map.setViewer("none");
                                loader_menu.sourceComponent = menu_annot_state;
                            }
                        }
                    }
                    Rectangle{
                        id: btn_next_0
                        width: 180
                        height: 60
                        radius: 10
                        color: "black"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "다음"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                //변경한게 있으면(drawing or rotate)
                                if(slider_rotate.value != 0){
                                    supervisor.writelog("[QML] MAP PAGE (ANNOT) -> NEXT (DRAWING) ROTATE CHANGED : "+Number(slider_rotate.value.toFixed(1)))
                                    edit_flag = true;
                                    supervisor.setAnnotEditFlag(true);
                                    popup_save_rotated.open();
                                }else if(map.map_type == "RAW"){
                                    //raw파일이었으면
                                    popup_save_rotated.open();
                                    supervisor.writelog("[QML] MAP PAGE (ANNOT) -> NEXT (DRAWING) NO EDITFILE")
                                }else{
                                    supervisor.writelog("[QML] MAP PAGE (ANNOT) -> NEXT (DRAWING)")
                                    //아무 변경이 없으면
                                    map.init();
                                    map.setViewer("annot_drawing")
                                    loader_menu.sourceComponent = menu_annot_draw;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component{
        id: menu_annot_draw
        Item{
            id: menu_load_edit
            objectName: "menu_load_edit"
            width: rect_menus.width
            height: rect_menus.height

            Component.onCompleted: {
                help_image.source = "video/draw_help.gif"
                if(supervisor.getSetting("ROBOT_SW","use_help") === "true"){
                    popup_help.open();
                }
            }
            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }
            Rectangle{
                id: rect_annot_state
                width: parent.width
                height: 50
                anchors.top: parent.top
                anchors.topMargin: 2
                color: "#4F5666"
                Text{
                    anchors.centerIn: parent
                    color: "white"
                    font.family: font_noto_b.name
                    font.pixelSize: 20
                    text: "2. 노이즈 제거"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Row{
                spacing: 30
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 30
                anchors.right: parent.right
                anchors.rightMargin: 30
                Rectangle{
                    id: btn_undo
                    width: 40
                    height: 40
                    radius: 40
                    color: enabled?"#282828":"#D0D0D0"
                    Image{
                        anchors.centerIn: parent
                        source: "icon/icon_undo.png"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : DRAWING UNDO")
                            map.drawing_undo();
                        }
                    }
                }
                Rectangle{
                    id: btn_redo
                    width: 40
                    height: 40
                    radius: 40
                    color: enabled?"#282828":"#D0D0D0"
                    Image{
                        anchors.centerIn: parent
                        source: "icon/icon_redo.png"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : DRAWING REDO")
                            map.drawing_redo();
                        }
                    }
                }
            }

            Timer{
                running: true
                repeat: true
                interval: 500
                triggeredOnStart: true
                onTriggered: {
                    map.checkDrawing();
                    if(map.is_drawing_undo)
                        btn_undo.enabled = true;
                    else
                        btn_undo.enabled = false;

                    if(map.is_drawing_redo)
                        btn_redo.enabled = true;
                    else
                        btn_redo.enabled = false;
                }
            }

            Rectangle{
                id: rect_annot_box
                width: parent.width - 60
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 90
                color: "#e8e8e8"

                Row{
                    anchors.centerIn: parent
                    spacing: 20
                    Rectangle{
                        id: btn_move
                        width: 78
                        height: width
                        radius: width
                        border.width: map.tool=="move"?3:0
                        border.color: "#12d27c"
                        Column{
                            anchors.centerIn: parent
                            Image{
                                source: "icon/icon_move.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                text: "이동"
                                font.family: font_noto_r.name
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : DRAWING MOVE")
                                map.setTool("move")
                            }
                        }
                    }
                    Rectangle{
                        id: btn_draw
                        width: 78
                        height: width
                        radius: width
                        border.width: map.tool=="draw"?3:0
                        border.color: "#12d27c"
                        Column{
                            anchors.centerIn: parent
                            Image{
                                source: "icon/icon_draw.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                text: "그리기"
                                font.family: font_noto_r.name
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : DRAWING BRUSH")
                                map.setTool("draw");
                            }
                        }
                    }
                    Rectangle{
                        id: btn_erase
                        width: 78
                        height: width
                        radius: width
                        Column{
                            anchors.centerIn: parent
                            Image{
                                source: "icon/icon_erase.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                text: "초기화"
                                font.family: font_noto_r.name
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : DRAWING ERASE ALL")
                                map.clear("all");
                            }
                        }
                    }
                }

            }
            Rectangle{
                id: rect_annot_boxs
                width: parent.width - 60
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_box.bottom
                color: "#e8e8e8"
                Column{
                    anchors.centerIn: parent
                    spacing: 2
                    Rectangle{
                        id: rect_annot_box2
                        width: rect_annot_boxs.width
                        height: 50
                        color: "white"
                        Text{
                            text: "색상"
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 30
                        }
                        Row{
                            id: colorbar
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 30
                            spacing: 25
                            property color paintColor: "black"
                            Repeater{
                                model: [0,127,255]
                                Rectangle {
                                    id: red
                                    width: map.tool=="draw"?(map.cur_color===modelData?26:23):23
                                    height: width
                                    radius: width
                                    color: {
                                        if(modelData === 0){
                                            "#000000"
                                        }else if(modelData === 127){
                                            "#7f7f7f"
                                        }else{
                                            "#ffffff"
                                        }
                                    }
                                    border.color: map.tool=="draw"?(map.cur_color===modelData?"#12d27c":"black"):"black"
                                    border.width: map.tool=="draw"?(map.cur_color===modelData?3:1):1
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : DRAWING COLOR "+modelData)
                                            map.setTool("draw");
                                            map.setDrawingColor(modelData);
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Rectangle{
                        id: rect_annot_box3
                        width: rect_annot_boxs.width
                        height: 50
                        color: "white"
                        Text{
                            text: "브러시 사이즈"
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 30
                        }
                        Slider {
                            id: slider_brush
                            x: 300
                            y: 330
                            value: 3
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 30
                            width: 170
                            height: 18
                            from: 1
                            to : 50
                            onValueChanged: {
                                map.setDrawingWidth(value);
                                print("slider : " +value);
                            }
                            onPressedChanged: {
                                if(slider_brush.pressed){
                                    map.show_brush = true;

//                                    map.brushchanged();
                                }else{
                                    map.show_brush = false;
//                                    map.brushdisappear();
                                }
                            }
                        }
                    }
                }
            }


            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                spacing: 30
                PageIndicator{
                    id: indicator_annot
                    count: 8
                    currentIndex: 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    delegate: Rectangle{
                        implicitWidth: index===indicator_annot.currentIndex?10:8
                        implicitHeight: implicitWidth
                        anchors.verticalCenter: parent.verticalCenter
                        radius: width
                        color: index===indicator_annot.currentIndex?"black":"#d0d0d0"
                        Behavior on color{
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Rectangle{
                        id: btn_prev_0
                        width: 180
                        height: 60
                        radius: 10
                        color:"transparent"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "이전"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : PREV (ROTATE)")
                                map.init();
                                map.setViewer("annot_drawing");
                                loader_menu.sourceComponent = menu_annot_rotate;
                            }
                        }
                    }
                    Rectangle{
                        id: btn_next_0
                        width: 180
                        height: 60
                        radius: 10
                        color: "black"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "다음"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
//                                popup_save_edited.unshow_rotate();
                                map.checkEdit();
                                //변경한게 있으면(drawing or rotate)
                                if(map.is_edited){
                                    supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : NEXT (OBJECT) -> CANVAS SIZE > 0")
                                    supervisor.setAnnotEditFlag(true);
                                    edit_flag = true;
                                    popup_save_edited.open();
                                }else if(map.map_type == "RAW"){
                                    //raw파일이었으면
                                    supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : NEXT (OBJECT) -> NO EDITFILE")
                                    popup_save_edited.open();
                                }else{
                                    //아무 변경이 없으면
                                    supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : NEXT (OBJECTING)")
                                    map.init();
                                    map.setViewer("annot_objecting");
                                    loader_menu.sourceComponent = menu_annot_objecting;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component{
        id: menu_patrol
        Item{
            objectName: "menu_patrol"
            width: rect_menus.width
            height: rect_menus.height

            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }
            Rectangle{
                id: rect_annot_state
                width: parent.width
                height: 50
                anchors.top: parent.top
                anchors.topMargin: 2
                color: "#4F5666"
                Text{
                    anchors.centerIn: parent
                    color: "white"
                    font.family: font_noto_b.name
                    font.pixelSize: 20
                    text: "지정 순회"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Column{
                anchors.centerIn: parent
                spacing: 40
                Rectangle{
                    width: 200
                    height: 150
                    radius: 10
                    Column{
                        anchors.centerIn: parent
                        spacing: 10
                        Image{
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: "icon/icon_random.png"
                        }
                        Text{
                            font.family: font_noto_r.name
                            text: "서빙포인트\n랜덤 순회"
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            // start random patrol (serving)
                            if(supervisor.getuistate() === 2){//ROBOT READY
                                supervisor.writelog("[USER INPUT] PATROL : START RANDOM")
                                popup_patrol_list.open();
                                popup_patrol_list.mode = "random";
//                                supervisor.runRotateTables();
                            }
                            supervisor.writelog("[USER INPUT] PATROL : START RANDOM")
                            popup_patrol_list.open();
                            popup_patrol_list.mode = "random";
                        }
                    }
                }
                Rectangle{
                    width: 200
                    height: 150
                    radius: 10
                    Column{
                        anchors.centerIn: parent
                        spacing: 10
                        Image{
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: "icon/icon_random.png"
                        }
                        Text{
                            font.family: font_noto_r.name
                            text: "서빙포인트\n순회"
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            // start random patrol (serving)
                            if(supervisor.getuistate() === 2){//ROBOT READY
                                supervisor.writelog("[QML] PATROL : START SEQUENCE")
                                popup_patrol_list.open();
                                popup_patrol_list.mode = "sequence";
//                                supervisor.runRotateTables();
                            }
                            supervisor.writelog("[QML] PATROL : START SEQUENCE")
                            popup_patrol_list.open();
                            popup_patrol_list.mode = "sequence";
                        }
                    }
                }
            }
        }
    }
    Popup{
        id: popup_patrol_list
        property string mode: ""
        anchors.centerIn: parent
        width: 500
        height: 600
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }
        onOpened:{
            cols_patrol_bigmenu.visible = true;
            flickable_patrol.visible = false;
            update();
        }

        function update(){
            model_patrols.clear();
            print(supervisor.getLocationNum(""));
            for(var i=0; i<supervisor.getLocationNum(""); i++){
                model_patrols.append({"name":supervisor.getLocationName(i,""),"select":false});
            }
        }

        Rectangle{
            width: parent.width
            height: parent.height
            radius: 10
            color: color_dark_navy
            Column{
                anchors.centerIn: parent
                spacing: 20
                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 5
                    Text{
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        text: "순회할 위치를 선택해주세요."
                        color: "white"
                    }
                    Text{
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        text: popup_patrol_list.mode==="random"?"(현재 선택된 모드 : 랜덤)":"(현재 선택된 모드 : 순서대로)"
                        color: "white"
                    }
                }

                Column{
                    id: cols_patrol_bigmenu
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: true
                    spacing: 20
                    Rectangle{
                        width: 300
                        height: 100
                        radius: 10
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            text: "전체 위치"
                            font.pixelSize: 20
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                supervisor.clearRotateList();
                                for(var i=0; i<supervisor.getLocationNum("");i++){
                                    supervisor.setRotateList(supervisor.getLocationName(i,""));
                                }
                                supervisor.startPatrol(popup_patrol_list.mode,false);
                                popup_patrol_list.close();
                            }
                        }
                    }
                    Rectangle{
                        width: 300
                        height: 100
                        radius: 10
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            text: "서빙 위치"
                            font.pixelSize: 20
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                supervisor.clearRotateList();
                                for(var i=0; i<supervisor.getLocationNum("Serving");i++){
                                    supervisor.setRotateList(supervisor.getLocationName(i,"Serving"));
                                }
                                supervisor.startPatrol(popup_patrol_list.mode,false);
                                popup_patrol_list.close();
                            }
                        }
                    }
                    Rectangle{
                        width: 300
                        height: 100
                        radius: 10
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            text: "직접 선택"
                            font.pixelSize: 20
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                cols_patrol_bigmenu.visible = false;
                                flickable_patrol.visible = true;
                            }
                        }
                    }
                }

                Flickable{
                    id: flickable_patrol
                    width: popup_patrol_list.width
                    height: 330
                    visible: false
                    contentHeight: col_patlist.height
                    Column{
                        id: col_patlist
                        anchors.centerIn: parent
                        spacing: 10
                        Repeater{
                            model: ListModel{id:model_patrols}
                            Rectangle{
                                width: popup_patrol_list.width*0.6
                                height: 50
                                radius: 5
                                color: select?color_green:"white"
                                Text{
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    text: name
                                    font.pixelSize: 20
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        if(select)
                                            select = false;
                                        else
                                            select = true;
                                    }
                                }
                            }
                        }
                    }
                }

                Row{
                    visible: flickable_patrol.visible
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle{
                        width: 150
                        height: 100
                        radius: 30
                        color: "gray"
                        Text{
                            anchors.centerIn: parent
                            text: "취소"
                            font.family: font_noto_b.name
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                popup_patrol_list.close();
                            }
                        }
                    }
                    Rectangle{
                        width: 150
                        height: 100
                        radius: 30
                        color: "#d0d0d0"
                        Text{
                            anchors.centerIn: parent
                            text: "확인"
                            font.family: font_noto_b.name
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.clearRotateList();
                                for(var i=0; i<model_patrols.count; i++){
                                    if(model_patrols.get(i).select)
                                        supervisor.setRotateList(model_patrols.get(i).name);
                                }
                                supervisor.startPatrol(popup_patrol_list.mode,false);

                                popup_patrol_list.close();
                            }
                        }
                    }
                }
            }
        }
    }

    Popup{
        id: popup_location_number
        anchors.centerIn: parent
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        bottomPadding: 0
        background: Rectangle{
            anchors.fill: parent
            color: color_dark_gray
            opacity: 0.7
        }
        width: 1280
        height: 800
        clip: true
        property bool usegroup : false
        onOpened:{
            readSetting();
        }
        function init(){
            readSetting();
        }

        function readSetting(){
            print("READ SETTING!!!!!!!!!!!!!!!!!!!!!!");
            groups.clear();
            for(var i=0; i<supervisor.getLocationGroupNum(); i++){
                groups.append({"value":supervisor.getLocGroupname(i)});
                print("groups append : ", supervisor.getLocGroupname(i))
            }

            if(supervisor.getLocationGroupNum() > 1)
                usegroup = true;
            else
                usegroup = false;

            locations.clear();
            for(var i=0; i<supervisor.getLocationNum("Serving"); i++){
                locations.append({"name": supervisor.getLocationName(i,"Serving"),
                               "group":supervisor.getLocationGroupNum(i),
                               "number": supervisor.getLocationNumber(-1,i),
                                "number_table" : supervisor.getLocationGroupSize(supervisor.getLocationGroupNum(i)),
                                "call_id" : supervisor.getLocationCallID("Serving",i),
                               "error":false});
                print("locations append : ",i,supervisor.getLocationGroupNum(i),supervisor.getLocationGroupNum(i),supervisor.getLocationNumber(-1,i))
            }
            update();
        }

        function update(){
            if(supervisor.getLocationGroupNum() > 1)
                usegroup = true;
            else
                usegroup = false;

            details.clear();
            details.append({"type":"Charging","name":"Charging","call_id":supervisor.getLocationCallID("Charging",0)});
            details.append({"type":"Resting","name":"Resting","call_id":supervisor.getLocationCallID("Resting",0)});
            for(var i=0; i<locations.count; i++){
                details.append({"type":"Serving",
                                "name":locations.get(i).name,
                               "group":locations.get(i).group,
                               "number":locations.get(i).number,
                               "number_table":getgroupsize(locations.get(i).group),
                                "call_id":locations.get(i).call_id,
                               "error":locations.get(i).error});
                print("detail append : ",i, locations.get(i).group, locations.get(i).number, getgroupsize(locations.get(i).group))
            }
            checkLocationNumber();

            if(isError()){
                rect_title_pop.color = color_red
                btn_confirm_location.enabled = false;
            }else{
                btn_confirm_location.enabled = true;
                rect_title_pop.color = color_dark_navy

            }
        }
        function isError(){
            for(var i=0; i<details.count; i++){
                if(details.get(i).type === "Serving")
                    if(details.get(i).error)
                        return true;
            }
            return false;
        }

        function getgroupsize(group){
            var count = 0;
            for(var i=0; i<locations.count; i++){
                if(locations.get(i).group === group)
                    count++
            }
            return count
        }

        function groupchange(number, group){
            print(" group change ",number,group,locations.count);
            if(number > -1 && number < locations.count){
                locations.get(number-2).group = group;
                locations.get(number-2).number = 0;
            }
            update();
        }

        function tablechange(number, table){
            print("table change ",number,table)
            if(number > -1 && number < locations.count){
                locations.get(number-2).number = table;
            }
            update();
        }
        function update_callbell(){
            details.get(0).call_id = supervisor.getLocationCallID("Charging",0);
            details.get(1).call_id = supervisor.getLocationCallID("Resting",0);
            for(var i=2; i<details.count; i++){
                details.get(i).call_id = supervisor.getLocationCallID("Serving",i-2);
            }
        }

        function checkLocationNumber(){
            for(var i=0; i<details.count; i++){
                if(details.get(i).type === "Serving"){
                    if(details.get(i).number < 1){
                        details.get(i).error = true;
                    }else if(details.get(i).number > details.get(i).number_table){
                        tablechange(i,0);
                        details.get(i).error = true;
                        details.get(i).number = 0;
                    }else
                        details.get(i).error = false;
                }
            }
            for(var i=0; i<details.count; i++){
                if(details.get(i).type === "Serving"){
                    for(var j=i+1; j<details.count; j++){
                        if(details.get(j).type === "Serving"){
                            if(details.get(i).number === details.get(j).number && details.get(i).group===details.get(j).group){
                                details.get(i).error = true;
                                details.get(j).error = true;
                            }
                        }

                    }
                }
            }
            for(var i=0; i<details.count; i++){
                if(details.get(i).type === "Serving"){
                    for(var j=i+1; j<details.count; j++){
                        if(details.get(j).type === "Serving"){
                            if(details.get(i).call_id === "")
                                continue;
                            if(details.get(i).call_id === details.get(j).call_id){
                                details.get(i).error = true;
                                details.get(j).error = true;
                            }
                        }

                    }
                }

            }
        }
//        ListModel{
//            id: tables_temp
//        }
        ListModel{
            id: locations
        }

        ListModel{
            id: groups
        }
        Rectangle{
            width: 800
            height: 500
            radius: 20
            anchors.centerIn: parent
            color: "transparent"
            Rectangle{
                width: parent.width
                height: parent.height
                radius: 20
                clip: true
                Rectangle{
                    id: rect_title_pop
                    width: parent.width
                    height: 60
                    radius: parent.radius
                    clip: true
                    color: color_dark_navy
                    Rectangle{
                        width: parent.width
                        height: parent.radius
                        anchors.bottom: parent.bottom
                        color: parent.color
                    }
                    Text{
                        anchors.centerIn: parent
                        text: "서빙위치 상세 지정"
                        font.pixelSize: 20
                        font.family: font_noto_r.name
                        color: "white"
                    }
                }
                Row{
                    id: row_ttle_popu
                    spacing: 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: rect_title_pop.bottom
                    anchors.topMargin: 10
                    Rectangle{
                        width: 150
                        height: 30
                        color: color_navy
                        visible: popup_location_number.usegroup
                        Text{
                            anchors.centerIn: parent
                            text: "그룹"
                            font.family: font_noto_r.name
                            color: "white"
                        }
                    }
                    Rectangle{
                        width: 200
                        height: 30
                        color: color_navy
                        Text{
                            anchors.centerIn: parent
                            text: "이름"
                            font.family: font_noto_r.name
                            color: "white"
                        }
                    }
                    Rectangle{
                        width: 180
                        height: 30
                        color: color_navy
                        Text{
                            anchors.centerIn: parent
                            text: "테이블 번호(중복x)"
                            font.family: font_noto_r.name
                            color: "white"
                        }
                    }
                    Rectangle{
                        width: 200
                        height: 30
                        color: color_navy
                        Text{
                            anchors.centerIn: parent
                            text: "호출벨"
                            font.family: font_noto_r.name
                            color: "white"
                        }
                    }
                }


                Component{
                    id: detaillocCompo
                    Item{
                        width: parent.width
                        height: 40
                        Component.onCompleted: {
                            combo_number.model.append({"value":"지정 안됨"})
                            for(var i=0; i<number_table; i++){
                               combo_number.model.append({"value":(i+1).toString()});
                            }
                            print("COMPO UPDATE : ",index,combo_number.model.count);
                        }

                        Row{
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 2
                            ComboBox{
                                id: combo_group
                                visible: popup_location_number.usegroup && type ==="Serving"
                                width: 150
                                height: 40
                                model: groups
                                currentIndex: group
                                onCurrentIndexChanged: {
                                    if(focus){
                                        print("group changed "+currentIndex);
                                        popup_location_number.groupchange(index,currentIndex);
                                    }
                                }
                            }
                            TextField{
                                id: tx_name
                                text: name
                                width:type==="Serving"?200:popup_location_number.use_group?200+150+180:200+180
                                height: 40
                                font.family: font_noto_r.name
                                font.pixelSize: 20
                                horizontalAlignment: Text.AlignHCenter
                                onFocusChanged: {
                                    keyboard.owner = tx_name;
                                    tx_name.selectAll();
                                    if(focus){
                                        keyboard.open();
                                    }else{
                                        keyboard.close();
                                        tx_name.select(0,0);
                                    }
                                }
                                onTextChanged: {
                                    print("set name to "+text);
                                    name = text;
                                    if(index > 1)
                                        locations.get(index-2).name = name;
                                }
                            }
                            Image{
                                visible: error && type ==="Serving"
                                source: "icon/icon_error.png"
                                width: 40
                                height: 38
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            ComboBox{
                                id: combo_number
                                width : error?180-42:180
                                height: 40
                                visible: type ==="Serving"
                                model: ListModel{}
                                currentIndex: number==-1?0:number
                                onCurrentIndexChanged: {
                                    if(focus){
                                        print("table focus change ",index,currentIndex)
                                        popup_location_number.tablechange(index,currentIndex);
                                    }
                                }
                            }
                            Rectangle{
                                width : 100
                                height: 40
                                Text{
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    text: call_id==""?" - ":call_id
                                }
                            }
                            Rectangle{
                                width : 100
                                height: 40
                                radius: 5
                                color: "black"
                                Text{
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    text:"설정"
                                    color: "white"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        popup_add_callbell.callid = index;
                                        popup_add_callbell.open();
                                    }
                                }
                            }
                        }
                    }
                }

                Flickable{
                    anchors.top: row_ttle_popu.bottom
                    anchors.topMargin: 2
                    width: parent.width
                    height: 300
                    clip: true
                    contentHeight: list_location_detail.height
                    ScrollBar.vertical: ScrollBar{
                        width: 25
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        policy: ScrollBar.AlwaysOn
                    }
                    ListView{
                        id: list_location_detail
                        width: parent.width
                        height: parent.height
                        spacing: 2
                        clip: true
                        anchors.horizontalCenter: parent.horizontalCenter
                        delegate: detaillocCompo
                        model:ListModel{id:details}
                    }
                }

                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 30
                    spacing: 30
                    Rectangle{
                        width: 180
                        height: 60
                        radius: 5
                        border.width: 1
                        color: "black"
                        Text{
                            anchors.centerIn: parent
                            text: "그룹 추가"
                            color: "white"
                            font.family: font_noto_r.name
                            font.pixelSize: 20
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                popup_add_location_group.open();
                            }
                        }
                    }
                    Rectangle{
                        width: 180
                        height: 60
                        radius: 5
                        border.width: 1
                        Text{
                            anchors.centerIn: parent
                            text: "취소"
                            font.family: font_noto_r.name
                            font.pixelSize: 20
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                popup_location_number.close();
                            }
                        }
                    }
                    Rectangle{
                        id: btn_confirm_location
                        width: 180
                        height: 60
                        radius: 5
                        enabled: false
                        color: enabled?color_green:color_red
                        Text{
                            anchors.centerIn: parent
                            text: btn_confirm_location.enabled?"확인":"오류가 있습니다"
                            color: "white"
                            font.family: font_noto_r.name
                            font.pixelSize: 20
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                for(var i=0; i<details.count-2; i++){
                                    supervisor.setLocation(i,details.get(i+2).name,details.get(i+2).group,details.get(i+2).number);
                                }
                                loader_menu.item.update();
                                popup_location_number.close();
                            }
                        }
                    }
                }
            }
        }
        Popup{
            id: popup_add_callbell
            anchors.centerIn: parent
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }
            width : 500
            height: 200
            property var callid: 0
            onOpened: {
                supervisor.setCallbell(callid);
            }
            onClosed: {
                supervisor.setCallbell(-1);
            }

            Rectangle{
                width: parent.width
                height: parent.height
                radius: 20
                color: color_dark_navy
                Text{
                    anchors.centerIn: parent
                    text: "변경하실 호출벨을 눌러주세요."
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                    color: "white"
                }
            }
        }

    }

    Component{
        id: menu_annot_velmap
        Item{
            objectName: "menu_velmap"
            width: rect_menus.width
            height: rect_menus.height

            Component.onCompleted: {
                map.loadmap(supervisor.getMapname(),"mapvel");
            }
            Component.onDestruction: {

            }

            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }
            Rectangle{
                id: rect_annot_state
                width: parent.width
                height: 50
                anchors.top: parent.top
                anchors.topMargin: 2
                color: "#4F5666"
                Text{
                    anchors.centerIn: parent
                    color: "white"
                    font.family: font_noto_b.name
                    font.pixelSize: 20
                    text: "속도구간 설정"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Row{
                id: row_redo
                spacing: 30
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 30
                anchors.right: parent.right
                anchors.rightMargin: 30
                Rectangle{
                    id: btn_undo
                    width: 40
                    height: 40
                    radius: 40
                    color: enabled?"#282828":"#D0D0D0"
                    Image{
                        anchors.centerIn: parent
                        source: "icon/icon_undo.png"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : TravelLine -> UNDO")
                            map.drawing_undo();
                        }
                    }
                }
                Rectangle{
                    id: btn_redo
                    width: 40
                    height: 40
                    radius: 40
                    color: enabled?"#282828":"#D0D0D0"
                    Image{
                        anchors.centerIn: parent
                        source: "icon/icon_redo.png"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : TravelLine -> REDO")
                            map.drawing_redo();
                        }
                    }
                }
            }
            Timer{
                running: true
                repeat: true
                interval: 500
                triggeredOnStart: true
                onTriggered: {
                    map.checkEdit();
                    if(map.is_drawing_undo)
                        btn_undo.enabled = true;
                    else
                        btn_undo.enabled = false;

                    if(map.is_drawing_redo)
                        btn_redo.enabled = true;
                    else
                        btn_redo.enabled = false;

                }
            }

            Rectangle{
                id: rect_annot_box
                width: parent.width - 60
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: row_redo.bottom
                anchors.topMargin: 15
                color: "#e8e8e8"
                Row{
                    anchors.centerIn: parent
                    spacing: 20
                    Item_button{
                        id: btn_move
                        width: 80
                        shadow_color: color_gray
                        highlight: map.tool=="move"
                        icon: "icon/icon_move.png"
                        name: "이동"
                        MouseArea{
                            anchors.fill: parent
                            onPressed: {
                                parent.pressed();
                            }
                            onReleased:{
                                parent.released();
                            }

                            onClicked: {
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : VelMap -> MOVE")
                                map.setTool("move");
                            }
                        }
                    }
                    Item_button{
                        id: btn_draw
                        width: 80
                        shadow_color: color_gray
                        highlight: map.tool=="draw" || map.tool=="erase" || map.tool=="draw_rect"
                        icon: "icon/icon_draw.png"
                        name: "수정"
                        MouseArea{
                            anchors.fill: parent
                            onPressed: {
                                parent.pressed();
                            }
                            onReleased:{
                                parent.released();
                            }
                            onClicked: {
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : VelMap -> BRUSH")
                                map.setTool("draw");
                                select_preset = 1;
                                map.setDrawingColor(100);
                                map.setDrawingWidth(slider_brush.value);
                            }
                        }
                    }
                    Item_button{
                        id: btn_erase
                        width: 80
                        shadow_color: color_gray
                        icon: "icon/icon_trashcan.png"
                        name: "초기화"
                        overcolor: true
                        MouseArea{
                            anchors.fill: parent
                            onPressed: {
                                parent.pressed();
                            }
                            onReleased:{
                                parent.released();
                            }
                            onClicked: {
                                map.clear("all");
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : VelMap -> Clear")
                            }
                        }
                    }
                }
            }
            Rectangle{
                id: rect_annot_boxs
                width: parent.width - 60
                height: 200
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_box.bottom
//                anchors.topMargin: 50
                color: "#e8e8e8"
                Column{
                    anchors.centerIn: parent
                    spacing: 4
                    Text{
                        visible: map.tool == "move"
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_b.name
                        font.pixelSize: 20
                        text: "   ** 속도구간 설정 안내 **   ";
                    }
                    Rectangle{
                        visible: map.tool == "move"
                        width: 10
                        height: 20
                        color: "transparent"
                    }

                    Text{
                        visible: map.tool == "move"
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: color_red
                        text: "로봇이 이동 중 해당 영역에 진입하면 속도가 줄어듭니다.";
                    }
                    Text{
                        visible: map.tool == "move"
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: color_red
                        text: "속도는 2단계(느리게, 매우느리게)로 나뉩니다.";
                    }
                    Text{
                        visible: map.tool == "move"
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: color_red
                        text: "각 단계의 속도는 SETTING에서 변경 가능합니다.";
                    }
                    Text{
                        visible: map.tool == "move"
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: color_red
                        text: "구간을 더 색칠하거나 지우신 후에는 반드시 저장을 눌러주세요.";
                    }

                    Rectangle{
                        id: rect_annot_tline_2
                        width: rect_annot_boxs.width
                        height: 60
                        visible: map.tool === "draw" || map.tool === "draw_rect" || map.tool === "erase"
                        color: "white"
                        Row{
                            anchors.centerIn: parent
                            spacing: 20

                            Rectangle{
                                width: 100
                                height: 50
                                color: "transparent"
                                Row{
                                    anchors.centerIn: parent
                                    spacing: 10
                                    Rectangle{
                                        width: 50
                                        height: width
                                        radius: width
                                        color: map.tool === "draw"?color_green:color_gray
                                        Image{
                                            source: "icon/icon-drawing-free drawing.png"
                                            width: 30
                                            height: 30
                                            anchors.centerIn: parent
                                        }
                                    }
                                    Text{
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.family: font_noto_r.name
                                        color: map.tool === "draw"?"black":color_gray
                                        text: "그리기"
                                    }
                                }

                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        map.setTool("draw");
                                    }
                                }
                            }

                            Rectangle{
                                width: 100
                                height: 50
                                color: "transparent"
                                Row{
                                    anchors.centerIn: parent
                                    spacing: 10
                                    Rectangle{
                                        width: 50
                                        height: width
                                        radius: width
                                        color: map.tool==="draw_rect"? color_green: color_gray
                                        Image{
                                            source: "icon/icon-drawing-square.png"
                                            width: 30
                                            height: 30
                                            anchors.centerIn: parent
                                        }
                                    }
                                    Text{
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.family: font_noto_r.name
                                        color: map.tool === "draw_rect"?"black":color_gray
                                        text: "사각형"
                                    }
                                }

                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        map.setTool("draw_rect");
                                    }
                                }
                            }
                            Rectangle{
                                width: 100
                                height: 50
                                color: "transparent"
                                Row{
                                    anchors.centerIn: parent
                                    spacing: 10
                                    Rectangle{
                                        width: 50
                                        height: width
                                        radius: width
                                        color: map.tool === "erase"?color_green:color_gray
                                        Image{
                                            source: "icon/icon_erase.png"
                                            width: 30
                                            height: 30
                                            anchors.centerIn: parent
                                            ColorOverlay{
                                                source: parent
                                                anchors.fill: parent
                                                color: "white"
                                            }
                                        }
                                    }
                                    Text{
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.family: font_noto_r.name
                                        color: map.tool === "erase"?"black":color_gray
                                        text: "지우개"
                                    }
                                }

                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        map.setTool("erase");
                                    }
                                }
                            }

                        }
                    }
                    Rectangle{
                        id: rect_annot_tline_1
                        width: rect_annot_boxs.width
                        height: 60
                        visible: map.tool === "draw" || map.tool === "draw_rect"
                        color: "white"
                        Row{
                            anchors.centerIn: parent
                            spacing: 20
                            Rectangle{
                                width: 130
                                height: 50
                                color: "transparent"
                                Row{
                                    anchors.centerIn: parent
                                    spacing: 10
                                    Rectangle{
                                        width: 50
                                        height: width
                                        radius: width
                                        color: select_preset===1?color_yellow_rect:color_gray
                                        Image{
                                            source: "icon/icon_connect_error.png"
                                            width: 28
                                            height: 25
                                            anchors.centerIn: parent
                                            ColorOverlay{
                                                source: parent
                                                anchors.fill: parent
                                                color: "white"
                                            }
                                        }
                                    }
                                    Text{
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.family: font_noto_r.name
                                        color: select_preset===1?"black":color_gray
                                        text: "느리게"
                                    }
                                }

                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        select_preset = 1;
                                        map.setDrawingColor(100);
                                        map.setDrawingWidth(slider_brush.value);
                                    }
                                }
                            }
                            Rectangle{
                                width: 130
                                height: 50
                                color: "transparent"
                                Row{
                                    anchors.centerIn: parent
                                    spacing: 10
                                    Rectangle{
                                        width: 50
                                        height: width
                                        radius: width
                                        color: select_preset===2?color_red:color_gray
                                        Image{
                                            source: "icon/icon_error.png"
                                            width: 30
                                            height: 30
                                            anchors.centerIn: parent
                                            ColorOverlay{
                                                source: parent
                                                anchors.fill: parent
                                                color: "white"
                                            }
                                        }
                                    }
                                    Text{
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.family: font_noto_r.name
                                        color: select_preset===2?"black":color_gray
                                        text: "매우 느리게"
                                    }
                                }

                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        select_preset = 2;
                                        map.setDrawingColor(200);
                                        map.setDrawingWidth(slider_brush.value);
                                    }
                                }
                            }
                        }
                    }
                    Rectangle{
                        id: rect_annot_box3
                        width: rect_annot_boxs.width
                        height: 60
                        color: "white"
                        visible: map.tool === "draw" || map.tool === "erase" || map.tool === "draw_rect"
                        Text{
                            text: "브러시 사이즈"
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 30
                        }
                        Slider {
                            id: slider_brush
                            x: 300
                            y: 330
                            value: 20
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 30
                            width: 170
                            height: 18
                            from: 5
                            to : 50
                            onValueChanged: {
                                map.setDrawingWidth(value)
                            }
                            onPressedChanged: {
                                if(slider_brush.pressed){
                                    map.show_brush = true;
                                }else{
                                    map.show_brush = false;
                                }
                            }
                        }
                    }
                }
            }
            Rectangle{
                id: btn_save_map
                width: 200
                height: 80
                radius: 5
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_boxs.bottom
                anchors.topMargin : 30
                color: "black"
                Text{
                    anchors.centerIn: parent
                    text: "저장"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        popup_save_travelline.save_mode = "velmap";
                        popup_save_travelline.open();
                    }
                }
            }
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                spacing: 30
                PageIndicator{
                    id: indicator_annot
                    count: 8
                    currentIndex: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    delegate: Rectangle{
                        implicitWidth: index===indicator_annot.currentIndex?10:8
                        implicitHeight: implicitWidth
                        anchors.verticalCenter: parent.verticalCenter
                        radius: width
                        color: index===indicator_annot.currentIndex?"black":"#d0d0d0"
                        Behavior on color{
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Rectangle{
                        id: btn_prev_0
                        width: 180
                        height: 60
                        radius: 10
                        color:"transparent"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "이전"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : PREV (OBJECT/LOCATION)")
                                map.init();
                                map.setViewer("annot_object");
                                loader_menu.sourceComponent = menu_annot_object;
                            }
                        }
                    }
                    Rectangle{
                        id: btn_next_0
                        width: 180
                        height: 60
                        radius: 10
                        color: "black"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "다음"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                supervisor.writelog("[QML] MAP PAGE (ANNOT) -> PASS TO TRAVELLINE")
                                map.init();
                                map.setViewer("annot_tline");
                                map.show_connection = false;
                                loader_menu.sourceComponent = menu_annot_tline;
                            }
                        }
                    }
                }
            }
        }
    }

    Component{
        id: menu_annot_tline
        Item{
            objectName: "menu_tline"
            width: rect_menus.width
            height: rect_menus.height

            Component.onCompleted: {
                if(supervisor.isExistTravelEdited(supervisor.getMapname())){
                    supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : travel_edited.png Exist.")
                    map.loadmap(supervisor.getMapname(),"T_EDIT");
                    btn_load_raw_map.activated = false;
                    btn_load_map.activated = true;
                }else{
                    supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : travel_edited.png not Exist.")
                    map.loadmap(supervisor.getMapname(),"T_RAW");
                    btn_load_raw_map.activated = true;
                    btn_load_map.activated = false;
                }
                help_image.source = "video/tline_help.gif"
                if(supervisor.getSetting("ROBOT_SW","use_help") === "true"){
                    popup_help.open();
                }
//                map.brush_size = slider_brush.value;
            }
            Component.onDestruction: {
//                map.setViewer("none");
//                map.init();
//                map.loadmap(supervisor.getMapname(),"EDITED");
//                map.show_connection = false;
            }

            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }
            Rectangle{
                id: rect_annot_state
                width: parent.width
                height: 50
                anchors.top: parent.top
                anchors.topMargin: 2
                color: "#4F5666"
                Text{
                    anchors.centerIn: parent
                    color: "white"
                    font.family: font_noto_b.name
                    font.pixelSize: 20
                    text: "이동경로 설정"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Row{
                id: load_btns
                spacing: 10
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 30
                anchors.left: parent.left
                anchors.leftMargin: 30
                Rectangle{
                    id: btn_load_raw_map
                    width: 100
                    height: 40
                    radius: 5
                    color: "black"
                    border.color: color_green
                    border.width: activated?3:0
                    property bool activated: false
                    Text{
                        anchors.centerIn: parent
                        text: "기본파일"
                        color: "white"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : TravelLine -> SET RAW FILE")
                            map.loadmap(supervisor.getMapname(),"T_RAW");
                            map.clear("spline");
                            map.clear("all");
                            btn_load_raw_map.activated = true;
                            btn_load_map.activated = false;
                        }
                    }
                }
                Rectangle{
                    id: btn_load_map
                    width: 100
                    height: 40
                    radius: 5
                    border.color: color_green
                    border.width: activated?3:0
                    property bool activated: false
                    enabled: false
                    color: enabled?"black":color_gray
                    Text{
                        anchors.centerIn: parent
                        text: "수정된파일"
                        color: "white"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : TravelLine -> SET EDITED FILE")
                            map.loadmap(supervisor.getMapname(),"T_EDIT");
                            map.clear("spline");
                            map.clear("all");
                            btn_load_raw_map.activated = false;
                            btn_load_map.activated = true;
                        }
                    }
                }
            }


            Row{
                spacing: 30
                anchors.top: load_btns.top
                anchors.right: parent.right
                anchors.rightMargin: 30
                Rectangle{
                    id: btn_undo
                    width: 40
                    height: 40
                    radius: 40
                    color: enabled?"#282828":"#D0D0D0"
                    Image{
                        anchors.centerIn: parent
                        source: "icon/icon_undo.png"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : TravelLine -> UNDO")
                            map.drawing_undo();
                        }
                    }
                }
                Rectangle{
                    id: btn_redo
                    width: 40
                    height: 40
                    radius: 40
                    color: enabled?"#282828":"#D0D0D0"
                    Image{
                        anchors.centerIn: parent
                        source: "icon/icon_redo.png"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : TravelLine -> REDO")
                            map.drawing_redo();
                        }
                    }
                }
            }
            Timer{
                running: true
                repeat: true
                interval: 500
                triggeredOnStart: true
                onTriggered: {
                    map.checkEdit();
                    if(map.is_drawing_undo)
                        btn_undo.enabled = true;
                    else
                        btn_undo.enabled = false;

                    if(map.is_drawing_redo)
                        btn_redo.enabled = true;
                    else
                        btn_redo.enabled = false;

                    if(supervisor.isExistTravelEdited(supervisor.getMapname())){
                        btn_load_map.enabled = true;
                    }else{
                        btn_load_map.enabled = false;
                    }
                }
            }

            Rectangle{
                id: rect_annot_box
                width: parent.width - 60
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: load_btns.bottom
                anchors.topMargin: 15
                color: "#e8e8e8"
                Row{
                    anchors.centerIn: parent
                    spacing: 20
                    Item_button{
                        id: btn_move
                        width: 80
                        shadow_color: color_gray
                        highlight: map.tool=="move"
                        icon: "icon/icon_move.png"
                        name: "이동"
                        MouseArea{
                            anchors.fill: parent
                            onPressed: {
                                parent.pressed();
                            }
                            onReleased:{
                                parent.released();
                            }

                            onClicked: {
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : TravelLine -> MOVE")
                                map.setTool("move");
                                map.clear("spline");
                            }
                        }
                    }
                    Item_button{
                        id: btn_draw
                        width: 80
                        shadow_color: color_gray
                        highlight: (map.tool=="draw" || map.tool == "straight" || map.tool == "erase")
                        icon: "icon/icon_draw.png"
                        name: "수정"
                        MouseArea{
                            anchors.fill: parent
                            onPressed: {
                                parent.pressed();
                            }
                            onReleased:{
                                parent.released();
                            }
                            onClicked: {
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : TravelLine -> BRUSH")
                                map.setTool("draw");
                                map.clear("spline");
                                map.setDrawingColor(255);
                                map.setDrawingWidth(slider_brush.value);
                            }
                        }
                    }
                    Item_button{
                        id: btn_clear
                        width: 80
                        shadow_color: color_gray
                        icon: "icon/icon_trashcan.png"
                        name: "초기화"
                        overcolor: true
                        MouseArea{
                            anchors.fill: parent
                            onPressed: {
                                parent.pressed();
                            }
                            onReleased:{
                                parent.released();
                            }

                            onClicked: {
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : TravelLine -> CLEAR ALL")
                                map.init();
                                map.clear("spline");
                                map.clear("tline");
                                map.clear("all");
                            }
                        }
                    }
                }
            }
            Rectangle{
                id: rect_annot_boxs
                width: parent.width - 60
                height: cccc.height > 180? cccc.height:180
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_box.bottom
//                anchors.topMargin: 50
                color: "#e8e8e8"
                Column{
                    id: cccc
                    anchors.centerIn: parent
                    spacing: 2
                    Text{
                        visible: map.tool == "move"
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_b.name
                        font.pixelSize: 20
                        text: "   ** 이동경로 설정 안내 **   ";
                    }
                    Rectangle{
                        visible: map.tool == "move"
                        width: 10
                        height: 20
                        color: "transparent"
                    }

                    Text{
                        visible: map.tool == "move"
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: color_red
                        text: "로봇이 이동경로를 따라 이동합니다.";
                    }
                    Text{
                        visible: map.tool == "move"
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: color_red
                        text: "이동경로가 없는 부분은 최단거리로 이동합니다.";
                    }
                    Text{
                        visible: map.tool == "move"
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: color_red
                        text: "로봇이 자동으로 생성한 이동경로가 이상하다면 수정해주세요.";
                    }
                    Text{
                        visible: map.tool == "move"
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: color_red
                        text: "수정하신 후에는 반드시 저장을 눌러주세요.";
                    }

                    Column{
                        visible: map.tool === "draw" || map.tool === "straight" || map.tool === "dot_spline"|| map.tool === "erase"
                        anchors.horizontalCenter: parent.horizontalCenter
                        Rectangle{
                            id: rect_annot_tline_1
                            width: rect_annot_boxs.width
                            height: 60
                            color: "white"
                            Row{
                                anchors.centerIn: parent
                                spacing: 20
                                Rectangle{
                                    width: 100
                                    height: 50
                                    color: "transparent"
                                    Row{
                                        anchors.centerIn: parent
                                        spacing: 10
                                        Rectangle{
                                            width: 50
                                            height: width
                                            radius: width
                                            color: map.tool === "draw"?color_green:color_gray
                                            Image{
                                                source: "icon/icon-drawing-free drawing.png"
                                                width: 30
                                                height: 30
                                                anchors.centerIn: parent
                                            }
                                        }
                                        Text{
                                            anchors.verticalCenter: parent.verticalCenter
                                            font.family: font_noto_r.name
                                            color: map.tool === "draw"?"black":color_gray
                                            text: "그리기"
                                        }
                                    }

                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            map.clear("spline");
                                            map.setTool("draw");
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 100
                                    height: 50
                                    color: "transparent"
                                    Row{
                                        anchors.centerIn: parent
                                        spacing: 10
                                        Rectangle{
                                            width: 50
                                            height: width
                                            radius: width
                                            color: map.tool === "straight"?color_green:color_gray
                                            Shape{
                                                width: 30
                                                height: 30
                                                anchors.centerIn: parent
                                                ShapePath{
                                                    strokeColor: "white"
                                                    fillColor: "white"
                                                    capStyle: Qt.RoundCap
                                                    strokeWidth:4
                                                    startX: 30
                                                    startY:0
                                                    PathLine{
                                                        x: 0
                                                        y: 30
                                                    }
                                                }
                                            }
                                        }
                                        Text{
                                            anchors.verticalCenter: parent.verticalCenter
                                            font.family: font_noto_r.name
                                            color: map.tool === "straight"?"black":color_gray
                                            text: "직선"
                                        }
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            map.clear("spline");
                                            map.setTool("straight");
                                        }
                                    }
                                }

                            }
                        }
                        Rectangle{
                            id: rect_annot_tline_11
                            width: rect_annot_boxs.width
                            height: 60
                            color: "white"
                            Row{
                                anchors.centerIn: parent
                                spacing: 20
                                Rectangle{
                                    width: 100
                                    height: 50
                                    color: "transparent"
                                    Row{
                                        anchors.centerIn: parent
                                        spacing: 10
                                        Rectangle{
                                            width: 50
                                            height: width
                                            radius: width
                                            color: map.tool === "dot_spline"?color_green:color_gray
                                            Image{
                                                source: "icon/icon-drawing-curve.png"
                                                width: 30
                                                height: 30
                                                anchors.centerIn: parent
                                                ColorOverlay{
                                                    source: parent
                                                    anchors.fill: parent
                                                    color: "white"
                                                }
                                            }
                                        }
                                        Text{
                                            anchors.verticalCenter: parent.verticalCenter
                                            font.family: font_noto_r.name
                                            color: map.tool === "dot_spline"?"black":color_gray
                                            text: "곡선"
                                        }
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            map.clear("spline");
                                            map.setTool("dot_spline");
                                        }
                                    }
                                }

                                Rectangle{
                                    width: 100
                                    height: 50
                                    color: "transparent"
                                    Row{
                                        anchors.centerIn: parent
                                        spacing: 10
                                        Rectangle{
                                            width: 50
                                            height: width
                                            radius: width
                                            color: map.tool === "erase"?color_green:color_gray
                                            Image{
                                                source: "icon/icon_erase.png"
                                                width: 30
                                                height: 30
                                                anchors.centerIn: parent
                                                ColorOverlay{
                                                    source: parent
                                                    anchors.fill: parent
                                                    color: "white"
                                                }
                                            }
                                        }
                                        Text{
                                            anchors.verticalCenter: parent.verticalCenter
                                            font.family: font_noto_r.name
                                            color: map.tool === "erase"?"black":color_gray
                                            text: "지우개"
                                        }
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : TravelLine -> ERASE")
                                            map.clear("spline");
                                            map.setDrawingWidth(slider_erase.value);
                                            map.setTool("erase");
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Rectangle{
                        id: rect_annot_tline_2
                        width: rect_annot_boxs.width
                        height: 50
                        visible: map.tool === "dot_spline"
                        color: "white"
                        Row{
                            anchors.centerIn: parent
                            spacing: 20
                            Rectangle{
                                width: 80
                                height: 40
                                radius: 5
                                border.width: 1
                                color: color_gray
                                Text{
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    text: "취소"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        map.clear("spline");
                                        map.setTool("draw");
                                    }
                                }
                            }
                            Rectangle{
                                width: 80
                                height: 40
                                radius: 5
                                border.width: 1
                                color: color_gray
                                Text{
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    text: "저장"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        map.save("spline");
                                        map.setTool("draw");
                                    }
                                }
                            }
                        }
                    }

                    Rectangle{
                        id: rect_annot_box3
                        width: rect_annot_boxs.width
                        height: 50
                        color: "white"
                        visible: map.tool === "draw" || map.tool === "straight" || map.tool === "dot_spline"
                        Text{
                            text: "브러시 사이즈"
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 30
                        }
                        Slider {
                            id: slider_brush
                            x: 300
                            y: 330
                            value: 1
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 30
                            width: 170
                            height: 18
                            from: 1
                            to : 5
                            onValueChanged: {
                                map.setDrawingWidth(value)
                                if(map.tool !== "draw" && map.tool !== "straight"){
                                    supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : TravelLine -> BRUSH")
                                    map.setTool("draw");
                                    map.setDrawingColor(255);
                                }
                            }
                            onPressedChanged: {
                                if(slider_brush.pressed){
                                    map.show_brush = true;
//                                    map.brushchanged();
                                }else{
                                    map.show_brush = false;
//                                    map.brushdisappear();
                                }
                            }
                        }
                    }
                    Rectangle{
                        width: rect_annot_boxs.width
                        height: 50
                        color: "white"
                        visible: map.tool === "erase"
                        Text{
                            text: "브러시 사이즈"
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 30
                        }
                        Slider {
                            id: slider_erase
                            x: 300
                            y: 330
                            value: 30
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 30
                            width: 170
                            height: 18
                            from: 10
                            to : 100
                            onValueChanged: {
                                map.setDrawingWidth(value);
                                if(map.tool !== "erase"){
                                    supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : TravelLine -> ERASE")
                                    map.setTool("erase");
                                    map.clear("spline");
                                }
                            }
                            onPressedChanged: {
                                if(slider_erase.pressed){
                                    map.show_brush = true;
//                                    map.brushchanged();
                                }else{
                                    map.show_brush = false;
//                                    map.brushdisappear();
                                }
                            }
                        }
                    }
                }
            }

            Rectangle{
                id: btn_save_map
                width: 200
                height: 80
                radius: 5
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_boxs.bottom
                anchors.topMargin : 30
                color: "black"
                Text{
                    anchors.centerIn: parent
                    text: "저장"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        popup_save_travelline.save_mode = "tline";
                        popup_save_travelline.open();
                        if(btn_load_map.activated){
                            popup_save_travelline.edited_mode = true;
                        }else{
                            popup_save_travelline.edited_mode = false;
                        }
                    }
                }
            }
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                spacing: 30
                PageIndicator{
                    id: indicator_annot
                    count: 8
                    currentIndex: 6
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    delegate: Rectangle{
                        implicitWidth: index===indicator_annot.currentIndex?10:8
                        implicitHeight: implicitWidth
                        anchors.verticalCenter: parent.verticalCenter
                        radius: width
                        color: index===indicator_annot.currentIndex?"black":"#d0d0d0"
                        Behavior on color{
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Rectangle{
                        id: btn_prev_0
                        width: 180
                        height: 60
                        radius: 10
                        color:"transparent"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "이전"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : NEXT (VELMAP)")
                                map.init();
                                map.loadmap(supervisor.getMapname(),"EDITED")
                                map.setViewer("annot_velmap");
                                loader_menu.sourceComponent = menu_annot_velmap;
                            }
                        }
                    }
                    Rectangle{
                        id: btn_next_0
                        width: 180
                        height: 60
                        radius: 10
                        color: "black"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "다음"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : NEXT(SAVE)")
                                map.init();
                                map.setTool("move");
                                map.setViewer("current")
                                map.loadmap(supervisor.getMapname(),"EDITED");
                                map.show_connection = false;
                                loader_menu.sourceComponent = menu_annot_save;


                            }
                        }
                    }
                }
            }
        }
    }

    Component{
        id: menu_annot_objecting
        Item{
            id: menu_objecting
            objectName: "menu_objecting"
            width: rect_menus.width
            height: rect_menus.height

            Timer{
                id: timer_check_localization
                running: false
                repeat: true
                interval: 500
                onTriggered:{
                    if(supervisor.is_slam_running()){
                        btn_auto_init.running = false;
                        map.clear("all");
                        timer_check_localization.stop();
                        supervisor.writelog("[QML] CHECK LOCALIZATION -> STARTED")
                    }else if(supervisor.getLocalizationState() === 0 || supervisor.getLocalizationState() === 3){
                        timer_check_localization.stop();
                        btn_auto_init.running = false;
                        supervisor.writelog("[QML] CHECK LOCALIZATION -> NOT WORKING "+Number(supervisor.getLocalizationState()));
                    }
                }
            }
            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }

            Component.onCompleted: {
            }

            Component.onDestruction: {
                if(is_objecting){
                    supervisor.stopObjecting();
                }
            }

            Rectangle{
                id: rect_annot_state
                width: parent.width
                height: 50
                anchors.top: parent.top
                anchors.topMargin: 2
                color: "#4F5666"
                Text{
                    anchors.centerIn: parent
                    color: "white"
                    font.family: font_noto_b.name
                    font.pixelSize: 20
                    text: "3. 맵 오브젝트 그리기"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Column{
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 20
                spacing: 10

                Rectangle{
                    width: parent.width*0.8
                    height: 40
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        color: "white"
                        text: "위치 초기화"
                        font.family: font_noto_r.name
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    id: rect_annot_localization
                    width: parent.width
                    height: 100
                    color: "#e8e8e8"
                    Row{
                        anchors.centerIn: parent
                        spacing: 20
                        Item_button{
                            id: btn_move
                            width: 80
                            shadow_color: color_gray
                            highlight: map.tool=="move"
                            icon: "icon/icon_move.png"
                            name: "이동"
                            MouseArea{
                                anchors.fill: parent
                                onPressed: {
                                    parent.pressed();
                                }
                                onReleased:{
                                    parent.released();
                                }

                                onClicked: {
                                    supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : LOCATION -> MOVE ")
                                    map.setTool("move");
                                    map.clear("all");
                                }
                            }
                        }
                        Item_button{
                            width: 80
                            visible: false
                            shadow_color: color_gray
                            icon: "icon/icon_local_manual.png"
                            name: "대기위치로\n초기화"
                            MouseArea{
                                anchors.fill: parent
                                onPressed: {
                                    parent.pressed();
                                }
                                onReleased:{
                                    parent.released();
                                }

                                onClicked: {
                                    supervisor.slam_stop();
                                    if(supervisor.getGridWidth() > 0){
                                        var init_x = supervisor.getLocationx("Resting");
                                        var init_y = supervisor.getLocationy("Resting");
                                        var init_th  = supervisor.getLocationth("Resting");
                                        map.setAutoInit(init_x,init_y,init_th);
                                    }
                                    supervisor.writelog("[QML] MAP PAGE (LOCAL) -> LOCALIZATION MANUAL ")
                                    supervisor.slam_setInit();
                                }
                            }
                        }
                        Item_button{
                            width: 80
                            shadow_color: color_gray
                            highlight: map.tool=="slam_init"
                            icon: "icon/icon_local_manual.png"
                            name: "수동 초기화"
                            MouseArea{
                                anchors.fill: parent
                                onPressed: {
                                    parent.pressed();
                                }
                                onReleased:{
                                    parent.released();
                                }

                                onClicked: {
                                    supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : LOCATION -> LOCALIZATION MANUAL ")
                                    supervisor.slam_stop();
                                    map.setTool("slam_init");
                                    if(supervisor.getGridWidth() > 0){
                                        var init_x = supervisor.getlastRobotx();
                                        var init_y = supervisor.getlastRoboty();
                                        var init_th  = supervisor.getlastRobotth();// - Math.PI/2;
                                        print(supervisor.getlastRobotx(),supervisor.getGridWidth(),supervisor.getOrigin()[0],init_x);
                                        map.setAutoInit(init_x,init_y,init_th);
                                        supervisor.setInitPos(init_x,init_y,init_th);
                                    }
                                    supervisor.slam_setInit();
                                }
                            }
                        }
                        Item_button{
                            id: btn_auto_init
                            width: 78
                            shadow_color: color_gray
                            icon:"icon/icon_local_auto.png"
                            name:"자동 초기화"
                            MouseArea{
                                anchors.fill: parent
                                onPressed: {
                                    parent.pressed();
                                }
                                onReleased:{
                                    parent.released();
                                }

                                onClicked: {
                                    if(supervisor.getLocalizationState() !== 1){
                                        supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : LOCATION -> LOCALIZATION AUTO ")
                                        btn_auto_init.running = true;
                                        timer_check_localization.start();
                                        supervisor.slam_autoInit();
//                                        menu_location.checkInit = true;
                                    }

                                }
                            }
                        }
                    }
                }

                Rectangle{
                    width: parent.width*0.8
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 40
                    color: "black"
                    Text{
                        color: "white"
                        text: "오브젝트 그리기"
                        font.family: font_noto_r.name
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    id: rect_annot_box_map
                    width: parent.width - 60
                    height: 100
                    radius: 5
                    anchors.horizontalCenter: parent.horizontalCenter
//                    anchors.top: rect_annot_state.bottom
//                    anchors.topMargin: 30
                    color: "#e8e8e8"
                    Row{
                        anchors.centerIn: parent
                        spacing: 30
                        Rectangle{
                            id: state_manual
                            width: 100
                            height: 80
                            radius: 10
                            color: "white"
                            enabled: supervisor.getEmoStatus()
                            border.color:color_green
                            border.width: enabled?3:0
                            Column{
                                spacing: 3
                                anchors.centerIn: parent
                                Image{
                                    source: "icon/image_emergency.png"
                                    Component.onCompleted: {
                                        if(sourceSize.width > 30)
                                            sourceSize.width = 30

                                        if(sourceSize.height > 30)
                                            sourceSize.height = 30
                                    }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    ColorOverlay{
                                        id: emo_light
                                        anchors.fill: parent
                                        source: parent
                                        color: color_green
                                        visible: state_manual.enabled
                                    }
                                }

                                Text{
                                    font.family: font_noto_r.name
                                    font.pixelSize: 12
                                    text: "비상스위치 눌림"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }
                        Rectangle{
                            id: state_objecting
                            width: 100
                            height: 80
                            radius: 10
                            color: "white"
                            border.color:color_green
                            border.width: is_objecting?3:0
                            Column{
                                spacing: 3
                                anchors.centerIn: parent
                                Image{
                                    source: is_objecting?"icon/icon_mapping.png":"icon/icon_mapping_start.png"
                                    Component.onCompleted: {
                                        if(sourceSize.width > 30)
                                            sourceSize.width = 30

                                        if(sourceSize.height > 30)
                                            sourceSize.height = 30
                                    }
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    font.family: font_noto_r.name
                                    font.pixelSize: 12
                                    text: is_objecting?"오브젝트 생성 중":"오브젝트 생성하기"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
                                    map.setTool("move");
                                    if(supervisor.getLCMConnection()){
                                        if(is_objecting){
                                            popup_reset_objecting.open();
                                        }else{
    //                                        btn_menu.is_restart = true;
                                            supervisor.writelog("[USER INPUT] ANNOTATION PAGE : START OBJECTING ")
                                            supervisor.startObjecting();
                                        }
                                    }else{
                                        supervisor.writelog("[USER INPUT] ANNOTATION PAGE : START OBJECTING -> BUT SLAM NOT CONNECTED")
                                    }
                                }
                            }
                        }
                    }
                }

            }
            Timer{
                id: update_timer
                interval: 500
                running: true
                repeat: true
                onTriggered:{
                    if(supervisor.getObjectingflag()){
                        if(!is_objecting){
//                            voice_stop_mapping.stop();
//                            voice_start_mapping.play();
                            is_objecting = true;
                        }
                    }else{
                        if(is_objecting){
//                            voice_start_mapping.stop();
//                            voice_stop_mapping.play();
                            is_objecting = false;
                        }
                    }

                    if(supervisor.getEmoStatus()){
                        state_manual.enabled = true;
                    }else{
                        state_manual.enabled = false;
                    }
                }
            }
            Rectangle{
                id: btn_save_map
                width: 200
                height: 80
                radius: 5
                enabled: is_objecting
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: cols.top
                anchors.bottomMargin : 50
//                anchors.left: rect_annot_box_map.left
                color: is_objecting?"black":color_gray
                Text{
                    anchors.centerIn: parent
                    text: "저장"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        map.setTool("move");
                        popup_save_objecting.open();
                    }
                }
            }
            Column{
                id: cols
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                spacing: 30
                PageIndicator{
                    id: indicator_annot
                    count: 8
                    currentIndex: 3
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    delegate: Rectangle{
                        implicitWidth: index===indicator_annot.currentIndex?10:8
                        implicitHeight: implicitWidth
                        anchors.verticalCenter: parent.verticalCenter
                        radius: width
                        color: index===indicator_annot.currentIndex?"black":"#d0d0d0"
                        Behavior on color{
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Rectangle{
                        id: btn_prev_0
                        width: 180
                        height: 60
                        radius: 10
                        color:"transparent"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "이전"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                supervisor.writelog("[QML] MAP PAGE (ANNOT) -> NEXT (DRAWING)")
                                //아무 변경이 없으면
                                map.init();
                                map.setViewer("annot_drawing");
                                loader_menu.sourceComponent = menu_annot_draw;
                            }
                        }
                    }
                    Rectangle{
                        id: btn_next_0
                        width: 180
                        height: 60
                        radius: 10
                        color: "black"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "다음"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : NEXT (OBJECT)")
                                map.init();
                                map.setViewer("annot_object");
                                loader_menu.sourceComponent = menu_annot_object;
                            }
                        }
                    }
                }
            }
        }

    }

    Component{
        id: menu_annot_object
        Item{
            id: menu_object
            objectName: "menu_object"
            width: rect_menus.width
            height: rect_menus.height
            property bool checkInit: false
            property var obj_category: 0
            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }
            function update(){
                print("object update");
                list_object.model.clear();
                list_location.model.clear();
                if(supervisor.getLocationNum("Charging") === 0){
                    list_location.model.append({"number":"-10","group":"temp","type":"Charging","name":"지정되지 않음","iscol":false,"empty":true})
                }else{
                    list_location.model.append({"number":"-10","group":"temp","type":"Charging","name":supervisor.getLocationName(0,"Charging"),"iscol":map.checkCollision(supervisor.getLocationX(0,"Charging"),supervisor.getLocationY(0,"Charging")),"empty":false});

                }

                if(supervisor.getLocationNum("Resting") === 0){
                    list_location.model.append({"number":"-5","group":"temp","type":"Resting","name":"지정되지 않음","iscol":false,"empty":true})
                }else{
                    list_location.model.append({"number":"-5","group":"temp","type":"Resting","name":supervisor.getLocationName(0,"Resting"),"iscol":map.checkCollision(supervisor.getLocationX(0,"Resting"),supervisor.getLocationY(0,"Resting")),"empty":false});

                }

                var loc_num = supervisor.getLocationNum("Serving");
                var group_num = supervisor.getLocationGroupNum();
                for(var i=0; i<loc_num; i++){
                    list_location.model.append({"type":"Serving", "name":supervisor.getLocationName(i,"Serving"), "iscol":map.checkCollision(supervisor.getLocationX(i,"Serving"), supervisor.getLocationY(i,"Serving")), "empty":false, "number":supervisor.getLocationNumber(-1,i).toString(), "group":supervisor.getLocationGroup(i)});
                    print(i,supervisor.getLocationNumber(-1,i).toString(),supervisor.getLocationNumber(supervisor.getLocationGroupNum(i),i).toString())
                }
                var ob_num = supervisor.getObjectNum();
                for(var i=0; i<ob_num; i++){
                    list_object.model.append({"name":supervisor.getObjectName(i)});
                }
                list_object.currentIndex = ob_num-1;
                list_location.currentIndex = -1;
                list_object.currentIndex = -1;
                map.setCurrentLocation(-1);
                map.setCurrentObject(-1);
            }

            function setcategory(num){
                obj_category = num;
            }

            function setobjcur(num){
                list_object.currentIndex = num;
            }
            function setloccur(num){
                print("setloccur ",num)
                list_location.currentIndex = num;
            }

            Timer{
                id: timer_check_localization
                running: false
                repeat: true
                interval: 500
                onTriggered:{
                    if(supervisor.is_slam_running()){
                        btn_auto_init.running = false;
                        map.clear("all");
                        timer_check_localization.stop();
                        supervisor.writelog("[QML] CHECK LOCALIZATION -> STARTED")
                    }else if(supervisor.getLocalizationState() === 0 || supervisor.getLocalizationState() === 3){
                        timer_check_localization.stop();
                        btn_auto_init.running = false;
                        supervisor.writelog("[QML] CHECK LOCALIZATION -> NOT WORKING "+Number(supervisor.getLocalizationState()));
                    }
                }
            }
            Component.onCompleted: {
                obj_category = 0;
                map.loadmap(supervisor.getMapname(),"OBJECT");
            }
            onObj_categoryChanged: {
                print("obj category changed");
                map.setcostmap();
                if(obj_category === 0){

                }else if(obj_category === 1){
                    help_image.source = "video/loc_help.gif"
                    if(supervisor.getSetting("ROBOT_SW","use_help") === "true"){
                        popup_help.open();
                    }
                }else if(obj_category === 2){
                    help_image.source = "video/obj_help.gif"
                    if(supervisor.getSetting("ROBOT_SW","use_help") === "true"){
                        popup_help.open();
                    }
                }
                map.setTool("move");
                update();
            }

            Rectangle{
                id: rect_annot_state
                width: parent.width
                height: 50
                anchors.top: parent.top
                anchors.topMargin: 2
                color: "#4F5666"
                Text{
                    anchors.centerIn: parent
                    color: "white"
                    font.family: font_noto_b.name
                    font.pixelSize: 20
                    text: "4. 위치 지정 / 가상 벽"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Row{
                id: row_small_menu
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 30
                spacing: 45
                Rectangle{
                    width: 100
                    height: 40
                    color: menu_object.obj_category === 0 ? "white" : color_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 16
                        text: "위치초기화"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            menu_object.obj_category = 0;
                        }
                    }
                }
                Rectangle{
                    width: 100
                    height: 40
                    color: menu_object.obj_category === 1 ? "white" : color_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 16
                        text: "위치지정"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            menu_object.obj_category = 1;
                            map.init();
                        }
                    }
                }
                Rectangle{
                    width: 100
                    height: 40
                    color: menu_object.obj_category === 2 ? "white" : color_gray
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 16
                        text: "가상벽"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            menu_object.obj_category = 2;
                            map.init();
//                            map.setViewer("annot_object");
                        }
                    }
                }
            }


            Rectangle{
                width: row_small_menu.width
                height: 400
                anchors.top: row_small_menu.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    Rectangle{
                        id: rect_obj_menu
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: row_small_menu.width-20
                        height: 100
                        color: color_light_gray
                        Row{
                            id: row_annot_localization
                            visible: menu_object.obj_category === 0
                            anchors.centerIn: parent
                            spacing: 20
                            Item_button{
                                visible: false
                                width: 80
                                shadow_color: color_gray
                                icon: "icon/icon_local_manual.png"
                                name: "대기위치로\n초기화"
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed:{
                                        parent.btn_color= color_light_gray;
                                    }
                                    onReleased: {
                                        parent.btn_color = "white";
                                    }
                                    onClicked: {
                                        supervisor.slam_stop();
                                        if(supervisor.getGridWidth() > 0){
                                            var init_x = supervisor.getLocationX("Resting");
                                            var init_y = supervisor.getLocationY("Resting");
                                            var init_th  = supervisor.getLocationTH("Resting");
                                            map.setAutoInit(init_x,init_y,init_th);
                                        }
                                        supervisor.writelog("[QML] MAP PAGE (LOCAL) -> LOCALIZATION MANUAL ")
                                        supervisor.slam_setInit();
                                        map.setTool("move");
                                    }
                                }
                            }
                            Item_button{
                                width: 80
                                shadow_color: color_gray
                                highlight: map.tool=="slam_init"
                                icon: "icon/icon_local_manual.png"
                                name: "수동 초기화"
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed:{
                                        parent.btn_color= color_light_gray;
                                    }
                                    onReleased: {
                                        parent.btn_color = "white";
                                    }
                                    onClicked: {
                                        if(map.tool === "slam_init"){
                                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : LOCATION -> MOVE ")
                                            map.setTool("move");
                                            list_object.currentIndex = -1;
                                            list_location.currentIndex = -1;
                                            map.clear("all");
                                            map.init();
                                        }else{
                                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : LOCATION -> LOCALIZATION MANUAL ")
                                            supervisor.slam_stop();
                                            map.setTool("slam_init");
                                            if(supervisor.getGridWidth() > 0){
                                                var init_x = supervisor.getlastRobotx();
                                                var init_y = supervisor.getlastRoboty();
                                                var init_th  = supervisor.getlastRobotth();// - Math.PI/2;
                                                print(supervisor.getlastRobotx(),supervisor.getGridWidth(),supervisor.getOrigin()[0],init_x);
                                                map.setAutoInit(init_x,init_y,init_th);
                                                supervisor.setInitPos(init_x,init_y,init_th);
                                            }
                                            supervisor.slam_setInit();
                                        }

                                    }
                                }
                            }
                            Item_button{
                                id: btn_auto_init
                                width: 78
                                shadow_color: color_gray
                                icon:"icon/icon_local_auto.png"
                                name:"자동 초기화"
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed:{
                                        parent.btn_color= color_light_gray;
                                    }
                                    onReleased: {
                                        parent.btn_color = "white";
                                    }
                                    onClicked: {
                                        map.clear("all");
                                        map.setTool("move");
                                        if(supervisor.getLocalizationState() !== 1){
                                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : LOCATION -> LOCALIZATION AUTO ")
                                            btn_auto_init.running = true;
                                            timer_check_localization.start();
                                            supervisor.slam_autoInit();
                                            menu_object.checkInit = true;
                                        }
                                    }
                                }
                            }
                        }

                        Row{
                            id: row_annot_loc
                            visible: menu_object.obj_category === 2
                            anchors.centerIn: parent
                            spacing: 15
                            Item_button{
                                id: btn_add_location
                                width: 78
                                shadow_color: color_gray
                                highlight: map.tool=="add_point"||map.tool=="add_object"
                                icon: "icon/icon_add.png"
                                name: "추가"
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed: {
                                        parent.pressed();
                                    }
                                    onReleased:{
                                        parent.released();
                                    }

                                    onClicked: {
                                        list_object.currentIndex = -1;
                                        list_location.currentIndex = -1;
                                        supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : OBJECT -> ADD")
                                        map.setTool("add_object");
                                    }
                                }
                            }
                            Item_button{
                                id: btn_edit
                                width: 78
                                shadow_color: color_gray
                                highlight: map.tool=="edit_object"
                                enabled: map.tool=="add_object"||map.tool=="add_point"||list_object.currentIndex<0?false:true
                                icon: "icon/icon_edit.png"
                                name: "수정"
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed: {
                                        parent.pressed();
                                    }
                                    onReleased:{
                                        parent.released();
                                    }

                                    onClicked: {
                                        supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : OBJECT -> EDIT")
                                        map.setTool("edit_object");
                                    }
                                }
                            }
                            Item_button{
                                id: btn_erase
                                width: 78
                                shadow_color: color_gray
                                enabled: map.tool=="add_object"||map.tool=="add_point"||list_object.currentIndex<0?false:true
                                icon: "icon/icon_erase.png"
                                name: "삭제"
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed: {
                                        parent.pressed();
                                    }
                                    onReleased:{
                                        parent.released();
                                    }

                                    onClicked: {
                                        supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : OBJECT -> REMOVE")
                                        supervisor.removeObject(list_object.currentIndex);

                                        map.setcostmap();
                                        list_object.currentIndex = -1;
                                        map.updateMap();
                                    }
                                }
                            }
                        }
                        Row{
                            anchors.centerIn: parent
                            spacing: 20
                            visible: menu_object.obj_category === 1

                            Item_button{
                                width: 78
                                shadow_color: color_gray
                                highlight: map.tool=="add_location"
                                icon: "icon/icon_add.png"
                                name: "추가"
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed: {
                                        parent.pressed();
                                    }
                                    onReleased:{
                                        parent.released();
                                    }

                                    onClicked: {
                                        supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : LOCATION -> ADD ")
                                        map.init();
                                        list_location.currentIndex = -1;
                                        map.setTool("add_location");
                                    }
                                }
                            }
                            Item_button{
                                width: 78
                                shadow_color: color_gray
                                highlight: map.tool=="edit_location"
                                enabled: map.tool=="add_location"||list_location.currentIndex < 0?false:true
                                icon: "icon/icon_edit.png"
                                name: "수정"
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed: {
                                        parent.pressed();
                                    }
                                    onReleased:{
                                        parent.released();
                                    }

                                    onClicked: {
                                        supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : LOCATION -> EDIT ")
                                        print(list_location.currentIndex,list_location.model.get(list_location.currentIndex).empty)
                                        if(list_location.currentIndex > -1 && list_location.model.get(list_location.currentIndex).empty){
                                            map.setTool("edit_location_new");
                                        }else{
                                            map.setTool("edit_location");
                                        }
                                    }
                                }
                            }
                            Item_button{
                                width: 78
                                shadow_color: color_gray
                                enabled: map.tool=="add_location"||list_location.currentIndex < 0?false:true
                                icon: "icon/icon_erase.png"
                                name: "삭제"
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed: {
                                        parent.pressed();
                                    }
                                    onReleased:{
                                        parent.released();
                                    }

                                    onClicked: {
                                        if(list_location.currentIndex > -1){
                                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : LOCATION -> REMOVE "+Number(list_location.currentIndex))
                                            supervisor.removeLocation(list_location.model.get(list_location.currentIndex).name);
                                            list_location.currentIndex = -1;
                                            map.updateMap();
                                        }
                                    }
                                }
                            }
                            Item_button{
                                width: 78
                                shadow_color: color_gray
                                icon: "icon/icon_bookmark.png"
                                name: "상세지정"
                                overcolor: true
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed: {
                                        parent.pressed();
                                    }
                                    onReleased:{
                                        parent.released();
                                    }
                                    onClicked: {
                                        popup_location_number.open();
                                    }
                                }
                            }
                        }
                    }

                    Rectangle{
                        id: rect_annot_submenu
                        width: parent.width
                        color: "#e8e8e8"
                        visible: map.tool == "add_object"||map.tool == "add_point" || map.tool == "add_location" || map.tool == "edit_location" || map.tool == "edit_location_new"
                        Row{
                            id: row_object
                            visible: map.tool == "add_object"||map.tool == "add_point"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 30
                            spacing: 15
                            Rectangle{
                                id: btn_rectangle
                                width: 80
                                height: 40
                                radius: 5
                                border.width: map.tool=="add_object"?3:1
                                border.color: map.tool=="add_object"?"#12d27c":"black"
                                Text{
                                    text: "사각형"
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : OBJECT -> DRAW RECTANGLE")
                                        map.setTool("add_object");
                                    }
                                }
                            }
                            Rectangle{
                                id: btn_point
                                width: 78
                                height: 40
                                radius: 5
                                border.width: map.tool=="add_point"?3:1
                                border.color: map.tool=="add_point"?"#12d27c":"black"
                                Text{
                                    text: "다각형"
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : OBJECT -> DRAW POINT")
                                        map.setTool("add_point");
                                    }
                                }
                            }
                            Rectangle{
                                id: btn_save_object
                                width: 78
                                height: 40
                                radius: 5
                                border.width: 1
                                border.color: "black"
                                Text{
                                    text: "저장"
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        map.checkEdit();
                                        if(map.is_object_new){
                                            supervisor.writelog("[QML] MAP PAGE : SAVE OBJECT -> "+select_object_type + "_" + Number(supervisor.getObjectSize(select_object_type)));

                                            map.saveObject("Wall");
                                            map.setcostmap();
                                            map.setTool("move");

                                            supervisor.setObjPose();
//                                            popup_add_object.open();
                                        }
                                    }
                                }
                            }
                            Rectangle{
                                id: btn_undo
                                width: 40
                                height: 40
                                radius: 40
                                color: enabled?"#282828":"#D0D0D0"
                                Image{
                                    anchors.centerIn: parent
                                    source: "icon/icon_undo.png"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        map.checkEdit();
                                        if(map.tool == "add_object"){
                                            map.init();
                                        }else if(map.tool == "add_point"){
                                            map.object_undo();
                                        }
                                        supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : OBJECT -> UNDO")
                                    }
                                }
                            }
                        }
                        Row{
                            id: row_location
                            visible: map.tool == "add_location" || map.tool == "edit_location" || map.tool == "edit_location_new"
                            anchors.centerIn: parent
                            spacing: 30
                            Rectangle{
                                id: btn_1
                                width: 80
                                height: 40
                                radius: 5
                                Text{
                                    text: "취소"
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : LOCATION -> ADD CANCEL")

                                        if(map.tool == "edit_location" || map.tool == "edit_locaiton_new")
                                            map.redoLocation();

                                        map.setTool("move");
                                        map.init();
                                        list_location.currentIndex = -1;
                                    }
                                }
                            }
                            Rectangle{
                                id: btn_2
                                width: 78
                                height: 40
                                radius: 5
                                color: "white"
                                Text{
                                    text: "저장"
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    color: parent.enabled?"black":"white"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        if(map.tool == "add_location"){
                                            map.checkEdit();
                                            if(map.is_location_new){
                                                popup_add_location.open();
                                            }
                                        }else{
                                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : LOCATION -> SAVE EDIT")
                                            if(map.tool == "edit_location_new"){
                                                map.save("location",list_location.model.get(list_location.currentIndex).type,list_location.model.get(list_location.currentIndex).type);
                                            }
                                            map.setTool("move");
                                            map.init();
                                            menu_object.update();
                                        }
                                    }
                                }
                            }
                            Rectangle{
                                id: btn_3
                                width: 78
                                height: 40
                                radius: 5
                                color: enabled?"white":"#f4f4f4"
                                enabled: supervisor.is_slam_running()?true:false
                                Text{
                                    text: "현재위치로"
                                    anchors.centerIn: parent
                                    font.family: font_noto_r.name
                                    color: parent.enabled?"black":"white"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        if(map.tool == "add_location"){
                                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : LOCATION -> ADD CUR POSITION")
                                            popup_add_location.open();
                                            popup_add_location.curpose_mode = true;
                                        }else{
                                            if(map.checkRobotCollision()){

                                            }else{
                                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : LOCATION -> EDIT" +Number(list_location.currentIndex) +" CUR POSITION")
                                                if(map.tool == "edit_location_new"){
                                                    map.save("location_cur",list_location.model.get(list_location.currentIndex).type,list_location.model.get(list_location.currentIndex).type);
                                                }else{
                                                    map.save("edit_location",list_location.model.get(list_location.currentIndex).type,list_location.model.get(list_location.currentIndex).name);
//                                                    map.editLocation(map.robot_x/map.newscale, map.robot_y/map.newscale, supervisor.getRobotth());
                                                }
                                                list_location.currentIndex = -1;
                                                map.setTool("move");
                                                map.init();
                                            }
                                        }
                                    }
                                }
                            }

                        }

                        onVisibleChanged: {
                            if(visible){
                                height = 50
                            }else{
                                height = 0
                            }
                        }
                        Behavior on height {
                            NumberAnimation{
                                duration:300;
                            }
                        }
                    }
                    Rectangle{
                        width: 400
                        height: 200
                        radius: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: menu_object.obj_category === 0
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
                                    text: "비상스위치가 눌려있다면 풀어주세요."
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
                                    text: "라이다가 맵과 일치하는 지 확인해주세요."
                                    font.pixelSize: 13
                                    font.family: font_noto_r.name
                                    color: color_red
                                }
                            }
                        }
                    }


                    ListView {
                        id: list_location
                        width: row_small_menu.width
                        visible: menu_object.obj_category === 1
                        enabled: menu_object.obj_category === 1
                        height: (row_location.visible)?200:260
                        clip: true
                        model: ListModel{}
                        delegate: locationCompo
                        highlight: Rectangle {color: "#83B8F9"}
                        onCurrentIndexChanged: {
                            map.clear("location");
                            if(map.tool == "add_location"){
                                map.setTool("move");
                            }
//                            print("list location current index changed ",currentIndex,menu_object.obj_category, visible);
                            if(currentIndex < 0 || currentIndex > list_location.model.count){
                                map.setCurrentLocation(-1,"");
                            }else{
                                map.setCurrentLocation(currentIndex,list_location.model.get(currentIndex).type);
                            }
                        }
                        Behavior on height {
                            NumberAnimation{
                                duration:300;
                            }
                        }
                    }
                    ListView {
                        id: list_object
                        width: row_small_menu.width
                        visible: menu_object.obj_category === 2
                        enabled: menu_object.obj_category === 2
                        height: (row_object.visible)?160:220
                        clip: true
                        model: ListModel{}
                        delegate: objectCompo
                        highlight: Rectangle {color: "#83B8F9"}

                        onCurrentIndexChanged: {
//                            print("list object current index changed ",currentIndex);
                            map.setCurrentObject(currentIndex);

                        }
                        Behavior on height {
                            NumberAnimation{
                                duration:300;
                            }
                        }
                    }
                }
            }


            Column{
                 anchors.horizontalCenter: parent.horizontalCenter
                 anchors.bottom: parent.bottom
                 anchors.bottomMargin: 30
                 spacing: 30
                 PageIndicator{
                     id: indicator_annot
                     count: 8
                     currentIndex: 4
                     anchors.horizontalCenter: parent.horizontalCenter
                     spacing: 10
                     delegate: Rectangle{
                         implicitWidth: index===indicator_annot.currentIndex?10:8
                         implicitHeight: implicitWidth
                         anchors.verticalCenter: parent.verticalCenter
                         radius: width
                         color: index===indicator_annot.currentIndex?"black":"#d0d0d0"
                         Behavior on color{
                             ColorAnimation {
                                 duration: 200
                             }
                         }
                     }
                 }
                 Row{
                     anchors.horizontalCenter: parent.horizontalCenter
                     spacing: 20
                     Rectangle{
                         id: btn_prev_0
                         width: 180
                         height: 60
                         radius: 10
                         color:"transparent"
                         border.width: 1
                         border.color: "#7e7e7e"
                         Text{
                             anchors.centerIn: parent
                             text: "이전"
                             font.family: font_noto_r.name
                             font.pixelSize: 25

                         }
                         MouseArea{
                             anchors.fill: parent
                             onClicked:{
                                 supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : NEXT (OBJECTING)")
                                 map.init();
                                 map.setViewer("annot_objecting")
                                 loader_menu.sourceComponent = menu_annot_objecting;
                             }
                         }
                     }
                     Rectangle{
                         id: btn_next_0
                         width: 180
                         height: 60
                         radius: 10
                         color: "black"
                         border.width: 1
                         border.color: "#7e7e7e"
                         Text{
                             anchors.centerIn: parent
                             text: "다음"
                             font.family: font_noto_r.name
                             font.pixelSize: 25
                             color: "white"
                         }
                         MouseArea{
                             anchors.fill: parent
                             onClicked:{
                                 supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : NEXT (VELMAP)")
                                 map.init();
                                 map.setViewer("annot_velmap");
                                 loader_menu.sourceComponent = menu_annot_velmap;
                             }
                         }
                     }
                 }
             }

            Timer{
                running: true
                repeat: true
                interval: 500
                triggeredOnStart: true
                property var loc_num: 0
                onTriggered: {
                    if(menu_object.obj_category === 1 || menu_object.obj_category === 0){
                        if(supervisor.is_slam_running()){
                            btn_3.enabled = true;
                            btn_auto_init.running = false;
                            if(menu_object.checkInit){
                                map.setTool("move");
                                map.clear("all");
                                menu_object.checkInit = false;
                            }
                        }else if(supervisor.getLocalizationState() === 0 || supervisor.getLocalizationState() === 3){
                            btn_auto_init.running = false;
                            btn_3.enabled = false;
                        }else{
                            btn_3.enabled = false;
                        }

                        if(loc_num !== supervisor.getLocationNum()){
                            update();
                            loc_num = supervisor.getLocationNum();
                        }
                    }else if(menu_object.obj_category === 2){
                        map.checkObject();
                        if(map.is_object_new)
                            btn_undo.enabled = true;
                        else
                            btn_undo.enabled = false;


                        var ob_num = supervisor.getObjectNum();
                        if(list_object.model.count !== ob_num){
                            update();
                        }
                    }
                }
            }
            Component {
                id: locationCompo
                Item {
                    width: parent.width
                    height: 35
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: type === "Serving"?120:150
                            height: 34
                            color: {
                                if(type === "Charging"){
                                    color_green
                                }else if(type === "Resting"){
                                    color_blue
                                }else if(iscol){
                                    color_red
                                }else{
                                    color_light_gray
                                }
                            }

                            Text {
                                id: text_loc_type
                                anchors.centerIn: parent
                                text: {
                                    if(type === "Serving"){
                                        supervisor.getLocationGroupNum() > 1?group:type
                                    }else{
                                        type
                                    }
                                }
                                font.family: font_noto_r.name
                                font.pixelSize: 20
                                color: {
                                    if(type === "Serving" && !iscol){
                                        "black"
                                    }else{
                                        "white"
                                    }
                                }
                            }
                        }
                        Rectangle{
                            visible: type === "Serving"
                            width: 30
                            height: 34
                            color: iscol?color_red:color_light_gray
                            Text {
                                anchors.centerIn: parent
                                text: typeof(number)=="undefined"?"-":number
                                font.family: font_noto_r.name
                                font.pixelSize: 20
                                color: iscol?"white":"black"
                            }
                        }
                        Rectangle{
                            width: 2
                            height: parent.height
                            color: "white"
                        }
                        Rectangle{
                            width: parent.width - 152
                            height: parent.height
                            color: "transparent"
                            Image{
                                source: "icon/icon_error.png"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                width: 28
                                height: 27
                                visible: iscol||empty
                            }
                            Text{
                                id: text_loc_name
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 30
                                text: name
                                font.family: font_noto_r.name
                                font.pixelSize: 15
                                font.bold: iscol
                                color: iscol?color_red:"black"
                            }
                        }
                    }



                    Rectangle//리스트의 구분선
                    {
                        id:line
                        width:parent.width
                        anchors.bottom:parent.bottom//현재 객체의 아래 기준점을 부모객체의 아래로 잡아주어서 위치가 아래로가게 설정
                        height:1
                        color:"#e8e8e8"
                    }
                    MouseArea{
                        id:area_compo
                        anchors.fill:parent
                        onClicked: {
                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : SELECT LOCATION "+Number(index))
                            if(list_location.currentIndex === index){
                                list_location.currentIndex = -1;
                            }else{
                                list_location.currentIndex = index;
                            }
                        }
                    }
                }
            }

            Component {
                id: objectCompo
                Item {
                    width: parent.width
                    height: 35
                    Text {
                        anchors.centerIn: parent
                        text: name
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                    }
                    Rectangle//리스트의 구분선
                    {
                        id:line
                        width:parent.width
                        anchors.bottom:parent.bottom
                        height:1
                        color:"#e8e8e8"
                    }
                    MouseArea{
                        id:area_compo
                        anchors.fill:parent
                        onClicked: {
                            supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : SELECT OBJECT "+Number(index))
                            if(list_object.currentIndex === index){
                                list_object.currentIndex = -1;
                            }else{
                                list_object.currentIndex = index;
                            }
                            map.setTool("move");
                        }
                    }
                }
            }

        }
    }

    Component{
        id: menu_annot_save
        Item{
            id: menu_save
            objectName: "menu_save"
            width: rect_menus.width
            height: rect_menus.height

            Component.onCompleted: {
                if(state_annot === 0){
                    supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : NEED SAVE (NO ANNOTATION)")
                    rect_state_annot.color = "#4F5666"
                    state_text_annot.text = "저장이 필요합니다."
                    state_text_annot.anchors.rightMargin = 20
                    btn_add1.border.width = 0
                }else if(state_annot === 1){
                    if(supervisor.getAnnotEditFlag() || edit_flag){
                        supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : NEED SAVE (EDITED)")
                        rect_state_annot.color = "#EE9D44"
                        state_text_annot.text = "저장이 필요합니다."
                        state_text_annot.anchors.rightMargin = 20
                        btn_add1.border.width = 0
                    }else{
                        supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : DON'T NEED SAVE")
                        rect_state_annot.color = "#12d27c"
                        state_text_annot.text = "Confirm"
                        state_text_annot.anchors.rightMargin = 50
                        btn_add1.border.width = 3
                        state_annot = 2;
                    }
                }

                if(state_annot === 2 && !supervisor.getAnnotEditFlag()){
                    btn_next_0.enabled = true;
                }
            }

            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }

            Rectangle{
                id: rect_annot_state
                width: parent.width
                height: 50
                anchors.top: parent.top
                anchors.topMargin: 2
                color: "#4F5666"
                Text{
                    anchors.centerIn: parent
                    color: "white"
                    font.family: font_noto_b.name
                    font.pixelSize: 20
                    text: "5. 저장하기"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id: rect_annot_map_name
                radius: 5
                width: parent.width*0.9
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 40
                color: "white"
                Text{
                    anchors.centerIn: parent
                    color: "#282828"
                    font.family: font_noto_b.name
                    font.pixelSize: 20
                    text: is_init_state?"맵 이름 : " + map.map_name:"맵 이름 : " + supervisor.getMapname();
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Column{
                anchors.top: rect_annot_map_name.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Rectangle{
                    id: rect_meta_box
                    visible: false
                    width: menu_save.width*0.7
                    height: 85
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    Rectangle{
                        id: rect_state_meta
                        height: 60
                        width: parent.width*0.8
                        radius: 10
                        color: "#12d27c"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        Text{
                            id: state_text_meta
                            text: "확인"
                            anchors.verticalCenter: parent.verticalCenter
                            color: "white"
                            anchors.right: parent.right
                            anchors.rightMargin: 50
                            font.family: font_noto_b.name
                            font.pixelSize: 25
                        }
                    }
                }

                Rectangle{
                    id: rect_annot_box
                    width: menu_save.width*0.7
                    height: 85
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    Rectangle{
                        id: rect_state_annot
                        height: 60
                        width: parent.width*0.8
                        radius: 10
                        color: "#12d27c"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        Text{
                            id: state_text_annot
                            text: "확인"
                            anchors.verticalCenter: parent.verticalCenter
                            color: "white"
                            anchors.right: parent.right
                            anchors.rightMargin: 50
                            font.family: font_noto_b.name
                            font.pixelSize: 25
                        }
                    }
                    Rectangle{
                        id: btn_add1
                        width: 85
                        height: width
                        radius: width
                        border.width: 0
                        border.color: "#12d27c"
                        Column{
                            anchors.centerIn: parent
                            Image{
                                source: "icon/icon_annot_save.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                text: "맵 설정"
                                font.family: font_noto_r.name
                                font.pixelSize: 13
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(supervisor.saveAnnotation(map.map_name)){
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : SAVE ANNOTATION")
                                btn_add1.border.width = 3;
                                state_annot = 2;
                                rect_state_annot.color = "#12d27c"
                                state_text_annot.text = "Confirm"
                                state_text_annot.anchors.rightMargin = 50
                                is_save_annot = true;
                            }else{
                                btn_add1.border.width = 0;
                            }
                            btn_next_0.enabled = true;
                        }
                    }
                }
                Rectangle{
                    width: menu_save.width*0.7
                    height: 85
                    visible: false
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    Rectangle{
                        id: rect_server
                        height: 60
                        width: parent.width*0.8
                        radius: 10
                        color: "#12d27c"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        Text{
                            id: rect_server_text
                            text: "확인"
                            anchors.verticalCenter: parent.verticalCenter
                            color: "white"
                            anchors.right: parent.right
                            anchors.rightMargin: 50
                            font.family: font_noto_b.name
                            font.pixelSize: 25
                        }
                    }
                    Rectangle{
                        id: btn_erase
                        width: 85
                        height: width
                        radius: width
                        enabled: supervisor.isConnectServer()
                        color: enabled?"white":"#f4f4f4"
                        Column{
                            anchors.centerIn: parent
                            Image{
                                source: "icon/icon_transmit_server.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                text: "서버에 전송"
                                color: btn_erase.enabled?"black":"white"
                                font.family: font_noto_r.name
                                font.pixelSize: 13
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.sendMaptoServer();
                        }
                    }
                }
            }
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                spacing: 30
                PageIndicator{
                    id: indicator_annot
                    count: 8
                    currentIndex: 7
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    delegate: Rectangle{
                        implicitWidth: index===indicator_annot.currentIndex?10:8
                        implicitHeight: implicitWidth
                        anchors.verticalCenter: parent.verticalCenter
                        radius: width
                        color: index===indicator_annot.currentIndex?"black":"#d0d0d0"
                        Behavior on color{
                            ColorAnimation {
                                duration: 200
                            }
                        }
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Rectangle{
                        id: btn_prev_0
                        width: 180
                        height: 60
                        radius: 10
                        color:"transparent"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "이전"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                supervisor.writelog("[QML] MAP PAGE (ANNOT) -> PASS TO TRAVELLINE")
                                map.init();
                                map.setViewer("annot_tline");
                                map.show_connection = false;
                                loader_menu.sourceComponent = menu_annot_tline;
                            }
                        }
                    }
                    Rectangle{
                        id: btn_next_0
                        width: 180
                        height: 60
                        radius: 10
                        color: enabled?"#12d27c":"#A9A9A9"
                        enabled: false
                        border.width: 1
                        border.color: enabled?"#12d27c":"#A9A9A9"
                        Text{
                            anchors.centerIn: parent
                            text: "확인"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                if(is_init_state){
                                    popup_map_use.open();
                                }else{
                                    map_mode = 0;
                                }
                                supervisor.writelog("[USER INPUT] MAP PAGE (ANNOT) : CONFIRM SAVE ALL")
                                //맵 다시 불러오기
                                supervisor.setMap(map.map_name);
                                map_current.loadmap(map.map_name,"EDITED");

                                loadPage(pinit);
                            }
                        }
                    }
                }
            }


        }

    }


    //Patrol Menu ITEM========================================================
    function updatemap(){
        map.reload();
//        map.clear_canvas();
//        map.update_canvas();
    }

    ////////*********************Timer********************************************************
    Timer{
        id: timer_get_joy
        interval: 100
        running: false
        repeat: true
        onTriggered: {
            joystick_connection = supervisor.isconnectJoy();
            if(joystick_connection){
                if(joy_init){
                    if(joy_axis_left_ud === supervisor.getJoyAxis(1) && joy_axis_right_rl === supervisor.getJoyAxis(2)){

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
                    if(supervisor.getJoyAxis(1) === 0 && supervisor.getJoyAxis(2) === 0){
                        supervisor.writelog("[JOYSTICK] ALL 0 , READ START");
                        joy_init =true;
                    }
                }
            }else{
                joy_init = false;
                joy_axis_left_ud = 0;
                joy_axis_right_rl = 0;
            }
        }
    }
    Timer{
        id: check_slam_init_timer
        interval: 1000
        running: false
        repeat: true
        property int trigger_cnt: 0
        onTriggered: {
            if(supervisor.getLocalizationState() === 2){
                if(slam_initializing == false){
                    supervisor.writelog("[QML] SLAM INIT : SUCCESS")
                    slam_initializing = true;
                    check_slam_init_timer.stop();
                }
            }else{
                if(slam_initializing){
                    supervisor.writelog("[QML] SLAM INIT : FAILED. ")
                    slam_initializing = false;
                    check_slam_init_timer.stop();
                }else{
                    if(trigger_cnt++ > 10){
                        supervisor.writelog("[QML] SLAM INIT : FAILED. TIMEOVER")
                        check_slam_init_timer.stop();
                    }
                }
            }
        }
    }


    //Dialog(Popup) ================================================================

    Popup{
        id: popup_map_use
        width: parent.width
        height: parent.height
        background:Rectangle{
            anchors.fill: parent
            color: "#282828"
            opacity: 0.7
        }
        onOpened: {
            if(is_init_state && !is_save_annot){
                text_warning.visible = true;
                btn_next_00.enabled = false;
            }else{
                text_warning.visible = false;
                btn_next_00.enabled = true;
            }
        }

        Rectangle{
            anchors.centerIn: parent
            width: 450
            height: 250
            color: "white"
            radius: 10

            Column{
                anchors.centerIn: parent
                spacing: 40
                Column{
                    spacing: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: is_init_state && !is_save_annot?"맵 설정이 저장되지 않았습니다.":"이대로 맵을 사용하시겠습니까?"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        id: text_warning
                        visible: false
                        text: "[맵 설정] 버튼을 눌러 저장해주세요.\n 모든 수정을 취소하시려면 오른쪽 상단의 [뒤로가기] 버튼을 누르세요."
                        font.family: font_noto_r.name
                        color: "#E7584D"
                        font.pixelSize: 15
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Rectangle{
                        id: btn_prev_00
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
                            onClicked:{
                                popup_map_use.close();
                            }
                        }
                    }
                    Rectangle{
                        id: btn_next_00
                        width: 180
                        height: 60
                        radius: 10
                        color: enabled?"#12d27c":"#e8e8e8"
                        border.width: 1
                        border.color: "#12d27c"
                        Text{
                            anchors.centerIn: parent
                            text: "확인"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: enabled?"white":"#f4f4f4"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                show_loading();
                                supervisor.writelog("[USER INPUT] USE MAP "+map.map_name);
                                supervisor.setMap(map.map_name);
                                popup_map_use.close();
                                backPage();
                                unshow_loading();
                            }
                        }
                    }
                }
            }
        }

    }

    Popup{
        id: popup_reset_mapping
        width: parent.width
        height: parent.height
        background:Rectangle{
            anchors.fill: parent
            color: "#282828"
            opacity: 0.7
        }
        Rectangle{
            anchors.centerIn: parent
            width: 400
            height: 250
            color: "white"
            radius: 10

            Column{
                anchors.centerIn: parent
                spacing: 20
                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: "맵 생성을 초기화하고 다시 시작하시겠습니까?"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
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
                            onClicked:{
                                popup_reset_mapping.close();
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
                            onClicked:{
                                supervisor.writelog("[USER INPUT] RESET MAPPING ");
                                supervisor.stopMapping();
                                popup_reset_mapping.close();
                            }
                        }
                    }
                }
            }
        }
    }

    Popup{
        id: popup_reset_objecting
        width: parent.width
        height: parent.height
        background:Rectangle{
            anchors.fill: parent
            color: "#282828"
            opacity: 0.7
        }
        Rectangle{
            anchors.centerIn: parent
            width: 400
            height: 250
            color: "white"
            radius: 10

            Column{
                anchors.centerIn: parent
                spacing: 20
                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: "오브젝트 생성을 초기화하고 다시 시작하시겠습니까?"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
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
                            onClicked:{
                                popup_reset_objecting.close();
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
                            onClicked:{
                                supervisor.writelog("[USER INPUT] RESET OBJECTING ");
                                supervisor.stopObjecting();
                                popup_reset_objecting.close();
                            }
                        }
                    }
                }
            }
        }
    }

    Popup{
        id: popup_save_objecting
        width: parent.width
        height: parent.height
        background:Rectangle{
            anchors.fill: parent
            color: "#282828"
            opacity: 0.7
        }
        Rectangle{
            anchors.centerIn: parent
            width: 400
            height: 250
            color: "white"
            radius: 10

            Column{
                anchors.centerIn: parent
                spacing: 20
                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: "오브젝트 맵을 <font color=\"#12d27c\">저장</font>하시겠습니까?"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
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
                            onClicked:{
                                popup_save_objecting.close();
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
                            onClicked:{
                                supervisor.saveObjecting();
                                show_loading();
                                timer_save_objecting.start();
                            }
                        }
                        Timer{
                            id: timer_save_objecting
                            interval: 1000
                            repeat: false
                            running: false
                            onTriggered:{
                                supervisor.writelog("[QML] MAP PAGE : SAVE OBJECTING ");
                                unshow_loading();
                                supervisor.readSetting();
                                popup_save_objecting.close();

                            }
                        }
                    }
                }
            }
        }
    }

    Popup{
        id: popup_save_mapping
        width: parent.width
        height: parent.height
        background:Rectangle{
            anchors.fill: parent
            color: "#282828"
            opacity: 0.7
        }
        Timer{
            id: timer_check_slam
            running: false
            repeat: true
            interval: 100
            onTriggered:{
                if(!supervisor.getLCMConnection()){
                    supervisor.writelog("[QML] MAP PAGE : SLAM RESTART DETECTED");
                    //맵 새로 불러오기.
                    map.loadmap(textfield_name22.text,"RAW");
                    supervisor.readSetting(textfield_name22.text);
                    map.init();
                    map.setViewer("annot_rotate");
                    loader_menu.sourceComponent = menu_annot_rotate;
                    popup_save_mapping.close();
                    timer_check_slam.stop();
                    unshow_loading();
                }
            }
        }
        onOpened: {
            print(supervisor.getnewMapname())
            textfield_name22.text = supervisor.getnewMapname();
        }

        Rectangle{
            anchors.centerIn: parent
            width: 400
            height: 250
            color: "white"
            radius: 10

            Column{
                anchors.centerIn: parent
                spacing: 20
                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: "맵을 <font color=\"#12d27c\">저장</font>하시겠습니까?"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        text: "동일한 이름의 맵은 덮어씌워집니다."
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    Text{
                        text: "맵 이름 : "
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                    }
                    TextField{
                        id: textfield_name22
                        width: 250
                        height: 50
                        placeholderText: qsTr("(영문과 숫자로만 입력해주세요.)")
                        onFocusChanged: {
                            keyboard.owner = textfield_name22;
                            if(focus){
                                keyboard.open();
                            }else{
                                keyboard.close();
                            }
                        }
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
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
                            onClicked:{
                                popup_save_mapping.close();
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
                            onClicked:{
                                supervisor.stopMapping();
                                if(textfield_name22.text == ""){
                                }else{
                                    show_loading();
                                    supervisor.writelog("[QML] MAP PAGE : SAVE MAPPING "+textfield_name22.text);
                                    timer_check_slam.start();
                                    supervisor.saveMapping(textfield_name22.text);

                                    timer_1sec.mapstr = textfield_name22.text;
                                    timer_1sec.start();
//                                    supervisor.setMap(textfield_name22.text);

//                                    //save temp Image
//                                    map.save_map("map_temp.png");

//                                    //임시 맵 이미지를 해당 폴더 안에 넣음.
//                                    supervisor.rotate_map("map_temp.png",textfield_name22.text, 2);
                                }
                            }
                        }
                    }
                }
            }
        }

    }
    Timer{
        id: timer_1sec
        interval: 1000
        property string mapstr:""
        repeat: false
        running: false
        onTriggered:{
            supervisor.setMap(mapstr);
        }
    }

    Popup{
        id: popup_save_rotated
        width: parent.width
        height: parent.height
        background:Rectangle{
            anchors.fill: parent
            color: "#282828"
            opacity: 0.7
        }
        Rectangle{
            anchors.centerIn: parent
            width: 400
            height: 250
            color: "white"
            radius: 10
            Column{
                anchors.centerIn: parent
                spacing: 20
                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: "맵을 <font color=\"#12d27c\">저장</font>하시겠습니까?"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        color: "red"
                        text: "맵이 회전되었습니다. 기존의 설정값을 모두 초기화합니다."
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
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
                            onClicked:{
                                loader_menu.item.valuezero();
//                                slider_rotate.value = 0;
                                map.rotate_map(0);
                                popup_save_rotated.close();
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
                            onClicked:{
                                show_loading();

                                supervisor.writelog("[QML] MAP PAGE : SAVE ROTATE MAP "+supervisor.getMapname());
                                //save temp Image
                                map.save("edited");
                                map.rotate("clear");

                                //맵 새로 불러오기.
                                supervisor.deleteAnnotation();
                                map.loadmap(supervisor.getMapname(),"EDITED");
                                map.setfullscreen();
                                map.init();
                                map.setViewer("annot_drawing");
                                loader_menu.sourceComponent = menu_annot_draw;
                                popup_save_rotated.close();
                                unshow_loading();
                            }
                        }
                    }
                }
            }
        }

    }

    Popup{
        id: popup_save_edited
        width: parent.width
        height: parent.height
        background:Rectangle{
            anchors.fill: parent
            color: "#282828"
            opacity: 0.7
        }
        onOpened:{
            textfield_name.text = supervisor.getMapname();
        }

        Rectangle{
            anchors.centerIn: parent
            width: 400
            height: 250
            color: "white"
            radius: 10

            Column{
                anchors.centerIn: parent
                spacing: 20
                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: "맵을 <font color=\"#12d27c\">저장</font>하시겠습니까?"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        text: "동일한 이름의 맵을 덮어씌워집니다."
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    Text{
                        text: "맵 이름 : "
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                    }
                    TextField{
                        id: textfield_name
                        width: 250
                        height: 50
                        text: supervisor.getMapname();
                        placeholderText: supervisor.getMapname();
                        onFocusChanged: {
                            keyboard.owner = textfield_name;
                            if(focus){
                                keyboard.open();
                                textfield_name.selectAll();
                            }else{
                                keyboard.close();
                            }
                        }
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
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
                            onClicked:{
                                popup_save_edited.close();
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
                            onClicked:{
                                if(textfield_name.text == ""){
                                }else{
                                    show_loading();
                                    supervisor.writelog("[QML] MAP PAGE : SAVE EDITED MAP "+textfield_name.text);
                                    //save temp Image
                                    map.save("edited");

                                    //임시 맵 이미지를 해당 폴더 안에 넣음.
//                                    supervisor.rotate_map("map_edited_temp.png",textfield_name.text, 1);
//                                    supervisor.setMap(textfield_name.text);

                                    //맵 새로 불러오기.
                                    map.loadmap(textfield_name.text,"EDITED");
                                    map.init();
                                    map.setViewer("annot_objecting");
                                    loader_menu.sourceComponent = menu_annot_objecting;
                                    popup_save_edited.close();
                                    unshow_loading();
                                }
                            }
                        }
                    }
                }
            }
        }

    }
    Popup{
        id: popup_save_travelline
        width: parent.width
        height: parent.height
        background:Rectangle{
            anchors.fill: parent
            color: "#282828"
            opacity: 0.7
        }
        property string save_mode: "tline"
        property bool edited_mode: false
        Rectangle{
            anchors.centerIn: parent
            width: 400
            height: 250
            color: "white"
            radius: 10

            Column{
                anchors.centerIn: parent
                spacing: 20
                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: "이대로 <font color=\"#12d27c\">저장</font>하시겠습니까?"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        text: "기존의 파일은 삭제됩니다."
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
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
                            onClicked:{
                                popup_save_travelline.close();
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
                            onClicked:{
                                //save temp Image
                                if(popup_save_travelline.save_mode === "tline"){
                                    supervisor.writelog("[QML] MAP PAGE : SAVE TRAVELLINE ");
                                    map.save("tline");
                                    map.loadmap(supervisor.getMapname(),"T_EDIT");
                                }else if(popup_save_travelline.save_mode === "velmap"){
                                    supervisor.writelog("[QML] MAP PAGE : SAVE VELOCITY MAP ");
                                    map.save("velmap");
                                }
                                popup_save_travelline.close();
                            }
                        }
                    }
                }
            }
        }

    }

    Component {
        id: locationCompo1
        Item {
            width: parent.width
            height: 35
            Text {
                id: text_loc
                anchors.centerIn: parent
                text: name
                font.family: font_noto_r.name
                font.pixelSize: 20
                font.bold: iscol
                color: list_location2.currentIndex==index?"black":"white"
            }
            Rectangle//리스트의 구분선
            {
                id:line
                width:parent.width
                anchors.bottom:parent.bottom//현재 객체의 아래 기준점을 부모객체의 아래로 잡아주어서 위치가 아래로가게 설정
                height:1
                color:"#e8e8e8"
            }
            MouseArea{
                id:area_compo
                anchors.fill:parent
                onClicked: {
                    map.select_location_show = supervisor.getLocNum(name);
                    list_location2.currentIndex = index;
                    map.update_canvas();
                }
            }
        }
    }
    Popup{
        id: popup_add_object
        width: 500
        height: 400
        anchors.centerIn: parent
        bottomPadding: 0
        topPadding: 0
        leftPadding: 0
        rightPadding: 0
        background: Rectangle{
            anchors.fill:parent
            color: "#f4f4f4"
        }
        onOpened: {
            text_annot_obj_name.text= "Object Name : " + select_object_type + "_" + Number(supervisor.getObjectSize(select_object_type))
        }

        Rectangle{
            id: rect_obj_title
            width: parent.width
            height: 50
            color: "#323744"
            Text{
                anchors.centerIn: parent
                text: "가상벽 추가"
                font.pixelSize: 20
                font.family: font_noto_r.name
                color: "white"
            }
        }
        Rectangle{
            id: rect_obj_menu
            anchors.top: rect_obj_title.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: rect_obj_title.horizontalCenter
            height: 100
            width: parent.width
            color: "#e8e8e8"
            Row{
                spacing: 20
                anchors.centerIn: parent
                Rectangle{
                    id: btn_table
                    width: 78
                    height: width
                    radius: width
                    border.width: select_object_type=="Table"?3:0
                    border.color: "#12d27c"
                    Column{
                        anchors.centerIn: parent
                        Image{
                            source: "icon/icon_move.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            text: "테이블"
                            font.family: font_noto_r.name
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            select_object_type = "Table";
                            text_annot_obj_name.text= "Object Name : " + select_object_type + "_" + Number(supervisor.getObjectSize(select_object_type))
                        }
                    }
                }
                Rectangle{
                    id: btn_chair
                    width: 78
                    height: width
                    radius: width
                    border.width: select_object_type=="Chair"?3:0
                    border.color: "#12d27c"
                    Column{
                        anchors.centerIn: parent
                        Image{
                            source: "icon/icon_move.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            text: "의자"
                            font.family: font_noto_r.name
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            select_object_type = "Chair";
                            text_annot_obj_name.text= "Object Name : " + select_object_type + "_" + Number(supervisor.getObjectSize(select_object_type))
                        }
                    }
                }
                Rectangle{
                    id: btn_wall
                    width: 78
                    height: width
                    radius: width
                    border.width: select_object_type=="Wall"?3:0
                    border.color: "#12d27c"
                    Column{
                        anchors.centerIn: parent
                        Image{
                            source: "icon/icon_move.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            text: "벽"
                            font.family: font_noto_r.name
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            select_object_type = "Wall";
                            text_annot_obj_name.text= "Object Name : " + select_object_type + "_" + Number(supervisor.getObjectSize(select_object_type))
                        }
                    }
                }

            }

        }

        Rectangle{
            id: rect_annot_obj_name
            width: parent.width*0.9
            radius: 5
            height: 50
            anchors.horizontalCenter: rect_obj_menu.horizontalCenter
            anchors.top: rect_obj_menu.bottom
            anchors.topMargin: 20
            color: "white"
            Text{
                id: text_annot_obj_name
                anchors.left: parent.left
                anchors.leftMargin: 60
                color: "#282828"
                font.family: font_noto_b.name
                font.pixelSize: 20
                text: "이름 : " + select_object_type + "_" + Number(supervisor.getObjectSize(select_object_type))
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Row{
            anchors.top: rect_annot_obj_name.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: rect_obj_menu.horizontalCenter
            spacing: 20
            Rectangle{
                id: btn_prev_0
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
                    onClicked:{
                        popup_add_object.close();
                    }
                }
            }
            Rectangle{
                id: btn_next_0
                width: 180
                height: 60
                radius: 10
                color: "black"
                border.width: 1
                border.color: "#7e7e7e"
                Text{
                    anchors.centerIn: parent
                    text: "확인"
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                    color: "white"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        supervisor.writelog("[QML] MAP PAGE : SAVE OBJECT -> "+select_object_type + "_" + Number(supervisor.getObjectSize(select_object_type)));

                        map.saveObject(select_object_type);
                        map.setTool("move");

                        supervisor.setObjPose();
                        popup_add_object.close();
                    }
                }
            }
        }

        Rectangle{
            anchors.fill:parent
            color: "transparent"
            border.width: 3
            border.color: "#323744"
        }

    }

    Popup{
        id: popup_add_location
        width: 500
        height: 400
        anchors.centerIn: parent
        bottomPadding: 0
        topPadding: 0
        leftPadding: 0
        rightPadding: 0
        property bool curpose_mode: false
        background: Rectangle{
            anchors.fill:parent
            color: "#f4f4f4"
        }
        onOpened:{
            curpose_mode = false;
            select_location_type = "Serving";
            tfield_location.text = select_location_type + "_" + Number(supervisor.getLocationSize(select_location_type))
            if(curpose_mode){
                if(supervisor.getObsState() || map.checkLocCollision()){
                    btn_next_000.enabled = false;
                    popup_location_warning.open();
                    popup_location_warning.set_obs();
                    supervisor.writelog("[QML] MAP PAGE : SAVE LOCATION -> BUT OBS CLOSE");
                }else{
                    btn_next_000.enabled = true;
                }
            }else{
                if(map.checkLocCollision()){
                    btn_next_000.enabled = false;
                    popup_location_warning.open();
                    popup_location_warning.set_obs();
                    supervisor.writelog("[QML] MAP PAGE : SAVE LOCATION -> BUT OBS CLOSE");
                }else{
                    btn_next_000.enabled = true;
                }
            }

            update();
        }
        function update(){
            model_loc_group.clear();
            for(var i=0; i<supervisor.getLocationGroupNum(); i++){
                model_loc_group.append({"name":supervisor.getLocGroupname(i)});
            }
        }

        Rectangle{
            id: rect_loc_title
            width: parent.width
            height: 50
            color: "#323744"
            Text{
                anchors.centerIn: parent
                text: "위치 추가"
                font.pixelSize: 20
                font.family: font_noto_r.name
                color: "white"
            }
        }
        Rectangle{
            color: "transparent"
            width: parent.width
            height: parent.height - rect_loc_title.height
            anchors.top: rect_loc_title.bottom
            Column{
                anchors.centerIn: parent
                spacing: 20
                Column{
                    id: column_loc
                    width: 500
                    anchors.horizontalCenter: parent.horizontalCenter
                    Row{
                        width: parent.width
                        Rectangle{
                            id: btn_serving
                            width: parent.width/3
                            height: 55
                            color: select_location_type=="Serving"?color_green:"white"
                            border.width: 1
                            border.color: color_mid_gray
                            Text{
                                text: "서빙위치"
                                font.pixelSize: 20
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    select_location_type = "Serving";
                                    tfield_location.text = select_location_type + "_" + Number(supervisor.getLocationSize(select_location_type))
                                }
                            }
                        }
                        Rectangle{
                            id: btn_charging
                            width: parent.width/3
                            height: 55
                            color: select_location_type=="Charging"?color_green:"white"
                            border.width: 1
                            border.color: color_mid_gray
                            Text{
                                text: "충전위치"
                                font.pixelSize: 20
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(supervisor.getLocationNum("Charging") > 0){
                                        popup_location_warning.open();
                                        popup_location_warning.set_overwrite();
                                    }
                                    select_location_type = "Charging";
                                    tfield_location.text = select_location_type
                                }
                            }
                        }
                        Rectangle{
                            id: btn_resting
                            width: parent.width/3
                            height: 55
                            color: select_location_type=="Resting"?color_green:"white"
                            border.width: 1
                            border.color: color_mid_gray
                            Text{
                                text: "대기위치"
                                font.pixelSize: 20
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(supervisor.getLocationNum("Resting") > 0){
                                        popup_location_warning.open();
                                        popup_location_warning.set_overwrite();
                                    }
                                    select_location_type = "Resting";
                                    tfield_location.text = select_location_type
                                }
                            }
                        }
                    }


                    Rectangle{
                        id: rect_loc_menu2
                        height: 80
                        width: parent.width
                        color: "#e8e8e8"
                        visible: select_location_type=="Serving"
                        Rectangle{
                            id:rect_plus
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 30
                            width: 50
                            height: 50
                            radius: 50
                            color: "black"
                            Text{
                                anchors.centerIn: parent
                                text: "+"
                                color: "white"
                                font.family: font_noto_b.name
                                font.pixelSize: 40
                                font.bold : true
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
                                    popup_add_location_group.open();
                                }
                            }
                        }
                        Flickable{
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: rect_plus.right
                            anchors.leftMargin: 20
                            width: parent.width - 80 - rect_plus.width
                            height: parent.height
                            clip: true
                            contentWidth: row_group.width
                            Row{
                                id: row_group
                                spacing: 20
                                anchors.verticalCenter: parent.verticalCenter
                                Repeater{
                                    model:ListModel{id:model_loc_group}
                                    Rectangle{
                                        width: 70
                                        height: 60
                                        radius: 10
                                        anchors.verticalCenter: parent.verticalCenter
                                        border.width: 1
                                        color: cur_group === index ? color_green : "white"
                                        Text{
                                            anchors.centerIn: parent
                                            font.family: font_noto_r.name
                                            font.pixelSize: 15
                                            text: name
                                        }
                                        MouseArea{
                                            anchors.fill: parent
                                            onClicked: {
                                                cur_group = index
                                            }
                                            onDoubleClicked: {
                                                cur_group = index
                                                popup_remove_group.open();
                                            }
                                            onPressAndHold: {
                                                cur_group = index
                                                popup_remove_group.open();

                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Popup{
                    id: popup_remove_group
                    anchors.centerIn: parent
                    width: 500
                    height: 250
                    background: Rectangle{
                        anchors.fill: parent
                        color: "transparent"
                    }
                    property bool alright: true
                    onOpened: {
                        if(supervisor.getLocationGroupSize(cur_group) > 0){
                            alright = false;
                        }else{
                            alright = true;
                        }
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
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.family: font_noto_b.name
                                font.pixelSize: 30
                                visible: popup_remove_group.alright
                                text: "선택하신 그룹을 삭제하시겠습니까?"
                                color: "white"
                            }
                            Text{
                                visible: !popup_remove_group.alright
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.family: font_noto_r.name
                                font.pixelSize: 20
                                color: color_red
                                horizontalAlignment: Text.AlignHCenter
                                text: "그룹 지정된 위치가 존재합니다.\n삭제하려면 그룹을 전부 비워주세요."
                            }
                            Text{
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.family: font_noto_r.name
                                font.pixelSize: 18
                                color: "white"
                                text: "( " + supervisor.getLocGroupname(cur_group) + " )"
                            }
                            Row{
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 30
                                Rectangle{
                                    width: 120
                                    height: 50
                                    radius: 10
                                    border.width: 1
                                    Text{
                                        anchors.centerIn: parent
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                        text: "취소"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            popup_remove_group.close();
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 120
                                    height: 50
                                    radius: 10
                                    enabled: popup_remove_group.alright
                                    border.width: 1
                                    color: popup_remove_group.alright?"white":color_dark_gray
                                    Text{
                                        anchors.centerIn: parent
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                        text: "삭제"
                                        color: popup_remove_group.alright?"black":"white"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            supervisor.removeLocationGroup(cur_group);
                                            popup_remove_group.close();
                                            cur_group = 0;
                                            popup_add_location.update();
                                        }
                                    }
                                }
                            }
                        }
                    }

                }

                TextField{
                    id: tfield_location
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width*0.9
                    height: 50
                    placeholderText: "(loc_name)"
                    font.family: font_noto_r.name
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 20
                    onFocusChanged: {
                        keyboard.owner = tfield_location;
                        tfield_location.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            tfield_location.select(0,0)
                            keyboard.close();
                        }
                    }
                }
                Row{
                    anchors.horizontalCenter: tfield_location.horizontalCenter
                    spacing: 20
                    Rectangle{
                        id: btn_prev_000
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
                            onClicked:{
                                popup_add_location.close();
                            }
                        }
                    }
                    Rectangle{
                        id: btn_next_000
                        width: 180
                        height: 60
                        radius: 10
                        enabled: false
                        color: enabled?"black":color_gray
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "확인"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                if(tfield_location.text == ""){
                                }else{
                                    if(popup_add_location.curpose_mode){
                                        map.savelocation("location_cur",select_location_type, cur_group, tfield_location.text);
                                    }else{
                                        map.savelocation("location",select_location_type,cur_group, tfield_location.text)
                                    }
                                    supervisor.writelog("[QML] MAP PAGE : SAVE LOCATION -> "+select_location_type + ", "+cur_group+", "+tfield_location.text);
                                    map.setTool("move");
                                    map.init();
                                    popup_add_location.close();
                                }
                            }
                        }
                    }
                }
            }
        }

        Rectangle{
            anchors.fill:parent
            color: "transparent"
            border.width: 3
            border.color: "#323744"
        }
    }

    Popup{
        id: popup_add_location_group
        anchors.centerIn: parent
        width: 400
        height: 250
        bottomPadding: 0
        topPadding: 0
        leftPadding: 0
        rightPadding: 0
        background: Rectangle{
            anchors.fill:parent
            color: "white"
        }
        onOpened:{
            tfield_group.text = "";
        }

        Rectangle{
            id: rect_add_loc_group_1
            width: parent.width
            height: 45
            color: "#323744"
            Text{
                anchors.centerIn: parent
                text: "그룹 추가"
                font.pixelSize: 20
                font.family: font_noto_r.name
                color: "white"
            }
        }
        Rectangle{
            color: "transparent"
            width: parent.width
            height: 250 - rect_add_loc_group_1.height
            anchors.bottom: parent.bottom
            Column{
                anchors.centerIn: parent
                spacing: 20

                TextField{
                    id: tfield_group
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: popup_add_location_group.width*0.9
                    height: 50
                    placeholderText: "(group_name)"
                    font.family: font_noto_r.name
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 20
                    onFocusChanged: {
                        keyboard.owner = tfield_group;
                        tfield_group.selectAll();
                        if(focus){
                            keyboard.open();
                        }else{
                            tfield_group.select(0,0)
                            keyboard.close();
                        }
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Rectangle{
                        width: 150
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
                            onClicked:{
                                popup_add_location_group.close();
                            }
                        }
                    }
                    Rectangle{
                        width: 150
                        height: 60
                        radius: 10
                        color: "black"
                        border.width: 1
                        border.color: "#7e7e7e"
                        Text{
                            anchors.centerIn: parent
                            text: "확인"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                if(tfield_group.text == ""){
                                }else{
                                    supervisor.addLocationGroup(tfield_group.text);
                                    supervisor.writelog("[QML] MAP PAGE : ADD LOCATION GROUP -> "+tfield_group.text);
                                    popup_add_location.update();
                                    popup_location_number.readSetting();
                                    cur_group = supervisor.getLocationGroupNum()-1;
                                    popup_add_location_group.close();
                                }
                            }
                        }
                    }
                }
            }
        }
        Rectangle{
            anchors.fill:parent
            color: "transparent"
            border.width: 3
            border.color: "#323744"
        }
    }

    Popup{
        id: popup_location_warning
        anchors.centerIn: parent
        width: 500
        height: 200
        bottomPadding: 0
        topPadding: 0
        leftPadding: 0
        rightPadding: 0
        function set_overwrite(){
            text_msg.text = "이미 설정한 위치가 존재합니다. \n저장하시면 설정된 위치를 덮어씁니다.";
        }
        function set_obs(){
            text_msg.text = "장애물과 너무 가깝습니다. \n위치를 저장할 수 없습니다."
        }

        background: Rectangle{
            anchors.fill:parent
            color: "transparent"
        }
        Rectangle{
            color: color_dark_navy
            anchors.fill: parent
            Column{
                anchors.centerIn: parent
                spacing: 20
                Image{
                    source:"icon/icon_error.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text{
                    id: text_msg
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    color: color_red
                    text: "이미 설정한 위치가 존재합니다. \n저장하시면 설정된 위치를 덮어씁니다."
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    popup_location_warning.close();
                }
            }

        }

    }


    function loadmap(name,type){
        print("map loadmap ",name,type);
        check_slam_init_timer.stop();
        map.loadmap(name,type);
        updatemap();
    }

    function init_map(){
        map.init();
        if(map_mode == 0){
            loader_menu.sourceComponent = menu_main;
            text_menu_title.visible = false;
            map.show_button_lidar = true;
            map.show_button_object = true;
            map.show_button_following = true;
            text_menu_title.text = "";
        }else if(map_mode == 1){
            text_menu_title.text = "맵 새로만들기";
            text_menu_title.visible = true;
            map.show_button_lidar = false;
            map.show_button_object = false;
            map.show_button_following = false;
            map.setViewer("mapping");
            loader_menu.sourceComponent = menu_slam;
        }else if(map_mode == 2){
            text_menu_title.text = "맵 설정";
            text_menu_title.visible = true;
            map.show_button_lidar = true;
            map.show_button_object = true;
            map.show_button_following = true;
            map.setViewer("current");
            loader_menu.sourceComponent = menu_annot_state;
        }else if(map_mode == 3){
            text_menu_title.text = "지정순회";
            text_menu_title.visible = true;
            map.show_button_lidar = true;
            map.show_button_object = true;
            map.show_button_following = true;
            map.setViewer("patrol")
            loader_menu.sourceComponent = menu_patrol;
        }else if(map_mode == 4){
            text_menu_title.visible = true;
            text_menu_title.text = "위치 초기화";
            map.show_button_lidar = true;
            map.show_button_object = true;
            map.show_button_following = true;
            map.setViewer("localization")
            loader_menu.sourceComponent = menu_localization;
        }
    }

    function updateobject(){
        loader_menu.item.update();
    }
    function updatelocation(){
        loader_menu.item.update();
    }
    function updatetravelline(){
        loader_menu.item.update();
    }
    function updatetravelline2(){
        loader_menu.item.update2();
    }
    function updatelistline(){
        loader_menu.item.update();
    }

    Audio{
        id: voice_start_mapping
        autoPlay: false
        volume: parseInt(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_start_mapping.mp3"
    }
    Audio{
        id: voice_stop_mapping
        autoPlay: false
        volume: parseInt(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_stop_mapping.mp3"
    }


    Popup{
        id: popup_help
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        background: Rectangle{
            anchors.fill: parent
            color: color_dark_black
            opacity: 0.7
        }
        onOpened: {
            help_image.play("video/slam_help.gif")
        }
        onClosed:{
            help_image.stop();
        }

        AnimatedImage{
            id: help_image
            enabled: supervisor.getSetting("ROBOT_SW","use_help")==="true"
            anchors.centerIn : parent
            function play(name){
                source = name;
                visible = true;
            }
            function stop(){
                visible = false;
                source = "";
            }
            source:  ""
            cache: false
        }
//        Rectangle{
//            width: parent.width
//            height: parent.height
//            radius: 20
//            Column{
//                spacing: 10
//                anchors.centerIn : parent
//                Text{
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    font.family: font_noto_r.name
//                    font.pixelSize: 30
//                    text: "방법"
//                }
//            }
//        }
        MouseArea{
            anchors.fill: parent
            onClicked:{
                popup_help.close();
            }
        }
    }
}
