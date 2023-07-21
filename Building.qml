import QtQuick 2.15
import QtQuick.Layouts 1.15
Rectangle {
    property string num
    opacity: 0.8
    Layout.columnSpan: 1
    implicitWidth: 200
    implicitHeight: 200
    color: "#1d1f23"
    border.color: "black"
    Layout.fillWidth: true
    Layout.fillHeight: true
    Text {
        color: "#9da5b4"
        anchors.centerIn: parent
        text: num
        font {
            family: "Microsoft YaHei UI"
            pixelSize: 18
            bold: true
        }
    }
}
