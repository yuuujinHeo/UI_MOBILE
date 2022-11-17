import QtQuick 2.0

Item {
    id: temp_button
    property color btn_color: "gray"
    property string btn_text: "temp"
    Rectangle{
        anchors.fill: parent
        color: btn_color
        Text{
            text: btn_text
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {

            }
        }
    }
}
