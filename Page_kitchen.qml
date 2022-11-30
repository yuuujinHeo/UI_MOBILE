import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.12
//import QtQuick.Shapes 1.
//import QtQuick.Dialogs 1.2
//import Qt.labs.platform 1.0
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
        table_num = supervisor.getTableNum();
        tray_num = supervisor.getTrayNum();
        traymodel.clear();
        for(var i=0; i<tray_num; i++){
            traymodel.append({x:0,y:0,tray_num:i+1,set_table:0,color:"gray"});
        }
    }
    property int tray_num: 3
    property int table_num: 5
    property double battery: 0
    property string robotName: "test"
    property date curDate: new Date()
    property string curTime: curDate.toLocaleTimeString()

    property int tray_width: 200
    property int tray_height: 80
    property int tray_dist: 30

    property int cur_table_num: 0
    property bool flag_moving: false

    Rectangle{
        anchors.fill : parent
        color: "white"
    }

    property int init_x_table : 0//400
    property int init_y_table : 0//10
    property int spacing_table : 10
    property int rect_size: 70

    ListModel{
        id: traymodel
        ListElement{
            x: 0
            y: 0
            tray_num: 1
            set_table: 0
            color: "gray"
        }
    }

    Rectangle{
        id: rect_tables
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.verticalCenter: parent.verticalCenter
        height: (rect_size+spacing_table)*table_num - spacing_table
        width: rect_size
        z:14
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
                property string cur_color
                property bool caught: false
                border{width:2;color:"white"}
                radius:7
                Drag.active: mouse_table.drag.active
                onYChanged: {
                    if(flag_moving){
                        for(var i=0; i<tray_num; i++){
                            if(rect_tables.x+x > column_tray.x && rect_tables.x+x<column_tray.x + tray_width){
                                if(rect_tables.y+y > column_tray.y+traymodel.get(i).y && rect_tables.y+y < column_tray.y+traymodel.get(i).y + tray_height){
                                    if(traymodel.get(i).set_table != cur_table_num){
                                        console.log("UI : SET TABLE "+Number(i+1)+" TO "+Number(cur_table_num));
                                        cur_color = rect_table.color;
                                        traymodel.get(i).color = cur_color;
                                        traymodel.get(i).set_table = cur_table_num;
                                    }
                                }
                            }
                        }
                    }
                }
                onXChanged: {
                    if(flag_moving){
                        for(var i=0; i<tray_num; i++){
                            if(rect_tables.x+x > column_tray.x && rect_tables.x+x<column_tray.x + tray_width){
                                if(rect_tables.y+y > column_tray.y+traymodel.get(i).y && rect_tables.y+y < column_tray.y+traymodel.get(i).y + tray_height){
                                    if(traymodel.get(i).set_table != cur_table_num){
                                        console.log("UI : SET TABLE "+Number(i+1)+" TO "+Number(cur_table_num));
                                        cur_color = rect_table.color;
                                        traymodel.get(i).color = cur_color;
                                        traymodel.get(i).set_table = cur_table_num;
                                    }
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
                    preventStealing: true
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



    Column{
        id: column_tray
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        spacing: 20
        z: 1
        Repeater{
            id: repeat_tray
            model: traymodel
            Rectangle{
                id: rect_tray
                width: tray_width
                height: tray_height
                color: model.color
                border{width:2;color:"black"}
                radius:7
                onYChanged: {
                    model.y = y;
                }

                onColorChanged: {
                    if(color != "#0000ff"){
                        ani_tray.start()
                    }
                }
                SequentialAnimation{
                    id: ani_tray
                    running: false
                    ParallelAnimation{
                        NumberAnimation{target:rect_tray; property:"scale"; from:1;to:1.2;duration:300;}
                        NumberAnimation{target:rect_tray; property:"scale"; from:1.2;to:1;duration:300;}
                    }
                }

                MouseArea{
                    id: tray_mousearea
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked:{
                        model.set_table = 0;
                        model.color =  "gray"
                    }
                }
                Text{
                    id: textTray
                    anchors.centerIn: parent
                    text: (model.set_table==0)?"Tray "+Number(model.tray_num):Number(model.set_table)
                }
            }

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
                print("serving start button");
                for(var i=0; i<tray_num; i++){
                    supervisor.setTray(i,traymodel.get(i).set_table);
                }
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
