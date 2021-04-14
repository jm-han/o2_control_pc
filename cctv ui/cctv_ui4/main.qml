import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import "./"

Window {
    //width: 640
    //height: 480
    visibility: "FullScreen"
    //title: qsTr("Hello World")
    ColumnLayout{           //col_1
        spacing: 0
        anchors.fill:parent

        Menu_bar{           // 상단 메뉴바
            Layout.preferredHeight: 3

        }

        Rectangle {
            id : null_bar  // dropmenu 공간
            color: "green"
            Layout.fillWidth: true
            Layout.fillHeight:true
            //Layout.preferredWidth: 40
            Layout.preferredHeight: 3
        }

        RowLayout{
            spacing: 0
            Camera_view{        // 카메라 영상 자리

            }
            ColumnLayout{
                spacing: 0
                Rectangle{
                   id : time_bar   // 시간
                   color : "skyblue"
                   Layout.fillWidth: true
                   Layout.fillHeight:true
                   Layout.preferredWidth: 20
                   Layout.preferredHeight: 5
               }
               Rectangle{
                   id : disk_bar  // 디스크 사용량
                   color : "blue"
                   Layout.fillWidth: true
                   Layout.fillHeight:true
                   Layout.preferredWidth: 20
                   Layout.preferredHeight: 10
               }

               Camera_button{

               }

               View_select{

               }

               Rectangle{
                  color : "orange"
                  Layout.fillWidth: true
                  Layout.fillHeight:true
                  Layout.preferredWidth: 20
                  Layout.preferredHeight: 5
              }
              Rectangle{
                  color : "blue"
                  Layout.fillWidth: true
                  Layout.fillHeight:true
                  Layout.preferredWidth: 20
                  Layout.preferredHeight: 5
              }
              Rectangle{
                  color : "skyblue"
                  Layout.fillWidth: true
                  Layout.fillHeight:true
                  Layout.preferredWidth: 20
                  Layout.preferredHeight: 5
              }

            }
        }
      } // col_1 end
}  // window end
