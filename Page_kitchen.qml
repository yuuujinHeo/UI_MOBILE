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
import QtQml 2.2
Item {
    id: page_kitchen
    objectName: "page_kitchen"
    width: 1280
    height: 800

    function init(){
        table_num1 = 0;
        tray_1.color =  "gray"
        table_num2 = 0;
        tray_2.color =  "gray"
        table_num3 = 0;
        tray_3.color =  "gray"
    }

    property int tray_num: 3
    property int table_num: 4
    property double battery: 0
    property string robotName: "test"
    property date curDate: new Date()
    property string curTime: curDate.toLocaleTimeString()

    property int table_num1: 0
    property int table_num2: 0
    property int table_num3: 0

    property int tray_width: 200
    property int tray_height: 80
    property int tray_dist: 30

    property int cur_table_num: 0
    property bool flag_moving: false

//    Timer{
//        id: timer_update
//        interval: 100
//        running: true
//        repeat: true
//        onTriggered: {
//            curTime = Qt.formatTime(new Date(), "hh:mm")
//            battery = supervisor.getBattery();
//        }
//    }

    Rectangle{
        anchors.fill : parent
        color: "white"
    }

    property int init_x_table : 0//400
    property int init_y_table : 0//10
    property int spacing_table : 10
    property int rect_size: 70
    Rectangle{
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.verticalCenter: parent.verticalCenter
        height: (rect_size+spacing_table)*table_num - spacing_table
        width: rect_size

        Repeater{
            model: table_num
            Rectangle{
                id: rect_table
                width:70
                height:70
                z: mouse_table.drag.active || mouse_table.pressed ? 2:1
                color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
                x: init_x_table
                y: init_y_table + spacing_table*index + 70*index
                property point beginDrag
                property bool caught: false
                border{width:2;color:"white"}
                radius:7
                Drag.active: mouse_table.drag.active

                onYChanged: {
                    if(flag_moving){
                        if(parent.x+x>tray_1.x && parent.x+x<tray_1.x+tray_1.width){
                            if(parent.y+y>tray_1.y && parent.y+y<tray_1.y+tray_1.height){
                                if(table_num1 != cur_table_num){
                                    console.log("UI : SET TABLE 1 TO "+Number(cur_table_num));
                                    tray_1.color = rect_table.color;
                                    table_num1 = cur_table_num;
                                }
                            }else if(parent.y+y>tray_2.y && parent.y+y<tray_2.y+tray_2.height){
                                if(table_num2 != cur_table_num){
                                    console.log("UI : SET TABLE 2 TO "+Number(cur_table_num));
                                    tray_2.color = rect_table.color;
                                    table_num2 = cur_table_num;
                                }
                            }else if(parent.y+y>tray_3.y && parent.y+y<tray_3.y+tray_3.height){
                                if(table_num3 != cur_table_num){
                                    console.log("UI : SET TABLE 3 TO "+Number(cur_table_num));
                                    tray_3.color = rect_table.color;
                                    table_num3 = cur_table_num;
                                }
                            }
                        }
                    }
                }
                onXChanged: {
                    if(flag_moving){
                        if(parent.x+x>tray_1.x && parent.x+x<tray_1.x+tray_1.width){
                            if(parent.y+y>tray_1.y && parent.y+y<tray_1.y+tray_1.height){
                                if(table_num1 != cur_table_num){
                                    console.log("UI : SET TABLE 1 TO "+Number(cur_table_num));
                                    tray_1.color = rect_table.color;
                                    table_num1 = cur_table_num;
                                }
                            }else if(parent.y+y>tray_2.y && parent.y+y<tray_2.y+tray_2.height){
                                if(table_num2 != cur_table_num){
                                    console.log("UI : SET TABLE 2 TO "+Number(cur_table_num));
                                    tray_2.color = rect_table.color;
                                    table_num2 = cur_table_num;
                                }
                            }else if(parent.y+y>tray_3.y && parent.y+y<tray_3.y+tray_3.height){
                                if(table_num3 != cur_table_num){
                                    console.log("UI : SET TABLE 3 TO "+Number(cur_table_num));
                                    tray_3.color = rect_table.color;
                                    table_num3 = cur_table_num;
                                }
                            }
                        }
                    }
                }

                Text{
                    anchors.centerIn: parent
                    text: index+1
                    color: "white"
                }
                MouseArea{
                    id:mouse_table
                    anchors.fill:parent
                    drag.target: parent
                    propagateComposedEvents: true
                    preventStealing: false
                    onPressed: {
                        rect_table.beginDrag = Qt.point(rect_table.x, rect_table.y);
                        cur_table_num = index+1;
                        flag_moving = true;
                    }
                    onReleased: {
                        flag_moving = false;
                        backAnimX.from = rect_table.x;
                        backAnimX.to = beginDrag.x;
                        backAnimY.from = rect_table.y;
                        backAnimY.to = beginDrag.y;
                        backAnim.start()

                    }
                }
                ParallelAnimation{
                    id: backAnim
                    SpringAnimation{ id: backAnimX; target: rect_table; property: "x"; duration: 500; spring: 2; damping: 0.2}
                    SpringAnimation{ id: backAnimY; target: rect_table; property: "y"; duration: 500; spring: 2; damping: 0.2}
                }
            }
        }
    }


    Rectangle{
        id: tray_1
        width: tray_width
        height: tray_height
        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.left: parent.left
//        anchors.leftMargin: 100
        anchors.top: parent.top
        anchors.topMargin: 150
        color: "gray"
        border{width:2;color:"black"}
        radius:7
        onColorChanged: {
            console.log(color)
            if(color != "#0000ff"){
                ani_tray_1.start()
            }
        }
        SequentialAnimation{
            id: ani_tray_1
            running: false
            ParallelAnimation{
                NumberAnimation{target:tray_1; property:"scale"; from:1;to:1.2;duration:300;}
                NumberAnimation{target:tray_1; property:"scale"; from:1.2;to:1;duration:300;}
            }
        }

        MouseArea{
            id: mtray_1
            anchors.fill: parent
            onClicked:{
                table_num1 = 0;
                tray_1.color =  "gray"
            }
        }
        Text{
            id: textTray1
            anchors.centerIn: parent
            text: table_num1==0?"":Number(table_num1)
        }
        Text{
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.right
            anchors.leftMargin: 10
            font.pixelSize: 30
            text: "TRAY 1"
        }
    }
    Rectangle{
        id: tray_2
        width: tray_width
        height: tray_height
        anchors.left: tray_1.left
        anchors.top: tray_1.bottom
        anchors.topMargin: tray_dist
        color: "gray"
        border{width:2;color:"black"}
        radius:7
        onColorChanged: {
            console.log(color)
            if(color != "#0000ff"){
                ani_tray_2.start()
            }
        }
        SequentialAnimation{
            id: ani_tray_2
            running: false
            ParallelAnimation{
                NumberAnimation{target:tray_2; property:"scale"; from:1;to:1.2;duration:300;}
                NumberAnimation{target:tray_2; property:"scale"; from:1.2;to:1;duration:300;}
            }
        }
        MouseArea{
            id: mtray_2
            anchors.fill: parent
            onClicked:{
                table_num2 = 0;
                tray_2.color= "gray"
            }
        }


        Text{
            id: textTray2
            anchors.centerIn: parent
            text: table_num2==0?"":Number(table_num2)
        }
        Text{
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.right
            anchors.leftMargin: 10
            font.pixelSize: 30
            text: "TRAY 2"
        }
    }
    Rectangle{
        id: tray_3
        width: tray_width
        height: tray_height
        anchors.left: tray_2.left
        anchors.top: tray_2.bottom
        anchors.topMargin: tray_dist
        color: "gray"
        border{width:2;color:"black"}
        radius:7
        onColorChanged: {
            console.log(color)
            if(color != "#0000ff"){
                ani_tray_3.start()
            }
        }
        SequentialAnimation{
            id: ani_tray_3
            running: false
            ParallelAnimation{
                NumberAnimation{target:tray_3; property:"scale"; from:1;to:1.2;duration:300;}
                NumberAnimation{target:tray_3; property:"scale"; from:1.2;to:1;duration:300;}
            }
        }
        MouseArea{
            id: mtray_3
            anchors.fill: parent
            onClicked:{
                table_num3 = 0;
                tray_3.color= "gray"
            }
        }
        Text{
            id: textTray3
            anchors.centerIn: parent
            text: table_num3==0?"":Number(table_num3)
        }
        Text{
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.right
            anchors.leftMargin: 10
            font.pixelSize: 30
            text: "TRAY 3"
        }
    }

    Rectangle{
        id: rect_go
        width: 150
        height: 150
        radius: 150
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 80
        anchors.horizontalCenter: parent.horizontalCenter
        color: "yellow"
        border.width: 2
        border.color: "gray"
        Text{
            id: text_go
            anchors.centerIn: parent
            text: "GO"
        }
        MouseArea{
            id: btn_go
            anchors.fill: parent
            onClicked: {
                console.log("GO : "+Number(table_num1)+","+Number(table_num2)+","+Number(table_num3));
                supervisor.setTray(table_num1,table_num2,table_num3);
            }
        }
    }

    Rectangle{
        id: rect_charge
        width: 100
        height: 100
        radius: 100
        anchors.top: rect_go.top
        anchors.topMargin: 70
        anchors.right: rect_go.left
        anchors.rightMargin: 30
        color: "gray"
        Text{
            id: text_charge
            anchors.centerIn: parent
            text: "ch"
        }
        MouseArea{
            id: btn_charge
            anchors.fill: parent
            onClicked: {
                supervisor.moveToCharge();
            }
        }
    }
    Rectangle{
        id: rect_menu
        width: 100
        height: 100
        radius: 100
        anchors.top: rect_go.top
        anchors.topMargin: 70
        anchors.left: rect_go.right
        anchors.leftMargin: 30
        color: "gray"
        Text{
            id: text_menu
            anchors.centerIn: parent
            text: "menu"
        }
        MouseArea{
            id: btn_menu
            anchors.fill: parent
            onClicked: {
                stackview.push(pmenus);
            }
        }
    }

    Rectangle{
        id: status_bar
        width: parent.width
        height: 50
        anchors.left: parent.left
        color: "gray"
        Text{
            id: textName
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            text: robotName

        }
        Text{
            id: textTime
            anchors.centerIn: parent
            anchors.leftMargin: 20
            text: curTime

        }
        Text{
            id: textBattery
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            text: battery.toFixed(1)+' V'
        }
    }

}
