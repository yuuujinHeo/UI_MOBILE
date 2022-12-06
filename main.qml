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
//            mainwindow.visibility = Window.FullScreen;
//        }
//    }


    property string curloc;

    function movelocation(){
        curloc = supervisor.getcurLoc();
        console.log("moving. location : " + curloc.slice(0,4));
        if(curloc.slice(0,4) == "char"){
            pmoving.pos = "충전 장소";
            voice_movecharge.play();
        }else if(curloc.slice(0,4) == "rest"){
            pmoving.pos = "대기 장소";
            voice_movewait.play();
        }else{
            voice_serving.play();
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

    function play_avoidmsg(){
        voice_avoid.play();
    }

    function docharge(){
        if(stackview.currentItem.objectName != "page_kitchen"){
            pkitchen.init();
            pmoving.stopMusic();
            stackview.pop();
        }
        pcharge.init();
        stackview.push(pcharge);
    }

    function waitkitchen(){
        if(stackview.currentItem.objectName != "page_kitchen"){
            pkitchen.init();
            pmoving.stopMusic();
            stackview.pop();
        }
    }
    function disconnected(){

    }
    function connected(){

    }

    function movetarget(){
        pmoving.pos = "지정장소";
        pmoving.init();
        stackview.push(pmoving);
    }

    function movejog(){

    }

    function pausedcheck(){
        pmoving.checkPaused();
    }

    function movemanual(){

    }
    function nopathfound(){
        play_avoidmsg();
        pmoving.movefail();
    }
    function robotresume(){

    }

    function movestopped(){
        pmoving.stopMusic();
        pkitchen.init();
        while(stackview.currentItem.objectName != "page_kitchen"){
            print(stackview.currentItem.objectName," pop");
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
    function newcall(){
        if(stackview.currentItem.objectName == "page_kitchen"){

        }else{
            supervisor.acceptCall(false);
        }
    }

    function updatepath(){
        pmap.updatepath();
    }
    function loadmap(){

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
    Map_minimap{
        id: pminimap;
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

    Timer{
        id: timer_init
        interval: 3000
        running: true
        repeat: false
        onTriggered: {
            if(pinit.init_mode == 4){
                pkitchen.init();
                stackview.push(pkitchen);
                print("init all done. pass to kitchen page")
            }else{
                stackview.push(pinit);
            }
        }
    }

    Timer{
        id: timer_update
        interval: 5000
        triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: {
            pkitchen.curTime = Qt.formatTime(new Date(), "hh:mm")
            pkitchen.battery = supervisor.getBattery();
            pkitchen.robotName = supervisor.getRobotName();
            pmap.curTime = Qt.formatTime(new Date(), "hh:mm")
            pmap.battery = supervisor.getBattery();
            pmap.robotName = supervisor.getRobotName();
            pmap.robotname_margin = pkitchen.robotname_margin;
            pmap.tray_center = pkitchen.tray_center;
            pmenus.curTime = Qt.formatTime(new Date(), "hh:mm")
            pmenus.battery = supervisor.getBattery();
            pmenus.robotName = supervisor.getRobotName();
            pmenus.robotname_margin = pkitchen.robotname_margin;
            pmenus.tray_center = pkitchen.tray_center;
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

}
