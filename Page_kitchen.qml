import QtQuick 2.12
import QtQuick.Controls 2.12
import "."
import QtGraphicalEffects 1.0
import io.qt.Supervisor 1.0
import QtMultimedia 5.12

Item {
    id: page_kitchen
    objectName: "page_kitchen"
    width: 1280
    height: 800

    property var view_mode: 0
    Component.onCompleted: {
        init();
    }
    property bool show_serving: true


    function init(){
        statusbar.visible = true;

        cur_table = -1;
        cur_group = 0;
        cur_page = 0;
        cur_preset = parseInt(supervisor.getSetting("ROBOT_SW","cur_preset"));

        view_mode = 1;
        group_num = supervisor.getLocationGroupNum();
        robot_type = supervisor.getSetting("ROBOT_HW","type");
        table_num = 0;
        tray_num = supervisor.getSetting("ROBOT_HW","tray_num");

        if(robot_type == "CALLING"){
            show_serving = false;
        }else{
            show_serving = true;
        }

        print("set ui state ?????????????????????")
        supervisor.setUiState(0);

        use_tray = JSON.parse(supervisor.getSetting("ROBOT_SW","use_tray"));
        if(use_tray){
            col_num = parseInt(supervisor.getSetting("FLOOR","table_col_num"));
            row_num = parseInt(supervisor.getSetting("FLOOR","table_row_num"));
        }else{
            col_num = parseInt(supervisor.getSetting("FLOOR","group_col_num"));
            row_num = parseInt(supervisor.getSetting("FLOOR","group_row_num"));
        }

        if(view_mode == 0){
            max_col = 8
            max_row = 4
        }else{
            max_col = 5
            max_row = 4
        }

        traymodel.clear();
        for(var i=0; i<tray_num; i++){
            traymodel.append({x:0,y:0,tray_num:i+1,set_table:0,color:"white"});
        }

        update_group();

        if(supervisor.isCallingMode() || supervisor.getCallQueueSize() > 0){
            print("!!!!!!",supervisor.isCallingMode(),supervisor.getCallQueueSize())
            popup_clean_calling.cleaninglocation = false;
            popup_clean_calling.open();
        }

        if(supervisor.getSetting("ROBOT_SW","resting_lock")==="true"){
            supervisor.setMotorLock(false);
        }else{
            supervisor.setMotorLock(true);
        }
    }

    function cleaning(){
        popup_clean_calling.cleaninglocation = true;
        popup_clean_calling.open();
    }

    property int tray_num: 3
    property int table_num: 5
    property int group_num: 1
    property int row_num: 5
    property int col_num: 1

    property int max_row: 5
    property int max_col: 5

    property bool is_con_robot: false
    property bool is_motor_power: false
    property bool is_emergency: false

    property bool use_tray: false

    property int tray_width: 400
    property int tray_height: 80
    property int spacing_tray : 10
    property int rect_size: 70
    property int traybox_margin: 150

    property int cur_table: -1
    property int cur_group: 0
    property int cur_page: 0

    property bool go_wait: false
    property bool go_charge: false
    property bool go_patrol: false
    property bool calling_mode: false

    property var cur_preset: 3
    onCur_groupChanged: {
        cur_table = -1;
        update_group();
    }

    Rectangle{
        anchors.fill : parent
        color: "#f4f4f4"
    }

    ListModel{
        id: traymodel
        ListElement{
            x: 0
            y: 0
            tray_num: 1
            set_table: 0
            color: "white"
        }
    }

    ListModel{
        id: patrolmodel
    }

    Timer{
        id: timer_update
        interval : 500
        running: true
        repeat: true
        onTriggered: {
            is_con_robot = true;//supervisor.getIPCConnection();
            is_emergency = supervisor.getEmoStatus();
            is_motor_power = true;//supervisor.getPowerStatus();

//            if(is_con_robot){
//                if(is_motor_power){
//                    if(is_emergency){
//                        btn_go.active = false;
//                        btn_charge.active = false;
//                        btn_resting.active = false;
//                        rect_go.color = color_red;
//                        text_go.color = color_dark_gray;
//                        text_go.text = qsTr("비상스위치가 눌려있음")
//                        text_go.font.pixelSize = 25
//                        popup_notice.main_str = qsTr("비상스위치가 눌려있습니다")
//                        popup_notice.sub_str = qsTr("비상스위치를 풀어주세요")
//                        popup_notice.show_localization = false
//                        popup_notice.show_motorinit = false;
//                        popup_notice.show_restart = false;
//                    }else if(supervisor.getMotorState() === 0){
//                        btn_go.active = false;
//                        btn_charge.active = false;
//                        btn_resting.active = false;
//                        rect_go.color = color_red;
//                        text_go.color = color_dark_gray;
//                        text_go.text = qsTr("모터 초기화필요")
//                        text_go.font.pixelSize = 25
//                        if(supervisor.getMotorStatus(0) === 0 || supervisor.getMotorStatus(1) === 0){
//                            popup_notice.main_str = qsTr("모터 초기화가 되지 않았습니다.")
//                            popup_notice.sub_str = qsTr("모터 초기화를 해주세요")
//                        }else{
//                            popup_notice.main_str = qsTr("모터에 에러가 발생했습니다")
//                            popup_notice.sub_str = qsTr("모터 초기화를 해주세요")
//                        }
//                        popup_notice.show_motorinit = true;
//                        popup_notice.show_localization = false;
//                        popup_notice.show_restart = false;

//                    }else if(supervisor.getLocalizationState() === 2){
//                        btn_go.active = true;
//                        btn_charge.active = true;
//                        btn_resting.active = true;
//                        rect_go.color = color_blue;

//                        text_go.color = "white";
//                        text_go.text = qsTr("서빙 시작")
//                        text_go.font.pixelSize = 35
//                        popup_notice.main_str = ""
//                        popup_notice.sub_str = ""
//                        popup_notice.show_localization = false
//                        popup_notice.show_motorinit = false;
//                        popup_notice.show_restart = false;
//                    }else{
//                        btn_go.active = false;
//                        btn_charge.active = false;
//                        btn_resting.active = false;
//                        rect_go.color = color_red;
//                        text_go.color = color_dark_gray;
//                        text_go.text = qsTr("위치 초기화필요")
//                        text_go.font.pixelSize = 30
//                        popup_notice.main_str = qsTr("위치를 찾을 수 없습니다")
//                        popup_notice.sub_str = qsTr("위치 초기화를 다시 해주세요")
//                        popup_notice.show_localization = true;
//                        popup_notice.show_motorinit = false;
//                        popup_notice.show_restart = false;
//                    }
//                }else{
//                    btn_go.active = false;
//                    btn_charge.active = false;
//                    btn_resting.active = false;
//                    rect_go.color = color_gray;
//                    text_go.color = color_dark_gray;
//                    text_go.text = qsTr("로봇 전원 안켜짐")
//                    text_go.font.pixelSize = 35
//                    popup_notice.main_str = qsTr("로봇 전원이 꺼져있습니다")
//                    popup_notice.sub_str = ""
//                    popup_notice.show_localization = false
//                    popup_notice.show_motorinit = false;
//                    popup_notice.show_restart = true;
//                }
//            }else{
//                btn_go.active = false;
//                btn_charge.active = false;
//                btn_resting.active = false;
//                rect_go.color = color_gray;
//                text_go.color = color_dark_gray;
//                text_go.text = qsTr("로봇 연결 안됨")
//                text_go.font.pixelSize = 35
//                popup_notice.main_str = qsTr("로봇이 연결되지 않았습니다")
//                popup_notice.sub_str = qsTr("프로그램을 재시작 해주세요")
//                popup_notice.show_localization = false;
//                popup_notice.show_motorinit = false;
//                popup_notice.show_restart = true;
//            }



        }
    }

    function update_group(){
        model_group.clear();
        for(var i=0; i<supervisor.getLocationGroupNum(); i++){
            if(supervisor.getLocationGroupSize(i) > 0){
                if(supervisor.getLocGroupname(i) === "DEFAULT" || supervisor.getLocGroupname(i) === "Default"){
                    model_group.append({"num":i,"name":"그룹"});
                }else{

                    model_group.append({"num":i,"name":supervisor.getLocGroupname(i)});
                }

            }
        }
        if(model_group.count > 0)
            table_num = supervisor.getLocationGroupSize(model_group.get(cur_group).num);
        else
            table_num = 0;
        update_table();
    }
    function update_table(){
        model_group_table.clear();
        for(var i=col_num*row_num*cur_page; i<col_num*row_num*(cur_page+1); i++){
//            print(i);
            if(i>=table_num)
                break;
//            print("update table : ",i,supervisor.getLocationAvailable(supervisor.getLocationNumber(model_group.get(cur_group).num,i)))

            model_group_table.append({"num":i,"available":true,"name":supervisor.getServingName(model_group.get(cur_group).num, i)});
            }
    }

    Image{
        id: image_head
        visible: (!show_serving || use_tray)?true:false
        anchors.horizontalCenter: show_serving?rect_tray_box.horizontalCenter:rect_calling_box.horizontalCenter
        anchors.bottom: rect_tray_box.top
        anchors.bottomMargin: 10

        width: 90*1.5
        height: 50*1.5
        source:"image/robot_head.png"
    }

    Rectangle{
        id: rect_tray_box
        visible: (show_serving && use_tray)?true:false
        width: 500
        height: tray_num*tray_height + (tray_num - 1)*spacing_tray + 50
        color: "#e8e8e8"
        radius: 30
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: rect_table_box.right
        anchors.leftMargin: (rect_menu_box.x-rect_table_box.width - width)/2
        Column{
            id: column_tray
            anchors.centerIn: parent
            spacing: 20
            Repeater{
                id: repeat_tray
                model: traymodel
                Rectangle{
                    id: rect_tray
                    width: tray_width
                    height: tray_height
                    color: "transparent"
                    radius:50
                    border.color: "#d0d0d0"
                    border.width: 1
                    onYChanged: {
                        model.y = y;
                    }

                    SequentialAnimation{
                        id: ani_tray
                        running: false
                        ParallelAnimation{
                            NumberAnimation{target:rect_tray_fill; property:"scale"; from:1;to:1.2;duration:300;}
                            NumberAnimation{target:rect_tray_fill; property:"scale"; from:1.2;to:1;duration:300;}
                        }
                    }
                    Rectangle{
                        id: rect_tray_fill
                        width: tray_width
                        height: tray_height
                        radius:50
                        color: model.color
                        border.color: model.color
                        border.width: 1
                        onColorChanged: {
                            if(color != "#0000ff"){
                                ani_tray.start()
                            }
                        }
                    }
                    Text{
                        id: text_cancel
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        color: "#525252"
                        visible: false
                        text:"cancel"
                    }
                    MouseArea{
                        id: tray_mousearea
                        anchors.fill: parent
                        property var firstX;
                        property var width_dis: 0
                        onPressed: {
                            click_sound.play();
                            firstX = mouseX;
                            width_dis = 0;
                        }
                        onReleased: {
                            if(width_dis > 50){
                                model.set_table = 0;
                                model.color =  "white"
                                cur_table = -1;
                            }else{
                                if(cur_table != 0){
                                    model.set_table = cur_table;
                                    model.color =  "#12d27c"
                                }

                            }
                            rect_tray_fill.width = rect_tray.width;
                            text_cancel.visible = false;
                            width_dis = 0;
                        }
                        onPositionChanged: {
                            count_resting = 0;
                            width_dis = firstX-mouseX;

                            if(width_dis < 0)
                                width_dis = 0;

                            if(model.set_table !== 0){
                                if(width_dis > 50){
                                    text_cancel.visible = true;
                                }else{
                                    text_cancel.visible = false;
                                }
                                rect_tray_fill.width = rect_tray.width - width_dis
                            }

                        }
                    }
                    Text{
                        id: textTray
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: (model.set_table===0)?25:30
                        font.bold: (model.set_table===0)?false:true
                        color: (model.set_table===0)?"#d0d0d0":"white"
                        text: (model.set_table===0)?"Tray "+Number(model.tray_num):Number(model.set_table)
                    }
                }
            }
        }
    }

    Rectangle{
        id: rect_table_box
        visible: (show_serving && use_tray)?true:false
        width: {
            if(col_num > 2){
               300 - 20 + 160
           }else{
               (col_num)*100 - 20 + 160
           }
        }
        height: parent.height - statusbar.height
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: statusbar.height
        color: "#282828"
        Text{
            id: text_tables
            color:"white"
            font.bold: true
            font.family: font_noto_b.name
            text: qsTr("테이블 번호")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 40
            font.pixelSize: 30
        }
        SwipeView{
            id: swipeview_tables
            width: parent.width
            currentIndex: 0
            clip: true
            anchors.top: text_tables.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            Repeater{
                id: page_table
                model: Math.ceil((table_num/(col_num*row_num)))

                onModelChanged: {
                    swipeview_tables.currentIndex = 0;
                }
                Item{
                    property int cur_page: index
                    Grid{
                        rows: row_num
                        columns: table_num-(col_num*row_num*(cur_page+1))>0?col_num:((table_num-(col_num*row_num*cur_page))/row_num + 1).toFixed(0)
                        spacing: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        flow: Grid.TopToBottom
                        Repeater{
                            id: column_table
                            model: table_num-(col_num*row_num*cur_page)>(col_num*row_num)?col_num*row_num:table_num-(col_num*row_num*cur_page)
                            Rectangle{
                                id: rect_table
                                width:80
                                height:80
                                radius:80
                                enabled:supervisor.getLocationAvailable((col_num*row_num*cur_page)+index);
                                color: ((col_num*row_num*cur_page)+index+1 == cur_table)?"#12d27c":"#d0d0d0"
                                Rectangle{
                                    width:68
                                    height:68
                                    radius:68
                                    color: "#f4f4f4"
                                    anchors.centerIn: parent
                                    Text{
                                        anchors.centerIn: parent
                                        text: (col_num*row_num*cur_page)+index+1
                                        color:"#525252"
                                        font.family: font_noto_r.name
                                        font.pixelSize: 25
                                    }
                                }
                                MouseArea{
                                    anchors.fill:parent
                                    onClicked: {
                                        click_sound.play();
                                        count_resting = 0;
                                        if(cur_table == (col_num*row_num*cur_page)+index+1){
                                            cur_table = -1;
                                        }else{
                                            if(supervisor.isExistLocation(-1,(col_num*row_num*cur_page)+index)){
                                                cur_table = (col_num*row_num*cur_page)+index+1;
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
        PageIndicator{
            id: indicator_tables1
            count: swipeview_tables.count
            currentIndex: swipeview_tables.currentIndex
            anchors.bottom: swipeview_tables.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            delegate: Rectangle{
                implicitWidth: 15
                implicitHeight: 15
                radius: width
                color: index===swipeview_tables.currentIndex?"#12d27c":"#525252"
                Behavior on color{
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
        }
        Rectangle{
            id: btn_lock
            color: "transparent"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            width: 50
            radius: 50
            height: 50
            visible: table_num>row_num?true:false
            Image{
                anchors.fill: parent
                source: "icon/btn_lock.png"
            }
            MouseArea{
                anchors.fill: parent
                onPressAndHold: {
                    click_sound.play();
                    count_resting = 0;
                    supervisor.writelog("[USER INPUT] TABLE NUM CHANGED DONE : "+Number(col_num));
                    btn_lock.visible = false;
                    btns_table.visible = true;
                }
            }
        }
        Row{
            id: btns_table
            visible: false
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            Rectangle{
                id: btn_minus
                color: "#282828"
                width: 40
                height: 40
                radius: 40
                enabled: table_num>row_num?true:false
                border.color: "#e8e8e8"
                border.width: 1
                Text{
                    anchors.centerIn: parent
                    text:"-"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: font_noto_b.name
                    font.pixelSize: 40
                    color: "#e8e8e8"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        click_sound.play();
                        count_resting = 0;
                        if(col_num > 1)
                            supervisor.setTableColNum(--col_num);
                    }
                }
            }
            Rectangle{
                id: btn_plus
                color: "#282828"
                width: 40
                height: 40
                radius: 40
                enabled: table_num>col_num*row_num?true:false
                border.color: "#e8e8e8"
                border.width: 1
                Text{
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text:"+"
                    font.family: font_noto_b.name
                    font.pixelSize: 40
                    color: "#e8e8e8"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        click_sound.play();
                        count_resting = 0;
                        if(col_num < max_col)
                            supervisor.setTableColNum(++col_num);
                    }
                }
            }
            Rectangle{
                id: btn_confirm_tables
                color: "#282828"
                width: 40
                height: 40
                radius: 40
                border.color: "#e8e8e8"
                border.width: 1
                Image{
                    anchors.fill: parent
                    source: "icon/btn_yes.png"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        click_sound.play();
                        count_resting = 0;
                        supervisor.writelog("[USER INPUT] TABLE NUM CHANGED");
                        btn_lock.visible = true;
                        btns_table.visible = false;
                    }
                }
            }

        }

    }

    Rectangle{
        id: rect_table_group
        width: 1280;// - 150 - rect_menu_box.width
        height: 580
        anchors.top: parent.top
        anchors.topMargin: statusbar.height;// (parent.height - statusbar.height - height - rect_go.height)/2
        anchors.left: parent.left
//        anchors.leftMargin: 50
        color: color_dark_navy
        visible: show_serving && !use_tray
        ListModel{
            id: model_group
        }
        ListModel{
            id: model_group_table
        }
        Component{
            id: tableNumCompo
            Rectangle{
                id: rect_table_groups
                width:80
                height:80
                radius:80
                color: (num == cur_table)?"#12d27c":"#d0d0d0"
                Rectangle{
                    width:68
                    height:68
                    radius:68
                    color: "#f4f4f4"
                    anchors.centerIn: parent
                    Text{
                        anchors.centerIn: parent
                        text: num
                        color: "#525252"
                        font.family: font_noto_r.name
                        font.pixelSize: 25
                    }
                }
                MouseArea{
                    anchors.fill:parent
                    onClicked: {
                        click_sound.play();
                        count_resting = 0;
                        if(cur_table == num)
                            cur_table = -1;
                        else
                            cur_table = num;
                    }
                }
            }

        }
        Component{
            id: tableNameCompo
            Rectangle{
                id: rect_table_groups
                width:153
                height:82
                radius:15
                color: color_navy
                enabled:available
                Rectangle{
                    width:153
                    height:75
                    radius:10
                    color: (num == cur_table)?color_green:color_light_gray
                    Text{
                        anchors.centerIn: parent
                        text: name
                        color: available?num==cur_table?"white":"#525252":color_red
                        font.family: font_noto_r.name
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 115){
                                scale=scale-0.01;
                            }
                        }
                        font.pixelSize: 25
                    }
                }
                MouseArea{
                    anchors.fill:parent
                    onClicked: {
                        click_sound.play();
                        count_resting = 0;
                        cur_table = num;
                    }
                }
            }
        }

        Rectangle{
            id: rect_group
            width: 1280 - 150 - rect_menu_box.width
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 50
            color: "transparent"
            Column{
                Rectangle{
                    id: rect_group_category
                    width: rect_group.width
                    height: 70
                    color: "transparent"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle{
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: 3
                        radius: 3
                        color: color_dark_gray
                    }
                    Row{
                        spacing: 5
                        Repeater{
                            model: model_group
                            Rectangle{
                                width: 150
                                height: 70
                                color: "transparent"
                                DropShadow{
                                    anchors.fill: textt
                                    source: textt
                                    visible: cur_group==index
                                    radius: 3
                                    color: color_more_gray
                                }
                                Text{
                                    id: textt
                                    anchors.centerIn: parent
                                    font.family: font_noto_b.name
                                    font.pixelSize: 30
                                    text: name
                                    color: cur_group==index?color_green:color_dark_gray
                                }
                                Rectangle{
                                    anchors.bottom: parent.bottom
                                    width: parent.width*0.9
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    radius: 2
                                    height: 3
                                    color: cur_group==index?color_green:"transparent"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        click_sound.play();
                                        cur_group = index;
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    width: rect_group.width
                    radius: 10
                    clip: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: rect_group.height - rect_group_category.height
                    color: color_dark_navy
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        spacing: 15
                        Repeater{
                            model:model_group
                            Rectangle{
                                width: 140
                                height: 30
                                color: color_dark_navy
                                opacity: cur_group === index?1:0
                            }
                        }
                    }
                    SwipeView{
                        id: swipeview_group
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        width: parent.width*0.9
                        height: parent.height*0.96
                        currentIndex: 0
                        clip: true
                        onCurrentIndexChanged: {
                            if(currentIndex > -1)
                                cur_page = currentIndex;
                            update_table();
                        }
                        Repeater{
                            id: page_group
                            model: Math.ceil((table_num/(col_num*row_num)))
                            Item{
                                Grid{
                                    rows: row_num
                                    columns: col_num//table_num-(col_num*row_num*(cur_page+1))>0?col_num:((table_num-(col_num*row_num*cur_page))/row_num + 1).toFixed(0)
                                    spacing: 20
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    Repeater{
                                        id: column_table_group
                                        delegate: {
                                            if(view_mode === 1){
                                                tableNameCompo
                                            }else{
                                                tableNumCompo
                                            }
                                        }
                                        model: model_group_table
                                    }

                                }
                            }
                        }
                    }
                    PageIndicator{
                        id: indicator_tables_group
                        count: swipeview_group.count
                        currentIndex: swipeview_group.currentIndex
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        delegate: Rectangle{
                            implicitWidth: 15
                            implicitHeight: 15
                            radius: width
                            color: index===swipeview_group.currentIndex?"#12d27c":"#525252"
                            Behavior on color{
                                ColorAnimation {
                                    duration: 200
                                }
                            }
                        }
                    }
                    Rectangle{
                        id: btn_lock_group
                        color: "transparent"
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 20
                        anchors.right: parent.right
                        width: 50
                        radius: 50
                        height: 50
                        visible: true;//group_num>row_num?true:false
                        Image{
                            anchors.fill: parent
                            source: "icon/btn_lock.png"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onPressAndHold: {
                                click_sound.play();
                                count_resting = 0;
                                supervisor.writelog("[USER INPUT] TABLE NUM CHANGED DONE : "+Number(col_num));
                                btn_lock_group.visible = false;
                                btns_table_group.visible = true;
                            }
                        }
                    }
                    Row{
                        id: btns_table_group
                        visible: false
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.right: parent.right
                        spacing: 10
                        Grid{
                            rows: 2
                            columns: 4
                            horizontalItemAlignment: Grid.AlignHCenter
                            verticalItemAlignment: Grid.AlignVCenter
                            spacing: 5
                            Text{
                                font.family: font_noto_r.name
                                font.pixelSize: 15
                                color: "white"
                                text: "가로줄개수"
                            }
                            Text{
                                font.family: font_noto_r.name
                                font.pixelSize: 15
                                color: "white"
                                text: ":"
                            }
                            Rectangle{
                                width: 30
                                height: 30
                                radius: 30
                                enabled: row_num > 1
                                color: enabled?color_dark_black:color_dark_gray
                                border.color: "#e8e8e8"
                                border.width: 1

                                Rectangle{
                                    width: 14
                                    radius: 2
                                    height: 2
                                    anchors.centerIn: parent
                                    color: color_mid_gray
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        click_sound.play();
                                        count_resting = 0;
                                        supervisor.setSetting("FLOOR/group_row_num",row_num-1);
                                        row_num--;
                                        update_table();
                                    }
                                }
                            }
                            Rectangle{
                                width: 30
                                height: 30
                                radius: 30
                                enabled: row_num < max_row
                                color: enabled?color_dark_black:color_dark_gray
                                border.color: "#e8e8e8"
                                border.width: 1
                                Rectangle{
                                    width: 2
                                    radius: 2
                                    height: 14
                                    anchors.centerIn: parent
                                    color: color_mid_gray
                                }
                                Rectangle{
                                    width: 14
                                    radius: 2
                                    height: 2
                                    anchors.centerIn: parent
                                    color: color_mid_gray
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        click_sound.play();
                                        count_resting = 0;
                                        supervisor.setSetting("FLOOR/group_row_num",row_num+1);
                                        row_num++;
                                        update_table();
                                    }
                                }
                            }

                            Text{
                                font.family: font_noto_r.name
                                font.pixelSize: 15
                                color: "white"
                                text: "세로열개수"
                            }
                            Text{
                                font.family: font_noto_r.name
                                font.pixelSize: 15
                                color: "white"
                                text: ":"
                            }
                            Rectangle{
                                width: 30
                                height: 30
                                radius: 30
                                enabled: col_num > 1
                                color: enabled?color_dark_black:color_dark_gray
                                border.color: "#e8e8e8"
                                border.width: 1

                                Rectangle{
                                    width: 14
                                    radius: 2
                                    height: 2
                                    anchors.centerIn: parent
                                    color: color_mid_gray
                                }

                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        click_sound.play();
                                        count_resting = 0;
                                        supervisor.setSetting("FLOOR/group_col_num",col_num-1);
                                        col_num--;
                                        update_table();
                                    }
                                }
                            }
                            Rectangle{
                                width: 30
                                height: 30
                                radius: 30
                                enabled: col_num < max_col
                                color: enabled?color_dark_black:color_dark_gray
                                border.color: "#e8e8e8"
                                border.width: 1
                                Rectangle{
                                    width: 2
                                    radius: 2
                                    height: 14
                                    anchors.centerIn: parent
                                    color: color_mid_gray
                                }
                                Rectangle{
                                    width: 14
                                    radius: 2
                                    height: 2
                                    anchors.centerIn: parent
                                    color: color_mid_gray
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        click_sound.play();
                                        count_resting = 0;
                                        supervisor.setSetting("FLOOR/group_col_num",col_num+1);
                                        col_num++;
                                        update_table();
                                    }
                                }
                            }
                        }

                        Rectangle{
                            id: btn_confirm_tables_group
                            color: "#282828"
                            width: 40
                            height: 40
                            radius: 40
                            anchors.verticalCenter: parent.verticalCenter
                            border.color: "#e8e8e8"
                            border.width: 1
                            Image{
                                anchors.fill: parent
                                source: "icon/btn_yes.png"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    click_sound.play();
                                    count_resting = 0;
                                    supervisor.writelog("[USER INPUT] TABLE NUM CHANGED");
                                    btn_lock_group.visible = true;
                                    btns_table_group.visible = false;
                                }
                            }
                        }

                    }
                }

            }

        }
    }
    Rectangle{
        id: rect_go
        width: 300
        visible: show_serving?true:false
        height: 120
        radius: 100
        anchors.horizontalCenter: {
            if(use_tray){
                rect_tray_box.horizontalCenter
            }else{
                rect_table_group.horizontalCenter
            }
        }
        anchors.top: {
            if(use_tray){
                rect_tray_box.bottom
            }else{
                rect_table_group.bottom
            }
        }
        anchors.topMargin: {
            if(use_tray)
                40
            else
                20
        }

        color: "#24a9f7"
        Text{
            id: text_go
            anchors.centerIn: parent
            text: qsTr("서빙 시작")
            font.family: font_noto_r.name
            font.pixelSize: 35
            font.bold: true
            color: "white"
        }
        MouseArea{
            id: btn_go
            property bool active: true
            property bool hold: false
            anchors.fill: parent
            onPressed:{
                if(active){
                    hold = false;
                    if(cur_table==-1){
                        click_sound_no.play();
                        count_resting = 0;
                    }else{
                        start_sound.play();
                        count_resting = 0;
                    }
                }else{
                    click_sound_no.play();
                    count_resting = 0;
                    cur_table = -1;
                }
            }
            onPressAndHold: {
                if(active){
                    print("hold");
                    hold = true;
                    popup_preset_menu.open();
                }
            }

            onReleased:{
                if(active){
                    if(!hold){
                        if(cur_table>-1){
                            supervisor.setMotorLock(true);
                            if(supervisor.getSetting("ROBOT_SW","use_tray") === "true"){
                                for(var i=0; i<tray_num; i++){
                                    supervisor.setTray(i,traymodel.get(i).set_table);
                                }
                                supervisor.startServing();
                            }else{
                                supervisor.goServing(model_group.get(cur_group).num,cur_table);
                            }
                            cur_table = -1;
                        }

                    }

                }else{
                    popup_notice.open();
                }
            }
        }

        Popup{
            id: popup_preset_menu
            width: 600
            height: 120
            leftPadding: 0
            rightPadding: 0
            topPadding: 0
            bottomPadding: 0
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }
            onOpened: {
                ani_open.start();
            }
            ParallelAnimation{
                id: ani_open
                onStarted: {
                    row_preset.opacity = 0;
                }

                SequentialAnimation{
                    ParallelAnimation{
                        NumberAnimation{
                            target: rect_preset
                            duration: 300
                            to: popup_preset_menu.width
                            from: 300
                            property: "width"
                        }
                        NumberAnimation{
                            target: rect_preset
                            duration: 300
                            to: -150
                            from: 0
                            property: "x"
                        }
                    }

                    NumberAnimation{
                        target: row_preset
                        duration: 50
                        to: 1
                        from: 0
                        property: "opacity"
                    }
                }
            }
            Rectangle{
                id: rect_preset
                width: parent.width
                height: parent.height
                radius: 100
                color: color_blue
                Row{
                    id: row_preset
                    opacity: 0
                    anchors.centerIn: parent
                    spacing: 15
                    Text{
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 25
                        color: "white"
                        text: "속도설정"
                    }
                    Rectangle{
                        width: 1
                        height: 70
                        color: color_mid_gray
                    }
                    Rectangle{
                        width: 60
                        height: 60
                        anchors.verticalCenter: parent.verticalCenter
                        color: "transparent"
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            font.pixelSize: 50
                            color: cur_preset===1?"white":color_dark_gray
                            text: "1"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                click_sound.play();
                                cur_preset = 1;
                                supervisor.setPreset(cur_preset);
                            }
                        }
                    }
                    Rectangle{
                        width: 1
                        height: 70
                        color: color_mid_gray
                    }
                    Rectangle{
                        width: 60
                        height: 60
                        anchors.verticalCenter: parent.verticalCenter
                        color: "transparent"
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            font.pixelSize: 50
                            color: cur_preset===2?"white":color_dark_gray
                            text: "2"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                click_sound.play();
                                cur_preset = 2;
                                supervisor.setPreset(cur_preset);
                            }
                        }
                    }
                    Rectangle{
                        width: 1
                        height: 70
                        color: color_mid_gray
                    }
                    Rectangle{
                        width: 60
                        height: 60
                        anchors.verticalCenter: parent.verticalCenter
                        color: "transparent"
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            font.pixelSize: 50
                            color: cur_preset===3?"white":color_dark_gray
                            text: "3"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                click_sound.play();
                                cur_preset = 3;
                                supervisor.setPreset(cur_preset);
                            }
                        }
                    }
                    Rectangle{
                        width: 1
                        height: 70
                        color: color_mid_gray
                    }
                    Rectangle{
                        width: 60
                        height: 60
                        anchors.verticalCenter: parent.verticalCenter
                        color: "transparent"
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            font.pixelSize: 50
                            color: cur_preset===4?"white":color_dark_gray
                            text: "4"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                click_sound.play();
                                cur_preset = 4;
                                supervisor.setPreset(cur_preset);
                            }
                        }
                    }
                    Rectangle{
                        width: 1
                        height: 70
                        color: color_mid_gray
                    }
                    Rectangle{
                        width: 60
                        height: 60
                        anchors.verticalCenter: parent.verticalCenter
                        color: "transparent"
                        Text{
                            anchors.centerIn: parent
                            font.family: font_noto_r.name
                            font.pixelSize: 50
                            color: cur_preset===5?"white":color_dark_gray
                            text: "5"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                click_sound.play();
                                cur_preset = 5;
                                supervisor.setPreset(cur_preset);
                            }
                        }
                    }
                }
            }
        }

    }
    Rectangle{
        id: rect_patrol_box
        visible: false
        width: (table_num/row_num).toFixed(0)*100 - 20 + 160
        height: parent.height - statusbar.height
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: statusbar.height
        color: "#282828"
        Text{
            id: text_patrol
            color:"white"
            font.bold: true
            font.family: font_noto_b.name
            text: qsTr("로봇 이동경로")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 40
            font.pixelSize: 30
        }

        Flickable{
            width: 180
            height: parent.height - y - 100
            contentHeight: column_patrol.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: text_patrol.bottom
            anchors.topMargin: 50
            clip: true
            Column{
                id: column_patrol
                anchors.centerIn: parent
                Repeater{
                    id: repeat_patrol
                    model: patrolmodel
                    Rectangle{
                        width: 179
                        height: 44
                        color: "transparent"
                        Rectangle{
                            enabled: patrolmodel.get(index).type===2?false:true
                            visible:patrolmodel.get(index).type===2?false:true
                            anchors.fill: parent
                            color:{
                                if(patrolmodel.get(index).type == 0){
                                    "#282828"
                                }else{
                                    "#d0d0d0"
                                }
                            }
                            radius: 10
                            border.width: 4
                            border.color: "#d0d0d0"
                            Text{
                                anchors.centerIn: parent
                                color:patrolmodel.get(index).type===0?"#d0d0d0":"#282828"
                                text:patrolmodel.get(index).name
                                font.family: font_noto_r.name
                                font.pixelSize: 20
                            }
                        }
                        Image{
                            visible:patrolmodel.get(index).type===2?true:false
                            anchors.centerIn: parent
                            width: 22
                            height: 13
                            source: "icon/patrol_down.png"
                        }
                    }
                }
            }

        }

    }
    Rectangle{
        id: rect_calling_box
        visible: !show_serving?true:false
        width: 500
        height: tray_num*tray_height + (tray_num - 1)*spacing_tray + 50
        color: "#e8e8e8"
        radius: 30
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.left: rect_table_box.right
//        anchors.leftMargin: traybox_margin
        Text{
            color:"white"
            font.bold: true
            font.family: font_noto_b.name
            text: qsTr("호출 대기 중")
            anchors.centerIn: parent
            font.pixelSize: 50
        }
    }
    Rectangle{
        id: rect_go_patrol
        width: 300
        visible: !show_serving?true:false
        height: 100
        radius: 100
        anchors.horizontalCenter: rect_calling_box.horizontalCenter
        anchors.top: rect_calling_box.bottom
        anchors.topMargin: 40
        color: "#24a9f7"
        Text{
            id: text_go2
            anchors.centerIn: parent
            text: qsTr("순회 시작")
            font.family: font_noto_r.name
            font.pixelSize: 35
            font.bold: true
            color: "white"
        }
        MouseArea{
            id: btn_go2
            anchors.fill: parent
            onClicked: {
                start_sound.play();
                popup_patrol_list.open();
//                count_resting = 0;
                go_patrol = true;
//                popup_question.visible = true;
//                print("patrol start button");
            }
        }
    }

    Popup{
        id: popup_patrol_list
        property string mode: "sequence"
        property var select_pos_mode: 0
        anchors.centerIn: parent
        width: 600
        height: 740
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
                anchors.fill: parent
                Rectangle{
                    width: parent.width
                    height: 90
                    color: "transparent"
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 35
                        text: qsTr("로봇이 지정된 위치로 이동합니다")
                        color: "white"
                    }
                }
                Rectangle{
                    width: parent.width
                    height: parent.height-90
                    color: "transparent"
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
                                text: qsTr("[ 순회 방식 설정 ]")
                                color: "white"
                            }
                            Row{
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 20
                                Rectangle{
                                    width: 150
                                    height: 60
                                    border.width: 2
                                    radius: 2
                                    border.color:"white"
                                    color: popup_patrol_list.mode==="random"?color_green:"transparent"
                                    Text{
                                        anchors.centerIn: parent
                                        font.family: font_noto_r.name
                                        font.pixelSize: 20
                                        text: qsTr("랜덤하게")
                                        color: "white"
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            click_sound.play();
                                            popup_patrol_list.mode = "random";
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 150
                                    height: 60
                                    radius: 2
                                    border.width: 2
                                    border.color:"white"
                                    color: popup_patrol_list.mode==="sequence"?color_green:"transparent"
                                    Text{
                                        anchors.centerIn: parent
                                        font.family: font_noto_r.name
                                        font.pixelSize: 20
                                        color: "white"
                                        text: qsTr("순차적으로")
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            click_sound.play();
                                            popup_patrol_list.mode = "sequence";
                                        }
                                    }
                                }
                            }

                        }

                        Column{
                            spacing: 5
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text{
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.family: font_noto_r.name
                                font.pixelSize: 20
                                text: qsTr("[ 순회 위치 설정 ]")
                                color: "white"
                            }
                            Column{
                                height: 300
                                id: cols_patrol_bigmenu
                                anchors.horizontalCenter: parent.horizontalCenter
                                visible: true
                                spacing: 20
                                Rectangle{
                                    width: 320
                                    height: 80
                                    radius: 10
                                    color: popup_patrol_list.select_pos_mode === 0?color_green:"white"
                                    Text{
                                        anchors.centerIn: parent
                                        font.family: font_noto_r.name
                                        text: qsTr("전체 위치")
                                        font.pixelSize: 30
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            click_sound.play();
                                            popup_patrol_list.select_pos_mode = 0;
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 320
                                    height: 80
                                    radius: 10
                                    color: popup_patrol_list.select_pos_mode === 1?color_green:"white"
                                    Text{
                                        anchors.centerIn: parent
                                        font.family: font_noto_r.name
                                        text: qsTr("서빙 위치")
                                        font.pixelSize: 30
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            click_sound.play();
                                            popup_patrol_list.select_pos_mode = 1;
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 320
                                    height: 80
                                    radius: 10
                                    color: popup_patrol_list.select_pos_mode === 2?color_green:"white"
                                    Text{
                                        anchors.centerIn: parent
                                        font.family: font_noto_r.name
                                        text: qsTr("직접 선택")
                                        font.pixelSize: 30
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            popup_patrol_list.select_pos_mode = 2;
                                            click_sound.play();
                                            cols_patrol_bigmenu.visible = false;
                                            flickable_patrol.visible = true;
                                        }
                                    }
                                }
                            }

                            Flickable{
                                id: flickable_patrol
                                width: popup_patrol_list.width
                                height: 300
                                visible: false
                                clip: true
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
                                                    click_sound.play();
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

                        }
                        Rectangle{
                            width: 200
                            height: 80
                            radius: 30
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: color_green
                            Text{
                                anchors.centerIn: parent
                                text: qsTr("순회 시작")
                                font.pixelSize: 40
                                color: "white"
                                font.family: font_noto_b.name
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(popup_patrol_list.select_pos_mode === 0){
                                        click_sound.play();
                                        supervisor.clearRotateList();
                                        for(var i=0; i<supervisor.getLocationNum("");i++){
                                            supervisor.setRotateList(supervisor.getLocationName(i,""));
                                        }
                                        supervisor.startPatrol(popup_patrol_list.mode,false);
                                    }else if(popup_patrol_list.select_pos_mode === 1){
                                        click_sound.play();
                                        supervisor.clearRotateList();
                                        for(var i=0; i<supervisor.getLocationNum("Serving");i++){
                                            supervisor.setRotateList(supervisor.getLocationName(i,"Serving"));
                                        }
                                        supervisor.startPatrol(popup_patrol_list.mode,false);
                                    }else if(popup_patrol_list.select_pos_mode === 2){
                                        click_sound.play();
                                        supervisor.clearRotateList();
                                        for(var i=0; i<model_patrols.count; i++){
                                            if(model_patrols.get(i).select){
                                                supervisor.setRotateList(model_patrols.get(i).name);
                                            }
                                        }
                                        supervisor.startPatrol(popup_patrol_list.mode,false);

                                    }else{
                                        click_sound2.play();
                                    }

                                    popup_patrol_list.close();
                                }
                            }
                        }

                    }

                }
            }

        }
    }


    property var size_menu: 100
    Rectangle{
        id: rect_menu_box
        width: 120
        height: width*3
        clip: true
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.top: parent.top
        anchors.topMargin: statusbar.height + 50
        color: "white"
        radius: 30
        Column{
            spacing: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id: btn_menu
                width: size_menu
                height: size_menu
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Image{
                    id: image_menu
                    source:"icon/btn_menu.png"
                    anchors.centerIn: parent
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            btn_menu.color = color_light_gray;
                            click_sound.play();
                        }
                        onReleased:{
                            btn_menu.color = "white";
                            count_resting = 0;
                            cur_table = -1;
                            loadPage(pmenu);
                        }
                    }
                }
            }
            Rectangle{// 구분바
                width: rect_menu_box.width
                height: 3
                color: "#f4f4f4"
            }
            Rectangle{
                id: btn_charge
                property bool active: false
                width: size_menu
                height: size_menu
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    width: size_menu
                    height: image_charge.height+text_charge.height
                    anchors.centerIn: parent
                    color: parent.color
                    Image{
                        id: image_charge
                        scale: 1.2
                        source:"icon/btn_charge.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        id: text_charge
                        text:qsTr("충전위치로")
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: color_dark_black
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: image_charge.bottom
                        anchors.topMargin: 10
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        btn_charge.color = color_light_gray;
                        count_resting = 0;
                        cur_table = -1;
                        if(btn_charge.active){
                            click_sound.play();
                            go_charge = true;
                        }else{
                            click_sound_no.play();
                        }
                    }
                    onReleased:{
                        btn_charge.color = "white";
                        if(btn_charge.active){
                            popup_question.visible = true;
                        }else{

                            popup_notice.open();
                        }
                    }
                }
            }
            Rectangle{// 구분바
                width: rect_menu_box.width
                height: 3
                color: "#f4f4f4"
            }
            Rectangle{
                id: btn_resting
                width: size_menu
                height: size_menu-10
                property bool active: false
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    width: size_menu
                    height: image_wait.height+text_wait.height
                    anchors.centerIn: parent
                    color: btn_resting.color
                    Image{
                        id: image_wait
                        scale: 1.3
                        source:"icon/btn_wait.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        id: text_wait
                        text:qsTr("대기위치로")
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: color_dark_black
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: image_wait.bottom
                        anchors.topMargin: 10
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        btn_resting.color = color_light_gray;
                        count_resting = 0;
                        cur_table = -1;
                        if(btn_resting.active){
                            click_sound.play();
                        }else{
                            click_sound_no.play();
                        }
                    }
                    onReleased:{
                        btn_resting.color = "white";
                        if(btn_resting.active){
                            go_wait = true;
                            popup_question.visible = true;
                        }else{
                            popup_notice.open();
                        }
                    }
                }
            }
        }
    }


    Popup{
        id: popup_notice
        anchors.centerIn: parent
        width: parent.width
        height: 320
        property string main_str: ""
        property string sub_str: ""
        property bool show_localization: false
        property bool show_motorinit: false
        property bool show_restart: false
        background:Rectangle{
            anchors.fill: parent
            color: "transparent"
        }
        topPadding: 0
        bottomPadding: 0
        rightPadding: 0
        leftPadding: 0
        Rectangle{
            width: parent.width
            height: parent.height
            color: color_dark_navy
            Rectangle{
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height-30
                width: parent.width
                color: color_light_gray
//                color: color_dark_black
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 150
                    spacing: 100
                    Image{
                        id: image_warn
                        width: 160
                        height: 160
                        source: "image/icon_warning.png"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Column{
                        spacing: 10
                        anchors.verticalCenter: parent.verticalCenter
                        Text{
                            color: color_dark_navy
                            font.family: font_noto_r.name
                            font.pixelSize: 50
                            text: popup_notice.main_str
                        }
                        Text{
                            color: color_dark_navy
                            font.family: font_noto_r.name
                            font.pixelSize: 35
                            text: popup_notice.sub_str
                        }
                    }

                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        popup_notice.close();
                    }
                }
                Rectangle{
                    width:  150
                    height: 70
                    anchors.right: parent.right
                    anchors.rightMargin: 50
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    color: color_dark_navy
                    radius: 40
                    visible: popup_notice.show_localization
                    Text{
                        anchors.centerIn: parent
                        color: "white"
                        font.family: font_noto_r.name
                        font.pixelSize: 25
                        text: qsTr("위치초기화")
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_dark_black
                            click_sound.play()
                        }
                        onReleased:{
                            parent.color = "transparent"
                            loadPage(plocalization);
                        }
                    }
                }
                Rectangle{
                    id: btn_restart
                    width:  150
                    height: 70
                    anchors.right: parent.right
                    anchors.rightMargin: 50
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    color: color_dark_navy
                    radius: 40
                    visible: popup_notice.show_restart
                    Rectangle{
                        width:  150
                        height: 70
                        color: color_dark_navy
                        radius: 40
                        Text{
                            anchors.centerIn: parent
                            color: "white"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            text: qsTr("재시작")
                        }
                        MouseArea{
                            anchors.fill: parent
                            onPressed:{
                                parent.color = color_dark_black
                                click_sound.play()
                            }
                            onReleased:{
                                parent.color = "transparent"
                                supervisor.programRestart();
                            }
                        }
                    }
                }
                Rectangle{
                    width:  150
                    height: 70
                    anchors.right: parent.right
                    anchors.rightMargin: 50
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    color: color_dark_navy
                    radius: 40
                    visible: popup_notice.show_motorinit
                    Text{
                        anchors.centerIn: parent
                        color: "white"
                        font.family: font_noto_r.name
                        font.pixelSize: 25
                        text: qsTr("모터초기화")
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_dark_black
                            click_sound.play()
                        }
                        onReleased:{
                            parent.color = "transparent"

                        }
                    }
                }
            }

        }
    }

    Item{
        id: popup_question
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "#282828"
            opacity: 0.8
        }
        Image{
            id: image_location
            source:"image/image_location.png"
            width: 160
            height: 160
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 200
        }
        Text{
            id: text_quest
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:image_location.bottom
            anchors.topMargin: 30
            font.family: font_noto_b.name
            font.pixelSize: 40
            color: "#12d27c"
            text: {
                if(go_wait){
                    qsTr("대기 장소로 이동<font color=\"white\">하시겠습니까?</font>")
                }else if(go_charge){
                    qsTr("충전기로 이동<font color=\"white\">하시겠습니까?</font>")
                }else if(go_patrol){
                    qsTr("패트롤을 시작 <font color=\"white\">하시겠습니까?</font>")
                }else if(calling_mode){
                    qsTr("트레이를 모두 비우고<font color=\"white\"> 확인 버튼을 눌러주세요.</font>")
                }else{
                    ""
                }
            }
        }
        Rectangle{
            id: btn_confirm
            width: 250
            height: 90
            radius: 20
            visible: !go_charge&&!go_wait&&!go_patrol
            color: "#d0d0d0"
            anchors.top: text_quest.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            Image{
                id: image_confirm
                source: "icon/btn_yes.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
            }
            Text{
                id:text_confirm
                text:qsTr("확인")
                font.family: font_noto_b.name
                font.pixelSize: 30
                color:"#282828"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: image_confirm.right
                anchors.leftMargin : (parent.width - image_confirm.x - image_confirm.width)/2 - text_confirm.width/2
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    count_resting = 0;
                    if(go_wait){
                        start_sound.play();
                        supervisor.moveToWait();
                    }else if(go_charge){
                        start_sound.play();
                        supervisor.moveToCharge();
                    }else if(go_patrol){
                        start_sound.play();

                    }else{
                        click_error.play();
                    }

                    go_wait = false;
                    go_charge = false;
                    go_patrol = false;
                    popup_question.visible = false;
                }
            }
        }
        Rectangle{
            id: btn_no
            width: 250
            height: 90
            radius: 20
            visible: go_charge||go_wait||go_patrol
            color: "#d0d0d0"
            anchors.top: text_quest.bottom
            anchors.topMargin: 50
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 20
            Image{
                id: image_no
                source: "icon/btn_no.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
            }
            Text{
                id:text_nono
                text:qsTr("아니오")
                font.family: font_noto_b.name
                font.pixelSize: 30
                color:"#282828"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: image_no.right
                anchors.leftMargin : (parent.width - image_no.x - image_no.width)/2 - text_nono.width/2
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    click_sound.play();
                    count_resting = 0;
                    go_wait = false;
                    go_charge = false;
                    go_patrol = false;
                    popup_question.visible = false;
                }
            }
        }
        Rectangle{
            id: btn_yes
            width: 250
            height: 90
            radius: 20
            visible: go_charge||go_wait||go_patrol
            color: "#d0d0d0"
            anchors.top: text_quest.bottom
            anchors.topMargin: 50
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 20
            Rectangle{
                color:"white"
                width: 240
                height: 80
                radius: 19
                anchors.centerIn: parent
            }
            Image{
                id: image_yes
                source: "icon/btn_yes.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
            }
            Text{
                text:qsTr("네")
                font.family: font_noto_b.name
                font.pixelSize: 30
                color:"#282828"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: image_yes.right
                anchors.leftMargin : (parent.width - image_yes.x - image_yes.width)/2 - width/2
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    click_sound.play();
                    count_resting = 0;
                    supervisor.setMotorLock(true);
                    if(go_wait){
                        supervisor.moveToWait();
                    }else if(go_charge){
                        supervisor.moveToCharge();
                    }else if(go_patrol){
                        print("patrol start command");
                    }else if(calling_mode){
                        calling_mode = false;
                    }
                    go_wait = false;
                    go_charge = false;
                    go_patrol = false;
                    popup_question.visible = false;
                }
            }
        }
    }

    Popup{
        id: popup_clean_calling
        anchors.centerIn: parent
        width: 1280
        height: 800
        property bool cleaninglocation: false
        background: Rectangle{
            anchors.fill: parent
            color: color_dark_black
            opacity: 0.8
        }
        onOpened: {
            update();
            timer_upd.start();
        }
        onClosed:{
            timer_upd.stop();
        }
        Timer{
            id: timer_upd
            repeat: true
            interval: 1000
            onTriggered:{
                popup_clean_calling.update();
            }
        }

        function update(){
            supervisor.writelog("call size : "+Number(supervisor.getCallQueueSize()));
            calls.clear();
            for(var i=0; i<supervisor.getCallQueueSize(); i++){
                calls.append({"loc_name":supervisor.getCallName(i)});
            }

            if(calls.count > 0){
                calling_list.visible = true;
            }else{
                calling_list.visible = false;
            }
        }

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            Column{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 80
                Text{
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 45
                    text: qsTr("다녀왔습니다")
                }
                Text{
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 40
                    text: qsTr("확인버튼을 누르시면 대기위치로 이동합니다\n바로 이동명령을 내리시려면 닫기를 눌러주세요")
                }
            }

            Column{
                id: calling_list
                anchors.centerIn: parent
                spacing: 5
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    text: qsTr("호출 대기열")
                }
                Flickable{
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 600
                    height: 100
                    contentWidth: row_calling.width
                    clip: true
                    Row{
                        id: row_calling
                        anchors.centerIn: parent
                        spacing: 10
                        Repeater{
                            id: rep_call
                            model: ListModel{id: calls}
                            Rectangle{
                                color: "transparent"
                                border.width: 2
                                border.color: "white"
                                width: 150
                                radius: 20
                                height: 60
                                Text{
                                    color:"white"
                                    font.family: font_noto_r.name
                                    text: loc_name
                                    anchors.centerIn: parent
                                    font.pixelSize: 20
                                    Component.onCompleted: {
                                        scale = 1;
                                        while(width*scale > parent.width*0.8){
                                            scale=scale-0.01;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

            }

            Row{
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 100
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 30
                Rectangle{
                    width: 250
                    height: 90
                    radius: 19
                    color:"#d0d0d0"
                    visible: calling_list.visible
                    Image{
                        id: imm2
                        source: "icon/btn_yes.png"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                    }
                    Text{
                        text:qsTr("대기열 지우기")
                        font.family: font_noto_b.name
                        font.pixelSize: 25
                        color:"#282828"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: imm2.right
                        anchors.leftMargin : (parent.width - imm2.x - imm2.width)/2 - width/2
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            click_sound.play();
                            supervisor.clearCallQueue();
                        }
                    }
                }
                Rectangle{
                    width: 250
                    height: 90
                    radius: 20
                    visible: popup_clean_calling.cleaninglocation && calling_list.visible
                    color: "#d0d0d0"
                    Rectangle{
                        width: 240
                        height: 80
                        anchors.centerIn: parent
                        radius: 19
                        color: "white"
                        Text{
                            text:qsTr("호출위치로")
                            font.family: font_noto_b.name
                            font.pixelSize: 30
                            color:"#282828"
                            anchors.centerIn: parent
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            click_sound.play();
                            supervisor.cleanTray();
                        }
                    }
                }
                Rectangle{
                    width: 250
                    height: 90
                    radius: 20
                    visible: popup_clean_calling.cleaninglocation
                    color: "#d0d0d0"
                    Rectangle{
                        width: 240
                        height: 80
                        anchors.centerIn: parent
                        radius: 19
                        color: "white"
                        Text{
                            text:qsTr("확인")
                            font.family: font_noto_b.name
                            font.pixelSize: 30
                            color:"#282828"
                            anchors.centerIn: parent
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            click_sound.play();
                            supervisor.moveToWait();
                        }
                    }
                }
                Rectangle{
                    width: 250
                    height: 90
                    radius: 20
                    visible: popup_clean_calling.cleaninglocation
                    color: "#d0d0d0"
                    Rectangle{
                        width: 240
                        height: 80
                        anchors.centerIn: parent
                        radius: 19
                        color: "white"
                        Text{
                            text:qsTr("닫기")
                            font.family: font_noto_b.name
                            font.pixelSize: 30
                            color:"#282828"
                            anchors.centerIn: parent
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            click_sound.play();
                            popup_clean_calling.close();
                        }
                    }
                }
                Rectangle{
                    width: 250
                    height: 90
                    radius: 20
                    visible: !popup_clean_calling.cleaninglocation
                    color: "#d0d0d0"
                    Rectangle{
                        width: 240
                        height: 80
                        anchors.centerIn: parent
                        radius: 19
                        color: "white"
                        Image{
                            id: imm
                            source: "icon/btn_yes.png"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                        }
                        Text{
                            text:qsTr("확인")
                            font.family: font_noto_b.name
                            font.pixelSize: 30
                            color:"#282828"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: imm.right
                            anchors.leftMargin : (parent.width - imm.x - imm.width)/2 - width/2
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.cleanTray();
                            popup_clean_calling.close();
                        }
                    }
                }

            }
        }

    }
}
