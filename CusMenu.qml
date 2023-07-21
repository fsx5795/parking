import QtQuick.Controls 2.15
import QtQuick 2.15
Menu {
    delegate: MenuItem {
        contentItem: Text {
            text: parent.text
            color: "white"
            font.family: 'Microsoft YaHei UI'
        }
        background: Rectangle {
            color: parent.highlighted ? "#3337b3" : "#21252b"
        }
    }
}