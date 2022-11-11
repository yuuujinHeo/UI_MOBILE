import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0
import "."
import io.qt.Supervisor 1.0
import QtQml 2.2

Item {
    id: page_map
    objectName: "page_map"
    width: 1280
    height: 800

    Item_joystick{
        id: pMap_joy
        anchors.left: pMap_curmap.right
        anchors.leftMargin: 100
        anchors.verticalCenter: parent.verticalCenter
    }

    Map_current{
        id: pMap_curmap
        anchors.left:parent.left
        anchors.leftMargin: 50
        anchors.top:parent.top
        anchors.topMargin: 100
    }

}
