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

    property string pos_name: ""
    property string pos: "1번 테이블"
    property bool robot_paused: false
    property bool move_fail: false
    property int password: 0
    property bool show_face: false
    Component.onCompleted: {
        init();
        print(statusbar.height);
        statusbar.visible = false;
    }
    Component.onDestruction:  {
        playMusic.stop();
    }

    function init(){
        supervisor.writelog("[QML] MOVING PAGE init")

        popup_pause.visible = false;
        if(supervisor.getSetting("ROBOT_SW","moving_face")==="true"){
            resting_image.visible = true;
            image_robot.visible = false;
            show_face = true;
        }else{
            show_face = false;
            resting_image.visible = false;
            image_robot.visible = true;
        }

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
        volume: parseInt(supervisor.getSetting("ROBOT_SW","volume_bgm"))/100
        source: "bgm/song.mp3"
        loops: 99
    }

    Rectangle{
        id: rect_background
        anchors.fill: parent
        color: "#282828"
    }
    AnimatedImage{
        id: resting_image
        visible: false
        source: "image/temp.gif"
        anchors.fill: parent
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

    Text{
        id: target_pos
        text: pos
        visible: !show_face
        font.pixelSize: 40
        font.family: font_noto_b.name
        anchors.right: parent.horizontalCenter
        anchors.top: image_robot.bottom
        anchors.topMargin: 80
        anchors.rightMargin: 40
        color: "#12d27c"
    }
    Text{
        id: text_mention
        visible: !show_face
        text: "(으)로 이동 중입니다."
        font.pixelSize: 40
        font.family: font_noto_r.name
        anchors.left: parent.horizontalCenter
        anchors.top: image_robot.bottom
        anchors.topMargin: 80
        anchors.leftMargin: 40
        color: "white"
    }
    Text{
        id: target_posname
        text: pos_name
        visible: !show_face
        font.pixelSize: 40
        font.family: font_noto_b.name
        color: "#12d27c"
        anchors.horizontalCenter: target_pos.horizontalCenter
        anchors.top: target_pos.bottom
        anchors.topMargin: 10
    }

    Item{
        id: popup_pause
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        onVisibleChanged: {
            if(visible){
                statusbar.visible = true;
            }else{
                statusbar.visible = false;
            }
        }

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
            text: move_fail?"경로를 찾을 수 없습니다.":"일시정지 됨"
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 80
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            Rectangle{
                width: 180
                height: 120
                radius: 20
                color: "transparent"
                border.color: color_red
                border.width: 6
                Text{
                    anchors.centerIn: parent
                    color: color_red
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    text: "수동 이동"
                }
                MouseArea{
                    anchors.fill: parent
                    z: 99
                    onClicked:{
                        supervisor.writelog("[USER INPUT] MOVING PAUSED : MOTOR LOCK DISABLE");
                    }
                }
            }
            Rectangle{
                width: 180
                height: 120
                radius: 20
                color: "transparent"
                border.color: color_red
                border.width: 6
                Text{
                    anchors.centerIn: parent
                    color: color_red
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    text: "경로 취소"
                }
                MouseArea{
                    anchors.fill: parent
                    z: 99
                    propagateComposedEvents: true
                    onPressed:{
                        parent.color = color_dark_navy
                    }
                    onReleased:{
                        parent.color = "transparent"
                    }

                    onClicked:{
                        supervisor.writelog("[USER INPUT] MOVING PAUSED : PATH CANCELED");
                        supervisor.moveStop();
                    }
                }
            }
            Rectangle{
                width: 180
                height: 120
                radius: 20
                color: "transparent"
                border.color: color_red
                border.width: 6
                Text{
                    anchors.centerIn: parent
                    color: color_red
                    font.family: font_noto_r.name
                    font.pixelSize: 30
                    text: "경로 재개"
                }
                MouseArea{
                    anchors.fill: parent
                    z: 99
                    onClicked:{
                        supervisor.writelog("[USER INPUT] MOVING PAUSED : RESUME");
                        supervisor.moveResume();
                        timer_check_pause.start();
                    }
                }
            }
        }
//        MouseArea{
//            id: btn_page_popup
//            anchors.fill: parent
//            onClicked: {
//                print(btn_page_popup.enabled, btn_page_popup.visible);
//                password = 0;
//                if(robot_paused){
//                    move_fail = false;
//                    supervisor.writelog("[USER INPUT] MOVING RESUME")
//                    supervisor.moveResume();
//                    timer_check_pause.start();
//                }else{
//                    move_fail = false;
//                    supervisor.writelog("[USER INPUT] MOVING PAUSE")
//                    supervisor.movePaused();
//                    timer_check_pause.start();
//                }
//            }
//        }
    }


    MouseArea{
        id: btn_password_1
        width: 100
        height: 100
        enabled: robot_paused
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        z: 99
        onClicked: {
            password++;
            supervisor.writelog("[USER INPUT] MOVING PASSWORD "+Number(password));
            if(password > 4){
                password = 0;
                supervisor.writelog("[USER INPUT] ENTER THE MOVEFAIL PAGE "+Number(password));
                loadPage(pmovefail);
                loader_page.item.setNotice(3);
            }
        }
    }

    Timer{
        id: timer_check_pause
        interval: 500
        running: false
        repeat: true
        onTriggered: {
            if(supervisor.getStateMoving() === 4){
                robot_paused = true;
                popup_pause.visible = true;
                supervisor.writelog("[QML] CHECK MOVING STATE : PAUSED")
                timer_check_pause.stop();
            }else if(supervisor.getStateMoving() === 0){
                robot_paused = true;
                popup_pause.visible = true;
                supervisor.writelog("[QML] CHECK MOVING STATE : NOT READY")
                move_fail = true;
                timer_check_pause.stop();
            }else{
                popup_pause.visible = false;
                robot_paused = false;
                supervisor.writelog("[QML] CHECK MOVING STATE : "+Number(supervisor.getStateMoving()));
                timer_check_pause.stop();
            }
        }
    }

    MouseArea{
        id: btn_page
        anchors.fill: parent
        visible: !robot_paused
        onClicked: {
            if(robot_paused){
                supervisor.writelog("[USER INPUT] MOVING RESUME 2")
                supervisor.moveResume();
                timer_check_pause.start();
            }else{
                supervisor.writelog("[USER INPUT] MOVING PAUSE 2")
                supervisor.movePause();
                timer_check_pause.start();

            }
        }
    }
}
