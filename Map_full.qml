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

    property bool show_connection: false
    property bool show_button_lidar: false
    property bool show_button_object: false
    property bool show_button_following: false
    property bool show_brush: false

    property int obj_sequence: 0

    //--------------------------------------- SLAM / Localization
    property bool is_slam_running: false

    //0(location patrol) 1:(path patrol)
    property int patrol_mode: 0

    //Annotation State (None, Drawing, Object, Location, Travelline)
    property string state_annotation: "NONE"

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
        supervisor.writelog("[QML MAP] LoadMap "+objectName+": "+name+" (mode = "+type+")");
        if(typeof(name) === 'undefined'){
            name = supervisor.getMapname();
        }
        supervisor.readSetting(name);

        if(typeof(type) !== 'undefined'){
            map_type = type;
            if(type === "MINIMAP"){

            }else if(type === "RAW"){
                mapview.setRawMap(name);
            }else if(type === "EDITED"){
                mapview.setEditedMap(name);
            }else if(type === "T_RAW"){
                mapview.setCostMap(name);
                mapview.setTlineMode(false);
                mapview.initTline(name);
            }else if(type === "T_EDIT"){
                mapview.setCostMap(name);
                mapview.setTlineMode(true);
                mapview.initTline(name);
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
        }
    }
    function rotate(dir){
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
        }else if(mode==="location_cur"){
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

    function savelocation(mode, type, name){
        if(mode==="cur_pose"){
            print(last_robot_x,last_robot_y,last_robot_th);
            mapview.addLocation(last_robot_x,last_robot_y,last_robot_th);
            mapview.saveLocation(type,name);
        }else if(mode==="new_target"){
            mapview.saveLocation(type,name);
        }
    }

    function setDrawingColor(color){
        mapview.setLineColor(color);
    }
    function setDrawingWidth(width){
        mapview.setLineWidth(width);
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
                    var dx = Math.abs(point_x1-point_x2);
                    var dy = Math.abs(point_y1-point_y2);
                    firstDist = Math.sqrt(dx*dx + dy*dy);
                }
            }else if(tool == "draw"){
                mapview.startDrawing(firstX, firstY);
            }else if(tool == "erase"){
                mapview.setLineColor(-1);
                mapview.setLineWidth(20);
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
                mapview.setInitPose(firstX,firstY,0);
            }
        }
        onReleased: {
            double_touch = false;
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
                    var angle = Math.atan2(-(newX-firstX),-(newY-firstY));
                    mapview.editLocation(firstX, firstY,angle);
                }else if( tool === "add_location"){

                }else if( tool === "slam_init"){
                    angle = Math.atan2(-(newY-firstY),-(newX-firstX));
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
                        newX = (point1.x + point2.x)*mapview.getScale()/2;
                        newY = (point1.y + point2.y)*mapview.getScale()/2;

                        var dx = Math.abs(point1.x - point2.x)
                        var dy = Math.abs(point1.y - point2.y)
                        var dist = Math.sqrt(dx*dx + dy*dy);

                        var threshold = 10;
                        if(startDist - dist > threshold){
                            mapview.zoomIn(newX/mapview.getScale(),newY/mapview.getScale());
                        }else if(dist - startDist > threshold){
                            mapview.zoomOut(newX/mapview.getScale(),newY/mapview.getScale());
                        }
                    }else if(point1.pressed){
                        newX = point1.x*mapview.getScale();
                        newY = point1.y*mapview.getScale();
                    }else if(point2.pressed){
                        newX = point2.x*mapview.getScale();
                        newY = point2.y*mapview.getScale();
                    }
                    mapview.setRobotFollowing(false);
                    mapview.move(firstX-newX, firstY-newY);
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
                    print(angle);
                    mapview.addLocation(firstX, firstY,angle);
                }else if( tool === "edit_location"){
                    angle = Math.atan2((newY-firstY),(newX-firstX));
                    print(angle, newX-firstX, newY-firstY);
                    mapview.editLocation(firstX, firstY,angle);
                }else if( tool === "slam_init"){
                    angle = Math.atan2((newY-firstY),(newX-firstX));
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
        visible: false
        width: 0
        height: width
        radius: width
        border.width: 1
        border.color: "black"
        anchors.centerIn: parent
    }

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








//Item {
//    //////========================================================================================Main Canvas
//    Rectangle{
//        id: rect_ma

//    Column{
//        id: scale_bar
//        anchors.bottom: parent.bottom
//        anchors.right: parent.right
//        anchors.rightMargin: 10
//        anchors.bottomMargin: 10
//        spacing: -5
//        Row{
//            Rectangle{
//                width: 3
//                height: 10
//                color: "white"
//                anchors.verticalCenter: parent.verticalCenter
//            }
//            Rectangle{
//                anchors.verticalCenter: parent.verticalCenter
//                width: (1/supervisor.getGridWidth())*newscale
//                height: 3
//                color: "white"
//            }
//            Rectangle{
//                width: 3
//                height: 10
//                color: "white"
//                anchors.verticalCenter: parent.verticalCenter
//            }
//        }
//        Text{
//            anchors.horizontalCenter: parent.horizontalCenter
//            text: "1m"
//            font.family: font_noto_r.name
//            font.pixelSize: 10
//            color: "white"
//        }
//    }


//    //최초 실행 후 맵 파일을 받아올 수 있을 때까지 1회 수행
//    Timer{
//        id: timer_loadmap
//        running: true
//        repeat: true
//        interval: 500
//        onTriggered: {
//            //맵을 로딩할 수 있을 때
//            if(supervisor.isloadMap()){

//                //맵 정보 받아옴(경로, 이름)
//                map_name = supervisor.getMapname();
//                loadmap(map_name);

//                //타이머 종료
//                timer_loadmap.stop();
//                supervisor.writelog("[QML] Load Map(AUTO) : "+map_name);
//            }
//        }
//    }

