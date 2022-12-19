import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0
import "."
import io.qt.Supervisor 1.0
import QtMultimedia 5.12

Window {
    id: mainwindow
    visible: true
    width: 1280
    height: 800
    title: qsTr("Hello World")
//    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint |Qt.WindowStaysOnTopHint |Qt.WindowOverridesSystemGestures |Qt.MaximizeUsingFullscreenGeometryHint
//    visibility: Window.FullScreen

//    onVisibilityChanged: {
//        if(mainwindow.visibility == Window.Minimized){
//            print("minimized");
//        }else if(mainwindow.visibility == Window.FullScreen){
//            print("fullscren");
//        }else{
//            supervisor.writelog("[QML - MAIN] Window show fullscreen");
//            mainwindow.visibility = Window.FullScreen;
//        }
//    }

    property string curloc;
    function movelocation(){
        curloc = supervisor.getcurLoc();
        supervisor.writelog("[QML - MAIN] MOVE TO "+curloc);
        if(curloc.slice(0,4) == "char"){
            supervisor.writelog("[QML - MOVING] MOVE TO CHARGING LOCATION");
            pmoving.pos = "충전 장소";
            voice_movecharge.play();
        }else if(curloc.slice(0,4) == "rest"){
            supervisor.writelog("[QML - MOVING] MOVE TO RESTING LOCATION");
            pmoving.pos = "대기 장소";
            voice_movewait.play();
        }else{
            voice_serving.play();
            var curtable = supervisor.getcurTable();
            pmoving.pos = curtable + "번 테이블";
            supervisor.writelog("[QML - MOVING] MOVE TO " + pmoving.pos);
        }

        if(stackview.currentItem.objectName != "page_kitchen"){
            supervisor.writelog("[QML - MAIN] current page : "+stackview.currentItem.objectName+" -> pop");
            pmoving.stopMusic();
            stackview.pop();
        }

        pmoving.init();
        stackview.push(pmoving);
    }
    function play_avoidmsg(){
        voice_avoid.play();
    }
    function docharge(){
        if(stackview.currentItem.objectName != "page_kitchen"){
            supervisor.writelog("[QML - MAIN] current page : "+stackview.currentItem.objectName+" -> pop");
            pkitchen.init();
            pmoving.stopMusic();
            stackview.pop();
        }
        supervisor.writelog("[QML - MAIN] Do Charging");
        pcharge.init();
        stackview.push(pcharge);
    }
    function waitkitchen(){
        if(stackview.currentItem.objectName != "page_kitchen"){
            supervisor.writelog("[QML - MAIN] current page : "+stackview.currentItem.objectName+" -> pop");
            pkitchen.init();
            pmoving.stopMusic();
            stackview.pop();
        }
        supervisor.writelog("[QML - MAIN] Do Wait Kitchen");
    }
    function movetarget(){
        pmoving.pos = "지정장소";
        supervisor.writelog("[QML - MOVING] MOVE TO " + pmoving.pos);
        pmoving.init();
        stackview.push(pmoving);
    }
    function pausedcheck(){
        supervisor.writelog("[QML - MAIN] Check Robot Paused");
        pmoving.checkPaused();
    }
    function nopathfound(){
        supervisor.writelog("[QML - MAIN] No path found -> movefail");
        play_avoidmsg();
        pmoving.movefail();
    }
    function movestopped(){
        supervisor.writelog("[QML - MAIN] Move Stopped");
        pmoving.stopMusic();
        pkitchen.init();
        while(stackview.currentItem.objectName != "page_kitchen"){
            supervisor.writelog("[QML - MAIN] current page : "+stackview.currentItem.objectName+" -> pop");
            stackview.pop();
        }
    }
    function showpickup(){
        pmoving.stopMusic();
        stackview.pop();
        ppickup.init();
        var trays = supervisor.getPickuptrays();
        var tempstr = "";
        for(var i=0; i<trays.length; i++){
            if(tempstr == ""){
                tempstr = Number(trays[i])+"번";
            }else{
                tempstr += "과 " + Number(trays[i])+"번";
            }
            if(trays[i] == 1){
                ppickup.pickup_1 = true;
            }else if(trays[i] == 2){
                ppickup.pickup_2 = true;
            }else if(trays[i] == 3){
                ppickup.pickup_3 = true;
            }
        }
        ppickup.pos = tempstr;
        supervisor.writelog("[QML - MAIN] Show Pickup Page : " + ppickup.pos);
        stackview.push(ppickup);
    }

    function updatepatrol(){
        pmap.updatepatrol();
    }
    function updatecanvas(){
        pmap.updatecanvas();
    }
    function updateobject(){
        pmap.updateobject();
    }
    function updatelocation(){
        pmap.updatelocation();
    }
    function updatetravelline(){
        pmap.updatetravelline();
    }
    function updatepath(){
        pmap.updatepath();
    }

    function newcall(){
        if(stackview.currentItem.objectName == "page_kitchen"){

        }else{
            supervisor.acceptCall(false);
        }
    }


    Page_kitchen{
        id: pkitchen;
        visible: false
    }
    Page_init{
        id:pinit;
        visible: false
    }
    Page_MoveFail{
        id:pmovefail
        visible: false
    }
    Page_setting{
        id: psetting;
        visible: false
    }
    Page_map{
        id: pmap;
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
    Page_pickup_calling{
        id: ppickup_calling
        visible: false
    }

    Timer{
        id: timer_init
        interval: 1000
        running: true
        repeat: false
        onTriggered: {
            if(pinit.init_mode == 4){
                pkitchen.init();
                stackview.push(pkitchen);
                supervisor.writelog("[QML - INIT] Init All Pass -> Wait Kitchen");
            }else{
                supervisor.writelog("[QML - INIT] Init Failed -> Show Init Page");
                stackview.push(pinit);
//                pmovefail.init();
//                stackview.push(pmovefail);
            }
        }
    }

    Timer{
        id: timer_update
        interval: 3000
        triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: {
            statusbar.curTime = Qt.formatTime(new Date(), "hh:mm")
            statusbar.battery = supervisor.getBattery();
            statusbar.robotName = supervisor.getRobotName();
            statusbar.robotname_margin = pkitchen.robotname_margin;
            statusbar.tray_center = pkitchen.tray_center;
            pmap.tray_center = pkitchen.tray_center;
            pmap.robotname_margin = pkitchen.robotname_margin;

        }
    }

    FontLoader{
        id: font_noto_b
        source: "font/NotoSansKR-Medium.otf"
    }
    FontLoader{
        id: font_noto_r
        source: "font/NotoSansKR-Light.otf"
    }

    Audio{
        id: voice_movewait
        autoPlay: false
        source: "bgm/voice_move_wait.mpga"
    }
    Audio{
        id: voice_movecharge
        autoPlay: false
        source: "bgm/voice_move_charge.mp3"
    }
    Audio{
        id: voice_serving
        autoPlay: false
        source: "bgm/voice_start_serving.mp3"
    }
    Audio{
        id: voice_avoid
        autoPlay: false
        source: "bgm/voice_avoid.mp3"
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
                anchors.fill: parent
                color: "#f4f4f4"

                OpacityAnimator{
                    target: image_logo;
                    from: 0;
                    to: 1;
                    duration: 2000
                    running: true
                }

                Image{
                    id: image_logo
                    width: 748/1.5
                    height: 335/1.5
                    source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
                    anchors.horizontalCenter:  parent.horizontalCenter
                    y: text_copyright.y / 2 - height/2
                }

                Text{
                    id: text_copyright
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 100
                    text: "Copyrights Rainbow Robotics Inc. All rights reserved."
                    color: "#7e7e7e"
                    font.family: font_noto_b.name
                    font.pixelSize: 15
                }
            }
        }
    }

    Item_statusbar{
        id: statusbar
        visible: false
    }
}
