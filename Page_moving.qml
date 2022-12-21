import QtQuick 2.12
import QtQuick.Controls 2.12
import "."
import io.qt.Supervisor 1.0
import QtMultimedia 5.12

Item {
    id: page_moving
    objectName: "page_moving"
    width: 1280
    height: 800

    property string pos: "1번 테이블"
    property bool robot_paused: false
    property bool move_fail: false
    property int password: 0

    Component.onCompleted: {
        init();
    }
    Component.onDestruction:  {
        playMusic.stop();
    }

    function init(){
        popup_pause.visible = false;
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

    Rectangle{
        id: rect_background
        anchors.fill: parent
        color: "#282828"
    }
    Image{
        id: image_robot
        source: {
            if(pos == "충전 장소"){
                "image/robot_move_charge.png"
            }else if(pos == "대기 장소"){
                "image/robot_move_wait.png"
            }else{
                "image/robot_moving.png"
            }
        }
        width: 300
        height: 270
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 200
    }

    Row{
        id: text_moving
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: image_robot.bottom
        anchors.topMargin: 80
        Text{
            id: target_pos
            text: pos
            font.pixelSize: 40
            font.family: font_noto_b.name
            color: "#12d27c"
        }
        Text{
            id: text_mention
            text: "(으)로 이동 중입니다."
            font.pixelSize: 40
            font.family: font_noto_r.name
            color: "white"
        }
    }

    Item{
        id: popup_pause
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        Rectangle{
            anchors.fill: parent
            visible: robot_paused
            color: "#282828"
            opacity: 0.8
        }
        Image{
            id: image_warning
            source: "icon/icon_warning.png"
            width: 160
            height: 160
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 250
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:image_warning.bottom
            anchors.topMargin: 30
            font.family: font_noto_b.name
            font.pixelSize: 40
            color: "#e2574c"
            text: move_fail?"패스를 찾을 수 없습니다.":"일시정지 됨"
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
                loadPage(pmovefail);
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