//    //로봇 연결되면 주기적 수행
//    Timer{
//        id: update_map
//        running: show_robot
//        repeat: true
//        interval: 500
//        onTriggered: {
//            if(supervisor.getLCMConnection()){
//                is_slam_running = supervisor.is_slam_running();
//                robot_x = (supervisor.getRobotx()/grid_size + origin_x)*newscale;
//                robot_y = (supervisor.getRoboty()/grid_size + origin_y)*newscale;
//                robot_th = -supervisor.getRobotth()-Math.PI/2;
//                path_num = supervisor.getPathNum();
//                draw_canvas_current();

//                if(show_connection){
//                    if(supervisor.getMappingflag()){
//                        rect_notice.visible = true;
//                        rect_notice.msg =  "맵 생성 중";
//                        rect_notice.color = color_navy;
//                        rect_notice.show_icon = false;
//                    }else if(supervisor.getObjectingflag()){
//                        rect_notice.visible = true;
//                        rect_notice.msg =  "오브젝트 생성 중";
//                        rect_notice.color = color_navy;
//                        rect_notice.show_icon = false;
//                    }else if(supervisor.getLocalizationState()===1){
//                        rect_notice.visible = true;
//                        rect_notice.msg =  "위치 초기화 중";
//                        rect_notice.color = color_navy;
//                        rect_notice.show_icon = false;
//                    }else if(!is_slam_running && map_mode != "MAPPING"){
//                        rect_notice.visible = true;
//                        rect_notice.msg =  "주행 활성화 안됨";
//                        rect_notice.color = color_red;
//                        rect_notice.show_icon = true;
//                    }else{
//                        rect_notice.visible = false;
//                    }
//                }else{
//                    rect_notice.visible = false;
//                }
//            }else{
//                rect_notice.visible = true;
//                rect_notice.msg =  "로봇 연결 안됨";
//                rect_notice.color = color_red;
//                rect_notice.show_icon = true;
//            }

//        }
//    }

//    //////========================================================================================Variable update function
//    function init_mode(){
//        tool = "MOVE";
//        select_object = -1;
//        select_object_point = -1;
//        select_location = -1;
//        select_patrol = -1;

//        new_location = false;
//        new_loc_available = false;
//        new_object = false;

//        supervisor.clearObjectPoints();

//        show_connection = true;

//        show_buttons = false;
//        show_lidar = false;
//        show_location = false;
//        show_object = false;
//        show_path = false;
//        show_robot = false;
//        show_objecting = false;
//        clear_margin();
//        clear_canvas();
//        update_canvas();
//    }

//    function update_path(){
//        canvas_map_cur.requestPaint();
//    }
//    function update_margin(){
//        update_checker.start();
//        canvas_map_margin.requestPaint();
//    }
//    function clear_margin(){
//        canvas_map_margin.requestPaint();
//    }

//    //////========================================================================================Annotation function
//    function find_map_walls(){
//        supervisor.clearMarginObj();
//        var ctx1 = canvas_object.getContext('2d');
//        var map_data1 = ctx1.getImageData(0,0,map_width, map_height);
//        for(var x=0; x< map_data1.data.length; x=x+4){
//            if(map_data1.data[x+3] > 0){
//                supervisor.setMarginPoint(Math.abs(x/4));
//            }
//        }
//    }

//    //margin 업데이트 1초 뒤, location collision 업데이트
//    function updatelocationcollision(){
//        loader_menu.item.update();
//    }

//    function is_Col_loc(x,y){
//        if(map_name != ""){
//            var ctx1 = canvas_map_margin.getContext('2d');
//            var ctx_robot = canvas_robot.getContext('2d');

//            var map_data = supervisor.getMapData(map_name);
//            var map_data1 = ctx1.getImageData(0,0,map_width,map_height);
//            var robot_data = ctx_robot.getImageData(0,0,canvas_robot.width,canvas_robot.height);

//            for(var i=0; i<robot_data.data.length; i=i+4){
//                if(robot_data.data[i+3] > 0){
//                    var robot_x = Math.floor((i/4)%canvas_robot.width + x - canvas_robot.width/2);
//                    var robot_y = Math.floor((i/4)/canvas_robot.width + y - canvas_robot.width/2);
//                    var pixel_num = robot_y*canvas_map.width + robot_x;
//                    if(map_data[pixel_num] == 0 || map_data[pixel_num] > 100){
//                        //collision walls
//                        return true;
//                    }else if(map_data1.data[pixel_num*4+3] > 0){
//                        //collision to margin
//                        return true;
//                    }
//                }
//            }
//        }
//        return false;
//    }

//    function save_patrol(is_edit){
//        var ctx = canvas_map.getContext('2d');

//        var data = ctx.getImageData(0,0,map_width, map_height);
//        var array = [];
//        for(var i=0; i<data.data.length; i=i+4){
//            if(data.data[i+3] > 0){
//                if(data.data[i] > 0){
//                    array.push(255);
//                }else{
//                    array.push(100);
//                }
//            }else{
//                array.push(0);
//            }

//        }
//        supervisor.saveTravel(is_edit,array);
//    }

//    function save_map(name){
//        newscale = 1;

//        var ctx = canvas_map.getContext('2d');
//        var data = ctx.getImageData(0,0,map_width,map_height);
//        var array= [];
//        var array_alpha= [];

//        for(var i=0; i<data.data.length; i=i+4){
//            array.push(data.data[i]);
//            array_alpha.push(data.data[i+3]);
//        }
//        print(map_width, map_height, data.data.length);
//        supervisor.saveMap(map_mode,map_name,name,array,array_alpha);
//    }

