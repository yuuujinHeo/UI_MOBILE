import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.12
//import QtQuick.Shapes 1.
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0
//import QtQuick.Templates 2.5
import "."
import io.qt.Supervisor 1.0

Item {
    id: page_annotation
    objectName: "page_annotation"
    width: 1280
    height: 800

    //Tool Num (0: move, 1: drawing, 2: addPoint, 3: editPoint, 4: )
    property int tool_num: 0
    //Annotation State (0: state, 1: load/edit, 2: object, 3: location, 4: travel line)
    property int anot_state: 0
    property string image_name: "map_rotated"
    property string image_source: "file://" + applicationDirPath + "/image/" + image_name + ".png"
    property bool loadImage: false
    property bool refreshCanvas: false
    property var brush_size: 10

    property var grid_size: 0.02
    property int origin_x: 500
    property int origin_y: 500
    property var robot_radius: 0.25

    property int select_object: -1
    property int select_object_point: -1
    property string select_object_str: ""

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

    Component.onCompleted: {
        var ob_num = supervisor.getObjectNum();
        list_object.model.clear();
        for(var i=0; i<ob_num; i++){
            list_object.model.append({"name":supervisor.getObjectName(i)});
        }
    }

    function updateCanvas(){
        refreshCanvas = true;
        canvas_map.requestPaint();
    }

    function updateobject(){
        var ob_num = supervisor.getObjectNum();
        list_object.model.clear();
        for(var i=0; i<ob_num; i++){
            list_object.model.append({"name":supervisor.getObjectName(i)});
        }
        list_object.currentIndex = ob_num-1;
    }

    //Menu===================================================================
    Rectangle{
        id: rect_menus
        width: parent.width - rect_map.width
        height: 100
        color: "gray"

        Row{
            spacing: 25
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            Repeater{
                model: ["edit","back"]
                Rectangle{
                    width: 60
                    height: 60
                    color: "gray"
                    radius: 10
                    border.color: "white"
                    border.width: 3
                    Text{
                        anchors.centerIn: parent
                        text: modelData
                    }
                    MouseArea{
                        anchors.fill:parent
                        onClicked:{
                            if(modelData == "edit"){
                                anot_state = 1;
                                refreshCanvas = true;
                                canvas_map.requestPaint();
                                stackview_menu.push(menu_load_edit);
                            }else if(modelData == "back"){
                                anot_state = 0;
                                stackview.pop();
                            }
                        }
                    }
                }
            }
        }

        Text{
            anchors.right: parent.right
            anchors.bottom: parent.verticalCenter
            text: Number(-grid_size*(point1.y - origin_y))
        }
        Text{
            anchors.right: parent.right
            anchors.top: parent.verticalCenter
            text: Number(-grid_size*(point1.x - origin_x))
        }


    }




    //Annotation Menu========================================================
    Rectangle{
        id: rect_anot_menus
        width: rect_menus.width
        height: parent.height - rect_menus.height
        anchors.top: rect_menus.bottom
        color: "gray"
        property int menu_height: 40
        StackView{
            id: stackview_menu
            anchors.fill: parent
            initialItem: menu_state
        }
    }

    //Annotation Menu ITEM===================================================
    Item{
        id: menu_state
        width: parent.width
        height: parent.height
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "white"
            Column{
                anchors.top: parent.top
                anchors.topMargin: 25
                spacing: 25
                Rectangle{
                    y: 20
                    width: menu_state.width
                    height: rect_anot_menus.menu_height
                    color: "yellow"
                    radius: 10
                    Text{
                        id: text_name
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 15
                        text: "Map : "
                    }
                }
                Rectangle{
                    width: menu_state.width
                    height: rect_anot_menus.menu_height
                    color: "yellow"
                    radius: 10

                }
                Rectangle{
                    width: menu_state.width
                    height: rect_anot_menus.menu_height
                    color: "yellow"
                    radius: 10

                }
                Rectangle{
                    width: menu_state.width
                    height: rect_anot_menus.menu_height
                    color: "yellow"
                    radius: 10

                }
            }

        }
    }
    Item{
        id: menu_load_edit
        width: parent.width
        height: parent.height
        visible: false
        Rectangle{
            width: parent.width
            height: parent.height
            anchors.fill: parent
            color: "white"
            Text{
                id: text_main_1
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
                text: "Step 1. Map annotation and edit location"
            }

            //map load
            Rectangle{
                id: text_cur_name
                anchors.top: text_main_1.bottom
                anchors.topMargin: 30
                width: parent.width
                height: rect_anot_menus.menu_height
                color: "yellow"
                radius: 10
                Text{
                    id: text_name2
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 15
                    text: " Current Map : "
                }
                Text{
                    id: text_name3
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 15
                    text: "/image/"+image_name + ".png";
                }
            }
            Rectangle{
                id: btn_load_map
                width: parent.width/2
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_cur_name.bottom
                anchors.topMargin: 30

                radius: 10
                border.width: 2
                border.color: "gray"

                Text{
                    anchors.centerIn: parent
                    text: "Load"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        fileload.open();
                    }
                }
            }


            //draw Menu
            Row{
                id: menubar_drawing
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: btn_load_map.bottom
                anchors.topMargin: 30
                spacing: 25
                Repeater{
                    model: ["move","draw","clear","undo","redo"]
                    Rectangle{
                        id: btn
                        width: 60
                        height: 60
                        color: {
                            if(tool_num == 0){
                                if(modelData == "move"){
                                    "blue"
                                }else{
                                    "gray"
                                }
                            }else if(tool_num == 1){
                                if(modelData == "draw"){
                                    "blue"
                                }else{
                                    "gray"
                                }
                            }else{
                                "gray"
                            }
                        }
                        radius: 10
                        Image{
                            anchors.centerIn:  parent
                            antialiasing: true
                            mipmap: true
                            scale: {(height>width?parent.width/height:parent.width/width)*0.8}
                            source:{
                                if(modelData == "move"){
                                    "./build/icon/icon_touch.png"
                                }else if(modelData == "draw"){
                                    "./build/icon/icon_save.png"
                                }else if(modelData == "clear"){
                                    "./build/icon/icon_clear.png"
                                }else if(modelData == "undo"){
                                    "./build/icon/icon_undo.png"
                                }else if(modelData == "redo"){
                                    "./build/icon/icon_redo.png"
                                }
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "move"){
                                    tool_num = 0;
                                }else if(modelData == "draw"){
                                    tool_num = 1;
                                }else if(modelData == "clear"){
                                    supervisor.clear_all();
                                    refreshCanvas = true;
                                    canvas_map.requestPaint();
                                }else if(modelData == "undo"){
                                    supervisor.undo();
                                    refreshCanvas = true;
                                    canvas_map.requestPaint();
                                }else if(modelData == "redo"){
                                    supervisor.redo();
                                    refreshCanvas = true;
                                    canvas_map.requestPaint();
                                }
                            }
                        }
                    }
                }
            }

            Row{
                id: colorbar
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: menubar_drawing.bottom
                anchors.topMargin: 30
                spacing: 25
                property color paintColor: "black"
                Repeater{
                    model: ["black", "#191919", "white"]
                    Rectangle {
                        id: red
                        width: 60
                        height: 60
                        color: modelData
                        border.color: "gray"
                        border.width: 2
                        radius: 60

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                colorbar.paintColor = color
                                tool_num = 1;
                            }
                        }
                    }
                }
            }

            Slider {
                id: slider_brush
                x: 300
                y: 330
                value: 15
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: colorbar.bottom
                anchors.topMargin: 20
                width: parent.width/1.5
                height: 30
                from: 0.1
                to : 50
//                orientation: Qt.Vertical
                onValueChanged: {
                    brush_size = value;
                    canvas_map.lineWidth = brush_size;
                    print("slider : " +brush_size);
                }
                onPressedChanged: {
                    if(slider_brush.pressed){
                        brushview.visible = true;
                    }else{
                        brushview.visible =false;
                    }
                }
            }



            //prev, next button
            Rectangle{
                id: btn_prev_1
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Previous"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        anot_state = 0;
                        stackview_menu.pop();
                    }
                }
            }
            Rectangle{
                id: btn_next_1
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Next"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        //save temp Image
                        canvas_map.save("image/map_edited.png");
                        image_name = "map_edited";
                        image_source = "file://" + applicationDirPath + "/image/" + image_name + ".png";
                        supervisor.clear_all();
                        refreshCanvas = true;
                        canvas_map.requestPaint();
                        anot_state = 2;
                        stackview_menu.push(menu_object);
                    }
                }
            }
        }
    }
    Item{
        id: menu_object
        width: parent.width
        height: parent.height
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "white"
            Text{
                id: text_main_2
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
                text: "Step 2. Add Object"
            }
            Row{
                id: menubar_object
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text_main_2.bottom
                anchors.topMargin: 30
                spacing: 25
                Repeater{
                    model: ["move","add","clear","undo","redo"]
                    Rectangle{
                        id: btn2
                        width: 60
                        height: 60
                        color: {
                            if(tool_num == 0){
                                if(modelData == "move"){
                                    "blue"
                                }else{
                                    "gray"
                                }
                            }else if(tool_num == 2){
                                if(modelData == "add"){
                                    "blue"
                                }else{
                                    "gray"
                                }
                            }else{
                                "gray"
                            }
                        }
                        radius: 10
                        Image{
                            anchors.centerIn:  parent
                            antialiasing: true
                            mipmap: true
                            scale: {(height>width?parent.width/height:parent.width/width)*0.8}
                            source:{
                                if(modelData == "move"){
                                    "./build/icon/icon_touch.png"
                                }else if(modelData == "add"){
                                    "./build/icon/icon_save.png"
                                }else if(modelData == "clear"){
                                    "./build/icon/icon_clear.png"
                                }else if(modelData == "undo"){
                                    "./build/icon/icon_undo.png"
                                }else if(modelData == "redo"){
                                    "./build/icon/icon_redo.png"
                                }
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "move"){
                                    tool_num = 0;
                                }else if(modelData == "add"){
                                    tool_num = 2;
                                }else if(modelData == "clear"){
                                    supervisor.clearObjectPoints();
                                    refreshCanvas = true;
                                    canvas_map.requestPaint();
                                }else if(modelData == "undo"){
                                    supervisor.removeObjectPointLast();
                                    refreshCanvas = true;
                                    canvas_map.requestPaint();
                                }else if(modelData == "redo"){
                                }
                            }
                        }
                    }
                }
            }

            //List Object
            Component {
                id: objectCompo
                Item {
                    width: 250; height: 30
                    Text {
                        anchors.centerIn: parent
                        text: name
                    }
                    Rectangle//리스트의 구분선
                    {
                        id:line
                        width:parent.width
                        anchors.bottom:parent.bottom//현재 객체의 아래 기준점을 부모객체의 아래로 잡아주어서 위치가 아래로가게 설정
                        height:1
                        color:"black"
                    }
                    MouseArea{
                        id:area_compo
                        anchors.fill:parent
                        onClicked: {
                            select_object = supervisor.getObjNum(name);
                            print("select object = "+select_object);
                            list_object.currentIndex = index;
                            refreshCanvas = true;
                            canvas_map.requestPaint();
                        }
                    }
                }
            }
            ListView {
                id: list_object
                width: 250
                height: 400
                anchors.top: menubar_object.bottom
                anchors.topMargin: 30
                anchors.left: parent.left
                anchors.leftMargin: 30
                clip: true
                model: ListModel{}
                delegate: objectCompo
                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                focus: true
            }

            Column{
                id: menubar_object2
                anchors.verticalCenter: list_object.verticalCenter
                anchors.left: list_object.right
                anchors.leftMargin: 40
                spacing: 30
                Repeater{
                    model: ["add","edit","remove"]
                    Rectangle{
                        id: btn3
                        width: 60
                        height: 60
                        color: "gray"
                        radius: 10
                        Image{
                            anchors.centerIn:  parent
                            antialiasing: true
                            mipmap: true
                            scale: {(height>width?parent.width/height:parent.width/width)*0.8}
                            source:{
                                if(modelData == "edit"){
                                    "./build/icon/icon_touch.png"
                                }else if(modelData == "remove"){
                                    "./build/icon/icon_save.png"
                                }else if(modelData == "add"){
                                    "./build/icon/icon_save.png"
                                }
                            }
                        }
                        Text{
                            anchors.centerIn: parent
                            text: modelData
                        }

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(modelData == "edit"){
                                    tool_num = 3;
                                }else if(modelData == "remove"){
                                    supervisor.removeObject(list_object.model.get(list_object.currentIndex).name);
                                }else if(modelData == "add"){
                                    popup_add_object.open();
                                }
                            }
                        }
                    }
                }
            }

            Rectangle{
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Previous"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        anot_state = 1;
                        stackview_menu.pop();
                    }
                }
            }
            Rectangle{
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Next"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        supervisor.clear_all();
                        refreshCanvas = true;
                        canvas_map.requestPaint();
                        anot_state = 3;
                        stackview_menu.push(menu_location);
                    }
                }
            }
        }
    }
    Item{
        id: menu_location
        width: parent.width
        height: parent.height
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "white"
            Text{
                id: text_main_3
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
                text: "Step 3. Set Margin"
            }
            Slider{
                id: slider_margin
                anchors.top: text_main_3.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 50
                from: 0
                to: 1
                value: supervisor.getMargin()
            }
            Rectangle{
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Previous"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        anot_state = 2;
                        stackview_menu.pop();
                    }
                }
            }
            Rectangle{
                width: parent.width/2
                height: 60
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                radius: 10
                border.width: 2
                border.color: "gray"
                Text{
                    anchors.centerIn: parent
                    text: "Next"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        anot_state = 4;
                    }
                }
            }

        }

    }



    //Map Canvas ===========================================================
    function draw_canvas_lines(){
        var ctx = canvas_map.getContext('2d');
        for(var i=0; i<supervisor.getCanvasSize(); i++){
            ctx.lineWidth = supervisor.getLineWidth(i);
            ctx.strokeStyle = supervisor.getLineColor(i);
            ctx.lineCap = "round"
            ctx.beginPath()
            lineX = supervisor.getLineX(i);
            lineY = supervisor.getLineY(i);
            for(var j=0;j<lineX.length-1;j++){
                ctx.moveTo(lineX[j], lineY[j])
                ctx.lineTo(lineX[j+1], lineY[j+1])
            }
            ctx.stroke()
        }
    }
    function draw_canvas_map(){
        var ctx = canvas_map.getContext('2d');
        ctx.drawImage(image_map,0,0,image_map.width,image_map.height);
    }
    function draw_canvas_location(){
        var ctx = canvas_map.getContext('2d');
        location_num = supervisor.getLocationNum();
        for(var i=0; i<location_num; i++){
            var loc_type = supervisor.getLocationTypes(i);
            var loc_x = supervisor.getLocationx(i)/grid_size;
            var loc_y = supervisor.getLocationy(i)/grid_size;
            var loc_th = -supervisor.getLocationth(i)-Math.PI/2;

//                        console.log(loc_type,loc_x,loc_y,loc_th);

            if(loc_type.slice(0,4) == "Char"){
                ctx.strokeStyle = "green";
            }else if(loc_type.slice(0,4) == "Rest"){
                ctx.strokeStyle = "white";
            }else if(loc_type.slice(0,4) == "Patr"){
                ctx.strokeStyle = "blue";
            }else if(loc_type.slice(0,4) == "Tabl"){
                ctx.strokeStyle = "gray";
            }
            ctx.beginPath();
            ctx.moveTo(loc_x+origin_x,loc_y+origin_y);
            ctx.arc(loc_x+origin_x,loc_y+origin_y,robot_radius/grid_size, loc_th, loc_th+2*Math.PI, true);
            ctx.moveTo(loc_x+origin_x,loc_y+origin_y);
            ctx.stroke()
        }
    }
    function draw_canvas_selected_object(){
        if(select_object != -1){
//            var ctx = canvas_map.getContext('2d');
//            var obj_type = supervisor.getObjectName(select_object);
//            var obj_size = supervisor.getObjectPointSize(select_object);
//            var obj_x = supervisor.getObjectX(select_object,0)/grid_size +origin_x;
//            var obj_y = supervisor.getObjectY(select_object,0)/grid_size +origin_y;
//            var obj_x0 = obj_x;
//            var obj_y0 = obj_y;
//            ctx.lineWidth = 2;
//            ctx.lineCap = "round";
//            ctx.strokeStyle = "yellow";
//            ctx.fillStyle = "steelblue";
//            ctx.beginPath();
//            ctx.moveTo(obj_x,obj_y);
//            for(var j=1; j<obj_size; j++){
//                obj_x = supervisor.getObjectX(select_object,j)/grid_size + origin_x;
//                obj_y = supervisor.getObjectY(select_object,j)/grid_size + origin_y;
//                ctx.lineTo(obj_x,obj_y);
//            }
//            ctx.lineTo(obj_x0,obj_y0);
//            ctx.closePath();
//            ctx.fill();
//            ctx.stroke();

//            ctx.strokeStyle = "red";
//            ctx.fillStyle = "red";
//            for(j=0; j<obj_size; j++){
//                ctx.beginPath();
//                obj_x = supervisor.getObjectX(select_object,j)/grid_size +origin_x;
//                obj_y = supervisor.getObjectY(select_object,j)/grid_size +origin_y;
//                ctx.moveTo(obj_x,obj_y);
//                ctx.arc(obj_x,obj_y,2,0, Math.PI*2);
//                ctx.closePath();
//                ctx.fill();
//                ctx.stroke();
//            }
        }
    }

    function draw_canvas_object(){
        var ctx = canvas_map.getContext('2d');
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
        var ctx = canvas_map.getContext('2d');
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
        var ctx = canvas_map.getContext('2d');
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
        var ctx = canvas_map_layer.getContext('2d');
        ctx.drawImage(image_map,0,0,image_map.width,image_map.height);
        var map_data = ctx.getImageData(0,0,image_map.width, image_map.height);

        ctx = canvas_map.getContext('2d');
        ctx.fillStyle = "cyan";
        for(var x=0; x< map_data.data.length; x=x+4){
            if(map_data.data[x] > 100){
                ctx.beginPath();
                ctx.moveTo((x/4)%image_map.width,Math.abs((x/4)/image_map.width));
                ctx.arc((x/4)%image_map.width,Math.abs((x/4)/image_map.width),slider_margin.value/grid_size,0,Math.PI*2);
                ctx.fill();
                ctx.stroke();
            }
        }

//        for(var x=0; x< map_data.data.length; x=x+4){
//            if(map_data.data[x] > 100){
//                ctx.beginPath();
//                ctx.moveTo((x/4)%image_map.width,Math.abs((x/4)/image_map.width));
//                ctx.arc((x/4)%image_map.width,Math.abs((x/4)/image_map.width),slider_margin.value/grid_size,0,Math.PI*2);
//                ctx.fill();
//                ctx.stroke();
//            }
//        }
    }


    Rectangle{
        id: rect_map
        width: 800
        height: 800
        clip: true
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right;

        Canvas{
            id: canvas_map_layer
            width: image_map.width
            height: image_map.height
            antialiasing: true

        }

        Canvas{
            id: canvas_map
            width: image_map.width
            height: image_map.height
            antialiasing: true
            property color color: colorbar.paintColor
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
                var ctx = getContext("2d");
                if(refreshCanvas){
                    refreshCanvas = false;
                    ctx.clearRect(0,0,canvas_map.width,canvas_map.height);

                    draw_canvas_map();

                    if(anot_state == 0){ //show current
                        draw_canvas_location();
                        draw_canvas_object();
                        draw_canvas_cur_pose();
                    }else if(anot_state == 1){ //draw
                        draw_canvas_lines();
                    }else if(anot_state == 2){ //object
                        draw_canvas_object();
                        draw_canvas_new_object();
                    }else if(anot_state == 3){ //location
                        draw_canvas_location();
                        draw_canvas_object();
                        draw_canvas_cur_pose();
                        draw_canvas_margin();
                    }else if(anot_state == 4){

                    }

                }
                // Draw new object
                if(tool_num == 1){ //Drawing
                    ctx.lineWidth = canvas_map.lineWidth
                    ctx.strokeStyle = canvas_map.color
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
                }else if(tool_num == 2){ //Add Point
                    draw_canvas_new_object();
                    // Dot , Line
//                    ctx.lineWidth = 1;
//                    ctx.lineCap = "round";

//                    var pointX = supervisor.getTempObjectX(0)/grid_size + origin_x;
//                    var pointY = supervisor.getTempObjectY(0)/grid_size + origin_y;

//                    for(i=1; i<supervisor.getTempObjectSize(); i++){
//                        ctx.strokeStyle = "yellow";
//                        ctx.moveTo(pointX,pointY);
//                        pointX = supervisor.getTempObjectX(i)/grid_size + origin_x;
//                        pointY = supervisor.getTempObjectY(i)/grid_size + origin_y;
//                        ctx.lineTo(pointX,pointY);
//                        ctx.stroke();
//                    }

//                    for(i=0; i<supervisor.getTempObjectSize(); i++){
//                        pointX = supervisor.getTempObjectX(i)/grid_size + origin_x;
//                        pointY = supervisor.getTempObjectY(i)/grid_size + origin_y;
//                        ctx.strokeStyle = "red";
//                        ctx.moveTo(pointX,pointY);
//                        ctx.ellipse(pointX,pointY,5,5);
//                        ctx.fill();
//                        ctx.stroke();
////                        ctx.arc(pointX,pointY,5,0,360);
////                        ctx.fill("red");
//                    }
                    //Temp Cur point

                }else{
                    // Draw canvas
                    if(anot_state == 0){ //show current
                        draw_canvas_location();
                        draw_canvas_object();
                        draw_canvas_cur_pose();
                    }else if(anot_state == 1){ //draw
                        draw_canvas_lines();
                    }else if(anot_state == 2){ //object
                        draw_canvas_new_object();
                        draw_canvas_object();
                        draw_canvas_selected_object();
                    }else if(anot_state == 3){ //location
                        draw_canvas_location();
                        draw_canvas_object();
                        draw_canvas_cur_pose();
                    }
                }
            }

            MultiPointTouchArea{
                id: area_map
                anchors.fill: parent
                minimumTouchPoints: 1
                maximumTouchPoints: 2
                property var gesture: "none"
                property var dmoveX : 0;
                property var dmoveY : 0;
                property var startX : 0;
                property var startY : 0;
                property var startDist : 0;
                touchPoints: [TouchPoint{id:point1},TouchPoint{id:point2}]

                onPressed: {
                    if(tool_num == 0){//move
                        gesture = "drag";
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
                    }else if(tool_num == 1){//draw
                        gesture = "draw";
                        print("gesture -> draw")
                        canvas_map.lastX = point1.x;
                        canvas_map.lastY = point1.y;
                        supervisor.startLine(canvas_map.color, canvas_map.lineWidth);
                        supervisor.setLine(point1.x,point1.y);
                    }else if(tool_num == 2){//add point

                    }else if(tool_num == 3){
                        select_object_point = supervisor.getObjPointNum(select_object, point1.x, point1.y);

                    }
                }

                onReleased: {
                    if(!point1.pressed&&!point2.pressed){
                        if(tool_num == 1){
//                            touchpoint.visible = false;
                            supervisor.stopLine();
                        }else if(tool_num == 2){//add point
                            print(point1.x, point1.y);
                            supervisor.addObjectPoint(point1.x, point1.y);
                        }else if(tool_num == 3){
                            select_object_point = -1;
                        }else{
                            select_object = supervisor.getObjNum(point1.x,point1.y);
                            list_object.currentIndex = select_object;
                            refreshCanvas = true;
                            canvas_map.requestPaint();
                        }

                        gesture = "none"
                    }
                }
                onTouchUpdated:{
                    var ctx = canvas_map.getContext('2d');
                    if(tool_num == 0){
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
                            if(canvas_map.y + dmoveY > canvas_map.height*(new_scale - 1)/2){

                            }else if(canvas_map.y + dmoveY < -(canvas_map.height*(new_scale - 1)/2 + canvas_map.height - rect_map.height)){

                            }else{
                                canvas_map.scale = new_scale;
                                canvas_map.y += dmoveY;
                            }
                            canvas_map.requestPaint()
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
                            canvas_map.requestPaint()
                        }
                    }else if(tool_num == 1){
                        canvas_map.requestPaint()
                    }else if(tool_num == 3){
                        if(select_object_point != -1){
                            supervisor.moveObjectPoint(select_object,select_object_point,point1.x, point1.y);
                        }
                    }
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
//        x: rect_map.x/2 - brush_size/2
//        y: rect_map.y/2 - brush_size/2
    }




    //Map Image================================================================
    Image{
        id: image_map
        visible: false
        source:image_source
        onSourceChanged: {
//            rect_map.flag_image = 0;
        }
    }



    //Timer=====================================================================
    Timer{
        id: timer_loadmap
        interval: 1000
        running: true
        triggeredOnStart: true
        repeat: true
        onTriggered: {
            if(!loadImage){
                if(supervisor.getMapExist()){
                    loadImage = true;
                    var ctx = canvas_map.getContext('2d');
//                    image_source = supervisor.getMappath();
//                    image_name = supervisor.getMapname();
                    print("image source = " + image_source);
                    supervisor.clear_all();
                    location_num = supervisor.getLocationNum();
                    origin_x = supervisor.getOrigin()[0];
                    origin_y = supervisor.getOrigin()[1];
                    grid_size = supervisor.getGridWidth();
                    object_num = supervisor.getObjectNum();
                    ctx.drawImage(image_map,0,0,image_map.width,image_map.height);
                    canvas_map.requestPaint();
                    timer_loadmap.stop();
                }
            }
        }
    }



    //Dialog(Popup) ================================================================
    FileDialog{
        id: fileload
        folder: "file:"+applicationDirPath+"/image"
        property variant pathlist
        property string path : ""
        fileMode: FileDialog.OpenFile
        nameFilters: ["*.png"]
        onAccepted: {
            print(fileload.file.toString());
            pathlist = fileload.file.toString().split("/");
            path = "./build/image/" + pathlist[9];
            image_source = fileload.file.toString();//path
            image_name = pathlist[9].split(".")[0];
            print(image_source)
            var ctx = canvas_map.getContext('2d');
            print("image source = " + image_source);
            ctx.drawImage(image_map,0,0,image_map.width,image_map.height);
            canvas_map.requestPaint();

        }
    }
    Popup{
        id: popup_add_object
//        visible: false
        width: 400
        height: 300
        anchors.centerIn: parent
        background: Rectangle{
            anchors.fill:parent
            color: "white"
        }

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Add Object"
            font.pixelSize: 20
            font.bold: true
        }
        TextField{
            id: textfield_name
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
            width: 200
            height: 60
            placeholderText: "(obj_name)"
            font.pointSize: 20
        }
        Rectangle{
            id: btn_add_object_confirm
            width: 60
            height: 50
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 20
            color: "gray"
            Text{
                anchors.centerIn: parent
                text: "확인"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(textfield_name.text == ""){
                        textfield_name.color = "red";
                    }else{
                        supervisor.addObject(textfield_name.text);
                        tool_num = 0;
                        popup_add_object.close();
                    }
                }
            }
        }
        Rectangle{
            id: btn_add_object_cancel
            width: 60
            height: 50
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 20
            color: "gray"
            Text{
                anchors.centerIn: parent
                text: "취소"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
//                    popup_add_object.visible = false;
                    popup_add_object.close();
                }
            }
        }
    }
}
