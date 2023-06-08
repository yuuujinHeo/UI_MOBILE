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
                map.setViewer("annot_rotate");
            }

            Text{
                text: "맵을 회전하고 맵의 영역만큼 지정해주세요."
                color: "white"
                font.pixelSize: 50
                font.family: font_noto_b.name
                anchors.top: parent.top
                anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Map_full{
                id: map
                width: 600
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
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
                        parent.color = "transparent";
                    }
                }
            }

        }
    }
}
