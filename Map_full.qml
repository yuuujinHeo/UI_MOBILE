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
    //mode : 0(mapview) 1:(slam) 2:(annotation) 3:(patrol)
    property string mode_mapview: "VIEWER"

    property bool show_object: false
    property bool show_location: false
    property bool show_patrol: false
    property bool show_travelline: false
    property bool show_path: false
    property bool show_robot: false
    property bool show_margin: false
    property bool show_lidar: false

    //0(location patrol) 1:(path patrol)
    property int patrol_mode: 0

    //Annotation State (None, Drawing, Object, Location, Travelline)
    property string state_annotation: "NONE"
    //Annotation State (0: state, 1: load/edit, 2: object, 3: location, 4: travel line)



    //////========================================================================================Annotation Tool
    //Tool Num (MOVE, BRUSH, ADD_POINT, EDIT_POINT, 4: ADD_LOCATION, 5: EDIT_LOCATION, 6: ADD_LINE)
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
    property var robot_x: supervisor.getRobotx()/grid_size;
    property var robot_y: supervisor.getRoboty()/grid_size;
    property var robot_th:-supervisor.getRobotth()-Math.PI/2;

    property int select_object: -1
    property int select_object_point: -1
    property int select_location: -1
    property int select_patrol: -1
    property int select_line: -1
    property int select_travel_line: -1

    property bool new_location: false
    property bool new_loc_available: false
    property var new_loc_x;
    property var new_loc_y;
    property var new_loc_th;

    //////========================================================================================Canvas Tool
    property bool refreshMap: false




    //////========================================================================================Map Image Variable
    property var grid_size: 0.02
    property int origin_x: 500
    property int origin_y: 500
    property var robot_radius: supervisor.getRobotRadius()
    Image{
        id: image_map
        property bool isload: false
        visible: false
        cache: false
    }

    //////========================================================================================Main Canvas
    Rectangle{
        id: rect_map
        anchors.fill: parent
        clip: true
        Canvas{
            id: canvas_map
            width: image_map.width
            height: image_map.height
            antialiasing: true
            property var lineWidth: brush_size

            property real lastX
            property real lastY
            property var lineX
            property var lineY

            Behavior on scale{
                NumberAnimation{
                    duration: 300
                }
            }
            Behavior on x{
                NumberAnimation{
                    duration: 100
                }
            }
            Behavior on y{
                NumberAnimation{
                    duration: 100
                }
            }

            onXChanged: {
                if(canvas_map.x  > canvas_map.width*(canvas_map.scale - 1)/2){
                    canvas_map.x = canvas_map.width*(canvas_map.scale - 1)/2
                }else if(canvas_map.x < -(canvas_map.width*(canvas_map.scale - 1)/2 + canvas_map.width - rect_map.width)){
                    canvas_map.x = -(canvas_map.width*(canvas_map.scale - 1)/2 + canvas_map.width - rect_map.width)
                }
                requestPaint();
            }
            onYChanged: {
                if(canvas_map.y  > canvas_map.height*(canvas_map.scale - 1)/2){
                    canvas_map.y = canvas_map.height*(canvas_map.scale - 1)/2
                }else if(canvas_map.y < -(canvas_map.height*(canvas_map.scale - 1)/2 + canvas_map.height - rect_map.height)){
                    canvas_map.y = -(canvas_map.height*(canvas_map.scale - 1)/2 + canvas_map.height - rect_map.height)
                }
                requestPaint();
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
                if(image_map.isload){
                    var ctx = canvas_map.getContext('2d');
                    if(refreshMap){
                        refreshMap = false;
                        ctx.clearRect(0,0,canvas_map.width, canvas_map.height);
                        draw_canvas_map();
                        if(state_annotation == "DRAWING"){
                            draw_canvas_lines();
                        }
                    }

                    // Draw new object
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
                }
            }
        }

        Canvas{
            id: canvas_map_margin
            width: image_map.width
            height: image_map.height
            antialiasing: true
            x: canvas_map.x
            y: canvas_map.y
            scale: canvas_map.scale
            onPaint: {
                if(image_map.isload && show_margin){
                    var ctx = canvas_map_margin.getContext('2d');
                    ctx.clearRect(0,0,canvas_map_margin.width,canvas_map_margin.height);
                    flag_margin = false;
                    draw_canvas_margin();
                }
            }
        }

        Canvas{
            id: canvas_object
            width: canvas_map.width
            height: canvas_map.height
            x: canvas_map.x
            y: canvas_map.y
            scale: canvas_map.scale
            antialiasing: true
            onPaint:{
                if(image_map.isload && show_object){
                    var ctx = getContext("2d");
                    ctx.clearRect(0,0,canvas_object.width,canvas_object.height);
                    draw_canvas_new_object();
                    draw_canvas_object();
                }
            }
        }

        Canvas{
            id: canvas_location
            width: canvas_map.width
            height: canvas_map.height
            x: canvas_map.x
            y: canvas_map.y
            scale: canvas_map.scale
            antialiasing: true

            onPaint:{
                if(image_map.isload && show_location){
                    var ctx = getContext("2d");
                    ctx.clearRect(0,0,canvas_location.width,canvas_location.height);

                    if(mode_mapview == "ANNOTATION"){
                        draw_canvas_location();
                    }else if(mode_mapview == "PATROL"){
                        draw_canvas_patrol_location();
                    }
                    draw_canvas_location_temp();

                }
            }
        }

        Canvas{
            id: canvas_travelline
            width: canvas_map.width
            height: canvas_map.height
            x: canvas_map.x
            y: canvas_map.y
            scale: canvas_map.scale
            antialiasing: true

            property bool ispoint1: false
            property bool ispoint2: false
            property int x1
            property int y1
            property int x2
            property int y2
            onPaint:{
                if(image_map.isload && show_travelline){
                    var ctx = getContext('2d');
                    ctx.clearRect(0,0,canvas_travelline.width, canvas_travelline.height);
                    draw_canvas_travelline();
                }
            }

        }

        Canvas{
            id: canvas_map_cur
            width: canvas_map.width
            height: canvas_map.height
            x: canvas_map.x
            y: canvas_map.y
            scale: canvas_map.scale
            antialiasing: true
            onPaint:{
                if(image_map.isload && show_robot){
                    var ctx = getContext("2d");
                    ctx.clearRect(0,0,canvas_map_cur.width,canvas_map_cur.height);
                    draw_canvas_cur_pose();
                }
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
                            if(new_scale < 1){
                                canvas_map.scale = 1;
                            }else{
                                canvas_map.scale = new_scale;
                            }
                        }
                        print("wheeled");
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

                    }else if(tool == "ADD_LOCATION"){
                        canvas_location.new_location = true;
                        canvas_location.new_loc_available = false;
                        canvas_location.new_loc_x = point1.x;
                        canvas_location.new_loc_y = point1.y;
                        canvas_location.new_loc_th = 0;
                    }else if(tool == "EDIT_LOCATION"){
                        supervisor.moveLocationPoint(select_location, point1.x, point1.y, 0);
                    }
                }

                onReleased: {
                    if(!point1.pressed&&!point2.pressed){
                        if(tool == "BRUSH"){
                            supervisor.stopLine();
                        }else if(tool == "ADD_POINT"){//add point
                            print(point1.x, point1.y);
                            supervisor.addObjectPoint(point1.x, point1.y);
                        }else if(tool == "EDIT_POINT"){
                            select_object_point = -1;
                            supervisor.setObjPose();
                        }else if(tool == "ADD_LOCATION"){
                            if(canvas_location.new_location)
                                popup_add_patrol_1.open();
                        }else if(tool == "EDIT_LOCATION"){
                            updatelocationcollision();
                            tool = "NONE";
                        }else if(tool == "ADD_LINE"){
                            if(state_annotation == "TRAVELLINE"){
                                if(canvas_travelline.ispoint1){
                                    canvas_travelline.x2 = point1.x;
                                    canvas_travelline.y2 = point1.y;
                                    canvas_travelline.ispoint2 = true;
                                }else{
                                    canvas_travelline.ispoint1 = true;
                                    canvas_travelline.x1 = point1.x;
                                    canvas_travelline.y1 = point1.y;
                                }
                                canvas_travelline.requestPaint();
                            }else{
                                tool = "NONE";
                            }
                        }else{
                            if(state_annotation == "OBJECT"){
                                select_object = supervisor.getObjNum(point1.x,point1.y);
                                list_object.currentIndex = select_object;
                                canvas_object.requestPaint();
                            }else if(state_annotation == "LOCATION"){
                                select_location = supervisor.getLocNum(point1.x,point1.y);
                                list_location.currentIndex = select_location;
                                canvas_location.requestPaint();
                            }else if(state_annotation == "TRAVELLINE"){
                                select_line = supervisor.getTlineNum(point1.x, point1.y)/2;
                                list_line.currentIndex = select_line;
                                canvas_travelline.requestPaint();
                            }
                        }
                    }
                }
                onTouchUpdated:{
                    if(tool == "MOVE"){
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
                            supervisor.moveObjectPoint(select_object,select_object_point,point1.x, point1.y);
                        }
                    }else if(tool == "ADD_LOCATION"){
                        if(point1.y-canvas_location.new_loc_y == 0){
                            canvas_location.new_loc_th = 0;
                        }else{
                            canvas_location.new_loc_th = Math.atan2(-(point1.x-canvas_location.new_loc_x),-(point1.y-canvas_location.new_loc_y));
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

    //////========================================================================================Timer
    Timer{
        id: update_checker
        interval: 1000
        running: flag_margin
        repeat: false
        onTriggered: {
            updatelocationcollision();
            flag_margin = false;
        }
    }


    //////========================================================================================Variable update function
    function init(){
        mode_mapview = "VIEWER";
        state_annotation = "NONE";
        tool = "MOVE";
        refreshMap = true;
        update_canvas_all();
    }
    function loadmap(path){
        image_map.source = path;
        image_map.isload = true;
        refreshMap = true;
        update_map_variable();
        update_canvas_all();
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
        canvas_map.requestPaint();
        canvas_object.requestPaint();
        canvas_location.requestPaint();
        canvas_map_margin.requestPaint();
        canvas_map_cur.requestPaint();
        canvas_travelline.requestPaint();
    }

    //////========================================================================================Annotation function
    function find_map_walls(){
        print("find map walls");
        supervisor.clearMarginObj();

        var ctx = canvas_map.getContext('2d');
        var map_data = ctx.getImageData(0,0,image_map.width, image_map.height);

        for(var x=0; x< map_data.data.length; x=x+4){
            if(map_data.data[x] > 100){
                supervisor.setMarginPoint(Math.abs(x/4));
            }
        }


        var ctx1 = canvas_object.getContext('2d');
        var map_data1 = ctx1.getImageData(0,0,image_map.width, image_map.height);

        for(x=0; x< map_data1.data.length; x=x+4){
            if(map_data1.data[x+3] > 0){
                supervisor.setMarginPoint(Math.abs(x/4));
            }
        }

//        supervisor.setMarginObj();
    }
    function is_Col_loc(x,y){
        if(image_map.isload){

            var ctx = canvas_map.getContext('2d');
            var ctx1 = canvas_map_margin.getContext('2d');
            var ctx_robot = canvas_robot.getContext('2d');
            var map_data = ctx.getImageData(0,0,image_map.width, image_map.height)
            var map_data1 = ctx1.getImageData(0,0,image_map.width,image_map.height);
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
    function draw_canvas_map(){
        var ctx = canvas_map.getContext('2d');
        ctx.drawImage(image_map,0,0,image_map.width,image_map.height);
    }
    function draw_canvas_location(){
        var ctx = canvas_location.getContext('2d');
        location_num = supervisor.getLocationNum();
        for(var i=0; i<location_num; i++){
            var loc_type = supervisor.getLocationTypes(i);
            var loc_x = supervisor.getLocationx(i)/grid_size;
            var loc_y = supervisor.getLocationy(i)/grid_size;
            var loc_th = -supervisor.getLocationth(i)-Math.PI/2;

//                        console.log(loc_type,loc_x,loc_y,loc_th);

            if(select_location == i){
                ctx.lineWidth = 3;
                ctx.strokeStyle = "yellow";
            }else{
                ctx.lineWidth = 1;
                if(loc_type.slice(0,4) == "Char"){
                    ctx.strokeStyle = "green";
                }else if(loc_type.slice(0,4) == "Rest"){
                    ctx.strokeStyle = "white";
                }else if(loc_type.slice(0,4) == "Patr"){
                    ctx.strokeStyle = "blue";
                }else if(loc_type.slice(0,4) == "Tabl"){
                    ctx.strokeStyle = "gray";
                }
            }

            ctx.beginPath();
            ctx.moveTo(loc_x+origin_x,loc_y+origin_y);
            ctx.arc(loc_x+origin_x,loc_y+origin_y,robot_radius/grid_size, loc_th, loc_th+2*Math.PI, true);
            ctx.moveTo(loc_x+origin_x,loc_y+origin_y);
            ctx.stroke()
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

//            console.log(loc_type,loc_name,loc_x,loc_y,loc_th);

            if(select_patrol == i){
                ctx.lineWidth = 3;
                ctx.strokeStyle = "yellow";
            }else{
                ctx.lineWidth = 1;
                if(loc_type == "START"){
                    ctx.strokeStyle = "green";
                }else if(loc_type == "END"){
                    ctx.strokeStyle = "red";
                }else{
                    ctx.strokeStyle = "white";
                }
            }
            ctx.beginPath();
            ctx.moveTo(loc_x,loc_y);
            ctx.arc(loc_x,loc_y,robot_radius/grid_size, loc_th, loc_th+2*Math.PI, true);
            ctx.moveTo(loc_x,loc_y);
            ctx.fillStyle="red"
            ctx.font="bold 20px sans-serif";
            if(i==0){
                ctx.fillText("START",loc_x+10,loc_y+5);
            }else{
                ctx.fillText(Number(i),loc_x+10,loc_y+5);
            }

            ctx.stroke()
        }
    }
    function draw_canvas_location_temp(){
        if(canvas_location.new_location){
            var ctx = canvas_location.getContext('2d');
            ctx.lineWidth = 3;
            if(is_Col_loc(canvas_location.new_loc_x,canvas_location.new_loc_y)){
                ctx.strokeStyle = "red";
                canvas_location.new_loc_available = false;
            }else{
                ctx.strokeStyle = "yellow";
                canvas_location.new_loc_available = true;
            }
            ctx.beginPath();
            ctx.moveTo(canvas_location.new_loc_x,canvas_location.new_loc_y);
            ctx.arc(canvas_location.new_loc_x,canvas_location.new_loc_y,robot_radius/grid_size, -canvas_location.new_loc_th-Math.PI/2, -canvas_location.new_loc_th-Math.PI/2+2*Math.PI, true);
            ctx.moveTo(canvas_location.new_loc_x,canvas_location.new_loc_y);
            ctx.stroke()
        }
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

            if(select_object == i){
                ctx.strokeStyle = "yellow";
                ctx.fillStyle = "steelblue";
                ctx.lineWidth = 3;
            }else{
                ctx.strokeStyle = "blue";
                ctx.fillStyle = "steelblue";
                ctx.lineWidth = 1;
            }

            ctx.beginPath();
            ctx.moveTo(obj_x,obj_y);
            for(var j=1; j<obj_size; j++){
                obj_x = supervisor.getObjectX(i,j)/grid_size + origin_x;
                obj_y = supervisor.getObjectY(i,j)/grid_size + origin_y;
                ctx.lineTo(obj_x,obj_y);
            }
            ctx.lineTo(obj_x0,obj_y0);
            ctx.closePath();
            ctx.fill();
            ctx.stroke();

            ctx.lineWidth = 1;
            ctx.strokeStyle = "red";
            ctx.fillStyle = "red";
            for(j=0; j<obj_size; j++){
                ctx.beginPath();
                obj_x = supervisor.getObjectX(i,j)/grid_size +origin_x;
                obj_y = supervisor.getObjectY(i,j)/grid_size +origin_y;
                ctx.moveTo(obj_x,obj_y);
                ctx.arc(obj_x,obj_y,2,0, Math.PI*2);
                ctx.closePath();
                ctx.fill();
                ctx.stroke();
            }
        }
    }
    function draw_canvas_cur_pose(){
        var ctx = canvas_map_cur.getContext('2d');
        robot_x = supervisor.getRobotx()/grid_size;
        robot_y = supervisor.getRoboty()/grid_size;
        robot_th = -supervisor.getRobotth()-Math.PI/2;
//                    print(robot_x,robot_y,robot_th);
        ctx.strokeStyle = "cyan";
        ctx.beginPath();
        ctx.moveTo(robot_x+origin_x,robot_y+origin_y);
        ctx.arc(robot_x+origin_x,robot_y+origin_y,robot_radius/grid_size, robot_th, robot_th+2*Math.PI, true);
        ctx.stroke()
        ctx.fillStyle = "black";
        ctx.fill()
        ctx.moveTo(robot_x+origin_x,robot_y+origin_y);
        ctx.lineTo(robot_x+origin_x,robot_y+origin_y)
        ctx.stroke()
    }
    function draw_canvas_new_object(){
        var ctx = canvas_object.getContext('2d');
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
            ctx.strokeStyle = "red";
            ctx.fillStyle = "red";
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
    function draw_canvas_margin(){
        var ctx1 = canvas_map.getContext('2d');
        var map_data = ctx1.getImageData(0,0,image_map.width, image_map.height);

        var ctx = canvas_map_margin.getContext('2d');
        var margin_obj = supervisor.getMarginObj();

        ctx.lineWidth = 0;
        ctx.lineCap = "round"
        ctx.strokeStyle = "cyan";
        ctx.fillStyle = "cyan";
        for(var i=0; i<margin_obj.length; i++){
            var point_x = (margin_obj[i])%image_map.width;
            var point_y = Math.floor((margin_obj[i])/image_map.width);
            ctx.beginPath();
            ctx.moveTo(point_x,point_y);
            ctx.arc(point_x,point_y,slider_margin.value/grid_size,0,Math.PI*2);
            ctx.fill();
            ctx.stroke();
        }

        ctx.fillStyle = "red";
        ctx.strokeStyle = "red";
        for(var x=0; x< map_data.data.length; x=x+4){
            if(map_data.data[x] > 100){
                ctx.beginPath();
                ctx.moveTo((x/4)%image_map.width,Math.floor((x/4)/image_map.width));
                ctx.arc((x/4)%image_map.width,Math.floor((x/4)/image_map.width),0.5,0,Math.PI*2);
                ctx.fill();
                ctx.stroke();
            }
        }

        flag_margin = true;
    }
    function draw_canvas_travelline(){
        var ctx = canvas_travelline.getContext('2d');

        ctx.lineCap = "round";

        var tline_num = supervisor.getTlineSize();
        print(tline_num);
        for(var i=0; i<tline_num; i++){
            var linenum = supervisor.getTlineSize(i);
            for(var j=0; j<linenum; j=j+2){

                if(select_travel_line == i && select_line == j/2){
                    ctx.lineWidth = 5;
                    ctx.strokeStyle = "yellow";
                }else{
                    ctx.lineWidth = 3;
                    ctx.strokeStyle = "red";
                }

                var linex = supervisor.getTlineX(i,j)/grid_size + origin_x;
                var liney = supervisor.getTlineY(i,j)/grid_size + origin_y;
                ctx.beginPath();
                ctx.moveTo(linex,liney);
                print(linex,liney);
                linex = supervisor.getTlineX(i,j+1)/grid_size + origin_x;
                liney = supervisor.getTlineY(i,j+1)/grid_size + origin_y;
                ctx.lineTo(linex,liney);
                print(linex,liney);
                ctx.stroke();
            }
        }

        if(canvas_travelline.ispoint1 && canvas_travelline.ispoint2){
            ctx.strokeStyle = "red";
            ctx.beginPath();
            ctx.moveTo(canvas_travelline.x1,canvas_travelline.y1);
            ctx.lineTo(canvas_travelline.x2, canvas_travelline.y2);
            ctx.stroke();
        }

        if(canvas_travelline.ispoint1){
            ctx.fillStyle = "yellow";
            ctx.strokeStyle = "yellow";
            ctx.beginPath();
            ctx.moveTo(canvas_travelline.x1,canvas_travelline.y1);
            ctx.arc(canvas_travelline.x1,canvas_travelline.y1,2,0,Math.PI*2);
            ctx.fill();
            ctx.stroke();
        }
        if(canvas_travelline.ispoint2){
            ctx.fillStyle = "yellow";
            ctx.strokeStyle = "yellow";
            ctx.beginPath();
            ctx.moveTo(canvas_travelline.x2,canvas_travelline.y2);
            ctx.arc(canvas_travelline.x2,canvas_travelline.y2,2,0,Math.PI*2);
            ctx.fill();
            ctx.stroke();
        }


    }

}

