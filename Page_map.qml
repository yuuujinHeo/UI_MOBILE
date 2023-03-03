import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0 as Platform
import QtQuick.Shapes 1.12
import QtGraphicalEffects 1.0
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

    property int state_meta: 0
    property int state_annot: 0
    property int state_map: 0

    //mode : 0(mapview) 1:(slam-mapping) 2:(annotation) 3:(patrol) 4: (slam-localization)
    property int map_mode: 0

    property bool is_mapping: false

    //0: location 1: record 2: random
    property int patrol_mode: 2
    property bool recording: false

    property bool is_init_state: false
    property bool is_save_annot: false

    //annotation
    property string select_object_type: "Wall"
    property string select_location_type: "Serving"
    property int select_tline_num: -1
    property int select_tline_category: -1
    property int select_patrol_num: -1

    Tool_Keyboard{
        id: keyboard
    }

    onSelect_patrol_numChanged: {
        loader_menu.item.setindex(select_patrol_num);
    }

    function set_map_raw(){
        map.map_mode = "RAW";
    }

    function update_mapping(){
        if(map_mode == 1){
            map.loadmapping();
        }
    }

    Component.onCompleted: {
        init_map();

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
            timer_get_joy.stop();
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

    function modeinit(){
        init_map();
        map_cur.visible = true;
        map_annot.visible = false;
        map_cur.opacity = 1;

        rect_menus.width = margin_name;
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
        width: margin_name
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
        Rectangle{
            id: rect_mapview
            anchors.fill: parent
            color: "#282828"
            Text{
                id: text_curmap
                color:"white"
                text: "Map Viewer"
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
                width: 500
                height: 500
                show_robot: true
                show_path: true
                robot_following: true
                show_lidar: true
                show_buttons: true
                show_connection: true
                show_object: true
                show_icon_only: true
                show_location: true
                anchors.horizontalCenter: text_curmap.horizontalCenter
//                anchors.leftMargin: parent.width/2 - width/2
                anchors.top: text_curmap.bottom
                anchors.topMargin: 10
            }
//          Text{
//              text: "수동 조작\n(lock on-off)"
//              anchors.horizontalCenter: switch_joy.horizontalCenter
//              anchors.bottom: switch_joy.top
//              anchors.bottomMargin: 20
//              font.family: font_noto_r.name
//              color: "white"
//              font.pixelSize: 15
//              horizontalAlignment: Text.AlignHCenter
//          }
//          Item_switch{
//              id: switch_joy
//              enabled: false
//              anchors.left: map_current.right
//              anchors.leftMargin: 50
//              anchors.bottom: map_current.bottom
//              onoff: false
//              touchEnabled: false
//          }

            Row{
                anchors.top: map_current.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: map_current.horizontalCenter
                spacing: 100
                Item_joystick{
                    id: joy_xy
                    verticalOnly: true
                    onUpdate_cntChanged: {
                        print("XY : ",update_cnt,supervisor.getJoyXY())
                        if(update_cnt == 0 && supervisor.getJoyXY() != 0){
                            supervisor.joyMoveXY(0, 0);
                        }else if(update_cnt > 2){
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
                        print("R : ",update_cnt,supervisor.getJoyR())
                        if(update_cnt == 0 && supervisor.getJoyR() != 0){
                            supervisor.joyMoveR(0, 0);
                        }else if(update_cnt > 2){
                            if(fingerInBounds) {
                                supervisor.joyMoveR(-Math.cos(angle) * Math.sqrt(fingerDistance2) / distanceBound);
                            } else {
                                supervisor.joyMoveR(-Math.cos(angle));
                            }
                        }
                    }
                }

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
                spacing: 50
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater{
                    model: ["mapping","localization","annotation","patrol"]
                    Rectangle{
                        property int btn_size: 120
                        width: btn_size
                        height: btn_size
                        radius: btn_size
                        color: "white"
                        Rectangle{
                            id: rect_btn
                            width: btn_size
                            height: btn_size
                            radius: 12
                            color: "white"
                            Column{
                                anchors.centerIn: parent
                                spacing: 5
                                Image{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    source: {
                                        if(modelData == "mapping"){
                                            "image/image_slam.png"
                                        }else if(modelData == "localization"){
                                            "image/image_annot.png"
                                        }else if(modelData == "annotation"){
                                            "image/image_annot.png"
                                        }else if(modelData == "patrol"){
                                            "image/image_patrol.png"
                                        }
                                    }
                                }
                                Text{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: font_noto_r.name
                                    font.pixelSize: 20
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
                                if(modelData == "mapping"){
                                    map_mode = 1;
                                }else if(modelData == "annotation"){
                                    map_mode = 2;
                                    supervisor.setAnnotEditFlag(true);
                                }else if(modelData == "localization"){
                                    map_mode = 4;
                                }else if(modelData == "patrol"){
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
                    backPage();
                }else{
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
            function remote_input_xy(value1,value2){
                if(value1 == 0 && value2 == 0){
                    joy_xy.remote_stop();
                }else{
                    joy_xy.remote_input(value1,value2);
                }
            }
            function remote_input_th(value1,value2){
                if(value1 == 0 && value2 == 0){
                    joy_th.remote_stop();
                }else{
                    joy_th.remote_input(value1,value2);
                }
            }


            property var count_u : 0
            property var count_d : 0
            property var count_l : 0
            property var count_r : 0
            property var prev_u : 0
            property var prev_d : 0
            property var prev_l : 0
            property var prev_r : 0


            function setKeyUp(pressed){
                if(pressed){
                    keyboard_arrow.pressed_up = pressed;
                    count_u = 0;
                }else{
                    count_u++;
                }

            }
            function setKeyDown(pressed){
                if(pressed){
                    keyboard_arrow.pressed_down= pressed;
                    count_d = 0;
                }else{
                    count_d++;
                }
            }
            function setKeyLeft(pressed){
                if(pressed){
                    keyboard_arrow.pressed_left = pressed;
                    count_l = 0;
                }else{
                    count_l++;
                }
            }
            function setKeyRight(pressed){
                if(pressed){
                    keyboard_arrow.pressed_right = pressed;
                    count_r = 0;
                }else{
                    count_r++;
                }
            }
            Timer{
                id: timer_check_keyboard
                running: supervisor.getEmoStatus()?false:true
                repeat: true
                interval: 500
                onTriggered: {
                    if(prev_u == count_u && count_u > 0){
                        keyboard_arrow.pressed_up = false;
                    }
                    if(prev_d == count_d && count_d > 0){
                        keyboard_arrow.pressed_down = false;
                    }
                    if(prev_r == count_r && count_r > 0){
                        keyboard_arrow.pressed_right = false;
                    }
                    if(prev_l == count_l && count_l > 0){
                        keyboard_arrow.pressed_left = false;
                    }
                    prev_u = count_u;
                    prev_d = count_d;
                    prev_r = count_r;
                    prev_l = count_l;
                }
            }

            function getKeyUp(){
                return keyboard_arrow.pressed_up
            }
            function getKeyDown(){
                return keyboard_arrow.pressed_down
            }
            function getKeyLeft(){
                return keyboard_arrow.pressed_left
            }
            function getKeyRight(){
                return keyboard_arrow.pressed_right
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
                    text: "Mapping"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id: btn_save_map
                width: 100
                height: 40
                radius: 5
                anchors.bottom: rect_annot_box444.top
                anchors.bottomMargin: 10
                anchors.left: rect_annot_box444.left
                color: "black"
                Text{
                    anchors.centerIn: parent
                    text: "Save"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        popup_save_mapping.open();
                    }
                }
            }
            Rectangle{
                id: rect_annot_box444
                width: parent.width - 60
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 80
                color: "white"
                Text{
                    text: "Grid Size"
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 50
                }
                ComboBox{
                    id: combobox_gridsize
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 50
                    width: 200
                    height: 40
                    currentIndex: 1
                    model:["3cm","5cm"]
                }
            }

            Rectangle{
                id: rect_annot_box
                width: parent.width - 60
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_box444.bottom
                anchors.topMargin: 3
                color: "#e8e8e8"
                Row{
                    anchors.centerIn: parent
                    spacing: 30
                    Item_button{
                        id: btn_start
                        width: 78
                        running: is_mapping
                        icon: "icon/icon_run.png"
                        name: "Start"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(supervisor.getLCMConnection()){
                                    map.map_mode = "MAPPING";
                                    if(combobox_gridsize.currentText === "3cm"){
                                        map.grid_size = 0.03;
                                        supervisor.startMapping(0.03);
                                    }else if(combobox_gridsize.currentText === "5cm"){
                                        map.grid_size = 0.05;
                                        supervisor.startMapping(0.05);
                                    }
                                }
                            }
                        }
                    }
                    Item_button{
                        id: btn_stop
                        width: 78
                        icon: "icon/icon_stop.png"
                        name: "Stop"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.stopMapping();
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
                    if(supervisor.getMappingflag()){
                        is_mapping = true;
                    }else{
                        is_mapping = false;
                    }

                    if(supervisor.getEmoStatus()){
                        timer_check_keyboard.stop();
                        timer_get_joy.stop();
                        col_manual.visible = true;
                        switch_joy.onoff = true;
                        row_joysticks.visible = false;
                        keyboard_arrow.visible = false;
                    }else{
                        if(row_joysticks.visible || keyboard_arrow.visible){
                            col_manual.visible = false;
                        }else{
                            col_manual.visible = true;
                        }
                        switch_joy.onoff = false;
                    }
                }
            }
            Column{
                anchors.top: rect_annot_box.bottom
                anchors.topMargin: 10
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
                        Row{
                            spacing: 30
                            anchors.horizontalCenter: parent.horizontalCenter
                            Rectangle{
                                width: 100
                                height: 40
                                radius: 5
                                color: "black"
                                Text{
                                    anchors.centerIn: parent
                                    color: "white"
                                    text: "가상 조이스틱"
                                    font.pixelSize: 15
                                    font.family: font_noto_r.name
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        row_joysticks.visible = true;
                                        col_manual.visible = false;
                                        keyboard_arrow.visible = false;
                                    }
                                }
                            }
                            Rectangle{
                                width: 100
                                height: 40
                                radius: 5
                                color: "black"
                                Text{
                                    anchors.centerIn: parent
                                    color: "white"
                                    text: "가상 키보드"
                                    font.pixelSize: 15
                                    font.family: font_noto_r.name
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        row_joysticks.visible = false;
                                        col_manual.visible = false;
                                        keyboard_arrow.visible = true;
                                    }
                                }
                            }
                        }
                    }
                }

                Row{
                    id: row_joysticks
                    visible: false
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 60
                    Item_joystick{
                        id: joy_xy
                        verticalOnly: true
                        bold: true
                        onUpdate_cntChanged: {
                            if(update_cnt == 0 && supervisor.getJoyXY() != 0){
                                supervisor.joyMoveXY(0, 0);
                            }else if(update_cnt > 2){
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
                        bold: true
                        onUpdate_cntChanged: {
                            if(update_cnt == 0 && supervisor.getJoyR() != 0){
                                supervisor.joyMoveR(0, 0);
                            }else if(update_cnt > 2){
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
                    id: keyboard_arrow
                    visible : false
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Column{
                    id: col_manual
                    visible: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 5
                    Item_switch{
                        id: switch_joy
                        enabled: supervisor.getLCMConnection()
                        onoff: supervisor.getEmoStatus()?true:false
                        touchEnabled: false
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "수동 조작"
                        font.family: font_noto_r.name
                        font.pixelSize: 10
                        horizontalAlignment: Text.AlignHCenter
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
                        timer_check_localization.stop();
                    }else if(supervisor.getLocalizationState() === 0 || supervisor.getLocalizationState() === 3){
                        timer_check_localization.stop();
                        btn_auto_init.running = false;
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
                                map.reset_canvas();
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
                                if(supervisor.getLocalizationState() !== 1){
                                    btn_auto_init.running = true;
                                    supervisor.slam_autoInit();
                                    timer_check_localization.start();
                                }

                            }
                        }
                    }
                }
            }
            Rectangle{
                width: rect_menus.width - 60
                height: 100
                visible: map.tool==="SLAM_INIT"?true:false
                anchors.top: rect_annot_box.bottom
                anchors.topMargin: 50
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
                                map.reset_canvas();
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
                                map.reset_canvas();
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

            Rectangle{
                width: parent.width*0.9
                height: 200
                radius: 10
//                anchors.bottom: parent.bottom
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 100
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

    Component{
        id: menu_patrol
        Item{
            objectName: "menu_patrol"
            property var curindex: 0
            function setindex(index){
                curindex = index;
            }
            function viewlast(){
                area_patrol_list.contentY = area_patrol_list.contentHeight
            }
            Component.onCompleted: {
                patrol_location_model.clear();
                if(supervisor.getPatrolFileName()===""){
                    text_patrol_name.text = "설정 된 파일이 없습니다.";
                    start_point.location_text = "";
                }else{
                    text_patrol_name.text = supervisor.getPatrolFileName();
                    supervisor.loadPatrolFile(supervisor.getPatrolFileName());

                    for(var i=0; i<supervisor.getPatrolNum(); i++){
                        if(i===0){
                            start_point.location_text = supervisor.getPatrolLocation(0);
                        }else{
                            patrol_location_model.append({name:supervisor.getPatrolType(i),location:supervisor.getPatrolLocation(i),loc_x:supervisor.getPatrolX(i),loc_y:supervisor.getPatrolY(i),loc_th:supervisor.getPatrolTH(i)});

                        }
                    }
                }
            }
            function update(){
                supervisor.setPatrolMode(2);
                patrol_location_model.clear();
                patrol_mode = supervisor.getPatrolMode();
                if(supervisor.getPatrolFileName()===""){
                    text_patrol_name.text = "설정 된 파일이 없습니다.";
                }else{
                    text_patrol_name.text = supervisor.getPatrolFileName();

                    for(var i=0; i<supervisor.getPatrolNum(); i++){
                        if(i===0){
                            start_point.location_text = supervisor.getPatrolLocation(0);
                        }else{
                            patrol_location_model.append({name:supervisor.getPatrolType(i),location:supervisor.getPatrolLocation(i),loc_x:supervisor.getPatrolX(i),loc_y:supervisor.getPatrolY(i),loc_th:supervisor.getPatrolTH(i)});

                        }
                    }


                }
            }

            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }


            //New, Load, Save
            //Mode : Location, Record, Random
            //Tool :
            Rectangle{
                id: rect_annot_map_name
                width: parent.width*0.9
                radius: 5
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 20
                color: "white"
                Row{
                    anchors.centerIn: parent
                    spacing: 10
                    Text{
                        color: "#282828"
                        font.family: font_noto_b.name
                        font.pixelSize: 20
                        text: "NAME : "
                    }
                    Text{
                        id: text_patrol_name
                        color: "#282828"
                        font.family: font_noto_b.name
                        font.pixelSize: 20
                        text: supervisor.getPatrolFileName()==""?"설정 된 파일이 없습니다.":supervisor.getPatrolFileName()
                    }
                }

            }
            Row{
                anchors.bottom: rect_menu_box.top
                anchors.bottomMargin: 10
                anchors.horizontalCenter: rect_menu_box.horizontalCenter
                spacing: 20
                Rectangle{
                    id: btn_load_map
                    width: 100
                    height: 40
                    radius: 5
                    color: "black"
                    Text{
                        anchors.centerIn: parent
                        text: "New"
                        color: "white"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
//                            if(supervisor.getPatrolMode() == 0){
//                                stackview_patrol_menu.push(menu_patrol_location);
//                                supervisor.makePatrol();
//                                supervisor.addPatrol("START","Resting_0",0,0,0);
//                            }else{
//                                stackview_patrol_menu.push(menu_patrol_record);
//                            }
                            update_patrol_location();
                        }
                    }
                }
                Rectangle{
                    id: btn_new_patrol
                    width: 100
                    height: 40
                    radius: 5
                    color: "black"
                    Text{
                        anchors.centerIn: parent
                        text: "Load"
                        color: "white"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
//                            fileopenpatrol.open();
                        }
                    }
                }
                Rectangle{
                    id: btn_save_map
                    width: 100
                    height: 40
                    radius: 5
                    color: "black"
                    Text{
                        anchors.centerIn: parent
                        text: "Save"
                        color: "white"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            if(supervisor.getPatrolFileName() === ""){
//                                filesavepatrol.open();
                            }else{
//                                supervisor.savePatrolFile(supervisor.getPatrolFileName());
                            }

                        }
                    }
                }
            }
            Rectangle{
                id: rect_menu_box
                width: parent.width - 60
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_map_name.bottom
                anchors.topMargin: 60
                color: "#e8e8e8"

                Row{
                    anchors.centerIn: parent
                    spacing: 20
                    Item_button{
                        id: btn_location
                        width: 78
                        highlight: patrol_mode === 0
                        icon: "icon/icon_point.png"
                        name: "Location"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.setPatrolMode(0);
                            }
                        }
                    }
                    Item_button{
                        width: 78
                        highlight: patrol_mode  === 1
                        icon: "icon/record_r.png"
                        name: "Record"
                        enabled: false
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.setPatrolMode(1);
                            }
                        }
                    }
                    Item_button{
                        width: 78
                        highlight: patrol_mode  === 2
                        icon: "icon/icon_run.png"
                        name: "Random"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.setPatrolMode(2);
                            }
                        }
                    }
                }
            }

            Rectangle{
                id: rect_patrol_location
                width: rect_menu_box.width
                height: parent.height - rect_menu_box.y - rect_menu_box.height
                anchors.top: rect_menu_box.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                visible: patrol_mode===0
                Rectangle{
                    id: rect_location
                    width: 60
                    height: parent.height*0.9
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    color: "#e8e8e8"

                    Column{
                        anchors.centerIn: parent
                        spacing: 20
                        Item_button{
                            id: btn_move
                            width: 40
                            highlight: map.tool=="MOVE"
                            icon: "icon/icon_move.png"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "MOVE";
                                    map.reset_canvas();
                                }
                            }
                        }
                        Item_button{
                            width: 40
                            highlight: map.tool=="SLAM_INIT"
                            icon: "icon/icon_add.png"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(map.tool == "ADD_PATROL_LOCATION"){
                                        if(canvas_location.isnewLoc && canvas_location.new_loc_available){
                                            supervisor.addPatrol("POINT","MANUAL",canvas_location.new_loc_x, canvas_location.new_loc_y, canvas_location.new_loc_th+Math.PI/2);
                                            update_patrol_location();
                                        }
                                        canvas_location.isnewLoc = false;
                                        map.tool = "MOVE";
                                        map.reset_canvas();
                                    }else{
                                        updatelocation();
                                        popup_add_patrol.open();
                                    }
                                    map.select_patrol = -1;
                                }
                            }
                        }
                        Item_button{
                            width: 40
                            icon: "icon/icon_erase.png"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    supervisor.removePatrol(map.select_patrol);
                                    map.select_patrol = -1;
                                    update_patrol_location();
                                }
                            }
                        }

                        Item_button{
                            width: 40
                            highlight: map.tool=="SLAM_INIT"
                            icon: "icon/joy_up.png"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    supervisor.movePatrolUp(map.select_patrol);
                                    update_patrol_location();
                                    if(map.select_patrol>1){
                                        map.select_patrol = map.select_patrol - 1;
                                        select_patrol_num--;
                                    }
                                }
                            }
                        }

                        Item_button{
                            width: 40
                            highlight: map.tool=="SLAM_INIT"
                            icon: "icon/joy_down.png"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    supervisor.movePatrolDown(map.select_patrol);
                                    update_patrol_location();
                                    if(map.select_patrol<supervisor.getPatrolNum()-1 && map.select_patrol > 0){
                                        map.select_patrol = map.select_patrol+ 1;
                                        select_patrol_num++;
                                    }
                                }
                            }
                        }
                    }

                }
                Flickable{
                    id: area_patrol_list
                    width: parent.width - rect_location.width
                    height: rect_location.height
                    contentHeight: column_patrol.height
                    clip: true
                    anchors.top: rect_location.top
                    Column{
                        id: column_patrol
                        Rectangle{
                            id: start_point
                            radius: 5
                            property string location_text: ""
                            width: area_patrol_list.width
                            height: 40
                            color: "#83B8F9"
                            //Image (+,-)

                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                font.family: font_noto_r.name
                                font.pixelSize: 20
                                text: "Start"
                            }
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                font.family: font_noto_r.name
                                font.pixelSize: 15
                                text: start_point.location_text
                            }
                            MouseArea{
                                id:area_compo
                                anchors.fill:parent
                                onClicked: {
                                    select_patrol_num = 0;
                                    map.select_patrol = 0;
                                    updatecanvas();
                                }
                            }
                        }
                        Repeater{
                            id: repeat_patrol
                            model: patrol_location_model

                            Rectangle{
                                width: parent.width
                                height: 70
                                color: "transparent"


                                Rectangle{
                                    width: parent.width
                                    height: 30
                                    anchors.top: parent.top
                                    color: "transparent"
                                    Image{
                                        id: image_down
                                        anchors.centerIn: parent
                                        width: 22
                                        height: 10
                                        source: "icon/patrol_down.png"
                                    }
                                    ColorOverlay{
                                        anchors.fill: image_down
                                        source: image_down
                                        color: "#282828"
                                    }
                                }

                                Rectangle{
                                    width: parent.width
                                    color: "transparent"
                                    height: 40
                                    anchors.bottom: parent.bottom
                                    Rectangle{
                                        id: num
                                        height: parent.height
                                        width: parent.height
                                        color: "black"
                                        Text{
                                            anchors.centerIn: parent
                                            font.family: font_noto_r.name
                                            color: "white"
                                            text: index+1
                                            font.pixelSize: 20
                                        }
                                    }
                                    Rectangle{
                                        width: parent.width-parent.height
                                        radius: 5
                                        height: 40
                                        anchors.left: num.right
                                        anchors.bottom: parent.bottom
                                        color: {
                                            if(select_patrol_num == index+1){
                                                "#FFD9FF"
                                            }else{
                                                "white"
                                            }
                                        }
                                        border.width: 1
                                        border.color: "#7e7e7e"


                                        Rectangle{
                                            width: (parent.width)*0.3
                                            height: parent.height
                                            color: "transparent"
                                            Text{
                                                anchors.centerIn: parent
                                                font.family: font_noto_r.name
                                                font.pixelSize: 20
                                                text: name
                                            }
                                        }
                                        Rectangle{
                                            width: (parent.width)*0.7
                                            height: parent.height
                                            color: "transparent"
                                            anchors.right: parent.right
                                            Text {
                                                anchors.centerIn: parent
                                                text: location
                                                font.family: font_noto_r.name
                                                font.pixelSize: 15
                                            }
                                        }
                                        MouseArea{
                                            anchors.fill:parent
                                            onClicked: {
                                                if(map.tool == "ADD_PATROL_LOCATION"){
                                                    map.tool = "MOVE";
                                                    map.reset_canvas();
                                                }
                                                select_patrol_num = index + 1;
                                                map.select_patrol = index + 1;
                                                updatecanvas();
                                            }
                                        }
                                    }

                                }
                            }
                        }
                    }
                }

            }

            Rectangle{
                id: rect_patrol_record
                width: parent.width
                height: parent.height - rect_menu_box.y - rect_menu_box.height
                anchors.top: rect_menu_box.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                visible: patrol_mode===1
                Rectangle{
                    id: rect_record
                    width: parent.width - 60
                    height: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    color: "#e8e8e8"

                    Row{
                        anchors.centerIn: parent
                        spacing: 30
                        Item_button{
                            width: 78
                            highlight: recording
                            icon: "icon/record_r.png"
                            name: "Move"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    recording = true;
                                }
                            }
                        }
                        Item_button{
                            width: 78
                            highlight: !recording
                            icon: "icon/stop_r.png"
                            name: "Point"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    recording = false;
                                }
                            }
                        }
                    }
                }

            }

            Rectangle{
                id: rect_patrol_random
                width: parent.width
                height: parent.height - rect_menu_box.y - rect_menu_box.height
                anchors.top: rect_menu_box.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                visible: patrol_mode===2
                Column{
                    anchors.centerIn: parent
                    spacing: 50
                    Rectangle{
                        width: 200
                        height: 80
                        visible: false
                        radius: 10
                        Text{
                            anchors.centerIn: parent
                            text: "서빙 포인트 순회"
                            font.family: font_noto_r.name
                            font.pixelSize: 15

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                // start random patrol (serving)
                                if(supervisor.getuistate() === 2){//ROBOT READY
                                    supervisor.runRotateTables();
                                }

                            }
                        }
                    }
                    Rectangle{
                        width: 200
                        height: 80
                        radius: 10
                        Text{
                            anchors.centerIn: parent
                            text: "랜덤 서빙"
                            font.family: font_noto_r.name
                            font.pixelSize: 15

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                // start random patrol (serving)
                                if(supervisor.getuistate() === 2){//ROBOT READY
                                    supervisor.startServingTest();
                                }
                            }
                        }
                    }
                }
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
                        text: "Map Meta Data"
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
                        Item_button{
                            width: 80
                            shadow_color: color_gray
                            icon: "icon/icon_move.png"
                            name: "DRAWING"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    supervisor.clear_all();
                                    map.state_annotation = "DRAWING";
                                    loader_menu.sourceComponent = menu_annot_draw;
                                }
                            }
                        }
                        Item_button{
                            width: 80
                            shadow_color: color_gray
                            highlight: map.tool=="SLAM_INIT"
                            icon: "icon/icon_point.png"
                            name: "OBJECT"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    supervisor.clear_all();
                                    map.state_annotation = "OBJECT";
                                    loader_menu.sourceComponent = menu_annot_object;
                                }
                            }
                        }
                        Item_button{
                            id: btn_auto_init
                            width: 78
                            shadow_color: color_gray
                            icon:"icon/icon_auto_init.png"
                            name:"LOCATION"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.init_mode();
                                    map.state_annotation = "LOCATION";
                                    loader_menu.sourceComponent = menu_annot_location;
                                }
                            }
                        }
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
                        text: is_init_state?"MAP : " + map.map_name:"MAP : " + supervisor.getMapname();
                        horizontalAlignment: Text.AlignHCenter
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
                            text: "Map"
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
                            text: is_init_state?map.map_name:supervisor.getMapname();
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "Width"
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
                            text: supervisor.getMapWidth();
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "Height"
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
                            text: supervisor.getMapHeight();
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "Grid Width"
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
                            text: supervisor.getGridWidth().toFixed(2);
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
                            text: "Serving Location"
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
                            text: supervisor.getLocationSize("Serving");
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "Resting Location"
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
                            text: supervisor.getLocationSize("Resting");
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "Charging Location"
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
                            text: supervisor.getLocationSize("Charging");
                        }
                        Text{
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            text: "Object Num"
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
                            text: supervisor.getObjectNum();
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
                    count: 6
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
                            text: "Previous"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
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
                            text: "Next"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                map.state_annotation = "DRAWING";
                                map.init_mode();
                                map.show_connection = false;
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
                    text: "STEP 1. Map Load and Rotate"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id: btn_load_map
                width: 100
                height: 40
                radius: 5
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 30
                anchors.left: parent.left
                anchors.leftMargin: 30
                color: "black"
                Text{
                    anchors.centerIn: parent
                    text: "Load"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        fileload.open();
                    }
                }
            }
            Rectangle{
                id: rect_annot_map_name
                width: parent.width*0.9
                radius: 5
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: btn_load_map.bottom
                anchors.topMargin: 20
                color: "white"
                Text{
                    anchors.centerIn: parent
                    color: "#282828"
                    font.family: font_noto_b.name
                    font.pixelSize: 20
                    text: is_init_state?"MAP : " + map.map_name:"MAP : " + supervisor.getMapname();
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
                    text: "Rotate Map"
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
                            slider_rotate.value = 0;
                            map.rotate_map(0);
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
                        map.rotate_map(value - angle_init);
                    }
                    onPressedChanged: {
                        if(pressed){
                            angle_init = value;
                        }else{
                            //released
                            map.rotate_map(value - angle_init);
//                                    print(value, angle_init);
                        }
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
                    text: "Rotate Map (1도단위)"
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
                        width: 50
                        height: 30
                        color: "black"
                        radius: 5
                        Text{
                            anchors.centerIn: parent
                            text: "<-"
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                slider_rotate.value--;
                            }
                        }
                    }
                    Rectangle{
                        width: 50
                        height: 30
                        color: "black"
                        radius: 5
                        Text{
                            anchors.centerIn: parent
                            text: "->"
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                slider_rotate.value++;
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
                    count: 6
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
                            text: "Previous"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                map.init_mode();
                                map.state_annotation = "NONE";
                                map.show_connection = false;
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
                            text: "Next"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                //변경한게 있으면(drawing or rotate)
                                if(slider_rotate.value != 0){
                                    supervisor.setAnnotEditFlag(true);
                                    popup_save_rotated.open();
                                }else if(state_map == 0){
                                    //raw파일이었으면
                                    popup_save_rotated.open();
                                }else{
                                    //아무 변경이 없으면
                                    supervisor.clear_all();
                                    map.state_annotation = "DRAWING";
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
                    text: "STEP 1. Map Load and Edit"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id: btn_load_map
                width: 100
                height: 40
                radius: 5
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 30
                anchors.left: parent.left
                anchors.leftMargin: 30
                color: "black"
                Text{
                    anchors.centerIn: parent
                    text: "Load"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 15
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        fileload.open();
                    }
                }
            }

            Row{
                spacing: 30
                anchors.top: btn_load_map.top
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
                            supervisor.undo();
                            map.update_canvas();
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
                            supervisor.redo();
                            map.update_canvas();
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
                    if(supervisor.getCanvasSize() > 0)
                        btn_undo.enabled = true;
                    else
                        btn_undo.enabled = false;
                    if(supervisor.getRedoSize() > 0)
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
                anchors.top: btn_load_map.bottom
                anchors.topMargin: 15
                color: "#e8e8e8"

                Row{
                    anchors.centerIn: parent
                    spacing: 30
                    Rectangle{
                        id: btn_move
                        width: 78
                        height: width
                        radius: width
                        border.width: map.tool=="MOVE"?3:0
                        border.color: "#12d27c"
                        Column{
                            anchors.centerIn: parent
                            Image{
                                source: "icon/icon_move.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                text: "Move"
                                font.family: font_noto_r.name
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                map.tool = "MOVE";
                            }
                        }
                    }
                    Rectangle{
                        id: btn_draw
                        width: 78
                        height: width
                        radius: width
                        border.width: map.tool=="BRUSH"?3:0
                        border.color: "#12d27c"
                        Column{
                            anchors.centerIn: parent
                            Image{
                                source: "icon/icon_draw.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                text: "Draw"
                                font.family: font_noto_r.name
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                map.tool = "BRUSH";
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
                                text: "Clear"
                                font.family: font_noto_r.name
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.clear_all();
                                map.update_canvas();
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
                            text: "Color"
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
                                model: ["#000000", "#7f7f7f", "#ffffff"]
                                Rectangle {
                                    id: red
                                    width: map.tool=="BRUSH"?(map.brush_color==modelData?26:23):23
                                    height: width
                                    radius: width
                                    color: modelData
                                    border.color: map.tool=="BRUSH"?(map.brush_color==modelData?"#12d27c":"black"):"black"
                                    border.width: map.tool=="BRUSH"?(map.brush_color==modelData?3:1):1
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            map.brush_color = color
                                            map.tool = "BRUSH";
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
                            text: "Brush Size"
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
                            value: 15
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 30
                            width: 170
                            height: 18
                            from: 0.1
                            to : 50
                            onValueChanged: {
                                map.brush_size = value;
                                print("slider : " +map.brush_size);
                            }
                            onPressedChanged: {
                                if(slider_brush.pressed){
                                    map.brushchanged();
                                }else{
                                    map.brushdisappear();
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
                    count: 6
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
                            text: "Previous"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                map.init_mode();
                                map.state_annotation = "DRAWING";
                                map.show_connection = false;
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
                            text: "Next"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                popup_save_edited.unshow_rotate();
                                //변경한게 있으면(drawing or rotate)
                                if(supervisor.getCanvasSize() > 0){
                                    supervisor.setAnnotEditFlag(true);
                                    popup_save_edited.open();
                                }else if(state_map == 0){
                                    //raw파일이었으면
                                    popup_save_edited.open();
                                }else{
                                    //아무 변경이 없으면
                                    supervisor.clear_all();
                                    map.state_annotation = "OBJECT";
                                    loader_menu.sourceComponent = menu_annot_object;

                                }


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

            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }

            Component.onCompleted: {
                var ob_num = supervisor.getObjectNum();
                list_object.model.clear();
                for(var i=0; i<ob_num; i++){
                    list_object.model.append({"name":supervisor.getObjectName(i)});
                }
                map.update_canvas();
                map.setfullscreen();
            }
            function update(){
                var ob_num = supervisor.getObjectNum();
                list_object.model.clear();
                for(var i=0; i<ob_num; i++){
                    list_object.model.append({"name":supervisor.getObjectName(i)});
                }
                list_object.currentIndex = ob_num-1;
                map.update_canvas();
            }
            function getcur(){
                return list_object.currentIndex;
            }
            function setcur(index){
                list_object.currentIndex = index;
            }

            function check_object_size(){
                if(supervisor.getTempObjectSize() > 2){
                    btn_save_object.enabled = true;
                }else{
                    btn_save_object.enabled = false;
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
                    text: "STEP 2. Add/Edit Object"
                    horizontalAlignment: Text.AlignHCenter
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
                            map.select_object = supervisor.getObjNum(name);
                            list_object.currentIndex = index;
                            map.tool = "MOVE";
                            map.reset_canvas();
                            map.update_canvas();
                        }
                    }
                }
            }

            Column{
                width: parent.width - 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 20
                spacing: 10
                Rectangle{
                    id: rect_annot_box
                    width: parent.width
                    height: 100
                    color: "#e8e8e8"
                    Row{
                        id: row_annot_loc
                        anchors.centerIn: parent
                        spacing: 15
                        Rectangle{
                            id: btn_move
                            width: 78
                            height: width
                            radius: width
                            border.width: map.tool=="MOVE"?3:0
                            border.color: "#12d27c"
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    source: "icon/icon_move.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "Move"
                                    font.family: font_noto_r.name
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "MOVE";
                                    map.reset_canvas();
                                    supervisor.clearObjectPoints();
                                }
                            }
                        }
                        Rectangle{
                            id: btn_add_location
                            width: 78
                            height: width
                            radius: width
                            border.width: map.tool=="ADD_POINT"||map.tool=="ADD_OBJECT"?3:0
                            border.color: "#12d27c"
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    width: 23
                                    height: 23
                                    source: "icon/icon_add.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "Add"
                                    font.family: font_noto_r.name
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "ADD_OBJECT";
                                }
                            }
                        }
                        Rectangle{
                            id: btn_edit
                            width: 78
                            height: width
                            radius: width
                            enabled: map.tool=="ADD_OBJECT"||map.tool=="ADD_POINT"?false:true
                            color: enabled?"white":"#f4f4f4"
                            border.width: map.tool=="EDIT_OBJECT"?3:0
                            border.color: "#12d27c"
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    source: "icon/icon_edit.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "Edit"
                                    color: btn_edit.enabled?"black":"#e8e8e8"
                                    font.family: font_noto_r.name
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "EDIT_OBJECT";
                                }
                            }
                        }
                        Rectangle{
                            id: btn_erase
                            width: 78
                            height: width
                            radius: width
                            color: enabled?"white":"#f4f4f4"
                            enabled: map.tool=="ADD_OBJECT"||map.tool=="ADD_POINT"?false:true
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    source: "icon/icon_erase.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "Remove"
                                    color: btn_erase.enabled?"black":"#e8e8e8"
                                    font.family: font_noto_r.name
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    supervisor.removeObject(list_object.currentIndex);
                                    map.update_canvas();
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: rect_annot_box4
                    width: parent.width
//                    height: 50
                    visible: map.tool=="ADD_OBJECT"||map.tool=="ADD_POINT"?true:false
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
                    color: "#e8e8e8"
                    Row{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        spacing: 15
                        Rectangle{
                            id: btn_rectangle
                            width: 80
                            height: 40
                            radius: 5
                            border.width: map.tool=="ADD_OBJECT"?3:1
                            border.color: map.tool=="ADD_OBJECT"?"#12d27c":"black"
                            Text{
                                text: "Rectangle"
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "ADD_OBJECT";
                                }
                            }
                        }
                        Rectangle{
                            id: btn_point
                            width: 78
                            height: 40
                            radius: 5
                            border.width: map.tool=="ADD_POINT"?3:1
                            border.color: map.tool=="ADD_POINT"?"#12d27c":"black"
                            Text{
                                text: "Point"
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "ADD_POINT";
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
                            color: enabled?"white":"#f4f4f4"
                            enabled: supervisor.getTempObjectSize()>2?true:false
                            Text{
                                text: "Save"
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                color: parent.enabled?"black":"white"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(supervisor.getTempObjectSize() > 2){
                                        popup_add_object.open();
                                    }
                                }
                            }
                        }
                    }

                    Image{
                        width: 40
                        height: 40
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 30
                        source: "icon/icon_undo.png"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(map.tool == "ADD_OBJECT"){
                                    supervisor.clearObjectPoints();
                                    map.new_object = false;
                                }else if(map.tool == "ADD_POINT"){
                                    supervisor.removeObjectPointLast();
                                }
                                map.update_canvas();
                            }
                        }
                    }
                }

                ListView {
                    id: list_object
                    width: parent.width
                    enabled: map.tool=="ADD_OBJECT"||map.tool=="ADD_POINT"?false:true
                    height: rect_annot_box4.visible?280:280+60
                    clip: true
                    model: ListModel{}
                    delegate: objectCompo
                    highlight: Rectangle {color: "#83B8F9"}

                    Rectangle{
                        anchors.fill: parent
                        color: parent.enabled?"transparent":"#e8e8e8"
                        opacity: parent.enabled?1:0.8
                        border.width: 1
                        border.color: "black"
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
                    count: 6
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
                            text: "Previous"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                map.init_mode();
                                map.show_connection = false;
                                supervisor.clearObjectPoints();
                                map.state_annotation = "DRAWING";
                                loader_menu.sourceComponent = menu_annot_draw;
                                map.update_canvas();
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
                            text: "Next"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                //save temp Image
                                map.init_mode();
                                map.state_annotation = "LOCATION";
//                                supervisor.clearObjectPoints();
//                                map.clear_canvas();
//                                map.update_canvas();
                                loader_menu.sourceComponent = menu_annot_location;
                            }
                        }
                    }
                }
            }
        }

    }

    Component{
        id: menu_annot_location
        Item{
            id: menu_location
            objectName: "menu_location"
            width: rect_menus.width
            height: rect_menus.height

            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }

            Component.onCompleted: {
                var loc_num = supervisor.getLocationNum();
                list_location.model.clear();
                for(var i=0; i<loc_num; i++){
                    list_location.model.append({"type":supervisor.getLocationTypes(i),"name":supervisor.getLocationName(i),"iscol":false});
                }
                map.update_canvas();
            }
            function getcur(){
                return list_location.currentIndex;
            }
            function setcur(index){
                list_location.currentIndex = index;
            }
            function getslider(){
                return slider_margin.value;
            }
            function update(){
                var loc_num = supervisor.getLocationNum();
                list_location.model.clear();
                for(var i=0; i<loc_num; i++){
                    if(map.is_Col_loc(supervisor.getLocationx(i)/map.grid_size + map.origin_x,supervisor.getLocationy(i)/map.grid_size + map.origin_y)){
                        list_location.model.append({"type":supervisor.getLocationTypes(i),"name":supervisor.getLocationName(i),"iscol":true});
                    }else{
                        list_location.model.append({"type":supervisor.getLocationTypes(i),"name":supervisor.getLocationName(i),"iscol":false});
                    }
                }
            }

            Timer{
                id: timer_check_localization
                running: false
                repeat: true
                interval: 500
                onTriggered:{
                    if(supervisor.is_slam_running()){
                        btn_auto_init.running = false;
                        timer_check_localization.stop();
                    }else if(supervisor.getLocalizationState() === 0 || supervisor.getLocalizationState() === 3){
                        timer_check_localization.stop();
                        btn_auto_init.running = false;
                    }
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
                    text: "STEP 3. Add/Edit Location"
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Component {
                id: locationCompo
                Item {
                    width: parent.width
                    height: 35
                    Rectangle{
                        width: 150
                        height: 34
                        color: iscol?"#E7584D":"#ffffff"
                        Text {
                            id: text_loc_type
                            anchors.centerIn: parent
                            text: type
                            font.family: font_noto_r.name
                            font.pixelSize: 20
                            color: iscol?"white":"black"
                        }
                    }
                    Text {
                        id: text_loc_name
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 30
                        text: name
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        font.bold: iscol
                        color: iscol?"#E7584D":"black"
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
                            map.select_location = supervisor.getLocNum(name);
                            list_location.currentIndex = index;
                            map.update_canvas();
                        }
                    }
                }
            }
            Column{
                width: parent.width - 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 20
                spacing: 10
                Rectangle{
                    id: rect_annot_localization
                    width: parent.width
                    height: 100
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
                                    map.reset_canvas();
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
                                    if(supervisor.getLocalizationState() !== 1){
                                        btn_auto_init.running = true;
                                        supervisor.slam_autoInit();
                                        timer_check_localization.start();
                                    }

                                }
                            }
                        }
                    }
                }
                Rectangle{
                    width: rect_menus.width - 60
                    height: 0
                    visible: map.tool==="SLAM_INIT"?true:false
                    anchors.horizontalCenter: parent.horizontalCenter
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
                    color: "transparent"
                    Row{
                        anchors.centerIn: parent
                        spacing: 20
                        Rectangle{
                            width: 80
                            height: 40
                            radius: 5
                            Text{
                                text: "Run"
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    btn_run.show_ani();
                                    map.tool = "MOVE";
                                    map.reset_canvas();
                                    supervisor.slam_run();
                                }
                            }
                        }
                        Rectangle{
                            width: 80
                            height: 40
                            radius: 5
                            Text{
                                text: "Stop"
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "MOVE";
                                    map.reset_canvas();
                                    btn_stop.show_ani();
                                    supervisor.slam_stop();
                                }
                            }
                        }
                        Rectangle{
                            width: 80
                            height: 40
                            radius: 5
                            Text{
                                text: "Set Init"
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                            }
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


                Rectangle{
                    id: rect_annot_box
                    width: parent.width
                    height: 100
                    color: "#e8e8e8"
                    Row{
                        anchors.centerIn: parent
                        spacing: 20

                        Rectangle{
                            id: btn_add_location
                            width: 78
                            height: width
                            radius: width
                            border.width: map.tool=="ADD_LOCATION"?3:0
                            border.color: "#12d27c"
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    width: 23
                                    height: 23
                                    source: "icon/icon_add.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "Add"
                                    font.family: font_noto_r.name
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "ADD_LOCATION";
                                }
                            }
                        }
                        Rectangle{
                            id: btn_edit
                            width: 78
                            height: width
                            radius: width
                            enabled: map.tool=="ADD_LOCATION"?false:true
                            color: enabled?"white":"#f4f4f4"
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    source: "icon/icon_edit.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "Edit"
                                    color: btn_edit.enabled?"black":"#e8e8e8"
                                    font.family: font_noto_r.name
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "EDIT_LOCATION";
                                }
                            }
                        }
                        Rectangle{
                            id: btn_erase
                            width: 78
                            height: width
                            radius: width
                            color: enabled?"white":"#f4f4f4"
                            enabled: map.tool=="ADD_LOCATION"?false:true
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    source: "icon/icon_erase.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "Remove"
                                    color: btn_erase.enabled?"black":"#e8e8e8"
                                    font.family: font_noto_r.name
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(list_location.currentIndex > 0){
                                        map.select_location = list_location.currentIndex-1;
                                        supervisor.removeLocation(list_location.model.get(list_location.currentIndex).name);
                                        map.update_canvas();
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle{
                    id: rect_annot_box5
                    width: parent.width
                    visible: map.tool=="ADD_LOCATION"?true:false
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
                    color: "#e8e8e8"
                    Row{
                        anchors.centerIn: parent
                        spacing: 30
                        Rectangle{
                            id: btn_1
                            width: 80
                            height: 40
                            radius: 5
                            Text{
                                text: "Cancel"
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "MOVE";
                                    map.reset_canvas();
                                    map.new_location = false;
                                    map.new_loc_x = 0;
                                    map.new_loc_y = 0;
                                    map.new_loc_th = 0;
                                    map.new_loc_available = false;
                                }
                            }
                        }
                        Rectangle{
                            id: btn_2
                            width: 78
                            height: 40
                            radius: 5
                            color: enabled?"white":"#f4f4f4"
                            enabled: map.new_location?true:false
                            Text{
                                text: "Save"
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                color: parent.enabled?"black":"white"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(map.new_location){
                                        popup_add_location.open();
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
                                    popup_add_location.open();
                                    popup_add_location.curpose_mode = true;
                                }
                            }
                        }

                    }
                }

                Rectangle{
                    id: rect_annot_box66
                    width: parent.width
                    visible: map.tool=="EDIT_LOCATION"?true:false
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
                    color: "#e8e8e8"
                    Row{
                        anchors.centerIn: parent
                        spacing: 30
                        Rectangle{
                            width: 80
                            height: 40
                            radius: 5
                            Text{
                                text: "Cancel"
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    map.tool = "MOVE";
                                    map.reset_canvas();
                                    map.select_location = -1;
                                    map.select_location_show = -1;
                                    list_location.currentIndex = -1;
                                    map.new_location = false;
                                    map.new_loc_x = 0;
                                    map.new_loc_y = 0;
                                    map.new_loc_th = 0;
                                    map.new_loc_available = false;
                                    map.update_canvas();
                                }
                            }
                        }
                        Rectangle{
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
                                    supervisor.moveLocationPoint(map.select_location, map.robot_x, map.robot_y, supervisor.getRobotth());
                                    map.select_location = -1;
                                    map.select_location_show = -1;
                                    map.new_location = false;
                                    map.new_loc_x = 0;
                                    map.new_loc_y = 0;
                                    map.new_loc_th = 0;
                                    map.new_loc_available = false;
                                    map.tool = "MOVE";
                                    map.reset_canvas();
                                    map.update_canvas();
                                }
                            }
                        }

                    }
                }

                ListView {
                    id: list_location
                    width: parent.width
                    height: rect_annot_box5.visible||rect_annot_box66.visible?160:220
                    Behavior on height {
                        NumberAnimation{
                            duration:300;
                        }
                    }
                    enabled: map.tool=="ADD_LOCATION"||map.tool=="EDIT_LOCATION"?false:true
                    clip: true
                    model: ListModel{}
                    delegate: locationCompo
                    highlight: Rectangle { color: "#83B8F9"}
                    Rectangle{
                        anchors.fill: parent
                        color: parent.enabled?"transparent":"#e8e8e8"
                        opacity: parent.enabled?1:0.8
                        border.width: 1
                        border.color: "black"
                    }
                }

