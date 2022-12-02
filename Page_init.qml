import QtQuick 2.12
import QtQuick.Controls 2.12
import "."
import io.qt.Supervisor 1.0

Item {
    id: page_init
    objectName: "page_init"
    width: 1280
    height: 800

    property string map_path: "file://" + applicationDirPath + "/image/map_rotated.png"

    function check_timer(){
        btn_server_load.enabled = false;
        btn_usb_load.enabled = false;
        notice_map_edited.enabled = false;
        notice_map_raw.enabled = false;
        popup_show_map.show_mode = 0;
        update_timer.start();
    }

    function loadmapall(map_path){
        pmap.loadmap(map_path);
        pmovefail.loadmap(map_path);
    }

    Image{
        id: image_logo
        width: 748/2
        height: 335/2
        anchors.top: parent.top
        anchors.topMargin: 80
        anchors.horizontalCenter: parent.horizontalCenter
        source: Qt.resolvedUrl("qrc:/image/rainbow3.png")
    }

    Text{
        id: text_notice
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: image_logo.bottom
        anchors.topMargin: 100
        text: "맵 파일을 찾을 수 없습니다.";
        font.pixelSize: 20
    }

    Row{
        spacing: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: text_notice.bottom
        anchors.topMargin: 200
        Rectangle{
            id: btn_server_load
            width: 200
            height: 150
            radius: 15
            color: enabled?"gray":"#DDDDDD"
            Text{
                anchors.centerIn: parent
                text: "서버에서 받아오기"
                font.pixelSize: 20
                color:enabled?"black":"white"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    supervisor.loadMaptoServer();
                    update_timer.start();
                }
            }
        }
        Rectangle{
            id: btn_slam_start
            width: 200
            height: 150
            radius: 15
            color: enabled?"gray":"#DDDDDD"
            Text{
                anchors.centerIn: parent
                text: "맵 생성"
                font.pixelSize: 20
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    supervisor.startSLAM();
                }
            }
        }
        Rectangle{
            id: btn_usb_load
            width: 200
            height: 150
            radius: 15
            color: enabled?"gray":"#DDDDDD"
            Text{
                anchors.centerIn: parent
                text: "로컬 맵 불러오기\n(USB)"
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                color:enabled?"black":"white"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    supervisor.loadMaptoUSB();
                    update_timer.start();
                }
            }
        }
    }

    Rectangle{
        id: notice_map_edited
        width: 180
        height: 50
        color: "red"
        anchors.right: parent.right
        visible: (y<300)?true:false
        y: enabled?200:800
        Behavior on y{
            SpringAnimation{
                duration: 1000
                spring: 1
                damping: 0.2
            }
        }

        Rectangle{
            width: 40
            height: parent.height
            radius: 10
            anchors.horizontalCenter: parent.left
            anchors.verticalCenter: parent.verticalCenter
            color: parent.color

            Image{
                width: 30
                height: 30
                anchors.centerIn: parent
                source: "image/warning.png"
            }
        }
        Text{
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 30
            color: "white"
            text: "로컬 맵 파일 확인됨"
            font.bold: true
            font.pixelSize: 15
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                popup_show_map.show_mode = 1;
                popup_show_map.open();
            }
        }
    }
    Rectangle{
        id: notice_map_raw
        width: 180
        height: 50
        color: "red"
        anchors.right: parent.right
        visible: (y<400)?true:false
        y: enabled?300:800
        Behavior on y{
            SpringAnimation{
                duration: 1000
                spring: 1
                damping: 0.2
            }
        }

        Rectangle{
            width: 40
            height: parent.height
            radius: 10
            anchors.horizontalCenter: parent.left
            anchors.verticalCenter: parent.verticalCenter
            color: parent.color

            Image{
                width: 30
                height: 30
                anchors.centerIn: parent
                source: "image/warning.png"
            }
        }
        Text{
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 30
            color: "white"
            text: "설정되지 않은 맵 파일 확인됨"
            font.bold: true
            font.pixelSize: 10
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                popup_show_map.show_mode = 2;
                popup_show_map.open();
            }
        }
    }

    Timer{
        id: update_timer
        interval: 1000
        running: false
        triggeredOnStart: true
        repeat: true
        onTriggered: {
            var map_exist = supervisor.isExistMap();
            if(supervisor.isloadMap()){
                print("loadmap true");
                if(supervisor.isuseServerMap()){
                    map_path = "file://" + applicationDirPath + "/image/map_rotated.png";
                    loadmapall(map_path);
                    pkitchen.init();
                    stackview.push(pkitchen);
                }else{
                    map_path = "file://" + applicationDirPath + "/image/map_edited.png";
                    loadmapall(map_path);
                    pkitchen.init();
                    stackview.push(pkitchen);
                }
                update_timer.stop();
            }else{
                if(map_exist == 1){
                    //Map Exist!!!!
                    print("map find!!");
                    notice_map_raw.enabled = false;
                    notice_map_edited.enabled = false;
                    popup_show_map.show_mode = 0;
                    popup_show_map.open();
                    update_timer.stop();
                }else{
                    btn_server_load.enabled = supervisor.isConnectServer();
                    btn_usb_load.enabled = supervisor.isUSBFile();
                    if(map_exist== 2){
                        //show map_edited exist
                        notice_map_edited.enabled = true;
                        notice_map_raw.enabled = false;
                    }else if(map_exist == 3){
                        //show raw_map exist
                        notice_map_raw.enabled = true;
                        notice_map_edited.enabled = false;
                    }else{
                        notice_map_raw.enabled = false;
                        notice_map_edited.enabled = false;
                    }
                }
            }

        }
    }

    Popup{
        id: popup_show_map
        width: 800
        height: 800
        anchors.centerIn: parent
        Rectangle{
            id: rect_back
            anchors.fill:parent
            color: "#DFDFDF"
        }
        closePolicy: Popup.NoAutoClose
        property int show_mode: 0 //0: server 1: edited 2: raw
        onOpened: {
            update_timer.stop();
            if(show_mode == 0){
                text_show_popup.text = "서버로부터 맵을 로드했습니다. 매장의 환경과 일치하는 맵인지 확인해주세요."
                map_view.show_meta_data = true;
                map_view.loadmap("file://"+applicationDirPath+"/image/map_rotated.png");
            }else if(show_mode == 1){
                text_show_popup.text = "저장된 맵을 로드했습니다. 매장의 환경과 일치하는 맵인지 확인해주세요.\n 맵이 일치하지 않다면 [맵 삭제] 버튼을, 오브젝트나 로케이션을 수정하길 원하시면 [맵 수정] 버튼을 눌러주세요."
                map_view.show_meta_data = true;
                map_view.loadmap("file://"+applicationDirPath+"/image/map_edited.png");
            }else{
                text_show_popup.text = "저장된 맵을 로드했습니다. 매장의 환경과 일치하는 맵이면 [맵 수정] 버튼을, 일치하지 않다면 [맵 삭제] 버튼을 눌러주세요.";
                map_view.show_meta_data = false;
                map_view.loadmap("file://"+applicationDirPath+"/image/map_raw.png");
            }
        }
        Text{
            id: text_show_popup
            anchors.horizontalCenter: rect_back.horizontalCenter
            anchors.top: rect_back.top
            anchors.topMargin: 30
            text: "서버로부터 맵을 로드했습니다. 매장의 환경과 일치하는 맵인지 확인해주세요."
            color: "black"
        }

        Map_current{
            id: map_view
            width: 550
            height: 550
            anchors.horizontalCenter: rect_back.horizontalCenter
            anchors.top: text_show_popup.bottom
            anchors.topMargin: 30
        }
        Row{
            id: row_button_2
            anchors.horizontalCenter: rect_back.horizontalCenter
            anchors.top: map_view.bottom
            anchors.topMargin: 30
            spacing: 30
            Repeater{
                model:{
                    if(popup_show_map.show_mode == 0){
                        ["맵 사용","맵 사용안함"]
                    }else if(popup_show_map.show_mode == 1){
                        ["맵 사용","맵 수정","맵 삭제"]
                    }else if(popup_show_map.show_mode == 2){
                        ["맵 수정","맵 삭제"]
                    }
                }
                Rectangle{
                    id: btn
                    width: 100
                    height: 80
                    radius: 15
                    color: "gray"
                    Text{
                        anchors.centerIn: parent
                        text: modelData
                        font.pixelSize: 20
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(modelData == "맵 사용"){
                                if(popup_show_map.show_mode == 0){
                                    popup_show_map.close();
                                    supervisor.setuseServerMap(true);
                                    map_path = "file://" + applicationDirPath + "/image/map_rotated.png";
                                    loadmapall(map_path);
                                    supervisor.setloadMap(true);
                                    pkitchen.init();
                                    stackview.push(pkitchen);
                                }else{
                                    popup_show_map.close();
                                    supervisor.setuseServerMap(false);
                                    map_path = "file://" + applicationDirPath + "/image/map_edited.png";
                                    loadmapall(map_path);
                                    supervisor.setloadMap(true);
                                    pkitchen.init();
                                    stackview.push(pkitchen);
                                }
                            }else if(modelData == "맵 수정"){
                                if(popup_show_map.show_mode == 1){
                                    popup_show_map.close();
                                    map_path = "file://" + applicationDirPath + "/image/map_edited.png";
                                    pannotation.loadmap(map_path);
                                    stackview.push(pannotation);
                                }else if(popup_show_map.show_mode == 2){
                                    popup_show_map.close();
                                    map_path = "file://" + applicationDirPath + "/image/map_raw.png";
                                    pannotation.loadmap(map_path);
                                    stackview.push(pannotation);
                                }
                            }else if(modelData == "맵 삭제"){
                                if(popup_show_map.show_mode == 1){
                                    supervisor.removeEditedMap();
                                    popup_show_map.close();
                                    update_timer.start();
                                }else{
                                    supervisor.removeRawMap();
                                    popup_show_map.close();
                                    update_timer.start();
                                }
                            }else if(modelData == "맵 사용안함"){
                                supervisor.removeServerMap();
                                popup_show_map.close();
                                update_timer.start();
                            }
                        }
                    }
                }
            }


        }
    }

}
