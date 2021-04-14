import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    Layout.preferredWidth  : camera_button.prefWidth(this)
    Layout.preferredHeight : camera_button.prefHeight(this)
    border.color: "black"
    Layout.rowSpan   : 1
    Layout.columnSpan: 1
    Text{
        text:""
    }
}
