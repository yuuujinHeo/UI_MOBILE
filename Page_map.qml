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
    property bool isrun: false
    property bool slam_initializing: false
    property bool joystick_connection: false

    property var joy_axis_left_ud: 0
    property var joy_axis_right_rl: 0

    //mode : 0(mapview) 1:(slam) 2:(annotation) 3:(patrol)
    property int map_mode: 0

    Component.onCompleted: {
        init();
        loadmap(map_path);

        var ob_num = supervisor.getObjectNum();
        list_object.model.clear();
        for(var i=0; i<ob_num; i++){
            list_object.model.append({"name":supervisor.getObjectName(i)});
        }

        var loc_num = supervisor.getLocationNum();
        list_location.model.clear();
        for(i=0; i<loc_num; i++){
            list_location.model.append({"name":supervisor.getLocationTypes(i),"iscol":false});
        }


        var travel_num = supervisor.getTlineSize();
        list_travel_line.model.clear();
        for(i=0; i<travel_num; i++){
            list_travel_line.model.append({"name":supervisor.getTlineName(i)});
        }
        map.select_travel_line = 0;

        var line_num = supervisor.getTlineSize(map.select_travel_line);
        list_line.model.clear();
        for(i=0; i<line_num; i=i+2){
            list_line.model.append({"name":"line_" + Number(i/2)});
        }

        map.update_canvas_all();





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
            ani_modechange_return.start();
        }else{
            ani_modechange.start();
        }
    }


    SequentialAnimation{
        id: ani_modechange
        running: false
        ParallelAnimation{
            NumberAnimation{target:menubar; property:"opacity"; from:1;to:0;duration:500;}
            NumberAnimation{target:rect_menus; property:"width"; from:margin_name;to:450;duration:500;}
            NumberAnimation{target:btn_menu; property:"width"; from:120;to:60;duration:500;}
        }
        onStarted: {
            timer_get_joy.stop();
            stackview_map.currentItem.visible = false;
            ani_modechange_return.stop();
        }
        onFinished: {
            if(map_mode == 1){
                stackview_menu.push(menu_slam);
                stackview_map.push(map_annot);
                map.init_mode();
                map.show_lidar = true;
                map.show_robot = true;
            }else if(map_mode == 2){
                stackview_menu.push(menu_annot);
                stackview_map.push(map_annot);
                map.init_mode();
                map.robot_following = false;
            }else if(map_mode == 3){
                update_patrol_location();
                stackview_menu.push(menu_patrol);
                stackview_map.push(map_annot);
                map.init_mode();
                map.show_patrol = true;
                map.show_robot   = true;
                map.show_object = true;
                map.show_path = true;
            }
            stackview_map.currentItem.visible = true;
        }
    }
    SequentialAnimation{
        id: ani_modechange_return
        running: false
        onStarted: {
            stackview_menu.pop();
            ani_modechange.stop();
            menubar.visible = true;
            stackview_map.currentItem.visible = false;
        }
        onFinished: {
            timer_get_joy.start();
            stackview_map.pop();
            stackview_map.currentItem.visible = true;
        }
        NumberAnimation{target:menubar; property:"opacity"; from:1;to:0;duration:1;}
        ParallelAnimation{
            NumberAnimation{target:btn_menu; property:"width"; from:btn_menu.width;to:120;duration:300;}
            NumberAnimation{target:rect_menus; property:"width"; from:450;to:margin_name;duration:300;}
        }
        NumberAnimation{target:menubar; property:"opacity"; from:0;to:1;duration:300;}
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
        color: "#f4f4f4"

        StackView{
            id:stackview_menu
            anchors.fill:parent

            pushEnter: Transition { PropertyAnimation { //뷰를 push 한 화면이 그려지는 애니메이션
                    property: "opacity"                 //투명도가 설정 되게 설정 x,나 y등 다른 속성값으로 설정할수 있음
                    from: 0.5                           //투명도를 1에서 1로 바꿔줌 즉 투명도가 변하지 않아서 애니메이션이 없는 것처럼 된다.
                    to:1
                    duration: 0
            }}
            pushExit: Transition { PropertyAnimation {  //뷰를 push 한 화면이 그려질때 이전화면이 없어지는 애니메이션
                    property: "opacity"                 //투명도가 설정 되게 설정 x,나 y등 다른 속성값으로 설정할수 있음
                    from: 0.5
                    to:1                                //투명도를 1에서 1로 바꿔줌 즉 투명도가 변하지 않아서 애니메이션이 없는 것처럼 된다.

                    duration: 0
            }}
            popEnter: Transition { PropertyAnimation { //뷰를 push 한 화면이 그려지는 애니메이션
                    property: "opacity"                 //투명도가 설정 되게 설정 x,나 y등 다른 속성값으로 설정할수 있음
                    from: 0.5                           //투명도를 1에서 1로 바꿔줌 즉 투명도가 변하지 않아서 애니메이션이 없는 것처럼 된다.
                    to:1
                    duration: 0
            }}
            popExit: Transition { PropertyAnimation {  //뷰를 push 한 화면이 그려질때 이전화면이 없어지는 애니메이션
                    property: "opacity"                 //투명도가 설정 되게 설정 x,나 y등 다른 속성값으로 설정할수 있음
                    from: 0.5
                    to:1                                //투명도를 1에서 1로 바꿔줌 즉 투명도가 변하지 않아서 애니메이션이 없는 것처럼 된다.

                    duration: 0
            }}
            initialItem: Item{
                id: menu_main
                objectName: "menu_main"
                Column{
                    id: menubar
                    spacing: 50
                    anchors.centerIn: parent
                    Repeater{
                        model: ["slam","annot","patrol"]
                        Rectangle{
                            property int btn_size: 100
                            width: btn_size
                            height: btn_size
                            radius: btn_size
                            color: "white"
                            Rectangle{
                                id: rect_btn
                                width: btn_size
                                height: btn_size
                                radius: btn_size
                                color: "white"
                                Text{
                                    anchors.verticalCenter : parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: font_noto_r.name
                                    font.pixelSize: 20
                                    color: "#7e7e7e"
                                    text:modelData
                                }
                            }
                            DropShadow{
                                anchors.fill: parent
                                radius: 15
                                color: "#d0d0d0"
                                source: rect_btn
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(modelData == "slam"){
                                        map_mode = 1;
                                    }else if(modelData == "annot"){
                                        map_mode = 2;
                                    }else if(modelData == "patrol"){
                                        map_mode = 3;
                                        patrol_location_model.clear();
                                        if(supervisor.getPatrolFileName() == ""){
                                            text_patrol.text = "현재 설정 된 패트롤 파일이 없습니다.";
                                        }else{
                                            supervisor.loadPatrolFile(supervisor.getPatrolFileName());
                                            if(supervisor.getPatrolMode() == 0){
                                                stackview_patrol_menu.push(menu_patrol_location);
                                                text_patrol.text = "현재 패트롤 파일 : "+supervisor.getPatrolFileName();
                                            }else{
                                                stackview_patrol_menu.push(menu_patrol_record);
                                                text_patrol.text = "현재 패트롤 파일 : "+supervisor.getPatrolFileName();
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

    StackView{
        id:stackview_map
        width: parent.width - rect_menus.width
        height: parent.height - status_bar.height
        anchors.left: rect_menus.right
        anchors.top: status_bar.bottom
        background: Rectangle{
            color:"#282828"
        }

        pushEnter: Transition { PropertyAnimation { //뷰를 push 한 화면이 그려지는 애니메이션
                property: "opacity"                 //투명도가 설정 되게 설정 x,나 y등 다른 속성값으로 설정할수 있음
                from: 0.5                           //투명도를 1에서 1로 바꿔줌 즉 투명도가 변하지 않아서 애니메이션이 없는 것처럼 된다.
                to:1
                duration: 0
        }}
        pushExit: Transition { PropertyAnimation {  //뷰를 push 한 화면이 그려질때 이전화면이 없어지는 애니메이션
                property: "opacity"                 //투명도가 설정 되게 설정 x,나 y등 다른 속성값으로 설정할수 있음
                from: 0.5
                to:1                                //투명도를 1에서 1로 바꿔줌 즉 투명도가 변하지 않아서 애니메이션이 없는 것처럼 된다.

                duration: 0
        }}
        popEnter: Transition { PropertyAnimation { //뷰를 push 한 화면이 그려지는 애니메이션
                property: "opacity"                 //투명도가 설정 되게 설정 x,나 y등 다른 속성값으로 설정할수 있음
                from: 0.5                           //투명도를 1에서 1로 바꿔줌 즉 투명도가 변하지 않아서 애니메이션이 없는 것처럼 된다.
                to:1
                duration: 0
        }}
        popExit: Transition { PropertyAnimation {  //뷰를 push 한 화면이 그려질때 이전화면이 없어지는 애니메이션
                property: "opacity"                 //투명도가 설정 되게 설정 x,나 y등 다른 속성값으로 설정할수 있음
                from: 0.5
                to:1                                //투명도를 1에서 1로 바꿔줌 즉 투명도가 변하지 않아서 애니메이션이 없는 것처럼 된다.

                duration: 0
        }}

        initialItem: Item{
            id: map_cur
            objectName: "map_current"
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
                    anchors.leftMargin: parent.width/2 - width/2
                    anchors.top: text_curmap.bottom
                    anchors.topMargin: 20
                }
//                Text{
//                    text: "joystick\nconnection"
//                    anchors.horizontalCenter: switch_joy.horizontalCenter
//                    anchors.bottom: switch_joy.top
//                    anchors.bottomMargin: 20
//                    font.family: font_noto_b.name
//                    color: "white"
//                    font.pixelSize: 20
//                    horizontalAlignment: Text.AlignHCenter
//                }
//                Item_switch{
//                    id: switch_joy
//                    anchors.left: joy_th.right
//                    anchors.leftMargin: 50
//                    anchors.verticalCenter: joy_th.verticalCenter
//                    onoff: joystick_connection
//                    touchEnabled: false
//                }

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
    }

    Rectangle{
        id: btn_menu
        width: 120
        height: width
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.top: status_bar.bottom
        anchors.topMargin: 50
        color: "white"
        radius: 30
        Image{
            source:"icon/btn_reset.png"
            scale: 1-(120-parent.width)/120
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                backPage();
            }
        }
    }

    ////////************************ITEM :: MAP **********************************************************
    Item{
        id: map_slam
        objectName: "map_slam"
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "#282828"
        }
    }

    Item{
        id: map_annot
        objectName: "map_annot"
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "#282828"
            Map_full{
                id: map
                height: stackview_map.height
                width: height
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                clip: true
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
                    text:"초기화 중...시간이 조금 소요됩니다."
                    color: "white"
                }
            }
        }
    }
    ////////************************ITEM :: MENU**********************************************************

    Item{
        id: menu_slam
        objectName: "menu_slam"
        visible: false
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

    Item{
        id: menu_annot
        objectName: "menu_annot"
        visible: false
        StackView{
            id: stackview_annot_menu
            anchors.fill: parent
            initialItem: menu_state
        }
    }

    Item{
        id: menu_patrol
        objectName: "menu_patrol"
        visible: false
        Text{
            id: text_patrol
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: font_noto_b.name
            text: "현재 설정 된 패트롤 파일이 없습니다."
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
    Item{
        id: menu_state
        objectName: "menu_init"
        width: parent.width
        height: parent.height
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "#f4f4f4"
            Column{
                anchors.top: parent.top
                anchors.topMargin: 25
                spacing: 25
                Rectangle{
                    y: 20
                    width: menu_state.width
                    height: rect_menus.menu_height
                    color: "yellow"
                    radius: 10
                    Text{
                        id: text_name
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 15
                        text: "Map : "
                    }
                }
                Rectangle{
                    width: menu_state.width
                    height: rect_menus.menu_height
                    color: "yellow"
                    radius: 10
                }
                Rectangle{
                    width: menu_state.width
                    height: rect_menus.menu_height
                    color: "yellow"
                    radius: 10
                }
                Rectangle{
                    width: menu_state.width
                    height: rect_menus.menu_height
                    color: "yellow"
                    radius: 10
                }
            }

            //prev, next button
            Rectangle{
                id: btn_prev_0
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Previous"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        init();
                    }
                }
            }
            Rectangle{
                id: btn_next_0
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Next"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        map.state_annotation = "DRAWING";
                        stackview_annot_menu.push(menu_load_edit);
                    }
                }
            }
        }
    }

    Item{
        id: menu_load_edit
        objectName: "menu_load_edit"
        width: parent.width
        height: parent.height
        visible: false
        Rectangle{
            width: parent.width
            height: parent.height
            anchors.fill: parent
            color: "transparent"
            Text{
                id: text_main_1
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
                text: "Step 1. Map annotation and edit location"
            }

            //map load
            Rectangle{
                id: text_cur_name
                anchors.top: text_main_1.bottom
                anchors.topMargin: 30
                width: parent.width
                height: rect_menus.menu_height
                color: "yellow"
                radius: 10
                Text{
                    id: text_name2
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 15
                    text: " Current Map : "
                }
                Text{
                    id: text_name3
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 15
                    text: "/image/"+map_name + ".png";
                }
            }
            Rectangle{
                id: btn_load_map
                width: parent.width/2
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_cur_name.bottom
                anchors.topMargin: 30

                radius: 10
                border.width: 2
                border.color: "gray"

                Text{
                    anchors.centerIn: parent
                    text: "Load"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        fileload.open();
                    }
                }
            }


            //draw Menu
            Row{
                id: menubar_drawing
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: btn_load_map.bottom
                anchors.topMargin: 30
                spacing: 25
                Repeater{
                    model: ["move","draw","clear","undo","redo"]
                    Rectangle{
                        id: btn
                        width: 60
                        height: 60
                        color: {
                            if(map.tool == "MOVE"){
                                if(modelData == "move"){
                                    "blue"
                                }else{
                                    "gray"
                                }
                            }else if(map.tool == "BRUSH"){
                                if(modelData == "draw"){
                                    "blue"
                                }else{
                                    "gray"
                                }
                            }else{
                                "gray"
                            }
                        }
                        radius: 10
                        Image{
                            anchors.centerIn:  parent
                            antialiasing: true
                            mipmap: true
                            scale: {(height>width?parent.width/height:parent.width/width)*0.8}
                            source:{
                                if(modelData == "move"){
                                    "icon/btn_minimize.png"
                                }else if(modelData == "draw"){
                                    "icon/play_r.png"
                                }else if(modelData == "clear"){
                                    "icon/btn_reset.png"
                                }else if(modelData == "undo"){
                                    "icon/btn_no.png"
                                }else if(modelData == "redo"){
                                    "icon/btn_yes.png"
                                }
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "move"){
                                    map.tool = "MOVE";
                                }else if(modelData == "draw"){
                                    map.tool = "BRUSH";
                                }else if(modelData == "clear"){
                                    supervisor.clear_all();
                                    map.update_canvas_all();
                                }else if(modelData == "undo"){
                                    supervisor.undo();
                                    map.update_canvas_all();
                                }else if(modelData == "redo"){
                                    supervisor.redo();
                                    map.update_canvas_all();
                                }
                            }
                        }
                    }
                }
            }

            Row{
                id: colorbar
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: menubar_drawing.bottom
                anchors.topMargin: 30
                spacing: 25
                property color paintColor: "black"
                Repeater{
                    model: ["black", "#262626", "white"]
                    Rectangle {
                        id: red
                        width: 60
                        height: 60
                        color: modelData
                        border.color: "gray"
                        border.width: 2
                        radius: 60

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

            Slider {
                id: slider_brush
                x: 300
                y: 330
                value: 15
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: colorbar.bottom
                anchors.topMargin: 20
                width: parent.width/1.5
                height: 30
                from: 0.1
                to : 50
//                orientation: Qt.Vertical
                onValueChanged: {
                    map.brush_size = value;
                    print("slider : " +map.brush_size);
                }
                onPressedChanged: {
                    if(slider_brush.pressed){
                        brushview.visible = true;
                    }else{
                        brushview.visible =false;
                    }
                }
            }



            //prev, next button
            Rectangle{
                id: btn_prev_1
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Previous"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        map.init_mode();
                        map.state_annotation = "NONE";
                        stackview_annot_menu.pop();
                    }
                }
            }
            Rectangle{
                id: btn_next_1
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Next"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        //save temp Image
                        map.save_canvas_temp();
                        map.loadmap("file://"+applicationDirPath+"/image/map_edited.png");
                        supervisor.clear_all();
                        map.state_annotation = "OBJECT";
                        stackview_annot_menu.push(menu_object);
                    }
                }
            }
        }
    }
    Item{
        id: menu_object
        objectName: "menu_object"
        width: parent.width
        height: parent.height
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            Text{
                id: text_main_2
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
                text: "Step 2. Add Object"
            }
            Row{
                id: menubar_object
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_main_2.bottom
                anchors.topMargin: 30
                spacing: 25
                Repeater{
                    model: ["move","rect","add","clear","undo"]
                    Rectangle{
                        id: btn2
                        width: 60
                        height: 60
                        color: {
                            if(map.tool == "MOVE"){
                                if(modelData == "move"){
                                    "blue"
                                }else{
                                    "gray"
                                }
                            }else if(map.tool == "ADD_POINT"){
                                if(modelData == "add"){
                                    "blue"
                                }else{
                                    "gray"
                                }
                            }else if(map.tool == "ADD_OBJECT"){
                                if(modelData == "rect"){
                                    "blue"
                                }else{
                                    "gray"
                                }
                            }else{
                                "gray"
                            }
                        }
                        radius: 10
                        Text{
                            anchors.centerIn:  parent
                            text: modelData
                        }

//                        Image{
//                            anchors.centerIn:  parent
//                            antialiasing: true
//                            mipmap: true
//                            scale: {(height>width?parent.width/height:parent.width/width)*0.8}
//                            source:{
//                                if(modelData == "move"){
//                                    "icon/btn_minimize.png"
//                                }else if(modelData == "add"){
//                                    "icon/btn_setting.png"
//                                }else if(modelData == "clear"){
//                                    "icon/btn_reset.png"
//                                }else if(modelData == "undo"){
//                                    "icon/btn_no.png"
//                                }else if(modelData == "rect"){
//                                    "icon/btn_yes.png"
//                                }
//                            }
//                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "move"){
                                    map.tool = "MOVE";
                                }else if(modelData == "add"){
                                    map.tool = "ADD_POINT";
                                }else if(modelData == "clear"){
                                    supervisor.clearObjectPoints();
                                    map.update_canvas_all();
                                }else if(modelData == "undo"){
                                    supervisor.removeObjectPointLast();
                                    map.update_canvas_all();
                                }else if(modelData == "rect"){
                                    map.tool = "ADD_OBJECT";
                                }
                            }
                        }
                    }
                }
            }

            //List Object
            Component {
                id: objectCompo
                Item {
                    width: 250; height: 30
                    Text {
                        anchors.centerIn: parent
                        text: name
                    }
                    Rectangle//리스트의 구분선
                    {
                        id:line
                        width:parent.width
                        anchors.bottom:parent.bottom//현재 객체의 아래 기준점을 부모객체의 아래로 잡아주어서 위치가 아래로가게 설정
                        height:1
                        color:"black"
                    }
                    MouseArea{
                        id:area_compo
                        anchors.fill:parent
                        onClicked: {
                            map.select_object = supervisor.getObjNum(name);
                            print("select object = "+map.select_object);
                            list_object.currentIndex = index;
                            map.update_canvas_all();
                        }
                    }
                }
            }
            ListView {
                id: list_object
                width: 250
                height: 400
                anchors.top: menubar_object.bottom
                anchors.topMargin: 30
                anchors.left: parent.left
                anchors.leftMargin: 30
                clip: true
                model: ListModel{}
                delegate: objectCompo
                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                focus: true
            }

            Column{
                id: menubar_object2
                anchors.verticalCenter: list_object.verticalCenter
                anchors.left: list_object.right
                anchors.leftMargin: 40
                spacing: 30
                Repeater{
                    model: ["add","edit","remove"]
                    Rectangle{
                        id: btn3
                        width: 60
                        height: 60
                        color: "gray"
                        radius: 10
//                        Image{
//                            anchors.centerIn:  parent
//                            antialiasing: true
//                            mipmap: true
//                            scale: {(height>width?parent.width/height:parent.width/width)*0.8}
//                            source:{
//                                if(modelData == "edit"){
//                                    "icon/btn_reset.png"
//                                }else if(modelData == "remove"){
//                                    "icon/btn_no.png"
//                                }else if(modelData == "add"){
//                                    "icon/btn_yes.png"
//                                }
//                            }
//                        }
                        Text{
                            anchors.centerIn: parent
                            text: modelData
                        }

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "edit"){
                                    map.tool = "EDIT_OBJECT";
//                                    map.tool = "EDIT_POINT";
                                }else if(modelData == "remove"){
                                    supervisor.removeObject(list_object.model.get(list_object.currentIndex).name);
                                    map.update_canvas_all();
                                }else if(modelData == "add"){
                                    popup_add_object.open();
                                }
                            }
                        }
                    }
                }
            }

            Rectangle{
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Previous"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        map.init_mode();
                        map.state_annotation = "DRAWING";
                        stackview_annot_menu.pop();
                    }
                }
            }
            Rectangle{
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Next"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        map.init_mode();
                        map.state_annotation = "LOCATION";
                        map.update_canvas_all();
                        stackview_annot_menu.push(menu_location);
                    }
                }
            }
        }
    }
    Item{
        id: menu_location
        objectName: "menu_location"
        width: parent.width
        height: parent.height
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            Text{
                id: text_main_3
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
                text: "Step 3. Set Margin"
            }
            Slider{
                id: slider_margin
                anchors.top: text_main_3.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 50
                from: 0
                to: 1
                value: supervisor.getMargin()
                onValueChanged: {
                    map.update_margin();
                }
            }
            Text{
                id: text_margin
                anchors.top: slider_margin.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
                text: "Margin [m] = " + slider_margin.value
            }

            //List Object
            Component {
                id: locationCompo
                Item {
                    width: 250; height: 30
                    Text {
                        id: text_loc
                        anchors.centerIn: parent
                        text: name
                        font.bold: iscol
                        color: iscol?"red":"black"
                    }
                    Rectangle//리스트의 구분선
                    {
                        id:line
                        width:parent.width
                        anchors.bottom:parent.bottom//현재 객체의 아래 기준점을 부모객체의 아래로 잡아주어서 위치가 아래로가게 설정
                        height:1
                        color:"black"
                    }
                    MouseArea{
                        id:area_compo
                        anchors.fill:parent
                        onClicked: {
                            map.select_location = supervisor.getLocNum(name);
                            print("select location = "+map.select_location);
                            list_location.currentIndex = index;
                            list_location2.currentIndex = index;
                            map.update_canvas_all();
                        }
                    }
                }
            }
            ListView {
                id: list_location
                width: 250
                height: 400
                anchors.top: text_margin.bottom
                anchors.topMargin: 30
                anchors.left: parent.left
                anchors.leftMargin: 30
                clip: true
                model: ListModel{}
                delegate: locationCompo
                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                focus: true
            }

            Column{
                id: menubar_location
                anchors.verticalCenter: list_location.verticalCenter
                anchors.left: list_location.right
                anchors.leftMargin: 40
                spacing: 30
                Repeater{
                    model: ["move","add","edit","remove"]
                    Rectangle{
                        id: btn4
                        width: 60
                        height: 60
                        color: {
                            if(map.tool == "ADD_LOCATION" && modelData == "add")
                                "blue"
                            else if(map.tool == "EDIT_LOCATION" && modelData == "edit")
                                "blue"
                            else
                                "gray"


                        }
                        radius: 10
                        Image{
                            anchors.centerIn:  parent
                            antialiasing: true
                            mipmap: true
                            scale: {(height>width?parent.width/height:parent.width/width)*0.8}
                            source:{
                                if(modelData == "edit"){
                                    "icon/btn_wait.png"
                                }else if(modelData == "remove"){
                                    "icon/btn_no.png"
                                }else if(modelData == "add"){
                                    "icon/btn_yes.png"
                                }else if(modelData == "move"){
                                    "icon/btn_minimize.png"
                                }
                            }
                        }
                        Text{
                            anchors.centerIn: parent
                            text: modelData
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "edit"){
                                    map.tool = "EDIT_LOCATION";
                                }else if(modelData == "remove"){
                                    if(list_location.currentIndex > 0){
                                        supervisor.removeLocation(list_location.model.get(list_location.currentIndex).name);
                                        map.map.select_location = -1;
                                        map.update_canvas_all();
                                    }
                                }else if(modelData == "add"){
                                    if(map.tool == "ADD_LOCATION"){
                                        if(map.new_loc_available){
                                            popup_add_location.open();
                                        }else{

                                        }
                                    }else{
                                        map.tool = "ADD_LOCATION";
                                    }
                                }else if(modelData == "move"){
                                    map.tool = "MOVE";
                                }
                            }
                        }
                    }
                }
            }

            Rectangle{
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Previous"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        map.init_mode();
                        map.state_annotation = "OBJECT";
                        stackview_annot_menu.pop();
                    }
                }
            }
            Rectangle{
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Next"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        map.init_mode();
                        map.state_annotation = "TRAVELLINE";
                        stackview_annot_menu.push(menu_travelline);
                    }
                }
            }
        }
    }
    Item{
        id: menu_travelline
        objectName: "menu_travelline"
        width: parent.width
        height: parent.height
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            Text{
                id: text_main_4
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
                text: "Step 4. Travel Line"
            }
            //List Object
            Component {
                id: lineCompo
                Item {
                    width: 250; height: 30
                    Text {
                        anchors.centerIn: parent
                        text: name
                    }
                    Rectangle//리스트의 구분선
                    {
                        id:line
                        width:parent.width
                        anchors.bottom:parent.bottom//현재 객체의 아래 기준점을 부모객체의 아래로 잡아주어서 위치가 아래로가게 설정
                        height:1
                        color:"black"
                    }
                    MouseArea{
                        id:area_compo
                        anchors.fill:parent
                        onClicked: {
                            map.select_line = index;
                            print("select line = "+map.select_line);
                            list_line.currentIndex = index;
                            map.update_canvas_all();
                        }
                    }
                }
            }
            Component {
                id: travellineCompo
                Item {
                    width: 250; height: 30
                    Text {
                        anchors.centerIn: parent
                        text: name
                    }
                    Rectangle//리스트의 구분선
                    {
                        id:line
                        width:parent.width
                        anchors.bottom:parent.bottom//현재 객체의 아래 기준점을 부모객체의 아래로 잡아주어서 위치가 아래로가게 설정
                        height:1
                        color:"black"
                    }
                    MouseArea{
                        id:area_compo
                        anchors.fill:parent
                        onClicked: {
                            map.select_travel_line = index;
                            print("select travel line = "+map.select_travel_line);
                            list_travel_line.currentIndex = index;
                            updatelistline();
                            map.update_canvas_all();
                        }
                    }
                }
            }
            ListView{
                id: list_travel_line
                width: 250
                height: 100
                anchors.top: text_main_4.bottom
                anchors.topMargin: 30
                anchors.left: parent.left
                anchors.leftMargin: 30
                clip: true
                model: ListModel{}
                delegate: travellineCompo
                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                focus: true
            }

            ListView {
                id: list_line
                width: 250
                height: 200
                anchors.top: list_travel_line.bottom
                anchors.topMargin: 30
                anchors.left: parent.left
                anchors.leftMargin: 30
                clip: true
                model: ListModel{}
                delegate: lineCompo
                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                focus: true
            }

            Column{
                id: menubar_line
                anchors.verticalCenter: list_line.verticalCenter
                anchors.left: list_line.right
                anchors.leftMargin: 40
                spacing: 30
                Repeater{
                    model: ["add","remove"]
                    Rectangle{
                        id: btn5
                        width: 60
                        height: 60
                        color: {
                            if(map.tool == "ADD_LINE" && modelData == "add")
                                "blue"
                            else
                                "gray"
                        }
                        radius: 10
                        Image{
                            anchors.centerIn:  parent
                            antialiasing: true
                            mipmap: true
                            scale: {(height>width?parent.width/height:parent.width/width)*0.8}
                            source:{
                                if(modelData == "remove"){
                                    "icon/btn_no.png"
                                }else if(modelData == "add"){
                                    "icon/btn_yes.png"
                                }
                            }
                        }
                        Text{
                            anchors.centerIn: parent
                            text: modelData
                        }

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "remove"){
                                    supervisor.removeTline(0,list_line.currentIndex);
                                    map.update_canvas_all();
                                }else if(modelData == "add"){
                                    if(map.tool == "ADD_LINE"){
                                        if(map.new_line_point1 && map.new_line_point2){
                                            supervisor.addTline(0,canvas_travelline.x1,canvas_travelline.y1,canvas_travelline.x2,canvas_travelline.y2);
                                        }
                                        //cancel
                                        map.new_line_point1 = false;
                                        map.new_line_point2 = false;
                                        map.tool = "MOVE";

                                    }else{
                                        map.tool = "ADD_LINE";
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Rectangle{
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Previous"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        map.init_mode();
                        map.state_annotation = "LOCATION";
                        stackview_annot_menu.pop();
                    }
                }
            }
            Rectangle{
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Next"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        map.init_mode();
                        map.state_annotation = "SAVE";
                        stackview_annot_menu.push(menu_save);
                    }
                }
            }
        }
    }
    Item{
        id: menu_save
        objectName: "menu_save"
        width: parent.width
        height: parent.height
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            Text{
                id: text_main_5
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
                text: "Save"
            }
            //현재 어노테이션 상태 체크 화면

            //저장
            Rectangle{
                id: btn_save_meta
                width: 100
                height: 60
                anchors.top: text_main_5.bottom
                anchors.topMargin: 50
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 30
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Meta 저장"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        filesavemeta.open();
                    }
                }
            }
            Rectangle{
                id:btn_save_annot
                width: 100
                height: 60
                anchors.top: text_main_5.bottom
                anchors.topMargin: 50
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 30
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Annot 저장"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        filesaveannot.open();
                    }
                }
            }
            //서버에 전송
            Rectangle{
                width: 100
                height: 60
                anchors.top: btn_save_annot.bottom
                anchors.topMargin: 50
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "서버에 전송"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        supervisor.sendMaptoServer();
                    }
                }
            }

            //뒤로가기
            Rectangle{
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Previous"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        map.state_annotation = "TRAVELLINE";
                        stackview_annot_menu.pop();
                        map.update_canvas_all();
                    }
                }
            }
            Rectangle{
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Confirm"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        init();
                    }
                }
            }
        }
    }

    //Patrol Menu ITEM========================================================
    Item{
        id: menu_patrol_location
        objectName: "menu_patrol_location"
        width: stackview_patrol_menu.width
        height: stackview_patrol_menu.height
        visible: false
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
    Item{
        id: menu_patrol_record
        objectName: "menu_patrol_record"
        width: parent.width
        height: parent.height
        visible: false
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
    Item{
        id: menu_patrol_random
        objectName: "menu_patrol_random"
        width: parent.width
        height: parent.height
        visible: false
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
            text_patrol.text = "현재 설정 된 패트롤 파일이 없습니다.";
        }else{
            text_patrol.text = "현재 패트롤 파일 : "+supervisor.getPatrolFileName();
        }
//        print(supervisor.getPatrolNum());
        for(var i=0; i<supervisor.getPatrolNum(); i++){
//            print(supervisor.getPatrolType(i));
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
                joy_axis_left_ud = 0;
                joy_axis_right_rl = 0;
                joy_xy.remote_stop();
                joy_th.remote_stop();
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
                text:"왼쪽 리스트에서 사전 정의된 위치를 선택하거나 지도에서 직접 위치를 입력해주세요."
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
                delegate: locationCompo
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
//        visible: false
        width: 400
        height: 300
        anchors.centerIn: parent
        background: Rectangle{
            anchors.fill:parent
            color: "white"
        }

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Add Object"
            font.pixelSize: 20
            font.bold: true
        }
        TextField{
            id: textfield_name
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
            width: 200
            height: 60
            placeholderText: "(obj_name)"
            font.pointSize: 20
        }
        Rectangle{
            id: btn_add_object_confirm
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
                    if(textfield_name.text == ""){
                        textfield_name.color = "red";
                    }else{
                        supervisor.addObject(textfield_name.text);
                        map.update_canvas_all();
                        map.tool = "MOVE";
                        popup_add_object.close();
                    }
                }
            }
        }
        Rectangle{
            id: btn_add_object_cancel
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
//                    popup_add_object.visible = false;
                    popup_add_object.close();
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

    Popup{
        id: popup_add_location
//        visible: false
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
            id: textfield_name2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
            width: 200
            height: 60
            placeholderText: "(loc_name)"
            font.pointSize: 20
        }
        Rectangle{
            id: btn_add_loc_confirm
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
                    if(textfield_name2.text == ""){
                        textfield_name2.color = "red";
                    }else{
                        supervisor.addLocation(textfield_name2.text, canvas_location.new_loc_x, canvas_location.new_loc_y, canvas_location.new_loc_th);

                        map.tool = "MOVE";
                        canvas_location.isnewLoc = false;
                        canvas_location.new_loc_x = 0;
                        canvas_location.new_loc_y = 0;
                        canvas_location.new_loc_th = 0;
                        canvas_location.new_loc_available = false;
                        popup_add_location.close();
                        map.update_canvas_all();
                    }
                }
            }
        }
        Rectangle{
            id: btn_add_loc_cancel
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
                    popup_add_location.close();
                }
            }
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
                        supervisor.addTline(textfield_name3.text, canvas_travelline.x1, canvas_travelline.y1, canvas_travelline.x2, canvas_travelline.y2);
                        map.isnewline = false;
                        canvas_travelline.x1 = 0;
                        canvas_travelline.x2 = 0;
                        canvas_travelline.y1 = 0;
                        canvas_travelline.y2 = 0;
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
        map_current.loadmap_mini();

        updatemap();
        map.update_canvas_all();
    }

    function init(){
        while(stackview_menu.currentItem.objectName != "menu_main"){
            print(stackview_menu.currentItem.objectName);
            stackview_menu.pop();
        }
        while(stackview_annot_menu.currentItem.objectName != "menu_init"){
            print(stackview_annot_menu.currentItem.objectName);
            stackview_annot_menu.pop();
        }
        while(stackview_menu.currentItem.objectName != "menu_main"){
            print(stackview_menu.currentItem.objectName);
            stackview_menu.pop();
        }
        map.init();
        map_mode = 0;
        timer_get_joy.start();
        map.state_annotation = "NONE";
        ani_modechange_return.start();
    }

    function updateobject(){
        var ob_num = supervisor.getObjectNum();
        list_object.model.clear();
        for(var i=0; i<ob_num; i++){
            list_object.model.append({"name":supervisor.getObjectName(i)});
        }
        list_object.currentIndex = ob_num-1;
    }
    function updatelocation(){
        var loc_num = supervisor.getLocationNum();
        list_location.model.clear();
        list_location2.model.clear();
        for(var i=0; i<loc_num; i++){
            list_location.model.append({"name":supervisor.getLocationTypes(i),"iscol":false});
            list_location2.model.append({"name":supervisor.getLocationTypes(i),"iscol":false});
        }
        list_location.currentIndex = loc_num-1;
        list_location2.currentIndex = 0;
    }
    function updatetravelline(){
        var travel_num = supervisor.getTlineSize();
        list_travel_line.model.clear();
        for(var i=0; i<travel_num; i++){
            list_travel_line.model.append({"name":supervisor.getTlineName(i)});
        }

        var line_num = supervisor.getTlineSize(map.select_travel_line);
        print(line_num);
        list_line.model.clear();
        for(i=0; i<line_num; i=i+2){
            list_line.model.append({"name":"line_" + Number(i/2)});
        }
        list_line.currentIndex = line_num-1;
    }
    function updatelistline(){
        var line_num = supervisor.getTlineSize(map.select_travel_line);
        print(line_num);
        list_line.model.clear();
        for(var i=0; i<line_num; i=i+2){
            list_line.model.append({"name":"line_" + Number(i/2)});
        }
    }

}