//    //////========================================================================================Canvas drawing function
//    function draw_canvas_lines(refresh){
//        if(canvas_map.available){
//            var ctx = canvas_map.getContext('2d');
//            if(refresh){
////                print("Refresh Canvas Map Lines");
//                ctx.clearRect(0,0,canvas_map.width,canvas_map.height);
//                for(var i=0; i<supervisor.getCanvasSize(); i++){
//                    ctx.lineWidth = supervisor.getLineWidth(i);
//                    ctx.strokeStyle = supervisor.getLineColor(i);
//                    ctx.lineCap = "round"
//                    ctx.beginPath()
//                    canvas_map.lineX = supervisor.getLineX(i);
//                    canvas_map.lineY = supervisor.getLineY(i);
//                    for(var j=0;j<canvas_map.lineX.length-1;j++){
//                        ctx.moveTo(canvas_map.lineX[j], canvas_map.lineY[j])
//                        ctx.lineTo(canvas_map.lineX[j+1], canvas_map.lineY[j+1])
//                    }
//                    ctx.stroke()
//                }
//            }else{
//                if(tool == "BRUSH" || tool == "ERASE"){
//                    ctx.lineWidth = canvas_map.lineWidth
//                    ctx.strokeStyle = brush_color
//                    ctx.lineCap = "round"
//                    ctx.beginPath()
//                    ctx.moveTo(canvas_map.lastX, canvas_map.lastY)
//                    if(point1.pressed){
//                        canvas_map.lastX = area_map.point_x1
//                        canvas_map.lastY = area_map.point_y1
//                    }
//                    supervisor.setLine(canvas_map.lastX,canvas_map.lastY);
//                    ctx.lineTo(canvas_map.lastX, canvas_map.lastY)
//                    ctx.stroke()
//                }

//            }

//            canvas_map.requestPaint();
//        }
//    }
//    function draw_canvas_temp(){
//        var ctx = canvas_map_temp.getContext('2d');
//        if(state_annotation === "TRAVELLINE"){
//            if(tool == "BRUSH" || tool == "ERASE"){
//                ctx.lineWidth = canvas_map_temp.lineWidth
//                ctx.strokeStyle = color_dark_navy
//                ctx.lineCap = "round"
//                ctx.beginPath()
//                ctx.moveTo(canvas_map_temp.lastX, canvas_map_temp.lastY)
//                if(point1.pressed){
//                    canvas_map_temp.lastX = area_map.point_x1
//                    canvas_map_temp.lastY = area_map.point_y1
//                }
//                ctx.lineTo(canvas_map_temp.lastX, canvas_map_temp.lastY)
//                ctx.stroke()
//            }
//        }else{
//            clear_canvas_temp();
//        }

//        canvas_map_temp.requestPaint();

//    }
//    function clear_canvas_temp(){
//        print("clear")
//        var ctx = canvas_map_temp.getContext('2d');
//        ctx.clearRect(0,0,canvas_map_temp.width,canvas_map_temp.height);

//    }

//    function clear_canvas_location(){
//        if(canvas_location.available){
//            var ctx = canvas_location.getContext('2d');
//            ctx.clearRect(0,0,canvas_location.width, canvas_location.height);
//            canvas_location.requestPaint();
//        }
//    }

//    function clear_canvas_object(){
//        if(canvas_object.available){
//            var ctx = canvas_object.getContext('2d');
//            ctx.clearRect(0,0,canvas_object.width, canvas_object.height);
//            canvas_object.requestPaint();
//        }
//    }

//    function draw_canvas_location_icon(){
//        if(canvas_location.available){
//            var ctx = canvas_location.getContext('2d');
//            location_num = supervisor.getLocationNum();
//            for(var i=0; i<location_num; i++){
//                var loc_type = supervisor.getLocationTypes(i);
//                var loc_x = (supervisor.getLocationx(i)/grid_size + origin_x)*newscale;;
//                var loc_y = (supervisor.getLocationy(i)/grid_size + origin_y)*newscale;;
//                var loc_th = supervisor.getLocationth(i);
//                var radiusrobot = robot_radius*newscale;
//                var icon_size = 13*newscale;
//                if(loc_type.slice(0,4) == "Char"){
//                    if(select_location == i){
//                        ctx.fillStyle = "#7f7f7f";
//                        ctx.strokeStyle = "#83B8F9";
//                        ctx.lineWidth = 2;
//                        ctx.beginPath();
//                        ctx.arc(loc_x,loc_y, radiusrobot/grid_size, -loc_th-Math.PI/2, -loc_th-Math.PI/2+2*Math.PI, true);
//                        ctx.fill()
//                        ctx.stroke()

//                        var distance = (radiusrobot/grid_size)*1.8;
//                        var distance2 = distance*0.8;
//                        var th_dist = Math.PI/8;
//                        var x = loc_x-distance*Math.sin(loc_th);
//                        var y = loc_y-distance*Math.cos(loc_th);
//                        var x1 = loc_x-distance2*Math.sin(loc_th-th_dist);
//                        var y1 = loc_y-distance2*Math.cos(loc_th-th_dist);
//                        var x2 = loc_x-distance2*Math.sin(loc_th+th_dist);
//                        var y2 = loc_y-distance2*Math.cos(loc_th+th_dist);

//                        ctx.beginPath();
//                        ctx.moveTo(x,y);
//                        ctx.lineTo(x1,y1);
//                        ctx.moveTo(x,y);
//                        ctx.lineTo(x2,y2);
//                        ctx.stroke()
//                        ctx.drawImage(image_charging_selected,loc_x - icon_size/2,loc_y - icon_size/2, icon_size, icon_size);

