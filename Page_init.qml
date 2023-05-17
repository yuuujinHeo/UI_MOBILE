import QtQuick 2.12
import QtQuick.Controls 2.12
import "."
import io.qt.Supervisor 1.0
import io.qt.MapView 1.0

Item {
    id: page_init
    objectName: "page_init"
    width: 1280
    height: 800

    property int init_mode: 0 //0:inifile, 1:mapfile, 2:connection, 3:slam, 4:done

//    property bool ui_slam_init: false
//    onUi_slam_initChanged: {
//        if(ui_slam_init){
//            loader_init.item.startinit();
//        }else{
//            loader_init.item.startreturn();
//        }
//    }

    property bool show_debug: false

    Component.onCompleted: {
        init_mode = 0;
        update_timer.start();
        statusbar.visible = false;

        supervisor.clearSharedMemory();

    }
    Component.onDestruction: {
        timer_usb_check.stop();
        timer_usb_new.stop();
        timer_wait_lcm.stop();
        failload_timer.stop();
        update_timer.stop();

    }

    function init(){

    }

    function loadmap_server(result){
        if(result){
            update_timer.stop();
            popup_show_map.is_server = true;
            popup_show_map.open();
        }else{
            loader_init.item.enable_failload();
            failload_timer.start();
        }
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
                    duration: 2000
                    running: true
                }

                Image{
                    id: image_logo1
                    sourceSize.width: 2245/6
                    sourceSize.height: 1004/6
                    source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
                    anchors.horizontalCenter:  parent.horizontalCenter
                    y: 200
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

    //맵을 찾을 수 없을 때
    Component{
        id: item_map_init
        Item{
            objectName: "init_map"
            anchors.fill: parent
            Component.onCompleted: {
                statusbar.visible = true;
            }
            function enable_rawmap(){
                notice_map_raw.enabled = true;
            }
            function disable_rawmap(){
                notice_map_raw.enabled = false;
            }
            function enable_availablemap(){
                notice_map_edited.enabled = true;
            }
            function disable_availablemap(){
                notice_map_edited.enabled = false;
            }
            function enable_failload(){
                notice_failload.enabled = true;
            }
            function disable_failload(){
                notice_failload.enabled = false;
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
                    if(supervisor.getLCMConnection() || supervisor.isIPCused()){
                        btn_slam_start.enabled = true;
                    }else{
                        btn_slam_start.enabled = false;
                    }
                }
            }

            Column{
                anchors.top: parent.top
                anchors.topMargin: 200
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:80
                Image{
                    id: image_logo
                    sourceSize.width: 2245/6
                    sourceSize.height: 1004/6
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
                }
                Text{
                    id: text_notice
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: "맵 파일을 찾을 수 없습니다.";
                    color: "#7e7e7e"
                    font.family: font_noto_r.name
                }

                Row{
                    spacing: 50
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle{
                        id: btn_slam_start
                        width: 188
                        height: 100
                        radius: 60
                        border.width: 3
                        border.color: "#e5e5e5"
                        enabled: supervisor.getLCMConnection()
                        color: enabled?"transparent":"#e5e5e5"
                        Column{
                            anchors.centerIn: parent
                            spacing: 5
                            Image{
                                source: "icon/icon_add.png"
                                width: 30
                                height: 30
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                text: "맵 새로만들기"
                                font.pixelSize: 15
                                font.family: font_noto_r.name
                                color:enabled?"black":"white"
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.writelog("[USER INPUT] INIT PAGE : MAKE NEW MAP")
                                loadPage(pmap);
                                loader_page.item.map_mode = 1;
                            }
                        }
                    }
                    Rectangle{
                        id: btn_usb_load
                        width: 188
                        height: 100
                        radius: 60
                        border.width: 3
                        border.color: "#e5e5e5"
                        enabled: supervisor.getusbsize()>0?true:false
                        color: enabled?"transparent":"#e5e5e5"
                        Column{
                            anchors.centerIn: parent
                            spacing: 5
                            Image{
                                scale: 0.8
                                source: "icon/icon_open.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                text: "USB에서\n가져오기"
                                font.pixelSize: 15
                                horizontalAlignment: Text.AlignHCenter
                                font.family: font_noto_r.name
                                color:enabled?"black":"white"
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.writelog("[USER INPUT] INIT PAGE : LOAD MAP FROM USB")
                                popup_usb_download.open();
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
                                text: "넘어가기 (DEBUG)"
                                font.family: font_noto_r.name
                                font.pixelSize: 15
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.writelog("[USER INPUT] INIT PAGE : PASS CONNECTION")
                                loadPage(pkitchen);
                                update_timer.stop();
                            }
                        }
                    }
                }
            }
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
                        show_debug = true;
                    }
                }
            }

            Rectangle{
                id: notice_failload
                width: 220
                height: 60
                radius: 10
                border.width: 3
                border.color: "#E7584D"
                color: "white"
                enabled: false
                anchors.right: parent.right
                anchors.rightMargin: -20
                visible: (y<200)?true:false
                y: enabled?100:800
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
                    text: "서버로 부터\n맵을 읽어오지 못함"
                    font.bold: true
                    font.pixelSize: 15
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
                    text: "설정중이던 맵이 있습니다."
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
                    text: "사용가능한 맵이 있습니다."
                    font.bold: true
                    font.pixelSize: 12
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        supervisor.writelog("[USER INPUT] INIT PAGE : SHOW UNSETTING MAP")
                        popup_show_map.is_server = false;
                        popup_show_map.open();
                    }
                }
            }
        }
    }

    //로봇과 lcm연결 되지 않을 때
    Component{
        id: item_lcm
        Item{
            objectName: "init_lcm"
            anchors.fill: parent
            Component.onCompleted: {
                statusbar.visible = true;
            }

            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
            }

            Column{
                anchors.top: parent.top
                anchors.topMargin: 200
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:80
                Image{
                    id: image_logo3
                    sourceSize.width: 2245/6
                    sourceSize.height: 1004/6
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
                }
                Text{
                    id: text_notice3
                    font.family: font_noto_r.name
                    color: "#7e7e7e"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "로봇과 연결이 되지 않습니다."
                    font.pixelSize: 20
                }
                Row{
                    id: row_menu3
                    spacing: 30
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle{
                        id: btn_minimize
                        width: 188
                        height: 100
                        radius: 60
                        color: "transparent"
                        border.width: 3
                        border.color: "#e5e5e5"
                        Column{
                            spacing: 5
                            anchors.centerIn: parent
                            Image{
                                id: image_charge
                                width: 30
                                height: 30
                                source:"icon/btn_minimize.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                text: "재시작"
                                font.family: font_noto_r.name
                                font.pixelSize: 15
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.writelog("[USER INPUT] INIT PAGE : PROGRAM RESTART")
                                supervisor.programRestart();
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
                                text: "넘어가기 (디버그 용)"
                                font.family: font_noto_r.name
                                font.pixelSize: 15
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                supervisor.writelog("[USER INPUT] INIT PAGE : PASS CONNECTION")
                                loadPage(pkitchen);
                                update_timer.stop();
                            }
                        }
                    }

                }
            }


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
                        show_debug = true;
                    }
                }
            }
        }
    }

    //로봇과 연결은 되었으나 init되지 않을 때
    Component{
        id: item_slam_init
        Item{
            objectName: "init_slam"
            anchors.fill: parent
            Component.onCompleted: {
                statusbar.visible = true;
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
                    NumberAnimation{
                        target: btn_slam_do_init;
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
                text: "로봇을 지정된 대기위치로 이동시켜 주세요.\n이동하신 후 시작버튼을 눌러주세요."
                font.pixelSize: 50
            }
            Rectangle{
                id: btn_slam_do_init
                width: 300
                height: 120
                radius: 60
                opacity: 0
                color: color_green
                border.width: 3
                border.color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 100
                Text{
                    id: text_slam_do_init
                    anchors.centerIn: parent
                    text: "시   작"
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 40
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_green;
                    }
                    onReleased: {
                        parent.color = color_green;
                    }
                    onClicked: {
                        supervisor.writelog("[USER INPUT] INIT PAGE : DO LOCALIZATION")
                        popup_localization_start.open();
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
                anchors.left: btn_slam_do_init.right
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
                        id: text_slam_pass
                        text: "넘어가기 (DEBUG)"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        supervisor.writelog("[USER INPUT] INIT PAGE : PASS LOCALIZATION")
                        loadPage(pkitchen);
                    }
                }
            }
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
                        show_debug = true;
                    }
                }
            }
        }

    }


    Popup{
        id: popup_localization_done
        anchors.centerIn: parent
        closePolicy: Popup.NoAutoClose
        width: 1280
        height: 800
        topPadding: 0
        bottomPadding: 0
        leftPadding: 0
        rightPadding: 0
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }
        onOpened:{
            mapview_localization.setEnable(true);
            mapview_localization.setViewer("local_view");
            mapview_localization.loadmap(supervisor.getMapname(),"local");
        }
        onClosed: {
            mapview_localization.setEnable(false);
        }

        Rectangle{
            anchors.centerIn: parent
            width: 1000
            height: 800
            radius: 20
            color: color_dark_navy
            Column{
                anchors.centerIn: parent
                spacing: 10
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    text: "로봇의 위치를 찾았습니다.\n맵과 로봇 라이다맵(푸른 선)이 일치하는 지 확인해주세요."
                }
                Map_full{
                    id: mapview_localization
                    width: 550
                    height: width
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 30
                    Rectangle{
                        width: 150
                        height: 80
                        radius: 10
                        border.width: 1
                        Text{
                            anchors.centerIn: parent
                            text: "확인"
                            font.family: font_noto_r.name
                            font.pixelSize: 20
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                popup_localization_done.close();
                                //localization done
                            }
                        }
                    }
                    Rectangle{
                        width: 150
                        height: 80
                        radius: 10
                        border.width: 1
                        Text{
                            anchors.centerIn: parent
                            text: "재시도"
                            font.family: font_noto_r.name
                            font.pixelSize: 20
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                popup_localization_start.open();
                                popup_localization_done.close();
                                //localization done
                            }
                        }
                    }
                }
            }
        }
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
                    popup_localization_done.close();
                }
            }
        }
    }

    Popup{
        id: popup_localization_start
        anchors.centerIn: parent
        closePolicy: Popup.NoAutoClose
        width: 1280
        height: 800
        topPadding: 0
        bottomPadding: 0
        leftPadding: 0
        rightPadding: 0
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }
        onOpened: {
            supervisor.writelog("[QML] INIT PAGE -> LOCALIZATION AUTO ")
            supervisor.slam_autoInit();
            timer_check_localization.start();
        }
        onClosed: {

            timer_check_localization.stop();
        }

        Timer{
            id: timer_check_localization
            running: false
            interval: 500
            repeat: true
            onTriggered: {
                if(supervisor.getLocalizationState() === 2){
                    popup_localization_done.open();
                    local_loading.visible = false;
                    timer_check_localization.stop();
                    popup_localization_start.close();
                }else if(supervisor.getLocalizationState() === 3){
                    local_loading.visible = false;
                    local_text.text = "로봇의 위치를 찾을 수 없습니다\n로봇이 바라보는 방향에 유의하여 대기위치로 이동시켜주세요."
                }else{
                    local_text.text = "로봇의 위치를 찾는 중입니다."
                    local_loading.visible = true;
                }
            }
        }

        Rectangle{
            anchors.centerIn: parent
            width: 450
            height: 200
            radius: 20
            color: color_dark_navy
            Column{
                anchors.centerIn: parent
                Text{
                    id: local_text
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    text: "로봇의 위치를 찾는 중입니다."
                }
                AnimatedImage{
                    id: local_loading
                    source: "video/loading_row.gif"
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        MouseArea{
            width: 150
            height: 150
            anchors.right: parent.right
            anchors.bottom : parent.bottom
            z: 99
            property var password: 0
            onClicked: {
                password++;
                if(password > 4){
                    popup_localization_start.close();
                }
            }
        }
    }
    //로봇과 연결은 되었으나 init되지 않을 때
    Component{
        id: item_motor_init
        Item{
            objectName: "init_motor"
            anchors.fill: parent
            Component.onCompleted: {
                statusbar.visible = true;
            }
            Rectangle{
                anchors.fill: parent
                color: "#f4f4f4"
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
                horizontalAlignment: Text.AlignHCenter
                color: "#7e7e7e"
                font.family: font_noto_r.name
                text: "모터가 초기화되지 않았습니다. 비상 스위치를 확인해주세요."
                font.pixelSize: 20
            }
            Rectangle{
                id: btn_slam_pass
                width: 188
                height: 100
                radius: 60
                color: "transparent"
                border.width: 3
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
                        text: "넘어가기 (디버그 용)"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        supervisor.writelog("[USER INPUT] INIT PAGE : PASS ROBOT INIT")
                        loadPage(pkitchen);
    //                    update_timer.stop();
                    }
                }
            }
        }

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
        interval: 5000
        running: false
        repeat: false
        onTriggered: {
            supervisor.writelog("[QML - ERROR] lcm connection failed.");
            loader_init.sourceComponent = item_lcm;
        }
    }

    Timer{
        id: update_timer
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            //체크 : robot.ini 존재여부
            if(init_mode == 0){
                if(supervisor.isExistRobotINI()){
                    init_mode = 1;
                }else{
                    if(loader_init.item.objectName != "init_ini"){
                        loader_init.sourceComponent = item_ini_init
                        supervisor.writelog("[QML - ERROR] robot_config.ini not found.");
                    }
                }
            //체크 : 맵 파일 존재여부 및 설정
            }else if(init_mode == 1){
                //supervisor가 ini파일을 성공적으로 읽었을 때까지 대기
                if(supervisor.getIniRead()){
                    var map_name = supervisor.getMapname();
                    //annotation과 map 존재여부 확인
                    if(supervisor.isExistAnnotation(map_name) && supervisor.isExistMap()){
                        //이미 설정확인된 맵이 존재한다면 다음으로 넘어감
                        popup_ask_annotation_use.close();
                        popup_map_list.close();
                        init_mode = 2;
                    }else{
                        //annotation, map 둘 중 하나라도 없으면 안내페이지 표시
                        if(loader_init.item.objectName != "init_map"){
                            supervisor.writelog("[QML - ERROR] Map not found. "+map_name);
                            loader_init.sourceComponent = item_map_init
                        }

                        //USB연결 확인
                        if(supervisor.getusbsize() > 0){
                            loader_init.item.enable_usb();
                        }else{
                            loader_init.item.disable_usb();
                        }

                        //설정 된 맵은 있지만 annotation은 없는 경우
                        if(supervisor.isExistMap()){
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
            }else if(init_mode == 2){
                if(supervisor.getLCMConnection()){
                    init_mode = 3;
                    timer_wait_lcm.stop();
                }else{
                    if(loader_init.item.objectName != "init_lcm" && !timer_wait_lcm.running){
                        timer_wait_lcm.start();
                    }
                }
            }else if(supervisor.getChargeStatus() === 1){
                dochargeininit();
            }else if(init_mode == 3){
                if(supervisor.getLCMConnection() && supervisor.getLocalizationState() === 2){
                    init_mode = 4;
                }else{
                    if(loader_init.item.objectName != "init_slam"){
                        loader_init.sourceComponent = item_slam_init
                    }
                }
            }else if(init_mode == 4){
                if(supervisor.getLCMConnection() && supervisor.getMotorState() === 1){
                    supervisor.writelog("[QML] INIT ALL DONE -> ROBOT READY")
                    init_mode = 5;
                    update_timer.stop();
                    loadPage(pkitchen);
                    supervisor.initdone();
                }else{
                    if(loader_init.item.objectName != "init_motor"){
                        loader_init.sourceComponent = item_motor_init
                    }
                }
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Popup_map_list{
        id: popup_map_list
    }


    //USB 맵 목록 보여주기
    Popup{
        id:popup_usb_map
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        background: Rectangle{
            color: "#282828"
            opacity: 0.7
        }
        onOpened: {
            list_map_usb.model.clear();
            var num = supervisor.getUsbMapSize();
            for(var i=0; i<num; i++){
                list_map_usb.model.append({"name":supervisor.getUsbMapPath(i),"selected":false});
            }
        }
        Rectangle{
            width: 600
            height: 700
            anchors.centerIn: parent
            radius: 30
            color: "#282828"
            Image{
                id: image_popup
                source: "image/robot_head.png"
                width: 90
                height: 55
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
            }

            Text{
                id: text_popup_usb
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: image_popup.bottom
                anchors.topMargin: 20
                color: "white"
                font.family: font_noto_b.name
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                text: "USB에서 아래와 같은 맵 파일을 찾았습니다.\n 가져오시려면 원하는 파일을 선택 후 확인 버튼을 누르세요."
            }
            ListView {
                id: list_map_usb
                width: 400
                height: 250
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_popup_usb.bottom
                anchors.topMargin: 50
                clip: true
                model: ListModel{}
                delegate: usbCompo
                //focus: true
            }
            Row{
                spacing: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: list_map_usb.bottom
                anchors.topMargin: 50
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
                            for(var i=0; i<supervisor.getUsbMapSize(); i++){
//                                print(i,list_map_usb.model.get(i).selected,list_map_usb.model.get(i).name);
                                if(list_map_usb.model.get(i).selected){
                                    supervisor.saveMapfromUsb(list_map_usb.model.get(i).name);
                                }
                            }
                            popup_usb_map.close();
                        }
                    }
                }
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
                            popup_usb_map.close();
                        }
                    }
                }
            }
        }
    }
    Component {
        id: usbCompo
        Item {
            width: parent.width
            height: 40
            Rectangle {
                visible: selected
                anchors.fill: parent
                color: "#12d27c"
                radius: 5
            }
            Text {
                id: text_loc
                anchors.centerIn: parent
                text: name
                color: "white"
                font.family: font_noto_b.name
            }
            Rectangle//리스트의 구분선
            {
                id:line
                width:parent.width
                anchors.bottom:parent.bottom//현재 객체의 아래 기준점을 부모객체의 아래로 잡아주어서 위치가 아래로가게 설정
                height:1
                color: "#d0d0d0"
            }
            MouseArea{
                id:area_compo
                anchors.fill:parent
                onClicked: {
                    list_map_usb.currentIndex = index;
                    if(selected){
                        selected = false;
                    }else{
                        selected = true;
                    }
                }
            }
            Rectangle{
                width: 60
                height: 30
                color: "#D0D0D0"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                Text{
                    text: "미리보기"
                    color: "#282828"
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        popup_show_map_light.map = supervisor.getUsbMapPathFull(index);
                        popup_show_map_light.open();
                    }
                }
            }
        }
    }

    //맵 보여주기
    Popup{
        id: popup_show_map_light
        width: 500
        height: 500
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        bottomPadding: 0
        anchors.centerIn: parent
        property string map: ""
        onOpened: {
            map_load2.enabled = true;
            map_load2.just_show_map = true;
            map_load2.loadmap(map);
        }
        onClosed:{
            map_load2.enabled = false;
        }

        Map_full{
            objectName: "INITSHOW"
            id: map_load2
            enabled: popup_show_map_light.opened
            width: popup_show_map_light.width
            height: popup_show_map_light.height
//            anchors.fill: parent
        }
    }
    Popup{
        id: popup_ask_annotation_use
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        closePolicy: Popup.NoAutoClose
        background: Rectangle{
            color:"#282828"
            opacity: 0.8
        }

        Rectangle{
            width: 450
            height: 200
            anchors.centerIn: parent
            color: "white"
            radius: 10
            Column{
                anchors.centerIn: parent
                spacing: 30
                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        id: text_title_ask
                        text: "사용가능한 <font color=\"#12d27c\">맵 설정</font> 파일을 찾았습니다."
                        font.family: font_noto_r.name
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 20
                    }
                    Text {
                        id: text_title_ask3
                        text: "확인 후 사용하지 않거나 수정할 수 있습니다."
                        font.family: font_noto_r.name
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 15
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
                            text: "사용 안함"
                            font.family: font_noto_r.name
                            font.pixelSize: 25

                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                popup_ask_annotation_use.close();
                                use_annotation = false;
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
                            text: "사용"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color: "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                popup_ask_annotation_use.close();
                                use_annotation = true;
                            }
                        }
                    }
                }

            }

        }

    }

    Popup{
        id: popup_annotation_delete
        width: parent.width
        height: parent.height
        background:Rectangle{
            anchors.fill: parent
            color: "#282828"
            opacity: 0.7
        }
        property string name: ""
        Rectangle{
            anchors.centerIn: parent
            width: 400
            height: 250
            color: "white"
            radius: 10

            Column{
                anchors.centerIn: parent
                spacing: 40
                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: "기존 맵 설정이 삭제됩니다."
                        font.family: font_noto_r.name
                        font.pixelSize: 20
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
                                popup_annotation_delete.close();
                            }
                        }
                    }
                    Rectangle{
                        id: btn_next_00
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
                                supervisor.writelog("[USER INPUT] INIT PAGE : DELETE ANNOTATION "+supervisor.getMapname())
                                supervisor.deleteAnnotation();
                                loadPage(pmap);
                                loader_page.item.loadmap(popup_annotation_delete.name,"RAW");
                                loader_page.item.is_init_state = true;
                                loader_page.item.map_mode = 2;
                                popup_annotation_delete.close();
                                popup_map_list.close();
                            }
                        }
                    }
                }
            }
        }

    }

    //서버 맵 보여주기
    Popup{
        id: popup_show_map
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        background: Rectangle{
            color: "#282828"
            opacity: 0.8
        }
        property bool is_server: false
        onOpened: {
            if(is_server){
                text_show_popup.text = "서버로부터 맵을 로드했습니다.\n 매장의 환경과 일치하는 맵인지 확인해주세요."
//                map_load.loadmap(supervisor.getServerMapname());
            }else{
                text_show_popup.text = "매장의 환경과 일치하는 맵인지 확인해주세요."
                map_load.loadmap(supervisor.getMapname(),"EDITED");
            }
            map_load.enabled = true;
            map_load.show_object = true;
            map_load.show_location = true;
            map_load.setfullscreen();
        }
        onClosed: {
            map_load.enabled = false;
        }

        Text{
            id: text_show_popup
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 30
            text: "서버로부터 맵을 로드했습니다. 매장의 환경과 일치하는 맵인지 확인해주세요."
            color: "white"
            font.family: font_noto_r.name
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
        }
        Map_full{
            id: map_load
            objectName: "SHOWSERVER"
            enabled: popup_show_map.opened
            width: 500
            height: 500
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: rect_map_name.bottom
            anchors.topMargin: 10
        }
        Rectangle{
            id: rect_map_name
            width: map_load.width*0.9
            radius: 5
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: text_show_popup.bottom
            anchors.topMargin: 20
            color: "white"
            Text{
                anchors.centerIn: parent
                color: "#282828"
                font.family: font_noto_b.name
                font.pixelSize: 20
                text: popup_show_map.is_server?"이름 : " + supervisor.getServerMapname():"이름 : " + supervisor.getMapname();
                horizontalAlignment: Text.AlignHCenter
            }
        }
        Rectangle{
            id: btn_menu2
            width: 120
            height: width
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.top: parent.top
            anchors.topMargin: 100
            color: "white"
            radius: 30
            Behavior on width{
                NumberAnimation{
                    duration: 500;
                }
            }
            Image{
                id: image_btn_menu2
                source:"icon/btn_reset2.png"
                scale: 1-(120-parent.width)/120
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    popup_show_map.close();
                }
            }
        }
        Row{
            id: row_button_2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: map_load.bottom
            anchors.topMargin: 20
            spacing: 30

            Rectangle{
                id: btn_use_map
                width: 78
                height: width
                radius: width
                visible: popup_show_map.is_server
                color:"white"
                Column{
                    anchors.centerIn: parent
                    Image{
                        source: "icon/icon_move.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        text: "사용"
                        font.family: font_noto_r.name
                        color: "#525252"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(popup_show_map.is_server){
                            popup_show_map.close();
                            //robot.ini에 서버맵정보를 넣고 annotation, map_meta.ini 수정
                            supervisor.setuseServerMap(true);
                            update_timer.start();
                        }
                    }
                }
            }
            Rectangle{
                id: btn_eidt_map
                width: 78
                height: width
                radius: width
                color:"white"
                Column{
                    anchors.centerIn: parent
                    Image{
                        source: "icon/icon_draw.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        text: "수정"
                        font.family: font_noto_r.name
                        color: "#525252"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        var name;
                        if(popup_show_map.is_server){
                            name = supervisor.getServerMapname();
                        }else{
                            name = supervisor.getMapname();
                        }
                        popup_show_map.close();
                        loadPage(pmap);
                        loader_page.item.loadmap(name);
                        loader_page.item.is_init_state = true;
                        loader_page.item.map_mode = 2;
                        loader_page.item.init_mode();
                        update_timer.start();
                    }
                }
            }
            Rectangle{
                id: btn_remove_map
                width: 78
                height: width
                radius: width
                color:"white"
                Column{
                    anchors.centerIn: parent
                    Image{
                        source: "icon/icon_erase.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        text: "삭제"
                        font.family: font_noto_r.name
                        color: "#525252"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        var name;
                        if(popup_show_map.is_server){
                            name = supervisor.getServerMapname();
                        }else{
                            name = supervisor.getMapname();
                        }
                        supervisor.removeMap(name);
                        popup_show_map.close();
                        update_timer.start();
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

}