//                Row{
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    spacing: 60
//                    Item_joystick{
//                        id: joy_xy
//                        show_arrow: false
//                        verticalOnly: true
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
//                        show_arrow: false
//                        horizontalOnly: true
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

            }

            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                spacing: 30
                PageIndicator{
                    id: indicator_annot
                    count: 6
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
                            text: "Previous"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                map.init_mode();
                                map.show_connection = false;
                                map.state_annotation = "OBJECT";
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
                            text: "Next"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                map.init_mode();
                                map.show_connection = false;
                                map.state_annotation = "SAVE";
                                loader_menu.sourceComponent = menu_annot_save;
//                                map.init_mode();
//                                map.state_annotation = "TRAVELLINE";
//                                loader_menu.sourceComponent = menu_annot_tline;
                            }
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
                    rect_state_annot.color = "#4F5666"
                    state_text_annot.text = "저장이 필요합니다."
                    state_text_annot.anchors.rightMargin = 20
                    btn_add1.border.width = 0
                }else if(state_annot === 1){
                    if(supervisor.getAnnotEditFlag()){
                        rect_state_annot.color = "#EE9D44"
                        state_text_annot.text = "저장이 필요합니다."
                        state_text_annot.anchors.rightMargin = 20
                        btn_add1.border.width = 0
                    }else{
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
                    text: "STEP 5. Save"
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
                    text: is_init_state?"MAP : " + map.map_name:"MAP : " + supervisor.getMapname();
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
                            text: "Confirm"
                            anchors.verticalCenter: parent.verticalCenter
                            color: "white"
                            anchors.right: parent.right
                            anchors.rightMargin: 50
                            font.family: font_noto_b.name
                            font.pixelSize: 25
                        }
                    }
                    Rectangle{
                        id: btn_move
                        width: 85
                        height: width
                        anchors.verticalCenter: parent.verticalCenter
                        radius: width
                        border.width: 0
                        border.color: "#12d27c"
                        Column{
                            anchors.centerIn: parent
                            Image{
                                source: "icon/icon_meta_save.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                text: "Meta 저장"
                                font.family: font_noto_r.name
                                font.pixelSize: 13
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(supervisor.saveMetaData(map.map_name)){
                                    btn_move.border.width = 3;
                                }else{
                                    btn_move.border.width = 0;
                                }
                            }
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
                            text: "Confirm"
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
                                text: "Annot 저장"
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
                            text: "Confirm"
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
                    count: 6
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
                            text: "Previous"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                map.init_mode();
                                map.state_annotation = "LOCATION";
                                loader_menu.sourceComponent = menu_annot_location;
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
                            text: "Confirm"
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
                                
                                //맵 다시 불러오기
                                map_current.map_mode = "EDITED";
                                map_current.loadmap(supervisor.getMapname(),"EDITED");
                                map_current.update_canvas();
                            }
                        }
                    }
                }
            }


        }

    }


    //Patrol Menu ITEM========================================================
    ListModel{
        id: patrol_location_model
        ListElement{
            name: "start"
            location: "charging_0"
            loc_x: 0
            loc_y: 0
            loc_th: 0
        }
    }

    function update_patrol_location(){
        loader_menu.item.update();
        map.update_canvas();
    }
    function updatemap(){
        map.clear_canvas();
        map.update_canvas();
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
//                    print(joy_axis_left_ud,joy_axis_right_rl,supervisor.getJoyAxis(1),supervisor.getJoyAxis(2))
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
                    if(supervisor.getJoyAxis(1) === 0 && supervisor.getJoyAxis(2) === 0){
                        supervisor.writelog("[JOYSTICK] ALL 0 , READ START");
                        joy_init =true;
                    }
                }
            }else{
                joy_init = false;
                joy_axis_left_ud = 0;
                joy_axis_right_rl = 0;
//                joy_xy.remote_stop();
//                joy_th.remote_stop();
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
                    slam_initializing = true;
                }
            }else{
                if(slam_initializing){
                    slam_initializing = false;
                    check_slam_init_timer.stop();
                }else{
                    if(trigger_cnt++ > 10){
                        print("slam auto init fail");
                        check_slam_init_timer.stop();
                    }
                }
            }
        }
    }

    //Dialog(Popup) ================================================================
    FileDialog{
        id: fileload
        folder: "file:"+homePath+"/maps"
        property variant pathlist
        property string path : ""
        nameFilters: ["*.png"]
        onAccepted: {
            setMapPath(fileload.file.toString(),pathlist[9].split(".")[0])
            print(fileload.file.toString());
        }
    }
    Platform.FileDialog{
        id: filesaveannot
        fileMode: Platform.FileDialog.SaveFile
        property variant pathlist
        property string path : ""
        folder: "file:"+homePath+"/maps"
        onAccepted: {
            print(filesaveannot.file.toString())
            supervisor.saveAnnotation(filesaveannot.file.toString());
        }
    }
    Platform.FileDialog{
        id: filesavepatrol
        fileMode: Platform.FileDialog.SaveFile
        property variant pathlist
        property string path : ""
        folder: "file:"+homePath+"/patrols"
        onAccepted: {
            print(filesavepatrol.file.toString())
            supervisor.savePatrolFile(filesavepatrol.file.toString());
        }
    }
    Platform.FileDialog{
        id: fileopenpatrol
        fileMode: Platform.FileDialog.OpenFile
        property variant pathlist
        property string path : ""
        folder: "file:"+homePath+"/patrols"
        onAccepted: {
            supervisor.loadPatrolFile(fileopenpatrol.file.toString());
            update_patrol_location();
            loader_menu.item.update();
        }
    }
    Platform.FileDialog{
        id: filesavemeta
        fileMode: Platform.FileDialog.SaveFile
        property variant pathlist
        property string path : ""
        folder: "file:"+homePath+"/maps"
        onAccepted: {
            print(filesavemeta.file.toString())

            supervisor.saveMetaData(filesavemeta.file.toString());
        }
    }

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
                        text: is_init_state && !is_save_annot?"Annotation이 저장되지 않았습니다.":"이대로 맵을 사용하시겠습니까?"
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        id: text_warning
                        visible: false
                        text: "[Annot 저장] 버튼을 눌러 저장해주세요.\n 모든 수정을 취소하시려면 오른쪽 상단의 [뒤로가기] 버튼을 누르세요."
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
                                supervisor.setMap(map.map_name);
                                popup_map_use.close();
                                backPage();
                            }
                        }
                    }
                }
            }
        }

    }


    Popup{
        id: popup_add_patrol
        width: 350
        height: 500
        anchors.centerIn: parent
        onOpened: {
            var loc_num = supervisor.getLocationNum();
            list_location2.model.clear();
            for(var i=0; i<loc_num; i++){
                list_location2.model.append({"type":supervisor.getLocationTypes(i),"name":supervisor.getLocationName(i),"iscol":false});
            }
        }

        bottomPadding: 0
        topPadding: 0
        leftPadding: 0
        rightPadding: 0

        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }

        Rectangle{
            id: rect_ba
            anchors.fill:parent
            color: "#282828"
            radius: 5

            Rectangle{
                id: rect_title1
                width: parent.width*0.9
                height: 80
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 5
                Text{
                    id: text_popup_patrol
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    text:"왼쪽 리스트에서 사전 정의된 위치를 선택하거나\n지도에서 직접 위치를 입력해주세요."
                }
            }


            ListView {
                id: list_location2
                width: 250
                height: 250
                anchors.top: rect_title1.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                model: ListModel{}
                delegate: locationCompo1
                highlight: Rectangle { color: "#FFD9FF"; radius: 5 }
            }
            Row{
                id: menubar22
                spacing: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: list_location2.bottom
                anchors.topMargin: 20
                Repeater{
                    model: ["confirm","in map"]
                    Rectangle{
                        property int btn_size: 100
                        width: 100
                        height: 50
                        radius: 10
                        color: "white"
                        Text{
                            anchors.verticalCenter : parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.family: font_noto_r.name
                            font.pixelSize: 20
                            color: "#7e7e7e"
                            text:modelData
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "confirm"){
                                    print(list_location2.model.get(list_location2.currentIndex).name);
                                    if(list_location2.model.get(list_location2.currentIndex).name != ""){
                                        supervisor.addPatrol("LOC",list_location2.model.get(list_location2.currentIndex).name,0,0,0);
                                        popup_add_patrol.close();
                                        update_patrol_location();
                                        map.select_location_show = -1;
                                        select_patrol_num = supervisor.getPatrolNum()-1;
                                        loader_menu.item.viewlast();
                                    }
                                }else if(modelData == "in map"){
                                    popup_add_patrol.close();
                                    map.tool = "ADD_PATROL_LOCATION";
                                }
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
            interval: 500
            onTriggered:{
                if(!supervisor.getLCMConnection()){

                    //맵 새로 불러오기.
                    map.init_mode();
                    map.show_connection = false;
                    map.loadmap(textfield_name22.text,"RAW");

                    supervisor.clear_all();
                    map.state_annotation = "DRAWING";
                    map.map_mode = "RAW";
                    map.update_canvas();
                    loader_menu.sourceComponent = menu_annot_rotate;
                    popup_save_mapping.close();
                    timer_check_slam.stop();

                }

            }
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
                                if(textfield_name22.text == ""){
                                }else{
                                    supervisor.saveMapping(textfield_name22.text);
                                    supervisor.setMap(textfield_name22.text);

                                    timer_check_slam.start();
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
                                if(map.map_name == "map_raw.png"){
                                    var text = "map_edited.png"
                                }else{
                                    text = map.map_name
                                }

                                //save temp Image
                                map.save_map(text);
                                map.rotate_map(0);

                                //맵 새로 불러오기.
                                map.loadmap(text,"EDITED");
                                map.setfullscreen();
                                supervisor.clear_all();
                                supervisor.deleteAnnotation();
                                map.state_annotation = "DRAWING";
                                loader_menu.sourceComponent = menu_annot_draw;

                                popup_save_rotated.close();

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
        onOpened: {
            if(map.map_name == "map_raw.png"){
                textfield_name.text = "map_edited.png"
            }else{
                textfield_name.text = map.map_name
            }
        }
        function show_rotate(){
        }
        function unshow_rotate(){
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
                        placeholderText: qsTr(map.map_name)
                        onFocusChanged: {
                            keyboard.owner = textfield_name;
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
                                    //save temp Image
                                    map.save_map(textfield_name.text);

                                    //임시 맵 이미지를 해당 폴더 안에 넣음.
//                                    supervisor.rotate_map("map_edited_temp.png",textfield_name.text, 1);
//                                    supervisor.setMap(textfield_name.text);

                                    //맵 새로 불러오기.
                                    map.loadmap(textfield_name.text,"EDITED");

                                    supervisor.clear_all();
                                    map.state_annotation = "OBJECT";
                                    loader_menu.sourceComponent = menu_annot_object;
                                    popup_save_edited.close();
                                }
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
                text: "Add Object"
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
                            text: "Table"
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
                            text: "Chair"
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
                            text: "Wall"
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
                text: "Object Name : " + select_object_type + "_" + Number(supervisor.getObjectSize(select_object_type))
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
                        if(map.tool == "ADD_OBJECT"){
                            supervisor.addObjectRect(select_object_type);
                        }else{
                            supervisor.addObject(select_object_type);
                        }
                        map.update_canvas();
                        map.tool = "MOVE";
                        map.reset_canvas();
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
            tfield_location.text = select_location_type + "_" + Number(supervisor.getLocationSize(select_location_type))
        }

        Rectangle{
            id: rect_loc_title
            width: parent.width
            height: 50
            color: "#323744"
            Text{
                anchors.centerIn: parent
                text: "Add Location"
                font.pixelSize: 20
                font.family: font_noto_r.name
                color: "white"
            }
        }
        Rectangle{
            id: rect_loc_menu
            anchors.top: rect_loc_title.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: rect_loc_title.horizontalCenter
            height: 100
            width: parent.width
            color: "#e8e8e8"
            Row{
                spacing: 20
                anchors.centerIn: parent
                Rectangle{
                    id: btn_serving
                    width: 78
                    height: width
                    radius: width
                    border.width: select_location_type=="Serving"?3:0
                    border.color: "#12d27c"
                    Column{
                        anchors.centerIn: parent
                        Image{
                            source: "icon/icon_move.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            text: "Serving"
                            font.family: font_noto_r.name
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
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
                    width: 78
                    height: width
                    radius: width
                    border.width: select_location_type=="Charging"?3:0
                    border.color: "#12d27c"
                    Column{
                        anchors.centerIn: parent
                        Image{
                            source: "icon/icon_move.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            text: "Charging"
                            font.family: font_noto_r.name
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            select_location_type = "Charging";
                            tfield_location.text = select_location_type + "_" + Number(supervisor.getLocationSize(select_location_type))
                        }
                    }
                }
                Rectangle{
                    id: btn_resting
                    width: 78
                    height: width
                    radius: width
                    border.width: select_location_type=="Resting"?3:0
                    border.color: "#12d27c"
                    Column{
                        anchors.centerIn: parent
                        Image{
                            source: "icon/icon_move.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            text: "Resting"
                            font.family: font_noto_r.name
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            select_location_type = "Resting";
                            tfield_location.text = select_location_type + "_" + Number(supervisor.getLocationSize(select_location_type))
                        }
                    }
                }
                Rectangle{
                    id: btn_other
                    width: 78
                    height: width
                    radius: width
                    border.width: select_location_type=="Other"?3:0
                    border.color: "#12d27c"
                    Column{
                        anchors.centerIn: parent
                        Image{
                            source: "icon/icon_move.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            text: "Other"
                            font.family: font_noto_r.name
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            select_location_type = "Other";
                            tfield_location.text = select_location_type + "_" + Number(supervisor.getLocationSize(select_location_type))
                        }
                    }
                }
            }
        }
        TextField{
            id: tfield_location
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: rect_loc_menu.bottom
            anchors.topMargin: 30
            width: parent.width*0.9
            height: 50
            placeholderText: "(loc_name)"
            font.family: font_noto_r.name
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 20
            onFocusChanged: {
                keyboard.owner = tfield_location;
                if(focus){
                    keyboard.open();
                }else{
                    keyboard.close();
                }
            }
        }
        Row{
            anchors.top: tfield_location.bottom
            anchors.topMargin: 30
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
                        if(tfield_location.text == ""){
                        }else{
                            if(popup_add_location.curpose_mode){
                                print(map.robot_th);
                                supervisor.addLocation(select_location_type,tfield_location.text, map.robot_x, map.robot_y,supervisor.getRobotth());
                            }else{
                                print(map.new_loc_th);
                                supervisor.addLocation(select_location_type,tfield_location.text, map.new_loc_x, map.new_loc_y, map.new_loc_th);
                            }
                            map.tool = "MOVE";
                            map.reset_canvas();
                            map.new_location = false;
                            map.new_loc_x = 0;
                            map.new_loc_y = 0;
                            map.new_loc_th = 0;
                            map.new_loc_available = false;
                            popup_add_location.close();
                            map.update_canvas();
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
        id: popup_add_travelline
        width: 400
        height: 300
        anchors.centerIn: parent
        background: Rectangle{
            anchors.fill:parent
            color: "white"
        }

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Add Location"
            font.pixelSize: 20
            font.bold: true
        }
        TextField{
            id: textfield_name3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
            width: 200
            height: 60
            placeholderText: "(line_name)"
            font.pointSize: 20
            onFocusChanged: {
                keyboard.owner = textfield_name3;
                if(focus){
                    keyboard.open();
                }else{
                    keyboard.close();
                }
            }
        }
        Rectangle{
            id: btn_add_line_confirm
            width: 60
            height: 50
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 20
            color: "gray"
            Text{
                anchors.centerIn: parent
                text: "확인"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(textfield_name3.text == ""){
                        textfield_name3.color = "red";
                    }else if(map.isnewline){
                        supervisor.addTline(textfield_name3.text, map.new_line_x1, map.new_line_y1, map.new_line_x2, map.new_line_y2);
                        map.isnewline = false;
                        map.new_line_x1 = 0;
                        map.new_line_x2 = 0;
                        map.new_line_y1 = 0;
                        map.new_line_y2 = 0;
                        map.tool = "MOVE";
                        map.reset_canvas();
                        popup_add_travelline.close();
                        map.update_canvas();
                    }else{
                        popup_add_travelline.close();
                    }
                }
            }
        }
        Rectangle{
            id: btn_add_line_cancel
            width: 60
            height: 50
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 20
            color: "gray"
            Text{
                anchors.centerIn: parent
                text: "취소"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    popup_add_travelline.close();
                }
            }
        }
    }

    Popup{
        id: popup_add_patrol_1
        width: 300
        height:200
        bottomPadding: 0
        topPadding: 0
        leftPadding: 0
        rightPadding: 0
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }

        anchors.centerIn: parent
        Rectangle{
            radius: 5
            width: parent.width
            height: parent.height
            color: "white"
            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                font.family: font_noto_r.name
                anchors.topMargin: 30
                text: "지정한 위치로 포인트를 추가 하시겠습니까?"
            }
            Row{
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                Repeater{
                    model: ["yes","retry","cancel"]
                    Rectangle{
                        width: 50
                        height: 50
                        color: "gray"
                        radius: 10
                        Text{
                            text: modelData
                            anchors.centerIn: parent
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "yes"){
                                    supervisor.addPatrol("POINT","MANUAL",map.new_loc_x, map.new_loc_y, map.new_loc_th+Math.PI/2);
                                    update_patrol_location();

                                    map.new_location = false;
                                    map.tool = "MOVE";
                                    map.reset_canvas();
                                    popup_add_patrol_1.close();
                                }else if(modelData == "retry"){
                                    popup_add_patrol_1.close();
                                }else if(modelData == "cancel"){
                                    map.tool = "MOVE";
                                    map.new_location = false;
                                    popup_add_patrol_1.close();
                                }
                                map.select_location_show = -1;
                            }
                        }
                    }
                }
            }
        }
    }

    function updatepatrol(){
        patrol_mode = supervisor.getPatrolMode();
    }

    function loadmap(name,type){
        check_slam_init_timer.stop();
        map.loadmap(name,type);
        updatemap();
    }

    function init_map(){
        map.init_mode();
        timer_get_joy.stop();
        map.state_annotation = "NONE";

        if(map_mode == 0){
//            timer_get_joy.start();
            loader_menu.sourceComponent = menu_main;
            text_menu_title.visible = false;
            map.show_buttons = true;
            text_menu_title.text = "";
        }else if(map_mode == 1){
            text_menu_title.text = "SLAM";
            text_menu_title.visible = true;
//            timer_get_joy.start();
            map.init_mode();
            map.show_lidar = true;
            map.show_robot = true;
            map.setfullscreen();
            loader_menu.sourceComponent = menu_slam;
            map.map_mode = "MAPPING";
        }else if(map_mode == 2){
            text_menu_title.text = "Annotation";
            text_menu_title.visible = true;
            map.show_location = true;
            map.show_connection = false;
            map.show_object = true;
            map.robot_following = false;
            map.setfullscreen();
            loader_menu.sourceComponent = menu_annot_state;
        }else if(map_mode == 3){
            text_menu_title.text = "Patrol";
            text_menu_title.visible = true;
            map.show_object = true;
            map.show_connection = false;
//            map.show_location_default = false;
            map.robot_following = false;
            map.update_canvas();
            loader_menu.sourceComponent = menu_patrol;
        }else if(map_mode == 4){
            text_menu_title.visible = true;
            text_menu_title.text = "Localization";
            map.show_lidar = true;
            map.show_buttons = true;
            map.show_robot = true;
            map.show_object = true;
            map.show_location = true;
            map.robot_following = true;
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

}