//                    }else{
//                        ctx.fillStyle = "#7f7f7f";
//                        ctx.strokeStyle = "white";
//                        ctx.lineWidth = 1;
//                        ctx.beginPath();
//                        ctx.arc(loc_x,loc_y,radiusrobot/grid_size, -loc_th-Math.PI/2, -loc_th-Math.PI/2+2*Math.PI, true);
//                        ctx.fill()
//                        ctx.stroke()
//                        ctx.drawImage(image_charging,loc_x - icon_size/2,loc_y - icon_size/2, icon_size,icon_size);
//                    }
//                }else if(loc_type.slice(0,4) == "Rest"){
//                    if(select_location === i){
//                        ctx.fillStyle = "#7f7f7f";
//                        ctx.strokeStyle = "#83B8F9";
//                        ctx.lineWidth = 2;
//                        ctx.beginPath();
//                        ctx.arc(loc_x,loc_y,radiusrobot/grid_size, -loc_th-Math.PI/2, -loc_th-Math.PI/2+2*Math.PI, true);
//                        ctx.fill()
//                        ctx.stroke()
//                        var distance = (radiusrobot/grid_size)*1.8;
//                        var distance2 = distance*0.8;
//                        var th_dist = Math.PI/8;
//                        var x = loc_x-distance*Math.sin(loc_th);
//                        var y = loc_y-distance*Math.cos(loc_th);
//                        var x1 = loc_x-distance2*Math.sin(loc_th-th_dist);
//                        var y1 = loc_y-distance2*Math.cos(loc_th-th_dist);
//                        var x2 = loc_x-distance2*Math.sin(loc_th+th_dist);
//                        var y2 = loc_y-distance2*Math.cos(loc_th+th_dist);

//                        ctx.beginPath();
//                        ctx.moveTo(x,y);
//                        ctx.lineTo(x1,y1);
//                        ctx.moveTo(x,y);
//                        ctx.lineTo(x2,y2);
//                        ctx.stroke()
//                        ctx.drawImage(image_resting_selected,loc_x - icon_size/2,loc_y - icon_size/2, icon_size, icon_size);
//                    }else{
//                        ctx.fillStyle = "#7f7f7f";
//                        ctx.strokeStyle = "white";
//                        ctx.lineWidth = 1;
//                        ctx.beginPath();
//                        ctx.arc(loc_x,loc_y,radiusrobot/grid_size, -loc_th-Math.PI/2, -loc_th-Math.PI/2+2*Math.PI, true);
//                        ctx.fill()
//                        ctx.stroke()
//                        ctx.drawImage(image_resting,loc_x - icon_size/2,loc_y - icon_size/2, icon_size, icon_size);
//                    }

//                }
//            }
//            canvas_location.requestPaint();
//        }
//    }

//    function draw_canvas_location(){
//        if(canvas_location.available && !show_icon_only){
//            var ctx = canvas_location.getContext('2d');
//            location_num = supervisor.getLocationNum();

//            for(var i=0; i<location_num; i++){
//                var loc_type = supervisor.getLocationTypes(i);
//                var loc_x = (supervisor.getLocationx(i)/grid_size +origin_x)*newscale;
//                var loc_y = (supervisor.getLocationy(i)/grid_size +origin_y)*newscale;
//                var loc_th = supervisor.getLocationth(i);//+Math.PI/2;
//                var radiusrobot = robot_radius*newscale;

//                if(select_location == i){
//                    ctx.strokeStyle = "#83B8F9";
//                    ctx.fillStyle = "#FFD9FF";
//                    ctx.lineWidth = 2;
//                }else{
//                    ctx.strokeStyle = "white";
//                    ctx.lineWidth = 2;
//                    ctx.fillStyle = "#83B8F9";
//                }

//                ctx.beginPath();
//                ctx.arc(loc_x,loc_y,radiusrobot/grid_size, -loc_th-Math.PI/2, -loc_th-Math.PI/2+2*Math.PI, true);
//                ctx.fill()
//                ctx.stroke()

//                var distance = (radiusrobot/grid_size)*1.8;
//                var distance2 = distance*0.8;
//                var th_dist = Math.PI/8;
//                var x = loc_x-distance*Math.sin(loc_th);
//                var y = loc_y-distance*Math.cos(loc_th);
//                var x1 = loc_x-distance2*Math.sin(loc_th-th_dist);
//                var y1 = loc_y-distance2*Math.cos(loc_th-th_dist);
//                var x2 = loc_x-distance2*Math.sin(loc_th+th_dist);
//                var y2 = loc_y-distance2*Math.cos(loc_th+th_dist);

//                if(select_location == i){
//                    ctx.strokeStyle = "#83B8F9";
//                }else{
//                    ctx.strokeStyle = "#83B8F9";
//                }

//                ctx.beginPath();
//                ctx.moveTo(x,y);
//                ctx.lineTo(x1,y1);
//                ctx.moveTo(x,y);
//                ctx.lineTo(x2,y2);
//                ctx.stroke()
//            }
//            canvas_location.requestPaint();
//        }

//    }

//    function draw_canvas_patrol_location(){
//        if(canvas_location.available && !show_icon_only){
//            var ctx = canvas_location.getContext('2d');
//            var patrol_num = supervisor.getPatrolNum();

//            for(var i=0; i<patrol_num; i++){
//                var loc_type = supervisor.getPatrolType(i);
//                var loc_name = supervisor.getPatrolLocation(i);
//                var loc_x = (supervisor.getPatrolX(i)/grid_size+origin_x)*newscale;
//                var loc_y = (supervisor.getPatrolY(i)/grid_size+origin_y)*newscale;
//                var loc_th = -supervisor.getPatrolTH(i)-Math.PI/2;
//                var radiusrobot = robot_radius*newscale;

//                if(select_patrol === i){
//                    ctx.lineWidth = 3;
//                    if(loc_type === "START"){
//                        ctx.fillStyle = "#12d27c";
//                    }else{
//                        ctx.fillStyle = "#FFD9FF";
//                    }
//                    ctx.strokeStyle = "#83B8F9";
//                }else{
//                    ctx.strokeStyle = "white";
//                    ctx.lineWidth = 2;
//                    if(loc_type === "START"){
//                        ctx.fillStyle = "#12d27c";
//                    }else{
//                        ctx.fillStyle = "#83B8F9";
//                    }
//                }
//                ctx.beginPath();
//                ctx.arc(loc_x,loc_y,radiusrobot/grid_size, -loc_th-Math.PI/2, -loc_th-Math.PI/2+2*Math.PI, true);
//                ctx.fill()
//                ctx.stroke()

