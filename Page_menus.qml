import QtQuick 2.0

Item {
    id: page_menu
    objectName: "page_menus"
    width: 1280
    height: 800

    function init(){

    }

    Rectangle{
        id: status_bar
        width: parent.width
        height: 60
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        color: "white"
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
                    loadPage(pmap);
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
                    loadPage(psetting);
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
                            loadPage(pkitchen);
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
                        supervisor.programHide();
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
