import QtQuick 2.12
import QtQuick.Controls 2.12
import "."
import io.qt.Supervisor 1.0

Item {
    id: page_init
    objectName: "page_init"
    width: 1280
    height: 800

    property int init_mode: 0 //0:inifile, 1:mapfile, 2:connection, 3:slam, 4:done
    property bool ui_slam_init: false

    onUi_slam_initChanged: {
        if(ui_slam_init){
            ani_do_init.start();
        }else{
            ani_do_init_return.start();
        }
    }

    Component.onCompleted: {
        init_mode = 0;
        popup_show_map.show_mode = 0;
        update_timer.start();
        statusbar.visible = false;
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
                    width: 748/1.5
                    height: 335/1.5
                    source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
                    anchors.horizontalCenter:  parent.horizontalCenter
                    y: text_copyright.y / 2 - height/2
                }

                Text{
                    id: text_copyright
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 100
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
            function enable_editedmap(){
                notice_map_edited.enabled = true;
            }
            function disable_editedmap(){
                notice_map_edited.enabled = false;
            }

            Image{
                id: image_logo
                width: 748/2
                height: 335/2
                anchors.top: parent.top
                anchors.topMargin: 80
                anchors.horizontalCenter: parent.horizontalCenter
                source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
            }

            Text{
                id: text_notice
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: image_logo.bottom
                horizontalAlignment: Text.AlignHCenter
                anchors.topMargin: 100
                text: "맵 파일을 찾을 수 없습니다.";
                font.pixelSize: 20
            }

            Row{
                spacing: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_notice.bottom
                anchors.topMargin: 200
                Rectangle{
                    id: btn_server_load
                    width: 200
                    height: 150
                    radius: 15
                    enabled: supervisor.isConnectServer()
                    color: enabled?"gray":"#DDDDDD"
                    Text{
                        anchors.centerIn: parent
                        text: "서버에서 받아오기"
                        font.pixelSize: 20
                        color:enabled?"black":"white"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.loadMaptoServer();
                            update_timer.start();
                        }
                    }
                }
                Rectangle{
                    id: btn_slam_start
                    width: 200
                    height: 150
                    radius: 15
                    enabled: true//supervisor.getLCMConnection()
                    color: enabled?"gray":"#DDDDDD"
                    Text{
                        anchors.centerIn: parent
                        text: "맵 생성"
                        font.pixelSize: 20
                        color:enabled?"black":"white"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            loadPage(pmapinit);
                            loader_page.item.map_mode = 1;
    //                        supervisor.startSLAM();
                        }
                    }
                }
                Rectangle{
                    id: btn_usb_load
                    width: 200
                    height: 150
                    radius: 15
                    enabled: supervisor.getUsbMapSize()>0?true:false
                    color: enabled?"gray":"#DDDDDD"
                    Text{
                        anchors.centerIn: parent
                        text: "로컬 맵 불러오기\n(USB)"
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        color:enabled?"black":"white"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            popup_usb_map.open();
    //                        supervisor.loadMaptoUSB();
    //                        update_timer.start();
                        }
                    }
                }
            }

            Rectangle{
                id: notice_map_edited
                width: 180
                height: 50
                color: "red"
                enabled: false
                anchors.right: parent.right
                visible: (y<300)?true:false
                y: enabled?200:800
                Behavior on y{
                    SpringAnimation{
                        duration: 1000
                        spring: 1
                        damping: 0.2
                    }
                }

                Rectangle{
                    width: 40
                    height: parent.height
                    radius: 10
                    anchors.horizontalCenter: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    color: parent.color

                    Image{
                        width: 30
                        height: 30
                        anchors.centerIn: parent
                        source: "image/warning.png"
                    }
                }
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 30
                    color: "white"
                    text: "로컬 맵 파일 확인됨"
                    font.bold: true
                    font.pixelSize: 15
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        popup_show_map.show_mode = 1;
                        popup_show_map.open();
                    }
                }
            }
            Rectangle{
                id: notice_map_raw
                width: 180
                height: 50
                color: "red"
                enabled: false
                anchors.right: parent.right
                visible: (y<400)?true:false
                y: enabled?300:800
                Behavior on y{
                    SpringAnimation{
                        duration: 1000
                        spring: 1
                        damping: 0.2
                    }
                }

                Rectangle{
                    width: 40
                    height: parent.height
                    radius: 10
                    anchors.horizontalCenter: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    color: parent.color

                    Image{
                        width: 30
                        height: 30
                        anchors.centerIn: parent
                        source: "image/warning.png"
                    }
                }
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 30
                    color: "white"
                    text: "설정되지 않은 맵 파일 확인됨"
                    font.bold: true
                    font.pixelSize: 10
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        popup_show_map.show_mode = 2;
                        popup_show_map.open();
                    }
                }
            }

        }

    }

    //ini파일을 찾을 수 없을 때
    Component{
        id: item_ini_init
        Item{
            objectName: "init_ini"
            anchors.fill: parent
            Component.onCompleted: {
                statusbar.visible = true;
            }

            Image{
                id: image_logo2
                width: 748/2
                height: 335/2
                anchors.top: parent.top
                anchors.topMargin: 80
                anchors.horizontalCenter: parent.horizontalCenter
                source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
            }

            Text{
                id: text_notice2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: image_logo2.bottom
                horizontalAlignment: Text.AlignHCenter
                anchors.topMargin: 100
                text: "로봇 세팅파일을 찾을 수 없습니다."
                font.pixelSize: 20
            }

            Rectangle{
                id: btn_make_ini
                width: 200
                height: 150
                radius: 15
                color: "gray"
                anchors.top: text_notice2.bottom
                anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    anchors.centerIn: parent
                    text: "기본내용으로 만들기"
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        supervisor.makeRobotINI();
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

            Image{
                id: image_logo3
                width: 748/2
                height: 335/2
                anchors.top: parent.top
                anchors.topMargin: 80
                anchors.horizontalCenter: parent.horizontalCenter
                source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
            }

            Text{
                id: text_notice3
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: image_logo3.bottom
                horizontalAlignment: Text.AlignHCenter
                anchors.topMargin: 100
                text: "로봇과 연결이 되지 않습니다."
                font.pixelSize: 20
            }

            Rectangle{
                id: btn_lcm_pass
                width: 200
                height: 150
                radius: 15
                color: "gray"
                anchors.top: text_notice3.bottom
                anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    anchors.centerIn: parent
                    text: "넘어가기(디버그용)"
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        loadPage(pkitchen);
                        update_timer.stop();
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

            SequentialAnimation{
                id: ani_do_init
                running: false
                onStarted: {
                    text_slaminimize.visible = false;
                    text_slam_pass.visible = false;
                }

                ParallelAnimation{
                    NumberAnimation{target: btn_slam_minimize; property:"width"; from:200; to:50; duration: 500;}
                    NumberAnimation{target: btn_slam_minimize; property:"height"; from:150; to:50; duration: 500;}
                    NumberAnimation{target: btn_slam_minimize; property:"radius"; from:15; to:50; duration: 500;}
                    NumberAnimation{target: btn_slam_pass; property:"width"; from:200; to:50; duration: 500;}
                    NumberAnimation{target: btn_slam_pass; property:"height"; from:150; to:50; duration: 500;}
                    NumberAnimation{target: btn_slam_pass; property:"radius"; from:15; to:50; duration: 500;}
                    NumberAnimation{target: btn_slam_do_init; property:"opacity"; from:1; to:0; duration: 500;}
                }
                ParallelAnimation{
                    NumberAnimation{target: image_logo4; property:"anchors.topMargin"; from:80; to:-200; duration: 500;}
                    NumberAnimation{target: btn_slam_minimize; property:"anchors.rightMargin"; from:50; to:400; duration: 500;}
                    NumberAnimation{target: btn_slam_minimize; property:"anchors.topMargin"; from:50; to:-100; duration: 500;}
                    NumberAnimation{target: btn_slam_pass; property:"anchors.leftMargin"; from:50; to:400; duration: 500;}
                    NumberAnimation{target: btn_slam_pass; property:"anchors.topMargin"; from:50; to:-100; duration: 500;}
                }
                onFinished: {
                    btn_slam_do_init.visible = false;
                    map_slam_init.visible = true;
                }
            }
            SequentialAnimation{
                id: ani_do_init_return
                running: false
                onStarted: {
                    btn_slam_do_init.visible = true;
                    map_slam_init.visible = false;
                }

                ParallelAnimation{
                    NumberAnimation{target: image_logo4; property:"anchors.topMargin"; from:-200; to:80; duration: 500;}
                    NumberAnimation{target: btn_slam_minimize; property:"anchors.rightMargin"; from:-500; to:30; duration: 500;}
                    NumberAnimation{target: btn_slam_minimize; property:"anchors.topMargin"; from:-50; to:50; duration: 500;}
                }
                ParallelAnimation{
                    NumberAnimation{target: btn_slam_minimize; property:"width"; from:50; to:200; duration: 500;}
                    NumberAnimation{target: btn_slam_minimize; property:"height"; from:50; to:150; duration: 500;}
                    NumberAnimation{target: btn_slam_minimize; property:"radius"; from:50; to:15; duration: 500;}
                    NumberAnimation{target: btn_slam_do_init; property:"opacity"; from:0; to:1; duration: 500;}
                }
                onFinished: {
                    text_slaminimize.visible = true;
                    text_slam_pass.visible = true;
                }
            }

            Image{
                id: image_logo4
                width: 748/2
                height: 335/2
                anchors.top: parent.top
                anchors.topMargin: 80
                anchors.horizontalCenter: parent.horizontalCenter
                source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
            }

            Text{
                id: text_notice4
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: image_logo4.bottom
                horizontalAlignment: Text.AlignHCenter
                anchors.topMargin: 100
                text: "SLAM 자동 초기화에 실패하였습니다.\n맵 상에서 로봇의 현재 위치를 바로 잡아주신 뒤 수동으로 초기화를 진행해 주세요."
                font.pixelSize: 20
            }
            Rectangle{
                id: btn_slam_minimize
                width: 200
                height: 150
                radius: 15
                color: "gray"
                anchors.right: btn_slam_do_init.left
                anchors.rightMargin: 30
                anchors.top: text_notice4.bottom
                anchors.topMargin: 50
                Text{
                    id: text_slaminimize
                    anchors.centerIn: parent
                    text: "창 최소화"
                    font.pixelSize: 20
                    color:"white"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mainwindow.showMinimized()
                    }
                }
            }
            Rectangle{
                id: btn_slam_do_init
                width: 200
                height: 150
                radius: 15
                color: "gray"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_notice4.bottom
                anchors.topMargin: 50
                Text{
                    id: text_slam_do_init
                    anchors.centerIn: parent
                    text: "UI에서 직접 초기화"
                    font.pixelSize: 20
                    color:"white"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        ui_slam_init = true;

                    }
                }
            }
            Rectangle{
                id: btn_slam_pass
                width: 200
                height: 150
                radius: 15
                color: "gray"
                anchors.left: btn_slam_do_init.right
                anchors.leftMargin: 30
                anchors.top: text_notice4.bottom
                anchors.topMargin: 50
                Text{
                    id: text_slam_pass
                    anchors.centerIn: parent
                    text: "넘어가기 (디버그 용)"
                    font.pixelSize: 20
                    color:"white"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        loadPage(pkitchen);
    //                    update_timer.stop();
                    }
                }
            }

            Map_full{
                id: map_slam_init
                width: 600
                height: 600
                visible: false
                show_object: true
                show_robot: true
                show_lidar: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_notice4.bottom
                anchors.topMargin: 50
            }
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
                        supervisor.writelog("[QML - ERROR] robot.ini not found.");
                    }
                }
            //체크 : 맵 파일 존재여부 및 설정
            }else if(init_mode == 1){
                //supervisor가 ini파일을 성공적으로 읽었을 때까지 대기
                if(supervisor.getIniRead()){

                    //map존재여부 확인 -> 0: 아무것도 없음, 1: 서버맵파일 확인 됨, 2: 로컬맵파일 확인 됨, 3: 로컬맵(설정안됨) 확인 됨
                    var map_exist = supervisor.isExistMap();

                    //이미 설정확인된 맵이 존재한다면 다음으로 넘어감
                    if(supervisor.isloadMap() || map_exist == 1){
                        if(supervisor.isuseServerMap()){
                            setMapPath("file://" + applicationDirPath + "/image/map_rotated.png","map_rotated.png");
                        }else{
                            setMapPath("file://" + applicationDirPath + "/image/map_edited.png","map_edited.png");
                        }
                        supervisor.make_minimap();
                        init_mode = 2;
                    }else{
                        if(loader_init.item.objectName != "init_map"){
                            loader_init.sourceComponent = item_map_init
                        }

                        if(map_exist == 1){
                            //Map Exist!!!!
                            print("map find!!");
                            notice_map_raw.enabled = false;
                            notice_map_edited.enabled = false;
                            update_timer.stop();
                            popup_show_map.show_mode = 0;
                            popup_show_map.open();
                        }else{
                            if(map_exist== 2){
                                //show map_edited exist
                                loader_init.item.disable_rawmap();
                                loader_init.item.enable_editedmap();
                            }else if(map_exist == 3){
                                //show raw_map exist
                                loader_init.item.enable_rawmap();
                                loader_init.item.disable_editedmap();
                            }else{
                                loader_init.item.disable_rawmap();
                                loader_init.item.disable_editedmap();
                            }
                        }
                    }
                }
            }else if(init_mode == 2){
                if(supervisor.getLCMConnection()){
                    init_mode = 3;
                }else{
                    if(loader_init.item.objectName != "init_lcm")
                        loader_init.sourceComponent = item_lcm
                }
            }else if(init_mode == 3){
                if(supervisor.getRobotState() == 0){
                    if(loader_init.item.objectName != "init_slam")
                        loader_init.sourceComponent = item_slam_init
                }else{
                    init_mode = 4;
                    update_timer.stop();
                    loadPage(pkitchen);

                }
            }
            }

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
                focus: true
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
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            for(var i=0; i<supervisor.getUsbMapSize(); i++){
                                print(i,list_map_usb.model.get(i).selected,list_map_usb.model.get(i).name);
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
                color: "lightsteelblue"
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
        anchors.centerIn: parent
        property string map: ""
        onOpened: {
            map_load2.just_show_map = true;
            map_load2.loadmap("file:/" + map);
        }
        Map_full{
            id: map_load2
            anchors.fill: parent
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
        property int show_mode: 0 //0: server 1: edited 2: raw 3:just map
        onOpened: {
            map_load.just_show_map = true;
            if(show_mode == 0){
                text_show_popup.text = "서버로부터 맵을 로드했습니다.\n 매장의 환경과 일치하는 맵인지 확인해주세요."
                map_load.loadmap("file://"+applicationDirPath+"/image/map_rotated.png");
                map_load.show_object = true;
                map_load.show_location = true;
            }else if(show_mode == 1){
                text_show_popup.text = "저장된 맵을 로드했습니다.\n 매장의 환경과 일치하는 맵인지 확인해주세요.\n 맵이 일치하지 않다면 [맵 삭제] 버튼을, 오브젝트나 로케이션을 수정하길 원하시면 [맵 수정] 버튼을 눌러주세요."
                map_load.loadmap("file://"+applicationDirPath+"/image/map_edited.png");
                map_load.show_object = true;
                map_load.show_location = true;
            }else{
                text_show_popup.text = "저장된 맵을 로드했습니다.\n 매장의 환경과 일치하는 맵이면 [맵 수정] 버튼을, 일치하지 않다면 [맵 삭제] 버튼을 눌러주세요.";
                map_load.loadmap("file://"+applicationDirPath+"/image/map_raw.png");
                map_load.init_mode();
            }
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
            width: 500
            height: 500
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: text_show_popup.bottom
            anchors.topMargin: 30
            just_show_map: true
        }
        Row{
            id: row_button_2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: map_load.bottom
            anchors.topMargin: 30
            spacing: 30
            Repeater{
                model:{
                    if(popup_show_map.show_mode == 0){
                        ["맵 사용","맵 사용안함"]
                    }else if(popup_show_map.show_mode == 1){
                        ["맵 사용","맵 수정","맵 삭제"]
                    }else if(popup_show_map.show_mode == 2){
                        ["맵 수정","맵 삭제"]
                    }
                }
                Rectangle{
                    id: btn
                    width: 150
                    height: 70
                    radius: 15
                    color: "#D0D0D0"
                    Text{
                        anchors.centerIn: parent
                        text: modelData
                        font.pixelSize: 20
                        font.family: font_noto_b.name
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(modelData == "맵 사용"){
                                if(popup_show_map.show_mode == 0){
                                    print("server use");
                                    popup_show_map.close();
                                    supervisor.setuseServerMap(true);
                                    supervisor.make_minimap();
                                    setMapPath("file://" + applicationDirPath + "/image/map_rotated.png", "map_rotated.png")
                                    supervisor.setloadMap(true);
                                }else{
                                    popup_show_map.close();
                                    supervisor.setuseServerMap(false);
                                    supervisor.make_minimap();
                                    setMapPath("file://" + applicationDirPath + "/image/map_edited.png", "map_edited.png")
                                    supervisor.setloadMap(true);
                                }
                                init_mode = 2;
                            }else if(modelData == "맵 수정"){
                                statusbar.visible = true;
                                if(popup_show_map.show_mode == 1){
                                    popup_show_map.close();
                                    setMapPath("file://" + applicationDirPath + "/image/map_edited.png", "map_edited.png")
                                    loadPage(pmapinit);
                                    loader_page.map_mode = 2;
                                }else if(popup_show_map.show_mode == 2){
                                    popup_show_map.close();
                                    setMapPath("file://" + applicationDirPath + "/image/map_raw.png", "map_raw.png")
                                    loadPage(pmapinit);
                                    loader_page.item.map_mode = 2;
                                    loader_page.item.init();
                                }
                            }else if(modelData == "맵 삭제"){
                                if(popup_show_map.show_mode == 1){
                                    supervisor.removeEditedMap();
                                    popup_show_map.close();
                                }else{
                                    supervisor.removeRawMap();
                                    popup_show_map.close();
                                }
                            }else if(modelData == "맵 사용안함"){
                                supervisor.removeServerMap();
                                popup_show_map.close();
                            }
                            update_timer.start();
                        }
                    }
                }
            }


        }
    }
}