//                if(select_patrol === i){
//                    ctx.font="bold 15px sans-serif";
//                    ctx.fillStyle = "yellow"
//                }else{
//                    ctx.font="bold 15px sans-serif";
//                    ctx.fillStyle = "white"
//                }

//                if(i===0){
//                    ctx.fillText("S",loc_x - 5,loc_y + 5);
//                }else{
//                    ctx.fillText(Number(i),loc_x - 5,loc_y + 5);
//                }

//                if(select_patrol === i){
//                    var distance = (radiusrobot/grid_size)*1.8;
//                    var distance2 = distance*0.8;
//                    var th_dist = Math.PI/8;
//                    var x = loc_x-distance*Math.sin(loc_th);
//                    var y = loc_y-distance*Math.cos(loc_th);
//                    var x1 = loc_x-distance2*Math.sin(loc_th-th_dist);
//                    var y1 = loc_y-distance2*Math.cos(loc_th-th_dist);
//                    var x2 = loc_x-distance2*Math.sin(loc_th+th_dist);
//                    var y2 = loc_y-distance2*Math.cos(loc_th+th_dist);

//                    ctx.strokeStyle = "yellow";
//                    ctx.beginPath();
//                    ctx.moveTo(x,y);
//                    ctx.lineTo(x1,y1);
//                    ctx.moveTo(x,y);
//                    ctx.lineTo(x2,y2);
//                    ctx.stroke()
//                }
//            }

//            if(select_location_show > -1){
//                //새로 추가될 location 보여주기(임시)
//                var loc_type = supervisor.getLocationTypes(select_location_show);
//                var loc_x = supervisor.getLocationx(select_location_show)/grid_size +origin_x;
//                var loc_y = supervisor.getLocationy(select_location_show)/grid_size +origin_y;
//                var loc_th = -supervisor.getLocationth(select_location_show)-Math.PI/2;

//                ctx.strokeStyle = "white";
//                ctx.lineWidth = 2;
//                ctx.fillStyle = "#FFD9FF";
//                ctx.beginPath();
//                ctx.arc(loc_x,loc_y,radiusrobot/grid_size, 0,2*Math.PI, true);
//                ctx.fill()
//                ctx.stroke()

//                var distance = (radiusrobot/grid_size)*1.8;
//                var distance2 = distance*0.8;
//                var th_dist = Math.PI/8;
//                var x = loc_x+distance*Math.cos(-loc_th-Math.PI/2);
//                var y = loc_y+distance*Math.sin(-loc_th-Math.PI/2);
//                var x1 = loc_x+distance2*Math.cos(-loc_th-Math.PI/2-th_dist);
//                var y1 = loc_y+distance2*Math.sin(-loc_th-Math.PI/2-th_dist);
//                var x2 = loc_x+distance2*Math.cos(-loc_th-Math.PI/2+th_dist);
//                var y2 = loc_y+distance2*Math.sin(-loc_th-Math.PI/2+th_dist);

//                if(select_location == i){
//                    ctx.strokeStyle = "#FFD9FF";
//                }else{
//                    ctx.strokeStyle = "#FFD9FF";
//                }
//                ctx.beginPath();
//                ctx.moveTo(x,y);
//                ctx.lineTo(x1,y1);
//                ctx.moveTo(x,y);
//                ctx.lineTo(x2,y2);
//                ctx.stroke()
//            }
//            canvas_location.requestPaint();
//        }

//    }

//    function draw_canvas_location_temp(){
//        if(canvas_location.available){
//            var ctx = canvas_location.getContext('2d');
//            ctx.strokeStyle = "white";
//            ctx.fillStyle = "yellow";
//            ctx.lineWidth = 2;
//            var robotradius = robot_radius*newscale;

//            if(new_location){
//                ctx.beginPath();
//                ctx.arc(new_loc_x*newscale,new_loc_y*newscale,robotradius/grid_size, -new_loc_th-Math.PI/2, -new_loc_th-Math.PI/2+2*Math.PI, true);
//                ctx.fill()
//                ctx.stroke()

//                var distance = (robotradius/grid_size)*2.2;
//                var distance2 = distance*0.7;
//                var th_dist = Math.PI/6;
//                var x = new_loc_x*newscale-distance*Math.sin(new_loc_th);
//                var y = new_loc_y*newscale-distance*Math.cos(new_loc_th);
//                var x1 = new_loc_x*newscale-distance2*Math.sin(new_loc_th-th_dist);
//                var y1 = new_loc_y*newscale-distance2*Math.cos(new_loc_th-th_dist);
//                var x2 = new_loc_x*newscale-distance2*Math.sin(new_loc_th+th_dist);
//                var y2 = new_loc_y*newscale-distance2*Math.cos(new_loc_th+th_dist);

//                ctx.beginPath();
//                ctx.moveTo(x,y);
//                ctx.lineTo(x1,y1);
//                ctx.lineTo(x2,y2);
//                ctx.closePath();

//                ctx.fill()
//            }
//            if(new_slam_init){
//                ctx.beginPath();
//                ctx.arc(init_x*newscale,init_y*newscale,robotradius/grid_size, -init_th-Math.PI/2, -init_th-Math.PI/2+2*Math.PI, true);
//                ctx.fill()
//                ctx.stroke()
//                print(init_x*newscale,init_y*newscale,robotradius,grid_size,init_th);

