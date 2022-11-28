import QtQuick 2.0

Item {
    id: page_menu
    objectName: "page_menus"
    width: 1280
    height: 800

    function init(){

    }

    Rectangle{
        id: rect_kitchen
        width: 100
        height: 100
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 100
        color: "gray"
        Text{
            id: text_set
            anchors.centerIn: parent
            text: "kitchen"
        }
        MouseArea{
            id: btn_setting
            anchors.fill: parent
            onClicked: {
                stackview.pop();
            }
        }
    }
    Rectangle{
        id: rect_mapview
        width: 100
        height: 100
        anchors.top: rect_kitchen.top
        anchors.left: rect_kitchen.right
        anchors.leftMargin: 100
        color: "gray"
        Text{
            id: text_mapview
            anchors.centerIn: parent
            text: "MAP"
        }
        MouseArea{
            id: btn_mapview
            anchors.fill: parent
            onClicked: {
                stackview.push(pmapview);
            }
        }
    }
    Rectangle{
        id: rect_annot
        width: 100
        height: 100
        anchors.top: rect_kitchen.bottom
        anchors.topMargin: 50
        anchors.left: rect_kitchen.left
        color: "gray"
        Text{
            anchors.centerIn: parent
            text: "ANNOT"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                stackview.push(pannotation);
                pannotation.updatecanvas();
            }
        }
    }
    Rectangle{
        id: rect_curmap
        width: 100
        height: 100
        anchors.top: rect_mapview.top
        anchors.left: rect_mapview.right
        anchors.leftMargin: 100
        color: "gray"
        Text{
            id: text_curmap
            anchors.centerIn: parent
            text: "CUR MAP"
        }
        MouseArea{
            id: btn_curmap
            anchors.fill: parent
            onClicked: {
                stackview.push(pmap);
//                stackview.push(curMap);
            }
        }
    }

    Rectangle{
        id: rect_setting
        width: 100
        height: 100
        anchors.top: rect_curmap.top
        anchors.left: rect_curmap.right
        anchors.leftMargin: 100
        color: "gray"
        Text{
            id: text_sett
            anchors.centerIn: parent
            text: "SETTING"
        }
        MouseArea{
            id: btn_sett
            anchors.fill: parent
            onClicked: {
                stackview.push(psetting);
            }
        }
    }
}
