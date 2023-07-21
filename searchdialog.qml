import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.platform 1.1 as Platform
import QtQuick.Layouts 1.15
import ParkModel 1.0
BaseDialog {
    id: searchDialog
    title: qsTr("搜索")
    property var results
    Platform.MessageDialog {
        id: messageDialog
        title: qsTr("错误")
        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
    contentItem: Item {
        implicitWidth: 500
        implicitHeight: 300
        anchors.top: parent.header.bottom
        anchors.bottom: parent.footer.top
        ColumnLayout {
            anchors.fill: parent
            HorizontalHeaderView {
                id: horizontalHeader
                Layout.fillWidth: true
                rowHeightProvider: function(column) { return 25 }
                syncView: tableView
                delegate: Rectangle {
                    color: "#282C34"
                    Text {
                        color: "#9da5b4"
                        anchors.centerIn: parent
                        text: display
                    }
                }
            }
            TableView {
                id: tableView
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.bottomMargin: 5
                //topMargin: horizontalHeader.implicitHeight
                //关闭拖动效果
                boundsBehavior: Flickable.OvershootBounds
                //行高
                rowHeightProvider: function(column) { return 25 }
                //columnWidthProvider: function(column) { return 60 }
                columnSpacing: 10
                model: ParkModel {
                    id: parkModel
                }
                delegate: Rectangle {
                    color: "#282C34"
                    Text {
                        color: "#9da5b4"
                        text: display
                        anchors.centerIn: parent
                    }
                }
            }
            /*
            Item {
                Layout.preferredHeight: 10
            }
            */
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                ComboBox {
                    id: comboBox
                    model: [
                        qsTr("姓名:"),
                        qsTr("手机:"),
                        qsTr("车牌号:")
                    ]
                    delegate: ItemDelegate {
                        width: comboBox.width
                        //下拉列表各项文本
                        contentItem: Text {
                            color: "#9da5b4"
                            text: modelData
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }
                        //下拉列表
                        background: Rectangle {
                            width: parent.width
                            height: parent.height
                            color: comboBox.highlightedIndex === index ? "blue" : "#282C34"
                         }
                    }
                    indicator: Canvas {
                        id: canvas
                        x: comboBox.width - width - comboBox.rightPadding
                        y: comboBox.topPadding + (comboBox.availableHeight - height) / 2
                        width: 12
                        height: 8
                        contextType: "2d"
                        Connections {
                            target: comboBox
                            function onPressedChanged() { canvas.requestPaint(); }
                        }
                        onPaint: {
                            context.reset();
                            context.moveTo(0, 0);
                            context.lineTo(width, 0);
                            context.lineTo(width / 2, height)
                            context.closePath();
                            context.fillStyle = comboBox.pressed ? "#17a81a" : "#21be2b";
                            context.fill();
                        }
                    }
                    //文本
                    contentItem: Text {
                        color: "#9da5b4"
                        text: comboBox.displayText
                        leftPadding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 30
                        color: "#282C34"
                        border.color: "black"
                    }
                    //弹出框
                    popup: Popup {
                        y: comboBox.height - 1
                        width: comboBox.width
                        implicitHeight: contentItem.implicitHeight
                        padding: 1
                        contentItem: ListView {
                            clip: true
                            implicitHeight: contentHeight
                            model: comboBox.popup.visible ? comboBox.delegateModel : null
                            currentIndex: comboBox.highlightedIndex
                            ScrollIndicator.vertical: ScrollIndicator{}
                        }
                        background: Rectangle {
                            color: "#282C34"
                            border.color: "black"
                        }
                    }
                }
                LineEdit { id: lineEdit }
            }
        }
    }
    Connections {
        target: confirmBtn
        function onClicked() {
            if (lineEdit.text.length === 0)
                messageDialog.show("搜索内容不能为空!");
            else
            {
                results = sqlite.searchParkingInfo(comboBox.currentIndex, lineEdit.text);
                parkModel.setData(results)
            }
        }
    }
}
