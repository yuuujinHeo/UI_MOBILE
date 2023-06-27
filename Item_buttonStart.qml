import QtQuick 2.12
import QtQuick.Shapes 1.12
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
    id: item_ButtonStart
    property string name: ""
    property string run_name: ""
    property string color: "white"
    property string push_color: color_mid_gray
    property string disable_color: color_gray
    property string font_color: color_dark_navy
    property color shadow_color: color_gray
    property bool running: false
    onRunningChanged: {
        if(running)
            timer.start();
        else
            timer.stop();
    }

    signal clicked
    width: 200
    height: 130

    Rectangle{
        width: parent.width
        height: parent.height
        color: "transparent"
        Rectangle{
            id: btn
            width: parent.width
            height: parent.height
            radius: 20
            color: item_ButtonStart.enabled?item_ButtonStart.color:item_ButtonStart.disable_color
            Column{
                anchors.centerIn: parent
                spacing: 10
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: running?run_name:name
                    color: item_ButtonStart.enabled?font_color:"white"
                    horizontalAlignment: Text.AlignHCenter
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                }
                Rectangle{
                    width: 180
                    height: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    Rectangle{
                        id: progress
                        width: 30
                        radius: 5
                        property string pos : "left"
                        onPosChanged: {
                            if(pos == "left")
                                x=0;
                            else
                                x=180-30
                        }

                        height: parent.height
                        color: running?color_green:"transparent"
                        x: 0
                        Behavior on x{
                            SpringAnimation{
                                duration: 300
                                spring: 2.5
                                damping: 0.6
                            }
                        }
                    }
                }
            }

            Timer{
                id: timer
                running: running
                interval: 1100
                repeat: true
                onTriggered: {
                    if(progress.pos === "left"){
                        progress.pos = "right";
                    }else{
                        progress.pos = "left";
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                onPressed:{
                    btn.color = push_color;
                }
                onReleased: {
                    btn.color = color;
                    item_ButtonStart.clicked()
                    //click_sound.play();
                }
            }
        }
        DropShadow{
            anchors.fill: parent
            radius: 10
            color: shadow_color
            source: btn
        }
    }
//    SoundEffect{
//        id: click_sound
//        source: "bgm/click.wav"
//    }
}
