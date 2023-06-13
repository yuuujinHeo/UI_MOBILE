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
    id: page_annotation
    objectName: "page_annotation"
    width: 1280
    height: 800
    property bool test: false
    property var last_robot_x: supervisor.getOrigin()[0]
    property var last_robot_y: supervisor.getOrigin()[1]
    property var last_robot_th: 0
    //0 none 1 moving 2 movefail
    property var test_move_state: 0
    property var test_move_error: 0
    property bool annotation_after_mapping: false


    onTest_move_stateChanged: {
        print("test move state changed : ",test_move_state);
    }

    function setMappingFlag(){
        print("setmappingflag")
        annotation_after_mapping = true;
        annot_pages.sourceComponent = page_annot_start;
        loading.hide();
    }

    function init(){
        test_move_state = 0;
    }
    function movestart(){
        test_move_state = 1;
    }
    function movedone(){
        test_move_state = 0;
    }
    function movefail(errnum){
        test_move_state = 2;
        test_move_error = errnum;

    }
    Component.onCompleted: {
        print("annotaiton completed");
        if(annotation_after_mapping){
            annot_pages.sourceComponent = page_annot_start;
        }else{
            if(supervisor.getLocalizationState() === 2){
                annot_pages.sourceComponent = page_annot_menu;
            }else{
                annot_pages.sourceComponent = page_annot_localization;
            }
        }


//        annot_pages.sourceComponent = page_annot_travelline;
    }

    Loader{
        id: annot_pages
        width: 1280
        height: 800 - statusbar.height
        anchors.bottom: parent.bottom
        clip: true
        sourceComponent: page_annot_start
    }

    Component{
        id: page_annot_menu
        Item{
            width: annot_pages.width
            height: annot_pages.height
            property var local_find_state: 0
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Component.onCompleted: {
                supervisor.setMotorLock(true);
            }
            Text{
                id: text_title1
                text: "맵을 수정합니다."
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
                font.family: font_noto_b.name
            }
            Text{
                id: text_title12
                text: "수정하실 단계를 선택하여 진행해주세요."
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 40
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_title1.bottom
                font.family: font_noto_b.name
            }
            Grid{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_title12.bottom
                anchors.topMargin: 50
                spacing: 30
                horizontalItemAlignment: Grid.AlignHCenter
                verticalItemAlignment: Grid.AlignVCenter
                rows: 2
                columns: 3
                Rectangle{
                    width: 220
                    height: 150
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    color: "transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        text: "이전세팅 초기화\n다시 세팅"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            supervisor.writelog("[ANNOTATION] MENU : Clear and New Annotation");
                            annot_pages.sourceComponent = page_annot_start;
                            annotation_after_mapping = true;
                            parent.color = "transparent";
                        }
                    }
                }
                Rectangle{
                    width: 220
                    height: 150
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    color: "transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        text: "맵 회전\n잘라내기"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            supervisor.writelog("[ANNOTATION] MENU : Rotate / Cut Map");
                            annot_pages.sourceComponent = page_annot_start;
                            parent.color = "transparent";
                        }
                    }
                }
                Rectangle{
                    width: 220
                    height: 150
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    color: "transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        text: "충전위치\n변경"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            supervisor.writelog("[ANNOTATION] MENU : Change Charging Location");
                            annot_pages.sourceComponent = page_annot_location_charging;
                            parent.color = "transparent";
                        }
                    }
                }
                Rectangle{
                    width: 220
                    height: 150
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    color: "transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        text: "대기위치\n변경"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            supervisor.writelog("[ANNOTATION] MENU : Change Resting Location");
                            annot_pages.sourceComponent = page_annot_location_resting;
                            parent.color = "transparent";
                        }
                    }
                }
                Rectangle{
                    width: 220
                    height: 150
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    color: "transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        text: "서빙위치\n변경"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            supervisor.writelog("[ANNOTATION] MENU : Change Serving Location");
                            annot_pages.sourceComponent = page_annot_location_serving_done;
                            parent.color = "transparent";
                        }
                    }
                }
                Rectangle{
                    width: 220
                    height: 150
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    color: "transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        text: "추가 설정"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            supervisor.writelog("[ANNOTATION] MENU : Additional menu");
                            annot_pages.sourceComponent = page_annot_additional_menu;
                            parent.color = "transparent";
                        }
                    }
                }
            }

            Rectangle{
                id: btn_right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "종 료"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[ANNOTATION] All Done");
                        backPage();
                        parent.color = "transparent";
                    }
                }
            }
        }

    }

    Component{
        id: page_annot_start
        Item{
            width: annot_pages.width
            height: annot_pages.height
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Component.onCompleted: {
                supervisor.setMotorLock(true);
            }
            Timer{
                interval: 500
                running: true
                onTriggered:{
                    map.setViewer("annot_rotate");
                    map.setTool("move");
                    map.clear("rotate")
                    map.setEnable(true);
                    if(annotation_after_mapping)
                        map.loadmap(supervisor.getMapname(),"RAW");
                    else
                        map.loadmap(supervisor.getMapname(),"EDITED");
                }
            }
            Text{
                text: "맵을 회전하고 맵의 영역만큼 지정해주세요."
                color: "white"
                font.pixelSize: 40
                font.family: font_noto_b.name
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image{
                source: "icon/btn_reset.png"
                width: 80
                height: 80
                anchors.verticalCenter: map.verticalCenter
                anchors.right: map.left
                anchors.rightMargin: 30
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
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
            Image{
                source: "icon/btn_reset.png"
                width: 80
                height: 80
                transform: Scale{xScale:-1}
                anchors.verticalCenter: map.verticalCenter
                anchors.left: map.right
                anchors.leftMargin: 30+width
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
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

            Timer{
                id: timer_rotate
                running: false
                repeat: true
                interval: 100
                property bool isplus: false
                onTriggered: {
                    if(isplus){
                        map.rotate("cw");
                    }else{
                        map.rotate("ccw");
                    }
                }
            }
            Map_full{
                id: map
                enabled: false
                objectName: "annot_rotate"
                width: 580
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 120
            }
            Rectangle{
                id: btn_right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "저 장"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        map.save("rotate");
                        supervisor.writelog("[ANNOTATION] Rotate, Cut : done and save.")
                        if(annotation_after_mapping)
                            annot_pages.sourceComponent = page_annot_localization;
                        else
                            annot_pages.sourceComponent = page_annot_menu;

                        supervisor.slam_map_reload(supervisor.getMapname());
                        parent.color = "transparent";
                    }
                }
            }
            Rectangle{
                id: btn_left
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: 50
                anchors.leftMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "초기화"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        map.clear("rotate");
                        parent.color = "transparent";
                    }
                }
            }

        }
    }
    Component{
        id: page_annot_localization
        Item{
            width: annot_pages.width
            height: annot_pages.height
            property var local_find_state: 0
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Component.onCompleted: {
                supervisor.setMotorLock(true);
                loading.show();
                text_finding.opacity = 1;
            }
            Timer{
                interval: 500
                running: true
                onTriggered:{
                    map.loadmap(supervisor.getMapname(),"EDITED");
                    map.setViewer("localization");
                }
            }

            Timer{
                id: timer_check_localization2
                running: false
                repeat: true
                interval: 500
                onTriggered: {
                    if(test){
                        btn_right2.enabled = true;
                    }else{
                        if(supervisor.getLocalizationState() === 2){//success
                            btn_right2.enabled = true;
                        }else{
                            btn_right2.enabled = false;
                        }
                    }

                }
            }
            Timer{
                id: timer_check_localization
                running: true
                repeat: true
                interval: 500
                onTriggered: {
                    if(test){
                        local_find_state = 2;
                        loading.hide();
                        timer_check_localization.stop();
                    }else{
                        local_find_state = supervisor.getLocalizationState();
                        if(local_find_state===0){//not ready
                            supervisor.slam_autoInit();
                        }else if(local_find_state === 2){//success
                            loading.hide();
                            timer_check_localization.stop();
                            map.setViewer("local_view");
                        }else if(local_find_state === 3){//failed
                            loading.hide();
                            timer_check_localization2.start();
                            timer_check_localization.stop();
                            map.setViewer("localization");
                        }

                        if(!supervisor.getLCMConnection()){
                            local_find_state = 10;
                            timer_check_localization.stop();
                        }
                    }

                }
            }

            Text{
                id: text_finding
                visible: local_find_state<2
                text: "로봇의 위치를 찾고 있습니다."
                color: "white"
                opacity: 0
                Behavior on opacity {
                    NumberAnimation{
                        duration : 500
                    }
                }
                font.pixelSize: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 140
                font.family: font_noto_b.name
            }
            Text{
                id: text_failed_connection
                visible: local_find_state===10
                text: "로봇과 연결이 되지 않았습니다."
                color: "white"
                font.pixelSize: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 140
                font.family: font_noto_b.name
            }
            Text{
                id: text_find
                visible: local_find_state===2||local_find_state===3
                text:local_find_state===2?"로봇의 위치를 찾았습니다. 로봇의 위치가 정확합니까?":"로봇의 위치를 찾을 수 없습니다. 로봇의 위치를 맵 상에서 표시해주세요."
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 30
                color: "white"
                font.family: font_noto_b.name
            }
            Column{
                anchors.right: map.left
                anchors.rightMargin: 30
                anchors.verticalCenter: map.verticalCenter
                spacing: 50
                Rectangle{
                    visible: local_find_state===3
                    width: 200
                    height: 80
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    color: map.tool==="move"?color_green:"transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        horizontalAlignment: Text.AlignHCenter
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        color: "white"
                        text: "이 동"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            print("move");
                            map.setTool("move");
                        }
                    }
                }
                Rectangle{
                    visible: local_find_state===3
                    width: 200
                    height: 80
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    color: map.tool==="slam_init"?color_green:"transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        horizontalAlignment: Text.AlignHCenter
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        color: "white"
                        text: "로봇위치\n표 시"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            print("slam init");
                            map.setTool("slam_init");
                            supervisor.setInitCurPos();
                            supervisor.slam_setInit();
                        }
                    }
                }
            }

            Map_full{
                id: map
                objectName: "annot_local"
                visible: local_find_state>1
                onVisibleChanged: {
                    print("map visible changed",visible,x,y,width,height);
                }
                anchors.top: text_find.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                width: 600
                height: 600
            }
            Rectangle{
                id: btn_right
                visible: local_find_state===2
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "일치 합니다"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[ANNOTATION] Localization : Success");
                        if(annotation_after_mapping)
                            annot_pages.sourceComponent = page_annot_location_charging;
                        else
                            annot_pages.sourceComponent = page_annot_menu;
                        parent.color = "transparent";
                    }
                }
            }
            Rectangle{
                id: btn_right2
                visible: local_find_state===3
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                enabled: false
                border.color: "white"
                color: enabled?"transparent":color_mid_gray
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "확 인"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[ANNOTATION] Localization : Success");
                        if(annotation_after_mapping)
                            annot_pages.sourceComponent = page_annot_location_charging;
                        else
                            annot_pages.sourceComponent = page_annot_menu;
                        parent.color = "transparent";
                    }
                }
            }
            Rectangle{
                id: btn_right3
                visible: local_find_state===10
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                enabled: false
                border.color: "white"
                color: enabled?"transparent":color_mid_gray
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "프로그램 다시시작"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[ANNOTATION] Localization : Connection Failed. Restart");
                        supervisor.programRestart();
                        parent.color = "transparent";
                    }
                }
            }
            Rectangle{
                id: btn_left
                visible: local_find_state===2
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: 50
                anchors.leftMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "틀립니다.\n(수동초기화)"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[ANNOTATION] Localization : Failed")
                        local_find_state = 3;
                        timer_check_localization2.start();
                        parent.color = "transparent";
                    }
                }
            }
        }
    }
    Component{
        id: page_annot_location_charging
        Item{
            width: annot_pages.width
            height: annot_pages.height
            Component.onCompleted: {
                supervisor.setMotorLock(false);
            }

            Timer{
                running: true
                interval: 500
                onTriggered:{
                    supervisor.drawingRunawayStart();
                }
            }

            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Column{
                id: col
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 80
                spacing: 30
                Text{
                    text: "로봇을 충전위치로 이동시켜주세요"
                    color: "white"
                    font.pixelSize: 80
                    font.family: font_noto_b.name
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Column{
                    Text{
                        text: "* 충전위치란?"
                        color: color_green
                        font.bold: true
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        font.family: font_noto_r.name
                    }
                    Text{
                        text: "로봇이 비 운영 중에 충전을 위해 서 있는 장소입니다."
                        color: "white"
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        font.family: font_noto_r.name
                    }
                    Text{
                        text: "충전기가 꼽혀있는 콘센트 주변으로 지정해주세요."
                        color: "white"
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        font.family: font_noto_r.name
                    }
                }
            }

            AnimatedImage{
                id: image_robotmoving
                source: "image/robot_manual.gif"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                width: 1280/1.5
                height: 800/1.5
                speed: 0.5
                anchors.bottomMargin: -100
            }

            Rectangle{
                id: btn_right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "이동했습니다."
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[ANNOTATION] LOCAION SAVE : Charging "+Number(supervisor.getlastRobotx())+", "+Number(supervisor.getlastRoboty())+", "+Number(supervisor.getlastRobotth()));
                        annot_pages.sourceComponent = page_annot_location_charging_done;
                        parent.color = "transparent";
                    }
                }
            }
        }
    }
    Component{
        id: page_annot_location_charging_done
        Item{
            width: annot_pages.width
            height: annot_pages.height
            Component.onCompleted: {
                supervisor.setMotorLock(false);
                map_hide.savelocation("location_cur","Charging", 0, "Charging");
//                loading.show();
            }
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Text{
                text: "로봇의 충전위치를 저장했습니다."
                color: "white"
                font.pixelSize: 80
                font.family: font_noto_b.name
                anchors.centerIn: parent
            }
            Rectangle{
                id: btn_left
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: 50
                anchors.leftMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "다시 지정"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[Annotation] Location Save : Charging -> Canceled");
                        annot_pages.sourceComponent = page_annot_location_charging;
                        parent.color = "transparent";
                    }
                }
            }

            Rectangle{
                id: btn_right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "다음으로"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[Annotation] Location Save : Charging -> Done");
                        if(annotation_after_mapping)
                            annot_pages.sourceComponent = page_annot_location_resting;
                        else
                            annot_pages.sourceComponent = page_annot_location_test_1;
                        parent.color = "transparent";
                    }
                }
            }
        }
    }
    Component{
        id: page_annot_location_resting
        Item{
            width: annot_pages.width
            height: annot_pages.height
            Component.onCompleted: {
                supervisor.setMotorLock(false);
            }

            Timer{
                running: true
                interval: 500
                onTriggered:{
                    supervisor.drawingRunawayStart();
                }
            }

            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Column{
                id: col
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 80
                spacing: 30
                Text{
                    text: "로봇을 대기위치로 이동시켜주세요"
                    color: "white"
                    font.pixelSize: 80
                    font.family: font_noto_b.name
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Column{
                    Text{
                        text: "* 대기위치란?"
                        color: color_green
                        font.bold: true
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        font.family: font_noto_r.name
                    }
                    Text{
                        text: "로봇이 서빙을 시작하기 전, 음식을 받기 위해 기다리는 장소입니다."
                        color: "white"
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        font.family: font_noto_r.name
                    }
                    Text{
                        text: "주방에서 음식을 올리기 편한 위치로 지정해주세요."
                        color: "white"
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        font.family: font_noto_r.name
                    }
                }
            }

            AnimatedImage{
                id: image_robotmoving
                source: "image/robot_manual.gif"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                width: 1280/1.5
                height: 800/1.5
                speed: 0.5
                anchors.bottomMargin: -100
            }

            Rectangle{
                id: btn_right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "이동했습니다."
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[ANNOTATION] LOCAION SAVE : Resting "+Number(supervisor.getlastRobotx())+", "+Number(supervisor.getlastRoboty())+", "+Number(supervisor.getlastRobotth()));
                        annot_pages.sourceComponent = page_annot_location_resting_done;
                        parent.color = "transparent";
                    }
                }
            }
        }
    }
    Component{
        id: page_annot_location_resting_done
        Item{
            width: annot_pages.width
            height: annot_pages.height
            Component.onCompleted: {
                supervisor.setMotorLock(false);
                map_hide.savelocation("location_cur","Resting", 0, "Resting");
//                loading.show();
            }
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Text{
                text: "로봇의 대기위치를 저장했습니다."
                color: "white"
                font.pixelSize: 80
                font.family: font_noto_b.name
                anchors.centerIn: parent
            }
            Rectangle{
                id: btn_left
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: 50
                anchors.leftMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "다시 지정"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[Annotation] Location Save : Resting -> Canceled");
                        annot_pages.sourceComponent = page_annot_location_resting;
                        parent.color = "transparent";
                    }
                }
            }

            Rectangle{
                id: btn_right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "다음으로"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[Annotation] Location Save : Resting -> Done");
                        annot_pages.sourceComponent = page_annot_location_test_1;
                        parent.color = "transparent";
                    }
                }
            }
        }
    }
    Component{
        id: page_annot_location_test_1
        Item{
            width: annot_pages.width
            height: annot_pages.height
            Component.onCompleted: {
                supervisor.setMotorLock(true);
            }
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Text{
                text: "충전 위치와 대기 위치 사이의 이동을 확인합니다."
                color: "white"
                font.pixelSize:60
                font.family: font_noto_b.name
                anchors.top: parent.top
                anchors.topMargin: 80
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Row{
                anchors.centerIn: parent
                spacing: 100
                visible:test_move_state===0
                Rectangle{
                    id: btn_charge
                    width: 240
                    height: 140
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    color: "transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        color: "white"
                        text: "충전 위치로"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            supervisor.writelog("[Annotation] Location Test : go Charging");
                            supervisor.moveToCharge();
                            parent.color = "transparent";
                        }
                    }
                }
                Rectangle{
                    id: btn_rest
                    width: 240
                    height: 140
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    color: "transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        color: "white"
                        text: "대기 위치로"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            supervisor.writelog("[Annotation] Location Test : go Resting");
                            supervisor.moveToWait();
                            parent.color = "transparent";
                        }
                    }
                }
            }

            Rectangle{
                id: notice_moving
                width: parent.width
                height: 250
                anchors.centerIn: parent
                color: "black"
                visible: test_move_state!==0
                Text{
                    anchors.centerIn: parent
                    visible: test_move_state === 1
                    text: "로봇이 이동 중 입니다."
                    color: "white"
                    font.pixelSize:60
                    font.family: font_noto_b.name
                }
                Text{
                    id: text_error_msg
                    anchors.centerIn: parent
                    visible: test_move_state === 2
                    color: color_red
                    text: {
                        if(test_move_error === 0){
                            "경로를 찾을 수 없습니다."
                        }else if(test_move_error === 1){
                            "로봇의 초기화가 틀어졌습니다."
                        }else if(test_move_error === 2){
                            "비상스위치가 눌렸습니다."
                        }else if(test_move_error === 3){
                            "사용자에 의해 정지되었습니다."
                        }else if(test_move_error === 4){
                            "모터가 초기화 되지 않았습니다."
                        }
                    }
                    font.pixelSize:60
                    font.family: font_noto_b.name
                }
            }

            Rectangle{
                id: btn_left
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: 50
                anchors.leftMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "대기위치 다시 지정"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[Annotation] Location Save : Resting -> Canceled");
                        annot_pages.sourceComponent = page_annot_location_resting;
                        parent.color = "transparent";
                    }
                }
            }
            Rectangle{
                id: btn_left2
                anchors.bottom: btn_left.top
                anchors.left: parent.left
                anchors.bottomMargin: 20
                anchors.leftMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "충전위치 다시 지정"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[Annotation] Location Save : Charging -> Canceled");
                        annot_pages.sourceComponent = page_annot_location_charging;
                        parent.color = "transparent";
                    }
                }
            }

            Rectangle{
                id: btn_right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: annotation_after_mapping?"다음으로":"확 인"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[Annotation] Location Test : Done");
                        if(annotation_after_mapping)
                            annot_pages.sourceComponent = page_annot_location_go_resting;
                        else
                            annot_pages.sourceComponent = page_annot_menu;
                        parent.color = "transparent";
                    }
                }
            }
        }
    }
    Component{
        id: page_annot_location_go_resting
        Item{
            width: annot_pages.width
            height: annot_pages.height
            Component.onCompleted: {
                supervisor.setMotorLock(true);
            }

            Timer{
                running: true
                interval: 500
                onTriggered:{
                    supervisor.drawingRunawayStart();
                }
            }
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Text{
                text: "지금부터 서빙위치를 지정하겠습니다.\n로봇을 대기위치로 이동시켜주세요."
                color: "white"
                font.pixelSize:60
                horizontalAlignment: Text.AlignHCenter
                font.family: font_noto_b.name
                anchors.top: parent.top
                anchors.topMargin: 80
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle{
                id: btn_rest
                width: 240
                height: 140
                radius: 15
                border.width: 2
                border.color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 100
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "대기 위치로"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[Annotation] Location Test : go Resting");
                        supervisor.moveToWait();
                        parent.color = "transparent";
                    }
                }
            }

            Rectangle{
                id: notice_moving
                width: parent.width
                height: 250
                anchors.centerIn: parent
                color: "black"
                visible: test_move_state!==0
                Text{
                    anchors.centerIn: parent
                    visible: test_move_state === 1
                    text: "로봇이 이동 중 입니다."
                    color: "white"
                    font.pixelSize:60
                    font.family: font_noto_b.name
                }
                Text{
                    id: text_error_msg
                    anchors.centerIn: parent
                    visible: test_move_state === 2
                    color: color_red
                    text: {
                        if(test_move_error === 0){
                            "경로를 찾을 수 없습니다."
                        }else if(test_move_error === 1){
                            "로봇의 초기화가 틀어졌습니다."
                        }else if(test_move_error === 2){
                            "비상스위치가 눌렸습니다."
                        }else if(test_move_error === 3){
                            "사용자에 의해 정지되었습니다."
                        }else if(test_move_error === 4){
                            "모터가 초기화 되지 않았습니다."
                        }
                    }
                    font.pixelSize:60
                    font.family: font_noto_b.name
                }
            }

            Rectangle{
                id: btn_right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "로봇이 대기위치입니다"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[Annotation] Location Test : Resting -> Done");
                        annot_pages.sourceComponent = page_annot_location_serving;
                        parent.color = "transparent";
                    }
                }
            }
        }
    }
    Component{
        id: page_annot_location_serving
        Item{
            width: annot_pages.width
            height: annot_pages.height
            Component.onCompleted: {
                supervisor.setMotorLock(false);
            }

            Timer{
                running: true
                interval: 500
                onTriggered:{
                    supervisor.drawingRunawayStart();
                }
            }

            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Column{
                id: col
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 30
                Text{
                    text: "로봇을 각 테이블의 서빙위치로 이동시켜주신 후\n저장 버튼을 누르세요"
                    color: "white"
                    font.pixelSize: 60
                    horizontalAlignment: Text.AlignHCenter
                    font.family: font_noto_b.name
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Column{
                    Text{
                        text: "* 서빙위치란?"
                        color: color_green
                        font.bold: true
                        font.pixelSize:15
                        horizontalAlignment: Text.AlignHCenter
                        font.family: font_noto_r.name
                    }
                    Text{
                        text: "로봇이 각 테이블에 음식을 서빙하기위해 서는 장소입니다."
                        color: "white"
                        font.pixelSize: 15
                        horizontalAlignment: Text.AlignHCenter
                        font.family: font_noto_r.name
                    }
                    Text{
                        text: "로봇이 도착 후 회전할 수 있을 만큼은 테이블로부터 떨어트려주세요."
                        color: "white"
                        font.pixelSize: 15
                        horizontalAlignment: Text.AlignHCenter
                        font.family: font_noto_r.name
                    }
                }
            }
            AnimatedImage{
                id: image_robotmoving
                source: "image/robot_manual.gif"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 60
                width: 1280/1.5
                height: 800/1.5
                speed: 0.5
                anchors.bottomMargin: -100
            }
            Column{
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 50
                spacing: 30
                Rectangle{
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 180
                    height: 80
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    color: "transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        color: "white"
                        text: "맵 표시"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            popup_serving_map.open();
                            parent.color = "transparent";
                        }
                    }
                }
                Rectangle{
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 180
                    height: 80
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    color: "transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        color: "white"
                        text: "목록 보기"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            popup_serving_list.open();
                            parent.color = "transparent";
                        }
                    }
                }
            }

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                width: 220
                height: 120
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "저 장"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[ANNOTATION] LOCAION SAVE : Serving "+Number(supervisor.getlastRobotx())+", "+Number(supervisor.getlastRoboty())+", "+Number(supervisor.getlastRobotth()));
                        popup_add_serving.open();
                        parent.color = "transparent";
                    }
                }
            }

            Rectangle{
                id: btn_right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "전부 완료했습니다"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[ANNOTATION] LOCAION SAVE : Serving Done ");
                        annot_pages.sourceComponent = page_annot_location_serving_done;
                        parent.color = "transparent";
                    }
                }
            }

            Popup{
                id: popup_add_serving
                property bool use_group: false
                property var cur_group: 0
                width: 1280
                height:800
                y:-statusbar.height
                background:Rectangle{
                    anchors.fill: parent
                    color: color_dark_black
                    opacity: 0.8
                }
                onOpened:{
                    update();
                    map_location.setViewer("annot_location");
                    map_location.loadmap(supervisor.getMapname(),"EDITED");

                    textfield_loc_name.text = "";
                }
                Timer{
                    running: true
                    interval: 500
                    onTriggered:{
                        map_location.loadmap(supervisor.getMapname(),"EDITED");
                        map_location.setfullscreen();
                        map_location.move(0,0);
                    }
                }

                function update(){
                    model_loc_group.clear();
                    for(var i=0; i<supervisor.getLocationGroupNum(); i++){
                        model_loc_group.append({"name":supervisor.getLocGroupname(i)});
                    }
                }
                Rectangle{
                    anchors.centerIn: parent
                    width: 1000
                    height: 700
                    radius: 20
                    Column{
                        Rectangle{
                            color: "transparent"
                            width: 1000
                            height: 100
                            Text{
                                text: "서빙위치를 추가합니다"
                                anchors.centerIn: parent
                                font.pixelSize: 40
                                horizontalAlignment: Text.AlignHCenter
                                font.family: font_noto_r.name
                            }
                        }
                        Rectangle{
                            color: "transparent"
                            width: 1000
                            height: 500
                            Row{
                                anchors.centerIn: parent
                                spacing: 50
                                Map_full{
                                    id: map_location
                                    width: 500
                                    objectName: "annot_add_Serving"
                                    height: 500
                                    enabled: popup_add_serving.opened
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Column{
                                    spacing: 50
                                    anchors.verticalCenter: parent.verticalCenter
                                    Column{
                                        spacing : 20
                                        Text{
                                            text: "위치 이름"
                                            font.pixelSize: 30
                                            horizontalAlignment: Text.AlignHCenter
                                            font.family: font_noto_r.name
                                        }
                                        TextField{
                                            id: textfield_loc_name
                                            width: 400
                                            height: 50
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            placeholderText: "(loc_name)"
                                            font.family: font_noto_r.name
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pointSize: 20
                                            onFocusChanged: {
                                                keyboard.owner = textfield_loc_name;
                                                textfield_loc_name.selectAll();
                                                if(focus){
                                                    keyboard.open();
                                                }else{
                                                    textfield_loc_name.select(0,0)
                                                    keyboard.close();
                                                }
                                            }
                                        }
                                    }
                                    Column{
                                        spacing: 20

                                        Text{
                                            text: "그룹 지정"
                                            font.pixelSize: 30
                                            horizontalAlignment: Text.AlignHCenter
                                            font.family: font_noto_r.name
                                        }
                                        Row{
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            spacing: 20
                                            visible: !popup_add_serving.use_group
                                            Rectangle{
                                                width: 180
                                                height: 60
                                                radius: 10
                                                color:color_green
                                                border.width: 1
                                                border.color: color_gray
                                                Text{
                                                    anchors.centerIn: parent
                                                    text: "지정 안함"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 25
                                                }
                                            }
                                            Rectangle{
                                                width: 180
                                                height: 60
                                                radius: 10
                                                color:"white"
                                                border.width: 1
                                                border.color: color_gray
                                                Text{
                                                    anchors.centerIn: parent
                                                    text: "그룹 사용"
                                                    font.family: font_noto_r.name
                                                    font.pixelSize: 25
                                                }
                                                MouseArea{
                                                    anchors.fill: parent
                                                    onClicked:{
                                                        popup_add_serving.use_group = true;
                                                    }
                                                }
                                            }
                                        }

                                        Flickable{
                                            width: 400
                                            height:100
                                            clip: true
                                            visible: popup_add_serving.use_group
                                            contentWidth: row_group.width
                                            Row{
                                                id: row_group
                                                spacing: 20
                                                anchors.verticalCenter: parent.verticalCenter
                                                Rectangle{
                                                    id:rect_plus
                                                    width: 50
                                                    height: 50
                                                    radius: 50
                                                    anchors.verticalCenter: parent.verticalCenter
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
                                                Repeater{
                                                    model:ListModel{id:model_loc_group}
                                                    Rectangle{
                                                        width: 80
                                                        height: 70
                                                        radius: 10
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        border.width: 1
                                                        border.color: color_gray
                                                        color: popup_add_serving.cur_group === index ? color_green : "white"
                                                        Text{
                                                            anchors.centerIn: parent
                                                            font.family: font_noto_r.name
                                                            font.pixelSize: 15
                                                            text: name
                                                        }
                                                        MouseArea{
                                                            anchors.fill: parent
                                                            onClicked: {
                                                                popup_add_serving.cur_group = index
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
                            color: "transparent"
                            width: 1000
                            height: 100
                            Row{
                                anchors.centerIn: parent
                                spacing: 50
                                Rectangle{
                                    id: btn_prev_000
                                    width: 180
                                    height: 70
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
                                            popup_add_serving.close();
                                        }
                                    }
                                }
                                Rectangle{
                                    width: 180
                                    height: 70
                                    radius: 10
                                    color:"black"
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
                                            if(textfield_loc_name.text == ""){
                                                textfield_loc_name.color = color_red;
                                            }else{
                                                map_hide.savelocation("location_cur","Serving", popup_add_serving.cur_group, textfield_loc_name.text);
                                                supervisor.writelog("[ANNOTATION] LOCAION SAVE : Serving -> "+popup_add_serving.cur_group+", "+textfield_loc_name.text);
                                                supervisor.writelog("[ANNOTATION] LOCAION SAVE : Serving "+Number(supervisor.getlastRobotx())+", "+Number(supervisor.getlastRoboty())+", "+Number(supervisor.getlastRobotth()));
                                                popup_add_serving.close();
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
                id: popup_serving_list
                property bool use_group: false
                width: 1280
                height:800
                y:-statusbar.height
                background:Rectangle{
                    anchors.fill: parent
                    color: color_dark_black
                    opacity: 0.8
                }
                onOpened:{
                    readSetting();
                }

                function readSetting(){
                    print("READ SETTING!!!!!!!!!!!!!!!!!!!!!!");
                    groups.clear();
                    print("READ SETTING!!!!!!!!!!!!!!!!!!!!!!");
                    for(var i=0; i<supervisor.getLocationGroupNum(); i++){
                        print(i,supervisor.getLocationGroupNum());
                        groups.append({"value":supervisor.getLocGroupname(i)});
                        print("groups append : ", supervisor.getLocGroupname(i))
                    }

                    if(supervisor.getLocationGroupNum() > 1)
                        popup_add_serving.use_group = true;
                    else
                        popup_add_serving.use_group = false;

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
                        popup_serving_list.use_group = true;
                    else
                        popup_serving_list.use_group = false;

                    details.clear();
                    details.append({"type":"Charging",
                                       "name":"Charging",
                                       "group":0,
                                       "number":0,
                                       "number_table":0,
                                       "error":false,
                                       "call_id":supervisor.getLocationCallID("Charging",0)});
                    details.append({"type":"Resting",
                                       "name":"Resting",
                                       "group":0,
                                       "number":0,
                                       "number_table":0,
                                       "error":false,
                                       "call_id":supervisor.getLocationCallID("Resting",0)});

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
                        btn_confirm_location.enabled = false;
                    }else{
                        btn_confirm_location.enabled = true;
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
//                    print(" group change ",number,group,locations.count);
                    if(number > -1 && number < locations.count){
                        locations.get(number-2).group = group;
                        locations.get(number-2).number = 0;
                    }
                    update();
                }

                function tablechange(number, table){
//                    print("table change ",number,table)
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

                ListModel{
                    id: locations
                }

                ListModel{
                    id: groups
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
                                visible: popup_serving_list.use_group && type === "Serving"
                                width: 150
                                height: 40
                                model: groups
                                currentIndex: group
                                onCurrentIndexChanged: {
                                    if(focus){
                                        print("group changed ",index,currentIndex);
                                        popup_serving_list.groupchange(index,currentIndex);
                                    }
                                }
                            }
                            TextField{
                                id: tx_name
                                text: name
                                width:type==="Serving"?300:popup_serving_list.use_group?300+150+154:300+152
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
//                                    print("set name to "+text);
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
                                width : error?150-42:150
                                height: 40
                                visible: type ==="Serving"
                                model: ListModel{}
                                currentIndex: number==-1?0:number
                                onCurrentIndexChanged: {
                                    if(focus){
//                                        print("table focus change ",index,currentIndex)
                                        popup_serving_list.tablechange(index,currentIndex);
                                    }
                                }
                            }
                            Rectangle{
                                width : 150
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


                Rectangle{
                    anchors.centerIn: parent
                    width: 1000
                    height: 700
                    radius: 20
                    Column{
                        Rectangle{
                            color: "transparent"
                            width: 1000
                            height: 100
                            Text{
                                text: "서빙위치 상세 지정"
                                anchors.centerIn: parent
                                font.pixelSize: 40
                                horizontalAlignment: Text.AlignHCenter
                                font.family: font_noto_r.name
                            }
                        }
                        Rectangle{
                            color: "transparent"
                            width: 1000
                            height: 500

                            Column{
                                anchors.centerIn: parent
                                spacing: 2

                                Row{
                                    spacing: 2
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    Rectangle{
                                        width: 150
                                        height: 30
                                        color: color_navy
                                        visible: popup_serving_list.use_group
                                        Text{
                                            anchors.centerIn: parent
                                            text: "그룹"
                                            font.family: font_noto_r.name
                                            color: "white"
                                        }
                                    }
                                    Rectangle{
                                        width: 300
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
                                        width: 150
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
                                        width: 250
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

                                Flickable{
                                    width: 1000
                                    height: 400
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
                            }
                        }
                        Rectangle{
                            color: "transparent"
                            width: 1000
                            height: 100

                            Row{
                                anchors.centerIn: parent
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
                                            popup_serving_list.close();
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
//                                            loader_menu.item.update();
                                            popup_serving_list.close();
                                        }
                                    }
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
            Popup{
                id: popup_serving_map
                property bool use_group: false
                width: 600
                height:700
                anchors.centerIn: parent
                background:Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                }
                onOpened:{
                    map_location_view.setViewer("annot_location");
                    map_location_view.show_connection = false;
                    map_location_view.show_button_lidar = false;
                    map_location_view.show_button_object = false;
                    map_location_view.loadmap(supervisor.getMapname(),"EDITED");
                }

                function update(){

                }

                Rectangle{
                    anchors.centerIn: parent
                    width: 600
                    height: 700
                    radius: 20
                    color: color_navy

                    Column{
                        Rectangle{
                            color: "transparent"
                            width: 600
                            height: 100
                            Text{
                                text: "서빙위치 맵 뷰어"
                                anchors.centerIn: parent
                                color: "white"
                                font.pixelSize: 40
                                horizontalAlignment: Text.AlignHCenter
                                font.family: font_noto_r.name
                            }
                        }
                        Rectangle{
                            color: "transparent"
                            objectName: "annot_serving_mapview"
                            width: 600
                            height: 600
                            Map_full{
                                id: map_location_view
                                width: 600
                                objectName: "serving_map"

                                enabled: popup_serving_map.opened
                                height: 600
                                anchors.centerIn: parent
                            }
                        }
                    }
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
                                            popup_add_serving.update();
                                            popup_serving_list.readSetting();
                                            popup_add_serving.cur_group = supervisor.getLocationGroupNum()-1;
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
        }
    }

    Component{
        id: page_annot_location_serving_done
        Item{
            width: annot_pages.width
            height: annot_pages.height
            property bool use_group: false
            property bool use_callbell : true
            Component.onCompleted: {
                supervisor.setMotorLock(true);
                readSetting();
            }
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }

            function readSetting(){
                print("READ SETTING!!!!!!!!!!!!!!!!!!!!!!");
                groups.clear();
                print("READ SETTING!!!!!!!!!!!!!!!!!!!!!!",supervisor.getLocationGroupNum());
                for(var i=0; i<supervisor.getLocationGroupNum(); i++){
                    print(i,supervisor.getLocationGroupNum())
                    groups.append({"value":supervisor.getLocGroupname(i)});
                        print("groups append : ", supervisor.getLocGroupname(i))
                }

                if(supervisor.getLocationGroupNum() > 1)
                    use_group = true;
                else
                    use_group = false;

                locations.clear();
                print("READ SETTING!!!!!!!!!!!!!!!!!!!!!!",supervisor.getLocationNum("Serving"));
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
                    use_group = true;
                else
                    use_group = false;

                details.clear();
                print("READ SETTING!!!!!!!!!!!!!!!!!!!!!!");
                details.append({"type":"Charging",
                                   "name":"Charging",
                                   "group":0,
                                   "number":0,
                                   "number_table":0,
                                   "error":false,
                                   "call_id":supervisor.getLocationCallID("Charging",0)});
                details.append({"type":"Resting",
                                   "name":"Resting",
                                   "group":0,
                                   "number":0,
                                   "number_table":0,
                                   "error":false,
                                   "call_id":supervisor.getLocationCallID("Resting",0)});
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
                print("=================================");
                checkLocationNumber();
                print("=================================");

                if(isError()){
                    btn_right.enabled = false;
                }else{
                    btn_right.enabled = true;

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
                print(" group change ",number,group,details.count);
                if(number > 1 && number < details.count){
                    locations.get(number-2).group = group;
                    locations.get(number-2).number = 0;
                }
                update();
            }

            function tablechange(number, table){
                    print("table change ",number,table)
                if(number > 1 && number < details.count){
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

            ListModel{
                id: locations
            }

            ListModel{
                id: groups
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
//                            print("COMPO UPDATE : ",index,combo_number.model.count);
                    }
                    Row{
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 5
                        ComboBox{
                            id: combo_group
                            visible: use_group && type === "Serving"
                            width: 170
                            height: 40
                            model: groups
                            currentIndex: group
                            onCurrentIndexChanged: {
                                if(focus){
                                    groupchange(index,currentIndex);
                                }
                            }
                        }
                        TextField{
                            id: tx_name
                            text: name
                            width:type==="Serving"?320:use_group?320+170+180:320+175
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
//                                    print("set name to "+text);
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
                            width : error?170-45:170
                            height: 40
                            visible: type ==="Serving"
                            model: ListModel{}
                            currentIndex: number==-1?0:number
                            onCurrentIndexChanged: {
                                if(focus){
//                                        print("table focus change ",index,currentIndex)
                                    tablechange(index,currentIndex);
                                }
                            }
                        }
                        Rectangle{
                            width : 170
                            height: 40
                            visible: use_callbell
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
                            visible: use_callbell
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

                        Rectangle{
                            width : 100
                            height: 40
                            radius: 5
                            color: "black"
                            Text{
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                text:"주행"
                                color: "white"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
                                    supervisor.writelog("[ANNOTATION] TEST MOVING : "+name);
                                    supervisor.moveToServingTest(name);
                                }
                            }
                        }
                    }

                }
            }

            Text{
                text: annotation_after_mapping?"서빙 위치를 다시한번 확인해주세요.":"서빙위치를 수정합니다."
                color: "white"
                font.pixelSize: 60
                horizontalAlignment: Text.AlignHCenter
                font.family: font_noto_b.name
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle{
                color: "transparent"
                width: 1200
                height: 500
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 110

                Column{
                    anchors.centerIn: parent
                    spacing: 5

                    Row{
                        spacing: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                        Rectangle{
                            width: 170
                            height: 30
                            color: color_navy
                            visible: use_group
                            Text{
                                anchors.centerIn: parent
                                text: "그룹"
                                font.family: font_noto_r.name
                                color: "white"
                            }
                        }
                        Rectangle{
                            width: 320
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
                            width: 170
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
                            width: 270
                            height: 30
                            color: color_navy
                            visible: use_callbell
                            Text{
                                anchors.centerIn: parent
                                text: "호출벨"
                                font.family: font_noto_r.name
                                color: "white"
                            }
                        }
                        Rectangle{
                            width: 100
                            height: 30
                            color: color_navy
                            Text{
                                anchors.centerIn: parent
                                text: "테스트주행"
                                font.family: font_noto_r.name
                                color: "white"
                            }
                        }
                    }

                    Flickable{
                        width: 1200
                        height: 400
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
                            spacing: 3
                            clip: true
                            anchors.horizontalCenter: parent.horizontalCenter
                            delegate: detaillocCompo
                            model:ListModel{id:details}
                        }
                    }
                }
            }

            Rectangle{
                id: notice_moving
                width: parent.width
                height: 250
                anchors.centerIn: parent
                color: "black"
                visible: test_move_state!==0
                Text{
                    anchors.centerIn: parent
                    visible: test_move_state === 1
                    text: "로봇이 이동 중 입니다."
                    color: "white"
                    font.pixelSize:60
                    font.family: font_noto_b.name
                }
                Text{
                    id: text_error_msg
                    anchors.centerIn: parent
                    visible: test_move_state === 2
                    color: color_red
                    text: {
                        if(test_move_error === 0){
                            "경로를 찾을 수 없습니다."
                        }else if(test_move_error === 1){
                            "로봇의 초기화가 틀어졌습니다."
                        }else if(test_move_error === 2){
                            "비상스위치가 눌렸습니다."
                        }else if(test_move_error === 3){
                            "사용자에 의해 정지되었습니다."
                        }else if(test_move_error === 4){
                            "모터가 초기화 되지 않았습니다."
                        }
                    }
                    font.pixelSize:60
                    font.family: font_noto_b.name
                }
            }

            Rectangle{
                id: btn_right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: enabled?"transparent":color_gray
                enabled: false

                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "저 장"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        for(var i=0; i<details.count-2; i++){
                            supervisor.setLocation(i,details.get(i+2).name,details.get(i+2).group,details.get(i+2).number);
                        }
                        map_hide.save("location_all");
                        supervisor.writelog("[ANNOTATION] LOCAION SAVE : Check Done ");
                        if(annotation_after_mapping)
                            annot_pages.sourceComponent = page_annot_done;
                        else
                            annot_pages.sourceComponent = page_annot_menu;
                        supervisor.drawingRunawayStop();
                        parent.color = "transparent";
                    }
                }
            }
            Rectangle{
                id: btn_left
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: 50
                anchors.leftMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "서빙위치\n추가"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[ANNOTATION] LOCAION SAVE : Back to Serving");
                        annot_pages.sourceComponent = page_annot_location_serving;
                        parent.color = "transparent";
                    }
                }
            }
            Rectangle{
                id: btn_left2
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: 50
                anchors.leftMargin: 270
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "그룹 추가"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        popup_add_location_group.open();
//                        annot_pages.sourceComponent = page_annot_location_serving;
                        parent.color = "transparent";
                    }
                }
            }
            Rectangle{
                id: btn_left3
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: 50
                anchors.leftMargin: 490
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "호출벨 사용"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        if(use_callbell)
                            use_callbell = false;
                        else
                            use_callbell = true;
                        parent.color = "transparent";
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
                                            update();
                                            readSetting();
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


        }
    }
    Component{
        id: page_annot_done
        Item{
            width: annot_pages.width
            height: annot_pages.height
            property var local_find_state: 0
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Component.onCompleted: {
                supervisor.setMotorLock(true);
                text_title1.opacity = 1;
                text_title12.opacity = 1;
                text_title2.opacity = 1;
                btn_right.opacity = 1;
                btn_right2.opacity = 1;
            }

            Timer{
                running: true
                interval: 500
                onTriggered:{
                    supervisor.drawingRunawayStop();
                }
            }

            Text{
                id: text_title1
                text: "수고하셨습니다"
                color: "white"
                opacity: 0
                Behavior on opacity {
                    NumberAnimation{
                        duration : 1000
                    }
                }
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 80
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 140
                font.family: font_noto_b.name
            }
            Text{
                id: text_title12
                text: "맵 설정이 저장되었습니다"
                color: "white"
                opacity: 0
                Behavior on opacity {
                    NumberAnimation{
                        duration : 1000
                    }
                }
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_title1.bottom
                anchors.topMargin: 3
                font.family: font_noto_b.name
            }

            Text{
                id: text_title2
                text: "추가로 맵의 안전속도 구간과 이동경로를 수정하실 수 있습니다.\n설정을 여기서 완료하시거나 추가 설정을 원하신다면 아래 버튼을 눌러주세요"
                color: "white"
                opacity: 0
                Behavior on opacity {
                    NumberAnimation{
                        duration : 1200
                    }
                }
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 25
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_title12.bottom
                anchors.topMargin: 20
                font.family: font_noto_r.name
            }
            Rectangle{
                id: btn_right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 150
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                opacity: 0
                Behavior on opacity {
                    NumberAnimation{
                        duration : 1500
                    }
                }
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "종 료"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[ANNOTATION] Early Done");
                        loadPage(pinit);
                        parent.color = "transparent";
                    }
                }
            }
            Rectangle{
                id: btn_right2
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                opacity: 0
                Behavior on opacity {
                    NumberAnimation{
                        duration : 1500
                    }
                }
                color: "transparent"
                border.width: 2
                border.color: "white"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "추가 설정"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[ANNOTATION] Next to Additional");
                        annot_pages.sourceComponent = page_annot_additional_menu;
                        parent.color = "transparent";
                    }
                }
            }
        }
    }

    Component{
        id: page_annot_additional_menu
        Item{
            width: annot_pages.width
            height: annot_pages.height
            property var local_find_state: 0
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Component.onCompleted: {
                supervisor.setMotorLock(true);
            }

            Text{
                id: text_title1
                text: "맵의 추가설정을 합니다."
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 80
                font.family: font_noto_b.name
            }
            Text{
                id: text_title12
                text: "이 부분은 로봇 운영에 있어 필수는 아닙니다."
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 40
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_title1.bottom
                font.family: font_noto_b.name
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_title12.bottom
                anchors.topMargin: 100
                spacing: 50
                Rectangle{
                    width: 220
                    height: 180
                    radius: 15
                    visible: false
                    border.width: 2
                    border.color: "white"
                    color: "transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        text: "안전속도\n구간설정"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            supervisor.writelog("[ANNOTATION] Enter : Velocity Map");
                            annot_pages.sourceComponent = page_annot_velmap;
                            parent.color = "transparent";
                        }
                    }
                }
                Rectangle{
                    width: 220
                    height: 180
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    color: "transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        text: "이동경로\n설정"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            supervisor.writelog("[ANNOTATION] Enter : Travelline Map");
                            annot_pages.sourceComponent = page_annot_travelline;
                            parent.color = "transparent";
                        }
                    }
                }
                Rectangle{
                    width: 220
                    height: 180
                    radius: 15
                    border.width: 2
                    border.color: "white"
                    visible: false
                    color: "transparent"
                    Text{
                        Component.onCompleted: {
                            scale = 1;
                            while(width*scale > 180){
                                scale=scale-0.01;
                            }
                        }
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        text: "맵\n예쁘게그리기"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed:{
                            parent.color = color_mid_navy;
                        }
                        onReleased: {
                            supervisor.writelog("[ANNOTATION] Enter : Map Drawing");
                            annot_pages.sourceComponent = page_annot_drawmap;
                            parent.color = "transparent";
                        }
                    }
                }
            }

            Rectangle{
                id: btn_right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                width: 200
                height: 80
                radius: 15
                border.width: 2
                border.color: "white"
                color: "transparent"
                Text{
                    Component.onCompleted: {
                        scale = 1;
                        while(width*scale > 180){
                            scale=scale-0.01;
                        }
                    }
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    color: "white"
                    text: "종 료"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        supervisor.writelog("[ANNOTATION] All Done");
                        if(annotation_after_mapping)
                            loadPage(pinit);
                        else
                            annot_pages.sourceComponent = page_annot_menu;
                        parent.color = "transparent";
                    }
                }
            }
        }
    }

    Component{
        id: page_annot_travelline
        Item{
            width: annot_pages.width
            height: annot_pages.height
            property var select_preset: 0
            property bool is_drawing: false
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Component.onCompleted: {
                loading.hide();
                supervisor.setMotorLock(true);
                if(supervisor.isExistTravelEdited(supervisor.getMapname())){
                    supervisor.writelog("[ANNOTATION] Travel Line : load map")
                }
            }
            Timer{
                interval: 500
                running: true
                onTriggered:{
                    map.setViewer("annot_tline");
                    map.loadmap(supervisor.getMapname(),"T_EDIT");
                }
            }
            Column{
                Rectangle{
                    width: annot_pages.width
                    height: 100
                    color: "transparent"
                    Text{
                        text: "이동경로를 수정합니다."
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 40
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_b.name
                        anchors.centerIn: parent
                    }
                    Row{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 30
                        spacing: 20
                        Rectangle{
                            width: 60
                            height: width
                            radius: 60
                            anchors.verticalCenter: parent.verticalCenter
                            color: "transparent"
                            border.width:2
                            border.color: "white"
                            Text{
                                anchors.centerIn: parent
                                text : "?"
                                font.family: font_noto_b.name
                                color: "white"
                                font.pixelSize: 60
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
                                    popup_mapping_help.open();
                                }
                            }
                        }

                        Rectangle{
                            id: btn_right
                            width: 120
                            height: 60
                            radius: 15
                            anchors.verticalCenter: parent.verticalCenter
                            border.width: 2
                            border.color: "white"
                            color: "transparent"
                            Text{
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > 95){
                                        scale=scale-0.01;
                                    }
                                }
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                font.pixelSize: 30
                                color: "white"
                                text: "저장 후 종료"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onPressed:{
                                    parent.color = color_mid_navy;
                                }
                                onReleased: {
                                    supervisor.writelog("[MAPPING] Travel line : Save and Exit");
//                                    supervisor.saveMapping(map_name);
                                    annot_pages.sourceComponent = page_annot_additional_menu;
                                    parent.color = "transparent";
                                }
                            }
                        }
                    }
                }
                Row{
                    Rectangle{
                        width: annot_pages.width - map.width
                        height: map.height
                        Row{
                            id: row_redo
                            spacing: 30
                            anchors.top: parent.top
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
                                        supervisor.writelog("[ANNOTATION] Travel Line : UNDO")
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
                                        supervisor.writelog("[ANNOTATION] Travel Line : REDO")
                                        map.drawing_redo();
                                    }
                                }
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
                                            supervisor.writelog("[ANNOTATION] Travel Line : Set Tool to move");
                                            map.setTool("move");
                                            map.clear("spline");
                                        }
                                    }
                                }
                                Item_button{
                                    id: btn_draw
                                    width: 80
                                    shadow_color: color_gray
                                    highlight: map.tool=="draw" || map.tool=="erase" || map.tool=="straight"
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
                                            supervisor.writelog("[ANNOTATION] Travel Line : Set Tool to move");
                                            map.setTool("draw");
                                            map.clear("spline");
                                            map.setDrawingColor(255);
                                            map.setDrawingWidth(slider_brush.value);
                                            select_preset = 1;
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
                                            map.clear("spline");
                                            map.clear("tline");
                                            map.clear("all");
                                            supervisor.writelog("[ANNOTATION] Travel line : Clear")
                                        }
                                    }
                                }
                                Item_button{
                                    width: 80
                                    shadow_color: color_gray
                                    highlight: is_drawing
                                    icon: "icon/icon_set_init.png"
                                    name: "경로그리기"
                                    MouseArea{
                                        anchors.fill: parent
                                        onPressed: {
                                            parent.pressed();
                                        }
                                        onReleased:{
                                            parent.released();
                                        }

                                        onClicked: {
                                            map.setTool("move");
                                            if(is_drawing){
                                                supervisor.writelog("[ANNOTATION] Travel Line : Drawing Stop");
                                                supervisor.drawingRunawayStop();
                                                is_drawing = false;
                                            }else{
                                                supervisor.writelog("[ANNOTATION] Travel Line : Drawing Start");
                                                supervisor.drawingRunawayStart();
                                                is_drawing = true;
                                            }
                                            timer_motor_lock.start();
                                        }
                                    }
                                }
                            }
                        }
                        Timer{
                            id: timer_motor_lock
                            interval: 500
                            onTriggered:{
                                if(is_drawing){
                                    supervisor.setMotorLock(false);
                                }else{
                                    supervisor.setMotorLock(true);
                                }
                            }
                        }

                        Rectangle{
                            id: rect_annot_boxs
                            width: parent.width - 60
                            height: 200
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: rect_annot_box.bottom
                            color: "#e8e8e8"
                            Column{
                                anchors.centerIn: parent
                                spacing: 4
                                Rectangle{
                                    id: rect_annot_tline_2
                                    width: rect_annot_boxs.width
                                    height: 60
                                    visible: map.tool === "draw" || map.tool === "straight" || map.tool === "dot_spline" || map.tool === "erase"
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
                                                    supervisor.writelog("[ANNOTATION] Travel line : Set tool to draw");
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
                                                    color: map.tool==="straight"? color_green: color_gray
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
                                                    supervisor.writelog("[ANNOTATION] Travel line : Set tool to straight");
                                                    map.clear("spline");
                                                    map.setTool("straight");
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
                                                    supervisor.writelog("[ANNOTATION] Travel line : Set tool to dot_spline");
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
                                                    supervisor.writelog("[ANNOTATION] Travel line : Set tool to erase");
                                                    map.clear("spline");
                                                    map.setDrawingWidth(slider_erase.value);
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
                                    visible: map.tool === "dot_spline"
                                    color: "white"
                                    Row{
                                        anchors.centerIn: parent
                                        spacing: 20
                                        Rectangle{
                                            width: 130
                                            height: 50
                                            color: "transparent"
                                            border.width: 1
                                            Row{
                                                anchors.centerIn: parent
                                                spacing: 10
                                                Text{
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    font.family: font_noto_r.name
                                                    text: "취소"
                                                }
                                            }

                                            MouseArea{
                                                anchors.fill: parent
                                                onClicked:{
                                                    supervisor.writelog("[ANNOTATION] Travel line : Cancel dot spline");
                                                    map.clear("spline");
                                                    map.setTool("draw");
                                                }
                                            }
                                        }
                                        Rectangle{
                                            width: 130
                                            height: 50
                                            color: "transparent"
                                            border.width: 1

                                            Row{
                                                anchors.centerIn: parent
                                                spacing: 10
                                                Text{
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    font.family: font_noto_r.name
                                                    text: "저장"
                                                }
                                            }
                                            MouseArea{
                                                anchors.fill: parent
                                                onClicked:{
                                                    supervisor.writelog("[ANNOTATION] Travel line : Save dot spline");
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
                                    height: 60
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
                                Rectangle{
                                    width: rect_annot_boxs.width
                                    height: 60
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
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin : 50
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
                                }
                            }
                        }

                    }
                    Map_full{
                        id: map
                        objectName: "annot_tline"
                        width: height
                        height: annot_pages.height - 100
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

        }
    }

    Component{
        id: page_annot_velmap
        Item{
            width: annot_pages.width
            height: annot_pages.height
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Component.onCompleted: {
                supervisor.setMotorLock(true);
            }
            Timer{
                interval: 500
                running: true
                onTriggered:{
                    map.setViewer("annot_velmap");
                    map.loadmap(supervisor.getMapname(),"mapvel");
                }
            }

            Column{
                Rectangle{
                    width: annot_pages.width
                    height: 100
                    color: "transparent"
                    Text{
                        text: "안전속도 구간을 설정합니다."
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 40
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: font_noto_b.name
                        anchors.centerIn: parent
                    }
                    Row{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 30
                        spacing: 20
                        Rectangle{
                            width: 60
                            height: width
                            radius: 60
                            anchors.verticalCenter: parent.verticalCenter
                            color: "transparent"
                            border.width:2
                            border.color: "white"
                            Text{
                                anchors.centerIn: parent
                                text : "?"
                                font.family: font_noto_b.name
                                color: "white"
                                font.pixelSize: 60
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
                                    popup_mapping_help.open();
                                }
                            }
                        }
                        Rectangle{
                            id: btn_right
                            width: 120
                            height: 60
                            radius: 15
                            anchors.verticalCenter: parent.verticalCenter
                            border.width: 2
                            border.color: "white"
                            color: "transparent"
                            Text{
                                Component.onCompleted: {
                                    scale = 1;
                                    while(width*scale > 95){
                                        scale=scale-0.01;
                                    }
                                }
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                font.pixelSize: 30
                                color: "white"
                                text: "저장 후 종료"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onPressed:{
                                    parent.color = color_mid_navy;
                                }
                                onReleased: {
                                    supervisor.writelog("[MAPPING] Velocity Map : Save and Exit");
//                                    supervisor.saveMapping(map_name);
                                    annot_pages.sourceComponent = page_annot_additional_menu;
                                    parent.color = "transparent";
                                }
                            }
                        }
                    }
                }
                Row{
                    Rectangle{
                        width: annot_pages.width - map.width
                        height: map.height
                        Row{
                            id: row_redo
                            spacing: 30
                            anchors.top: parent.top
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

                    }
                    Map_full{
                        id: map
                        width: height
                        objectName: "annot_velmap"
                        height: annot_pages.height - 100
                    }
                }
            }
            Popup{
                id: popup_mapping_help
                anchors.centerIn: parent
                width: 800
                height: 600
                background: Rectangle{
                    width: popup_mapping_help.width
                    height: popup_mapping_help.height
                    radius: 30
                    color: color_dark_black
                    opacity: 0.9
                }
                Column{
                    Rectangle{
                        width: popup_mapping_help.width
                        height: 100
                        color: "transparent"
                        Text{
                            anchors.centerIn: parent
                            text: "도움말"
                            font.family: font_noto_r.name
                            font.pixelSize: 50
                            color:"white"
                        }
                    }
                    Rectangle{
                        width: popup_mapping_help.width
                        height: popup_mapping_help.height - 100
                        color: "transparent"
                        Column{
                            anchors.centerIn: parent
                            spacing: 50
                            Column{
                                spacing: 10
                                width: 550
                                Text{
                                    text: "Q. 안전속도 구간이란?"
                                    font.family: font_noto_r.name
                                    font.pixelSize: 25
                                    color:"white"
                                }
                                Text{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "로봇이 이동 중 해당 구간에 진입하면 '느리게', '아주 느리게' 속도로 이동합니다.\n각 속도의 설정 값은 세팅화면에서 변경 가능합니다."
                                    font.family: font_noto_r.name
                                    font.pixelSize: 20
                                    color:"white"
                                }
                            }
                        }

                    }

                }
            }
        }
    }
    AnimatedImage{
        id: loading
        anchors.fill: parent
        function show(){
            source = "image/loading_rb.gif"
        }
        function hide(){
            source = "";
        }
        source: ""
    }
    Map_full{
        id: map_hide
        visible:false
        objectName: "annot_hide"
        enabled:false
    }
    Tool_Keyboard{
        id: keyboard
    }
}
