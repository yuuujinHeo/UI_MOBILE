import QtQuick 2.12
import QtQuick.Controls 2.12



Popup{
    id: popup_help
    anchors.centerIn: parent
    width: 800
    height: 600
    background: Rectangle{
        width: popup_help.width
        height: popup_help.height
        radius: 30
        color: color_dark_black
        opacity: 0.95
    }
    function clear(){
        model_tips.clear();
    }

    function addTip(question, answer){
        model_tips.append({"question":question,"answer":answer});
    }

    Column{
        Rectangle{
            width: popup_help.width
            height: 100
            color: "transparent"
            Text{
                anchors.centerIn: parent
                text: "도움말"
                font.family: font_noto_r.name
                font.pixelSize: 50
                color:"white"
            }
        }
        Rectangle{
            width: popup_help.width
            height: popup_help.height - 100
            color: "transparent"
            Column{
                width: parent.width - 100
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 50
                spacing: 50
                Repeater{
                    model: ListModel{id: model_tips}
                    Column{
                        width: popup_help.width - 100
                        spacing: 10
                        Text{
                            text: "Q. "+question
                            font.family: font_noto_r.name
                            font.pixelSize: 25
                            color:"white"
                        }
                        Text{
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: answer
                            font.family: font_noto_r.name
                            font.pixelSize: 16
                            color:"white"
                        }
                    }
                }
            }
        }

    }
}
