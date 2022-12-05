import QtQuick 2.12
import QtQuick.Controls 2.12
import "."
import io.qt.Supervisor 1.0

Item {
    id: page_movefail
    objectName: "page_movefail"
    width: 1280
    height: 800

    function loadmap(path){
        pMap_curmap.loadmap_mini();
    }

    Text{
        id: text
        text:"목적지로 이동하는데 실패하였습니다.\n 주변에 방해되는 요소를 제거하거나 로봇을 수동으로 이동시켜주세요."
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        horizontalAlignment: Text.AlignHCenter
        anchors.topMargin: 30
        font.pixelSize: 20
    }

    Map_current{
        id: pMap_curmap
        width: 500
        height: 500
        anchors.top: text.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item_joystick{
        id: joy_xy
        anchors.right: pMap_curmap.left
        anchors.rightMargin: 100
        anchors.verticalCenter: parent.verticalCenter
        verticalOnly: true
        onUpdate_cntChanged: {
            if(update_cnt == 0){
                supervisor.joyMoveXY(0, 0);
            }else{
                if(fingerInBounds) {
                    supervisor.joyMoveXY(Math.sin(angle) * Math.sqrt(fingerDistance2) / distanceBound);
                }else{
                    supervisor.joyMoveXY(Math.sin(angle));
                }
            }
        }
    }

    Item_joystick{
        id: joy_th
        anchors.left: pMap_curmap.right
        anchors.leftMargin: 100
        anchors.verticalCenter: parent.verticalCenter
        horizontalOnly: true
        onUpdate_cntChanged: {
            if(update_cnt == 0){
                supervisor.joyMoveR(0, 0);
            }else{
                if(fingerInBounds) {
                    supervisor.joyMoveR(-Math.cos(angle) * Math.sqrt(fingerDistance2) / distanceBound);
                } else {
                    supervisor.joyMoveR(-Math.cos(angle));
                }
            }
        }
    }

    Rectangle{
        id: btn_resume
        width: 100
        height: 100
        anchors.top: pMap_curmap.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        color: "gray"
        Text{
            text: "경로 재탐색"
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                timer_check_pause.start();
            }
        }
    }

    Timer{
        id: timer_check_pause
        interval: 500
        running: false
        repeat: true
        onTriggered: {
            print(supervisor.getRobotState());
            if(supervisor.getRobotState() == 4){
                supervisor.moveResume();
            }else{
                pmoving.checkPaused();
                stackview.pop();
                timer_check_pause.stop();
            }
        }
    }
    Rectangle{
        id: btn_stop
        width: 100
        height: 100
        anchors.top: pMap_curmap.bottom
        anchors.topMargin: 30
        anchors.right: btn_resume.left
        anchors.rightMargin: 50
        color: "gray"
        Text{
            text: "경로 취소"
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                supervisor.moveStop();
            }
        }
    }
    Rectangle{
        id: btn_manual
        width: 100
        height: 100
        anchors.top: pMap_curmap.bottom
        anchors.topMargin: 30
        anchors.left: btn_resume.right
        anchors.leftMargin: 50
        color: "gray"
        Text{
            text: "수동 밀기"
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                supervisor.moveManual();
            }
        }
    }
}
