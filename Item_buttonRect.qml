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
    id: item_ButtonRect
    property string icon: ""
    property string name: ""
    property string color: color_dark_navy
    property string push_color: "black"
    property string disable_color: color_gray
    property string font_color: "white"
    signal clicked
    width: 200
    height: 100

    Rectangle{
        id: btn
        width: parent.width
        height: parent.height
        radius: 20
        color: parent.enabled?parent.color:parent.disable_color
        Text{
            anchors.centerIn: parent
            text: name
            color: item_ButtonRect.enabled?font_color:"white"
            horizontalAlignment: Text.AlignHCenter
            font.family: font_noto_r.name
            font.pixelSize: 40
        }
        MouseArea{
            anchors.fill: parent
            onPressed:{
                btn.color = push_color;
            }
            onReleased: {
                btn.color = color;
                item_ButtonRect.clicked()
                click_sound.play();
            }
        }
    }
//    SoundEffect{
//        id: click_sound
//        source: "bgm/click.wav"
//    }
}
