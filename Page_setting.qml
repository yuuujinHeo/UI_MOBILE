import QtQuick 2.9
import QtQuick.Window 2.9
import QtQuick.Controls 2.9

Item {
    id: page_setting
    objectName: "page_setting"
    width: 1280
    height: 800

    Rectangle{
        width: 100
        height: 100
        color: "gray"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                stackview.pop();
            }
        }
    }
    property var rect_height: 70
    property string platform_name: supervisor.getRobotName()
    property string debug_platform_name: ""
    property bool is_debug: false

    function uiupdate(){
        textfield_name.text = supervisor.getRobotName();
        slider_vxy.value = supervisor.getVelocityXY();
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
        combo_table_num.currentIndex = supervisor.getTableNum()-1;

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

    Flickable{
        y: 150
        width: parent.width
        height: parent.height - y - 100
        contentHeight: column_setting.height
        clip: true
        ScrollBar.vertical: ScrollBar{
            width: 30
            anchors.right: parent.right
            policy: ScrollBar.AlwaysOn
        }

        Column{
            id:column_setting
            width: parent.width
            spacing:25

            Rectangle{
                id: set_platform_name
                width: parent.width
                height: rect_height
                color: "yellow"
                Text{
                    anchors.left: parent.left
                    anchors.leftMargin: 250
                    font.pixelSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                    text: "플랫폼 이름(반드시 영어) : "
                }
                TextField{
                    id: textfield_name
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 200
                    width: 300
                    height: rect_height - 10
                    placeholderText: qsTr(platform_name)
                    font.pointSize: 20
                }
            }
            Rectangle{
                id: set_velocity
                width: parent.width
                height: rect_height
                color: "yellow"
                Text{
                    anchors.left: parent.left
                    anchors.leftMargin: 250
                    font.pixelSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                    text: "로봇 이동속도 : "
                }
                Slider{
                    id: slider_vxy
                    anchors.right: parent.right
                    anchors.rightMargin: 200
                    anchors.verticalCenter: parent.verticalCenter
                    width: 300
                    height: 50
                    from: 0
                    to: 1
                    value: supervisor.getVelocityXY()
                }
            }
            Rectangle{
                id: set_platform_type
                width: parent.width
                height: rect_height
                color: "yellow"
                Text{
                    anchors.left: parent.left
                    anchors.leftMargin: 250
                    font.pixelSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                    text: "플랫폼 타입 : "
                }
                ComboBox{
                    id: combo_platform_type
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 200
                    height: rect_height-10
                    width: 300
                    model:["서빙용","호출용"]
                }
            }
            Rectangle{
                id: set_use_travelline
                width: parent.width
                height: rect_height
                color: "yellow"
                Text{
                    anchors.left: parent.left
                    anchors.leftMargin: 250
                    font.pixelSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                    text: "트래블 라인 : "
                }
                ComboBox{
                    id: combo_use_travelline
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 200
                    height: rect_height-10
                    width: 300
                    model:["사용 안함","사용"]
                }
            }
            Rectangle{
                id: set_travelline
                width: parent.width
                height: rect_height
                color: "yellow"
                Text{
                    anchors.left: parent.left
                    anchors.leftMargin: 250
                    font.pixelSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                    text: "트래블 라인 지정 : "
                }
                ComboBox{
                    id: combo_travelline
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 200
                    height: rect_height-10
                    width: 300
                    model:ListModel{}
                }
            }
            Rectangle{
                id: set_tray_num
                width: parent.width
                height: rect_height
                color: "yellow"
                Text{
                    anchors.left: parent.left
                    anchors.leftMargin: 250
                    font.pixelSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                    text: "트레이 개수 : "
                }
                ComboBox{
                    id: combo_tray_num
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 200
                    height: rect_height-10
                    width: 300
                    model:[1,2,3,4,5]
                }
            }
            Rectangle{
                id: set_table_num
                width: parent.width
                height: rect_height
                color: "yellow"
                Text{
                    anchors.left: parent.left
                    anchors.leftMargin: 250
                    font.pixelSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                    text: "테이블 개수 : "
                }
                ComboBox{
                    id: combo_table_num
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 200
                    height: rect_height-10
                    width: 300
                    model:[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
                }
            }
            Rectangle{
                id: set_use_voice
                width: parent.width
                height: rect_height
                color: "yellow"
                Text{
                    anchors.left: parent.left
                    anchors.leftMargin: 250
                    font.pixelSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                    text: "음성 안내 : "
                }
                ComboBox{
                    id: combo_use_voice
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 200
                    height: rect_height-10
                    width: 300
                    model:["사용 안함","사용"]
                }
            }

            Rectangle{
                id: set_use_bgm
                width: parent.width
                height: rect_height
                color: "yellow"
                Text{
                    anchors.left: parent.left
                    anchors.leftMargin: 250
                    font.pixelSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                    text: "이동 시 음악 재생 : "
                }
                ComboBox{
                    id: combo_use_bgm
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 200
                    height: rect_height-10
                    width: 300
                    model:["사용 안함","사용"]
                }
            }
            Rectangle{
                id: set_use_servercmd
                width: parent.width
                height: rect_height
                color: "yellow"
                Text{
                    anchors.left: parent.left
                    anchors.leftMargin: 250
                    font.pixelSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                    text: "서버 명령 사용 : "
                }
                ComboBox{
                    id: combo_use_servercmd
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 200
                    height: rect_height-10
                    width: 300
                    model:["사용 안함","사용"]
                }
            }
            Rectangle{
                id: set_debug_name
                width: parent.width
                height: rect_height
                color: "yellow"
                Text{
                    id: text_dd
                    anchors.left: parent.left
                    anchors.leftMargin: 250
                    font.pixelSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Debug : " + debug_platform_name
                }
                Rectangle{
                    width: rect_height
                    height: rect_height
                    anchors.left: text_dd.right
                    anchors.leftMargin: 200
                    color: is_debug?"blue":"gray"
                    Text{
                        anchors.centerIn: parent
                        text: is_debug?"OFF":"ON"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            is_debug = !is_debug;
                            debug_platform_name = textfield_debug.text
                        }
                    }
                }
                TextField{
                    id: textfield_debug
                    width: 100
                    height: rect_height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 200
                    placeholderText: "(debug name)"
                    text: "C1"
                    font.pointSize: 20

                }
            }
        }

    }


    Timer{
        running: true
        interval: 1000
        repeat: true
        onTriggered: {
            if(is_debug != supervisor.getDebugState()){
                supervisor.setDebugState(is_debug);
            }
            if(debug_platform_name != supervisor.getDebugName()){
                supervisor.setDebugName(debug_platform_name);
            }
        }
    }


    Rectangle{
        id: rect_confirm
        width: 100
        height: 80
        color: "gray"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: 50
        Text{
            anchors.centerIn: parent
            font.pixelSize: 30
            text: "confirm"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                supervisor.setRobotName(textfield_name.text);
                supervisor.setVelocity(slider_vxy.value);
                supervisor.setRobotType(combo_platform_type.currentIndex);

                if(combo_use_travelline.currentIndex == 0)
                    supervisor.setuseTravelline(false);
                else
                    supervisor.setuseTravelline(true);

                supervisor.setnumTravelline(combo_travelline.currentIndex);

                supervisor.setTrayNum(combo_tray_num.currentIndex+1);
                supervisor.setTableNum(combo_table_num.currentIndex+1);

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

                uiupdate();
            }
        }
    }


    Rectangle{
        id: rect_default
        width: 100
        height: 80
        color: "gray"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: 50
        Text{
            anchors.centerIn: parent
            font.pixelSize: 30
            text: "default"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                uiupdate();
            }
        }
    }
}
