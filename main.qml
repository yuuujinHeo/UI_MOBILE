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

//import QtQuick 2.12
//import QtQuick.Window 2.12
//import QtQuick.Controls 2.12
//import QtQuick.Shapes 1.12
//import QtQuick.Dialogs 1.2
//import Qt.labs.platform 1.0
//import QtGraphicalEffects 1.12
//import QtQuick.Templates 2.5

Window {
    visible: true
    width: 1280
    height: 800
    title: qsTr("Hello World")
//    flags: Qt.Window | Qt.FramelessWindowHint
//    visibility: Window.FullScreen

    property string curloc;

    function movelocation(){
        curloc = supervisor.getcurLoc();
        console.log("moving. location : " + curloc.slice(0,4));
        if(curloc.slice(0,4) == "char"){
            pmoving.pos = "충전기";
        }else if(curloc.slice(0,4) == "wait"){
            pmoving.pos = "대기장소";
        }else{
            var curtable = supervisor.getcurTable();
            pmoving.pos = curtable + "번 테이블";
        }
        if(stackview.currentItem.objectName != "page_kitchen"){
            pmoving.stopMusic();
            stackview.pop();
        }
        pmoving.init();
        stackview.push(pmoving);
    }

    function docharge(){
        if(stackview.currentItem.objectName != "page_kitchen"){
            pkitchen.init();
            pmoving.stopMusic();
            stackview.pop();

        }
        stackview.push(pcharge);
    }

    function waitkitchen(){
        if(stackview.currentItem.objectName != "page_kitchen"){
            pkitchen.init();
            pmoving.stopMusic();
            stackview.pop();
        }
    }

    function movetarget(){
        pmoving.pos = "지정장소";
        pmoving.init();
        stackview.push(pmoving);
    }

    function movejog(){

    }
    function movepaused(){
        pmoving.robot_paused = true;
        pmoving.popup_pause.visible = true;
    }
    function moveresumed(){
        pmoving.robot_paused = false;
        pmoving.popup_pause.visible = false;
    }

    function movemanual(){

    }
    function movestop(){

    }
    function showpickup(){
        pmoving.stopMusic();
        stackview.pop();
        var trays = supervisor.getPickuptrays();
        var tempstr = "";
        for(var i=0; i<trays.length; i++){
            if(tempstr == ""){
                tempstr = Number(trays[i])+"번";
            }else{
                tempstr += "과 " + Number(trays[i])+"번";
            }
        }
        ppickup.pos = tempstr;

        ppickup.init();
        stackview.push(ppickup);
    }

    Page_kitchen{
        id: pkitchen;
        visible: false
    }
    Page_setting{
        id: psetting;
        visible: false
    }

    Page_jog{
        id: pjog;
        visible: false
    }
    Page_mapview{
        id: pmapview;
        visible: false
    }
    Page_menus{
        id: pmenus;
        visible: false
    }
    Page_moving{
        id: pmoving;
        visible: false
    }
    Page_pickup{
        id: ppickup;
        visible: false
    }
    Page_charge{
        id: pcharge;
        visible: false
    }

    Supervisor{
        id:supervisor
    }

    Map_current{
        id:curMap
        visible: false
    }

    Timer{
        id: timer_init
        interval: 2000
        running: true
        repeat: false
        onTriggered: {
            stackview.push(pkitchen);
//            stackview.push(curMap);
        }
    }


    Timer{
        id: timer_update
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            pkitchen.curTime = Qt.formatTime(new Date(), "hh:mm")
            pkitchen.battery = supervisor.getBattery();
            pkitchen.robotName = supervisor.getRobotName();
            pcharge.curTime = Qt.formatTime(new Date(), "hh:mm")
            pcharge.battery = supervisor.getBattery();
            pcharge.robotName = supervisor.getRobotName();
        }
    }


    StackView{
        id: stackview
        anchors.fill: parent

        replaceEnter: Transition { PropertyAnimation {//뷰를 replace 한 화면이 그려질때 출력하는 애니메이션
                property: "opacity"
                from: 1
                to:1
                duration: 0
        }}
        replaceExit: Transition { PropertyAnimation {//뷰를 replace 한 화면이 그려질때 이전화면이 없어지는 애니메이션
                property: "opacity"
                from: 1
                to:1
                duration: 0
        }}
        pushEnter: Transition { PropertyAnimation { //뷰를 push 한 화면이 그려지는 애니메이션
                property: "opacity"                 //투명도가 설정 되게 설정 x,나 y등 다른 속성값으로 설정할수 있음
                from: 0.5                           //투명도를 1에서 1로 바꿔줌 즉 투명도가 변하지 않아서 애니메이션이 없는 것처럼 된다.
                to:1
                duration: 0
        }}
        pushExit: Transition { PropertyAnimation {  //뷰를 push 한 화면이 그려질때 이전화면이 없어지는 애니메이션
                property: "opacity"                 //투명도가 설정 되게 설정 x,나 y등 다른 속성값으로 설정할수 있음
                from: 0.5
                to:1                                //투명도를 1에서 1로 바꿔줌 즉 투명도가 변하지 않아서 애니메이션이 없는 것처럼 된다.
                duration: 0
        }}
        popEnter: Transition { PropertyAnimation { //뷰를 push 한 화면이 그려지는 애니메이션
                property: "opacity"                 //투명도가 설정 되게 설정 x,나 y등 다른 속성값으로 설정할수 있음
                from: 0.5                           //투명도를 1에서 1로 바꿔줌 즉 투명도가 변하지 않아서 애니메이션이 없는 것처럼 된다.
                to:1
                duration: 0
        }}
        popExit: Transition { PropertyAnimation {  //뷰를 push 한 화면이 그려질때 이전화면이 없어지는 애니메이션
                property: "opacity"                 //투명도가 설정 되게 설정 x,나 y등 다른 속성값으로 설정할수 있음
                from: 0.5
                to:1                                //투명도를 1에서 1로 바꿔줌 즉 투명도가 변하지 않아서 애니메이션이 없는 것처럼 된다.
                duration: 0
        }}


        initialItem: Item {
            objectName: "page_logo"
            Rectangle{
                anchors.centerIn: parent
                width: 748//image_logo.width
                height: 335//image_logo.height

                OpacityAnimator{
                    target: image_logo;
                    from: 0;
                    to: 1;
                    duration: 3000
                    running: true
                }

                Image{
                    id: image_logo
                    source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
                    anchors.fill: parent
                }
            }
        }
    }

}