//                var distance = (robotradius/grid_size)*2.2;
//                var distance2 = distance*0.7;
//                var th_dist = Math.PI/6;
//                var x = init_x*newscale-distance*Math.sin(init_th);
//                var y = init_y*newscale-distance*Math.cos(init_th);
//                var x1 = init_x*newscale-distance2*Math.sin(init_th-th_dist);
//                var y1 = init_y*newscale-distance2*Math.cos(init_th-th_dist);
//                var x2 = init_x*newscale-distance2*Math.sin(init_th+th_dist);
//                var y2 = init_y*newscale-distance2*Math.cos(init_th+th_dist);

//                ctx.beginPath();
//                ctx.moveTo(x,y);
//                ctx.lineTo(x1,y1);
//                ctx.lineTo(x2,y2);
//                ctx.closePath();

//                ctx.fill()
//            }
//            canvas_location.requestPaint();
//        }

//    }

//    function draw_canvas_new_object(){
//        if(canvas_object.available && new_object){
//            var ctx = canvas_object.getContext('2d');

//            if(tool == "ADD_OBJECT"){
//                ctx.lineCap = "round";
//                ctx.strokeStyle = "yellow";
//                ctx.fillStyle = "steelblue";
//                ctx.lineWidth = 3;

//                ctx.beginPath();
//                ctx.moveTo(new_obj_x1*newscale,new_obj_y1*newscale);
//                ctx.rect(new_obj_x1*newscale,new_obj_y1*newscale, (new_obj_x2-new_obj_x1)*newscale, (new_obj_y2 - new_obj_y1)*newscale);
//                ctx.closePath();
//                ctx.stroke();
//                ctx.fill();

//                ctx.lineWidth = 1;
//                ctx.strokeStyle = "blue";
//                ctx.fillStyle = "blue";

//                ctx.beginPath();
//                ctx.moveTo(new_obj_x1*newscale,new_obj_y1*newscale);
//                ctx.arc(new_obj_x1*newscale,new_obj_y1*newscale,2,0, Math.PI*2);
//                ctx.closePath();
//                ctx.fill();
//                ctx.stroke();

//                ctx.beginPath();
//                ctx.moveTo(new_obj_x1*newscale,new_obj_y2*newscale);
//                ctx.arc(new_obj_x1*newscale,new_obj_y2*newscale,2,0, Math.PI*2);
//                ctx.closePath();
//                ctx.fill();
//                ctx.stroke();

//                ctx.beginPath();
//                ctx.moveTo(new_obj_x2*newscale,new_obj_y1*newscale);
//                ctx.arc(new_obj_x2*newscale,new_obj_y1*newscale,2,0, Math.PI*2);
//                ctx.closePath();
//                ctx.fill();
//                ctx.stroke();

//                ctx.beginPath();
//                ctx.moveTo(new_obj_x2*newscale,new_obj_y2*newscale);
//                ctx.arc(new_obj_x2*newscale,new_obj_y2*newscale,2,0, Math.PI*2);
//                ctx.closePath();
//                ctx.fill();
//                ctx.stroke();
//            }else if(tool == "ADD_POINT"){
//                var point_num = supervisor.getTempObjectSize();
//                if(point_num > 0){
//                    ctx.lineCap = "round";
//                    ctx.strokeStyle = "yellow";
//                    ctx.fillStyle = "steelblue";
//                    ctx.lineWidth = 3;
//                    var point_x = (supervisor.getTempObjectX(0)/grid_size + origin_x)*newscale;
//                    var point_y = (supervisor.getTempObjectY(0)/grid_size + origin_y)*newscale;
//                    var point_x0 = point_x;
//                    var point_y0 = point_y;

//                    if(point_num > 2){
//                        ctx.beginPath();
//                        ctx.moveTo(point_x,point_y);
//                        for(var i=1; i<point_num; i++){
//                            point_x = (supervisor.getTempObjectX(i)/grid_size + origin_x)*newscale;
//                            point_y = (supervisor.getTempObjectY(i)/grid_size + origin_y)*newscale;
//                            ctx.lineTo(point_x,point_y);
//                        }
//                        if(point_num > 2){
//                            ctx.lineTo(point_x0,point_y0);
//                        }
//                        ctx.fill();
//                        ctx.stroke();
//                    }else if(point_num > 1){
//                        ctx.beginPath()
//                        ctx.moveTo(point_x,point_y)
//                        point_x = (supervisor.getTempObjectX(1)/grid_size + origin_x)*newscale;
//                        point_y = (supervisor.getTempObjectY(1)/grid_size + origin_y)*newscale;
//                        ctx.lineTo(point_x,point_y)
//                        ctx.stroke();
//                    }

//                    ctx.lineWidth = 1;
//                    ctx.strokeStyle = "blue";
//                    ctx.fillStyle = "blue";
//                    point_x = (supervisor.getTempObjectX(0)/grid_size + origin_x)*newscale;
//                    point_y = (supervisor.getTempObjectY(0)/grid_size + origin_y)*newscale;
//                    for(i=0; i<point_num; i++){
//                        ctx.beginPath();
//                        point_x = (supervisor.getTempObjectX(i)/grid_size + origin_x)*newscale;
//                        point_y = (supervisor.getTempObjectY(i)/grid_size + origin_y)*newscale;
//                        ctx.moveTo(point_x,point_y);
//                        ctx.arc(point_x,point_y,2,0, Math.PI*2);
//                        ctx.closePath();
//                        ctx.fill();
//                        ctx.stroke();
//                    }
//                }
//            }

//            canvas_object.requestPaint();
//        }
//    }

