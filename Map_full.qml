import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import "."
import io.qt.Supervisor 1.0
import io.qt.MapView 1.0


Item {
    id: map_full
    objectName: "map_full"
    width: 1000
    height: 1000

    //--------------------------------------- main variables
    property string tool: "move"
    property string map_type: ""
    property string map_name: ""

    property bool show_connection: true
    property bool show_button_lidar: false
    property bool show_button_object: false
    property bool show_button_following: false
    property bool show_brush: false

    property int obj_sequence: 0

    property var cur_width: 0
    property var cur_color: 0
    //--------------------------------------- SLAM / Localization
    property bool is_slam_running: false

    //0(location patrol) 1:(path patrol)
    property int patrol_mode: 0

    property bool is_edited: false
    property bool is_object_new: false
    property bool is_location_new: false
    property bool is_drawing_undo: false
    property bool is_drawing_redo: false

    onEnabledChanged: {
        print("enabled changed : "+objectName + enabled);
        mapview.setEnable(enabled);
    }

    onWidthChanged: {
        if(width>0 && height>0){
            mapview.setMapSize(width, height);
        }
    }

    Component.onCompleted: {
        mapview.setRawMap("");
        mapview.setName(objectName);
        mapview.setMapSize(width, height);
    }

    function setEnable(en){
        enabled = en;
        mapview.setEnable(en);
    }

    function setViewer(mode){
        supervisor.writelog("[QML MAP] SET Viewer "+objectName+" to "+mode);
        mapview.setMode(mode);
        if(mode === "annot_drawing"){
            show_connection = false;
            show_button_following = false;
            show_button_lidar = false;
            show_button_object = false;
        }
    }

    function reload(){

    }

    function checkEdit(){
        checkDrawing();
        checkObject();
        checkLocation();
        is_edited = false;
        if(is_object_new || is_drawing_undo || is_location_new){
            is_edited = true;
        }
    }

    function checkObject(){
        is_object_new = false;
        if(mapview.getObjectFlag()){
            is_object_new = true;
        }
    }

    function checkDrawing(){
        is_drawing_redo = false;
        is_drawing_undo = false;
        if(mapview.getDrawingFlag()){
            is_drawing_undo = true;
        }
        if(mapview.getDrawingUndoFlag()){
            is_drawing_redo = true;
        }
    }
    function checkLocation(){
        is_location_new = false;
        if(mapview.getLocationFlag()){
            is_location_new = true;
        }
    }



    function loadmap(name,type){
        print(objectName);
        supervisor.writelog("[QML MAP] LoadMap "+objectName+": "+name+" (mode = "+type+")");
        if(typeof(name) === 'undefined'){
            name = supervisor.getMapname();
        }
        supervisor.readSetting(name);
        map_name = name;
        if(typeof(type) !== 'undefined'){
            map_type = type;
            if(type === "MINIMAP"){

            }else if(type === "RAW"){
                mapview.setRawMap(name);
            }else if(type === "EDITED"){
                mapview.setEditedMap(name);
            }else if(type === "T_RAW"){
                mapview.setTlineMode(false);
                mapview.initTline(name);
                mapview.setCostMap(name);
            }else if(type === "T_EDIT"){
                mapview.setTlineMode(true);
                mapview.initTline(name);
                mapview.setCostMap(name);
            }else if(type === "OBJECT"){
                mapview.setObjectMap(name);
            }
        }else{
            if(supervisor.isExistAnnotation(name)){
                mapview.setEditedMap(name);
                map_type = "EDITED";
            }else{
                mapview.setRawMap(name);
                map_type = "RAW";
            }
        }
        mapview.updateMap();
    }

    function loadmapping(){
        mapview.setMapping();
    }

    function loadobjecting(){
        mapview.setObjecting();
    }

    function setfullscreen(){
        mapview.setFullScreen();
    }

    function setCurrentObject(num){
        mapview.selectObject(num);
    }

    function setCurrentLocation(num){
        mapview.selectLocation(num);
    }

    function setTool(name){
        tool = name;
        mapview.setTool(name);
    }
    function saveMap(){
        mapview.saveMap();
    }
    function drawing_undo(){
        mapview.undoLine();
    }
    function drawing_redo(){
        mapview.redoLine();
    }
    function object_undo(){
        mapview.undoObject();
    }

    function init(){
        mapview.reloadMap();
        clear("all");
        setTool("move");
    }

    function clear(mode){
        if(mode==="obj"){

        }else if(mode === "loc"){

        }else if(mode==="all"){
            mapview.clearDrawing();
            mapview.clearObject();
            mapview.clearLocation();
        }else if(mode==="tline"){
            mapview.clearDrawing();

        }
    }
    function rotate(dir){
        print("rotate map : "+dir)
        if(dir === "cw"){
            mapview.rotateMapCW();
        }else if(dir === "ccw"){
            mapview.rotateMapCCW();
        }else if(dir === "clear"){
            mapview.rotateMap(0);
        }else{
            mapview.rotateMap(dir);
        }
    }
    function saveObject(type){
        mapview.saveObject(type);
    }

    function save(mode){
        if(mode==="obj"){
            mapview.saveObject();
        }else if(mode==="raw"){

        }else if(mode==="edited"){
            mapview.saveMap();
            supervisor.setMap(map_name);
        }else if(mode==="location_cur"){
            last_robot_x = supervisor.getlastRobotx();
            last_robot_y = supervisor.getlastRoboty();
            last_robot_th = supervisor.getlastRobotth();
            print(last_robot_x,last_robot_y,last_robot_th);
            mapview.addLocation(last_robot_x,last_robot_y,last_robot_th);
            mapview.saveLocation(select_location_type,tfield_location.text);
        }else if(mode==="location"){
            mapview.saveLocation(select_location_type,tfield_location.text);
        }else if(mode==="tline"){
            mapview.saveTline();
        }
    }

    function editLocation(){
        mapview.editLocation();
    }

    function redoLocation(){
        mapview.redoLocation();
    }

//    function savelocation(mode, type, name){
//        if(mode==="cur_pose"){
//            print(last_robot_x,last_robot_y,last_robot_th);
//            mapview.addLocation(last_robot_x,last_robot_y,last_robot_th);
//            mapview.saveLocation(type,name);
//        }else if(mode==="new_target"){
//            mapview.saveLocation(type,name);
//        }
//    }

    function setDrawingColor(color){
        mapview.setLineColor(color);
        cur_color = color;
    }


    function setDrawingWidth(width){
        mapview.setLineWidth(width);
        cur_width = width/mapview.getScale() + 2;
        print("setdrawingwidth ",width,mapview.getScale(),cur_width);
    }

    function setAutoInit(x,y,th){
        print(objectName+" ?:",x,y,th);
        mapview.setInitPose(x,y,th);
        supervisor.setInitPos(x,y,th);
    }
    function updateMap(){
        mapview.updateMap();
    }

    Timer{
        id: timer
        interval: 500
        repeat: true
        running: true
        onTriggered: {
            btn_robot_following.active = mapview.getRobotFollowing();
            btn_show_lidar.active = mapview.getlidarView();
            btn_show_objecting.active = mapview.getobjectView();
            btn_show_object.active = mapview.getobjectBoxView();
        }
    }

    MapView{
        id: mapview
        anchors.fill: parent
        Component.onCompleted: {
        }
        clip: true

        Rectangle{
            id: rect_notice
            anchors.horizontalCenter: parent.horizontalCenter
            width: 300
            height: 60
            y: -10
            radius: 5
            color: color_red
            function show_connect(){
                show_ani.start();
            }
            function unshow_connect(){
                unshow_ani.start();
            }
            NumberAnimation{
                id: show_ani
                target: parent
                property: "y"
                from: -height
                to: 0
                duration: 500
                onStarted: {
                    parent.visible = true;
                }
                onFinished: {

                }
            }
            NumberAnimation{
                id: unshow_ani
                target: parent
                property: "y"
                from: 0
                to: -height
                duration: 500
                onStarted: {
                }
                onFinished: {
                    parent.visible = false;
                }
            }
            visible: false
            onVisibleChanged: {
                if(visible){
                    show_ani.start();
                }
            }
            property string msg: ""
            property bool show_icon: false
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 5
                spacing: 10
                Image{
                    width: 30
                    height: 30
                    visible: rect_notice.show_icon
                    anchors.verticalCenter: parent.verticalCenter
                    source: "icon/icon_warning.png"
                    ColorOverlay{
                        source: parent
                        anchors.fill: parent
                        color: "white"
                    }
                }
                Text{
                    text: rect_notice.msg
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: font_noto_b.name
                    font.pixelSize: 20
                    color: "white"
                }
            }
        }

    }
    MouseArea{
        enabled: parent.enabled
        anchors.fill: parent
        hoverEnabled: true
        onWheel: {
            if(wheel.angleDelta.y > 0){
                mapview.zoomIn(mouseX, mouseY);
            }else{
                mapview.zoomOut(mouseX, mouseY);
            }
        }
    }

    MultiPointTouchArea{
        enabled: parent.enabled
        anchors.fill: parent
        minimumTouchPoints: 1
        maximumTouchPoints: 2
        property var firstX;
        property var firstY;
        property var firstDist;
        property bool double_touch: false
        touchPoints: [TouchPoint{id:point1},TouchPoint{id:point2}]
        onPressed:{
            double_touch = false;
            mapview.setRobotFollowing(false);
            if(point1.pressed && point2.pressed){
                double_touch = true;
            }else if(point1.pressed){
                firstX = mapview.getX() + point1.x*mapview.getScale();
                firstY = mapview.getY() + point1.y*mapview.getScale();
            }else if(point2.pressed){
                firstX = mapview.getX() + point2.x*mapview.getScale();
                firstY = mapview.getY() + point2.y*mapview.getScale();
            }

            if(tool == "move"){
                if(double_touch){
                    firstX = mapview.getX() + (point1.x+point2.x)*mapview.getScale()/2;
                    firstY = mapview.getY() + (point1.y+point2.y)*mapview.getScale()/2;
                    var dx = Math.abs(point1.x-point2.x);
                    var dy = Math.abs(point1.y-point2.y);
                    firstDist = Math.sqrt(dx*dx + dy*dy);
                    print("PRESS : ",firstX,firstY,firstDist);
                }
            }else if(tool == "draw"){
                mapview.showBrush(true);
                mapview.startDrawing(firstX, firstY);
            }else if(tool == "erase"){
                mapview.showBrush(true);
                mapview.setLineColor(-1);
                mapview.startDrawing(firstX, firstY);
            }else if( tool === "add_object"){
                mapview.addObject(firstX, firstY);
            }else if( tool === "edit_object"){
                mapview.editObjectStart(firstX,firstY)
            }else if( tool === "add_point"){
                mapview.addObjectPoint(firstX, firstY);
            }else if( tool === "add_location"){
                mapview.addLocation(firstX, firstY,0);
            }else if( tool === "edit_location"){
                mapview.editLocation(firstX, firstY,0);
            }else if( tool === "slam_init"){
                print("Pressed : ",firstX,firstY,0);
                mapview.setInitPose(firstX,firstY,0);
            }
        }
        onReleased: {
            mapview.showBrush(false);
//            double_touch = false;
            var newX = mapview.getX() + point1.x*mapview.getScale();
            var newY = mapview.getY() + point1.y*mapview.getScale();
            if(!point1.pressed && !point2.pressed){
                if(tool == "move"){
                    if(mapview.getMode() === "annot_object"){
                        loader_menu.item.setcur(mapview.getObjectNum(newX, newY))
                    }else if(mapview.getMode() === "annot_location"){
                        loader_menu.item.setcur(mapview.getLocationNum(newX, newY))
                    }
                }else if(tool == "draw"){
                    mapview.endDrawing(newX, newY);
                }else if(tool == "erase"){
                    mapview.endDrawing(newX, newY);
                }else if( tool === "add_object"){

                }else if( tool === "edit_object"){
                    supervisor.setObjPose();
                }else if( tool === "add_point"){

                }else if( tool === "edit_location"){
                    var angle = Math.atan2((newX-firstX),(newY-firstY));
                    mapview.editLocation(firstX, firstY,angle);
                }else if( tool === "add_location"){

                }else if( tool === "slam_init"){
                    angle = Math.atan2((newY-firstY),(newX-firstX));
                    print("Released : ",firstX,firstY,angle);
                    supervisor.setInitPos(firstX, firstY, angle);
                    supervisor.slam_setInit();
                }
            }

        }
        onTouchUpdated: {
            if(point1.pressed || point2.pressed){
                var newX = mapview.getX() + point1.x*mapview.getScale();
                var newY = mapview.getY() + point1.y*mapview.getScale();
                if(tool == "move"){
                    if(double_touch){
                        if(point1.pressed && point2.pressed){
                            newX = (point1.x + point2.x)*mapview.getScale()/2;
                            newY = (point1.y + point2.y)*mapview.getScale()/2;

                            var dx = Math.abs(point1.x - point2.x)
                            var dy = Math.abs(point1.y - point2.y)
                            var dist = Math.sqrt(dx*dx + dy*dy);
                            var thres = 10;

                            for(var i=0; i<(firstDist-dist)/thres; i++){
//                                mapview.scaledOut(1,1);
                                mapview.zoomOut(newX,newY);
                            }
                            for(var i=0; i<(dist-firstDist)/thres; i++){
//                                mapview.scaledIn(1,1);
                                mapview.zoomIn(newX,newY);
                            }
                            firstDist = dist;

//                            print("UPDATE : ",newX,newY,dist);
                            mapview.setRobotFollowing(false);
                            mapview.move(firstX-newX, firstY-newY);
                        }else{
                            double_touch = false;
                        }
                    }else{
                        if(point1.pressed){
                            newX = point1.x*mapview.getScale();
                            newY = point1.y*mapview.getScale();
                        }else if(point2.pressed){
                            newX = point2.x*mapview.getScale();
                            newY = point2.y*mapview.getScale();
                        }
//                        print("UPDATE : ",newX,newY);
                        mapview.setRobotFollowing(false);
                        mapview.move(firstX-newX, firstY-newY);
                    }
                }else if(tool == "draw"){
                    mapview.addLinePoint(newX, newY);
                }else if(tool == "erase"){
                    mapview.addLinePoint(newX, newY);
                }else if( tool === "add_object"){
                    mapview.setObject(newX, newY);
                }else if( tool === "edit_object"){
                    mapview.editObject(newX, newY);
                }else if( tool === "add_point"){
                    mapview.setObject(newX, newY);
                }else if( tool === "add_location"){
                    var angle = Math.atan2((newY-firstY),(newX-firstX));
                    mapview.addLocation(firstX, firstY,angle);
                }else if( tool === "edit_location"){
                    angle = Math.atan2((newY-firstY),(newX-firstX));
//                    print(angle, newX-firstX, newY-firstY);
                    mapview.editLocation(firstX, firstY,angle);
                }else if( tool === "slam_init"){
                    angle = Math.atan2((newY-firstY),(newX-firstX));
//                    print("Update : ",firstX,firstY,angle);
                    mapview.setInitPose(firstX,firstY,angle);
                }
            }
        }
    }

    //Buttons

    Rectangle{
        id: btn_robot_following
        width: 40
        height: 40
        radius: 40
        visible: show_button_following
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 5
        property bool active: false
        color: active?"#12d27c":"#e8e8e8"
        Image{
            anchors.centerIn: parent
            source: "icon/icon_cur.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                mapview.setRobotFollowing(true);
            }
        }
    }

    Rectangle{
        id: btn_show_lidar
        width: 40
        height: 40
        radius: 40
        visible: show_button_lidar
        property bool active: false
        anchors.top: btn_robot_following.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        color:active?"#12d27c":"#e8e8e8"
        Image{
            anchors.centerIn: parent
            source: "icon/icon_lidar.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(parent.active){
                    mapview.setlidarView(false);
                }else{
                    mapview.setlidarView(true);
                }
            }
        }
    }

    Rectangle{
        id: btn_show_objecting
        width: 40
        height: 40
        radius: 40
        visible: show_button_object
        anchors.top: btn_show_lidar.bottom
        anchors.topMargin: 5
        property bool active: false
        anchors.left: parent.left
        anchors.leftMargin: 5
        color: active?"#12d27c":"#e8e8e8"
        Image{
            anchors.centerIn: parent
            source: {
                 parent.active?"icon/icon_obj_yes.png":"icon/icon_obj_no.png"
            }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(parent.active){
                    mapview.setobjectView(false);
                }else{
                    mapview.setobjectView(true);
                }
            }
        }
    }
    Rectangle{
        id: btn_show_object
        width: 40
        height: 40
        radius: 40
        visible: show_button_object
        anchors.top: btn_show_objecting.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        property bool active: false
        anchors.leftMargin: 5
        color:  active?"#12d27c":"#e8e8e8"
        Image{
            anchors.centerIn: parent
            source: parent.active?"icon/icon_obj_yes.png":"icon/icon_obj_no.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(parent.active){
                    mapview.setobjectBoxView(false);
                }else{
                    mapview.setobjectBoxView(true);
                }
            }
        }
    }
    Rectangle{
        id: brushview
        visible: show_brush
        width: cur_width
        height: width
        radius: width
        border.width: 1
        border.color: "black"
        anchors.centerIn: parent
    }

    //최초 실행 후 맵 파일을 받아올 수 있을 때까지 1회 수행
    Timer{
        id: timer_loadmap
        running: true
        repeat: true
        interval: 500
        onTriggered: {
            //맵을 로딩할 수 있을 때
            if(supervisor.isloadMap()){
                //맵 정보 받아옴(경로, 이름)
                map_name = supervisor.getMapname();
                loadmap(map_name,"EDITED");
                setfullscreen();

                //타이머 종료
                timer_loadmap.stop();
                supervisor.writelog("[QML] Load Map(AUTO) : "+map_name);
            }
        }
    }

    //로봇 연결되면 주기적 수행
    Timer{
        id: update_map
        running: true
        repeat: true
        interval: 500
        onTriggered: {
            if(supervisor.isIPCused() || supervisor.getLCMConnection()){
                is_slam_running = supervisor.is_slam_running();
                if(show_connection){
                    if(supervisor.getMappingflag()){
                        rect_notice.visible = true;
                        rect_notice.msg =  "맵 생성 중";
                        rect_notice.color = color_navy;
                        rect_notice.show_icon = false;
                    }else if(supervisor.getObjectingflag()){
                        rect_notice.visible = true;
                        rect_notice.msg =  "오브젝트 생성 중";
                        rect_notice.color = color_navy;
                        rect_notice.show_icon = false;
                    }else if(supervisor.getLocalizationState()===1){
                        rect_notice.visible = true;
                        rect_notice.msg =  "위치 초기화 중";
                        rect_notice.color = color_navy;
                        rect_notice.show_icon = false;
                    }else if(!is_slam_running && mapview.getMode() !== "mapping"){
                        rect_notice.visible = true;
                        rect_notice.msg =  "주행 활성화 안됨";
                        rect_notice.color = color_red;
                        rect_notice.show_icon = true;
                    }else{
                        rect_notice.visible = false;
                    }
                }else{
                    rect_notice.visible = false;
                }
            }else{
                rect_notice.visible = true;
                rect_notice.msg =  "로봇 연결 안됨";
                rect_notice.color = color_red;
                rect_notice.show_icon = true;
            }

        }
    }
}
