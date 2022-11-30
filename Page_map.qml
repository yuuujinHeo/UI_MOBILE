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
    property bool isrun: false

    function updatepath(){
        pMap_curmap.updatepath();
    }


    function loadmap(path){
        pMap_curmap.loadmap(path);
        supervisor.joyMoveXY(0, 0);
        supervisor.joyMoveR(0, 0);
    }

    Row{
        id: menubar_map
        spacing: 25
    Repeater{
        model: ["load","save","record","run","stop","manual","back"]
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
                    }else if(modelData == "manual"){
                        "./build/icon/icon_pause.png"
                    }else if(modelData == "manualon"){
                        "./build/icon/icon_stop.png"
                    }else if(modelData == "back"){
                        "./build/icon/icon_pause.png"
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    if(modelData == "load"){
                        pathload.open();
                    }else if(modelData == "save"){
                        pathsave.open();
                    }else if(modelData == "record"){
                        supervisor.startRecordPath();
                    }else if(modelData == "run"){
//                        supervisor.startcurPath();
//                        modelData = "pause";
                        supervisor.runRotateTables();
                    }else if(modelData == "stop"){
                        supervisor.stopRotateTables();
//                        supervisor.stopcurPath();
                    }else if(modelData == "pause"){
                        modelData = "run";
                    }else if(modelData == "manual"){
                        supervisor.moveManual();
                        modelData = "manualon";
                    }else if(modelData == "manualon"){
                        supervisor.moveStop();
                        modelData = "manual";
                    }else if(modelData == "back"){
                        stackview.pop();
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
        id: joy_xy
        anchors.right: pMap_curmap.left
        anchors.rightMargin: 100
        anchors.verticalCenter: parent.verticalCenter
        verticalOnly: true
        onUpdate_cntChanged: {
            if(update_cnt == 0){
                supervisor.joyMoveXY(0, 0);
            }else{
                if(fingerInBounds) {
                    supervisor.joyMoveXY(Math.sin(angle) * Math.sqrt(fingerDistance2) / distanceBound);
                }else{
                    supervisor.joyMoveXY(Math.sin(angle));
                }
            }
        }
    }

    Item_joystick{
        id: joy_th
        anchors.left: pMap_curmap.right
        anchors.leftMargin: 100
        anchors.verticalCenter: parent.verticalCenter
        horizontalOnly: true
        onUpdate_cntChanged: {
            if(update_cnt == 0){
                supervisor.joyMoveR(0, 0);
            }else{
                if(fingerInBounds) {
                    supervisor.joyMoveR(-Math.cos(angle) * Math.sqrt(fingerDistance2) / distanceBound);
                } else {
                    supervisor.joyMoveR(-Math.cos(angle));
                }
            }
        }
    }
    Map_current{
        id: pMap_curmap
        anchors.centerIn: parent
    }
}
