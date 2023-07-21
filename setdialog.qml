import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Shapes 1.15
import QtQml 2.15
BaseDialog {
    id: setDialog
    property alias spinBox: spinBox
    title: qsTr("过期提前提醒设置")
    implicitWidth: 350
    implicitHeight: 300
    contentItem: Item {
        anchors.top: parent.header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.footer.top
        RowLayout {
            anchors.fill: parent
            anchors.margins: 30
            Text {
                text: qsTr("提前")
                color: "#9da5b4"
                font.pixelSize: 15
                Layout.fillWidth: true
            }
            SpinBox {
                id: spinBox
                editable: true
                value: configure.getRemindDays()
                height: 30
                Layout.fillWidth: true
                contentItem: TextInput {
                    text: spinBox.textFromValue(spinBox.value, spinBox.locale)
                    color: "#9da5b4"
                    readOnly: !spinBox.editable
                    validator: spinBox.validator
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                }
                up.indicator: Rectangle {
                    id: upRect
                    x: parent.width - implicitWidth
                    implicitWidth: parent.height
                    implicitHeight: parent.height
                    color: "#282C34"
                    Text {
                        text: "+"
                        color: "#9da5b4"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    //绘制左边框
                    Shape {
                        anchors.fill: parent
                        ShapePath {
                            strokeColor: "black"
                            startX: 0
                            startY: 0
                            PathLine {
                                x: 0
                                y: upRect.implicitHeight
                            }
                        }
                    }
                }
                down.indicator: Rectangle {
                    id: downRect
                    x: 0
                    height: parent.height
                    color: "#282C34"
                    implicitWidth: parent.height
                    Text {
                        text: "-"
                        color: "#9da5b4"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    //绘制右边框
                    Shape {
                        anchors.fill: parent
                        ShapePath {
                            strokeColor: "black"
                            startX: downRect.width
                            startY: 0
                            PathLine {
                                x: downRect.width
                                y: upRect.implicitHeight
                            }
                        }
                    }
                }
                background: Rectangle {
                    implicitWidth: parent.height
                    implicitHeight: parent.height
                    color: "#1d1f23"
                    border.color: "black"
                }
            }
            Text {
                color: "#9da5b4"
                text: qsTr("天")
                font.pixelSize: 15
                Layout.fillWidth: true
            }
        }
    }
    Connections {
        target: confirmBtn
        function onClicked() {
            setDialog.accept()
        }
    }
}
