import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import "."
import io.qt.Supervisor 1.0
import QtMultimedia 5.12

Item {
    id: page_log
    objectName: "page_log"
    width: 1280
    height: 800

    property date currentDate: new Date()
    property string today: ""
    property var year: -1
    property var month: -1
    property var date: -1
    property string week: ""
    property var date_end: 30
    property var select_category: 1

    Component.onCompleted: {
        setdateToday();
    }

    onSelect_categoryChanged: {
        supervisor.setLog(select_category);
        supervisor.readLog(currentDate)
        setdateToday();
    }

    function setdateToday(){
        currentDate = new Date();

        if(model_date.count > 0){
            if(model_date.get(0).month !== currentDate.getMonth()+1){
                set_datelist();
            }
        }else{
            set_datelist();
        }
        date_list.enabled = true;
        date_list.currentIndex = currentDate.getDate()-1;
        update_log();
    }

    function update_log(){
        supervisor.readLog(currentDate);
        model_log.clear();
        for(var i=0;i<supervisor.getLogLineNum(); i++){
            model_log.append({"date":supervisor.getLogDate(i),"auth":supervisor.getLogAuth(i),"message":supervisor.getLogMessage(i)})
        }
    }

    function set_datelist(){
        var tempstr = supervisor.getLocaleDate(currentDate.getFullYear(),currentDate.getMonth()+1,1);
        var temp_date = Date.fromLocaleString(Qt.locale(),tempstr, "yyyy-MM-dd");

        date_list.enabled = false;
        model_date.clear();
        while(temp_date.getMonth() === currentDate.getMonth()){
            var tempWeek = temp_date.toLocaleDateString().split(" ")[3];

            model_date.append({"year":temp_date.getFullYear(),"month":temp_date.getMonth()+1,"date":temp_date.getDate(),"week":tempWeek})

            var newdate = temp_date;
            newdate.setDate(temp_date.getDate() + 1);
            temp_date = newdate;
        }
        date_list.currentIndex = currentDate.getDate() - 1;
        date_list.enabled = true;
    }

    function setdate(new_date){
        currentDate = new_date;
        if(model_date.count > 0){
            if(model_date.get(0).month !== currentDate.getMonth()+1){
                set_datelist();
            }
        }else{
            set_datelist();
        }
        date_list.enabled = true;
        date_list.currentIndex = currentDate.getDate()-1;
        update_log();
    }

    function getyesterday(){
        var newdate = currentDate;
        newdate.setDate(currentDate.getDate() - 1);
        return newdate;
    }
    function gettomorrow(){
        var newdate = currentDate;
        newdate.setDate(currentDate.getDate() + 1);
        return newdate;
    }

    Rectangle{
        width: parent.width
        height: parent.height-statusbar.height
        anchors.bottom: parent.bottom
        color: "#f4f4f4"
        Rectangle{
            width: parent.width - 200
            height: parent.height
            color: "#f4f4f4"
            Row{
                id: rows_category
                spacing: 5
                Rectangle{
                    width: 250
                    height: 40
                    color: "#323744"
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        color: "white"
                        text: "로그"
                        font.pixelSize: 20
                    }
                }
                Rectangle{
                    width: 240
                    height: 40
                    color: "#647087"
                    Text{
                        anchors.centerIn: parent
                        font.family: font_noto_r.name
                        color: "white"
                        text: "UI"
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
                        text: "SLAM"
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
            SwipeView{
                id: date_list
                width: 300
                height: 40
                spacing: 30
                clip: false
                anchors.top: rows_category.bottom
                anchors.topMargin: 30
                enabled: false
                onCurrentIndexChanged: {
                    if(enabled){
//                        print("current index changed ", currentIndex, model_date.count);
                        if(model_date.count > currentIndex && currentIndex > -1){
                            if(model_date.get(currentIndex).date > 0){
                                var tempStr = supervisor.getLocaleDate(model_date.get(currentIndex).year, model_date.get(currentIndex).month, model_date.get(currentIndex).date);
                                setdate(Date.fromLocaleString(Qt.locale(),tempStr,"yyyy-MM-dd"));
                            }
                        }
                    }else{
//                        print("current index changed ff", currentIndex, model_date.count);
                    }
                }
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater{
                    model : ListModel{id: model_date}
                    Rectangle{
                        width: 100
                        height: 40
                        color: "transparent"
                        Text{
                            text: Number(month)+"월 "+Number(date)+"일 ("+week+")";
                            font.family: font_noto_b.name
                            font.pixelSize: 30
                            anchors.centerIn: parent
                        }
                    }
                }
            }
            Image{
                source: "icon/joy_left.png"
                anchors.verticalCenter: date_list.verticalCenter
                anchors.right: date_list.left
                width: 12
                height: 20
                sourceSize.width: width
                sourceSize.height: height
                ColorOverlay{
                    source: parent
                    anchors.fill: parent
                    color: color_navy
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        setdate(getyesterday());
                    }
                }
            }
            Image{
                source: "icon/joy_right.png"
                anchors.verticalCenter: date_list.verticalCenter
                anchors.left: date_list.right
                width: 12
                height: 20
                sourceSize.width: width
                sourceSize.height: height
                ColorOverlay{
                    source: parent
                    anchors.fill: parent
                    color: color_navy
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        setdate(gettomorrow());
                    }
                }
            }
            Rectangle{
                anchors.verticalCenter: date_list.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 100
                width: 40
                height: 40
                radius: 5
                border.width: 1
                Image{
                    source: "icon/icon_transmit_server.png"
                    anchors.fill: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        popup_calendar.open();
                    }
                }
            }
            Flickable{
                id: area_log
                width: parent.width
                anchors.top: date_list.bottom
                anchors.topMargin: 50
                anchors.bottom: parent.bottom
                contentHeight: column_log.height
                ScrollBar.vertical: ScrollBar{
                    width: 20
                    anchors.right: parent.right
                    policy: ScrollBar.AlwaysOn
                }
                clip: true
                Column{
                    id: column_log
                    spacing: 5
                    Repeater{
                        model: ListModel{id: model_log}
                        Rectangle{
                            width: area_log.width
                            height: 40
                            Row{
                                anchors.fill: parent
                                Rectangle{
                                    width: 200
                                    height: parent.height
                                    Text{
                                        anchors.centerIn: parent
                                        text: date
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                }

                                Rectangle{
                                    height: parent.height
                                    width: 3
                                    color: color_light_gray
                                }

                                Rectangle{
                                    width: 100
                                    height: parent.height
                                    Text{
                                        anchors.centerIn: parent
                                        text: auth
                                        font.family: font_noto_r.name
                                        font.pixelSize: 15
                                    }
                                }

                                Rectangle{
                                    height: parent.height
                                    width: 3
                                    color: color_light_gray
                                }

                                Rectangle{
                                    width: parent.width - 306
                                    height: parent.height
                                    Text{
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.left: parent.left
                                        anchors.leftMargin: 10
                                        font.pixelSize: {
                                            if(message.length > 80)
                                                12
                                            else
                                                15
                                        }

                                        text: message
                                        font.family: font_noto_r.name
                                    }
                                }
                            }
                            Rectangle{
                                width: parent.width
                                anchors.bottom: parent.bottom
                                height: 1
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
                    supervisor.writelog("[USER INPUT] LOG PAGE -> BACKPAGE");
                    backPage();
                }
            }
        }
    }

    Popup{
        id: popup_calendar
        anchors.centerIn: parent
        width: 500
        height: 500
        background: Rectangle{
            anchors.fill: parent
            color: "transparent"
        }

        Calendar{
            id: calendar
            anchors.fill: parent
            frameVisible: false
            weekNumbersVisible: false
            selectedDate: currentDate
            minimumDate: new Date(2023, 1, 1)
            maximumDate: new Date()
            style: CalendarStyle{
                dayDelegate: Rectangle{
                    color:{
                        if(styleData.valid && styleData.visibleMonth){
                            "white"
                        }else{
                            color_light_gray
                        }
                    }

                    Label {
                        text: styleData.date.getDate()
                        anchors.centerIn: parent
                        color: {
                            if(styleData.valid && styleData.visibleMonth){
                                if(supervisor.isHasLog(styleData.date)){
                                     "black"
                                }else{
                                    "grey"
                                }
                            }else{
                                "grey"
                            }
                        }
                    }

                    Image{
                        source: "icon/icon_point_1.png"
                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: 18
                        height: 20
                        visible: {
                            if(styleData.valid){
                                if(supervisor.isHasLog(styleData.date)){
                                     true
                                }else{
                                    false
                                }
                            }else{
                                false
                            }
                        }
                        ColorOverlay{
                            source: parent
                            anchors.fill: parent
                            color: color_green
                            visible: {
                                if(styleData.valid && styleData.visibleMonth){
                                    true
                                }else{
                                    false
                                }
                            }
                        }
                    }
                }
            }

            onClicked: {
                if(supervisor.isHasLog(selectedDate)){
                    setdate(selectedDate);
                    popup_calendar.close();
                }
            }
        }
    }
}