//    function draw_canvas_object(){
//        if(canvas_object.available){
//            var ctx = canvas_object.getContext('2d');
//            object_num = supervisor.getObjectNum();
//            ctx.lineWidth = 1;
//            ctx.lineCap = "round";
//            ctx.strokeStyle = "white";
//            for(var i=0; i<object_num; i++){
//                var obj_type = supervisor.getObjectName(i);
//                var obj_size = supervisor.getObjectPointSize(i);
//                var obj_x = (supervisor.getObjectX(i,0)/grid_size +origin_x)*newscale;
//                var obj_y = (supervisor.getObjectY(i,0)/grid_size +origin_y)*newscale;
//                var obj_x0 = obj_x;
//                var obj_y0 = obj_y;

//                if(select_object == i){
//                    ctx.strokeStyle = "#83B8F9";
//                    ctx.fillStyle = "#FFD9FF";
//                    ctx.lineWidth = 3;
//                }else{
//                    if(obj_type.slice(0,5) === "Table"){
//                        ctx.strokeStyle = "white";
//                        ctx.fillStyle = "#56AA72";
//                        ctx.lineWidth = 1;
//                    }else if(obj_type.slice(0,5) === "Chair"){
//                        ctx.strokeStyle = "white";
//                        ctx.fillStyle = "#727272";
//                        ctx.lineWidth = 1;
//                    }else if(obj_type.slice(0,4) === "Wall"){
//                        ctx.strokeStyle = "white";
//                        ctx.fillStyle = "white";
//                        ctx.lineWidth = 1;
//                    }else{
//                        ctx.strokeStyle = "red";
//                        ctx.fillStyle = "red";
//                        ctx.lineWidth = 1;
//                    }
//                }

//                ctx.beginPath();
//                ctx.moveTo(obj_x,obj_y);
//                for(var j=1; j<obj_size; j++){
//                    var obj_x_new = (supervisor.getObjectX(i,j)/grid_size + origin_x)*newscale;
//                    var obj_y_new = (supervisor.getObjectY(i,j)/grid_size + origin_y)*newscale;
//    //                print(obj_x,obj_y,obj_x_new,obj_y_new);
//                    if(Math.abs(obj_x - obj_x_new) > 2 || Math.abs(obj_y - obj_y_new) > 2){
//                        obj_x = obj_x_new;
//                        obj_y = obj_y_new;
//                        ctx.lineTo(obj_x,obj_y);
//                    }
//                }
//                ctx.lineTo(obj_x0,obj_y0);
//                ctx.closePath();
//                ctx.fill();
//                ctx.stroke();

//                if(state_annotation == "OBJECT"){
//                    ctx.lineWidth = 1;
//                    if(select_object == i){
//                        ctx.strokeStyle = "#83B8F9";
//                        ctx.fillStyle = "#83B8F9";
//                        for(j=0; j<obj_size; j++){
//                            ctx.beginPath();
//                            obj_x = (supervisor.getObjectX(i,j)/grid_size +origin_x)*newscale;
//                            obj_y = (supervisor.getObjectY(i,j)/grid_size +origin_y)*newscale;
//                            ctx.moveTo(obj_x,obj_y);
//                            if(select_object == i){
//                                ctx.arc(obj_x,obj_y,4,0, Math.PI*2);
//                            }else{
//                                ctx.arc(obj_x,obj_y,2,0, Math.PI*2);
//                            }

//                            ctx.closePath();
//                            ctx.fill();
//                            ctx.stroke();
//                        }
//                    }else{
////                        ctx.strokeStyle = "white";
////                        ctx.fillStyle = "white";
//                    }

//                }
//            }
//            canvas_object.requestPaint();
//        }

//    }


//    function draw_canvas_current(){
//        if(canvas_map_cur.available){
//            var ctx = canvas_map_cur.getContext('2d');
////            ctx.fillStyle = "white"
////            ctx.fillRect(0,0,canvas_map_cur.width,canvas_map_cur.height);
//            ctx.clearRect(0,0,canvas_map_cur.width,canvas_map_cur.height);
//            if(show_robot && (supervisor.is_slam_running() || map_mode === "MAPPING")){
//                robot_x = (supervisor.getRobotx()/grid_size + origin_x)*newscale;
//                robot_y = (supervisor.getRoboty()/grid_size + origin_y)*newscale;
//                robot_th = -supervisor.getRobotth()-Math.PI/2;
//                var robotradius = robot_radius*newscale

////                print(robot_th);
//                ctx.strokeStyle = "white";
//                ctx.lineWidth = 2;
//                ctx.beginPath();
//                ctx.arc(robot_x,robot_y,robotradius/grid_size, robot_th, robot_th+2*Math.PI, true);
//                ctx.fillStyle = "red";
//                ctx.fill()
//                ctx.stroke()

//                var distance = (robotradius/grid_size)*2.2;
//                var distance2 = distance*0.7;
//                var th_dist = Math.PI/6;
//                var x = robot_x+distance*Math.cos(robot_th);
//                var y = robot_y+distance*Math.sin(robot_th);
//                var x1 = robot_x+distance2*Math.cos(robot_th-th_dist);
//                var y1 = robot_y+distance2*Math.sin(robot_th-th_dist);
//                var x2 = robot_x+distance2*Math.cos(robot_th+th_dist);
//                var y2 = robot_y+distance2*Math.sin(robot_th+th_dist);

//                ctx.beginPath();
//                ctx.moveTo(x,y);
//                ctx.lineTo(x1,y1);
//                ctx.lineTo(x2,y2);
//                ctx.closePath();

