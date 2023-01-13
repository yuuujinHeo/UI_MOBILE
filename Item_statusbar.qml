import QtQuick 2.12
import QtQuick.Controls 2.12
import "."
import io.qt.Supervisor 1.0

Item {
    id: item_statusbar
    width: parent.width
    height: 60

    property date curDate: new Date()
    property string curTime: curDate.toLocaleTimeString()

    property bool is_con_joystick: false
    property bool is_con_server: false
    property bool is_con_robot: false
    property bool robot_tx: false
    property bool robot_rx: false



    Rectangle{
        id: status_bar
        width: parent.width
        height: 60
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        color: "white"
        Text{
            id: textName
            width: margin_name
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family: font_noto_r.name
            font.pixelSize: 20
            text: robot_name
            MouseArea{
                anchors.fill: parent
                onPressAndHold: {
                    popup_menu.open();
                }
            }
        }
        Text{
            id: textTime
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: curTime
            font.family: font_noto_b.name
            font.pixelSize: 20
        }
        Image{
            id: image_clock
            source:"icon/clock.png"
            anchors.right: textTime.left
            anchors.rightMargin: 5
            anchors.verticalCenter: textTime.verticalCenter
        }

        Row{
            id: rows_icon
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 30
            spacing: 5
            Image{
                id: image_joystick
                visible: is_con_joystick
                sourceSize.width: 46
                sourceSize.height: 42
                source: "icon/icon_joy_connect.png"
            }
            Image{
                id: image_server
                visible: is_con_server
                sourceSize.width: 46
                sourceSize.height: 42
                source: "icon/icon_server_connect.png"
            }
            Image{
                id: image_robot_discon
                visible: !is_con_robot
                sourceSize.width: 46
                sourceSize.height: 42
                source: "icon/icon_connect_error.png"
            }
            Rectangle{
                color: "transparent"
                width: 46
                height: 42
                visible: is_con_robot
                anchors.verticalCenter: parent.verticalCenter
                Row{
                    id: image_robot_con
                    anchors.centerIn: parent
                    Image{
                        id: image_tx
                        width: 15
                        height: 28
                        mipmap: true
                        antialiasing: true
                        sourceSize.width: 15
                        sourceSize.height: 28
                        source: robot_tx?"icon/data_green.png":"icon/data_gray.png"
                    }
                    Image{
                        id: image_rx
                        mipmap: true
                        antialiasing: true
                        width: 15
                        height: 28
                        sourceSize.width: 15
                        sourceSize.height: 28
                        anchors.top: image_tx.top
                        anchors.topMargin: 1
                        rotation: 180
                        source: robot_rx?"icon/data_green.png":"icon/data_gray.png"
                    }
                }
            }


            Image{
                id: image_battery
                property string src:""
                source: {
                    if(robot_battery > 90){
                        src = "icon/bat_full.png"
                        src
                    }else if(robot_battery > 60){
                        src = "icon/bat_3.png"
                        src
                    }else if(robot_battery > 30){
                        src = "icon/bat_2.png"
                        src
                    }else{
                        src = "icon/bat_1.png"
                        src
                    }
                }
                sourceSize.width: 46
                sourceSize.height: 42
                anchors.verticalCenter: parent.verticalCenter
            }

            Text{
                id: textBattery
                anchors.verticalCenter: parent.verticalCenter
                color: "#7e7e7e"
                font.pixelSize: 20
                text: robot_battery.toFixed(0)+' %'
            }

        }
        MouseArea{
            anchors.fill: rows_icon
            onClicked: {
                update_detail();
                popup_status_detail.open();
            }
        }
    }



    Popup{
        id: popup_menu
        width: 300
        height: 100
        bottomPadding: 0
        topPadding: 0
        leftPadding: 0
        rightPadding: 0
        y: parent.height
        Rectangle{
            anchors.fill: parent
            color: "#e8e8e8"
            Row{
                anchors.centerIn: parent
                spacing: 30

                Rectangle{
                    id: btn_minimize
                    width: 78
                    height: 78
                    radius: width
                    Column{
                        anchors.centerIn: parent
                        Image{
                            id: image_charge
                            source:"icon/btn_minimize.png"
                            anchors.horizontalCenter: parent.horizontalCenter
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
                Rectangle{
                    width: 78
                    height: 78
                    radius: width
                    Column{
                        anchors.centerIn: parent
                        Image{
                            id: image_wait
                            source:"icon/icon_power.png"
                            anchors.horizontalCenter: parent.horizontalCenter
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

    SequentialAnimation{
        id: ani_popup_show
        NumberAnimation{target: popup_status_detail; property: "height"; from: 0; to: model_details.count * 40; duration: 300; easing.type: Easing.OutBack}
    }

    ListModel{
        id: model_details
    }

    function update_detail(){
        model_details.clear();
        if(is_con_joystick){
            model_details.append({"detail":"조이스틱이 연결되었습니다.","icon":"icon/icon_joy_connect.png","error":false});
        }
        if(is_con_server){
            model_details.append({"detail":"서버에 연결되었습니다.","icon":"icon/icon_server_connect.png","error":false});
        }
        if(!is_con_robot){
            model_details.append({"detail":"로봇과 연결되지 않았습니다.","icon":"icon/icon_connect_error.png","error":true});
        }
        if(robot_battery < 30 && is_con_robot){
            model_details.append({"detail":"배터리가 부족합니다.","icon":qsTr(image_battery.src),"error":true});
        }
    }

    Popup{
        id: popup_status_detail
        width: 300
        height: 0
        x: parent.width - width
        y: parent.height

        onOpened: {
            if(model_details.count == 0){
                popup_status_detail.close();
            }else{
                ani_popup_show.start();
            }

        }

        Rectangle{
            color: "white"
            anchors.fill: parent
        }

        Column{
            id: col_details
            anchors.centerIn: parent
            spacing: 10
            Repeater{
                model: model_details
                Row{
                    spacing: 10
                    Image{
                        source: icon
                        width: 20
                        height: 20
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text{
                        text: detail
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: font_noto_r.name
                        font.pixelSize: 15
                        color: error===true?"red":"green"
                    }
                }
            }
        }
    }

    Timer{
        id: timer_status_update
        interval: 10
        repeat: true
        running: true
        onTriggered: {
            curTime = Qt.formatTime(new Date(), "hh:mm");
            robot_rx = supervisor.getLCMRX();
            robot_tx = supervisor.getLCMTX();
            is_con_joystick = supervisor.isconnectJoy();
            is_con_server = supervisor.isConnectServer();
            is_con_robot = supervisor.getLCMConnection();
        }

    }

}
