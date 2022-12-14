import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0 as Platform
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

    //annotation
    property string select_object_type: "Wall"
    property string select_location_type: "Serving"
    property int select_tline_num: -1
    property int select_tline_category: -1


    Component.onCompleted: {
        init();
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
            modeinit();
        }else{
            ani_mode_change.start();
//            modechange();
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
            rect_menu_dump.visible = false;
            rect_menu_dump.anchors.topMargin = 0;
            map_annot.enabled = true;
            map_cur.enabled = true;
            map_cur.visible = false;
            if(map_mode == 1){ // slam
                loader_menu.sourceComponent = menu_slam;
                map.init_mode();
                map.show_lidar = true;
                map.show_robot = true;
            }else if(map_mode == 2){ //annotation
                loader_menu.sourceComponent = menu_annot_state;
                map.init_mode();
                map.show_location = true;
                map.show_object = true;
                map.show_travelline = true;
                map.robot_following = false;
            }else if(map_mode == 3){ //patrol
                update_patrol_location();
                loader_menu.sourceComponent = menu_patrol;
                map.init_mode();
                map.show_patrol = true;
                map.show_robot   = true;
                map.show_object = true;
                map.show_path = true;
            }else if(map_mode == 4){ //localization
                loader_menu.sourceComponent = menu_slam_init;
                map.init_mode();
                map.show_lidar = true;
                map.show_robot = true;
                map.show_object = true;
            }
        }
    }

    function modeinit(){
        init();
        loader_menu.sourceComponent = menu_main;
        loader_menu.item.appear();
        map_cur.visible = true;
        map_annot.visible = false;
        map_cur.opacity = 1;

        rect_menus.width = margin_name;
        btn_menu.width = 120;
        timer_get_joy.start();
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
                show_object: true
                anchors.left: parent.left
                anchors.leftMargin: 200//parent.width/2 - width/2
                anchors.top: text_curmap.bottom
                anchors.topMargin: 20
            }
          Text{
              text: "?????? ??????\n(lock on-off)"
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

            Image{
                id: image_joy_up
                source: "icon/joy_up.png"
                width: 13
                height: 8
                anchors.horizontalCenter: joy_xy.horizontalCenter
                anchors.bottom: joy_xy.top
                anchors.bottomMargin: 8
            }
            Image{
                id: image_joy_down
                source: "icon/joy_down.png"
                width: 13
                height: 8
                anchors.horizontalCenter: joy_xy.horizontalCenter
                anchors.top: joy_xy.bottom
                anchors.topMargin: 8
            }
            Image{
                id: image_joy_left
                source: "icon/joy_left.png"
                width: 8
                height: 13
                anchors.verticalCenter: joy_th.verticalCenter
                anchors.right: joy_th.left
                anchors.rightMargin: 8
            }
            Image{
                id: image_joy_right
                source: "icon/joy_right.png"
                width: 8
                height: 13
                anchors.verticalCenter: joy_th.verticalCenter
                anchors.left: joy_th.right
                anchors.leftMargin: 8
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
                just_show_map: true
            }
            Rectangle{
                id: rect_init_notice
                width: 400
                height: 100
                visible: slam_initializing
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                color: "gray"
                Text{
                    anchors.centerIn: parent
                    text:"????????? ???...????????? ?????? ???????????????."
                    color: "white"
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
                anchors.centerIn: parent

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
                                    patrol_location_model.clear();
                                    if(supervisor.getPatrolFileName() == ""){
                                        text_patrol.text = "?????? ?????? ??? ????????? ????????? ????????????.";
                                    }else{
                                        supervisor.loadPatrolFile(supervisor.getPatrolFileName());
                                        if(supervisor.getPatrolMode() == 0){
                                            stackview_patrol_menu.push(menu_patrol_location);
                                            text_patrol.text = "?????? ????????? ?????? : "+supervisor.getPatrolFileName();
                                        }else{
                                            stackview_patrol_menu.push(menu_patrol_record);
                                            text_patrol.text = "?????? ????????? ?????? : "+supervisor.getPatrolFileName();
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
                if(map_mode==0){
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

            Column{
                id: column_slam_menus
                spacing: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50


                Rectangle{
                    id: btn_slam_save
                    width: 150
                    height: 70
                    radius: 15
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#D0D0D0"
                    Text{
                        anchors.centerIn: parent
                        text: "save"
                        font.family: font_noto_b.name
                        font.pixelSize: 20
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            map.save_map("image/raw_map.png");
                            supervisor.writelog("[USER INPUT] Save Mapping Image -> image/raw_map.png");
                        }
                    }
                }
                Row{
                    id: row_slam_menu
                    spacing: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    Repeater{
                        model: ["run","stop"]
                        Rectangle{
                            width: 150
                            height: 70
                            radius: 15
                            color: "#D0D0D0"
                            Text{
                                anchors.centerIn: parent
                                text: modelData
                                font.family: font_noto_b.name
                                font.pixelSize: 20
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(modelData == "run"){
                                        supervisor.startMapping();
                                        timer_mapping.start();
                                    }else if(modelData == "stop"){
                                        supervisor.stopMapping();
                                        timer_mapping.stop();
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Image{
                id: image_joy_up
                source: "icon/joy_up.png"
                width: 13
                height: 8
                anchors.horizontalCenter: joy_xy.horizontalCenter
                anchors.bottom: joy_xy.top
                anchors.bottomMargin: 8
            }
            Image{
                id: image_joy_down
                source: "icon/joy_down.png"
                width: 13
                height: 8
                anchors.horizontalCenter: joy_xy.horizontalCenter
                anchors.top: joy_xy.bottom
                anchors.topMargin: 8
            }
            Image{
                id: image_joy_left
                source: "icon/joy_left.png"
                width: 8
                height: 13
                anchors.verticalCenter: joy_th.verticalCenter
                anchors.right: joy_th.left
                anchors.rightMargin: 8
            }
            Image{
                id: image_joy_right
                source: "icon/joy_right.png"
                width: 8
                height: 13
                anchors.verticalCenter: joy_th.verticalCenter
                anchors.left: joy_th.right
                anchors.leftMargin: 8
            }

            Item_joystick{
                id: joy_xy
                anchors.top: column_slam_menus.bottom
                anchors.topMargin: 100
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
                anchors.top: column_slam_menus.bottom
                anchors.topMargin: 100
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
            anchors.fill: parent
            Row{
                id: row_slam_menu
                spacing: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
                Repeater{
                    model : ["init","new"]
                    Rectangle{
                        width: 100
                        height: 100
                        radius: 50
                        color: "gray"
                        Text{
                            text: modelData
                            anchors.centerIn: parent
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "init"){
                                    stackview_slam_menu.push(menu_slam_init);
                                }else if(modelData == "new"){

                                }
                            }
                        }
                    }
                }
            }

            StackView{
                id: stackview_slam_menu
                width: parent.width
                height: parent.height - y
                anchors.top: row_slam_menu.bottom
                anchors.topMargin: 50
                initialItem: menu_slam_init
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
            Text{
                id: text_patrol
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: font_noto_b.name
                text: "?????? ?????? ??? ????????? ????????? ????????????."
            }
            Row{
                id: row_patrol_menu
                spacing: 20
                anchors.top: text_patrol.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater{
                    id:repeat_patrol_menu
                    model:["make","load","save"]
                    Rectangle{
                        id: btn_patrol_menus
                        width: 60
                        height: 60
                        radius: 30
                        color: "#282828"
                        Text{
                            text: modelData
                            color: "white"
                            font.family: font_noto_b.name
                            font.pixelSize: 15
                            anchors.centerIn: parent
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "make"){
                                    if(supervisor.getPatrolMode() == 0){
                                        stackview_patrol_menu.push(menu_patrol_location);
                                        supervisor.makePatrol();
                                        supervisor.addPatrol("START","Resting_0",0,0,0);
                                    }else{
                                        stackview_patrol_menu.push(menu_patrol_record);
                                    }
                                    update_patrol_location();
                                }else if(modelData == "load"){
                                    fileopenpatrol.open();
                                }else if(modelData == "save"){
                                    if(supervisor.getPatrolFileName() == ""){
                                        filesavepatrol.open();
                                    }else{
                                        supervisor.savePatrolFile(supervisor.getPatrolFileName());
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Row{
                id: row_patrol_mode
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: row_patrol_menu.bottom
                anchors.topMargin: 20
                spacing: 40
                Rectangle{
                    id: mode_location
                    width: 100
                    height: 50
                    radius: 10
                    color: supervisor.getPatrolMode()===0?"blue":"gray"
                    Text{
                        anchors.centerIn: parent
                        text: "location mode"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            supervisor.setPatrolMode(0);
                        }
                    }
                }
                Rectangle{
                    id: mode_record
                    width: 100
                    height: 50
                    radius: 10
                    color: supervisor.getPatrolMode()===1?"blue":"gray"
                    Text{
                        anchors.centerIn: parent
                        text: "record mode"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            supervisor.setPatrolMode(1);
                        }
                    }
                }
                Rectangle{
                    id: mode_random
                    width: 100
                    height: 50
                    radius: 10
                    color: supervisor.getPatrolMode()===2?"blue":"gray"
                    Text{
                        anchors.centerIn: parent
                        text: "random mode"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            supervisor.setPatrolMode(2);
                        }
                    }
                }
            }

            StackView{
                id: stackview_patrol_menu
                width: rect_menus.width
                height: rect_menus.height - y
                anchors.top: row_patrol_mode.bottom
                anchors.topMargin: 30
                initialItem: Item{
                    Rectangle{
                        anchors.fill: parent
                        color: "white"
                    }
                }
            }
        }

    }


    //SLAM Menu ITEM===================================================
    Item{
        id: menu_slam_init
        objectName: "menu_slam_init"
        width: parent.width
        height: parent.height
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "white"
            Row{
                id: row_slam_menu1
                spacing: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 100
                Repeater{
                    model: ["move","point"]
                    Rectangle{
                        width: 100
                        height: 100
                        radius: 50
                        color: "gray"
                        Text{
                            anchors.centerIn: parent
                            text: modelData
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "move"){
                                    map.tool = "MOVE";
                                    map.new_slam_init = false;
                                }else if(modelData == "point"){
                                    map.tool = "SLAM_INIT";
                                }
                            }
                        }
                    }
                }
            }
            Row{
                id: row_slam_menu2
                spacing: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: row_slam_menu1.bottom
                anchors.topMargin: 100
                Repeater{
                    model: ["set init","run","stop","auto"]
                    Rectangle{
                        width: 100
                        height: 100
                        radius: 50
                        color: "gray"
                        Text{
                            anchors.centerIn: parent
                            text: modelData
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "set init"){
                                    supervisor.slam_setInit();
                                }else if(modelData == "run"){
                                    supervisor.slam_run();
                                }else if(modelData == "stop"){
                                    supervisor.slam_stop();
                                }else if(modelData == "auto"){
                                    supervisor.slam_autoInit();
                                    check_slam_init_timer.trigger_cnt = 0;
                                    check_slam_init_timer.start();
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
                    text: "MAP : " + map_name
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
                                //save temp Image
                                map.save_canvas_temp();
                                map.loadmap("file://"+applicationDirPath+"/image/map_edited.png");
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
                    Rectangle//???????????? ?????????
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

                    Rectangle//???????????? ?????????
                    {
                        id:line
                        width:parent.width
                        anchors.bottom:parent.bottom//?????? ????????? ?????? ???????????? ??????????????? ????????? ??????????????? ????????? ??????????????? ??????
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
                                text: "Meta ??????"
                                font.family: font_noto_r.name
                                font.pixelSize: 13
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(supervisor.saveMetaData("setting/map_meta.ini")){
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
                                text: "Annot ??????"
                                font.family: font_noto_r.name
                                font.pixelSize: 13
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(supervisor.saveAnnotation("setting/annotation.ini")){
                                    btn_add1.border.width = 3;
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
                                text: "????????? ??????"
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
                        text: "MAP : " + map_name
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
                                map_mode = 0;
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
                                    supervisor.movePatrolUp(map.select_patrol);
                                    update_patrol_location();
                                    if(map.select_patrol>1)
                                        map.select_patrol--;
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
        id: menu_patrol_record
        Item{
            anchors.fill: parent
            Rectangle{
                anchors.fill: parent
                color: "blue"
            }
            Row{
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
                Repeater{
                    model:["record","play","pause","stop"]
                    Rectangle{
                        width: 50
                        height: 50
                        radius: 20
                        color: "gray"
                        Text{
                            anchors.centerIn: parent
                            text: modelData
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                print(modelData);
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
                    text: "????????? ?????? ?????? ?????????"
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
        patrol_location_model.clear();
        if(supervisor.getPatrolFileName() == ""){
            text_patrol.text = "?????? ?????? ??? ????????? ????????? ????????????.";
        }else{
            text_patrol.text = "?????? ????????? ?????? : "+supervisor.getPatrolFileName();
        }

        for(var i=0; i<supervisor.getPatrolNum(); i++){
            patrol_location_model.append({name:supervisor.getPatrolType(i),location:supervisor.getPatrolLocation(i),loc_x:supervisor.getPatrolX(i),loc_y:supervisor.getPatrolY(i),loc_th:supervisor.getPatrolTH(i)});
        }
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
                map.loadmapping();
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
        folder: "file:"+applicationDirPath+"/image"
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
        folder: "file:"+applicationDirPath+"/setting"
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
        folder: "file:"+applicationDirPath+"/patrol"
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
        folder: "file:"+applicationDirPath+"/patrol"
        onAccepted: {
            supervisor.loadPatrolFile(fileopenpatrol.file.toString());
            update_patrol_location();
        }
    }
    Platform.FileDialog{
        id: filesavemeta
        fileMode: Platform.FileDialog.SaveFile
        property variant pathlist
        property string path : ""
        folder: "file:"+applicationDirPath+"/setting"
        onAccepted: {
            print(filesavemeta.file.toString())

            supervisor.saveMetaData(filesavemeta.file.toString());
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
                color: iscol?"red":"black"
            }
            Rectangle//???????????? ?????????
            {
                id:line
                width:parent.width
                anchors.bottom:parent.bottom//?????? ????????? ?????? ???????????? ??????????????? ????????? ??????????????? ????????? ??????????????? ??????
                height:1
                color:"#e8e8e8"
            }
            MouseArea{
                id:area_compo
                anchors.fill:parent
                onClicked: {
                    map.select_location = supervisor.getLocNum(name);
                    list_location2.currentIndex = index;
                    map.update_canvas_all();
                }
            }
        }
    }
    Popup{
        id: popup_add_patrol
        width: 700
        height: 600
        anchors.centerIn: parent
        Rectangle{
            id: rect_ba
            anchors.fill:parent
            Text{
                id: text_popup_patrol
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 30
                text:"?????? ??????????????? ?????? ????????? ????????? ??????????????? ???????????? ?????? ????????? ??????????????????."
            }

            ListView {
                id: list_location2
                width: 250
                height: 400
                anchors.top: text_popup_patrol.bottom
                anchors.topMargin: 30
                anchors.left: parent.left
                anchors.leftMargin: 30
                clip: true
                model: ListModel{}
                delegate: locationCompo1
                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                focus: true
            }
            Column{
                id: menubar22
                spacing: 30
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: list_location2.right
                anchors.leftMargin: 50
                Repeater{
                    model: ["confirm","cancel","in map"]
                    Rectangle{
                        property int btn_size: 100
                        width: 50
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
                                }else if(modelData == "cancel"){
                                    popup_add_patrol.close();
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
                    text: "??????"
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
                    text: "??????"
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
                id: btn_prev_00
                width: 180
                height: 60
                radius: 10
                color:"transparent"
                border.width: 1
                border.color: "#7e7e7e"
                Text{
                    anchors.centerIn: parent
                    text: "??????"
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
                id: btn_next_00
                width: 180
                height: 60
                radius: 10
                color: "black"
                border.width: 1
                border.color: "#7e7e7e"
                Text{
                    anchors.centerIn: parent
                    text: "??????"
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
                text: "??????"
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
                text: "??????"
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
        anchors.centerIn: parent
        Rectangle{
            anchors.fill: parent
            color: "white"
            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 30
                text: "????????? ????????? ???????????? ?????? ???????????????????"
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
                                    if(canvas_location.isnewLoc && canvas_location.new_loc_available){
                                        supervisor.addPatrol("POINT","",canvas_location.new_loc_x, canvas_location.new_loc_y, canvas_location.new_loc_th);
                                        update_patrol_location();
                                    }
                                    canvas_location.isnewLoc = false;
                                    map.tool = "MOVE";
                                    popup_add_patrol_1.close();
                                }else if(modelData == "retry"){
                                    popup_add_patrol_1.close();
                                }else if(modelData == "cancel"){
                                    map.tool = "MOVE";
                                    canvas_location.isnewLoc = false;
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
        if(supervisor.getPatrolMode() == 0){
            mode_location.color = "blue";
            mode_record.color = "gray";
            mode_random.color = "gray";
            if(stackview_patrol_menu.currentItem.objectName !== "menu_patrol_location"){
                stackview_patrol_menu.pop();
                stackview_patrol_menu.push(menu_patrol_location);
            }
        }else if(supervisor.getPatrolMode() == 1){
            mode_location.color = "gray";
            mode_record.color = "blue";
            mode_random.color = "gray";
            if(stackview_patrol_menu.currentItem.objectName != "menu_patrol_record"){
                stackview_patrol_menu.pop();
                stackview_patrol_menu.push(menu_patrol_record);
            }
        }else if(supervisor.getPatrolMode() == 2){
            mode_location.color = "gray";
            mode_record.color = "gray";
            mode_random.color = "blue";
            if(stackview_patrol_menu.currentItem.objectName != "menu_patrol_random"){
                stackview_patrol_menu.pop();
                stackview_patrol_menu.push(menu_patrol_random);
            }
        }
    }

    function loadmap(path){
        map.loadmap(path);
        map_current.loadmap(path);
        updatemap();
        map.update_canvas_all();
    }

    function init(){
        if(map_mode == 1){
            map.mapping_mode = true;
            map.just_show_map = true;
            loader_menu.sourceComponent = menu_slam;
            timer_get_joy.start();
        }else if(map_mode == 2){
            timer_get_joy.stop();
            loader_menu.sourceComponent = menu_annot_state;
            map.state_annotation = "NONE";
        }
        map.init();
        map_current.init();
        loadmap(map_path);
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
