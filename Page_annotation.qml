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
    property bool test: true

    function init(){

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
        id: page_annot_start
        Item{
            width: annot_pages.width
            height: annot_pages.height
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Component.onCompleted: {
                map.loadmap(supervisor.getMapname(),"EDITED");

                map.setViewer("annot_rotate");
                map.setTool("cut_map");
                map.clear("rotate")
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
                        annot_pages.sourceComponent = page_annot_localization;
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
            property bool local_find: false
            Rectangle{
                anchors.fill: parent
                color: color_dark_navy
            }
            Component.onCompleted: {
                loading.show();
                text_finding.opacity = 1;
                map.loadmap("EDITED");
                map.setViewer("local_view");
            }

            Timer{
                id: timer_check_localization
                running: true
                repeat: true
                interval: 100
                onTriggered: {
                    if(test){

                    }

                    if(supervisor.getLocalizationState()===0){//not ready
                        print("slam autoInit");
                        supervisor.slam_autoInit();
                    }else if(supervisor.getLocalizationState() === 2){//success
                        timer_check_localization.stop();
                    }else if(supervisor.getLocalizationState() === 3){//failed
                        timer_check_localization.stop();
                    }
                }
            }
            Map_full{
                id: map
                visible: local_find
            }

            Text{
                id: text_finding
                visible: !local_find
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

}
