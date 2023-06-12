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

    property string map_name : "TEST_1"
    property var grid_width: 3
    property var map_wdth: 1000

    function init(){
        mapping_pages.sourceComponent = page_mapping_start;
        map_name = "TEST_1";
        grid_width = 3;
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
                    text: "맵 생성을 시작합니다."
                    color: "white"
                    font.pixelSize: 80
                    font.family: font_noto_b.name
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text{
                    text: "매장환경을 정돈하신 후 가급적 테이블의 이동을 삼가 해주시기 바랍니다.\n지금부터 로봇을 밀며 이동할 수 있습니다."
                    color: "white"
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    font.family: font_noto_r.name
                    anchors.horizontalCenter: parent.horizontalCenter
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
            property var select_grid: 3
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
                            text: "맵의 크기가 커질 수록 이동을 시작할 때나 맵을 그릴 때 느려질 수 있습니다."
                        }
                    }
                    Slider{
                        id: slider_mapsize
                        width: 550
                        from: 1000
                        to: 3000
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
                            text: "픽셀크기가 작을 수록 정밀한 로봇 이동이 가능합니다."
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
                        map_name = textfield_name.text;
                        grid_width = select_grid;
                        supervisor.setSetting("ROBOT_SW/map_size","1000");
                        supervisor.setSetting("ROBOT_SW/grid_size",(grid_width/100).toString());
                        supervisor.writelog("[MAPPING] START Mapping : set name("+map_name+") grid("+(grid_width/100).toString()+")");
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
            }

            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }

            Rectangle{
                width: 100
                height: width
                radius: 100
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
                        popup_mapping_help.open();
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
                                    text: "Q. 매핑을 새로 시작하고 싶어요."
                                    font.family: font_noto_r.name
                                    font.pixelSize: 25
                                    color:"white"
                                }
                                Text{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "매핑을 새로 시작하려면 취소를 누르고 다시 시작해주세요."
                                    font.family: font_noto_r.name
                                    font.pixelSize: 20
                                    color:"white"
                                }
                            }
                            Column{
                                spacing: 10
                                width: 550
                                Text{
                                    text: "Q. 매핑을 새로 시작하고 싶어요."
                                    font.family: font_noto_r.name
                                    font.pixelSize: 25
                                    color:"white"
                                }
                                Text{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "매핑을 새로 시작하려면 취소를 누르고 다시 시작해주세요."
                                    font.family: font_noto_r.name
                                    font.pixelSize: 20
                                    color:"white"
                                }
                            }
                        }

                    }

                }
            }

            Map_full{
                id: mapping_view
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
                supervisor.setMotorLock(true);
                loading.show();
            }
            Timer{
                running: true
                repeat: true
                interval: 100
                onTriggered: {
                    if(!supervisor.getLCMConnection()){
                        supervisor.writelog("[MAPPING] START Mapping : Slam restart detected!")
                        loading.hide();
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
                    text: "맵 생성을 완료하였습니다."
                    color: "white"
                    font.pixelSize: 60
                    font.family: font_noto_b.name
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text{
                    text: "다음으로 맵 설정을 진행합니다."
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
                        supervisor.writelog("[MAPPING] START Annotation");
                        loadPage(pannotation);
                        parent.color = "transparent";
                    }
                }
            }
        }
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
