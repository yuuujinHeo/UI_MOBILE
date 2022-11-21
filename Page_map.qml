import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.12
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

    Row{
        id: menubar_map
        spacing: 25
    Repeater{
        model: ["load","save","record","run","stop"]
        Rectangle{
            id: btn
            width: 60
            height: 60
            color: "gray"
            radius: 10
            Image {
                id: image_icon
                anchors.centerIn:  parent
                antialiasing: true
                mipmap: true
                scale: {height>width?60/height:60/width}
                source: {
                    if(modelData == "load"){
                        "./build/icon/icon_folder2.png"
                    }else if(modelData == "save"){
                        "./build/icon/icon_save2.png"
                    }else if(modelData == "record"){
                        "./build/icon/icon_record.png"
                    }else if(modelData == "run"){
                        "./build/icon/icon_play.png"
                    }else if(modelData == "stop"){
                        "./build/icon/icon_stop.png"
                    }else if(modelData == "pause"){
                        "./build/icon/icon_pause.png"
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    print(modelData);
                    if(modelData == "load"){
                        pathload.open();
                    }else if(modelData == "save"){
                        pathsave.open();
                    }else if(modelData == "record"){
                        supervisor.startRecordPath();
                    }else if(modelData == "run"){
                        supervisor.startcurPath();
                        modelData = "pause";
                    }else if(modelData == "stop"){
                        supervisor.stopcurPath();
                    }else if(modelData == "pause"){
                        modelData = "run";

                    }
                }
            }
        }
    }
    }

    FileDialog{
        id: pathload
        folder: "file:"+applicationDirPath+"/path"
        property variant pathlist
        property string path : ""
        fileMode: FileDialog.OpenFile
        nameFilters: ["*.ini"]
        onAccepted: {
            print(pathload.file.toString());
            pathlist = pathload.file.toString().split("/");
            path = "./build/path/" + pathlist[9];
            print(path);
        }
    }

    FileDialog{
        id: pathsave
        fileMode: FileDialog.SaveFile
        property variant pathlist
        property string path : ""
        folder: "file:"+applicationDirPath+"/path"
        onAccepted: {
            print(pathsave.file.toString())
            pathlist = pathsave.file.toString().split('/');
            print(pathlist[9]);
        }
    }

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
    Rectangle{
        id: rect_manual_on
        width: 100
        height: 100
        anchors.top: pMap_joy.bottom
        anchors.topMargin: 100
        anchors.left: pMap_joy.left
        anchors.leftMargin: 60
        color: "gray"
        Text{
            text: "manual on"
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                supervisor.moveManual();
            }
        }
    }
    Rectangle{
        id: rect_manual_off
        width: 100
        height: 100
        anchors.top: pMap_joy.bottom
        anchors.topMargin: 100
        anchors.left: rect_manual_on.right
        anchors.leftMargin: 30
        color: "gray"
        Text{
            text: "stop"
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                supervisor.moveStop();
            }
        }
    }
    Rectangle{
        id: rect_pop
        width: 100
        height: 100
        anchors.top: pMap_joy.bottom
        anchors.topMargin: 100
        anchors.left: rect_manual_off.right
        anchors.leftMargin: 30
        color: "gray"
        Text{
            text: "back"
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
