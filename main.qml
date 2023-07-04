import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0
import "."
import io.qt.Supervisor 1.0
import io.qt.Keyemitter 1.0
import io.qt.MapViewer 1.0
import QtMultimedia 5.12

Window {
    id: mainwindow
    visible: true
    width: 1280
    height: 800

    property bool debug_mode: false
    property var volume_button : parseInt(supervisor.getSetting("ROBOT_SW","volume_button"));
    property var volume_bgm : parseInt(supervisor.getSetting("ROBOT_SW","volume_bgm"));
    property var volume_voice: parseInt(supervisor.getSetting("ROBOT_SW","volume_voice"));

    flags: homePath.split("/")[2]==="odroid"?Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint |Qt.WindowStaysOnTopHint |Qt.WindowOverridesSystemGestures |Qt.MaximizeUsingFullscreenGeometryHint:Qt.Window
    visibility: homePath.split("/")[2]==="odroid"?Window.FullScreen:Window.Windowed
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
    property color color_dark_gray: "#999999";
    property color color_red: "#E7584D"
    property color color_green: "#12d27c"
    property color color_mid_green: "#0FB168"
    property color color_yellow: "#F7DB0D"
    property color color_dark_black: "#282828"
    property color color_gray: "#d8d8d8"
    property color color_mid_gray: "#e8e8e8"
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

    property bool playingSound: false
    property string cur_sound: ""
    property string next_sound: ""

    function setVoice(str){
        next_sound = str;
    }
    function playVoice(str){
        voice_all_stop();
        if(str === "startServing"){
            voice_serving.play();
        }else if(str === "startCalling"){
            voice_calling.play();
        }else if(str === "moveResting"){
            voice_movewait.play();
        }else if(str === "moveCharging"){
            voice_movecharge.play();
        }else if(str === "noBattery"){
            voice_battery.play();
        }else if(str === "moveWait"){
            voice_wait.play();
        }else if(str === "excuseMe"){
            voice_avoid.play();
        }else if(str === "errorEMO"){
            voice_emergency.play();
        }else if(str === "errorLocal"){
            voice_localfail.play();
        }else if(str === "errorMotor"){
            voice_motor_error.play();
        }else if(str === "errorPath"){
            voice_movefail.play();
        }
    }
    function stopVoice(){
        voice_all_stop();
        playingSound = false;
        cur_sound = "";
        next_sound = "";
    }


    Timer{
        id: timer_voice
        interval: 200
        repeat: true
        running: true
        onTriggered: {
            if(playingSound){
                cur_sound = "";
            }else{
                if(cur_sound === ""){
                    if(next_sound === ""){

                    }else{
                        cur_sound = next_sound;
                        next_sound = "";
                    }
                }else{
                    voice_all_stop();
                    if(cur_sound == "startServing"){
                        voice_serving.play();
                    }else if(cur_sound == "startCalling"){
                        voice_calling.play();
                    }else if(cur_sound == "moveResting"){
                        voice_movewait.play();
                    }else if(cur_sound == "moveCharging"){
                        voice_movecharge.play();
                    }else if(cur_sound == "noBattery"){
                        voice_battery.play();
                    }else if(cur_sound == "moveWait"){
                        voice_wait.play();
                    }else if(cur_sound == "excuseMe"){
                        voice_avoid.play();
                    }else if(cur_sound == "errorEMO"){
                        voice_emergency.play();
                    }else if(cur_sound == "errorLocal"){
                        voice_localfail.play();
                    }else if(cur_sound == "errorMotor"){
                        voice_motor_error.play();
                    }else if(cur_sound == "errorPath"){
                        voice_movefail.play();
                    }
                    playingSound = true;
                }
            }
        }
    }

    function movefail_wake(){
        if(loader_page.item.objectName == "page_annotation"){
            loader_page.item.movedone();
        }
    }

    function movefail(){
        if(loader_page.item.objectName == "page_annotation"){
            if(supervisor.getEmoStatus()){
                loader_page.item.movefail(2);
            }else if(supervisor.getMotorState() === 0){
                loader_page.item.movefail(4);
            }else if(supervisor.getLocalizationState() === 0 || supervisor.getLocalizationState() === 3){
                loader_page.item.movefail(1);
            }else if(supervisor.getStateMoving() === 0){
                loader_page.item.movefail(0);
            }else{
                supervisor.writelog("[MOVEFAIL] WEIRED MOVEFAIL : "+supervisor.getStateMoving().toString()+","+supervisor.getLocalizationState().toString()+","+supervisor.getMotorState().toString())
            }
        }else if(loader_page.item.objectName == "page_mapping" || loader_page.item.objectName == "page_init" || loader_page.item.objectName == "page_movefail" || loader_page.item.objectName == "page_map" || loader_page.item.objectName == "page_setting"){

        }else{
            //0: no path /1: local fail /2: emergency /3: user stop /4: motor error
            if(supervisor.getEmoStatus()){
                supervisor.writelog("[UI] Force Page Change MoveFail : Emergency Switch");
                loadPage(pmovefail);
                loader_page.item.setNotice(2);
                playVoice("errorEMO");
            }else if(supervisor.getMotorState() === 0){
                supervisor.writelog("[UI] Force Page Change MoveFail : Motor not ready");
                loadPage(pmovefail);
                loader_page.item.setNotice(4);
                stopVoice();
            }else if(supervisor.getLocalizationState() === 0 || supervisor.getLocalizationState() === 3){
                supervisor.writelog("[UI] Force Page Change MoveFail : Localization not ready");
                loadPage(pmovefail);
                loader_page.item.setNotice(1);
                playVoice("errorLocal");
            }else if(supervisor.getStateMoving() === 0){
                supervisor.writelog("[UI] Force Page Change MoveFail : Robot not running");
                loadPage(pmovefail);
                loader_page.item.setNotice(0);
                playVoice("errorPath");
            }else{
                supervisor.writelog("[UI] Force Page Change MoveFail : Unknown state ("+supervisor.getStateMoving().toString()+","+supervisor.getLocalizationState().toString()+","+supervisor.getMotorState().toString()+")");
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
        voice_wait.stop();
    }

    function lessbattery(){
        supervisor.writelog("[UI] Play Voice : less battery");
        setVoice("noBattery");
    }

    function checkwifidone(){
        if(loader_page.item.objectName == "page_init"){
            loader_page.item.wifistatein();
        }
    }

    function movelocation(){
        cur_location = supervisor.getcurLoc();
        voice_all_stop();
        if(cur_location == "Charging"){
            cur_location = "충전 장소";
            playVoice("moveCharing");
        }else if(cur_location == "Resting"){
            cur_location = "대기 장소";
            playVoice("moveResting");
        }else{
            if(supervisor.isCallingMode()){
                playVoice("startCalling");
            }else{
                playVoice("startServing");
            }
        }

        if(loader_page.item.objectName == "page_annotation"){
            supervisor.writelog("[UI] Annotation Check : Moving Start "+cur_location);
            loader_page.item.movestart();
        }else{
            loadPage(pmoving)
            supervisor.writelog("[UI] Force Page Change Moving : "+cur_location);
            loader_page.item.pos_name = cur_location;
        }
    }

    function docharge(){
        if(loader_page.item.objectName == "page_annotation"){
            supervisor.writelog("[UI] Annotation Check : Moving Done (Charge) ");
            loader_page.item.movedone();
        }else{
            loadPage(pcharging)
            supervisor.writelog("[UI] Force Page Change Charging");
        }
    }
    function dochargeininit(){
        loadPage(pcharging)
        supervisor.writelog("[UI] Force Page Change Charging : Init State");
        loader_page.item.setInit();
    }

    function waitkitchen(){
        if(loader_page.item.objectName == "page_annotation"){
            supervisor.writelog("[UI] Annotation Check : Moving Done (Resting) ");
            loader_page.item.movedone();
        }else{
            loadPage(pkitchen)
            supervisor.writelog("[UI] Force Page Change Kitchen");
        }
    }

    function clearkitchen(){
        loadPage(pkitchen)
        supervisor.writelog("[UI] Force Page Change Kitchen : need Clear");
    }

    function updatecamera(){
        if(loader_page.item.objectName == "page_setting"){
            loader_page.item.update_camera();
        }
    }

    function updatemapping(){
        if(loader_page.item.objectName == "page_mapping"){
            loader_page.item.update_mapping();
        }
    }

    function movestopped(){
        if(loader_page.item.objectName == "page_annotation"){
            supervisor.writelog("[UI] Annotation Check : Moving Done (Stopped) ");
        }else{
            supervisor.writelog("[UI] Force Page Change Kitchen : move stopped");
            loadPage(pkitchen);
        }
    }

    function showpickup(){
        if(loader_page.item.objectName == "page_annotation"){
            supervisor.writelog("[UI] Annotation Check : Moving Done (Serving Pickup) ");
            loader_page.item.movedone();
        }else{
            if(supervisor.isCallingMode()){
                supervisor.writelog("[UI] Force Page Change Pickup(Calling) : "+ loader_page.item.pos_name);
                loadPage(ppickupCall);
                loader_page.item.init();
            }else{
                supervisor.writelog("[UI] Force Page Change Pickup : "+ loader_page.item.pos_name);
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
                loader_page.item.pos = tempstr;
            }

        }
    }

    function need_init(){
        if(!debug_mode){
            if(loader_page.item.objectName != "page_annotation" && loader_page.item.objectName != "page_mapping"){
                supervisor.writelog("[UI] Force Page Change : Robot disconnected");
                loadPage(pinit);
            }
        }
    }

    function show_loading(){
        rect_loading.open();
    }
    function unshow_loading(){
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

    function updatepath(){
        if(loader_page.item.objectName == "page_map")
            loader_page.item.updatepath();
    }

    function excuseme(){
        playVoice("excuseMe");
        print("excuseme");
    }
    function movewait(){
        playVoice("moveWait");
    }


    function wififailed(){
        if(loader_page.item.objectName == "page_setting" || loader_page.item.objectName == "page_init")
            loader_page.item.wifi_con_failed();
    }

    function wifisuccess(){
        if(loader_page.item.objectName == "page_setting" || loader_page.item.objectName == "page_init")
            loader_page.item.wifi_con_success();
    }

    function wifireset(){
        if(loader_page.item.objectName == "page_setting" || loader_page.item.objectName == "page_init")
            loader_page.item.init();
    }

    function loadPage(page){
        print("loadpage start");
        pbefore = loader_page.source;
        loader_page.source = page;
        print("loadpage done");
    }

    function backPage(){
        print(pbefore);
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
            timer_update.start();
            loader_page.item.init();
        }
        source: pannotation//pinit
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
        id: voice_movecharge
        autoPlay: false
        volume: volume_voice/100
        source: "bgm/voice_move_charge.mp3"
        onPlaylistChanged: {
            if(playing) playingSound = true;
            else playingSound = false;
        }
    }
    Audio{
        id: voice_serving
        autoPlay: false
        volume: volume_voice/100
        source: "bgm/voice_start_serving.mp3"
        onPlaylistChanged: {
            if(playing) playingSound = true;
            else playingSound = false;
        }
    }
    Audio{
        id: voice_calling
        autoPlay: false
        volume: volume_voice/100
        source: "bgm/voice_start_calling.mp3"
        onPlaylistChanged: {
            if(playing) playingSound = true;
            else playingSound = false;
        }
    }
    Audio{
        id: voice_avoid
        autoPlay: false
        volume: volume_voice/100
        source: "bgm/serving.mp3"
        onPlaylistChanged: {
            if(playing) playingSound = true;
            else playingSound = false;
        }
    }
    Audio{
        id: voice_wait
        autoPlay: false
        volume: volume_voice/100
        source: "bgm/voice_avoid.mp3"
        onPlaylistChanged: {
            if(playing) playingSound = true;
            else playingSound = false;
        }
    }
    Audio{
        id: voice_movefail
        autoPlay: false
        volume: volume_voice/100
        source: "bgm/voice_movefail.mp3"
        onPlaylistChanged: {
            if(playing) playingSound = true;
            else playingSound = false;
        }
    }
    Audio{
        id: voice_movewait
        autoPlay: false
        volume: volume_voice/100
        source: "bgm/voice_move_wait.mp3"
        onPlaylistChanged: {
            if(playing) playingSound = true;
            else playingSound = false;
        }
    }
    Audio{
        id: voice_localfail
        autoPlay: false
        volume: volume_voice/100
        source: "bgm/voice_local_fail.mp3"
        onPlaylistChanged: {
            if(playing) playingSound = true;
            else playingSound = false;
        }
    }
    Audio{
        id: voice_motor_error
        autoPlay: false
        volume: volume_voice/100
        source: "bgm/voice_motor_error.mp3"
        onPlaylistChanged: {
            if(playing) playingSound = true;
            else playingSound = false;
        }
    }
    Audio{
        id: voice_emergency
        autoPlay: false
        volume: volume_voice/100
        source: "bgm/voice_emergency.mp3"
        onPlaylistChanged: {
            if(playing) playingSound = true;
            else playingSound = false;
        }
    }
    Audio{
        id: voice_battery
        autoPlay: false
        volume: volume_voice/100
        source: "bgm/battery.mp3"
        onPlaylistChanged: {
            if(playing) playingSound = true;
            else playingSound = false;
        }
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
        visible: true
    }

    SoundEffect{
        id: click_sound
        source: "bgm/click.wav"
        volume: volume_button/100
    }
    SoundEffect{
        id: click_sound_no
        source: "bgm/click_error.wav"
        volume: volume_button/100
    }
    SoundEffect{
        id: click_sound2
        source: "bgm/click2.wav"
        volume: volume_button/100
    }
    SoundEffect{
        id: start_sound
        source: "bgm/click_start.wav"
        volume: volume_button/100
    }
}
