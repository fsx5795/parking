import QtQuick.Controls 2.15
import QtQuick 2.15
import QtQuick.Layouts 1.15
import Configure 1.0
import Sqlite 1.0
import QtQuick.Window 2.15
import Qt.labs.platform 1.1 as Pf
import QtQuick.Controls.Universal 2.15
import QtGraphicalEffects 1.15
ApplicationWindow {
    id: mainWindow
    width: 800
    height: 600
    visible: true
    visibility: 'Maximized'
    color: "#282C34"
    flags: Qt.Window | Qt.FramelessWindowHint
    Universal.theme: Universal.Dark
    Universal.accent: Universal.Violet
    property string curClickedParking
    function updateOverState(item) {
        item.color = configure.getOverState(item.text)
    }
    Sqlite {
        id: sqlite
    }
    Configure {
        id: configure
    }
    Loader {
        id: loadWindow
        anchors.centerIn: parent
    }
    QuestionDialog {
        id: questionDialog
    }
    CusMenu {
        id: optionMenu
        Action {
            text: qsTr("修改")
            onTriggered: {
                loadWindow.setSource("qrc:/editdialog.qml", { "title": curClickedParking })
                loadWindow.item.open()
            }
        }
        Action {
            text: qsTr("删除")
            onTriggered: {
                questionDialog.show(qsTr("确定删除?"))
                questionDialog.accepted.connect(function(){
                    if (!sqlite.deleteParking(curClickedParking))
                        questionDialog.show(qsTr("删除失败"))
                })
            }
        }
    }
    menuBar: MenuBar {
        id: mainMenuBar
        CusMenu {
            title: qsTr("开始")
            Action {
                text: qsTr("关闭")
                onTriggered: mainWindow.hide()
            }
        }
        CusMenu {
            title: qsTr("工具")
            Action {
                text: qsTr("设置")
                onTriggered: {
                    var component = Qt.createComponent("qrc:/setdialog.qml")
                    if (component.status === Component.Ready) {
                        var dialog = component.createObject(mainWindow)
                        dialog.open()
                        dialog.accepted.connect(function(){
                            configure.setRemindDays(dialog.spinBox.value)
                        })
                    }
                }
            }
            Action {
                text: qsTr("搜索")
                onTriggered: {
                    var component = Qt.createComponent("qrc:/searchdialog.qml")
                    if (component.status === Component.Ready) {
                        var dialog = component.createObject(mainWindow)
                        dialog.open()
                    }
                }
            }
        }
        delegate: MenuBarItem {
            contentItem: Text {
                text: parent.text
                color: "white"
                font.family: 'Microsoft YaHei UI'
            }
            background: Rectangle {
                color: parent.highlighted ? "#3337b3" : "transparent"
            }
        }
        background: Rectangle {
            color: Qt.rgba(33 / 255, 27 / 255, 43 / 255, 0.5)
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                onPressed: mainWindow.startSystemMove()
                onDoubleClicked: mainWindow.visibility = mainWindow.visibility === Window.Maximized ? Window.Windowed : Window.Maximized
            }
        }
    }
    Image {
        anchors.fill: scrollView
        id: bug
        source: 'qrc:/Light.jpg'
        smooth: true
        visible: false
    }
    FastBlur {
        anchors.fill: bug
        source: bug
        radius: 64
    }
    ScrollView {
        id: scrollView
        anchors.fill: parent
        GridLayout {
            anchors.fill: parent
            columns: 7
            rowSpacing: 8
            columnSpacing: 8
            anchors.margins: 15
            Building {
                num: qsTr("45#")
                Layout.columnSpan: 2
            }
            Building { num: qsTr("44#") }
            Building { num: qsTr("43#") }
            Building { num: qsTr("幼儿园") }
            ColumnLayout {
                spacing: 0
                Building { num: qsTr("42#") }
                RowLayout {
                    id: layout_42
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                Building { num: qsTr("41#") }
                RowLayout {
                    id: layout_41
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                RowLayout {
                    id: layout_29t
                    spacing: 0
                }
                Building { num: qsTr("29#") }
                RowLayout {
                    id: layout_29b
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                RowLayout {
                    id: layout_28t
                    spacing: 0
                }
                Building { num: qsTr("28#") }
                RowLayout {
                    id: layout_28b
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                Building { num: qsTr("40#") }
                RowLayout {
                    id: layout_40
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                Building { num: qsTr("39#") }
                RowLayout {
                    id: layout_39
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                Building { num: qsTr("38#") }
                RowLayout {
                    id: layout_38
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                Building { num: qsTr("15#") }
                RowLayout {
                    id: layout_15
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                Building { num: qsTr("14#") }
                RowLayout {
                    id: layout_14
                    spacing: 0
                }
            }
            Building { num: qsTr("27#") }
            Building { num: qsTr("26#") }
            ColumnLayout {
                spacing: 0
                RowLayout {
                    id: layout_37
                    spacing: 0
                }
                Building { num: qsTr("37#") }
            }
            Building { num: qsTr("36#") }
            ColumnLayout {
                spacing: 0
                RowLayout {
                    id: layout_35
                    spacing: 0
                }
                Building { num: qsTr("35#") }
            }
            ColumnLayout {
                spacing: 0
                Building { num: qsTr("13#") }
                RowLayout {
                    id: layout_13
                    spacing: 0
                }
            }
            Building { num: qsTr("12#") }
            ColumnLayout {
                spacing: 0
                RowLayout {
                    id: layout_25t
                    spacing: 0
                }
                Building { num: qsTr("25#") }
                RowLayout {
                    id: layout_25b
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                RowLayout {
                    id: layout_24t
                    spacing: 0
                }
                Building { num: qsTr("24#") }
                RowLayout {
                    id: layout_24b
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                Building { num: qsTr("32#") }
                RowLayout {
                    id: layout_32
                    spacing: 0
                }
            }
            Building { num: qsTr("34#") }
            Building { num: qsTr("33#") }
            Building { num: qsTr("11#") }
            ColumnLayout {
                spacing: 0
                RowLayout {
                    id: layout_10
                    spacing: 0
                }
                Building { num: qsTr("10#") }
            }
            Building { num: qsTr("23#") }
            Building { num: qsTr("22#") }
            Building { num: qsTr("31#") }
            Building { num: qsTr("30#") }
            Item { Layout.fillWidth: true }
            ColumnLayout {
                spacing: 0
                Building { num: qsTr("9#") }
                RowLayout {
                    id: layout_9
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                Building { num: qsTr("8#") }
                RowLayout {
                    id: layout_8
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                RowLayout {
                    id: layout_21t
                    spacing: 0
                }
                Building { num: qsTr("21#") }
                RowLayout {
                    id: layout_21b
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                RowLayout {
                    id: layout_20t
                    spacing: 0
                }
                Building { num: qsTr("20#") }
                RowLayout {
                    id: layout_20b
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                RowLayout {
                    id: layout_19t
                    spacing: 0
                }
                Building { num: qsTr("19#") }
                RowLayout {
                    id: layout_19b
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                RowLayout {
                    id: layout_7t
                    spacing: 0
                }
                Building { num: qsTr("7#") }
                RowLayout {
                    id: layout_7b
                    spacing: 0
                }
            }
            ColumnLayout {
                spacing: 0
                Building { num: qsTr("6#") }
                RowLayout {
                    id: layout_6
                    spacing: 0
                }
            }
            Building { num: qsTr("5#") }
            Building { num: qsTr("4#") }
            Building { num: qsTr("18#") }
            Building { num: qsTr("17#") }
            Building { num: qsTr("16#") }
            Building { num: qsTr("3#") }
            ColumnLayout {
                spacing: 0
                RowLayout {
                    id: layout_2
                    spacing: 0
                }
                Building { num: qsTr("2#") }
            }
            Building {
                num: qsTr("1#")
                Layout.columnSpan: 2
            }
        }
    }
    Component {
        id: rectComponent
        Rectangle {
            id: rec
            property string text: text
            implicitWidth: 50
            implicitHeight: 50
            color: "#1d1f23"
            border.color: "black"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Text {
                anchors.centerIn: parent
                color: "white"
                text: parent.text
            }
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onClicked: {
                    curClickedParking = parent.text
                    optionMenu.popup()
                }
            }
            Connections {
                target: configure
                function onUpdateOverState() {
                    updateOverState(rec)
                }
            }
            Connections {
                target: sqlite
                function onUpdateParking(parking) {
                    if (parking === rec.text) {
                        updateOverState(rec)
                    }
                }
            }
            Component.onCompleted:{
                updateOverState(rec)
            }
        }
    }
    Component.onCompleted: {
        var i = 317;
        while (i >= 310) {
            var obj = rectComponent.createObject(layout_29t, { "text": i } )
            --i
        }
        while (i >= 302) {
            rectComponent.createObject(layout_28t, { "text": i } )
            --i
        }
        i = 298;
        while (i > 288) {
            rectComponent.createObject(layout_42, {"text": i})
            --i
        }
        while (i >= 275) {
            rectComponent.createObject(layout_41, {"text": i})
            --i
        }
        while (i >= 263) {
            rectComponent.createObject(layout_29b, {"text": i})
            --i
        }
        while (i > 250) {
            rectComponent.createObject(layout_28b, {"text": i})
            --i
        }
        while (i >= 240) {
            rectComponent.createObject(layout_40, {"text": i})
            --i
        }
        while (i >= 225) {
            rectComponent.createObject(layout_39, {"text": i})
            --i
        }
        while (i >= 210) {
            rectComponent.createObject(layout_38, {"text": i})
            --i
        }
        while (i >= 207) {
            rectComponent.createObject(layout_35, {"text": i})
            --i
        }
        while (i > 198) {
            rectComponent.createObject(layout_15, {"text": i})
            --i
        }
        while (i >= 187) {
            rectComponent.createObject(layout_14, {"text": i})
            --i
        }
        while (i > 180) {
            rectComponent.createObject(layout_13, {"text": i})
            --i
        }
        while (i >= 178) {
            rectComponent.createObject(layout_10, {"text": i})
            --i
        }
        while (i >= 172) {
            rectComponent.createObject(layout_25t, {"text": i})
            --i
        }
        while (i >= 162) {
            rectComponent.createObject(layout_24t, {"text": i})
            --i
        }
        while (i >= 154) {
            rectComponent.createObject(layout_25b, {"text": i})
            --i
        }
        while (i >= 140) {
            rectComponent.createObject(layout_24b, {"text": i})
            --i
        }
        while (i >= 130) {
            rectComponent.createObject(layout_32, {"text": i})
            --i
        }
        while (i > 116) {
            rectComponent.createObject(layout_9, {"text": i})
            --i
        }
        while (i > 108) {
            rectComponent.createObject(layout_8, {"text": i})
            --i
        }
        while (i >= 104) {
            rectComponent.createObject(layout_21t, {"text": i})
            --i
        }
        while (i > 98) {
            rectComponent.createObject(layout_20t, {"text": i})
            --i
        }
        while (i >= 95) {
            rectComponent.createObject(layout_19t, {"text": i})
            --i
        }
        while (i > 90) {
            rectComponent.createObject(layout_7t, {"text": i})
            --i
        }
        while (i >= 75) {
            rectComponent.createObject(layout_21b, {"text": i})
            --i
        }
        while (i >= 60) {
            rectComponent.createObject(layout_20b, {"text": i})
            --i
        }
        while (i >= 43) {
            rectComponent.createObject(layout_19b, {"text": i})
            --i
        }
        while (i > 38) {
            rectComponent.createObject(layout_7b, {"text": i})
            --i
        }
        while (i >= 27) {
            rectComponent.createObject(layout_6, {"text": i})
            --i
        }
        while (i >= 23) {
            rectComponent.createObject(layout_2, {"text": i})
            --i
        }
    }
    property real shellLength: 4
    MouseArea {
        id: leftArea
        z: 100
        anchors.left: topLeftArea.left
        anchors.top: topLeftArea.bottom
        anchors.bottom: bottomLeftArea.top
        anchors.right: bottomLeftArea.right
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.SizeHorCursor
        onPressed: mainWindow.startSystemResize(Qt.LeftEdge)
    }
    Pf.SystemTrayIcon {
        id: tray
        visible: true
        icon.source: 'qrc:/tray.png'
        tooltip: qsTr('金色港湾车位信息')
        menu: Pf.Menu {
            Pf.MenuItem {
                text: qsTr("退出")
                onTriggered: Qt.quit()
            }
        }
    }
    MouseArea {
        id: topLeftArea
        width: shellLength
        height: shellLength
        z: 100
        anchors.left: parent.left
        anchors.top: menuBar ? menuBar.top : header ? header.top : parent.top
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.SizeFDiagCursor
        onPressed: mainWindow.startSystemResize(Qt.TopEdge | Qt.LeftEdge)
    }
    MouseArea {
        id: topArea
        z: 100
        anchors.top: topLeftArea.top
        anchors.left: topLeftArea.right
        anchors.right: topRightArea.left
        anchors.bottom: topRightArea.bottom
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.SizeVerCursor
        onPressed: mainWindow.startSystemResize(Qt.TopEdge)
    }
    MouseArea {
        id: topRightArea
        width: shellLength
        height: shellLength
        z: 100
        anchors.top: menuBar ? menuBar.top : header ? header.top : parent.top
        anchors.right: parent.right
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.SizeBDiagCursor
        onPressed: mainWindow.startSystemResize(Qt.TopEdge | Qt.RightEdge)
    }
    MouseArea {
        id: rightArea
        z: 100
        anchors.right: topRightArea.right
        anchors.top: topRightArea.bottom
        anchors.bottom: bottomRightArea.bottom
        anchors.left: bottomRightArea.left
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.SizeHorCursor
        onPressed: mainWindow.startSystemResize(Qt.RightEdge)
    }
    MouseArea {
        id: bottomRightArea
        width: shellLength
        height: shellLength
        z: 100
        anchors.bottom: footer ? footer.bottom : parent.bottom
        anchors.right: parent.right
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.SizeFDiagCursor
        onPressed: mainWindow.startSystemResize(Qt.BottomEdge | Qt.RightEdge)
    }
    MouseArea {
        id: bottomArea
        z: 100
        anchors.bottom: bottomRightArea.bottom
        anchors.right: bottomRightArea.left
        anchors.left: bottomLeftArea.right
        anchors.top: bottomLeftArea.top
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.SizeVerCursor
        onPressed: mainWindow.startSystemResize(Qt.BottomEdge)
    }
    MouseArea {
        id: bottomLeftArea
        width: shellLength
        height: shellLength
        z: 100
        anchors.left: parent.left
        anchors.bottom: footer ? footer.bottom : parent.bottom
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.SizeBDiagCursor
        onPressed: mainWindow.startSystemResize(Qt.BottomEdge | Qt.LeftEdge)
    }
    Connections {
        target: tray
        function onActivated(reason) {
            if (reason === Pf.SystemTrayIcon.DoubleClick) {
                mainWindow.show()
                mainWindow.raise()
                mainWindow.requestActivate()
            }
            else if (reason === Pf.SystemTrayIcon.Trigger) {
                tray.showMessage(qsTr("提示"), qsTr("点我显示主界面"))
            }
        }
        function onMessageClicked() {
                mainWindow.show()
                mainWindow.raise()
                mainWindow.requestActivate()
        }
    }
}
