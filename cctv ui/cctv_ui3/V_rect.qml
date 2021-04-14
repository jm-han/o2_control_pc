import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    Layout.preferredWidth  : view.prefWidth(this)
    Layout.preferredHeight : view.prefHeight(this)
    border.color: "black"
    Layout.rowSpan   : 1
    Layout.columnSpan: 1
    Text{
        text:""
    }
}
