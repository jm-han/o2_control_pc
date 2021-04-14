import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

Rectangle{
       color : "yellow"
       Layout.fillWidth: true
       Layout.fillHeight:true
       Layout.preferredWidth: 20
       Layout.preferredHeight: 30
       GridLayout {
           id : camera_button
           anchors.fill: parent
           rows    : 5
           columns : 4
           columnSpacing: 0
           rowSpacing: 0
           property double colMulti : camera_button.width / camera_button.columns
           property double rowMulti : camera_button.height / camera_button.rows
           function prefWidth(item){
               return colMulti * item.Layout.columnSpan
           }
           function prefHeight(item){
               return rowMulti * item.Layout.rowSpan
           }

           Rectangle {      //카메라 선택 타이틀
               color:"orange"
               Layout.preferredWidth  : camera_button.prefWidth(this)
               Layout.preferredHeight : camera_button.prefHeight(this)
               border.color: "black"
               Layout.rowSpan   : 1
               Layout.columnSpan: 4
               Text{
                   text:""
               }
           }
           B_rect {
               color : 'red'
               border.color: "black"
               Text{
                   text:"1번"
               }
           }
           B_rect {
               color : 'blue'
               Text{
                   text:"2번"
               }
           }
           B_rect {
               color : 'green'

               Text{
                   text:"3번"
               }
           }
           B_rect {
               color : 'yellow'
               Text{
                   text:"4번"
               }
           }

           B_rect {
               color : 'red'
               Text{
                   text:"5번"
               }
           }
           B_rect {
               color : 'blue'
               Text{
                   text:"6번"
               }
           }
           B_rect {
               color : 'green'
               Text{
                   text:"7번"
               }
           }
           B_rect {
               color : 'yellow'
               Text{
                   text:"8번"
               }
           }

           B_rect {
               color : 'red'
               Text{
                   text:"9번"
               }
           }
           B_rect {
               color : 'blue'
               Text{
                   text:"10번"
               }
           }
           B_rect {
               color : 'green'
               Text{
                   text:"11번"
               }
           }
           B_rect {
               color : 'yellow'
               Text{
                   text:"12번"
               }
           }

           B_rect {
               color : 'red'
               Text{
                   text:"13번"
               }
           }
           B_rect {
               color : 'blue'
               Text{
                   text:"14번"
               }
           }
           B_rect {
               color : 'green'
               Text{
                   text:"15번"
               }
           }
           B_rect {
               color : 'yellow'
               Text{
                   text:"16번"
               }
           }

       }

   }
