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

    //mode : 0(mapview) 1:(slam-mapping) 2:(annotation) 3:(patrol) 4: (slam-localization)
    property int map_mode: 0

    //0: location 1: record 2: random
    property int patrol_mode: 0
    property bool recording: false

    property bool is_init_state: false
    property bool is_save_annot: false

    //annotation
    property string select_object_type: "Wall"
    property string select_location_type: "Serving"
    property int select_tline_num: -1
    property int select_tline_category: -1
    property int select_patrol_num: -1


    Component.onCompleted: {
        init_map();
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
            if(map_mode == 1){
                if(event.key === Qt.Key_Up){
                    loader_menu.item.setKeyUp(false);
                    if(!loader_menu.item.getKeyDown())
                        supervisor.joyMoveXY(0);
                }
                if(event.key === Qt.Key_Down){
                    loader_menu.item.setKeyDown(false);
                    if(!loader_menu.item.getKeyUp())
                        supervisor.joyMoveXY(0);
                }
                if(event.key === Qt.Key_Left){
                    loader_menu.item.setKeyLeft(false);
                    if(!loader_menu.item.getKeyRight())
                        supervisor.joyMoveR(0);
                }
                if(event.key === Qt.Key_Right){
                    loader_menu.item.setKeyRight(false);
                    if(!loader_menu.item.getKeyLeft())
                        supervisor.joyMoveR(0);
                }
            }
        }
        Keys.onPressed: {
            if(map_mode == 1){
                if(event.key === Qt.Key_Up){
                    loader_menu.item.setKeyUp(true);
                    supervisor.joyMoveXY(-1);
                }
                if(event.key === Qt.Key_Down){
                    loader_menu.item.setKeyDown(true);
                    supervisor.joyMoveXY(1);
                }
                if(event.key === Qt.Key_Left){
                    loader_menu.item.setKeyLeft(true);
                    supervisor.joyMoveR(-1);
                }
                if(event.key === Qt.Key_Right){
                    loader_menu.item.setKeyRight(true);
                    supervisor.joyMoveR(1);
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
        map.update_canvas_all();
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
                    focus: true
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
                                            supervisor.addPatrol("POINT",list_location2.model.get(list_location2.currentIndex).name,0,0,0);
                                            popup_add_patrol.close();
                                            update_patrol_location();
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
                anchors.horizontalCenter: map_current.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 30
            }
            Map_full{
                id: map_current
                width: 450
                height: 450
                show_robot: true
                show_path: true
                show_lidar: true
                show_buttons: true
                show_connection: true
                show_object: true
                anchors.left: parent.left
                anchors.leftMargin: 200//parent.width/2 - width/2
                anchors.top: text_curmap.bottom
                anchors.topMargin: 20
            }
          Text{
              text: "수동 조작\n(lock on-off)"
              anchors.horizontalCenter: switch_joy.horizontalCenter
              anchors.bottom: switch_joy.top
              anchors.bottomMargin: 20
              font.family: font_noto_r.name
              color: "white"
              font.pixelSize: 15
              horizontalAlignment: Text.AlignHCenter
          }
          Item_switch{
              id: switch_joy
              enabled: false
              anchors.left: map_current.right
              anchors.leftMargin: 50
              anchors.bottom: map_current.bottom
              onoff: false
              touchEnabled: false
          }

            Item_joystick{
                id: joy_xy
                anchors.top: map_current.bottom
                anchors.topMargin: 30
                anchors.right: map_current.horizontalCenter
                anchors.rightMargin: 30
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
                anchors.top: map_current.bottom
                anchors.topMargin: 30
                anchors.left: map_current.horizontalCenter
                anchors.leftMargin: 30
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
                height: parent.height
                width: height
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                clip: true
//                just_show_map: true
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
            function setKeyUp(pressed){
                keyboard.pressed_up = pressed;
            }
            function setKeyDown(pressed){
                keyboard.pressed_down = pressed;
            }
            function setKeyLeft(pressed){
                keyboard.pressed_left = pressed;
            }
            function setKeyRight(pressed){
                keyboard.pressed_right = pressed;
            }
            function getKeyUp(){
                return keyboard.pressed_up
            }
            function getKeyDown(){
                return keyboard.pressed_down
            }
            function getKeyLeft(){
                return keyboard.pressed_left
            }
            function getKeyRight(){
                return keyboard.pressed_right
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
                anchors.bottom: rect_annot_box.top
                anchors.bottomMargin: 10
                anchors.left: rect_annot_box.left
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
                id: rect_annot_box
                width: parent.width - 60
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 100
                color: "#e8e8e8"


                Row{
                    anchors.centerIn: parent
                    spacing: 30
                    Item_button{
                        id: btn_start
                        width: 78
                        running: timer_mapping.running
                        icon: "icon/icon_run.png"
                        name: "Start"

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(supervisor.getLCMConnection()){
                                    map.mapping_mode = true;
                                    supervisor.startMapping();
                                    timer_mapping.start();
                                }
                            }
                        }

                    }
                    Item_button{
                        id: btn_stop
                        width: 78
                        highlight: timer_mapping.running
                        icon: "icon/icon_stop.png"
                        name: "Stop"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                map.mapping_mode = false;
                                supervisor.stopMapping();
                                timer_mapping.stop();
                            }
                        }
                    }
                }
            }

            Item_joystick{
                id: joy_xy
                anchors.top: rect_annot_box.bottom
                anchors.topMargin: 50
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 30
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
                anchors.top: rect_annot_box.bottom
                anchors.topMargin: 50
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 30
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
            Item_keyboard{
                id: keyboard
                focus: true
                anchors.top: joy_th.bottom
                anchors.topMargin: 100
                anchors.horizontalCenter: parent.horizontalCenter
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
                        width: 78
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
                        width: 78
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
                }
            }
            Rectangle{
                id: rect_annot_box2
                width: parent.width - 60
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_box.bottom
                anchors.topMargin: 50
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
                                btn_auto_init.running = true;
                                supervisor.slam_autoInit();
                            }
                        }
                    }
                }
            }

            Rectangle{
                id: rect_localization_help
                width: parent.width - 60
                height: 200
                radius: 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_box2.bottom
                anchors.topMargin: 30
                color: "white"
                Text{
                    text: "1. 로봇의 현재 위치와 방향대로 Point를 새로 찍어주세요.\n2. Set Init 버튼을 눌러 새로운 Point에 맞게 초기화를 시킵니다.\n3. lidar 데이터가 맵과 일치하는 지 확인하고 위 과정을 반복해주세요.\n4. Run 버튼을 눌러 Localization을 실행합니다."
                    font.family: font_noto_r.name
                    anchors.centerIn: parent
                }
            }

            Timer{
                id: update_timer
                interval: 500
                running: true
                repeat: true
                onTriggered:{
                    if(supervisor.is_slam_running()){
                        btn_auto_init.running = false;
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
                patrol_location_model.clear();
                patrol_mode = supervisor.getPatrolMode();
                if(supervisor.getPatrolFileName()===""){
                    text_patrol_name.text = "설정 된 파일이 없습니다.";
                }else{
                    text_patrol_name.text = supervisor.getPatrolFileName();
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
                            if(supervisor.getPatrolMode() == 0){
                                stackview_patrol_menu.push(menu_patrol_location);
                                supervisor.makePatrol();
                                supervisor.addPatrol("START","Resting_0",0,0,0);
                            }else{
                                stackview_patrol_menu.push(menu_patrol_record);
                            }
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
                            fileopenpatrol.open();
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

                                filesavepatrol.open();
                            }else{
                                supervisor.savePatrolFile(supervisor.getPatrolFileName());
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
                                            supervisor.addPatrol("POINT","",canvas_location.new_loc_x, canvas_location.new_loc_y, canvas_location.new_loc_th);
                                            update_patrol_location();
                                        }
                                        canvas_location.isnewLoc = false;
                                        map.tool = "MOVE";
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
                                    if(map.select_patrol>1)
                                        map.select_patrol--;
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
                                    if(map.select_patrol<supervisor.getPatrolNum()-1 && map.select_patrol > 0)
                                        map.select_patrol++;
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
                                width: area_patrol_list.width
                                height: 40
                                color: "transparent"
                                Rectangle{
                                    id: line1
                                    width: 1
                                    height: parent.height/2
                                    color: "#7e7e7e"
                                }
                                Rectangle{
                                    id: line2
                                    width: parent.width/10
                                    height: 1
                                    anchors.top: line1.bottom
                                    color: "#7e7e7e"
                                }
                                Rectangle{
                                    id: rect_line
                                    width: parent.width*0.9
                                    height: parent.height
                                    anchors.right: parent.right
                                    color: {
                                        if(select_patrol_num == index+1){
                                            "#FFD9FF"
                                        }else{
                                            "white"
                                        }
                                    }
                                    border.width: 1
                                    border.color: "#7e7e7e"

                                    Text{
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.left: parent.left
                                        anchors.leftMargin: 20
                                        font.family: font_noto_r.name
                                        font.pixelSize: 20
                                        text: name
                                    }
                                    Text{
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.right: parent.right
                                        anchors.rightMargin: 20
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                        text: location
                                    }
                                    Text {
                                        anchors.centerIn: parent
                                        text: name
                                        font.family: font_noto_r.name
                                        font.pixelSize: 20
                                    }
                                    MouseArea{
                                        anchors.fill:parent
                                        onClicked: {
                                            if(map.tool == "ADD_PATROL_LOCATION"){
                                                map.tool = "MOVE";
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
                    text: "Map Meta Data"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id: rect_annot_map_name
                width: parent.width*0.9
                radius: 5
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_state.bottom
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
            Column{
                anchors.top: rect_annot_map_name.bottom
                anchors.topMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 50
                spacing: 5
                Row{
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: "Map : "
                    }
                    Text{
                        id: text_name
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: "-"
                    }
                }
                Row{
                    Text{
                        text: "Size : "
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                    Text{
                        id: text_size
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        text: "1000x1000 [pixel]"
                    }
                }
                Row{
                    Text{
                        text: "Object : "
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                    Text{
                        id: text_object
                        text: "-"
                        font.pixelSize: 15
                        font.family: font_noto_r.name
                    }
                }
                Row{
                    Text{
                        text: "Location : "
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                    Text{
                        id: text_location
                        text: "-"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                }
                Row{
                    Text{
                        text: "Predefined routes : "
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                    Text{
                        id: text_routes
                        text: "-"
                        font.pixelSize: 15
                        font.family: font_noto_r.name
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
                                loader_menu.sourceComponent = menu_annot_draw;
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
                Image{
                    width: 40
                    height: 40
                    source: "icon/icon_undo.png"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.undo();
                            map.update_canvas_all();
                        }
                    }
                }

                Image{
                    id: redo
                    width: 40
                    height: 40
                    source: "icon/icon_redo.png"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.redo();
                            map.update_canvas_all();
                        }
                    }
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
                                map.update_canvas_all();
                            }
                        }
                    }
                }

            }
            Rectangle{
                id: rect_annot_boxs
                width: parent.width - 60
                height: 102
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
                                model: ["#000000", "#262626", "#ffffff"]
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
                                popup_save_edited.open();
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
                map.update_canvas_all();
            }
            function update(){
                var ob_num = supervisor.getObjectNum();
                list_object.model.clear();
                for(var i=0; i<ob_num; i++){
                    list_object.model.append({"name":supervisor.getObjectName(i)});
                }
                list_object.currentIndex = ob_num-1;
                map.update_canvas_all();
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
                            map.update_canvas_all();
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
                                    map.update_canvas_all();
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
                                }else if(map.tool == "ADD_POINT"){
                                    supervisor.removeObjectPointLast();
                                }
                                map.update_canvas_all();
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
                    focus: true

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
                                supervisor.clearObjectPoints();
                                map.state_annotation = "DRAWING";
                                loader_menu.sourceComponent = menu_annot_draw;
                                map.update_canvas_all();
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
                                supervisor.clearObjectPoints();
                                map.state_annotation = "LOCATION";
                                map.update_canvas_all();
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
                map.update_canvas_all();
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
                print("update")
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
            Rectangle{
                id: rect_location_box
                width: parent.width - 60
                height: 50
                radius: 5
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 20
                Text{
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                    text: "Margin : " + slider_margin.value.toFixed(3) + " [m]"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                }
                Slider{
                    id: slider_margin
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 30
                    width: 150
                    from: 0
                    to: 0.5
                    value: supervisor.getMargin()
                    onValueChanged: {
                        map.update_margin();
                    }
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
                            map.update_canvas_all();
                        }
                    }
                }
            }
            Column{
                width: parent.width - 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_location_box.bottom
                anchors.topMargin: 20
                spacing: 10
                Rectangle{
                    id: rect_annot_box
                    width: parent.width
                    height: 100
                    color: "#e8e8e8"
                    Row{
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
                                    map.new_location = false;
                                    map.new_loc_x = 0;
                                    map.new_loc_y = 0;
                                    map.new_loc_th = 0;
                                    map.new_loc_available = false;
                                }
                            }
                        }
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
                                        map.update_canvas_all();
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
                    }
                }

                ListView {
                    id: list_location
                    width: parent.width
                    height: rect_annot_box5.visible?210:270
                    enabled: map.tool=="ADD_LOCATION"?false:true
                    clip: true
                    model: ListModel{}
                    delegate: locationCompo
                    highlight: Rectangle { color: "#83B8F9"}
                    focus: true
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
                                map.state_annotation = "TRAVELLINE";
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
            id: menu_travelline
            objectName: "menu_travelline"
            width: rect_menus.width
            height: rect_menus.height

            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }

            Component.onCompleted: {
                var travel_num = supervisor.getTlineSize();
                tline_model.clear();
                for(var i=0; i<travel_num; i++){
                    tline_model.append({category:i,show:false});
                    print(i);
                }
                map.update_canvas_all();
            }
            function update_line(category){
                var line_num = supervisor.getTlineSize(category);
                tline_line_model.clear();
                for(var i=0; i<line_num; i=i+2){
                    tline_line_model.append({name:"line_" + Number(i/2)});
                }
            }

            function getcur(){
                return list_line.currentIndex;
            }
            function setcur(index){
                select_tline_num = index;
            }
            function update(){
                var travel_num = supervisor.getTlineSize();
                tline_model.clear();
                for(var i=0; i<travel_num; i++){
                    tline_model.append({category:i,show:false});
                    print(i);
                }
                tline_line_model.clear();
            }
            function update2(){
                var travel_num = supervisor.getTlineSize();
                tline_model.clear();
                for(var i=0; i<travel_num; i++){
                    tline_model.append({category:i,show:false});
                    print(i);
                }
                tline_line_model.clear();
                select_tline_category = -1;
                select_tline_num = -1;
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
                    text: "STEP 4. Add/Edit Travel Line"
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Column{
                spacing: 20
                width: parent.width
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    id: rect_annot_box6
                    width: parent.width - 60
                    height: 100
                    anchors.horizontalCenter: parent.horizontalCenter
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
                            id: btn_add1
                            width: 78
                            height: width
                            radius: width
                            border.width: map.tool=="ADD_LINE"?3:0
                            border.color: "#12d27c"
                            Column{
                                anchors.centerIn: parent
                                Image{
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
                                    map.tool = "ADD_LINE";
                                }
                            }
                        }
                        Rectangle{
                            id: btn_erase
                            width: 78
                            height: width
                            radius: width
                            color: enabled?"white":"#f4f4f4"
                            enabled: map.tool=="ADD_LINE"?false:true
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
                                    supervisor.removeTline(select_tline_category,select_tline_num);
                                    map.update_canvas_all();
                                    update_line(select_tline_category);

                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: rect_annot_box7
                    width: parent.width
                    visible: map.tool=="ADD_LINE"?true:false
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
                            id: btn_11
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
                                    map.new_travel_line = false;
                                    map.new_line_point1 = false;
                                    map.new_line_point2 = false;
                                }
                            }
                        }
                        Rectangle{
                            id: btn_22
                            width: 78
                            height: 40
                            radius: 5
                            color: enabled?"white":"#f4f4f4"
                            enabled: map.new_line_point1&&map.new_line_point2?true:false
                            Text{
                                text: "Save"
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                color: parent.enabled?"black":"white"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(map.new_line_point1&&map.new_line_point2){
                                        print("??????????! : "+select_tline_category)
                                        if(select_tline_category > 0){
                                            supervisor.addTline(select_tline_category,map.new_line_x1,map.new_line_y1,map.new_line_x2,map.new_line_y2);
                                        }else{
                                            supervisor.addTline(supervisor.getTlineSize(),map.new_line_x1,map.new_line_y1,map.new_line_x2,map.new_line_y2);
                                            update();
                                            select_tline_category = supervisor.getTlineSize()-1;
                                            map.select_travel_line = select_tline_category;
                                        }
                                        print("?! : "+select_tline_category)
                                        update_line(select_tline_category);
                                        map.tool = "MOVE";
                                        map.new_travel_line = false;
                                        map.new_line_point1 = false;
                                        map.new_line_point2 = false;
                                        updatecanvas();
                                    }
                                }
                            }
                        }
                    }
                }
                Flickable{
                    width: rect_annot_box6.width
                    height: rect_annot_box7.visible?310-60:310
                    anchors.horizontalCenter: parent.horizontalCenter
                    contentHeight: column_tline.height
                    clip: true
                    Column{
                        id: column_tline
                        spacing: 5
                        Repeater{
                            id: repeat_tline
                            model: tline_model
                            Column{
                                spacing: 5
                                Rectangle{
                                    id: rect_category
                                    width: rect_annot_box6.width
                                    height: 40
                                    color: "#83B8F9"
                                    //Image (+,-)
                                    Text{
                                        anchors.centerIn: parent
                                        font.family: font_noto_r.name
                                        font.pixelSize: 20
                                        text: "Travel Line "+ Number(category)
                                    }
                                    MouseArea{
                                        id:area_compo
                                        anchors.fill:parent
                                        onClicked: {
                                            if(map.tool == "ADD_LINE"){
                                                map.tool = "MOVE";
                                                map.new_line_point1 = false;
                                                map.new_line_point2 = false;
                                            }

                                            if(select_tline_category == category){
                                                select_tline_category = -1;
                                                map.select_travel_line = -1;
                                            }else{
                                                map.select_travel_line = category;
                                                select_tline_category = category;
                                                update_line(category);
                                            }
                                            select_tline_num = -1;
                                            map.select_line = -1;
                                            updatecanvas();
                //                            map.select_object = supervisor.getObjNum(name);
                //                            list_object.currentIndex = index;
                //                            map.tool = "MOVE";
                //                            map.update_canvas_all();
                                        }
                                    }

                                }

                                Repeater{
                                    model:tline_line_model
                                    visible: select_tline_category == category?true:false
                                    Rectangle{
                                        visible: select_tline_category == category?true:false
                                        width: rect_annot_box6.width
                                        height: 40
                                        color: "transparent"
                                        Rectangle{
                                            id: line1
                                            width: 1
                                            height: parent.height/2
                                            color: "#7e7e7e"
                                        }
                                        Rectangle{
                                            id: line2
                                            width: parent.width/10
                                            height: 1
                                            anchors.top: line1.bottom
                                            color: "#7e7e7e"
                                        }
                                        Rectangle{
                                            id: rect_line
                                            width: parent.width*0.9
                                            height: parent.height
                                            anchors.right: parent.right
                                            color: {
                                                if(select_tline_num == index){
                                                    "#FFD9FF"
                                                }else{
                                                    "white"
                                                }
                                            }
                                            border.width: 1
                                            border.color: "#7e7e7e"
                                            Text {
                                                anchors.centerIn: parent
                                                text: name
                                                font.family: font_noto_r.name
                                                font.pixelSize: 20
                                            }
                                            MouseArea{
                                                anchors.fill:parent
                                                onClicked: {
                                                    if(map.tool == "ADD_LINE"){
                                                        map.tool = "MOVE";
                                                        map.new_line_point1 = false;
                                                        map.new_line_point2 = false;
                                                    }
                                                    select_tline_num = index;
                                                    map.select_line = index;
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


            }


            ListModel{
                id: tline_model
            }
            ListModel{
                id: tline_line_model
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
                                map.state_annotation = "SAVE";
                                loader_menu.sourceComponent = menu_annot_save;
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
                id: rect_annot_box8
                width: parent.width - 60
                height: 120
                anchors.top: rect_annot_state.bottom
                anchors.topMargin: 60
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#e8e8e8"
                Row{
                    anchors.centerIn: parent
                    spacing: 30
                    Rectangle{
                        id: btn_move
                        width: 85
                        height: width
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
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(supervisor.saveAnnotation(map.map_name)){
                                    btn_add1.border.width = 3;
                                    is_save_annot = true;
                                }else{
                                    btn_add1.border.width = 0;
                                }
                            }
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
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.sendMaptoServer();
                            }
                        }
                    }
                }
            }

            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rect_annot_box8.bottom
                anchors.topMargin: 20
                width: parent.width*0.9
                spacing:20
                Rectangle{
                    id: rect_annot_map_name
                    radius: 5
                    width: parent.width
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
                                map.state_annotation = "TRAVELLINE";
                                loader_menu.sourceComponent = menu_annot_tline;
                            }
                        }
                    }
                    Rectangle{
                        id: btn_next_0
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
                                if(is_init_state){
                                    popup_map_use.open();
                                }else{
                                    map_mode = 0;
                                }
                            }
                        }
                    }
                }
            }


        }

    }


    //Patrol Menu ITEM========================================================
    Component{
        id: menu_patrol_location
        Item{
            anchors.fill: parent
            Rectangle{
                id: kk
                anchors.fill: parent
                color: "red"
            }
            ListView{
                id: listview_patrol_location
                width: 300
                height: parent.height - 60
                clip: true
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.top: parent.top
                anchors.topMargin: 30
                model: patrol_location_model
                delegate: compo_patrol_location
            }
            Column{
                id: column_patrol_menus
                spacing: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 20
                Repeater{
                    model: ["add","remove","up","down"]
                    Rectangle{
                        color: "gray"
                        width: 50
                        height: 50
                        radius: 10
                        Text{
                            anchors.centerIn: parent
                            text: modelData
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "add"){
                                    if(map.tool == "ADD_PATROL_LOCATION"){
                                        if(canvas_location.isnewLoc && canvas_location.new_loc_available){
                                            supervisor.addPatrol("POINT","",canvas_location.new_loc_x, canvas_location.new_loc_y, canvas_location.new_loc_th);
                                            update_patrol_location();
                                        }
                                        canvas_location.isnewLoc = false;
                                        map.tool = "MOVE";
                                    }else{
                                        updatelocation();
                                        popup_add_patrol.open();
                                    }
                                    map.select_patrol = -1;
                                }else if(modelData == "remove"){
                                    supervisor.removePatrol(map.select_patrol);
                                    map.select_patrol = -1;
                                    update_patrol_location();
                                }else if(modelData == "up"){
                                }else if(modelData == "down"){
                                    supervisor.movePatrolDown(map.select_patrol);
                                    update_patrol_location();
                                    if(map.select_patrol<supervisor.getPatrolNum()-1 && map.select_patrol > 0)
                                        map.select_patrol++;

                                }
                            }
                        }
                    }
                }
            }
        }

    }


    Component{
        id: menu_patrol_random
        Item{
            anchors.fill: parent
            Rectangle{
                anchors.fill: parent
                color: "blue"
            }
            Rectangle{
                id: btn_patrol_random
                anchors.centerIn: parent
                width: 200
                height: 150
                radius: 20
                color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "테이블 위치 랜덤 패트롤"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        if(supervisor.getuistate() == 8){
                            supervisor.runRotateTables();
                            btn_patrol_random.color = "gray";
                        }else{
                            supervisor.runRotateTables();
                            btn_patrol_random.color = "blue";
                        }
                    }
                }
            }
        }

    }


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
        map.update_canvas_all();
    }

    Component{
        id: compo_patrol_location
        Item{
            width: parent.width
            height: 100
            Rectangle{
                anchors.fill: parent
                radius: 30
                color:{
                    if(name=="START"){
                        "yellow"
                    }else if(name == "END"){
                        "blue"
                    }else{
                        "gray"
                    }
                }
                border.color: "black"
                border.width:index==map.select_patrol?2:0
                Text{
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    font.family: font_noto_b.name
                    font.bold: true
                    font.pixelSize: 30
                    color: "white"
                }
                Text{
                    visible: location==""?false:true
                    text: location
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: font_noto_b.name
                    anchors.right: parent.right
                    anchors.rightMargin: 30
                    font.pixelSize: 20
                    color: "white"
                }
                Text{
                    visible: location==""?true:false
                    text:{
                        "x : " + Number(loc_x).toFixed(1) + "\n" +
                        "y : " + Number(loc_y).toFixed(1) + "\n" +
                        "r : " + Number(loc_th).toFixed(1) + "\n"
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: font_noto_b.name
                    anchors.right: parent.right
                    anchors.rightMargin: 30
                    font.pixelSize: 10
                    color: "white"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        map.select_patrol = index;
                        update_patrol_location();
                    }
                }
            }

        }
    }

    function updatemap(){
        map.update_map_variable();
        map.update_canvas_all();
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
                joy_xy.remote_stop();
                joy_th.remote_stop();
            }
        }
    }
    Timer{
        id: timer_mapping
        interval: 500
        running: false
        repeat: true
        onTriggered: {
            if(supervisor.getMappingflag()){
                //Mapping update
                supervisor.setMappingflag(false);
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
            if(supervisor.getRobotState() == 7){
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
        id: popup_save_mapping
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
                                    //save temp Image
                                    map.save_map("map_temp.png");

                                    //임시 맵 이미지를 해당 폴더 안에 넣음.
                                    supervisor.rotate_map("map_temp.png",textfield_name22.text, 2);

                                    //맵 새로 불러오기.
                                    map.use_rawmap = true;
                                    map.loadmap(textfield_name22.text);

                                    supervisor.clear_all();
                                    map.state_annotation = "OBJECT";
                                    loader_menu.sourceComponent = menu_annot_object;
                                    popup_save_mapping.close();
                                }
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
                                    map.save_map("map_edited_temp.png");

                                    //임시 맵 이미지를 해당 폴더 안에 넣음.
                                    supervisor.rotate_map("map_edited_temp.png",textfield_name.text, 2);

                                    //맵 새로 불러오기.
                                    map.use_rawmap = false;
                                    map.use_minimap = false;
                                    map.loadmap(textfield_name.text);

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
                    map.update_canvas_all();
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
                        map.update_canvas_all();
                        map.tool = "MOVE";
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
        background: Rectangle{
            anchors.fill:parent
            color: "#f4f4f4"
        }
        onOpened: {
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
                            supervisor.addLocation(select_location_type,tfield_location.text, map.new_loc_x, map.new_loc_y, map.new_loc_th);
                            map.tool = "MOVE";
                            map.new_location = false;
                            map.new_loc_x = 0;
                            map.new_loc_y = 0;
                            map.new_loc_th = 0;
                            map.new_loc_available = false;
                            popup_add_location.close();
                            map.update_canvas_all();
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
                        popup_add_travelline.close();
                        map.update_canvas_all();
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
                                    print(map.new_location, map.new_loc_available);
                                    if(map.new_location && map.new_loc_available){
                                        supervisor.addPatrol("POINT","",canvas_location.new_loc_x, canvas_location.new_loc_y, canvas_location.new_loc_th);
                                        update_patrol_location();
                                    }
                                    map.new_location = false;
                                    map.tool = "MOVE";
                                    popup_add_patrol_1.close();
                                }else if(modelData == "retry"){
                                    popup_add_patrol_1.close();
                                }else if(modelData == "cancel"){
                                    map.tool = "MOVE";
                                    map.new_location = false;
                                    popup_add_patrol_1.close();
                                }
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

    function loadmap(name){
        check_slam_init_timer.stop();
        map.loadmap(name);
        updatemap();
        map.update_canvas_all();
    }

    function init_map(){
        map.init_mode();
        timer_get_joy.stop();
        map.state_annotation = "NONE";
        print("map_mode "+map_mode)
        if(map_mode == 0){
            timer_get_joy.start();
            loader_menu.sourceComponent = menu_main;
            text_menu_title.visible = false;
            map.show_buttons = true;
            text_menu_title.text = "";

        }else if(map_mode == 1){
            text_menu_title.text = "SLAM";
            text_menu_title.visible = true;
            timer_get_joy.start();
            map.fill_canvas_map();
            map.show_lidar = true;
            map.show_robot = true;
            map.just_show_map = true;
            map.show_connection = false;
            loader_menu.sourceComponent = menu_slam;
        }else if(map_mode == 2){
            text_menu_title.text = "Annotation";
            text_menu_title.visible = true;
            map.show_location = true;
            map.show_connection = false;
            map.show_object = true;
            map.show_travelline = true;
            map.robot_following = false;
            loader_menu.sourceComponent = menu_annot_state;
        }else if(map_mode == 3){
            text_menu_title.text = "Patrol";
            text_menu_title.visible = true;
            map.show_patrol = true;
            map.show_robot   = true;
            map.show_object = true;
            map.show_connection = false;
//            map.show_path = true;
//            map.show_location = true;
//            map.show_travelline = true;
            map.robot_following = false;
            loader_menu.sourceComponent = menu_patrol;
        }else if(map_mode == 4){
            text_menu_title.visible = true;
            text_menu_title.text = "Localization";
            map.show_lidar = true;
            map.show_buttons = true;
            map.show_robot = true;
            map.show_object = true;
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
