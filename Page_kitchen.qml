import QtQuick 2.12
import QtQuick.Controls 2.12
import "."
import io.qt.Supervisor 1.0
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
            traymodel.append({x:0,y:0,tray_num:i+1,set_table:0,color:"white"});
        }
    }
    property int tray_num: 3
    property int table_num: 5
    property double battery: 0
    property string robotName: "test"
    property date curDate: new Date()
    property string curTime: curDate.toLocaleTimeString()

    property int tray_width: 400
    property int tray_height: 80
    property int spacing_tray : 10

    property int cur_table_num: 0
    property bool flag_moving: false

    property int rect_size: 70
    property int traybox_margin: 150
    property int tray_center: rect_table_box.width + traybox_margin + rect_tray_box.width/2

    property int cur_table: 0
    property bool go_wait: false
    property bool go_charge: false
    property int robotname_margin: rect_table_box.width/2 - textName.width/2

    Rectangle{
        anchors.fill : parent
        color: "#f4f4f4"
    }

    Rectangle{
        id: status_bar
        width: parent.width
        height: 60
        anchors.top: parent.top
        color: "white"
        Text{
            id: textName
            anchors.left: parent.left
            anchors.leftMargin: robotname_margin
            anchors.verticalCenter: parent.verticalCenter
            font.family: font_noto_r.name
            font.pixelSize: 20
            text: robotName
            onTextChanged: {
                robotname_margin = rect_table_box.width/2 - textName.width/2
            }
        }
        Text{
            id: textTime
            x: tray_center - width/2
            anchors.verticalCenter: parent.verticalCenter
            text: curTime
            font.family: font_noto_b.name
            font.pixelSize: 20
        }
        Image{
            id: image_clock
            source:"icon/clock.png"
            anchors.right: textTime.left
            anchors.rightMargin: 10
            anchors.verticalCenter: textTime.verticalCenter
        }

        Image{
            id: image_battery
            source: {
                if(battery > 90){
                    "icon/bat_full.png"
                }else if(battery > 60){
                    "icon/bat_3.png"
                }else if(battery > 30){
                    "icon/bat_2.png"
                }else{
                    "icon/bat_1.png"
                }
            }
            height: textBattery.height
            width: height*2
            anchors.verticalCenter: textBattery.verticalCenter
            anchors.right: textBattery.left
            anchors.rightMargin: 20
        }

        Text{
            id: textBattery
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 50
            color: "#7e7e7e"
            font.pixelSize: 20
            text: battery.toFixed(0)+' %'
        }
    }

    ListModel{
        id: traymodel
        ListElement{
            x: 0
            y: 0
            tray_num: 1
            set_table: 0
            color: "white"
        }
    }

    Image{
        id: image_head
        anchors.horizontalCenter: rect_tray_box.horizontalCenter
        anchors.bottom: rect_tray_box.top
        anchors.bottomMargin: 10
        width: 90*1.5
        height: 50*1.5
        source:"image/robot_head.png"
    }

    Rectangle{
        id: rect_tray_box
        width: 500
        height: tray_num*tray_height + (tray_num - 1)*spacing_tray + 50
        color: "#e8e8e8"
        radius: 30
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: rect_table_box.right
        anchors.leftMargin: traybox_margin
        Column{
            id: column_tray
            anchors.centerIn: parent
            spacing: 20
            Repeater{
                id: repeat_tray
                model: traymodel
                Rectangle{
                    id: rect_tray
                    width: tray_width
                    height: tray_height
                    color: "transparent"
                    radius:50
                    border.color: "#d0d0d0"
                    border.width: 1
                    onYChanged: {
                        model.y = y;
                    }

                    SequentialAnimation{
                        id: ani_tray
                        running: false
                        ParallelAnimation{
//                            NumberAnimation{target:rect_tray; property:"scale"; from:1;to:1.2;duration:300;}
                            NumberAnimation{target:rect_tray_fill; property:"scale"; from:1;to:1.2;duration:300;}
//                            NumberAnimation{target:rect_tray; property:"scale"; from:1.2;to:1;duration:300;}
                            NumberAnimation{target:rect_tray_fill; property:"scale"; from:1.2;to:1;duration:300;}
                        }
                    }
                    Rectangle{
                        id: rect_tray_fill
                        width: tray_width
                        height: tray_height
                        radius:50
                        color: model.color
                        border.color: model.color
                        border.width: 1
                        onColorChanged: {
                            if(color != "#0000ff"){
                                ani_tray.start()
                            }
                        }
                    }
                    Text{
                        id: text_cancel
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        color: "#525252"
                        visible: false
                        text:"cancel"
                    }
                    MouseArea{
                        id: tray_mousearea
                        anchors.fill: parent
                        property var firstX;
                        property var width_dis: 0
                        onPressed: {
                            firstX = mouseX;
                            width_dis = 0;
                        }
                        onReleased: {
                            if(width_dis > 50){
                                model.set_table = 0;
                                model.color =  "white"
                                cur_table = 0;
                            }else{
                                if(cur_table != 0){
                                    model.set_table = cur_table;
                                    model.color =  "#12d27c"
                                }

                            }
                            rect_tray_fill.width = rect_tray.width;
                            text_cancel.visible = false;
                            width_dis = 0;
                        }
                        onPositionChanged: {
                            width_dis = firstX-mouseX;

                            if(width_dis < 0)
                                width_dis = 0;

                            if(model.set_table != 0){
                                if(width_dis > 50){
                                    text_cancel.visible = true;
                                }else{
                                    text_cancel.visible = false;
                                }
                                rect_tray_fill.width = rect_tray.width - width_dis
                            }

                        }
                    }
                    Text{
                        id: textTray
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        font.pixelSize: (model.set_table==0)?25:30
                        font.bold: (model.set_table==0)?false:true
                        color: (model.set_table==0)?"#d0d0d0":"white"
                        text: (model.set_table==0)?"Tray "+Number(model.tray_num):Number(model.set_table)
                    }
                }

            }

        }

    }

    Rectangle{
        id: rect_table_box
        width: (table_num/5).toFixed(0)*100 - 20 + 160
        height: parent.height - status_bar.height
        anchors.left: parent.left
        anchors.top: status_bar.bottom
        color: "#282828"
        onWidthChanged: {
            robotname_margin = rect_table_box.width/2 - textName.width/2
        }

        Text{
            color:"white"
            font.bold: true
            font.family: font_noto_b.name
            text: "테이블 번호"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 40
            font.pixelSize: 30
        }
        Grid{
            id: grid_tables
            rows: 5
            columns: (table_num/5).toFixed(0)
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            flow: Grid.TopToBottom
            Repeater{
                id: column_table
                model: table_num
                Rectangle{
                    id: rect_table
                    width:80
                    height:80
                    radius:80
                    color: (index+1 == cur_table)?"#12d27c":"#d0d0d0"
                    Rectangle{
                        width:68
                        height:68
                        radius:68
                        color: "#f4f4f4"
                        anchors.centerIn: parent
                        Text{
                            anchors.centerIn: parent
                            text: index+1
                            color: "#525252"
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                        }
                    }
                    MouseArea{
                        anchors.fill:parent
                        onClicked: {
                            if(cur_table == index+1){
                                cur_table = 0;
                            }else{
                                cur_table = index+1;
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle{
        id: rect_go
        width: 300
        height: 100
        radius: 100
        anchors.horizontalCenter: rect_tray_box.horizontalCenter
        anchors.top: rect_tray_box.bottom
        anchors.topMargin: 40
        color: "#24a9f7"
        Text{
            id: text_go
            anchors.centerIn: parent
            text: "서빙 시작"
            font.family: font_noto_r.name
            font.pixelSize: 35
            font.bold: true
            color: "white"
        }
        MouseArea{
            id: btn_go
            anchors.fill: parent
            onClicked: {
                print("serving start button");
                cur_table = 0;
                for(var i=0; i<tray_num; i++){
                    supervisor.setTray(i,traymodel.get(i).set_table);
                }
            }
        }
    }

    property var size_menu: 100
    Rectangle{
        id: rect_menu_box
        width: 120
        height: width*3
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.top: status_bar.bottom
        anchors.topMargin: 50
        color: "white"
        radius: 30
        Column{
            spacing: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id: btn_menu
                width: size_menu
                height: size_menu
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Image{
                    source:"icon/btn_menu.png"
                    anchors.centerIn: parent
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            cur_table = 0;
                            stackview.push(pmenus);
                        }
                    }
                }
            }
            Rectangle{// 구분바
                width: rect_menu_box.width
                height: 3
                color: "#f4f4f4"
            }
            Rectangle{
                id: btn_charge
                width: size_menu
                height: size_menu
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    width: size_menu
                    height: image_charge.height+text_charge.height
                    anchors.centerIn: parent
                    Image{
                        id: image_charge
                        scale: 1.2
                        source:"icon/btn_charge.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        id: text_charge
                        text:"Charge"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: "#525252"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: image_charge.bottom
                        anchors.topMargin: 10
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        cur_table = 0;
                        go_charge = true;
                        popup_question.visible = true;
                    }
                }
            }
            Rectangle{// 구분바
                width: rect_menu_box.width
                height: 3
                color: "#f4f4f4"
            }
            Rectangle{
                width: size_menu
                height: size_menu
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    width: size_menu
                    height: image_wait.height+text_wait.height
                    anchors.centerIn: parent
                    Image{
                        id: image_wait
                        scale: 1.3
                        source:"icon/btn_wait.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        id: text_wait
                        text:"Ready"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: "#525252"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: image_wait.bottom
                        anchors.topMargin: 10
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        cur_table = 0;
                        go_wait = true;
                        popup_question.visible = true;
                    }
                }
            }
        }
    }


    Item{
        id: popup_question
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "#282828"
            opacity: 0.8
        }
        Image{
            id: image_location
            source:"image/image_location.png"
            width: 160
            height: 160
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 200
        }
        Text{
            id: text_quest
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:image_location.bottom
            anchors.topMargin: 30
            font.family: font_noto_b.name
            font.pixelSize: 40
            color: "#12d27c"
            text: {
                if(go_wait){
                    "대기 장소로 이동<font color=\"white\">하시겠습니까?</font>"
                }else if(go_charge){
                    "충전기로 이동<font color=\"white\">하시겠습니까?</font>"
                }else{
                    ""
                }
            }
        }
        Rectangle{
            id: btn_no
            width: 250
            height: 90
            radius: 20
            color: "#d0d0d0"
            anchors.top: text_quest.bottom
            anchors.topMargin: 50
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 20
            Image{
                id: image_no
                source: "icon/btn_no.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
            }
            Text{
                id:text_nono
                text:"아니오"
                font.family: font_noto_b.name
                font.pixelSize: 30
                color:"#282828"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: image_no.right
                anchors.leftMargin : (parent.width - image_no.x - image_no.width)/2 - text_nono.width/2
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    go_wait = false;
                    go_charge = false;
                    popup_question.visible = false;
                }
            }
        }
        Rectangle{
            id: btn_yes
            width: 250
            height: 90
            radius: 20
            color: "#d0d0d0"
            anchors.top: text_quest.bottom
            anchors.topMargin: 50
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 20
            Rectangle{
                color:"white"
                width: 240
                height: 80
                radius: 19
                anchors.centerIn: parent
            }
            Image{
                id: image_yes
                source: "icon/btn_yes.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
            }
            Text{
                text:"네"
                font.family: font_noto_b.name
                font.pixelSize: 30
                color:"#282828"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: image_yes.right
                anchors.leftMargin : (parent.width - image_yes.x - image_yes.width)/2 - width/2
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(go_wait){
                        supervisor.moveToWait();
                    }else if(go_charge){
                        supervisor.moveToCharge();
                    }
                    go_wait = false;
                    go_charge = false;
                    popup_question.visible = false;
                }
            }
        }
    }
}
