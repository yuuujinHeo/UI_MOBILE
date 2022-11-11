import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
//import QtQuick.Shapes 1.
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0
//import QtQuick.Templates 2.5
import "."
import io.qt.Supervisor 1.0
import QtMultimedia 5.9

Item {
    id: page_moving
    objectName: "page_moving"
    width: 1280
    height: 800

    property string pos: "1번테이블"
    property bool robot_paused: false

    function init(){
        robot_paused = false;
        popup_pause.visible = false;
        playMusic.play();
    }
    function stopMusic(){
        playMusic.stop();
    }

    Audio{
        id: playMusic
        autoPlay: false
        source: "bgm/song.mp3"
    }

    Text{
        id: target_pos
        text: pos
        font.pixelSize: 50
        font.bold: true
        color: "blue"
        anchors.horizontalCenter: parent.horizontalCenter
        y: 150
    }
    Text{
        id: text_mention
        text: "(으)로 이동 중입니다."
        font.pixelSize: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top : target_pos.bottom
        anchors.topMargin: 30
    }
    Rectangle{
        id: rect_moving
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: text_mention.bottom
        anchors.topMargin: 40
        width: ani_moving.width;
        height: ani_moving.height;
        AnimatedImage{
            id: ani_moving
            source: Qt.resolvedUrl("qrc:/image/robot_moving.gif")
            width: 350;
            height: 350;
            paused: robot_paused
        }
    }






    Rectangle{
        id: popup_pause
        width: 200
        height: 150
        visible: robot_paused
        anchors.centerIn: parent
        color:"gray"
        opacity: 0.6
        Text{
            anchors.centerIn: parent
            text: "일시정지"
        }
        MouseArea{
            id: btn_page_popup
            anchors.fill: parent
            onClicked: {
                if(robot_paused){
                    console.log("UI : RESUME");
                    supervisor.moveResume();
                    timer_check_pause.start();
                }else{
                    console.log("UI : PAUSE");
                    supervisor.movePaused();
                    timer_check_pause.start();

                }
            }
        }
    }
    Timer{
        id: timer_check_pause
        interval: 500
        running: false
        repeat: true
        onTriggered: {
            if(supervisor.getRobotState() == 4){
                robot_paused = true;
                print("robot paused!!");
                popup_pause.visible = true;
                timer_check_pause.stop();
            }else{
                robot_paused = false;
                print("robot resume!!");
                popup_pause.visible = false;
                timer_check_pause.stop();
            }
        }
    }

    MouseArea{
        id: btn_page
        anchors.fill: parent
        onClicked: {
            if(robot_paused){
                console.log("UI : RESUME");
                supervisor.moveResume();
                timer_check_pause.start();
            }else{
                console.log("UI : PAUSE");
                supervisor.movePause();
                timer_check_pause.start();

            }
        }
    }
}
