import QtQuick 2.0

Item {
    id: page_menu
    objectName: "page_menus"
    width: 1280
    height: 800

    property string robotName: "test"
    property double battery: 0
    property date curDate: new Date()
    property string curTime: curDate.toLocaleTimeString()
    property int robotname_margin: 300
    property int tray_center: 700
    function init(){

    }

    Rectangle{
        id: status_bar
        width: parent.width
        height: 60
        anchors.horizontalCenter: parent.horizontalCenter
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

    Rectangle{
        id: rect_background
        width: parent.width
        height: parent.height - status_bar.height
        anchors.top: status_bar.bottom
        color: "#282828"

        Text{
            id: text_menu
            text: "MENU"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 150
            font.family: font_noto_r.name
            font.pixelSize: 40
            color:"white"
        }

        Image{
            id: rect_map
            width: 301
            height: 301
            anchors.top: text_menu.bottom
            anchors.topMargin: 50
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 30
            source: "icon/btn_map.png"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    pmap.init();
                    stackview.push(pmap);
                }
            }
        }

        Image{
            id: rect_setting
            width: 301
            height: 301
            anchors.top: text_menu.bottom
            anchors.topMargin: 50
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 30
            source: "icon/btn_setting.png"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    psetting.uiupdate();
                    stackview.push(psetting);
                }
            }
        }

//tangle{
//            id: rect_annot
//            width: 100
//            height: 100
//            anchors.top: rect_kitchen.bottom
//            anchors.topMargin: 50
//            anchors.left: rect_kitchen.left
//            color: "gray"
//            Text{
//                anchors.centerIn: parent
//                text: "ANNOT"
//            }
//            MouseArea{
//                anchors.fill: parent
//                onClicked: {
//                    pannotation.init();
//                    stackview.push(pannotation);
//                }
//            }
//        }


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
                            pkitchen.init();
                            stackview.pop();
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
                id: btn_minimize
                width: size_menu
                height: size_menu
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    width: size_menu
                    color: "transparent"
                    height: image_charge.height+text_charge.height
                    anchors.centerIn: parent
                    Image{
                        id: image_charge
                        scale: 1.2
                        source:"icon/btn_minimize.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        id: text_charge
                        text:"Minimize"
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        horizontalAlignment: Text.AlignHCenter
                        color: "#525252"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: image_charge.bottom
                        anchors.topMargin: 10
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mainwindow.showMinimized()
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
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    width: size_menu
                    color: "transparent"
                    height: image_wait.height+text_wait.height
                    anchors.centerIn: parent
                    Image{
                        id: image_wait
                        scale: 1.2
                        source:"icon/icon_power.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        id: text_wait
                        text:"OFF"
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
                        supervisor.programExit();
                    }
                }
            }
        }
    }
}
