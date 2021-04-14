import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5


Rectangle{
    Layout.fillWidth: true
    Layout.fillHeight:true
    Layout.preferredWidth: 80
    //Layout.preferredHeight: 80

    GridLayout {
        id : camera_view
        anchors.fill: parent
        rows    : 4
        columns : 4
        columnSpacing: 0
        rowSpacing: 0
        Layout.margins: 10
        property double colMulti : camera_view.width / camera_view.columns
        property double rowMulti : camera_view.height / camera_view.rows
        function prefWidth(item){
            return colMulti * item.Layout.columnSpan
        }
        function prefHeight(item){
            return rowMulti * item.Layout.rowSpan
        }

        C_rect {
            color : 'red'
            Text{
                text:"1번"
            }
        }
        C_rect {
            color : 'blue'
            Text{
                text:"2번"
            }
        }
        C_rect {
            color : 'green'

            Text{
                text:"3번"
            }
        }
        C_rect {
            color : 'yellow'
            Text{
                text:"4번"
            }
        }

        C_rect {
            color : 'red'
            Text{
                text:"5번"
            }
        }
        C_rect {
            color : 'blue'
            Text{
                text:"6번"
            }
        }
        C_rect {
            color : 'green'
            Text{
                text:"7번"
            }
        }
        C_rect {
            color : 'yellow'
            Text{
                text:"8번"
            }
        }

        C_rect {
            color : 'red'
            Text{
                text:"9번"
            }
        }
        C_rect {
            color : 'blue'
            Text{
                text:"10번"
            }
        }
        C_rect {
            color : 'green'
            Text{
                text:"11번"
            }
        }
        C_rect {
            color : 'yellow'
            Text{
                text:"12번"
            }
        }

        C_rect {
            color : 'red'
            Text{
                text:"13번"
            }
        }
        C_rect {
            color : 'blue'
            Text{
                text:"14번"
            }
        }
        C_rect {
            color : 'green'
            Text{
                text:"15번"
            }
        }
        C_rect {
            color : 'yellow'
            Text{
                text:"16번"
            }
        }

     }
}
