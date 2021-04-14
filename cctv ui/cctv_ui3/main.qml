import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import "./"


Window {
    width: 640
    height: 480
    visibility: Window.FullScreen

    ColumnLayout{
        spacing: 0
        anchors.fill:parent
        RowLayout{
            spacing: 0
            Layout.fillWidth: true
            Layout.fillHeight:true
            //Layout.preferredWidth: 80
            Layout.preferredHeight: 5
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
        Rectangle {
            id : null_bar  // 부분메뉴
            color: "green"
            Layout.fillWidth: true
            Layout.fillHeight:true
            //Layout.preferredWidth: 40
            Layout.preferredHeight: 5
        }

            RowLayout{
                spacing: 0
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
               ColumnLayout{
                   spacing: 0
                   Rectangle{
                       color : "skyblue"
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
                       Layout.preferredHeight: 10
                   }
                   Rectangle{
                       color : "orange"
                       Layout.fillWidth: true
                       Layout.fillHeight:true
                       Layout.preferredWidth: 20
                       Layout.preferredHeight: 5
                   }
                   Rectangle{
                       color : "yellow"
                       Layout.fillWidth: true
                       Layout.fillHeight:true
                       Layout.preferredWidth: 20
                       Layout.preferredHeight: 25
                       GridLayout {
                           id : camera_button
                           anchors.fill: parent
                           rows    : 4
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
                   Rectangle{
                       color : "orange"
                       Layout.fillWidth: true
                       Layout.fillHeight:true
                       Layout.preferredWidth: 20
                       Layout.preferredHeight: 5
                   }
                   Rectangle{
                       color : "yellow"
                       Layout.fillWidth: true
                       Layout.fillHeight:true
                       Layout.preferredWidth: 20
                       Layout.preferredHeight: 15
                       Layout.margins: 1

                       GridLayout {
                           id : view
                           anchors.fill: parent
                           rows    : 2
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
                   Rectangle{
                       color : "green"
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


               } // 2st ColumnLayout end

            } // 2st RowLayout end

    } // 1st ColumnLayout

} //window end

