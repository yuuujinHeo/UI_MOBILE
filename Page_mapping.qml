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
    id: page_mapping
    objectName: "page_mapping"
    width: 1280
    height: 800
    property bool test: true
    property bool is_mapping: false
    property string map_name : "TEST_1"
    property var grid_width: 3
    property var map_width: 1000

    function init(){
        mapping_pages.sourceComponent = page_mapping_start;
        map_name = "TEST_1";
        grid_width = 3;
    }
    function update_mapping(){
        mapping_pages.item.update();
    }

    Timer{
        id: update_timer
        interval: 1000
        running: true
        repeat: true
        onTriggered:{
            if(supervisor.getMappingflag()){
                if(!is_mapping){
                    voice_stop_mapping.stop();
                    voice_start_mapping.play();
                    is_mapping = true;
                }
            }else{
                if(is_mapping){
                    voice_start_mapping.stop();
                    is_mapping = false;
                }
            }
        }
    }
    Loader{
        id: mapping_pages
        width: 1280
        height: 800 - statusbar.height
        anchors.bottom: parent.bottom
        clip: true
        sourceComponent: page_mapping_start
    }
    Component{
        id: page_mapping_start
        Item{
            width: mapping_pages.width
            height: mapping_pages.height
            Component.onCompleted: {
                supervisor.setMotorLock(false);
            }

            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Column{
                id: col
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 120
                spacing: 30
                Text{
                    text: "맵 생성을 시작합니다"
                    color: "white"
                    font.pixelSize: 80
                    font.family: font_noto_b.name
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text{
                    text: "매장환경을 정돈하신 후 가급적 테이블의 이동을 삼가 해주시기 바랍니다\n지금부터 로봇을 밀며 이동할 수 있습니다"
                    color: "white"
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    font.family: font_noto_r.name
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle{
                width: 80
                height: width
                radius: width
                color: "transparent"
                border.width:2
                border.color: "white"
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.top: parent.top
                anchors.topMargin: 50
                Text{
                    anchors.centerIn: parent
                    text : "?"
                    font.family: font_noto_b.name
                    color: "white"
                    font.pixelSize: 80
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        click_sound.play();
                        popup_help.setTitle("맵 생성");
                        popup_help.addTip("맵 생성이 무엇인가요?","로봇을 처음 세팅하거나 매장의 환경이 많이 바뀌었을 때 매장의 지도를 다시 그려야 합니다\n맵을 생성하고 저장하면 기존의 데이터는 더 이상 사용하지 않으며 새로 세팅해야 합니다\n맵을 그린 뒤 각각의 서빙, 충전 위치 등을 지정하고 이동경로를 학습하려면 [시작] 버튼을 누르세요");
                        popup_help.addTip("맵 생성을 했다가 다시 되돌릴 수 있나요?","맵을 저장하지 않으면 기존 데이터를 덮어쓰지 않습니다\n만일 맵을 저장했다 하더라도 기존에 저장된 맵과 서빙포인트를 되살리고 싶다면 맵 설정 페이지에서 맵 불러오기를 실행하세요");
                        popup_help.open();
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
                    text: "시 작"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        click_sound.play();
                        supervisor.writelog("[MAPPING] START Mapping : next page")
                        mapping_pages.sourceComponent = page_mapping_set;
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
                    text: "취 소"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        click_sound.play();
                        backPage();
                        parent.color = "transparent";
                    }
                }
            }

        }


    }
    Component{
        id: page_mapping_set
        Item{
            width: mapping_pages.width
            height: mapping_pages.height
            property var select_grid: 5
            property var available_size: 0
            onSelect_gridChanged: {
                available_size = select_grid*slider_mapsize.value/100;
            }

            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Component.onCompleted: {
                textfield_name.text = supervisor.getnewMapname();
                slider_mapsize.value = parseInt(supervisor.getSetting("ROBOT_SW","map_size"));
            }

            Text{
                text: "맵의 기본 정보를 설정합니다"
                color: "white"
                font.pixelSize: 60
                font.family: font_noto_b.name
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Column{
                width: 550
                anchors.centerIn: parent
                spacing: 30
                Column{
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        font.family: font_noto_r.name
                        font.pixelSize: 30
                        color: "white"
                        text: "맵의 이름"
                    }
                    TextField{
                        id: textfield_name
                        width: 550
                        height: 70
                        horizontalAlignment: TextField.AlignHCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        Component.onCompleted: {
                            focus = false;
                        }
                        onFocusChanged: {
                            keyboard.owner = textfield_name;
                            textfield_name.selectAll();
                            if(focus){
                                keyboard.open();
                            }else{
                                keyboard.close();
                                textfield_name.select(0,0);
                            }
                        }
                    }
                }
                Column{
                    spacing: 20
                    width: 550
                    anchors.horizontalCenter: parent.horizontalCenter
                    Column{
                        spacing: 3
                        Rectangle{
                            width: 550
                            height: 40
                            color: "transparent"
                            Text{
                                font.family: font_noto_r.name
                                font.pixelSize: 30
                                color: "white"
                                text: "맵 크기"
                            }

                            Text{
                                anchors.right: parent.right
                                font.family: font_noto_r.name
                                font.pixelSize: 30
                                color: "white"
                                text: slider_mapsize.value.toString() + " [pixel]"
                            }
                        }
                        Text{
                            anchors.right: parent.right
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            color: "white"
                            text: "맵의 크기가 커질 수록 이동을 시작할 때나 맵을 그릴 때 느려질 수 있습니다"
                        }
                    }
                    Slider{
                        id: slider_mapsize
                        width: 550
                        from: 1000
                        to: 2500
                        stepSize: 200
                        onValueChanged: {
                            available_size = select_grid*slider_mapsize.value/100;
                        }
                    }
                }
                Column{
                    spacing: 20
                    width: 550
                    anchors.horizontalCenter: parent.horizontalCenter
                    Column{
                        spacing: 3
                        Text{
                            width: 550
                            font.family: font_noto_r.name
                            font.pixelSize: 30
                            color: "white"
                            text: "맵 픽셀 당 크기"
                        }
                        Text{
                            anchors.right: parent.right
                            font.family: font_noto_r.name
                            font.pixelSize: 15
                            color: "white"
                            text: "픽셀크기가 작을 수록 정밀한 로봇 이동이 가능합니다"
                        }
                    }

                    Row{
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 50
                        Rectangle{
                            width: 150
                            height: 80
                            radius: 20
                            border.width: 2
                            border.color: "white"
                            color: select_grid === 3?color_green:"transparent"
                            Text{
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                font.pixelSize: 30
                                color: "white"
                                text: "3 cm"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    click_sound.play();
                                    select_grid = 3;
                                }
                            }
                        }
                        Rectangle{
                            width: 150
                            height: 80
                            radius: 20
                            border.width: 2
                            border.color: "white"
                            color: select_grid === 5?color_green:"transparent"
                            Text{
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                font.pixelSize: 30
                                color: "white"
                                text: "5 cm"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    click_sound.play();
                                    select_grid = 5;
                                }
                            }
                        }
                        Rectangle{
                            width: 150
                            height: 80
                            radius: 20
                            border.width: 2
                            border.color: "white"
                            color: select_grid === 3||select_grid === 5?"transparent":color_green
                            Text{
                                anchors.centerIn: parent
                                font.family: font_noto_r.name
                                font.pixelSize: 30
                                color: "white"
                                text: select_grid === 3||select_grid === 5?"그 외":select_grid.toString()+" cm"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    click_sound.play();
                                    popup_select_grid.open();
                                }
                            }
                        }
                    }
                }
            }
            Timer{
                running: true
                interval: 1000
                onTriggered: {
                    btn_right.enabled = true;
                }
            }

            Popup{
                id: popup_select_grid
                anchors.centerIn: parent
                width: 600
                height: 300
                background: Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                }
                Rectangle{
                    width: parent.width
                    height: parent.height
                    radius: 20
                    color: color_navy
                    Column{
                        anchors.centerIn: parent
                        spacing: 50
                        Column{
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 10
                            Text{
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.family: font_noto_r.name
                                font.pixelSize: 30
                                color: "white"
                                text: "맵 픽셀 당 크기"
                            }
                            Text{
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.family: font_noto_r.name
                                font.pixelSize: 30
                                color: "white"
                                text: slider_grid.value.toString()+" cm"
                            }
                        }

                        Slider{
                            id: slider_grid
                            width: 500
                            anchors.horizontalCenter: parent.horizontalCenter
                            from: 1
                            to: 10
                            value: 3
                            stepSize: 1
                            onValueChanged: {
                                select_grid = value;
                            }
                        }
                    }
                }
            }

            Column{
                anchors.horizontalCenter: btn_right.horizontalCenter
                anchors.bottom: btn_right.top
                anchors.bottomMargin: 10
                spacing: 5
                Text{
                    font.pixelSize: 15
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: font_noto_r.name
                    color: color_blue
                    text:"맵 생성 가능한 매장 크기(최대)"
                }
                Text{
                    font.pixelSize: 15
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: font_noto_r.name
                    color: color_blue
                    text:available_size.toString() + " m X " + available_size.toString() + " m";
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
                enabled: false
                color: enabled?"transparent":color_dark_gray
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
                    text: "맵 생성"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        click_sound.play();
                        map_name = textfield_name.text;
                        map_width = slider_mapsize.value;
                        grid_width = (select_grid/100);
                        supervisor.setSetting("ROBOT_SW/map_size","1000");
                        supervisor.setSetting("ROBOT_SW/grid_size",grid_width.toString());
                        supervisor.writelog("[MAPPING] START Mapping : set name("+map_name+") grid("+grid_width.toString()+")");
                        mapping_pages.sourceComponent = page_mapping_view;
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
                    text: "취 소"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        click_sound.play();
                        supervisor.writelog("[MAPPING] START Mapping : prev page")
                        mapping_pages.sourceComponent = page_mapping_start;
                        parent.color = "transparent";
                    }
                }
            }

        }

    }
    Component{
        id: page_mapping_view
        Item{
            width: mapping_pages.width
            height: mapping_pages.height
            Component.onCompleted: {
                mapping_view.setViewer("mapping");
                mapping_view.setEnable(true)
                supervisor.startMapping(map_width,grid_width);
            }
            function update(){
//                print("update mapping");
                mapping_view.loadmapping();
            }

            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }

            Rectangle{
                width: 80
                height: width
                radius: width
                color: "transparent"
                border.width:2
                border.color: "white"
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.top: parent.top
                anchors.topMargin: 50
                Text{
                    anchors.centerIn: parent
                    text : "?"
                    font.family: font_noto_b.name
                    color: "white"
                    font.pixelSize: 80
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        click_sound.play();
                        popup_help.setTitle("맵 생성");
                        popup_help.addTip("맵을 새로 그리고 싶어요","[취소] 버튼을 누르고 새로 시작해 주세요");
                        popup_help.addTip("맵이 틀어진 것 같아요","맵을 그리다보면 간혹 기존 맵과 일치하지 않게 틀어진 맵이 추가로 그려질 수 있습니다\n이때 틀어졌다고 판단되는 구간에서 잠시 정지하여 기다려주세요\n로봇은 주기적으로 맵의 오차를 계산하고 이를 복구하기 위해 노력합니다");
                        popup_help.addTip("맵이 끝에서 잘립니다","맵 생성이 가능한 사이즈는 정해져있습니다\n맵을 그리기 시작할 때 로봇의 위치는 맵의 중심좌표가 됩니다\n로봇을 맵의 중앙에 가깝게 이동시켜주신뒤 새로 그려주세요\n");
                        popup_help.open();
                    }
                }
            }

            MAP_FULL2{
                id: mapping_view
                enabled: true
                objectName: "mappingview"
                width: parent.height
                height: parent.height
                anchors.centerIn: parent
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
                enabled: false||test
                color: enabled?"transparent":color_dark_gray
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
                        click_sound.play();
                        supervisor.writelog("[MAPPING] START Mapping : save mapping");
                        supervisor.saveMapping(map_name);
                        mapping_pages.sourceComponent = page_mapping_done;
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
                    text: "취 소"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        click_sound.play();
                        supervisor.writelog("[MAPPING] START Mapping : Stop and canceled")
                        supervisor.stopMapping();
                        mapping_pages.sourceComponent = page_mapping_start;
                        parent.color = "transparent";
                    }
                }
            }
        }
    }
    Component{
        id: page_mapping_done
        Item{
            width: mapping_pages.width
            height: mapping_pages.height
            property bool detect_done: false
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Component.onCompleted: {
                loading.show();
            }
            Timer{
                running: true
//                repeat: true
                interval: 1000
                onTriggered: {
                    if(supervisor.getIPCConnection()){
                        loading.hide();
                        supervisor.setMap(map_name);
                        detect_done = true;
                        stop();
                    }
                }
            }
            Column{
                anchors.centerIn: parent
                spacing: 30
                opacity: detect_done?1:0
                Behavior on opacity {
                    NumberAnimation{
                        duration : 500
                    }
                }
                Text{
                    text: "맵 생성을 완료하였습니다"
                    color: "white"
                    font.pixelSize: 60
                    font.family: font_noto_b.name
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text{
                    text: "다음으로 맵 설정을 진행합니다"
                    color: "white"
                    font.pixelSize: 60
                    font.family: font_noto_b.name
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle{
                id: btn_right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 50
                anchors.rightMargin: 50
                opacity: detect_done?1:0
                Behavior on opacity {
                    NumberAnimation{
                        duration : 500
                    }
                }
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
                    text: "맵 설정"
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        parent.color = color_mid_navy;
                    }
                    onReleased: {
                        click_sound.play();
                        supervisor.writelog("[MAPPING] START Annotation");
                        loadPage(pannotation);
                        loader_page.item.setMappingFlag();
                        parent.color = "transparent";
                    }
                }
            }
        }
    }

    Audio{
        id: voice_start_mapping
        autoPlay: false
        volume: volume_voice/100
        source: supervisor.getVoice("start_mapping");
        property bool isplaying: false
        onStopped: {
            isplaying = false;
        }
        onPlaying:{
            isplaying = true;
        }
    }
    Audio{
        id: voice_stop_mapping
        autoPlay: false
        volume: volume_voice/100
        source: supervisor.getVoice("stop_mapping");
        property bool isplaying: false
        onStopped: {
            isplaying = false;
        }
        onPlaying:{
            isplaying = true;
        }
    }

    Popup_help{
        id: popup_help
    }

    Tool_Keyboard{
        id: keyboard
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
}
