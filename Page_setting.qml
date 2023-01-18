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
                width: 250
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
                width: 240
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
                width: 240
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
            Rectangle{
                id: rect_category_3
                width: 264
                height: 40
                color: "#647087"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "SLAM"
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                       select_category = 3;
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 7
                    visible: select_category==3?true:false
                    color: "#12d27c"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                }
            }
            Rectangle{
                id: rect_category_4
                width: 240
                height: 40
                color: "#647087"
                Text{
                    anchors.centerIn: parent
                    font.family: font_noto_r.name
                    color: "white"
                    text: "Motor"
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                       select_category = 4;
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 7
                    visible: select_category==4?true:false
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
                                id: platform_name
                                anchors.fill: parent
                                text:supervisor.getSetting("ROBOT_HW","model");
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_robot_1_serial
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
                                text:"플랫폼 넘버(중복 주의)"
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
                                id: combo_platform_serial
                                anchors.fill: parent
                                model:[0,1,2,3,4,5,6,7,8,9,10]
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
                            id: rr
                            width: parent.width - 351
                            height: parent.height
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_velocity
                                        anchors.centerIn: parent
                                        text: slider_vxy.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_vxy
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0
                                    to: 1
                                    value: supervisor.getVelocity()
                                }
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
                                text:"로봇 반지름 반경"
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
                                id: radius
                                anchors.fill: parent
                                text:supervisor.getSetting("ROBOT_HW","radius");
                            }
                        }
                    }
                }

                Rectangle{
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
                                text:"UI 명령 활성"
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
                                id: combo_use_uicmd
                                anchors.fill: parent
                                model:["비활성화","활성화"]
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
                                enabled: combo_use_travelline.currentIndex==1
                                id: combo_travelline
                                anchors.fill: parent
                                model:ListModel{}
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

        Flickable{
            id: area_setting_slam
            visible: select_category==3?true:false
            width: 880
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 120
            height: parent.height - 200
            contentHeight: column_setting3.height
            clip: true
            ScrollBar.vertical: ScrollBar{
                width: 20
                anchors.right: parent.right
                policy: ScrollBar.AlwaysOn
            }
            Column{
                id:column_setting3
                width: parent.width
                spacing:25
                Rectangle{
                    id: set_slam_1
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
                                text:"baudrate"
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
                                id: combo_baudrate
                                anchors.fill: parent
                                model:[115200,256000]
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_slam_2
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
                                text:"mask"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_mask
                                        anchors.centerIn: parent
                                        text: slider_mask.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_mask
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0
                                    to: 15.0
                                    value: 10.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_slam_3
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
                                text:"max_range"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_max_range
                                        anchors.centerIn: parent
                                        text: slider_max_range.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_max_range
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 10.0
                                    to: 50.0
                                    value: 40.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_slam_4
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
                                text:"offset_x"
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
                                id: offset_x
                                anchors.fill: parent
                                text:supervisor.getSetting("SENSOR","offset_x");
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_slam_5
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
                                text:"offset_y"
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
                                id: offset_y
                                anchors.fill: parent
                                text:supervisor.getSetting("SENSOR","offset_y");
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_slam_6
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
                                text:"left_camera"
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
                                id: left_camera
                                height: parent.height
                                anchors.left: parent.left
                                anchors.right: btn_view_cam.left
                                text:supervisor.getSetting("SENSOR","left_camera");
                            }
                            Rectangle{
                                id: btn_view_cam
                                width: 100
                                height: parent.height
                                anchors.right: parent.right
                                radius: 5
                                color: "#d0d0d0"
                                Text{
                                    anchors.centerIn: parent
                                    text: "viewer"
                                    font.pixelSize: 15
                                    font.family: font_noto_r.name

                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        popup_camera.open();

                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_slam_7
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
                                text:"right_camera"
                                font.pixelSize: 20
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {

                                }
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
                                id: right_camera
                                height: parent.height
                                anchors.left: parent.left
                                anchors.right: btn_view_camr.left
                                text:supervisor.getSetting("SENSOR","right_camera");
                            }
                            Rectangle{
                                id: btn_view_camr
                                width: 100
                                height: parent.height
                                anchors.right: parent.right
                                radius: 5
                                color: "#d0d0d0"
                                Text{
                                    anchors.centerIn: parent
                                    text: "viewer"
                                    font.pixelSize: 15
                                    font.family: font_noto_r.name
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            popup_camera.open();

                                        }
                                    }

                                }
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"k_curve"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_k_curve
                                        anchors.centerIn: parent
                                        text: slider_k_curve.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_k_curve
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.1
                                    to: 5.0
                                    value: 0.7
                                }
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"k_v"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_k_v
                                        anchors.centerIn: parent
                                        text: slider_k_v.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_k_v
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.1
                                    to: 2.0
                                    value: 0.7
                                }
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"k_w"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_k_w
                                        anchors.centerIn: parent
                                        text: slider_k_w.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_k_w
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 1.0
                                    to: 3.0
                                    value: 2.5
                                }
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"limit_pivot"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_pivot
                                        anchors.centerIn: parent
                                        text: slider_limit_pivot.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_pivot
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 5.0
                                    to: 90.0
                                    value: 45.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"limit_v"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_v
                                        anchors.centerIn: parent
                                        text: slider_limit_v.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_v
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.1
                                    to: 2.0
                                    value: 1.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"limit_w"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_w
                                        anchors.centerIn: parent
                                        text: slider_limit_w.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_w
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 5.0
                                    to: 120.0
                                    value: 120.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"limit_manual_v"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_manual_v
                                        anchors.centerIn: parent
                                        text: slider_limit_manual_v.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_manual_v
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.1
                                    to: 2.0
                                    value: 0.3
                                }
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"limit_manual_w"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_manual_w
                                        anchors.centerIn: parent
                                        text: slider_limit_manual_w.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_manual_w
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 5.0
                                    to: 120.0
                                    value: 120.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"look_ahead_dist"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_look_ahead_dist
                                        anchors.centerIn: parent
                                        text: slider_look_ahead_dist.value.toFixed(2)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_look_ahead_dist
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.3
                                    to: 1.0
                                    value: 0.45
                                }
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"wheel_base"
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
                                id: wheel_base
                                anchors.fill: parent
                                text:supervisor.getSetting("ROBOT","wheel_base");
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"wheel_radius"
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
                                id: wheel_radius
                                anchors.fill: parent
                                text:supervisor.getSetting("ROBOT","wheel_radius");
                            }
                        }
                    }
                }





            }
        }

        Flickable{
            id: area_setting_motor
            visible: select_category==4?true:false
            width: 880
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 120
            height: parent.height - 200
            contentHeight: column_setting4.height
            clip: true
            ScrollBar.vertical: ScrollBar{
                width: 20
                anchors.right: parent.right
                policy: ScrollBar.AlwaysOn
            }
            Column{
                id:column_setting4
                width: parent.width
                spacing:25
                Rectangle{
                    id: set_motor_1
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
                                text:"gear_ratio"
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
                                id: gear_ratio
                                anchors.fill: parent
                                text: supervisor.getSetting("MOTOR","gear_ratio");
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_motor_2
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
                                text:"k_p"
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
                                id: k_p
                                anchors.fill: parent
                                text: supervisor.getSetting("MOTOR","k_p");
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_motor_3
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
                                text:"k_i"
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
                                id: k_i
                                anchors.fill: parent
                                text: supervisor.getSetting("MOTOR","k_i");
                            }
                        }
                    }
                }
                Rectangle{
                    id: set_motor_4
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
                                text:"k_d"
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
                                id: k_d
                                anchors.fill: parent
                                text: supervisor.getSetting("MOTOR","k_d");
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"limit_acc"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_acc
                                        anchors.centerIn: parent
                                        text: slider_limit_acc.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_acc
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.5
                                    to: 1.5
                                    value: 1.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"limit_dec"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_dec
                                        anchors.centerIn: parent
                                        text: slider_limit_dec.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_dec
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.5
                                    to: 1.5
                                    value: 1.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"limit_vel"
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
                            Row{
                                spacing: 10
                                anchors.centerIn: parent
                                Rectangle{
                                    width: rr.width*0.1
                                    height: 40
                                    Text{
                                        id: text_limit_vel
                                        anchors.centerIn: parent
                                        text: slider_limit_vel.value.toFixed(1)
                                        font.pixelSize: 15
                                        font.family: font_noto_r.name
                                    }
                                }
                                Slider{
                                    id: slider_limit_vel
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: rr.width*0.8
                                    height: 40
                                    from: 0.1
                                    to: 2.0
                                    value: 2.0
                                }
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"wheel_dir"
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
                                id: combo_wheel_dir
                                anchors.fill: parent
                                model: [-1,1]
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"left_id"
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
                                id: combo_left_id
                                anchors.fill: parent
                                model:[0,1]
                            }
                        }
                    }
                }
                Rectangle{
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
                                text:"right_id"
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
                                id: combo_right_id
                                anchors.fill: parent
                                model:[0,1]
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
                id: btn_update
                width: 180
                height: 60
                radius: 10
                color:"transparent"
                border.width: 1
                border.color: "#7e7e7e"
                Text{
                    anchors.centerIn: parent
                    text: "Program Update"
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        popup_update.open();
                    }
                }
            }
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
                        supervisor.setSetting("ROBOT_HW/model",platform_name.text);
                        supervisor.setSetting("ROBOT_HW/serial_num",combo_platform_serial.currentText);
                        supervisor.setSetting("ROBOT_HW/radius",radius.text);
                        supervisor.setSetting("ROBOT_HW/tray_num",combo_tray_num.currentText);

                        if(combo_platform_type.currentIndex == 0){
                            supervisor.setSetting("ROBOT_HW/type","SERVING");
                        }else if(combo_platform_type.currentIndex == 1){
                            supervisor.setSetting("ROBOT_HW/type","CALLING");
                        }

                        supervisor.setSetting("ROBOT_HW/wheel_base",wheel_base.text);
                        supervisor.setSetting("ROBOT_HW/wheel_radius",wheel_radius.text);

                        supervisor.setSetting("ROBOT_SW/k_curve",text_k_curve.text);
                        supervisor.setSetting("ROBOT_SW/k_v",text_k_v.text);
                        supervisor.setSetting("ROBOT_SW/k_w",text_k_w.text);
                        supervisor.setSetting("ROBOT_SW/limit_pivot",text_limit_pivot.text);
                        supervisor.setSetting("ROBOT_SW/limit_v",text_limit_v.text);
                        supervisor.setSetting("ROBOT_SW/limit_w",text_limit_w.text);

                        supervisor.setSetting("ROBOT_SW/limit_manual_v",text_limit_manual_v.text);
                        supervisor.setSetting("ROBOT_SW/limit_manual_w",text_limit_manual_w.text);
                        supervisor.setSetting("ROBOT_SW/look_ahead_dist",text_look_ahead_dist.text);


                        if(combo_use_voice.currentIndex == 0)
                            supervisor.setSetting("ROBOT_SW/use_voice","false");
                        else
                            supervisor.setSetting("ROBOT_SW/use_voice","true");

                        if(combo_use_bgm.currentIndex == 0)
                            supervisor.setSetting("ROBOT_SW/use_bgm","false");
                        else
                            supervisor.setSetting("ROBOT_SW/use_bgm","true");

                        if(combo_use_uicmd.currentIndex == 0)
                            supervisor.setSetting("ROBOT_SW/use_uicmd","false");
                        else
                            supervisor.setSetting("ROBOT_SW/use_uicmd","true");

                        if(combo_use_servercmd.currentIndex == 0)
                            supervisor.setSetting("SERVER/use_servercmd","false");
                        else
                            supervisor.setSetting("SERVER/use_servercmd","true");


                        supervisor.setSetting("ROBOT_SW/velocity",text_velocity.text);


                        supervisor.setSetting("SENSOR/baudrate",combo_baudrate.currentText);
                        supervisor.setSetting("SENSOR/mask",text_mask.text);
                        supervisor.setSetting("SENSOR/max_range",text_max_range.text);
                        supervisor.setSetting("SENSOR/offset_x",offset_x.text);
                        supervisor.setSetting("SENSOR/offset_y",offset_y.text);
                        supervisor.setSetting("SENSOR/right_camera",right_camera.text);
                        supervisor.setSetting("SENSOR/left_camera",left_camera.text);


                        supervisor.setSetting("MOTOR/gear_ratio",gear_ratio.text);
                        supervisor.setSetting("MOTOR/k_d",k_d.text);
                        supervisor.setSetting("MOTOR/k_i",k_i.text);
                        supervisor.setSetting("MOTOR/k_p",k_p.text);

                        supervisor.setSetting("MOTOR/left_id",combo_left_id.currentText);
                        supervisor.setSetting("MOTOR/right_id",combo_right_id.currentText);

                        supervisor.setSetting("MOTOR/limit_acc",text_limit_acc.text);
                        supervisor.setSetting("MOTOR/limit_dec",text_limit_dec.text);
                        supervisor.setSetting("MOTOR/limit_vel",text_limit_vel.text);

                        supervisor.setSetting("MOTOR/wheel_dir",combo_wheel_dir.currentText);









                        if(combo_use_travelline.currentIndex == 0)
                            supervisor.setuseTravelline(false);
                        else
                            supervisor.setuseTravelline(true);

                        supervisor.setnumTravelline(combo_travelline.currentIndex);

                        supervisor.setTableNum(combo_table_num.currentIndex);




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
        platform_name.text = supervisor.getSetting("ROBOT_HW","model");
        combo_platform_serial.currentIndex = parseInt(supervisor.getSetting("ROBOT_HW","serial_num"))
        radius.text = supervisor.getSetting("ROBOT_HW","radius");

        combo_tray_num.currentIndex = supervisor.getSetting("ROBOT_HW","tray_num")-1;

        if(supervisor.getSetting("ROBOT_HW","type") === "SERVING"){
            combo_platform_type.currentIndex = 0;
        }else{
            combo_platform_type.currentIndex = 1;
        }
        wheel_base.text = supervisor.getSetting("ROBOT_HW","wheel_base");
        wheel_radius.text = supervisor.getSetting("ROBOT_HW","wheel_radius");

        slider_k_curve.value = parseFloat(supervisor.getSetting("ROBOT_SW","k_curve"));
        slider_k_v.value = parseFloat(supervisor.getSetting("ROBOT_SW","k_v"));
        slider_k_w.value = parseFloat(supervisor.getSetting("ROBOT_SW","k_w"));
        slider_limit_pivot.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_pivot"));
        slider_limit_manual_v.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_manual_v"));
        slider_limit_manual_w.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_manual_w"));
        slider_limit_v.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_v"));
        slider_limit_w.value = parseFloat(supervisor.getSetting("ROBOT_SW","limit_w"));
        slider_look_ahead_dist.value = parseFloat(supervisor.getSetting("ROBOT_SW","look_ahead_dist"));

        if(supervisor.getSetting("ROBOT_SW","use_voice") === "true"){
            combo_use_voice.currentIndex = 1;
        }else{
            combo_use_voice.currentIndex = 0;
        }
        if(supervisor.getSetting("ROBOT_SW","use_bgm") === "true"){
            combo_use_bgm.currentIndex = 1;
        }else{
            combo_use_bgm.currentIndex = 0;
        }
        if(supervisor.getSetting("SERVER","use_servercmd") === "true"){
            combo_use_servercmd.currentIndex = 1;
        }else{
            combo_use_servercmd.currentIndex = 0;
        }
        if(supervisor.getSetting("ROBOT_SW","use_uicmd") === "true"){
            combo_use_uicmd.currentIndex = 1;
        }else{
            combo_use_uicmd.currentIndex = 0;
        }

        slider_vxy.value = parseFloat(supervisor.getSetting("ROBOT_SW","velocity"));

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
        combo_table_num.currentIndex = supervisor.getTableNum();



        gear_ratio.text = supervisor.getSetting("MOTOR","gear_ratio");
        k_d.text = supervisor.getSetting("MOTOR","k_d");
        k_i.text = supervisor.getSetting("MOTOR","k_i");
        k_p.text = supervisor.getSetting("MOTOR","k_p");


        combo_left_id.currentIndex = parseInt(supervisor.getSetting("MOTOR","left_id"));
        combo_right_id.currentIndex = parseInt(supervisor.getSetting("MOTOR","right_id"));

        slider_limit_acc.value = parseFloat(supervisor.getSetting("MOTOR","limit_acc"));
        slider_limit_dec.value = parseFloat(supervisor.getSetting("MOTOR","limit_dec"));
        slider_limit_vel.value = parseFloat(supervisor.getSetting("MOTOR","limit_vel"));

        if(supervisor.getSetting("MOTOR","wheel_dir") === "-1"){
            combo_wheel_dir.currentIndex = 0;
        }else{
            combo_wheel_dir.currentIndex = 1;
        }

        if(supervisor.getSetting("SENSOR","baudrate") === "115200"){
            combo_baudrate.currentIndex = 0;
        }else if(supervisor.getSetting("SENSOR","baudrate") === "256000"){
            combo_baudrate.currentIndex = 1;
        }
        slider_mask.value = parseFloat(supervisor.getSetting("SENSOR","mask"));
        slider_max_range.value = parseFloat(supervisor.getSetting("SENSOR","max_range"));
        offset_x.text = supervisor.getSetting("SENSOR","offset_x");
        offset_y.text = supervisor.getSetting("SENSOR","offset_y");
        right_camera.text = supervisor.getSetting("SENSOR","right_camera");
        left_camera.text = supervisor.getSetting("SENSOR","left_camera");
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


    Popup{
        id: popup_update
        width: 600
        height: 400
        anchors.centerIn: parent


        onOpened: {
            //버전 체크
            if(supervisor.isNewVersion()){
                //버전이 이미 최신임
                rect_lastest.visible = true;
                rect_need_update.visible = false;
                text_version.text = supervisor.getLocalVersion()
            }else{
                //새로운 버전 확인됨
                rect_lastest.visible = false;
                rect_need_update.visible = true;
                text_version1.text = "현재 : " + supervisor.getLocalVersion()
                text_version2.text = "최신 : " + supervisor.getServerVersion()
            }
        }

        Rectangle{
            id: rect_lastest
            anchors.fill: parent
            radius: 5
            Text{
                id: text_1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
                font.family: font_noto_r.name
                font.pixelSize: 20
                text:"프로그램이 이미 최신입니다."
            }
            Text{
                id: text_version
                anchors.centerIn: parent
                anchors.topMargin: 50
                font.family: font_noto_r.name
                font.pixelSize: 20
                text:supervisor.getLocalVersion()
            }

            Rectangle{
                width: 180
                height: 60
                radius: 10
                color: "#12d27c"
                border.width: 1
                border.color: "#12d27c"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                Text{
                    anchors.centerIn: parent
                    text: "확인"
                    font.family: font_noto_r.name
                    font.pixelSize: 25
                    color: "white"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        popup_update.close();
                    }
                }
            }
        }
        Rectangle{
            id: rect_need_update
            anchors.fill: parent
            radius: 5
            Text{
                id: text_11
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
                font.family: font_noto_r.name
                font.pixelSize: 20
                text:"새로운 버전이 확인되었습니다. 업데이트하시겠습니까?"
            }
            Column{
                anchors.centerIn: parent
                Text{
                    id: text_version1
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                    text:"현재 : "+supervisor.getLocalVersion()
                }
                Text{
                    id: text_version2
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                    text:"최신 : "+supervisor.getServerVersion()
                }
            }
            Row{
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20

                Rectangle{
                    width: 180
                    height: 60
                    radius: 10
                    color:"transparent"
                    border.width: 1
                    border.color: "#7e7e7e"
                    Text{
                        anchors.centerIn: parent
                        text: "취소"
                        font.family: font_noto_r.name
                        font.pixelSize: 25
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            popup_update.close();
                        }
                    }
                }
                Rectangle{
                    width: 180
                    height: 60
                    radius: 10
                    color: "#12d27c"
                    border.width: 1
                    border.color: "#12d27c"
                    Text{
                        anchors.centerIn: parent
                        text: "확인"
                        font.family: font_noto_r.name
                        font.pixelSize: 25
                        color: "white"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            supervisor.pullGit();
                            popup_update.close();
                        }
                    }
                }
            }
        }

    }


    Popup{
        id: popup_camera
        width: parent.width
        height: parent.height
        background: Rectangle{
            opacity: 0.8
            color: "#282828"
        }
        property bool is_load: false

        Timer{
            id: timer_load
            interval: 1000
            repeat: true
            triggeredOnStart: true
            onTriggered:{
                //카메라 정보 요청
                supervisor.requestCamera();

                //카메라 대수에 따라 UI 업데이트
                if(supervisor.getCameraNum() > 1){
                    text_camera_1.text = supervisor.getCameraSerial(0);
                    text_camera_2.text = supervisor.getCameraSerial(1);
                    popup_camera.is_load = true;
                }else if(supervisor.getCameraNum() === 1){
                    text_camera_1.text = supervisor.getCameraSerial(0);
                    popup_camera.is_load = true;
                }else{
                    text_camera_1.text = "";
                    text_camera_2.text = "";
                }

                if(popup_camera.is_load){
                    print("load done");
                    //지정된 왼쪽카메라 확인
                    if(supervisor.getLeftCamera() === supervisor.getCameraSerial(0)){
                        mousearea_1.is_left = true;
                        mousearea_2.is_left = false;

                        ani_1.to = popup_camera.pos_left;
                        ani_2.to = popup_camera.pos_right;
                        ani_camera.restart();
                    }
                    if(supervisor.getRightCamera() === supervisor.getCameraSerial(0)){
                        mousearea_1.is_left = false;
                        mousearea_2.is_left = true;
                        ani_1.to = popup_camera.pos_right;
                        ani_2.to = popup_camera.pos_left;
                        ani_camera.restart();
                    }

                    if(supervisor.getCameraNum() > 1){
                        if(mousearea_1.is_left && supervisor.getLeftCamera() === supervisor.getCameraSerial(0)){
                            cam_info_1.set = true;
                        }
                        if(mousearea_2.is_left && supervisor.getLeftCamera() === supervisor.getCameraSerial(1)){
                            cam_info_2.set = true;
                        }
                        if(!mousearea_1.is_left && supervisor.getRightCamera() === supervisor.getCameraSerial(0)){
                            cam_info_1.set = true;
                        }
                        if(!mousearea_2.is_left && supervisor.getRightCamera() === supervisor.getCameraSerial(1)){
                            cam_info_2.set = true;
                        }
                    }

                    canvas_camera_1.requestPaint();
                    canvas_camera_2.requestPaint();
                    timer_load.stop();
                }else{
                    cam_info_1.set = false;
                    cam_info_2.set = false;
                }
            }
        }

        property var pos_left: rect_remain.width/4 - cam_info_1.width/2
        property var pos_right: rect_remain.width*3/4 - cam_info_1.width/2
        Rectangle{
            anchors.centerIn: parent
            width: 800
            height: 800
            Rectangle{
                id: rect_title
                width: parent.width
                height: 100
                color: "#323744"
                Text{
                    anchors.centerIn: parent
                    color: "white"
                    font.family: font_noto_r.name
                    font.pixelSize: 20
                    text: "카메라 정보를 확인한 후, 위치를 지정하여주세요."
                }
            }
            Rectangle{
                id: rect_remain
                width: parent.width
                height: parent.height - rect_title.height
                anchors.top: rect_title.bottom

                Rectangle{
                    id: rect_black_left
                    width: rect_remain.width/2
                    height: 500
                    color: "#282828"
                    Text{
                        id: text_left
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        text: "Left"
                        font.family: font_noto_b.name
                        font.pixelSize: 20
                        color: "white"
                    }
                }
                Rectangle{
                    id: rect_black_right
                    width: rect_remain.width/2
                    anchors.left: rect_black_left.right
                    height: 500
                    color: "#282828"
                    Text{
                        id: text_right
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        text: "Right"
                        font.family: font_noto_b.name
                        font.pixelSize: 20
                        color: "white"
                    }
                }

                ParallelAnimation{
                    id: ani_camera;
                    SpringAnimation{
                        id:ani_1
                        target:cam_info_1
                        property:"x"
                        duration:500
                        spring: 2
                        damping: 0.2
                    }
                    SpringAnimation{
                        id:ani_2
                        target:cam_info_2
                        property:"x"
                        duration:500
                        spring: 2
                        damping: 0.2
                    }
                }

                Rectangle{
                    id: cam_info_1
                    width: 350
                    height: 400
                    color: "transparent"
                    property bool set:false
                    z: mousearea_1.pressed?2:1
                    x: parent.width/4 - width/2
                    y: 60

                    Rectangle{
                        id: rect_cam_1
                        clip: true
                        width: parent.width
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        Canvas{
                            id: canvas_camera_1
                            anchors.fill: parent
                            onPaint:{
                                var ctx = getContext('2d');
                                ctx.clearRect(0,0,width,height);

                                if(supervisor.getCameraNum() > 0){
                                    var image_data = supervisor.getCamera(0);
                                    var temp_image = ctx.createImageData(width,height);

                                    for(var i=0; i<image_data.length; i++){
                                        temp_image.data[4*i+0] = image_data[i];
                                        temp_image.data[4*i+1] = image_data[i];
                                        temp_image.data[4*i+2] = image_data[i];
                                        temp_image.data[4*i+3] = 255;
                                    }
                                    ctx.drawImage(temp_image,0,0,width,height);
                                }

                            }
                        }

                    }

                    Rectangle{
                        anchors.top: rect_cam_1.bottom
                        width: parent.width
                        height: 50
                        radius: 5
                        color: cam_info_1.set?"#12d27c":"#d0d0d0"
                        Row{
                            spacing: 10
                            anchors.centerIn: parent
                            Text{
                                text: "Serial : "
                                font.family: font_noto_r.name

                            }
                            Text{
                                id: text_camera_1
                                text: {
                                    if(supervisor.getCameraNum() > 0){
                                        supervisor.getCameraSerial(0);
                                    }else{
                                        ""
                                    }
                                }
                                font.family: font_noto_r.name

                            }
                        }
                    }

                    MouseArea{
                        id:mousearea_1
                        anchors.fill: parent
                        property var firstX;
                        property var firstY;
                        property bool is_left: true
                        propagateComposedEvents: true
                        preventStealing: false

                        onPressed:{
                            firstX = mouseX;
                            firstY = mouseY;
                        }
                        onReleased: {
                            if(is_left){
                                ani_1.from = cam_info_1.x;
                                ani_1.to = popup_camera.pos_left;

                                ani_2.from = cam_info_2.x;
                                ani_2.to = popup_camera.pos_right;

                                print("LEFT ",ani_1.to, ani_2.to);
                                ani_camera.restart();

                            }else{
                                ani_1.from = cam_info_1.x;
                                ani_1.to = popup_camera.pos_right;
                                ani_2.from = cam_info_2.x;
                                ani_2.to = popup_camera.pos_left;
                                print("RIGHT ",ani_1.to, ani_2.to);
                                ani_camera.restart();
                            }
                        }
                        onPositionChanged: {
                            cam_info_1.x += mouseX - firstX;
                            if(mouseX - firstX > 0){
                                is_left = false;
                            }else{
                                is_left = true;
                            }
                        }
                    }
                }
                Rectangle{
                    id: cam_info_2
                    width: 350
                    height: 400
                    color: "transparent"
                    property bool set: false
                    z: mousearea_2.pressed?2:1
                    x: parent.width*3/4 - width/2
                    y: 60
                    Rectangle{
                        id: rect_cam_2
                        clip: true
                        width: parent.width
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        Canvas{
                            id: canvas_camera_2
                            anchors.fill: parent
                            onPaint:{
                                var ctx = getContext('2d');
                                ctx.clearRect(0,0,width,height);

                                if(supervisor.getCameraNum() > 1){
                                    var image_data = supervisor.getCamera(1);
                                    var temp_image = ctx.createImageData(width,height);

                                    for(var i=0; i<image_data.length; i++){
                                        temp_image.data[4*i+0] = image_data[i];
                                        temp_image.data[4*i+1] = image_data[i];
                                        temp_image.data[4*i+2] = image_data[i];
                                        temp_image.data[4*i+3] = 255;
                                    }
                                    ctx.drawImage(temp_image,0,0,width,height);
                                }

                            }
                        }

                    }

                    Rectangle{
                        anchors.top: rect_cam_2.bottom
                        width: parent.width
                        height: 50
                        radius: 5
                        color: cam_info_2.set?"#12d27c":"#d0d0d0"
                        Row{
                            spacing: 10
                            anchors.centerIn: parent
                            Text{
                                text: "Serial : "
                                font.family: font_noto_r.name

                            }
                            Text{
                                id: text_camera_2
                                text: {
                                    if(supervisor.getCameraNum() > 1){
                                        supervisor.getCameraSerial(1);
                                    }else{
                                        ""
                                    }
                                }
                                font.family: font_noto_r.name

                            }
                        }
                    }

                    MouseArea{
                        id:mousearea_2
                        anchors.fill: parent
                        property var firstX;
                        property var firstY;
                        property bool is_left: true
                        propagateComposedEvents: true
                        preventStealing: false

                        onPressed:{
                            firstX = mouseX;
                            firstY = mouseY;
                        }
                        onReleased: {
                            if(!is_left){
                                ani_1.from = cam_info_1.x;
                                ani_1.to = popup_camera.pos_left;

                                ani_2.from = cam_info_2.x;
                                ani_2.to = popup_camera.pos_right;

                                ani_camera.restart();

                            }else{
                                ani_1.from = cam_info_1.x;
                                ani_1.to = popup_camera.pos_right;
                                ani_2.from = cam_info_2.x;
                                ani_2.to = popup_camera.pos_left;
                                ani_camera.restart();
                            }
                        }
                        onPositionChanged: {
                            cam_info_2.x += mouseX - firstX;
                            if(mouseX - firstX > 0){
                                is_left = false;
                            }else{
                                is_left = true;
                            }
                        }
                    }
                }

                Rectangle{
                    width: rect_remain.width
                    height: rect_remain.height - rect_black_left.height
                    anchors.top: rect_black_left.bottom
                    Row{
                        spacing: 50
                        anchors.centerIn: parent
                        Rectangle{
                            width: 180
                            height: 60
                            radius: 10
                            color: enabled?"#12d27c":"#e9e9e9"
                            border.width: enabled?1:0
                            border.color: "#12d27c"
                            enabled: popup_camera.is_load
                            Text{
                                anchors.centerIn: parent
                                text: "확인"
                                font.family: font_noto_r.name
                                font.pixelSize: 25
                                color: "white"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(mousearea_1.is_left){
                                        supervisor.setCamera(text_camera_1.text,text_camera_2.text);
                                    }else{
                                        supervisor.setCamera(text_camera_2.text,text_camera_1.text);
                                    }
                                    supervisor.readSetting();
                                    init();
                                    popup_camera.close();
                                }
                            }
                        }
                        Rectangle{
                            width: 180
                            height: 60
                            radius: 10
                            color:"transparent"
                            border.width: 1
                            border.color: "#7e7e7e"
                            Text{
                                anchors.centerIn: parent
                                text: "취소"
                                font.family: font_noto_r.name
                                font.pixelSize: 25
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    popup_camera.close();
                                }
                            }
                        }
                        Rectangle{
                            width: 180
                            height: 60
                            radius: 10
                            color:popup_camera.is_load?"transparent":"#12d27c"
                            border.width: 1
                            border.color: "#7e7e7e"
                            Text{
                                anchors.centerIn: parent
                                text: "사진 요청"
                                font.family: font_noto_r.name
                                font.pixelSize: 25
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    supervisor.requestCamera();
                                    timer_load.start();
                                }
                            }
                        }
                    }
                }

            }
        }
    }
}
