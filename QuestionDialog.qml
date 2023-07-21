//import Qt.labs.platform as Platform
import Qt.labs.platform 1.1
//Platform.MessageDialog {
MessageDialog {
    id: messageDialog
    buttons: MessageDialog.Ok | MessageDialog.Cancel
    function show(caption) {
        messageDialog.text = caption
        messageDialog.open()
    }
}
