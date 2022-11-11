import QtQuick 2.0

Item {

    Rectangle{
        width: 100
        height: 100
        x: 700
        y: 400
        color: "gray"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                stackview.pop();
            }
        }
    }
}
