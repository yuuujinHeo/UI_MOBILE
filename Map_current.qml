import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0
import "."
import io.qt.Supervisor 1.0

Item {
    id: current_map
    objectName: "current_map"

    property int _width: 600
    property int _height: 600

    width: _width
    height: _height

    property bool flag_map: supervisor.getMapState()
    property bool flag_map_load: false
    property int image_width: 1000
    property int image_height: 1000
    property int origin_x: 500
    property int origin_y: 500
    property var map_data

    property var robot_radius: 0.25
    property var grid_size: 0.02

    property int location_num: supervisor.getLocationNum();
    property int path_num: supervisor.getPathNum();

    property var location_types
    property var location_x
    property var location_y
    property var location_th

    property var path_x
    property var path_y
    property var path_th

    property var robot_x: supervisor.getRobotx()/grid_size;
    property var robot_y: supervisor.getRoboty()/grid_size;
    property var robot_th:-supervisor.getRobotth()-Math.PI/2;

    onLocation_numChanged: {
        canvas_cur_map.requestPaint();
    }
    onRobot_xChanged: {
        canvas_cur_map.requestPaint();
    }
    onRobot_yChanged: {
        canvas_cur_map.requestPaint();
    }
    onRobot_thChanged: {
        canvas_cur_map.requestPaint();
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

    Timer{
        id: update_map
        running: true
        repeat: true
        interval: 100
        onTriggered: {
            robot_x = supervisor.getRobotx()/grid_size;
            robot_y = supervisor.getRoboty()/grid_size;
            robot_th = -supervisor.getRobotth()-Math.PI/2;
            path_num = supervisor.getPathNum();
        }
    }

    Timer{
        id: timer_loadmap
        repeat: true
        interval: 1000
        running: true
        onTriggered: {
            flag_map = true;//supervisor.getMapState();
            if(flag_map){
                print("map downloading..");
//                map_data = supervisor.getImageData();
//                print(map_data);
                location_num = supervisor.getLocationNum();
                origin_x = supervisor.getOrigin()[0];
                origin_y = supervisor.getOrigin()[1];
                grid_size = supervisor.getGridWidth();
                timer_loadmap.stop();
            }

        }
    }

//    Rectangle{
//        width: 100
//        height: 100
//        x: 700
//        y: 400
//        color: "gray"
//        MouseArea{
//            anchors.fill: parent
//            onClicked: {
//                stackview.pop();
//            }
//        }
//    }

    Image{
        id: map_image
        visible: false
        source: "file://" + applicationDirPath + "/image/map_downloaded.png"
    }

    Rectangle{
        id: rect_cur_map
        width: parent.width
        height: parent.height
        clip: true
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right;

        border.width: 3
        border.color:"black"
        color: "black"

        Canvas{
            id: canvas_cur_map
            x: - origin_x + rect_cur_map.width/2;
            y: - origin_y + rect_cur_map.height/2;
            width: image_width
            height: image_height
            antialiasing: true
            property var loc_type
            property var loc_x
            property var loc_y
            property var loc_th
            property var grid_width


            onPaint:{
                var ctx = getContext("2d");
//                ctx.clearRect(0,0,canvas_cur_map.width,canvas_cur_map.height);

                //Map Load
                if(flag_map){
                    ctx.drawImage(map_image, 0,0,image_width,image_height);
                    ctx.lineWidth = 1;
                    ctx.lineCap = "round"
                    //Location Load

                    for(var i=0; i<location_num; i++){
                        loc_type = supervisor.getLocationTypes(i);
                        loc_x = supervisor.getLocationx(i)/grid_size;
                        loc_y = supervisor.getLocationy(i)/grid_size;
                        loc_th = -supervisor.getLocationth(i)-Math.PI/2;

//                        console.log(loc_type,loc_x,loc_y,loc_th);

                        if(loc_type == "charge"){
                            ctx.strokeStyle = "green";
                        }else if(loc_type == "wait"){
                            ctx.strokeStyle = "white";
                        }else{
                            ctx.strokeStyle = "gray";
                        }
                        ctx.beginPath();
                        ctx.moveTo(loc_x+origin_x,loc_y+origin_y);
                        ctx.arc(loc_x+origin_x,loc_y+origin_y,robot_radius/grid_size, loc_th, loc_th+2*Math.PI, true);
                        ctx.moveTo(loc_x+origin_x,loc_y+origin_y);
                        ctx.stroke()
                    }

                    //Path Load
                    path_num = supervisor.getPathNum();
                    path_x = robot_x;
                    path_y = robot_y;
                    path_th = robot_th;
                    for(i=0; i<path_num; i++){
                        var path_x_before = path_x;
                        var path_y_before = path_y;
                        var path_th_before = path_th;
                        path_x = supervisor.getPathx(i)/grid_size;
                        path_y = supervisor.getPathy(i)/grid_size;
                        path_th = -supervisor.getPathth(i)-Math.PI/2;//supervisor.getLocationth(i);

//                        console.log(path_x,path_y,path_th);
                        ctx.strokeStyle = "yellow";

                        ctx.beginPath();
                        if(i>0){
                            ctx.moveTo(path_x_before+origin_x,path_y_before+origin_y);
                            ctx.lineTo(path_x+origin_x,path_y+origin_y);
                            ctx.stroke()
                        }

                    }

                    if(path_num > 0){
                        //target Pos
                        ctx.strokeStyle = "yellow";
                        ctx.beginPath();
                        ctx.moveTo(path_x+origin_x,path_y+origin_y);
                        ctx.arc(path_x+origin_x,path_y+origin_y,robot_radius/grid_size, path_th, path_th+2*Math.PI, true);
                        ctx.stroke()
                        ctx.fill("black")
                        ctx.moveTo(path_x+origin_x,path_y+origin_y);
                        ctx.lineTo(path_x+origin_x,path_y+origin_y)
                        ctx.stroke()
                    }
                    //Robot Cur Pos
                    robot_x = supervisor.getRobotx()/grid_size;
                    robot_y = supervisor.getRoboty()/grid_size;
                    robot_th = -supervisor.getRobotth()-Math.PI/2;
//                    print(robot_x,robot_y,robot_th);
                    ctx.strokeStyle = "cyan";
                    ctx.beginPath();
                    ctx.moveTo(robot_x+origin_x,robot_y+origin_y);
                    ctx.arc(robot_x+origin_x,robot_y+origin_y,robot_radius/grid_size, robot_th, robot_th+2*Math.PI, true);
                    ctx.stroke()
                    ctx.fill("black")
                    ctx.moveTo(robot_x+origin_x,robot_y+origin_y);
                    ctx.lineTo(robot_x+origin_x,robot_y+origin_y)
                    ctx.stroke()

                }
            }
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
                if(canvas_cur_map.x  > canvas_cur_map.width*(canvas_cur_map.scale - 1)/2){
                    canvas_cur_map.x = canvas_cur_map.width*(canvas_cur_map.scale - 1)/2
                }else if(canvas_cur_map.x < -(canvas_cur_map.width*(canvas_cur_map.scale - 1)/2 + canvas_cur_map.width - rect_cur_map.width)){
                    canvas_cur_map.x = -(canvas_cur_map.width*(canvas_cur_map.scale - 1)/2 + canvas_cur_map.width - rect_cur_map.width)
                }
                requestPaint();
            }
            onYChanged: {
                if(canvas_cur_map.y  > canvas_cur_map.height*(canvas_cur_map.scale - 1)/2){
                    canvas_cur_map.y = canvas_cur_map.height*(canvas_cur_map.scale - 1)/2
                }else if(canvas_cur_map.y < -(canvas_cur_map.height*(canvas_cur_map.scale - 1)/2 + canvas_cur_map.height - rect_cur_map.height)){
                    canvas_cur_map.y = -(canvas_cur_map.height*(canvas_cur_map.scale - 1)/2 + canvas_cur_map.height - rect_cur_map.height)
                }
                requestPaint();
            }
            onScaleChanged: {
                if(canvas_cur_map.x  > canvas_cur_map.width*(canvas_cur_map.scale - 1)/2){
                    canvas_cur_map.x = canvas_cur_map.width*(canvas_cur_map.scale - 1)/2
                }else if(canvas_cur_map.x < -(canvas_cur_map.width*(canvas_cur_map.scale - 1)/2 + canvas_cur_map.width - rect_cur_map.width)){
                    canvas_cur_map.x = -(canvas_cur_map.width*(canvas_cur_map.scale - 1)/2 + canvas_cur_map.width - rect_cur_map.width)
                }

                if(canvas_cur_map.y  > canvas_cur_map.height*(canvas_cur_map.scale - 1)/2){
                    canvas_cur_map.y = canvas_cur_map.height*(canvas_cur_map.scale - 1)/2
                }else if(canvas_cur_map.y < -(canvas_cur_map.height*(canvas_cur_map.scale - 1)/2 + canvas_cur_map.height - rect_cur_map.height)){
                    canvas_cur_map.y = -(canvas_cur_map.height*(canvas_cur_map.scale - 1)/2 + canvas_cur_map.height - rect_cur_map.height)
                }
                requestPaint();
            }


            MultiPointTouchArea{
                id: area_map_touch
                anchors.fill: parent
                minimumTouchPoints: 1
                maximumTouchPoints: 2
//                mouseEnabled: false
                property var gesture: "none"
                property var dmoveX : 0;
                property var dmoveY : 0;
                property var startX : 0;
                property var startY : 0;
                property var startDist : 0;
                touchPoints: [TouchPoint{id:point1},TouchPoint{id:point2}]
                onPressed: {
//                    print("pressed ",point1.pressed,point2.pressed)
                    gesture = "drag";
                    if(point1.pressed && point2.pressed){
                        var dx = Math.abs(point1.x-point2.x);
                        var dy = Math.abs(point1.y-point2.y);
                        var dist = Math.sqrt(dx*dx + dy*dy);
                        area_map_touch.startX = (point1.x+point2.x)/2;
                        area_map_touch.startY = (point1.y+point2.y)/2;
                        area_map_touch.startDist = dist;
                    }else if(point1.pressed){
                        area_map_touch.startX = point1.x;
                        area_map_touch.startY = point1.y;
                    }

                }
                onReleased: {
                    if(!point1.pressed&&!point2.pressed){
                        gesture = "none"
                    }
                }
                onTouchUpdated:{
                    var ctx = canvas_cur_map.getContext('2d');
                    var dx = Math.abs(point1.x-point2.x);
                    var dy = Math.abs(point1.y-point2.y);
                    var mx = (point1.x+point2.x)/2;
                    var my = (point1.y+point2.y)/2;
                    var dist = Math.sqrt(dx*dx + dy*dy);
                    var dscale = (dist)/startDist;
                    var new_scale = canvas_cur_map.scale*dscale;
                    if(point1.pressed&&point2.pressed){

                        if(new_scale > 5)   new_scale = 5;

                        if(canvas_cur_map.width*new_scale < rect_cur_map.width){
                            new_scale = rect_cur_map.width/canvas_cur_map.width;
                        }

//                        else if(canvas_cur_map.width new_scale < 1){

//                            new_scale = 1;

//                        }
                        canvas_cur_map.scale = new_scale;

//                        print("drag",mx,my,dist,new_scale,canvas_cur_map.scale);

                        dmoveX = (mx - startX);
                        dmoveY = (my - startY);
                        canvas_cur_map.x += dmoveX;
                        canvas_cur_map.y += dmoveY;

                        canvas_cur_map.requestPaint()
                    }else{
                        dmoveX = (point1.x - startX);
                        dmoveY = (point1.y - startY);
                        canvas_cur_map.x += dmoveX;
                        canvas_cur_map.y += dmoveY;

                        canvas_cur_map.requestPaint()
                    }
                }
            }

        }
    }





}
