import QtQuick.Controls 2.15
import QtQuick 2.15
import Qt.labs.platform 1.1 as Platform
import QtQuick.Layouts 1.15
/*
import QtQuick.LocalStorage
import "database.js" as DB
*/
BaseDialog {
    id: editDialog
    closePolicy: Popup.NoAutoClose
    Component.onCompleted: {
    /*
        DB.initDatabase();
        console.log(DB.getParkingData(title));
    */
        //building TEXT, name TEXT, phone TEXT, vehicle TEXT, parking INTEGER, start TEXT, end TEXT, pay TEXT
        var info = sqlite.getParkingInfo(title)
        building.text = info.building.toString()
        name.text = info.name.toString()
        phone.text = info.phone.toString()
        vehicle.text = info.vehicle.toString()
        start.text = info.start.toString()
        end.text = info.end.toString()
        pay.text = info.pay.toString()
    }
    Platform.MessageDialog {
        id: messageDialog
        title: qsTr("错误")
        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
    contentItem: Rectangle {
        implicitHeight: 300
        anchors.top: parent.header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.footer.top
        color: "#282C34"
        GridLayout {
            columns: 2
            rowSpacing: 10
            anchors.fill: parent
            anchors.margins: 10
            Text {
                text: qsTr("楼栋:")
                color: "#9da5b4"
            }
            LineEdit { id: building }
            Text {
                text: qsTr("姓名:")
                color: "#9da5b4"
            }
            LineEdit { id: name }
            Text {
                text: qsTr("手机:")
                color: "#9da5b4"
            }
            LineEdit { id: phone }
            Text {
                text: qsTr("车牌号:")
                color: "#9da5b4"
            }
            LineEdit { id: vehicle }
            Text {
                text: qsTr("起始日期:")
                color: "#9da5b4"
            }
            LineEdit { id: start }
            Text {
                text: qsTr("终止日期:")
                color: "#9da5b4"
            }
            LineEdit { id: end }
            Text {
                text: qsTr("缴费日期:")
                color: "#9da5b4"
            }
            LineEdit { id: pay }
        }
    }
    Connections {
        target: confirmBtn
        function onClicked() {
            if (building.text.length === 0)
                messageDialog.show("楼栋不能为空!");
            else if (name.text.length === 0)
                messageDialog.show("姓名不能为空!");
            else if (phone.text.length === 0)
                messageDialog.show("手机号不能为空!");
            else if (vehicle.text.length === 0)
                messageDialog.show("车牌号不能为空!");
            else if(Date.fromLocaleDateString(Qt.locale(), start.text, "yyyyMMdd").toString() === "Invalid Date")
                messageDialog.show("起始日期格式有误")
            else if(Date.fromLocaleDateString(Qt.locale(), end.text, "yyyyMMdd").toString() === "Invalid Date")
                messageDialog.show("终止日期格式有误")
            else if(Date.fromLocaleDateString(Qt.locale(), pay.text, "yyyyMMdd").toString() === "Invalid Date")
                messageDialog.show("缴费日期格式有误")
            else
            {
                if (sqlite.setParkingInfo(building.text, name.text, phone.text, vehicle.text, title, start.text, end.text, pay.text) === false)
                    messageDialog.show("数据保存失败!")
                editDialog.close()
            }
        }
    }
}