//                ctx.fillStyle = "red";
//                ctx.fill()
//            }
//            //lidar
//            if(show_lidar){
//                ctx.lineWidth = 0.5;
//                ctx.strokeStyle = "red";
//                ctx.fillStyle = "red";
//                robot_x = (supervisor.getRobotx()/grid_size + origin_x)*newscale;
//                robot_y = (supervisor.getRoboty()/grid_size + origin_y)*newscale;
//                robot_th = -supervisor.getRobotth()-Math.PI/2;
////                print("REDRAW, "+robot_x,canvas_map_cur.width,canvas_map_cur.x)
//                for(var i=0; i<360; i++){
//                    var data = (supervisor.getLidar(i)/grid_size)*newscale;
//                    if(data > 0.01){
//                        ctx.beginPath();
//                        var lidar_x = robot_x + data*Math.cos((-Math.PI*i)/180 + robot_th);
//                        var lidar_y = robot_y  + data*Math.sin((-Math.PI*i)/180 + robot_th);
//                        ctx.moveTo(lidar_x, lidar_y);
//                        ctx.arc(lidar_x,lidar_y,newscale,0,Math.PI*2);
//                        ctx.closePath();
//                        ctx.fill();
//                        ctx.stroke();
//                    }
//                }
//            }
//            //path
//            if(show_path){
//                //Global path!
//                path_num = supervisor.getPathNum();
////                print("show path"+path_num);
//                path_x = robot_x;
//                path_y = robot_y;
//                path_th = robot_th;
//                ctx.lineWidth = 2;
//                for(var i=0; i<path_num; i++){
//                    var path_x_before = path_x;
//                    var path_y_before = path_y;
//                    var path_th_before = path_th;
//                    path_x = (supervisor.getPathx(i)/grid_size+origin_x)*newscale;
//                    path_y = (supervisor.getPathy(i)/grid_size+origin_y)*newscale;
//                    path_th = -supervisor.getPathth(i)-Math.PI/2;

//                    ctx.strokeStyle = "#FFD9FF";
//                    ctx.fillStyle = "#05C9FF";
//                    ctx.lineWidth = 2;
//                    ctx.beginPath();
//                    if(i>0){
//                        ctx.moveTo(path_x_before,path_y_before);
//                        ctx.lineTo(path_x,path_y);
//                        ctx.stroke()
//                    }
//                }
//                //target pose
//                if(path_num > 0){
//                    ctx.beginPath();
//                    ctx.arc(path_x,path_y,robotradius/grid_size, -path_th-Math.PI/2, -path_th-Math.PI/2+2*Math.PI, true);
//                    ctx.fill()
//                    ctx.stroke()

//                    var distance = (robotradius/grid_size)*1.8;
//                    var distance2 = distance*0.8;
//                    var th_dist = Math.PI/8;
//                    var x = path_x+distance*Math.cos(-path_th-Math.PI/2);
//                    var y = path_y+distance*Math.sin(-path_th-Math.PI/2);
//                    var x1 = path_x+distance2*Math.cos(-path_th-Math.PI/2-th_dist);
//                    var y1 = path_y+distance2*Math.sin(-path_th-Math.PI/2-th_dist);
//                    var x2 = path_x+distance2*Math.cos(-path_th-Math.PI/2+th_dist);
//                    var y2 = path_y+distance2*Math.sin(-path_th-Math.PI/2+th_dist);

//                    ctx.beginPath();
//                    ctx.moveTo(x,y);
//                    ctx.lineTo(x1,y1);
//                    ctx.moveTo(x,y);
//                    ctx.lineTo(x2,y2);
//                    ctx.stroke()
//                }

//                //Local path!
//                ctx.lineWidth = 1;
//                ctx.strokeStyle = "#05C9FF";
//                ctx.fillStyle = "#05C9FF";
//                if(path_num != 0){
//                    var localpath_num = supervisor.getLocalPathNum();
////                    print("local num : ",localpath_num);
//                    for(var i=0; i<localpath_num; i++){
//                        ctx.beginPath();
//                        var local_x = (supervisor.getLocalPathx(i)/grid_size +origin_x)*newscale;
//                        var local_y = (supervisor.getLocalPathy(i)/grid_size +origin_y)*newscale;
//                        ctx.moveTo(local_x,local_y);
//                        ctx.arc(local_x,local_y,2,0, Math.PI*2);
//                        ctx.closePath();
//                        ctx.fill();
//                        ctx.stroke();
//                    }
//                }
//            }
//            canvas_map_cur.requestPaint();
//        }
//    }

//    function draw_canvas_margin(){
//        if(canvas_map_margin.available){
//            var ctx = canvas_map_margin.getContext('2d');

//            var map_data = supervisor.getMapData(map_name);
//            var margin_obj = supervisor.getMarginObj();

//            ctx.lineWidth = 0;
//            ctx.lineCap = "round"
//            ctx.strokeStyle = "#E7584D";
//            ctx.fillStyle = "#E7584D";
//            for(var i=0; i<margin_obj.length; i++){
//                var point_x = (margin_obj[i])%map_width;
//                var point_y = Math.floor((margin_obj[i])/map_width);
//                ctx.beginPath();
//                ctx.moveTo(point_x,point_y);
//                ctx.arc(point_x,point_y,1,0,Math.PI*2);
//                ctx.fill();
//                ctx.stroke();
//            }

//            ctx.fillStyle = "#d0d0d0";
//            ctx.strokeStyle = "#d0d0d0";
//            for(var x=0; x< map_data.length; x++){
//                if(map_data[x] > 100){
//                    ctx.beginPath();
//                    ctx.moveTo((x)%map_width,Math.floor((x)/map_width));
//                    ctx.arc((x)%map_width,Math.floor((x)/map_width),0.5,0,Math.PI*2);
//                    ctx.fill();
//                    ctx.stroke();
//                }
//            }
//            update_checker.start();
//        }
//    }

//    function set_travel_draw(){
//        var ctx = canvas_map.getContext('2d');

//        var data = ctx.getImageData(0,0,map_width, map_height);
//        var array = [];
//        clear_canvas_temp();
//        for(var i=0; i<data.data.length; i=i+4){
//            if(data.data[i+3] > 0){
//                if(data.data[i] > 0){
//                    array.push(255);
//                }else{
//                    array.push(100);
//                }
//            }else{
//                array.push(0);
//            }

//        }
//        travelview.setMap(supervisor.getTravel(array));
//    }
//}

