import QtQuick 2.12
import QtQuick.Controls 2.12


// 가능한 모든 맵 리스트 보여주기
Popup{
    id: popup_map_list
    width: 1280
    height: 800
    closePolicy: Popup.NoAutoClose
    leftPadding: 0
    rightPadding: 0
    topPadding: 0
    bottomPadding: 0
    property string temp_name: ""
    property int select_map_list: -1
    background:Rectangle{
        anchors.fill: parent
        color: "#282828"
        opacity: 0.8
    }
    onOpened: {
        list_map.model.clear();
        var num = supervisor.getAvailableMap();
        var mapname = supervisor.getMapname();
        btn_use.enabled = false;
        btn_draw.enabled = false;
        btn_erase.enabled = false;
        map_list_view.enabled = true;
        map_list_view.setViewer("annot_view");
        for(var i=0; i<num; i++){
            list_map.model.append({"name":supervisor.getAvailableMapPath(i),"selected":false});
            if(mapname === supervisor.getAvailableMapPath(i)){
                select_map_list = i;
                if(supervisor.isExistMap(mapname)){
                    print(mapname, "map exist");
                    map_list_view.loadmap(mapname,"EDITED");
                    if(supervisor.isExistAnnotation(mapname)){
                        btn_use.enabled = true;
                        btn_draw.enabled = true;
                        btn_draw_new.enabled = true;
                    }else{
                        btn_use.enabled = false;
                        btn_draw.enabled = false;
                        btn_draw_new.enabled = true;
                    }
                }else{
                    print(mapname, "map no exist");
                    map_list_view.loadmap(mapname,"RAW");
                    if(supervisor.isExistRawMap(mapname)){
                        btn_draw_new.enabled = true;
                        if(supervisor.isExistAnnotation(mapname)){
                            btn_draw.enabled = true;
                        }
                    }else{

                    }
                }

                list_map_detail.model.clear();
                var num1 = supervisor.getMapFileSize(mapname);
                for(var ii=0; i<num1; i++){
                    list_map_detail.model.append({"name":supervisor.getMapFile(ii)});
                }
                supervisor.readSetting(mapname);
            }
        }
    }
    onClosed:{
        map_list_view.enabled = false;
    }

    function update_list(){
        list_map.model.clear();
        var num = supervisor.getAvailableMap();
        for(var i=0; i<num; i++){
            list_map.model.append({"name":supervisor.getAvailableMapPath(i),"selected":false});
        }
        select_map_list = -1;
        map_list_view.loadmap("");
    }

    Component{
        id: maplistCompo
        Item{
            width: parent.width
            height: 40
            Rectangle{
                id: background
                visible: select_map_list==index?true:false
                anchors.fill: parent
                radius: 5
                color: "#12d27c"
            }
            Text{
                id: text_map_name
                anchors.centerIn: parent
                font.family: font_noto_r.name
                text: name
                color: "white"
            }
            Rectangle//리스트의 구분선
            {
                id:line
                width:parent.width
                anchors.bottom:parent.bottom//현재 객체의 아래 기준점을 부모객체의 아래로 잡아주어서 위치가 아래로가게 설정
                height:1
                color: "#d0d0d0"
            }
            MouseArea{
                id:area_compo
                anchors.fill:parent
                onClicked: {
                    click_sound.play();
                    list_map.currentIndex = index;
                    if(select_map_list == index){
                        select_map_list = -1;
                        map_list_view.loadmap("");
                        btn_use.enabled = false;
                        btn_draw.enabled = false;
                        btn_draw_new.enabled = false;
                        btn_erase.enabled = false;
                    }else{
                        select_map_list = index;
                        btn_erase.enabled = true;
                        if(supervisor.isExistMap(name)){
                            map_list_view.loadmap(name,"EDITED");
                            if(supervisor.isExistAnnotation(name)){
                                btn_use.enabled = true;
                                btn_draw.enabled = true;
                                btn_draw_new.enabled = true;
                            }else{
                                btn_use.enabled = false;
                                btn_draw.enabled = true;
                                btn_draw_new.enabled = true;
                            }
                        }else{
                            map_list_view.loadmap(name,"RAW");
                            if(supervisor.isExistRawMap(name)){
                                btn_draw_new.enabled = true;
                                btn_use.enabled = false;
                                btn_draw.enabled = false;
                                if(supervisor.isExistAnnotation(name)){
                                    btn_draw.enabled = true;
                                }
                            }else{
                                btn_use.enabled = false;
                                btn_draw.enabled = false;
                            }
                        }
                        list_map_detail.model.clear();
                        var num = supervisor.getMapFileSize(name);
                        for(var i=0; i<num; i++){
                            list_map_detail.model.append({"name":supervisor.getMapFile(i)});
                        }

                        supervisor.readSetting(name);
                    }
                    map_list_view.setViewer("annot_view");

//                    map_list_view.update_canvas();
                }
            }
        }

    }
    Component{
        id: mapdetaillistCompo
        Item{
            width: parent.width
            height: 40
//            Rectangle{
//                id: background
//                visible: select_map_list==index?true:false
//                anchors.fill: parent
//                radius: 5
//                color: "#12d27c"
//            }
            Text{
                id: text_map_name
                anchors.centerIn: parent
                font.family: font_noto_r.name
                text: name
                color: "white"
            }
            Rectangle//리스트의 구분선
            {
                id:line
                width:parent.width
                anchors.bottom:parent.bottom//현재 객체의 아래 기준점을 부모객체의 아래로 잡아주어서 위치가 아래로가게 설정
                height:1
                color: "#d0d0d0"
            }
            MouseArea{
                id:area_compo
                anchors.fill:parent
                onClicked: {
                    click_sound.play();
                    list_map_detail.currentIndex = index;
                }
            }
        }

    }



    Rectangle{
        width: 900
        height: 800
        anchors.centerIn: parent
        color:"transparent"
        Rectangle{
            id: rect_list_top
            height: 100
            width: parent.width
            color: "transparent"
            Column{
                anchors.centerIn: parent
                spacing: 10
                Text{
                    id: text_list_title
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "white"
                    font.family: font_noto_b.name
                    font.bold: true
                    text: "확인된 맵 목록"
                    font.pixelSize: 30
                }
                Text{
                    id: text_list_title2
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "white"
                    font.family: font_noto_r.name
                    text: "사용 가능한 맵 파일을 모두 찾았습니다. 원하는 파일을 선택하신 후 확인 버튼을 눌러주세요."
                    font.pixelSize: 15
                }
            }

        }

        Rectangle{
            id: rect_list_top2
            color: "transparent"
            height: 100
            width: parent.width
            anchors.top: rect_list_top.bottom
            Row{
                anchors.centerIn: parent
                spacing: 100
                Rectangle{
                    id: rect_list_menus
                    width: rect_list_top2.width
                    height: 100
                    radius: 5
                    color: color_gray
                    Row{
                        anchors.centerIn: parent
                        spacing: 50
                        Rectangle{
                            id: btn_use
                            width: 78
                            height: width
                            radius: width
                            anchors.verticalCenter: parent.verticalCenter
                            enabled: false
                            color:enabled?"white":"#f4f4f4"
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    source: "icon/icon_move.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "사용"
                                    font.family: font_noto_r.name
                                    color: btn_use.enabled?color_dark_black:color_gray
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    click_sound.play();
                                    if(select_map_list > -1){
                                        supervisor.writelog("[USER INPUT] Map used changed : " + list_map.model.get(select_map_list).name);
                                        supervisor.setMap(list_map.model.get(select_map_list).name);
                                        loader_page.item.init();
                                        popup_map_list.close();
                                    }
                                }
                            }
                        }
                        Rectangle{
                            id: btn_draw
                            width: 78
                            anchors.verticalCenter: parent.verticalCenter
                            height: width
                            radius: width
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    source: "icon/icon_draw.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "수정"
                                    color: btn_use.enabled?color_dark_black:color_gray
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    click_sound.play();
                                    if(select_map_list > -1){
                                        var name = list_map.model.get(select_map_list).name;
                                        popup_map_list.close();
                                        print(name);
                                        supervisor.readSetting(name);
                                        loadPage(pmap);
                                        loader_page.item.loadmap(name);
                                        loader_page.item.is_init_state = true;
                                        loader_page.item.map_mode = 2;
//                                        loader_page.item.init();
                                    }
                                }
                            }
                        }
                        Rectangle{
                            id: btn_erase
                            width: 78
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            radius: width
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    source: "icon/icon_erase.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "삭제"
                                    color: btn_use.enabled?color_dark_black:color_gray
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    click_sound.play();
                                    supervisor.removeMap(list_map.model.get(select_map_list).name);
                                    popup_map_list.update_list();
                                }
                            }
                        }
                        Rectangle{
                            id: btn_draw_new
                            width: 78
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            radius: width
                            Column{
                                anchors.centerIn: parent
                                Image{
                                    source: "icon/icon_draw.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                Text{
                                    text: "새로 수정"
                                    color: btn_use.enabled?color_dark_black:color_gray
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    click_sound.play();
                                    if(select_map_list > -1){
                                        var name = list_map.model.get(select_map_list).name;
                                        print("name : ",name);
                                        if(supervisor.isExistAnnotation(name)){
                                            temp_name = list_map.model.get(select_map_list).name;
                                            popup_annotation_delete.name = name;
                                            popup_annotation_delete.open();
                                        }else{
                                            supervisor.loadMap(name);
                                            loadPage(pmap);
                                            loader_page.item.loadmap(name,"RAW");
                                            loader_page.item.map_mode = 2;
                                            loader_page.item.is_init_state = true;
                                            popup_map_list.close();
                                        }
                                    }
                                }
                            }
                        }

                        Rectangle{
                            id: btn_menu
                            width: 100
                            height: width
                            color: color_gray
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
                                    click_sound.play();
                                    popup_map_list.close();
                                }
                            }
                        }
                    }
                }
            }
        }


        Rectangle{
            id: rect_list_left
            height: parent.height - rect_list_top.height - rect_list_top2.height
            width: parent.width - map_list_view.width
            color: "transparent"
            anchors.top: rect_list_top2.bottom
            Row{
                anchors.centerIn: parent
                ListView {
                    id: list_map
                    width: select_map_list==-1?rect_list_left.width:rect_list_left.width/2
                    Behavior on width {
                        NumberAnimation{
                            duration : 500;
                        }
                    }

                    height: 500
                    clip: true
                    model: ListModel{}
                    delegate: maplistCompo
                    //focus: true
                }
                ListView {
                    id: list_map_detail
//                        visible: select_map_list==-1?false:true
                    width: select_map_list==-1?0:rect_list_left.width/2
                    Behavior on width {
                        NumberAnimation{
                            duration : 500;
                        }
                    }
//                        width: 200
                    height: 500
                    clip: true
                    model: ListModel{}
                    delegate: mapdetaillistCompo
//                    focus: true
                }
            }


        }

        Rectangle{
            id: rect_list_right
            color: "transparent"
            width: parent.width - rect_list_left.width
            height: parent.height - rect_list_top.height - rect_list_top2.height
            anchors.top: rect_list_left.top
            anchors.left: rect_list_left.right

            MAP_FULL2{
                id: map_list_view
                objectName: "POPUP"
                width: parent.height-100
                height: parent.height-100
                anchors.centerIn: parent
                show_connection: false
                Component.onCompleted: {
                    setfullscreen();
                    setViewer("annot_view")
                }
            }
        }
    }
    Popup{
        id: popup_annotation_delete
        width: parent.width
        height: parent.height
        background:Rectangle{
            anchors.fill: parent
            color: "#282828"
            opacity: 0.7
        }
        property string name: ""
        Rectangle{
            anchors.centerIn: parent
            width: 400
            height: 250
            color: "white"
            radius: 10

            Column{
                anchors.centerIn: parent
                spacing: 40
                Column{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: "기존 맵 설정이 삭제됩니다."
                        font.family: font_noto_r.name
                        font.pixelSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Rectangle{
                        id: btn_prev_00
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
                            onClicked:{
                                click_sound.play();
                                popup_annotation_delete.close();
                            }
                        }
                    }
                    Rectangle{
                        id: btn_next_00
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
                            onClicked:{
                                click_sound.play();
                                supervisor.deleteAnnotation();
                                supervisor.setMap(name);
                                loadPage(pmap);
                                loader_page.item.loadmap(popup_annotation_delete.name,"RAW");
                                loader_page.item.is_init_state = true;
                                loader_page.item.map_mode = 2;
                                popup_annotation_delete.close();
                                popup_map_list.close();
                            }
                        }
                    }
                }
            }
        }
    }
}


