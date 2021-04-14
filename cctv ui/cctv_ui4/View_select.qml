import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

Rectangle{
       color : "silver"
       Layout.fillWidth: true
       Layout.fillHeight:true
       Layout.preferredWidth: 20
       Layout.preferredHeight: 20
       Layout.margins: 1

       GridLayout {
           id : view
           anchors.fill: parent
           rows    : 3
           columns : 3
           columnSpacing: 1
           rowSpacing: 1
           property double colMulti : view.width / view.columns
           property double rowMulti : view.height / view.rows
           function prefWidth(item){
               return colMulti * item.Layout.columnSpan
           }
           function prefHeight(item){
               return rowMulti * item.Layout.rowSpan
           }

           Rectangle {      //화면 선택 타이틀
               color:"orange"
               Layout.preferredWidth  : view.prefWidth(this)
               Layout.preferredHeight : view.prefHeight(this)
               border.color: "black"
               Layout.rowSpan   : 1
               Layout.columnSpan: 3
               Text{
                   text:""
               }
           }
           V_rect {
               color : 'yellow'
               Text{
                   text:"1번"
               }
           }
           V_rect {
               color : 'yellow'
               Text{
                   text:"2번"
               }
           }
           V_rect {
               color : 'yellow'
               Text{
                   text:"3번"
               }
           }
           V_rect {
               color : 'yellow'
               Text{
                   text:"4번"
               }
           }
           V_rect {
               color : 'yellow'
               Text{
                   text:"5번"
               }
           }
           V_rect {
               color : 'yellow'
               Text{
                   text:"6번"
               }
           }

       }
   }
