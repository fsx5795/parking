import QtQuick.Controls 2.15
import QtQuick 2.15
Dialog {
    id: rootDialog
    modal: true
    property alias confirmBtn: confirmBtn
    header: Rectangle {
        id: headRect
        width: parent.width
        height: 30
        color: "#282C34"
        Text {
            text: rootDialog.title
            color: "#9da5b4"
            anchors.centerIn: parent
            font {
                family: "Microsoft YaHei UI"
                pixelSize: 18
                bold: true
            }
        }
        MouseArea {
            property point clickPos
            anchors.fill: headRect
            acceptedButtons: Qt.LeftButton
            onPressed: clickPos = Qt.point(mouseX, mouseY)
            onPositionChanged: {
                console.log("pos")
                var delta = Qt.point(mouseX - clickPos.x, mouseY - clickPos.y)
                rootDialog.x = rootDialog.x + delta.x
                rootDialog.y = rootDialog.y + delta.y
            }
        }
    }
    footer: DialogButtonBox {
        spacing: 10
        rightPadding: 20
        Button {
            id: cancelBtn
            Text {
                color: "#9da5b4"
                text: qsTr("取消")
            }
            background: Rectangle {
                implicitWidth: 50
                implicitHeight: 20
                border.color: "transparent"
                color: "#282C34"
            }
            onClicked: rootDialog.reject()
        }
        Button {
            id: confirmBtn
            Text {
                color: "#9da5b4"
                text: qsTr("确定")
            }
            background: Rectangle {
                implicitWidth: 50
                implicitHeight: 20
                border.color: "transparent"
                color: "#282C34"
            }
        }
        background: Rectangle {
            x: 0; y: 0
            width: parent.width
            height: parent.height
            color: "#282C34"
        }
    }
    background: Rectangle {
        color: "#282C34"
    }
}
