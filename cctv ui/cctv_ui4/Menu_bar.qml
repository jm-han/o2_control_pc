import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

RowLayout{
    spacing: 0
    Layout.fillWidth: true
    Layout.fillHeight:true
    //Layout.preferredWidth: 80
    //Layout.preferredHeight: 5
    Button {
        id : quit   // 종료
        //color: "blue"
        Layout.fillWidth: true
        Layout.fillHeight:true
        Layout.preferredWidth: 10
       // Layout.preferredHeight: 20
        text:" QUIT"
        font.pixelSize: 20
        onClicked: {
            Qt.quit();
        }
    }
    Rectangle {
        id : menu_bar2   //
        color: "skyblue"
        Layout.fillWidth: true
        Layout.fillHeight:true
        Layout.preferredWidth: 10
       // Layout.preferredHeight: 20
    }
    Rectangle {
        id : menu_bar3   //
        color: "silver"
        Layout.fillWidth: true
        Layout.fillHeight:true
        Layout.preferredWidth: 10
       // Layout.preferredHeight: 20
    }
    Rectangle {
        id : menu_bar4   //
        color: "blue"
        Layout.fillWidth: true
        Layout.fillHeight:true
        Layout.preferredWidth: 10
       // Layout.preferredHeight: 10
    }
    Rectangle {
        id : menu_bar5_null   //
        color: "yellow"
        Layout.fillWidth: true
        Layout.fillHeight:true
        Layout.preferredWidth: 40
       // Layout.preferredHeight: 10
    }
    Rectangle {
        id : menu_bar6   //
        color: "red"
        Layout.fillWidth: true
        Layout.fillHeight:true
        Layout.preferredWidth: 20
       //Layout.preferredHeight: 10
    }
}
