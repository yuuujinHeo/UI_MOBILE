import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.12
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
    property bool move_fail: false
    property int password: 0

    function loadmap(path){
        pMap_curmap.loadmap(path);
    }
    function updatepath(){
        pMap_curmap.updatepath();
    }
    function init(){
        robot_paused = false;
        playMusic.play();
    }
    function stopMusic(){
        playMusic.stop();
    }
    function checkPaused(){
        timer_check_pause.start();
    }

    function movefail(){
        robot_paused = true;
        move_fail = true;
    }

    Audio{
        id: playMusic
        autoPlay: false
        source: "bgm/song.mp3"
        loops: 99
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
    Map_current{
        id: pMap_curmap
        anchors.right:parent.right
        anchors.bottom:parent.bottom
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
            text: move_fail?"패스를 찾을 수 없습니다.":"일시정지"
        }
        MouseArea{
            id: btn_page_popup
            anchors.fill: parent
            onClicked: {
                password = 0;
                if(robot_paused){
                    move_fail = false;
                    console.log("UI : RESUME");
                    supervisor.moveResume();
                    timer_check_pause.start();
                }else{
                    move_fail = false;
                    console.log("UI : PAUSE");
                    supervisor.movePaused();
                    timer_check_pause.start();
                }
            }
        }
    }
    MouseArea{
        id: btn_password_1
        width: 100
        height: 100
        enabled: robot_paused
        anchors.top: parent.top
        anchors.left: parent.left
        z: 99
        onClicked: {
            password++;
            print(password);
            if(password > 4){
                password = 0;
                stackview.push(pmovefail);
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
                popup_pause.visible = true;
                print("robot_paused = true");
                timer_check_pause.stop();
            }else if(supervisor.getRobotState() == 5){
                robot_paused = true;
                popup_pause.visible = true;
                print("robot_paused = true, move fail");
                move_fail = true;
                timer_check_pause.stop();
            }else{
                popup_pause.visible = false;
                robot_paused = false;
                print("robot_paused = false");
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
