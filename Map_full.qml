import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import "."
import io.qt.Supervisor 1.0


Item {
    id: map_full
    objectName: "map_full"
    width: 800
    height: 800

    //////========================================================================================Mode
    property bool just_show_map: false
    property bool mapping_mode: false

    property bool show_connection: false
    property bool show_buttons: false

    onShow_buttonsChanged: {
        print("showbuttons = "+show_buttons);
    }

    property bool is_slam_running: false
    property bool show_object: false
    property bool show_location: false
    property bool show_patrol: false
    property bool show_travelline: false
    property bool show_path: false
    property bool show_robot: false
    property bool show_margin: false
    property bool show_lidar: false

    property bool use_minimap: false
    property bool use_rawmap: false

    //0(location patrol) 1:(path patrol)
    property int patrol_mode: 0

    //Annotation State (None, Drawing, Object, Location, Travelline)
    property string state_annotation: "NONE"

    //Annotation State (0: state, 1: load/edit, 2: object, 3: location, 4: travel line)
    property bool robot_following: just_show_map?false:true

    //Map Image File Path / Name
    property string map_name: ""

    //////========================================================================================Map Image Variable
    property var grid_size: 0.02
    property int origin_x: 500
    property int origin_y: 500
    property var robot_radius: supervisor.getRobotRadius()
    property var map_width: 1000
    property var map_height: 1000

    //////========================================================================================Annotation Tool
    //Tool Num (MOVE, BRUSH, ADD_OBJECT, ADD_POINT, EDIT_POINT, ADD_LOCATION, EDIT_LOCATION, ADD_LINE, SLAM_INIT, ADD_PATROL_LOCATION)
    property string tool: "MOVE"
    property var brush_size: 10
    property color brush_color: "black"
    property bool flag_margin: false

    property int location_num: supervisor.getLocationNum();
    property int path_num: supervisor.getPathNum();
    property int object_num: supervisor.getObjectNum();
    property var location_types
    property var location_x
    property var location_y
    property var location_th
    property var path_x
    property var path_y
    property var path_th

    property bool new_slam_init: false
    property var init_x: supervisor.getInitPoseX()/grid_size;
    property var init_y: supervisor.getInitPoseY()/grid_size;
    property var init_th:-supervisor.getInitPoseTH()-Math.PI/2;

    property var robot_x: supervisor.getRobotx()/grid_size;
    property var robot_y: supervisor.getRoboty()/grid_size;
    property var robot_th:-supervisor.getRobotth()-Math.PI/2;

    property int select_object: -1
    property int select_object_point: -1
    property int select_location: -1
    property int select_patrol: -1
    property int select_line: -1
    property int select_travel_line: -1
    property int select_location_show: -1

    property bool new_travel_line: false
    property bool new_line_point1: false
    property bool new_line_point2: false
    property int new_line_x1;
    property int new_line_x2;
    property int new_line_y1;
    property int new_line_y2;

    property bool new_location: false
    property bool new_loc_available: false
    property var new_loc_x;
    property var new_loc_y;
    property var new_loc_th;

    property bool new_object: false
    property int new_obj_x1;
    property int new_obj_y1;
    property int new_obj_x2;
    property int new_obj_y2;

    //////========================================================================================Canvas Tool
    property bool refreshMap: true

    onRobot_followingChanged: {
        if(robot_following){
            var newx = -(robot_x-origin_x)*canvas_map.scale - origin_x + rect_map.width/2;
            if(newx  > canvas_map.width*(canvas_map.scale - 1)/2){
                canvas_map.x = canvas_map.width*(canvas_map.scale - 1)/2
            }else if(newx < -(canvas_map.width*(canvas_map.scale - 1)/2 + canvas_map.width - rect_map.width)){
                canvas_map.x = -(canvas_map.width*(canvas_map.scale - 1)/2 + canvas_map.width - rect_map.width)
            }else{
                canvas_map.x = newx;
            }
            var newy = -(robot_y-origin_y)*canvas_map.scale - origin_y + rect_map.width/2;
            if(newy  > canvas_map.height*(canvas_map.scale - 1)/2){
                canvas_map.y = canvas_map.height*(canvas_map.scale - 1)/2
            }else if(newy < -(canvas_map.height*(canvas_map.scale - 1)/2 + canvas_map.height - rect_map.height)){
                canvas_map.y = -(canvas_map.height*(canvas_map.scale - 1)/2 + canvas_map.height - rect_map.height)
            }else{
                canvas_map.y = newy;
            }
        }

    }

    onRobot_xChanged: {
        if(robot_following){
            var newx = -(robot_x-origin_x)*canvas_map.scale - origin_x + rect_map.width/2;
            if(newx  > canvas_map.width*(canvas_map.scale - 1)/2){
                canvas_map.x = canvas_map.width*(canvas_map.scale - 1)/2
            }else if(newx < -(canvas_map.width*(canvas_map.scale - 1)/2 + canvas_map.width - rect_map.width)){
                canvas_map.x = -(canvas_map.width*(canvas_map.scale - 1)/2 + canvas_map.width - rect_map.width)
            }else{
                canvas_map.x = newx;
            }
        }
    }
    onRobot_yChanged: {
        if(robot_following){
            var newy = -(robot_y-origin_y)*canvas_map.scale - origin_y + rect_map.width/2;
            if(newy  > canvas_map.height*(canvas_map.scale - 1)/2){
                canvas_map.y = canvas_map.height*(canvas_map.scale - 1)/2
            }else if(newy < -(canvas_map.height*(canvas_map.scale - 1)/2 + canvas_map.height - rect_map.height)){
                canvas_map.y = -(canvas_map.height*(canvas_map.scale - 1)/2 + canvas_map.height - rect_map.height)
            }else{
                canvas_map.y = newy;
            }
        }
    }

    Behavior on robot_x{
        NumberAnimation{
            duration: 200
        }
    }
    Behavior on robot_y{
        NumberAnimation{
            duration: 200
        }
    }
    Behavior on robot_th{
        NumberAnimation{
            duration: 200
        }
    }

    Component.onCompleted: {
        loadmap("");
    }

    //Annotation State (None, Drawing, Object, Location, Travelline)
    onState_annotationChanged: {
        tool = "MOVE";
        if(state_annotation == "NONE"){

        }else if(state_annotation == "DRAWING"){

        }else if(state_annotation == "OBJECT"){
            show_object = true;
        }else if(state_annotation == "LOCATION"){
            show_object = true;
            show_location = true;
            show_margin = true;
            find_map_walls();
        }else if(state_annotation == "TRAVELLINE"){
            show_travelline = true;
        }else if(state_annotation == "SAVE"){
            show_location = true;
            show_object = true;
            show_robot = true;
            show_travelline = true;
        }
        update_canvas_all();
    }

    function brushchanged(){
        brushview.visible = true;
    }
    function brushdisappear(){
        brushview.visible = false;
    }

    function update_mapping(){
        canvas_map.requestPaint();
    }

    //////========================================================================================Main Canvas
    Rectangle{
        id: rect_map
        anchors.fill: parent
        clip: true
        Canvas{
            id: canvas_map
            width: map_width
            height: map_height
            antialiasing: true
            property var lineWidth: brush_size

            //drawing 용
            property real lastX
            property real lastY
            property var lineX
            property var lineY

            Behavior on scale{
                NumberAnimation{
                    duration: just_show_map?0:300
                }
            }
            Behavior on x{
                NumberAnimation{
                    duration: mapping_mode?0:100
                }
            }
            Behavior on y{
                NumberAnimation{
                    duration: mapping_mode?0:100
                }
            }

            onXChanged: {
                if(canvas_map.x  > canvas_map.width*(canvas_map.scale - 1)/2){
                    canvas_map.x = canvas_map.width*(canvas_map.scale - 1)/2
                }else if(canvas_map.x < -(canvas_map.width*(canvas_map.scale - 1)/2 + canvas_map.width - rect_map.width)){
                    canvas_map.x = -(canvas_map.width*(canvas_map.scale - 1)/2 + canvas_map.width - rect_map.width)
                }
            }
            onYChanged: {
                if(canvas_map.y  > canvas_map.height*(canvas_map.scale - 1)/2){
                    canvas_map.y = canvas_map.height*(canvas_map.scale - 1)/2
                }else if(canvas_map.y < -(canvas_map.height*(canvas_map.scale - 1)/2 + canvas_map.height - rect_map.height)){
                    canvas_map.y = -(canvas_map.height*(canvas_map.scale - 1)/2 + canvas_map.height - rect_map.height)
                }
            }
            onScaleChanged: {
                if(canvas_map.x  > canvas_map.width*(canvas_map.scale - 1)/2){
                    canvas_map.x = canvas_map.width*(canvas_map.scale - 1)/2
                }else if(canvas_map.x < -(canvas_map.width*(canvas_map.scale - 1)/2 + canvas_map.width - rect_map.width)){
                    canvas_map.x = -(canvas_map.width*(canvas_map.scale - 1)/2 + canvas_map.width - rect_map.width)
                }

                if(canvas_map.y  > canvas_map.height*(canvas_map.scale - 1)/2){
                    canvas_map.y = canvas_map.height*(canvas_map.scale - 1)/2
                }else if(canvas_map.y < -(canvas_map.height*(canvas_map.scale - 1)/2 + canvas_map.height - rect_map.height)){
                    canvas_map.y = -(canvas_map.height*(canvas_map.scale - 1)/2 + canvas_map.height - rect_map.height)
                }
            }


            onPaint:{
                var ctx = getContext('2d');
                if(mapping_mode){
                    draw_canvas_mapping();
                }else{
                    if(map_name != ""){
                        if(refreshMap){
                            print("draw map refresh");
                            refreshMap = false;
                            //캔버스 초기화
                            ctx.clearRect(0,0,map_width,map_height);

                            //map 이미지 불러와서 그림
                            draw_canvas_map();

                            //drawing한 line들 다시 그림
                            if(state_annotation == "DRAWING"){
                                draw_canvas_lines();
                            }
                        }
                        // 새로 그려지는 line
                        if(tool == "BRUSH"){
                            ctx.lineWidth = canvas_map.lineWidth
                            ctx.strokeStyle = brush_color
                            ctx.lineCap = "round"
                            ctx.beginPath()
                            ctx.moveTo(lastX, lastY)
                            if(point1.pressed){
                                lastX = point1.x
                                lastY = point1.y
                            }
                            supervisor.setLine(lastX,lastY);
                            ctx.lineTo(lastX, lastY)
                            ctx.stroke()
                        }
                    }else{
                        fill_canvas_map();
                    }
                }
            }

        }

        Canvas{
            id: canvas_map_margin
            width: map_width
            height: map_height
            antialiasing: true
            x: canvas_map.x
            y: canvas_map.y
            scale: canvas_map.scale
            onPaint: {
                var ctx = getContext('2d');
                ctx.clearRect(0,0,map_width,map_height);

                if(show_margin){
                    draw_canvas_margin();
                }
            }
        }

        Canvas{
            id: canvas_object
            width: map_width
            height: map_height
            x: canvas_map.x
            y: canvas_map.y
            scale: canvas_map.scale
            antialiasing: true
            onPaint:{
                var ctx = getContext("2d");
                ctx.clearRect(0,0,map_width,map_height);
                if(show_object){
                    draw_canvas_object();
                    draw_canvas_new_object();
                }
            }
        }

        Canvas{
            id: canvas_location
            width: map_width
            height: map_height
            x: canvas_map.x
            y: canvas_map.y
            scale: canvas_map.scale
            antialiasing: true
            onPaint:{
                var ctx = getContext("2d");
                ctx.clearRect(0,0,map_width,map_height);
                if(show_location){
                    draw_canvas_location();
                    draw_canvas_location_temp();
                }
                if(show_patrol){
                    draw_canvas_patrol_location();
                    draw_canvas_location_temp();
                }

            }
        }

        Canvas{
            id: canvas_travelline
            width: map_width
            height: map_height
            x: canvas_map.x
            y: canvas_map.y
            scale: canvas_map.scale
            antialiasing: true
            onPaint:{
                var ctx = getContext('2d');
                ctx.clearRect(0,0,map_width,map_height);
                if(show_travelline)
                    draw_canvas_travelline();
            }

        }

        Canvas{
            id: canvas_map_cur
            width: map_width
            height: map_height
            x: canvas_map.x
            y: canvas_map.y
            scale: canvas_map.scale
            antialiasing: true
            onPaint:{
                var ctx = getContext("2d");
                ctx.clearRect(0,0,map_width,map_height);

                if(show_robot){
                    draw_canvas_global_path();
                    draw_canvas_local_path();
                    draw_canvas_cur_pose();
                    if(tool == "SLAM_INIT")
                        draw_canvas_init_pos();
                }
                if(show_lidar)
                    draw_canvas_lidar();
            }
            MultiPointTouchArea{
                id: area_map
                anchors.fill: parent
                minimumTouchPoints: 1
                maximumTouchPoints: 2
                property var dmoveX : 0;
                property var dmoveY : 0;
                property var startX : 0;
                property var startY : 0;
                property var startDist : 0;
                MouseArea{
                    anchors.fill: parent
                    onWheel: {
                        var ctx = canvas_map.getContext('2d');
                        var new_scale;
                        wheel.accepted = false;
                        if(wheel.angleDelta.y > 0){
                            new_scale = canvas_map.scale + 0.5;
                            if(new_scale > 5){
                                canvas_map.scale = 5;
                            }else{
                                canvas_map.scale = new_scale;
                            }
                        }else{
                            new_scale = canvas_map.scale - 0.5;
                            if(rect_map.width > new_scale*canvas_map.width){
                                canvas_map.scale = rect_map.width/canvas_map.width;
                            }else{
                                canvas_map.scale = new_scale;
                            }
                        }
                    }
                }
                touchPoints: [TouchPoint{id:point1},TouchPoint{id:point2}]
                onPressed: {
                    if(tool == "MOVE"){//move
                        if(point1.pressed && point2.pressed){
                            var dx = Math.abs(point1.x-point2.x);
                            var dy = Math.abs(point1.y-point2.y);
                            var dist = Math.sqrt(dx*dx + dy*dy);
                            area_map.startX = (point1.x+point2.x)/2;
                            area_map.startY = (point1.y+point2.y)/2;
                            area_map.startDist = dist;
                        }else if(point1.pressed){
                            area_map.startX = point1.x;
                            area_map.startY = point1.y;
                        }
                    }else if(tool == "BRUSH"){//draw
                        canvas_map.lastX = point1.x;
                        canvas_map.lastY = point1.y;
                        supervisor.startLine(brush_color, canvas_map.lineWidth);
                        supervisor.setLine(point1.x,point1.y);
                    }else if(tool == "EDIT_POINT"){
                        select_object_point = supervisor.getObjPointNum(select_object, point1.x, point1.y);

                    }else if(tool == "EDIT_OBJECT"){
                        select_object_point = supervisor.getObjPointNum(select_object, point1.x, point1.y);

                    }else if(tool == "ADD_LOCATION"){
                        new_location = true;
                        new_loc_available = false;
                        new_loc_x = point1.x;
                        new_loc_y = point1.y;
                        new_loc_th = 0;
                    }else if(tool == "ADD_PATROL_LOCATION"){
                        new_location = true;
                        new_loc_available = false;
                        new_loc_x = point1.x;
                        new_loc_y = point1.y;
                        new_loc_th = 0;
                    }else if(tool == "EDIT_LOCATION"){
                        supervisor.moveLocationPoint(select_location, point1.x, point1.y, 0);
                    }else if(tool == "SLAM_INIT"){
                        new_slam_init = true;
                        init_x = point1.x;
                        init_y = point1.y;
                        init_th = 0;
                    }else if(tool == "ADD_OBJECT"){
                        supervisor.clearObjectPoints();
                        new_object = true;
                        new_obj_x1 = point1.x;
                        new_obj_y1 = point1.y;
                        new_obj_x2 = point1.x;
                        new_obj_y2 = point1.y;
                    }
                }

                onReleased: {
                    if(!point1.pressed&&!point2.pressed){
                        if(tool == "BRUSH"){
                            supervisor.stopLine();
                        }else if(tool == "ADD_POINT"){//add point
                            supervisor.addObjectPoint(point1.x, point1.y);
                            loader_menu.item.check_object_size();
                        }else if(tool == "EDIT_POINT"){
                            select_object_point = -1;
                            supervisor.setObjPose();
                        }else if(tool == "EDIT_OBJECT"){
                            select_object_point = -1;
                            supervisor.setObjPose();
                        }else if(tool == "ADD_PATROL_LOCATION"){
                            if(new_location){
                                popup_add_patrol_1.open();
                            }
                        }else if(tool == "EDIT_LOCATION"){
                            updatelocationcollision();
                            tool = "NONE";
                        }else if(tool == "SLAM_INIT"){
                            supervisor.setInitPos(init_x,init_y, init_th);
                        }else if(tool == "ADD_LINE"){
                            if(state_annotation == "TRAVELLINE"){
                                if(new_line_point1){
                                    new_line_x2 = point1.x;
                                    new_line_y2 = point1.y;
                                    new_line_point2 = true;
                                }else{
                                    new_line_point1 = true;
                                    new_line_x1 = point1.x;
                                    new_line_y1 = point1.y;
                                }
                                canvas_travelline.requestPaint();
                            }else{
                                tool = "NONE";
                            }
                        }else if(tool == "ADD_OBJECT"){
                            supervisor.addObjectPoint(new_obj_x1,new_obj_y1);
                            supervisor.addObjectPoint(new_obj_x1,new_obj_y2);
                            supervisor.addObjectPoint(new_obj_x2,new_obj_y2);
                            supervisor.addObjectPoint(new_obj_x2,new_obj_y1);
                            loader_menu.item.check_object_size();
                        }else{
                            if(state_annotation == "OBJECT"){
                                select_object = supervisor.getObjNum(point1.x,point1.y);
                                loader_menu.item.setcur(select_object);
                                canvas_object.requestPaint();
                            }else if(state_annotation == "LOCATION"){
                                select_location = supervisor.getLocNum(point1.x,point1.y);
                                loader_menu.item.setcur(select_location);
                                canvas_location.requestPaint();
                            }else if(state_annotation == "TRAVELLINE"){
                                select_line = supervisor.getTlineNum(point1.x, point1.y)/2;
                                loader_menu.item.setcur(select_line);
                                canvas_travelline.requestPaint();
                            }
                        }
                    }
                }
                onTouchUpdated:{
                    if(tool == "MOVE"){
                        robot_following = false;
                        if(point1.pressed&&point2.pressed){
                            var dx = Math.abs(point1.x-point2.x);
                            var dy = Math.abs(point1.y-point2.y);
                            var mx = (point1.x+point2.x)/2;
                            var my = (point1.y+point2.y)/2;
                            var dist = Math.sqrt(dx*dx + dy*dy);
                            var dscale = (dist)/startDist;
                            var new_scale = canvas_map.scale*dscale;

                            if(new_scale > 5)   new_scale = 5;
                            else if(new_scale < 1) new_scale = 1;

                            print("drag",mx,my,dist,new_scale,canvas_map.scale);
                            dmoveX = (mx - startX);
                            dmoveY = (my - startY);

                            if(canvas_map.x + dmoveX > canvas_map.width*(new_scale - 1)/2){

                            }else if(canvas_map.x +dmoveX < -(canvas_map.width*(new_scale - 1)/2 + canvas_map.width - rect_map.width)){

                            }else{
                                canvas_map.scale = new_scale;
                                canvas_map.x += dmoveX;
                            }
                            if(canvas_map + dmoveY > canvas_map.height*(new_scale - 1)/2){

                            }else if(canvas_map.y + dmoveY < -(canvas_map.height*(new_scale - 1)/2 + canvas_map.height - rect_map.height)){

                            }else{
                                canvas_map.scale = new_scale;
                                canvas_map.y += dmoveY;
                            }
                        }else{
                            dmoveX = (point1.x - startX)*canvas_map.scale;
                            dmoveY = (point1.y - startY)*canvas_map.scale;

                            if(canvas_map.x + dmoveX > canvas_map.width*(canvas_map.scale - 1)/2){

                            }else if(canvas_map.x +dmoveX < -(canvas_map.width*(canvas_map.scale - 1)/2 + canvas_map.width - rect_map.width)){

                            }else{
                                canvas_map.x += dmoveX;
                            }
                            if(canvas_map.y + dmoveY > canvas_map.height*(canvas_map.scale - 1)/2){

                            }else if(canvas_map.y + dmoveY < -(canvas_map.height*(canvas_map.scale - 1)/2 + canvas_map.height - rect_map.height)){

                            }else{
                                canvas_map.y += dmoveY;
                            }
                        }
                    }else if(tool == "BRUSH"){
                        canvas_map.requestPaint()
                    }else if(tool == "EDIT_POINT"){
                        if(select_object_point != -1){
                            supervisor.editObject(select_object,select_object_point,point1.x, point1.y);
                        }
                    }else if(tool == "EDIT_OBJECT"){
                        if(select_object_point != -1){
                            supervisor.editObject(select_object, select_object_point, point1.x, point1.y);
                        }
                    }else if(tool == "ADD_LOCATION"){
                        if(point1.y-new_loc_y == 0){
                            new_loc_th = 0;
                        }else{
                            new_loc_th = Math.atan2(-(point1.x-new_loc_x),-(point1.y-new_loc_y));
                        }
                        canvas_location.requestPaint();
                    }else if(tool == "ADD_PATROL_LOCATION"){
                        if(point1.y-new_loc_y == 0){
                            new_loc_th = 0;
                        }else{
                            new_loc_th = Math.atan2(-(point1.x-new_loc_x),-(point1.y-new_loc_y));
                        }
                        canvas_location.requestPaint();
                    }else if(tool == "EDIT_LOCATION"){
                        var new_th;
                        var cur_x = supervisor.getLocationx(select_location)/grid_size + origin_x;
                        var cur_y = supervisor.getLocationy(select_location)/grid_size + origin_y;
                        if(point1.y-cur_y == 0){
                            new_th= 0;
                        }else{
                            new_th = Math.atan2(-(point1.x-cur_x),-(point1.y-cur_y));
                        }
                        supervisor.moveLocationPoint(select_location, cur_x,cur_y, new_th);
                        canvas_location.requestPaint();
                    }else if(tool == "SLAM_INIT"){
                        if(point1.y-init_y == 0){
                            init_th = 0;
                        }else{
                            init_th = Math.atan2(-(point1.x-init_x),-(point1.y-init_y));
                        }
                        canvas_map_cur.requestPaint();
                    }else if(tool == "ADD_OBJECT"){
                        new_obj_x2 = point1.x
                        new_obj_y2 = point1.y
                        canvas_object.requestPaint();
                    }
                }
            }
        }

        Rectangle{
            id: btn_robot_following
            width: 40
            height: 40
            radius: 40
            visible: show_buttons && state_annotation=="NONE"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 5
            color: robot_following?"#12d27c":"#e8e8e8"
            Image{
                anchors.centerIn: parent
                source: "icon/icon_cur.png"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    robot_following = true;
                }
            }
        }

        Rectangle{
            id: btn_show_lidar
            width: 40
            height: 40
            radius: 40
            visible: show_buttons   && state_annotation=="NONE"
            anchors.top: btn_robot_following.bottom
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            color: show_lidar?"#12d27c":"#e8e8e8"
            Image{
                anchors.centerIn: parent
                source: "icon/icon_lidar.png"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(show_lidar){
                        show_lidar = false;
                    }else{
                        show_lidar = true;
                    }
                }
            }
        }

        Rectangle{
            id: brushview
            visible: false
            width: (brush_size+1)*canvas_map.scale
            height: (brush_size+1)*canvas_map.scale
            radius: (brush_size+1)*canvas_map.scale
            border.width: 1
            border.color: "black"
            anchors.centerIn: rect_map
        }

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            visible: show_connection && !is_slam_running && !just_show_map && tool!="SLAM_INIT" && state_annotation=="NONE"
            border.color: "#E7584D"
            border.width: 5
            Column{
                anchors.centerIn: parent
                spacing: 10
                Image{
                    width: 100
                    height: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "icon/icon_warning.png"
                }
                Text{
                    text: "SLAM 활성화 안됨"
                    font.family: font_noto_b.name
                    font.pixelSize: 40
                    color: "#E7584D"
                }
            }

        }
    }


    //////========================================================================================Sub Canvas
    Canvas{
        id: canvas_robot
        visible: false
        width: (robot_radius/grid_size)*2
        height: (robot_radius/grid_size)*2
        onPaint: {
            var ctx = getContext('2d');
            ctx.clearRect(0,0,width,height);
            ctx.lineWidth = 1;
            ctx.fillStyle = "yellow";
            ctx.strokeStyle = "yellow";
            ctx.beginPath();
            ctx.moveTo(width/2,width/2);
            ctx.arc(width/2,width/2,robot_radius/grid_size, 0, 2*Math.PI, true);
            ctx.moveTo(width/2,width/2);
            ctx.fill()
            ctx.stroke()
        }
    }

    Canvas{
        id: canvas_map_temp
        visible: false
        width: map_width
        height: map_height
    }

    Image{
        id: image_charging
        visible: false
        width: 20
        height: 20
        source: "icon/btn_lock.png"
    }
    Image{
        id: image_resting
        visible: false
        width: 20
        height: 20
        source: "icon/btn_home.png"
    }

    //////========================================================================================Timer
    Timer{
        id: update_checker
        interval: 1000
        running: flag_margin
        repeat: false
        onTriggered: {
            print("update_checker")
            updatelocationcollision();
            flag_margin = false;
        }
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

                //캔버스에 맵을 그림
                refreshMap = true;
                update_canvas_all();

                //타이머 종료
                timer_loadmap.stop();
                supervisor.writelog("[QML] LoadMap(AUTO) : "+map_name);
            }
            if(just_show_map){
                canvas_map.scale = rect_map.width/canvas_map.width;
            }
        }
    }

    //로봇 연결되면 주기적 수행
    Timer{
        id: update_map
        running: true
        repeat: true
        interval: 200
        onTriggered: {
            if(supervisor.getLCMConnection()){
                is_slam_running = supervisor.is_slam_running();
                if(show_robot){
                    canvas_map_cur.requestPaint();
                    robot_x = supervisor.getRobotx()/grid_size;
                    robot_y = supervisor.getRoboty()/grid_size;
                    robot_th = -supervisor.getRobotth()-Math.PI/2;
                    path_num = supervisor.getPathNum();
                }
            }
        }
    }

    //////========================================================================================Variable update function
    function init_mode(){
        print("init mode")
        tool = "MOVE";

        select_object = -1;
        select_object_point = -1;
        select_location = -1;
        select_patrol = -1;
        select_line = -1;
        select_travel_line = -1;

        new_travel_line = false;
        new_location = false;
        new_line_point1 = false;
        new_line_point2 = false;

        supervisor.clearObjectPoints();

        show_buttons = false;
        show_connection = true;
        show_lidar = false;
        show_location = false;
        show_margin = false;
        show_object = false;
        show_path = false;
        show_patrol = false;
        show_robot = false;
        show_travelline = false;

        refreshMap = true;
        update_canvas_all();
        clear_margin();
    }

    property var map_array:[]

    function loadmap(name){
        supervisor.writelog("[QML] LoadMap : "+name);
        if(typeof(name) !== 'undefined'){
            map_name = name;
        }else{
            map_name = "";
        }
        update_map_variable();
        update_canvas_all();
//        nn();

        if(just_show_map){
            canvas_map.scale = map_full.width/canvas_map.width;
        }
    }

    function update_map_variable(){
        supervisor.clear_all();
        location_num = supervisor.getLocationNum();
        origin_x = supervisor.getOrigin()[0];
        origin_y = supervisor.getOrigin()[1];
        grid_size = supervisor.getGridWidth();
        object_num = supervisor.getObjectNum();
    }
    function update_canvas_all(){
        refreshMap = true;
        canvas_map.requestPaint();
        canvas_object.requestPaint();
        canvas_location.requestPaint();
        canvas_map_cur.requestPaint();
        canvas_travelline.requestPaint();
    }
    function update_path(){
        canvas_map_cur.requestPaint();
    }

    function update_margin(){
        update_checker.start();
        canvas_map_margin.requestPaint();
    }
    function clear_margin(){
        canvas_map_margin.requestPaint();
    }

    //////========================================================================================Annotation function
    function find_map_walls(){
        print("find map walls");
        supervisor.clearMarginObj();

        var ctx = canvas_map.getContext('2d');
        var map_data = ctx.getImageData(0,0,map_width, map_height);

        for(var x=0; x< map_data.data.length; x=x+4){
            if(map_data.data[x] > 100){
                supervisor.setMarginPoint(Math.abs(x/4));
            }
        }


        var ctx1 = canvas_object.getContext('2d');
        var map_data1 = ctx1.getImageData(0,0,map_width, map_height);

        for(x=0; x< map_data1.data.length; x=x+4){
            if(map_data1.data[x+3] > 0){
                supervisor.setMarginPoint(Math.abs(x/4));
            }
        }
    }
    function updatelocationcollision(){
        print("updatelocationcollision")
        loader_menu.item.update();
    }
    function is_Col_loc(x,y){
        if(map_name != ""){
            var ctx = canvas_map.getContext('2d');
            var ctx1 = canvas_map_margin.getContext('2d');
            var ctx_robot = canvas_robot.getContext('2d');
            var map_data = ctx.getImageData(0,0,map_width, map_height)
            var map_data1 = ctx1.getImageData(0,0,map_width,map_height);
            var robot_data = ctx_robot.getImageData(0,0,canvas_robot.width,canvas_robot.height);
            for(var i=0; i<robot_data.data.length; i=i+4){
                if(robot_data.data[i+3] > 0){
                    var robot_x = Math.floor((i/4)%canvas_robot.width + x - canvas_robot.width/2);
                    var robot_y = Math.floor((i/4)/canvas_robot.width + y - canvas_robot.width/2);
                    var pixel_num = robot_y*canvas_map.width + robot_x;
                    if(map_data.data[pixel_num*4] == 0 || map_data.data[pixel_num*4] > 100){
                        //collision walls
                        return true;
                    }else if(map_data1.data[pixel_num*4+3] > 0){
                        //collision to margin
                        return true;
                    }
                }
            }
        }
        return false;
    }

    function save_map(name){
        canvas_map.save(name);
    }

    //////========================================================================================Canvas drawing function
    function draw_canvas_lines(){
        var ctx = canvas_map.getContext('2d');
        for(var i=0; i<supervisor.getCanvasSize(); i++){
            ctx.lineWidth = supervisor.getLineWidth(i);
            ctx.strokeStyle = supervisor.getLineColor(i);
            ctx.lineCap = "round"
            ctx.beginPath()
            canvas_map.lineX = supervisor.getLineX(i);
            canvas_map.lineY = supervisor.getLineY(i);
            for(var j=0;j<canvas_map.lineX.length-1;j++){
                ctx.moveTo(canvas_map.lineX[j], canvas_map.lineY[j])
                ctx.lineTo(canvas_map.lineX[j+1], canvas_map.lineY[j+1])
            }
            ctx.stroke()
        }
    }
    function clear_canvas_map(){
        var ctx = canvas_map.getContext('2d');
        ctx.clearRect(0,0,map_width,map_height);
    }
    function fill_canvas_map(){
        var ctx = canvas_map.getContext('2d');
        ctx.fillStyle = "black";
        ctx.fillRect(0,0,map_width,map_height);
        print("fill canvas map");
        refreshMap = false;
        canvas_map.scale = rect_map.width/canvas_map.width;
        canvas_map.requestPaint();
    }

    function draw_canvas_mapping(){
        var ctx = canvas_map.getContext('2d');

        var map_data = supervisor.getMapping();
//        print(map_data.length);
        var temp_image = ctx.createImageData(map_width,map_height);

        for(var i=0; i<map_data.length; i++){
            temp_image.data[4*i+0] = map_data[i];
            temp_image.data[4*i+1] = map_data[i];
            temp_image.data[4*i+2] = map_data[i];
            temp_image.data[4*i+3] = 255;
        }
        ctx.drawImage(temp_image,0,0,map_width,map_height);
    }
    function draw_canvas_map(){
        print("draw canvas map")
        var ctx = canvas_map.getContext('2d');
        if(use_rawmap){
            var map_data = supervisor.getRawMap(map_name);
        }else if(use_minimap){
            map_data = supervisor.getMiniMap(map_name);
        }else{
            map_data = supervisor.getMap(map_name);

        }

        print(map_data.length);
        var temp_image = ctx.createImageData(map_width,map_height);

        for(var i=0; i<map_data.length; i++){
            temp_image.data[4*i+0] = map_data[i];
            temp_image.data[4*i+1] = map_data[i];
            temp_image.data[4*i+2] = map_data[i];
            temp_image.data[4*i+3] = 255;
        }
        ctx.drawImage(temp_image,0,0,map_width,map_height);
    }
    function draw_canvas_location(){
        var ctx = canvas_location.getContext('2d');

        location_num = supervisor.getLocationNum();

        for(var i=0; i<location_num; i++){
            var loc_type = supervisor.getLocationTypes(i);
            var loc_x = supervisor.getLocationx(i)/grid_size +origin_x;
            var loc_y = supervisor.getLocationy(i)/grid_size +origin_y;
            var loc_th = -supervisor.getLocationth(i)-Math.PI/2;

            if(loc_type.slice(0,4) == "Char"){
                if(select_location == i){
                    ctx.drawImage(image_charging,loc_x,loc_y, image_charging.width, image_charging.height);
                }else{
                    ctx.drawImage(image_charging,loc_x,loc_y, image_charging.width, image_charging.height);
                }

            }else if(loc_type.slice(0,4) == "Rest"){
                if(select_location == i){
                    ctx.drawImage(image_resting,loc_x,loc_y, image_resting.width, image_resting.height);
                }else{
                    ctx.drawImage(image_resting,loc_x,loc_y, image_resting.width, image_resting.height);
                }
            }else{
                if(select_location == i){
                    ctx.strokeStyle = "#05C9FF";
                    ctx.lineWidth = 3;
                    ctx.fillStyle = "yellow";
                }else{
                    ctx.strokeStyle = "white";
                    ctx.lineWidth = 2;
                    ctx.fillStyle = "#83B8F9";
                }
                ctx.beginPath();
                ctx.arc(loc_x,loc_y,robot_radius/grid_size, -loc_th-Math.PI/2, -loc_th-Math.PI/2+2*Math.PI, true);
                ctx.fill()
                ctx.stroke()

                var distance = (robot_radius/grid_size)*1.8;
                var distance2 = distance*0.8;
                var th_dist = Math.PI/8;
                var x = loc_x+distance*Math.cos(-loc_th-Math.PI/2);
                var y = loc_y+distance*Math.sin(-loc_th-Math.PI/2);
                var x1 = loc_x+distance2*Math.cos(-loc_th-Math.PI/2-th_dist);
                var y1 = loc_y+distance2*Math.sin(-loc_th-Math.PI/2-th_dist);
                var x2 = loc_x+distance2*Math.cos(-loc_th-Math.PI/2+th_dist);
                var y2 = loc_y+distance2*Math.sin(-loc_th-Math.PI/2+th_dist);

                if(select_location == i){
                    ctx.strokeStyle = "yellow";
                }else{
                    ctx.strokeStyle = "#83B8F9";
                }
                ctx.beginPath();
                ctx.moveTo(x,y);
                ctx.lineTo(x1,y1);
                ctx.moveTo(x,y);
                ctx.lineTo(x2,y2);
                ctx.stroke()
            }
        }
    }
    function draw_canvas_patrol_location(){
        var ctx = canvas_location.getContext('2d');

        var patrol_num = supervisor.getPatrolNum();


        for(var i=0; i<patrol_num; i++){
            var loc_type = supervisor.getPatrolType(i);
            var loc_name = supervisor.getPatrolLocation(i);
            var loc_x = supervisor.getPatrolX(i)/grid_size+origin_x;
            var loc_y = supervisor.getPatrolY(i)/grid_size+origin_y;
            var loc_th = -supervisor.getPatrolTH(i)-Math.PI/2;

            if(select_patrol === i){
                ctx.lineWidth = 3;
                ctx.strokeStyle = "#05C9FF";
                ctx.fillStyle = "yellow";
            }else{
                ctx.strokeStyle = "white";
                ctx.lineWidth = 2;
                if(loc_type == "START"){
                    ctx.fillStyle = "#12d27c";
                }else{
                    ctx.fillStyle = "#83B8F9";
                }
            }
            ctx.beginPath();
            ctx.arc(loc_x,loc_y,robot_radius/grid_size, -loc_th-Math.PI/2, -loc_th-Math.PI/2+2*Math.PI, true);
            ctx.fill()
            ctx.stroke()

            ctx.font="bold 20px sans-serif";
            if(i===0){
                ctx.fillText("START",loc_x,loc_y);
            }else{
                ctx.fillText(Number(i),loc_x,loc_y);
            }

            if(select_patrol === i){
                var distance = (robot_radius/grid_size)*1.8;
                var distance2 = distance*0.8;
                var th_dist = Math.PI/8;
                var x = loc_x+distance*Math.cos(-loc_th-Math.PI/2);
                var y = loc_y+distance*Math.sin(-loc_th-Math.PI/2);
                var x1 = loc_x+distance2*Math.cos(-loc_th-Math.PI/2-th_dist);
                var y1 = loc_y+distance2*Math.sin(-loc_th-Math.PI/2-th_dist);
                var x2 = loc_x+distance2*Math.cos(-loc_th-Math.PI/2+th_dist);
                var y2 = loc_y+distance2*Math.sin(-loc_th-Math.PI/2+th_dist);

                if(select_location == i){
                    ctx.strokeStyle = "yellow";
                }else{
                    ctx.strokeStyle = "#83B8F9";
                }
                ctx.beginPath();
                ctx.moveTo(x,y);
                ctx.lineTo(x1,y1);
                ctx.moveTo(x,y);
                ctx.lineTo(x2,y2);
                ctx.stroke()
            }


        }

        if(select_location_show > -1){
            //새로 추가될 location 보여주기(임시)
            var loc_type = supervisor.getLocationTypes(select_location_show);
            var loc_x = supervisor.getLocationx(select_location_show)/grid_size +origin_x;
            var loc_y = supervisor.getLocationy(select_location_show)/grid_size +origin_y;
            var loc_th = -supervisor.getLocationth(select_location_show)-Math.PI/2;

            print(select_location_show, loc_x, loc_y, loc_th);


            ctx.strokeStyle = "white";
            ctx.lineWidth = 2;
            ctx.fillStyle = "#FFD9FF";
            ctx.beginPath();
            ctx.arc(loc_x,loc_y,robot_radius/grid_size, 0,2*Math.PI, true);
            ctx.fill()
            ctx.stroke()

            var distance = (robot_radius/grid_size)*1.8;
            var distance2 = distance*0.8;
            var th_dist = Math.PI/8;
            var x = loc_x+distance*Math.cos(-loc_th-Math.PI/2);
            var y = loc_y+distance*Math.sin(-loc_th-Math.PI/2);
            var x1 = loc_x+distance2*Math.cos(-loc_th-Math.PI/2-th_dist);
            var y1 = loc_y+distance2*Math.sin(-loc_th-Math.PI/2-th_dist);
            var x2 = loc_x+distance2*Math.cos(-loc_th-Math.PI/2+th_dist);
            var y2 = loc_y+distance2*Math.sin(-loc_th-Math.PI/2+th_dist);

            if(select_location == i){
                ctx.strokeStyle = "#FFD9FF";
            }else{
                ctx.strokeStyle = "#FFD9FF";
            }
            ctx.beginPath();
            ctx.moveTo(x,y);
            ctx.lineTo(x1,y1);
            ctx.moveTo(x,y);
            ctx.lineTo(x2,y2);
            ctx.stroke()
        }
    }

    function draw_canvas_location_temp(){
        if(new_location){
            var ctx = canvas_location.getContext('2d');
            ctx.strokeStyle = "white";
            ctx.lineWidth = 2;
            ctx.beginPath();
            ctx.arc(new_loc_x,new_loc_y,robot_radius/grid_size, -new_loc_th-Math.PI/2, -new_loc_th-Math.PI/2+2*Math.PI, true);
            ctx.fillStyle = "yellow";
            ctx.fill()
            ctx.stroke()

            var distance = (robot_radius/grid_size)*2.2;
            var distance2 = distance*0.7;
            var th_dist = Math.PI/6;
            var x = new_loc_x+distance*Math.cos(-new_loc_th-Math.PI/2);
            var y = new_loc_y+distance*Math.sin(-new_loc_th-Math.PI/2);
            var x1 = new_loc_x+distance2*Math.cos(-new_loc_th-Math.PI/2-th_dist);
            var y1 = new_loc_y+distance2*Math.sin(-new_loc_th-Math.PI/2-th_dist);
            var x2 = new_loc_x+distance2*Math.cos(-new_loc_th-Math.PI/2+th_dist);
            var y2 = new_loc_y+distance2*Math.sin(-new_loc_th-Math.PI/2+th_dist);

            ctx.beginPath();
            ctx.moveTo(x,y);
            ctx.lineTo(x1,y1);
            ctx.lineTo(x2,y2);
            ctx.closePath();

            ctx.fillStyle = "yellow";
            ctx.fill()
        }
    }
    function draw_canvas_new_object_rect(){
        var ctx = canvas_object.getContext('2d');
        ctx.lineCap = "round";
        ctx.strokeStyle = "white";
        ctx.fillStyle = "#FFD9FF";
        ctx.lineWidth = 3;


        ctx.beginPath();
        ctx.moveTo(new_obj_x1,new_obj_y1);
        ctx.rect(new_obj_x1,new_obj_y1, new_obj_x2-new_obj_x1, new_obj_y2 - new_obj_y1);
        ctx.closePath();
        ctx.stroke();
        ctx.fill();



        ctx.lineWidth = 1;
        ctx.strokeStyle = "white";
        ctx.fillStyle = "white";

        ctx.beginPath();
        ctx.moveTo(new_obj_x1,new_obj_y1);
        ctx.arc(new_obj_x1,new_obj_y1,2,0, Math.PI*2);
        ctx.closePath();
        ctx.fill();
        ctx.stroke();

        ctx.beginPath();
        ctx.moveTo(new_obj_x1,new_obj_y2);
        ctx.arc(new_obj_x1,new_obj_y2,2,0, Math.PI*2);
        ctx.closePath();
        ctx.fill();
        ctx.stroke();

        ctx.beginPath();
        ctx.moveTo(new_obj_x2,new_obj_y1);
        ctx.arc(new_obj_x2,new_obj_y1,2,0, Math.PI*2);
        ctx.closePath();
        ctx.fill();
        ctx.stroke();

        ctx.beginPath();
        ctx.moveTo(new_obj_x2,new_obj_y2);
        ctx.arc(new_obj_x2,new_obj_y2,2,0, Math.PI*2);
        ctx.closePath();
        ctx.fill();
        ctx.stroke();
    }

    function draw_canvas_object(){
        var ctx = canvas_object.getContext('2d');
        object_num = supervisor.getObjectNum();
        ctx.lineWidth = 1;
        ctx.lineCap = "round";
        ctx.strokeStyle = "white";
        for(var i=0; i<object_num; i++){
            var obj_type = supervisor.getObjectName(i);
            var obj_size = supervisor.getObjectPointSize(i);
            var obj_x = supervisor.getObjectX(i,0)/grid_size +origin_x;
            var obj_y = supervisor.getObjectY(i,0)/grid_size +origin_y;
            var obj_x0 = obj_x;
            var obj_y0 = obj_y;

//            print("OBJECT "+i+" -> "+obj_type+obj_size);

            if(select_object == i){
                ctx.strokeStyle = "#83B8F9";
                ctx.fillStyle = "#FFD9FF";
                ctx.lineWidth = 3;
            }else{
                if(obj_type.slice(0,5) === "Table"){
                    ctx.strokeStyle = "white";
                    ctx.fillStyle = "#56AA72";
                    ctx.lineWidth = 1;
                }else if(obj_type.slice(0,5) === "Chair"){
                    ctx.strokeStyle = "white";
                    ctx.fillStyle = "#727272";
                    ctx.lineWidth = 1;
                }else if(obj_type.slice(0,4) === "Wall"){
                    ctx.strokeStyle = "white";
                    ctx.fillStyle = "white";
                    ctx.lineWidth = 1;
                }else{
                    ctx.strokeStyle = "red";
                    ctx.fillStyle = "red";
                    ctx.lineWidth = 1;
                }

            }

            ctx.beginPath();
            ctx.moveTo(obj_x,obj_y);
            for(var j=1; j<obj_size; j++){
                var obj_x_new = supervisor.getObjectX(i,j)/grid_size + origin_x;
                var obj_y_new = supervisor.getObjectY(i,j)/grid_size + origin_y;
//                print(obj_x,obj_y,obj_x_new,obj_y_new);
                if(Math.abs(obj_x - obj_x_new) > 2 || Math.abs(obj_y - obj_y_new) > 2){
                    obj_x = obj_x_new;
                    obj_y = obj_y_new;
                    ctx.lineTo(obj_x,obj_y);
                }
            }
            ctx.lineTo(obj_x0,obj_y0);
            ctx.closePath();
            ctx.fill();
            ctx.stroke();

            if(state_annotation == "OBJECT"){
                ctx.lineWidth = 1;
                if(select_object == i){
                    ctx.strokeStyle = "#83B8F9";
                    ctx.fillStyle = "#83B8F9";
                }else{
                    ctx.strokeStyle = "white";
                    ctx.fillStyle = "white";
                }

                for(j=0; j<obj_size; j++){
                    ctx.beginPath();
                    obj_x = supervisor.getObjectX(i,j)/grid_size +origin_x;
                    obj_y = supervisor.getObjectY(i,j)/grid_size +origin_y;
                    ctx.moveTo(obj_x,obj_y);
                    if(select_object == i){
                        ctx.arc(obj_x,obj_y,4,0, Math.PI*2);
                    }else{
                        ctx.arc(obj_x,obj_y,2,0, Math.PI*2);
                    }

                    ctx.closePath();
                    ctx.fill();
                    ctx.stroke();
                }
            }

        }
    }


    function draw_canvas_cur_pose(){
        var ctx = canvas_map_cur.getContext('2d');
        robot_x = supervisor.getRobotx()/grid_size + origin_x;
        robot_y = supervisor.getRoboty()/grid_size + origin_y;
        robot_th = -supervisor.getRobotth()-Math.PI/2;

        ctx.strokeStyle = "white";
        ctx.lineWidth = 2;
        ctx.beginPath();
        ctx.arc(robot_x,robot_y,robot_radius/grid_size, robot_th, robot_th+2*Math.PI, true);
        ctx.fillStyle = "red";
        ctx.fill()
        ctx.stroke()


        var distance = (robot_radius/grid_size)*2.2;
        var distance2 = distance*0.7;
        var th_dist = Math.PI/6;
        var x = robot_x+distance*Math.cos(robot_th);
        var y = robot_y+distance*Math.sin(robot_th);
        var x1 = robot_x+distance2*Math.cos(robot_th-th_dist);
        var y1 = robot_y+distance2*Math.sin(robot_th-th_dist);
        var x2 = robot_x+distance2*Math.cos(robot_th+th_dist);
        var y2 = robot_y+distance2*Math.sin(robot_th+th_dist);

        ctx.beginPath();
        ctx.moveTo(x,y);
        ctx.lineTo(x1,y1);
        ctx.lineTo(x2,y2);
        ctx.closePath();

        ctx.fillStyle = "red";
        ctx.fill()
    }
    function draw_canvas_new_object(){
        var ctx = canvas_object.getContext('2d');
        if(tool == "ADD_OBJECT"){
            ctx.lineCap = "round";
            ctx.strokeStyle = "yellow";
            ctx.fillStyle = "steelblue";
            ctx.lineWidth = 3;


            ctx.beginPath();
            ctx.moveTo(new_obj_x1,new_obj_y1);
            ctx.rect(new_obj_x1,new_obj_y1, new_obj_x2-new_obj_x1, new_obj_y2 - new_obj_y1);
            ctx.closePath();
            ctx.stroke();
            ctx.fill();



            ctx.lineWidth = 1;
            ctx.strokeStyle = "blue";
            ctx.fillStyle = "blue";

            ctx.beginPath();
            ctx.moveTo(new_obj_x1,new_obj_y1);
            ctx.arc(new_obj_x1,new_obj_y1,2,0, Math.PI*2);
            ctx.closePath();
            ctx.fill();
            ctx.stroke();

            ctx.beginPath();
            ctx.moveTo(new_obj_x1,new_obj_y2);
            ctx.arc(new_obj_x1,new_obj_y2,2,0, Math.PI*2);
            ctx.closePath();
            ctx.fill();
            ctx.stroke();

            ctx.beginPath();
            ctx.moveTo(new_obj_x2,new_obj_y1);
            ctx.arc(new_obj_x2,new_obj_y1,2,0, Math.PI*2);
            ctx.closePath();
            ctx.fill();
            ctx.stroke();

            ctx.beginPath();
            ctx.moveTo(new_obj_x2,new_obj_y2);
            ctx.arc(new_obj_x2,new_obj_y2,2,0, Math.PI*2);
            ctx.closePath();
            ctx.fill();
            ctx.stroke();
        }else if(tool == "ADD_POINT"){
            var point_num = supervisor.getTempObjectSize();
            if(point_num > 0){
                ctx.lineCap = "round";
                ctx.strokeStyle = "yellow";
                ctx.fillStyle = "steelblue";
                ctx.lineWidth = 3;
                var point_x = supervisor.getTempObjectX(0)/grid_size + origin_x;
                var point_y = supervisor.getTempObjectY(0)/grid_size + origin_y;
                var point_x0 = point_x;
                var point_y0 = point_y;

                if(point_num > 2){
                    ctx.beginPath();
                    ctx.moveTo(point_x,point_y);
                    for(var i=1; i<point_num; i++){
                        point_x = supervisor.getTempObjectX(i)/grid_size + origin_x;
                        point_y = supervisor.getTempObjectY(i)/grid_size + origin_y;
                        ctx.lineTo(point_x,point_y);
                    }
                    if(point_num > 2){
                        ctx.lineTo(point_x0,point_y0);
                    }
                    ctx.fill();
                    ctx.stroke();
                }else if(point_num > 1){
                    ctx.beginPath()
                    ctx.moveTo(point_x,point_y)
                    point_x = supervisor.getTempObjectX(1)/grid_size + origin_x;
                    point_y = supervisor.getTempObjectY(1)/grid_size + origin_y;
                    ctx.lineTo(point_x,point_y)
                    ctx.stroke();
                }

                ctx.lineWidth = 1;
                ctx.strokeStyle = "blue";
                ctx.fillStyle = "blue";
                point_x = supervisor.getTempObjectX(0)/grid_size + origin_x;
                point_y = supervisor.getTempObjectY(0)/grid_size + origin_y;
                for(i=0; i<point_num; i++){
                    ctx.beginPath();
                    point_x = supervisor.getTempObjectX(i)/grid_size + origin_x;
                    point_y = supervisor.getTempObjectY(i)/grid_size + origin_y;
                    ctx.moveTo(point_x,point_y);
                    ctx.arc(point_x,point_y,2,0, Math.PI*2);
                    ctx.closePath();
                    ctx.fill();
                    ctx.stroke();
                }
            }
        }
    }
    function draw_canvas_margin(){
        var ctx1 = canvas_map.getContext('2d');
        var map_data = ctx1.getImageData(0,0,map_width, map_height);

        var ctx = canvas_map_margin.getContext('2d');
        var margin_obj = supervisor.getMarginObj();

        ctx.lineWidth = 0;
        ctx.lineCap = "round"
        ctx.strokeStyle = "#E7584D";
        ctx.fillStyle = "#E7584D";
        for(var i=0; i<margin_obj.length; i++){
            var point_x = (margin_obj[i])%map_width;
            var point_y = Math.floor((margin_obj[i])/map_width);
            ctx.beginPath();
            ctx.moveTo(point_x,point_y);
            ctx.arc(point_x,point_y,loader_menu.item.getslider()/grid_size,0,Math.PI*2);
            ctx.fill();
            ctx.stroke();
        }

        ctx.fillStyle = "#d0d0d0";
        ctx.strokeStyle = "#d0d0d0";
        for(var x=0; x< map_data.data.length; x=x+4){
            if(map_data.data[x] > 100){
                ctx.beginPath();
                ctx.moveTo((x/4)%map_width,Math.floor((x/4)/map_width));
                ctx.arc((x/4)%map_width,Math.floor((x/4)/map_width),0.5,0,Math.PI*2);
                ctx.fill();
                ctx.stroke();
            }
        }

        flag_margin = true;
    }
    function draw_canvas_init_pos(){
        if(new_slam_init){
            var ctx = canvas_map_cur.getContext('2d');
            ctx.strokeStyle = "white";
            ctx.lineWidth = 2;
            ctx.beginPath();
            ctx.arc(init_x,init_y,robot_radius/grid_size, -init_th-Math.PI/2, -init_th-Math.PI/2+2*Math.PI, true);
            ctx.fillStyle = "yellow";
            ctx.fill()
            ctx.stroke()
            var distance = (robot_radius/grid_size)*2.2;
            var distance2 = distance*0.7;
            var th_dist = Math.PI/6;
            var x = init_x+distance*Math.cos(-init_th-Math.PI/2);
            var y = init_y+distance*Math.sin(-init_th-Math.PI/2);
            var x1 = init_x+distance2*Math.cos(-init_th-Math.PI/2-th_dist);
            var y1 = init_y+distance2*Math.sin(-init_th-Math.PI/2-th_dist);
            var x2 = init_x+distance2*Math.cos(-init_th-Math.PI/2+th_dist);
            var y2 = init_y+distance2*Math.sin(-init_th-Math.PI/2+th_dist);

            ctx.beginPath();
            ctx.moveTo(x,y);
            ctx.lineTo(x1,y1);
            ctx.lineTo(x2,y2);
            ctx.closePath();

            ctx.fillStyle = "yellow";
            ctx.fill()
        }
    }

    function draw_canvas_travelline(){
        var ctx = canvas_travelline.getContext('2d');
        ctx.lineCap = "round";

        var tline_num = supervisor.getTlineSize();
        for(var i=0; i<tline_num; i++){

            var linenum = supervisor.getTlineSize(i);
            for(var j=0; j<linenum; j=j+2){

                if(select_travel_line === i){
                    if(select_line == j/2){
                        ctx.lineWidth = 5;
                        ctx.strokeStyle = "yellow";
                    }else{
                        ctx.lineWidth = 2;
                        ctx.strokeStyle = "#FFD9FF";
                    }

                    var len = 10;

                    var linex = supervisor.getTlineX(i,j)/grid_size + origin_x;
                    var liney = supervisor.getTlineY(i,j)/grid_size + origin_y;

                    ctx.setLineDash([2]);
                    ctx.beginPath();
                    ctx.moveTo(linex,liney);
                    linex = supervisor.getTlineX(i,j+1)/grid_size + origin_x;
                    liney = supervisor.getTlineY(i,j+1)/grid_size + origin_y;
                    ctx.lineTo(linex,liney);
                    ctx.stroke();
                }
            }
        }

        if(new_line_point1 && new_line_point2){
            ctx.strokeStyle = "red";
            ctx.beginPath();
            ctx.moveTo(new_line_x1,new_line_y1);
            ctx.lineTo(new_line_x2, new_line_y2);
            ctx.stroke();
        }

        if(new_line_point1){
            ctx.fillStyle = "yellow";
            ctx.strokeStyle = "yellow";
            ctx.beginPath();
            ctx.moveTo(new_line_x1,new_line_y1);
            ctx.arc(new_line_x1,new_line_y1,2,0,Math.PI*2);
            ctx.fill();
            ctx.stroke();
        }
        if(new_line_point2){
            ctx.fillStyle = "yellow";
            ctx.strokeStyle = "yellow";
            ctx.beginPath();
            ctx.moveTo(new_line_x2,new_line_y2);
            ctx.arc(new_line_x2,new_line_y2,2,0,Math.PI*2);
            ctx.fill();
            ctx.stroke();
        }


    }

    function draw_canvas_global_path(){
        var ctx = canvas_map_cur.getContext('2d');
        path_num = supervisor.getPathNum();
        path_x = robot_x;
        path_y = robot_y;
        path_th = robot_th;
        ctx.lineWidth = 2;
        for(var i=0; i<path_num; i++){
            var path_x_before = path_x;
            var path_y_before = path_y;
            var path_th_before = path_th;
            path_x = supervisor.getPathx(i)/grid_size+origin_x;
            path_y = supervisor.getPathy(i)/grid_size+origin_y;
            path_th = -supervisor.getPathth(i)-Math.PI/2;

//            ctx.strokeStyle = "#05C9FF";
//            ctx.fillStyle = "#FFD9FF";
            ctx.strokeStyle = "#FFD9FF";
            ctx.fillStyle = "#05C9FF";
            ctx.lineWidth = 2;
            ctx.beginPath();
            if(i>0){
                ctx.moveTo(path_x_before,path_y_before);
                ctx.lineTo(path_x,path_y);
                ctx.stroke()
            }
        }





        if(path_num > 0){
//            //target Pos
            ctx.beginPath();
            ctx.arc(path_x,path_y,robot_radius/grid_size, -path_th-Math.PI/2, -path_th-Math.PI/2+2*Math.PI, true);
            ctx.fill()
            ctx.stroke()

            var distance = (robot_radius/grid_size)*1.8;
            var distance2 = distance*0.8;
            var th_dist = Math.PI/8;
            var x = path_x+distance*Math.cos(-path_th-Math.PI/2);
            var y = path_y+distance*Math.sin(-path_th-Math.PI/2);
            var x1 = path_x+distance2*Math.cos(-path_th-Math.PI/2-th_dist);
            var y1 = path_y+distance2*Math.sin(-path_th-Math.PI/2-th_dist);
            var x2 = path_x+distance2*Math.cos(-path_th-Math.PI/2+th_dist);
            var y2 = path_y+distance2*Math.sin(-path_th-Math.PI/2+th_dist);

            ctx.beginPath();
            ctx.moveTo(x,y);
            ctx.lineTo(x1,y1);
            ctx.moveTo(x,y);
            ctx.lineTo(x2,y2);
            ctx.stroke()
        }
    }

    function draw_canvas_local_path(){
        var ctx = canvas_map_cur.getContext('2d');
        ctx.lineWidth = 1;
        ctx.strokeStyle = "#05C9FF";
        ctx.fillStyle = "#05C9FF";
        if(path_num != 0){
            var localpath_num = supervisor.getLocalPathNum();
            for(var i=0; i<localpath_num; i++){
                ctx.beginPath();
                var local_x = supervisor.getLocalPathx(i)/grid_size +origin_x;
                var local_y = supervisor.getLocalPathy(i)/grid_size +origin_y;
                ctx.moveTo(local_x,local_y);
                ctx.arc(local_x,local_y,2,0, Math.PI*2);
                ctx.closePath();
                ctx.fill();
                ctx.stroke();
            }
        }

    }
    function draw_canvas_lidar(){
        var ctx = canvas_map_cur.getContext('2d');
        ctx.lineWidth = 1;
        ctx.strokeStyle = "red";
        ctx.fillStyle = "red";
        for(var i=0; i<360; i++){
            var data = supervisor.getLidar(i)/grid_size;
            if(data > 0.01){
                ctx.beginPath();
                var lidar_x = robot_x + data*Math.cos((-Math.PI*i)/180 + robot_th);
                var lidar_y = robot_y  + data*Math.sin((-Math.PI*i)/180 + robot_th);
                ctx.moveTo(lidar_x, lidar_y);
                ctx.arc(lidar_x,lidar_y,1,0,Math.PI*2);
                ctx.closePath();
                ctx.fill();
                ctx.stroke();
            }
        }
    }

    function nn(){
        var newx = -robot_x;
        if(newx  > canvas_map.width*(canvas_map.scale - 1)/2){
            canvas_map.x = canvas_map.width*(canvas_map.scale - 1)/2
        }else if(newx < -(canvas_map.width*(canvas_map.scale - 1)/2 + canvas_map.width - rect_map.width)){
            canvas_map.x = -(canvas_map.width*(canvas_map.scale - 1)/2 + canvas_map.width - rect_map.width)
        }else{
            canvas_map.x = newx;
        }
        var newy = -robot_y;
        if(newy  > canvas_map.height*(canvas_map.scale - 1)/2){
            canvas_map.y = canvas_map.height*(canvas_map.scale - 1)/2
        }else if(newy < -(canvas_map.height*(canvas_map.scale - 1)/2 + canvas_map.height - rect_map.height)){
            canvas_map.y = -(canvas_map.height*(canvas_map.scale - 1)/2 + canvas_map.height - rect_map.height)
        }else{
            canvas_map.y = newy;
        }
    }

}

