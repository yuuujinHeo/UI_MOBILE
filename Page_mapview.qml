import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
//import QtQuick.Shapes 1.
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0
//import QtQuick.Templates 2.5
import "."
import io.qt.Supervisor 1.0
Item {
    property int tool_num: 0
    property int touch_mode: supervisor.getDBvalue('prefer_mouse')=="yes"?1:0 //0:touch 1:mouse
    property bool refresh_flag: false
    property int map_size: 800
    property int size_zoom: 0
    property int brush_size: 10
    property int index: 0
    property list<Item> array_canvas;
    property list<Item> array_brush;
    property var map_data;
    property string image_source: "file://" + applicationDirPath + "/image/map_downloaded.png"

    onMap_dataChanged: {
        canvas_map.requestPaint()
    }

    Text{
        id: text_cfile
        text: "current file : "
        x: 20
        y: 20
    }
    Text{
        id: text_filename
        text: image_source.split('/')[9]
        anchors.left: text_cfile.right
        anchors.verticalCenter: text_cfile.verticalCenter
        anchors.leftMargin: 20
    }

    Row {
        id: menubar
        x: 40
        y: 100
        spacing: 25
        Repeater{
            model: ["load","save","mouse","touch"]
            Rectangle{
                id: btn
                property bool containMouse: false
                property color image_color: {
                    if(containMouse){
                        "white"
                    }else if(modelData == "load"){
                        "#E4B78A"
                    }else if(modelData == "save"){
                        "#AE809B"
                    }else if(modelData == "mouse"){
                        "#E38A8A"
                    }else if(modelData == "touch"){
                        "#997976"
                    }
                }

                Behavior on image_color {
                    ColorAnimation {
                        duration: 200
                    }
                }
                Behavior on color{
                    ColorAnimation {
                        duration: 200
                    }
                }
                width: 80
                height: 80
                color: {
                    if(containMouse){
                        if(modelData == "load"){
                            "#E4B78A"
                        }else if(modelData == "save"){
                            "#AE809B"
                        }else if(modelData == "mouse"){
                            "#E38A8A"
                        }else if(modelData == "touch"){
                            "#997976"
                        }
                    }else{
                        if(modelData == "mouse" && touch_mode == 1){
                            "#E4B78A"
                        }else if(modelData == "touch" && touch_mode == 0){
                            "#E4B78A"
                        }else{
                            "transparent"
                        }
                    }
                }
                border.color: image_color
                border.width: 4
                radius: 10
                Image{
                    id: imm
                    anchors.centerIn:  parent
                    antialiasing: true
                    mipmap: true
                    scale: {height>width?60/height:60/width}
                    source: {
                        if(modelData == "load"){
                            "./build/icon/icon_folder.png"
                        }else if(modelData == "save"){
                            "./build/icon/icon_save.png"
                        }else if(modelData == "mouse"){
                            "./build/icon/icon_mouse.png"
                        }else if(modelData == "touch"){
                            "./build/icon/icon_touch.png"
                        }
                    }
                    ColorOverlay{
                        anchors.fill: parent
                        source: parent
                        cached: true
                        color: parent.parent.image_color
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        if(modelData == "touch"){
                            touch_mode = 0;
                            tool_num = 0;
                        }else if(modelData == "mouse"){
                            touch_mode = 1;
                            tool_num = 0;
                        }else if(modelData == "save"){
                            filesave.open();
                            canvas_map.save("image/map1.png")
                        }else if(modelData == "load"){
                            fileload.open();
                        }
                    }
                    onContainsMouseChanged: {
                        parent.containMouse = containsMouse
                    }
                }
            }
        }
    }

    MessageDialog{

        id: msgbox_map_save
        title: "Save"
        text: "맵 파일이 기존 과 다릅니다.\n이 맵을 기본 맵으로 설정하시겠습니까?"
        buttons: StandardButton.Yes | StandardButton.No
        onYesClicked:{
            supervisor.setMapURL(image_source);
        }
        onNoClicked:{

        }
    }

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
            print(image_source)
//            Qt.quit()

        }
    }

    FileDialog{
        id: filesave
        fileMode: FileDialog.SaveFile
        property variant pathlist
        property string path : ""
        folder: "file:"+applicationDirPath+"/image"
        onAccepted: {
            print(filesave.file.toString())
            pathlist = filesave.file.toString().split('/');
            print(pathlist[9]);

            if(pathlist[9].split('.')[1] == "png"){
                canvas_map.save("image/"+pathlist[9]);
                image_source = filesave.file.toString();
            }else{
                canvas_map.save("image/"+pathlist[9]+".png");
                image_source = filesave.file.toString()+".png";
            }

            print(image_source)
            if(supervisor.getMapURL() == image_source){
            }else{
                msgbox_map_save.open();
            }
        }
    }

    Row {
        id: menubar2
        x: 40
        y: 200
        spacing: 25
        Repeater{
            model: ["clear","undo","redo"]
            Rectangle{
                property bool containMouse: false
                property color image_color: {
                    if(containMouse && modelData != "redo"){
                        "white"
                    }else if(modelData == "clear"){
                        "#E4B78A"
                    }else if(modelData == "undo"){
                        "#AE809B"
                    }else if(modelData == "redo"){
                        if(supervisor.getRedoSize() > 0){
                            if(containMouse){
                                "white"
                            }else{
                                "#E38A8A"
                            }
                        }else{
                            "gray"
                        }
                    }
                }
                Behavior on image_color {
                    ColorAnimation {
                        duration: 200
                    }
                }
                Behavior on color{
                    ColorAnimation {
                        duration: 200
                    }
                }

                width: 80
                height: 80
                color: {
                    if(containMouse){
                        if(modelData == "clear"){
                            "#E4B78A"
                        }else if(modelData == "undo"){
                            "#AE809B"
                        }else if(modelData == "redo"){
                            if(supervisor.getRedoSize() > 0){
                                "#E38A8A"
                            }else{
                                "transparent"
                            }
                        }
                    }else{
                        "transparent"
                    }

                }
                border.color: image_color
                border.width: 4
                radius: 10
                Image{
                    anchors.centerIn:  parent
                    antialiasing: true
                    mipmap: true
                    scale: {height>width?60/height:60/width}
                    source: {
                        if(modelData == "clear"){
                            "./build/icon/icon_clear.png"
                        }else if(modelData == "undo"){
                            "./build/icon/icon_undo.png"
                        }else if(modelData == "redo"){
                            "./build/icon/icon_redo.png"
                        }
                    }
                    ColorOverlay{
                        anchors.fill: parent
                        source: parent
                        cached: true
                        color: parent.parent.image_color
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        if(modelData == "draw"){
                            tool_num = 1;
                        }else if(modelData == "clear"){
                            supervisor.clear_all();
                            refresh_flag = true;
                            canvas_map.requestPaint();
                        }else if(modelData == "undo"){
                            supervisor.undo();
                            refresh_flag = true;
                            canvas_map.requestPaint();
                        }else if(modelData == "redo"){
                            supervisor.redo();
                            refresh_flag = true;
                            canvas_map.requestPaint();
                        }
                    }
                    onContainsMouseChanged: {
                        parent.containMouse = containsMouse
                    }

                }
            }
        }
    }

    Rectangle{
        id: btn_add
        x: 40
        y: 600
        property bool containMouse: false
        property color image_color: {
            if(containMouse){
                "white"
            }else{
                "#E4B78A"
            }
        }

        Behavior on image_color {
            ColorAnimation {
                duration: 200
            }
        }
        Behavior on color{
            ColorAnimation {
                duration: 200
            }
        }
        width: 80
        height: 80
        color: {
            if(containMouse){
                "#E4B78A"
            }else{
                "transparent"
            }
        }
        border.color: image_color
        border.width: 4
        radius: 10
        Image{
            anchors.centerIn:  parent
            antialiasing: true
            mipmap: true
            scale: {height>width?60/height:60/width}
            source: "./build/icon/add.png"
            ColorOverlay{
                anchors.fill: parent
                source: parent
                cached: true
                color: parent.parent.image_color
            }
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                showMenus();
            }
            onContainsMouseChanged: {
                parent.containMouse = containsMouse
            }
        }
    }


    Row {
        id: menubar3
        x: 145
        y: 600
        spacing: 25

        Repeater{
            id: menus_3
            model: []
            delegate: Rectangle{
                id: btn3
                property bool containMouse: false
                property color image_color: {
                    if(containMouse){
                        "white"
                    }else if(modelData == "add"){
                        "#E4B78A"
                    }else if(modelData == "hello"){
                        "#E4B78A"
                    }else{
                        "transparent"
                    }
                }

                Behavior on x{
                    ParallelAnimation{
                        PropertyAnimation{
                            duration: 5000
                            easing.type: Easing.InOutBack
                        }
                    }
                }

                Behavior on image_color {
                    ColorAnimation {
                        duration: 200
                    }
                }
                Behavior on color{
                    ColorAnimation {
                        duration: 200
                    }
                }
                width: 80
                height: 80
                color: {
                    if(containMouse){
                        if(modelData == "add"){
                            "#E4B78A"
                        }else if(modelData == "hello"){
                            "#E4B78A"
                        }else{
                            "transparent"
                        }
                    }else{
                        "transparent"
                    }
                }
                border.color: image_color
                border.width: 4
                radius: 10
                Image{
                    id: imm3
                    anchors.centerIn:  parent
                    antialiasing: true
                    mipmap: true
                    scale: {height>width?60/height:60/width}
                    source: {
                        if(modelData == "add"){
                            "./build/icon/add.png"
                        }else if(modelData == "hello"){
                            "./build/icon/add.png"
                        }
                    }
                    ColorOverlay{
                        anchors.fill: parent
                        source: parent
                        cached: true
                        color: parent.parent.image_color
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        if(modelData == "add"){
                            showMenus();
                        }
                    }
                    onContainsMouseChanged: {
                        parent.containMouse = containsMouse
                    }
                }

            }
        }
    }


    Timer{
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            var element1 = menus_3.itemAt()
        }
    }

    function showMenus(){
        menus_3.model = ["hello","hello","hello","hello"]
    }

    function hideMenus(){
        menus_3.model = []
    }


    Rectangle{
        id: cur_color
        width: 80
        height: 80
        radius: 80
        border.color: tool_num==1?"yellow":"white"
        border.width: 20
        x: colorTools.x - 10
        y: {
            if(colorTools.paintColor == "#000000"){
                colorTools.y + 0 - 10
            }else if(colorTools.paintColor == "#191919"){
                colorTools.y + 80 - 10
            }else{
                colorTools.y + 160 - 10
            }
        }
        Behavior on y{
            NumberAnimation{
                duration : 500
            }
        }
    }

    Column {
        id: colorTools
        x: 100
        y: 350
        spacing: 20
        property color paintColor: "black"
        onPaintColorChanged: {
            print(colorTools.paintColor)
        }

        Repeater {
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
                        colorTools.paintColor = color
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
        value: 1.5
        width: 100
        height: 230
        from: 0.5
        to : 50
        orientation: Qt.Vertical
        onValueChanged: {
            brush_size = value;
        }
        onPressedChanged: {
            if(slider_brush.pressed){
                brushview.visible = true;
            }else{
                brushview.visible =false;
            }
        }
    }


    Rectangle{
        id: rect_map
        width: 800
        height: 800
        clip: true
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right;

        property int flag_image: 0
        border.width: 3
        border.color:"black"

        Canvas{
            id: canvas_map
            x: 0; y:0;
            width: image_map.width
            height: image_map.height
            antialiasing: true

            property real lastX
            property real lastY
            property var lineX
            property var lineY
            property var index: 0
            property color color: colorTools.paintColor
            property var lineWidth: brush_size

            function rePaint(){
//                print("repaint")
//                var ctx = getContext("2d")
//                ctx.clearRect(0,0,canvas_map.width,canvas_map.height);
//                ctx.drawImage(image_map,0,0,image_map.width,image_map.height)
//                tool_num = 0;
//                refresh_flag = true;
            }

            onPaint:{

                var ctx = getContext("2d")
                if(refresh_flag){
                    refresh_flag = false;
                    ctx.clearRect(0,0,canvas_map.width,canvas_map.height);
                    ctx.drawImage(image_map,0,0,image_map.width,image_map.height)
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
//                        print(i,ctx.lineWidth,ctx.strokeStyle);
                    }
                }

                if(tool_num == 1){
                    ctx.lineWidth = canvas_map.lineWidth
                    ctx.strokeStyle = canvas_map.color
                    ctx.lineCap = "round"
                    ctx.beginPath()
                    ctx.moveTo(lastX, lastY)

                    if(touch_mode == 0 && point1.pressed){
                        lastX = point1.x
                        lastY = point1.y
//                        print(lastX,lastY)
                    }else if(touch_mode == 1 && area_map.pressed){
                        lastX = area_map.mouseX
                        lastY = area_map.mouseY
                    }
                    supervisor.setLine(lastX,lastY);
                    ctx.lineTo(lastX, lastY)
                    ctx.stroke()
                }else{
                    //test
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
//                        print(i,ctx.lineWidth,ctx.strokeStyle);
                        ctx.stroke()
                    }
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

            MultiPointTouchArea{
                id: area_map_touch
                enabled: touch_mode==0?true:false
                anchors.fill: parent
                minimumTouchPoints: 1
                maximumTouchPoints: 2
                mouseEnabled: false
                property var gesture: "none"
                property var dmoveX : 0;
                property var dmoveY : 0;
                property var startX : 0;
                property var startY : 0;
                property var startDist : 0;
                touchPoints: [TouchPoint{id:point1},TouchPoint{id:point2}]
                onPressed: {
                    print("pressed ",point1.pressed,point2.pressed)
                    if(tool_num == 0){//move
                        print("gesture -> drag")
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
                    }else if(tool_num == 1){//draw
                        gesture = "draw";
                        print("gesture -> draw")
                        canvas_map.lastX = point1.x;
                        canvas_map.lastY = point1.y;
                        supervisor.startLine(canvas_map.color, canvas_map.lineWidth);
                        supervisor.setLine(point1.x,point1.y);
                    }
                }
                onReleased: {
                    if(!point1.pressed&&!point2.pressed){
                        if(tool_num == 1){
                            touchpoint.visible = false;
                            supervisor.stopLine();
                        }
                        gesture = "none"
                    }
                }
                onTouchUpdated:{
                    var ctx = canvas_map.getContext('2d');
                    if(tool_num == 0){
                        var dx = Math.abs(point1.x-point2.x);
                        var dy = Math.abs(point1.y-point2.y);
                        var mx = (point1.x+point2.x)/2;
                        var my = (point1.y+point2.y)/2;
                        var dist = Math.sqrt(dx*dx + dy*dy);
                        var dscale = (dist)/startDist;
                        var new_scale = canvas_map.scale*dscale;
                        if(point1.pressed&&point2.pressed){

                            if(new_scale > 5)   new_scale = 5;
                            else if(new_scale < 1) new_scale = 1;

                            canvas_map.scale = new_scale;

                            print("drag",mx,my,dist,new_scale,canvas_map.scale);

                            dmoveX = (mx - startX);
                            dmoveY = (my - startY);
                            canvas_map.x += dmoveX;
                            canvas_map.y += dmoveY;

                            canvas_map.requestPaint()
                        }else{
                            dmoveX = (point1.x - startX);
                            dmoveY = (point1.y - startY);
                            canvas_map.x += dmoveX;
                            canvas_map.y += dmoveY;

                            canvas_map.requestPaint()
                        }
                    }else if(tool_num == 1){
                        canvas_map.requestPaint()
                    }


                }
            }


            Rectangle{
                id: touchpoint
                visible: false
                width: brush_size+1
                height: brush_size+1
                radius: brush_size+1
                border.width: 1
                border.color: "black"
                color: colorTools.paintColor
                x:touch_mode==0?area_map_touch.point1.x-brush_size/2-1:area_map.mouseX-brush_size/2-1
                y:touch_mode==0?area_map_touch.point1.y-brush_size/2-1:area_map.mouseY-brush_size/2-1

            }

            MouseArea{
                id: area_map
                enabled: touch_mode==1?true:false
                anchors.fill: parent
                property var tempPath;
                cursorShape: tool_num==1?Qt.CrossCursor:Qt.ArrowCursor

                property var moveX : 0;
                property var moveY : 0;
                property var dmoveX : 0;
                property var dmoveY : 0;
                property var startX : 0;
                property var startY : 0;
                property bool is_pressed : false;
                hoverEnabled: false;//tool_num==0?true:false

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
                    print(canvas_map.scale,canvas_map.width,canvas_map.height,canvas_map.x,canvas_map.y)
//                        canvas_map.requestPaint()


                }

                onPressed: {
                    is_pressed = true;
                    startX = mouseX;
                    startY = mouseY;
                    canvas_map.lastX = mouseX;
                    canvas_map.lastY = mouseY;
                    if(tool_num == 1){
                        touchpoint.visible = true;
                        supervisor.startLine(canvas_map.color, canvas_map.lineWidth);
                        supervisor.setLine(mouseX,mouseY);
                    }
                }
                onReleased: {
                    is_pressed = false;
                    if(tool_num == 0){
                        moveX = moveX+dmoveX;
                        moveY = moveY+dmoveY;
                    }
                    if(tool_num == 1){
                        touchpoint.visible = false;
                        supervisor.stopLine();
                    }
                }
                onPositionChanged: {
                    var ctx = canvas_map.getContext('2d');
                    if(is_pressed){
                        if(tool_num == 0){//move
                            dmoveX = (mouseX - startX);
                            dmoveY = (mouseY - startY);

                            canvas_map.x += dmoveX;
                            canvas_map.y += dmoveY;

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

                        }else if(tool_num == 1){

                        }
                        canvas_map.requestPaint()
                    }else{

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

    Timer {
        interval: 1000
        running: true
        triggeredOnStart: true
        repeat: true
        onTriggered: {
            if(canvas_map.available && rect_map.flag_image == 0){
                rect_map.flag_image = 1;
                var ctx = canvas_map.getContext('2d');
                ctx.drawImage(image_map,0,0,image_map.width,image_map.height)
                map_data = ctx.getImageData(0,0,image_map.width,image_map.height)
//                print(map_data);
                //Debugging
//                curMap.map_data = map_data;
//                curMap.image_width = image_map.width;
//                curMap.image_height = image_map.height;

                print('image size = ',image_map.width, image_map.height)
                print('pixel length = ',map_data.data.length)
//                for( var x=0; x < map_data.data.length; x=x+4 )
//                {

////                     To read RGBA values
//                    var red   =  map_data.data[x];
//                    var green =  map_data.data[x + 1];
//                    var blue  =  map_data.data[x + 2];
//                    var alpha =  map_data.data[x + 3];

//                    print(red + ", " + green + ", " + blue + ", " + alpha );

////                     To convert to grey scale, modify rgba according to your formula
//                    map_data.data[x]     = 0.2126 *map_data.data[x]  + 0.7152* map_data.data[x+1]  + 0.0722 *map_data.data[x+2];
//                    map_data.data[x+1]   = 0.2126 *map_data.data[x]  + 0.7152* map_data.data[x+1]  + 0.0722 *map_data.data[x+2];
//                    map_data.data[x+2]   = 0.2126 *map_data.data[x]  + 0.7152* map_data.data[x+1]  + 0.0722 *map_data.data[x+2];
//                    map_data.data[x+3]   =  255;
//                }
//                print(map_data.data)
            }

            canvas_map.requestPaint()
        }

    }


    Image{
        id: image_map
        visible: false
        source:image_source
        onSourceChanged: {
            print(image_source)
            rect_map.flag_image = 0;
        }
    }

    Rectangle{
        id: rect_before
        width: 70
        height: 70
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: 100
        color: "gray"
        Text{
            text: "menu"
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                stackview.pop();
            }
        }
    }
}
