import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0
import "."
import io.qt.Supervisor 1.0
import io.qt.Keyemitter 1.0
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

    property string pbefore: pinit
    property string ploading: "qrc:/Page_loading.qml"
    property string pkitchen: "qrc:/Page_kitchen.qml"
    property string pinit: "qrc:/Page_init.qml"
    property string pcharging: "qrc:/Page_charge.qml"
    property string pmap: "qrc:/Page_map.qml"
    property string pmenu: "qrc:/Page_menus.qml"
    property string pmovefail: "qrc:/Page_MoveFail.qml"
    property string pmoving: "qrc:/Page_moving.qml"
    property string ppickup: "qrc:/Page_pickup.qml"
    property string ppickupCall: "qrc:/Page_pickup_calling.qml"
    property string psetting: "qrc:/Page_setting.qml"

    property string robot_type: supervisor.getRobotType()
    property string robot_name: supervisor.getRobotName()
    property var robot_battery: 0

    property int margin_name: 250

    property string cur_location;

    function movelocation(){
        cur_location = supervisor.getcurLoc();
        var str_target;
        supervisor.writelog("[QML - MAIN] MOVE TO "+cur_location);
        if(cur_location.slice(0,4) == "Char"){
            supervisor.writelog("[QML - MOVING] MOVE TO CHARGING LOCATION");
            str_target = "충전 장소";
            voice_movecharge.play();
        }else if(cur_location.slice(0,4) == "Rest"){
            supervisor.writelog("[QML - MOVING] MOVE TO RESTING LOCATION");
            str_target = "대기 장소";
            voice_movewait.play();
        }else{
            voice_serving.play();
            var curtable = supervisor.getcurTable();
            str_target = curtable + "번 테이블";
            supervisor.writelog("[QML - MOVING] MOVE TO " + str_target);
        }
        loadPage(pmoving)
        loader_page.item.pos = str_target;
    }
    function play_avoidmsg(){
        voice_avoid.play();
    }
    function docharge(){
        loadPage(pcharging)
        supervisor.writelog("[QML - MAIN] Do Charging");
    }
    function waitkitchen(){
        loadPage(pkitchen)
        supervisor.writelog("[QML - MAIN] Do Wait Kitchen");
    }
    function movetarget(){
        loadPage(pmoving);
        loader_page.pos = "지정장소";
        supervisor.writelog("[QML - MOVING] MOVE TO " + loader_page.pos);
    }
    function updatecamera(){
        if(loader_page.item.objectName == "page_setting"){
            loader_page.item.update_camera();
        }
    }
    function updatemapping(){
        if(loader_page.item.objectName == "page_map"){
            loader_page.item.update_mapping();
        }
    }

    function pausedcheck(){
        supervisor.writelog("[QML - MAIN] Check Robot Paused");
        if(loader_page.item.objectName == "page_moving"){
            loader_page.item.checkPaused();
        }
    }
    function nopathfound(){
        supervisor.writelog("[QML - MAIN] No path found -> movefail");
        play_avoidmsg();
        if(loader_page.item.objectName == "page_moving"){
            loader_page.item.movefail();
        }
    }
    function movestopped(){
        supervisor.writelog("[QML - MAIN] Move Stopped");
        loadPage(pkitchen);
    }
    function showpickup(){
        robot_type = supervisor.getRobotType();
        if(robot_type == "SERVING"){
            loadPage(ppickup);
            loader_page.item.init();
            var trays = supervisor.getPickuptrays();
            var tempstr = "";
            for(var i=0; i<trays.length; i++){
                if(tempstr == ""){
                    tempstr = Number(trays[i])+"번";
                }else{
                    tempstr += "과 " + Number(trays[i])+"번";
                }
                if(trays[i] == 1){
                    loader_page.item.pickup_1 = true;
                }else if(trays[i] == 2){
                    loader_page.item.pickup_2 = true;
                }else if(trays[i] == 3){
                    loader_page.item.pickup_3 = true;
                }
            }
            loader_page.item.pos = tempstr;
            supervisor.writelog("[QML - MAIN] Show Pickup Page : " + loader_page.item.pos);
        }else if(robot_type == "CALLING"){
            loadPage(ppickupCall);
        }
    }
    function loadmap_server_fail(){
        loader_page.item.loadmap_server(false);
    }
    function loadmap_server_success(){
        loader_page.item.loadmap_server(true);
    }

    function updatepatrol(){
        if(loader_page.item.objectName == "page_map")
            loader_page.item.updatepatrol();
    }
    function updatecanvas(){
        print(loader_page.item.objectName);
        if(loader_page.item.objectName == "page_map")
            loader_page.item.updatecanvas();
    }
    function updateobject(){
        if(loader_page.item.objectName == "page_map")
            loader_page.item.updateobject();
    }
    function updatelocation(){
        if(loader_page.item.objectName == "page_map")
            loader_page.item.updatelocation();
    }
    function updatetravelline(){
        if(loader_page.item.objectName == "page_map")
            loader_page.item.updatetravelline();
    }
    function updatetravelline2(){
        if(loader_page.item.objectName == "page_map")
            loader_page.item.updatetravelline2();
    }
    function updatepath(){
        if(loader_page.item.objectName == "page_map")
            loader_page.item.updatepath();
    }

    function newcall(){
        if(loader_page.item.objectName == "page_kitchen"){

        }else{
            supervisor.acceptCall(false);
        }
    }

    function loadPage(page){
        pbefore = loader_page.source;
        loader_page.source = page;
    }

    function backPage(){
        loader_page.source = pbefore;
    }

    function update_ini(){
        robot_type = supervisor.getRobotType()
        robot_name = supervisor.getRobotName()
    }

    Keyemitter{
        id: emitter
    }

    Loader{
        id: loader_page
        focus: true
        anchors.fill: parent
        onLoaded: {
            supervisor.writelog("[QML] Load Page : "+source);
            timer_update.start();
        }
        source: pinit
    }

    Supervisor{
        id:supervisor
    }

    Timer{
        id: timer_update
        interval: 3000
        triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: {
            statusbar.curTime = Qt.formatTime(new Date(), "hh:mm")
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
        volume: Number(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_move_wait.mpga"
    }
    Audio{
        id: voice_movecharge
        autoPlay: false
        volume: Number(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_move_charge.mp3"
    }
    Audio{
        id: voice_serving
        autoPlay: false
        volume: Number(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_start_serving1.mp3"
    }
    Audio{
        id: voice_avoid
        autoPlay: false
        volume: Number(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_avoid.mp3"
    }

    Item_statusbar{
        id: statusbar
        visible: false
    }
}
