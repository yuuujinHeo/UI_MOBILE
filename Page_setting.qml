import QtQuick 2.12
import QtQuick.Controls 2.12
import "."
import io.qt.Supervisor 1.0

Item {
    id: page_setting
    objectName: "page_setting"
    width: 1280
    height: 800

    property int select_category: 1
    property string platform_name: supervisor.getRobotName()
    property string debug_platform_name: ""
    property bool is_debug: false
    Rectangle{
        width: parent.width
        height: parent.height-statusbar.height
        anchors.bottom: parent.bottom
        color: "#f4f4f4"

        //카테고리 바
        Row{
            spacing: 5
            Rectangle{
                width: 264
                height: 40
                color: "#323744"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "Setting"
                    font.pixelSize: 20
                }
            }
            Rectangle{
                id: rect_category_1
                width: 264
                height: 40
                color: "#647087"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "Robot"
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                       select_category = 1;
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 7
                    visible: select_category==1?true:false
                    color: "#12d27c"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                }
            }
            Rectangle{
                id: rect_category_2
                width: 264
                height: 40
                color: "#647087"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "Map"
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                       select_category = 2;
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 7
                    visible: select_category==2?true:false
                    color: "#12d27c"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                }
            }
        }

        Flickable{
            id: area_setting_robot
            visible: select_category==1?true:false
            width: 880
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 120
            height: parent.height - 200
            contentHeight: column_setting.height
            clip: true
            ScrollBar.vertical: ScrollBar{
                width: 20
                anchors.right: parent.right
                policy: ScrollBar.AlwaysOn
            }
            Column{
                id:column_setting
                width: parent.width
                spacing:25
                Rectangle{
                    id: set_robot_1
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"플랫폼 이름(*영문)"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            TextField{
                                id: textfield_name
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.leftMargin: 30
                                width: parent.width*0.8

                                height: parent.height
                                placeholderText: qsTr(platform_name)
                                font.pointSize: 15
                                font.family: font_noto_r.name
                            }
                        }
                    }
                }

                Rectangle{
                    id: set_robot_2
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"플랫폼 타입"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_platform_type
                                anchors.fill: parent
                                model:["서빙용","호출용"]
                            }
                        }
                    }
                }

                Rectangle{
                    id: set_robot_3
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"이동 속도"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            Slider{
                                id: slider_vxy
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width*0.8
                                height: 40
                                from: 0
                                to: 1
                                value: supervisor.getVelocity()
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_robot_4
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"음성 안내"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_use_voice
                                anchors.fill: parent
                                model:["사용 안함","사용"]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_robot_5
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"이동 시 음악 재생"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_use_bgm
                                anchors.fill: parent
                                model:["사용 안함","사용"]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_robot_6
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"서버 명령 사용"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_use_servercmd
                                anchors.fill: parent
                                model:["사용 안함","사용"]
                            }
                        }
                    }
                }
            }
        }

        Flickable{
            id: area_setting_map
            visible: select_category==2?true:false
            width: 880
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 120
            height: parent.height - 200
            contentHeight: column_setting2.height
            clip: true
            ScrollBar.vertical: ScrollBar{
                width: 20
                anchors.right: parent.right
                policy: ScrollBar.AlwaysOn
            }
            Column{
                id:column_setting2
                width: parent.width
                spacing:25
                Rectangle{
                    id: set_map_1
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"트래블 라인"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_use_travelline
                                anchors.fill: parent
                                model:["사용 안함","사용"]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_map_2
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"트래블 라인 지정"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_travelline
                                anchors.fill: parent
                                model:ListModel{}
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_map_3
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"트레이 개수"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_tray_num
                                anchors.fill: parent
                                model:[1,2,3,4,5]
                            }
                        }
                    }

                }
                Rectangle{
                    id: set_map_4
                    width: 840
                    height: 40
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: 350
                            height: parent.height
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 50
                                font.family: font_noto_r.name
                                text:"테이블 개수"
                                font.pixelSize: 20
                            }
                        }
                        Rectangle{
                            width: 1
                            height: parent.height
                            color: "#d0d0d0"
                        }
                        Rectangle{
                            width: parent.width - 351
                            height: parent.height
                            ComboBox{
                                id: combo_table_num
                                anchors.fill: parent
                                model:30
//                                model:[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]

                            }
                        }
                    }
                }
            }
        }

        Rectangle{
            id: btn_menu
            width: 120
            height: width
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.top: parent.top
            anchors.topMargin: 50
            color: "transparent"
            radius: 30
            Behavior on width{
                NumberAnimation{
                    duration: 500;
                }
            }
            Image{
                id: image_btn_menu
                source:"icon/btn_reset2.png"
                scale: 1-(120-parent.width)/120
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    backPage();
                }
            }
        }

        Column{
            anchors.bottom: area_setting_robot.bottom
            anchors.right: parent.right
            anchors.rightMargin: (parent.width - area_setting_robot.width - area_setting_robot.x - btn_default.width)/2
            spacing: 30
            Rectangle{
                id: btn_default
                width: 180
                height: 60
                radius: 10
                color:"transparent"
                border.width: 1
                border.color: "#7e7e7e"
                Text{
                    anchors.centerIn: parent
                    text: "Default"
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        init();
                    }
                }
            }
            Rectangle{
                id: btn_confirm
                width: 180
                height: 60
                radius: 10
                color: "#12d27c"
                border.width: 1
                border.color: "#12d27c"
                Text{
                    anchors.centerIn: parent
                    text: "Confirm"
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                    color: "white"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        supervisor.setRobotName(textfield_name.text);
                        supervisor.setVelocity(slider_vxy.value);
                        supervisor.setRobotType(combo_platform_type.currentIndex);
                        if(combo_use_travelline.currentIndex == 0)
                            supervisor.setuseTravelline(false);
                        else
                            supervisor.setuseTravelline(true);

                        supervisor.setnumTravelline(combo_travelline.currentIndex);

                        supervisor.setTrayNum(combo_tray_num.currentIndex+1);
                        supervisor.setTableNum(combo_table_num.currentIndex);

                        if(combo_use_voice.currentIndex == 0)
                            supervisor.setuseVoice(false);
                        else
                            supervisor.setuseVoice(true);

                        if(combo_use_bgm.currentIndex == 0)
                            supervisor.setuseBGM(false);
                        else
                            supervisor.setuseBGM(true);

                        if(combo_use_servercmd.currentIndex == 0)
                            supervisor.setserverCMD(false);
                        else
                            supervisor.setserverCMD(true);

                        supervisor.readSetting();

                        init();
                    }
                }
            }
        }

    }
    Component.onCompleted: {
        init();
    }

    function init(){
        textfield_name.text = supervisor.getRobotName();
        slider_vxy.value = supervisor.getVelocity();
        if(supervisor.getRobotType() == "SERVING"){
            combo_platform_type.currentIndex = 0;
        }else{
            combo_platform_type.currentIndex = 1;
        }
        if(supervisor.getuseTravelline()){
            combo_use_travelline.currentIndex = 1;
        }else{
            combo_use_travelline.currentIndex = 0;
        }

        var num_tline = supervisor.getTlineSize();
        print(num_tline);
        for(var i=0; i<num_tline; i++){
            combo_travelline.model.append({i});
        }

        combo_travelline.currentIndex = supervisor.getnumTravelline();
        combo_tray_num.currentIndex = supervisor.getTrayNum()-1;
        combo_table_num.currentIndex = supervisor.getTableNum();

        if(supervisor.getuseVoice()){
            combo_use_voice.currentIndex = 1;
        }else{
            combo_use_voice.currentIndex = 0;
        }
        if(supervisor.getuseBGM()){
            combo_use_bgm.currentIndex = 1;
        }else{
            combo_use_bgm.currentIndex = 0;
        }
        if(supervisor.getserverCMD()){
            combo_use_servercmd.currentIndex = 1;
        }else{
            combo_use_servercmd.currentIndex = 0;
        }

    }


    Timer{
        running: true
        interval: 1000
        repeat: true
        onTriggered: {
//            if(is_debug != supervisor.getDebugState()){
//                supervisor.setDebugState(is_debug);
//            }
//            if(debug_platform_name != supervisor.getDebugName()){
//                supervisor.setDebugName(debug_platform_name);
//            }
        }
    }





}
