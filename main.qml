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
import io.qt.Loading 1.0
import io.qt.MapView 1.0

Window {
    id: mainwindow
    visible: true
    width: 1280
    height: 800
    title: qsTr("Hello World")

    flags: homePath.split("/")[2]==="odroid"?Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint |Qt.WindowStaysOnTopHint |Qt.WindowOverridesSystemGestures |Qt.MaximizeUsingFullscreenGeometryHint:Qt.Window
    visibility: homePath.split("/")[2]==="odroid"?Window.FullScreen:Window.Windowed
//    visibility: Window.FullScreen
    onVisibilityChanged: {
        if(homePath.split("/")[2]==="odroid"){
            if(mainwindow.visibility == Window.Minimized){
                print("minimized");
            }else if(mainwindow.visibility == Window.FullScreen){
                print("fullscreen");
            }else{
                supervisor.writelog("[QML - MAIN] Window show fullscreen");
                mainwindow.visibility = Window.FullScreen;
            }
        }
    }

    Component.onDestruction: {

    }

    property color color_dark_gray: "#999999";
    property color color_red: "#E7584D"
    property color color_mid_gray: "#BEBEBE"
    property color color_green: "#12d27c"
    property color color_mid_green: "#0FB168"
    property color color_yellow: "#F7DB0D"
    property color color_dark_black: "#282828"
    property color color_gray: "#d8d8d8"
    property color color_light_gray: "#F4F4F4"
    property color color_navy: "#4f5666"
    property color color_dark_navy: "#323744"
    property color color_mid_navy: "#242535"
    property color color_blue: "#24a9f7"
    property color color_yellow_rect: "#ffc850"

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
    property string plog: "qrc:/Page_log.qml"

    property string pmapping: "qrc:/Page_mapping.qml"
    property string pannotation: "qrc:/Page_annotation.qml"


    property string robot_type: supervisor.getRobotType()
    property string robot_name: supervisor.getRobotName()
    property var robot_battery: 0

    property var count_resting: 0

    property string cur_location;

    function movefail(){
        if(loader_page.item.objectName == "page_annotation"){
            if(supervisor.getEmoStatus()){
                loader_page.item.movefail(2);
                voice_all_stop();
                voice_emergency.play();
            }else if(supervisor.getMotorState() === 0){
                loader_page.item.movefail(4);
                voice_all_stop();
            }else if(supervisor.getLocalizationState() === 0 || supervisor.getLocalizationState() === 3){
                loader_page.item.movefail(1);
                voice_all_stop();
                voice_localfail.play();
            }else if(supervisor.getStateMoving() === 0){
                loader_page.item.movefail(0);
                voice_all_stop();
                play_movefailmsg();
            }else{
                supervisor.writelog("[MOVEFAIL] WEIRED MOVEFAIL : "+supervisor.getStateMoving().toString()+","+supervisor.getLocalizationState().toString()+","+supervisor.getMotorState().toString())
            }
        }else if(loader_page.item.objectName == "page_movefail" || loader_page.item.objectName == "page_map" || loader_page.item.objectName == "page_setting"){

        }else{
            //0: no path /1: local fail /2: emergency /3: user stop /4: motor error
            if(supervisor.getEmoStatus()){
                loadPage(pmovefail);
                loader_page.item.setNotice(2);
                voice_all_stop();
                voice_emergency.play();
                print("movefail emergency")
            }else if(supervisor.getMotorState() === 0){

                loadPage(pmovefail);
                loader_page.item.setNotice(4);
                voice_all_stop();
//                voice_motor_error.play();
                print("movefail motor")
            }else if(supervisor.getLocalizationState() === 0 || supervisor.getLocalizationState() === 3){

                loadPage(pmovefail);
                loader_page.item.setNotice(1);
                voice_all_stop();
                voice_localfail.play();
                print("movefail local")
            }else if(supervisor.getStateMoving() === 0){
                loadPage(pmovefail);
                loader_page.item.setNotice(0);
                voice_all_stop();
                play_movefailmsg();
                print("movefail no path")
            }else{
                supervisor.writelog("[MOVEFAIL] WEIRED MOVEFAIL : "+supervisor.getStateMoving().toString()+","+supervisor.getLocalizationState().toString()+","+supervisor.getMotorState().toString())
            }
        }
    }
    function voice_all_stop(){
        voice_avoid.stop();
        voice_emergency.stop();
        voice_localfail.stop();
        voice_motor_error.stop();
        voice_movecharge.stop();
        voice_movefail.stop();
        voice_movewait.stop();
        voice_serving.stop();
        voice_calling.stop();
        voice_battery.stop();
    }

    function stateinit(){
        if(loader_page.item.objectName != "page_map")
            loadPage(pinit);
    }
    function lessbattery(){
        voice_battery.play();
    }

    function checkwifidone(){
        if(loader_page.item.objectName == "page_init"){
            loader_page.item.wifistatein();
        }
    }

    function movelocation(){
        cur_location = supervisor.getcurLoc();
        var str_target;
        supervisor.writelog("[QML - MAIN] MOVE TO "+cur_location);
        if(cur_location == "Charging"){
            supervisor.writelog("[QML - MOVING] MOVE TO CHARGING LOCATION");
            str_target = "충전 장소";
            voice_movecharge.play();
        }else if(cur_location == "Resting"){
            supervisor.writelog("[QML - MOVING] MOVE TO RESTING LOCATION");
            str_target = "대기 장소";
            voice_movewait.play();
        }else{
            if(supervisor.isCallingMode()){
                voice_calling.play();
            }else{
                voice_serving.play();
            }
            var curtable = supervisor.getcurTable();
            str_target = curtable + "번 테이블";
            supervisor.writelog("[QML - MOVING] MOVE TO " + str_target);
        }

        if(loader_page.item.objectName == "page_annotation"){
            loader_page.item.movestart();
        }else{
            loadPage(pmoving)
            loader_page.item.pos_name = cur_location;
            loader_page.item.pos = str_target;
        }
    }
    function play_movefailmsg(){
        print("play movefail");
        voice_movefail.play();
    }
    function docharge(){
        if(loader_page.item.objectName == "page_annotation"){
            loader_page.item.movedone();
        }else{
            loadPage(pcharging)
            supervisor.writelog("[QML - MAIN] Do Charging");
        }
    }
    function dochargeininit(){
        loadPage(pcharging)
        loader_page.item.setInit();
        supervisor.writelog("[QML - MAIN] Do Charging");
    }
    function waitkitchen(){
        if(loader_page.item.objectName == "page_annotation"){
            loader_page.item.movedone();
        }else{
            loadPage(pkitchen)
            supervisor.writelog("[QML - MAIN] Do Wait Kitchen");
        }
    }

    function clearkitchen(){
        loadPage(pkitchen)
//        loader_page.item.clearkitchen();
        supervisor.writelog("[QML - MAIN] Do Clear Kitchen");
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
//        mapview.setMap(supervisor.getMapping())
        if(loader_page.item.objectName == "page_map"||loader_page.item.objectName == "page_mapping"){
            loader_page.item.update_mapping();
        }
    }
    function updateobjecting(){
//        mapview.setMap(supervisor.getMapping())
        if(loader_page.item.objectName == "page_map"){
            loader_page.item.update_objecting();
        }
    }
    function pausedcheck(){
        supervisor.writelog("[QML - MAIN] Check Robot Paused");
        if(loader_page.item.objectName == "page_moving"){
            loader_page.item.checkPaused();
        }
    }
    function movestopped(){
        supervisor.writelog("[QML - MAIN] Move Stopped");
        loadPage(pkitchen);
    }
    function showpickup(){
        if(loader_page.item.objectName == "page_annotation"){
            loader_page.item.movedone();
        }else{

            robot_type = supervisor.getRobotType();
            if(supervisor.isCallingMode()){
                loadPage(ppickupCall);
                loader_page.item.init();
            }else{
                loadPage(ppickup);
                loader_page.item.init();
                var trays = supervisor.getPickuptrays();
                var tempstr = "";
                for(var i=0; i<trays.length; i++){
                    if(tempstr === ""){
                        tempstr = Number(trays[i])+"번";
                    }else{
                        tempstr += "과 " + Number(trays[i])+"번";
                    }
                    if(trays[i] === 1){
                        loader_page.item.pickup_1 = true;
                    }else if(trays[i] === 2){
                        loader_page.item.pickup_2 = true;
                    }else if(trays[i] === 3){
                        loader_page.item.pickup_3 = true;
                    }
                }
    //            loader_page.item.play_voice();
                loader_page.item.pos = tempstr;
                supervisor.writelog("[QML - MAIN] Show Pickup Page : " + loader_page.item.pos);
            }

        }
    }
    function loadmap_server_fail(){
        loader_page.item.loadmap_server(false);
    }
    function loadmap_server_success(){
        loader_page.item.loadmap_server(true);
    }
    function fail_localization(){
        if(loader_page.item.objectName !== "page_init"){
            print("main: fail_localization");
            timer_update.start();
            loadPage(pmap);
            loader_page.item.is_init_state = true;
            loader_page.item.map_mode = 4;
            loader_page.item.init();
        }
    }
    function show_loading(){
        supervisor.writelog("[QML] SHOW LOADING")
        rect_loading.open();
    }
    function unshow_loading(){
        supervisor.writelog("[QML] UNSHOW LOADING")
        rect_loading.close();
    }
    function show_resting(){
        rect_resting.open();
    }
    function unshow_resting(){
        rect_resting.close();
    }

    function call_setting(){
        loader_page.item.set_call_done();
    }

    function updatepatrol(){
        if(loader_page.item.objectName == "page_map")
            loader_page.item.updatepatrol();
    }
    function updatecanvas(){
        if(loader_page.item !== "undefined" && loader_page.item !== null)
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
    function excuseme(){
        voice_all_stop();
        voice_avoid.play();
    }
    function newcall(){
        if(loader_page.item.objectName == "page_kitchen"){

        }else{
            supervisor.acceptCall(false);
        }
    }
    function wififailed(){
        print("wififailed")
        if(loader_page.item.objectName == "page_setting" || loader_page.item.objectName == "page_init")
            loader_page.item.wifi_con_failed();
    }
    function wifisuccess(){
        print("wifisuccess")
        if(loader_page.item.objectName == "page_setting" || loader_page.item.objectName == "page_init")
            loader_page.item.wifi_con_success();
    }
    function wifireset(){
        if(loader_page.item.objectName == "page_setting" || loader_page.item.objectName == "page_init")
            loader_page.item.init();
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

    Supervisor{
        id:supervisor
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
            loader_page.item.init();
        }
        source: pinit
    }

    Timer{
        id: timer_update
        interval: 3000
        triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: {
            statusbar.curTime = Qt.formatTime(new Date(), "hh:mm")
            if(loader_page.item.objectName == "page_kitchen"){
                if(count_resting++ > 100){
                    show_resting();
                }
            }else{
                count_resting =0;
            }
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
        volume: parseInt(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_move_wait.mp3"
    }
    Audio{
        id: voice_movecharge
        autoPlay: false
        volume: parseInt(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_move_charge.mp3"
    }
    Audio{
        id: voice_serving
        autoPlay: false
        volume: parseInt(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_start_serving.mp3"
    }
    Audio{
        id: voice_calling
        autoPlay: false
        volume: parseInt(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_start_calling.mp3"
    }
    Audio{
        id: voice_avoid
        autoPlay: false
        volume: parseInt(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_avoid.mp3"
    }
    Audio{
        id: voice_movefail
        autoPlay: false
        volume: parseInt(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_movefail.mp3"
    }
    Audio{
        id: voice_localfail
        autoPlay: false
        volume: parseInt(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_local_fail.mp3"
    }
    Audio{
        id: voice_motor_error
        autoPlay: false
        volume: parseInt(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_motor_error.mp3"
    }
    Audio{
        id: voice_emergency
        autoPlay: false
        volume: parseInt(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/voice_emergency.mp3"
    }
    Audio{
        id: voice_battery
        autoPlay: false
        volume: parseInt(supervisor.getSetting("ROBOT_SW","volume_voice"))/100
        source: "bgm/battery.mp3"
    }

    Popup{
        id: rect_loading
        width: parent.width
        height: parent.height
        onOpened:{
            loading_image.play("image/loading_rb.gif");
        }
        onClosed:{
            loading_image.stop();
        }

        background:Rectangle{
            anchors.fill: parent
            color: color_dark_black
            opacity: 0.5
        }
        AnimatedImage{
            id: loading_image
            source: ""
            cache: false
            function play(name){
                source = name;
                visible = true;
            }
            function stop(){
                visible = false;
                source = "";
            }
            anchors.fill: parent
        }
    }
    Popup{
        id: rect_resting
        width: parent.width

        height: parent.height
        onOpened:{
            resting_image.play("image/loading_rb.gif");
        }
        onClosed:{
            resting_image.stop();
        }

        background:Rectangle{
            anchors.fill: parent
            color: color_dark_black
        }
        AnimatedImage{
            id: resting_image
            source: ""
            cache: false
            function play(name){
                source = name;
                visible = true;
            }
            function stop(){
                visible = false;
                source = "";
            }
            anchors.fill: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                rect_resting.close();
                count_resting = 0;
            }
        }
    }

    Item_statusbar{
        id: statusbar
    }

//    Loading{
//        id: loading
//    }
}
