import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
//import com.dawn.com 0.1

Window {
    visible: true
    visibility: "FullScreen"
    //width: 480
    //height: 250
    minimumWidth: 420
    minimumHeight: 250
    title: qsTr("Layout")

    property int font_size: 55


//    SerialPort
//    {
//        id : serialPort
//    }

    Connections {
        target: serialPort
        onNewBar: {
            //console.log(fBar);
            pgt1_right_text.text = fBar;
            pgt1_right_text.text += " Bar";
        }
        onNewBar2:{
            pgt2_right_text.text = fBar2;
            pgt2_right_text.text += " Bar";
        }

        onNewFlow:
        {
            flow_text.text = fFlow;
            flow_text.text += " L/Min";
        }
        onNewRemain:
        {
            remain.text = strRemain;            
        }
        onChangeColor:
        {
            pgt1_left.color = strColor;
        }

        onChangeColor2:
        {
            pgt2_left.color = strColor;
        }

    }

    ColumnLayout {
        spacing: 0      // 컬럼간의 간격 설정
        anchors.fill: parent   // Window 의 공간 채움
        anchors.margins: 0     // 윈도우와 컬럼설정간의 공간 설정?

         // PGT 11 압력 표시란
        RowLayout {
        id: pgt1
        //anchors.fill: parent
        spacing: 0    // 각 항목에 대한 공간
                Rectangle
                 {
                    id : pgt1_left
                    //Layout.alignment: Qt.AlignLeft
                    color: 'white'         // 배경색 지정
                    border.color: "transparent" // 외곽선 지정
                    Layout.fillWidth: true // 가로 채우기 활성
                    Layout.fillHeight: true // 세로 채우기 활성
                    Layout.preferredHeight: 40  // 기준 가로 크기    (( 이부분에 대한 정확한 의미는 아직 오리무중
                    Layout.preferredWidth: 100   // 기준 세로 크기
                    //Layout.maximumWidth: 300  // 최대 가로 크기
                    Layout.minimumWidth: 100// 최소 가로 크기
                    //Layout.maximumHeight: 150 // 최대 세로 크기
                    Layout.minimumHeight: 50  // 최소 세로 크기
                    Text {
                        id : pgt1_left_text
                        anchors.left: parent.left     // Rectangle 의 왼쪽편 일치
                        anchors.verticalCenter: parent.verticalCenter     // Rectangle 의 가운데에 일치
                        anchors.leftMargin: 5   // 왼쪽 마진 설정
                        text : "압력1"   //
                        font.pixelSize: font_size

                         }
                    }


                Rectangle {
                //Layout.alignment: Qt.AlignRight
                   id : pgt1_right
                   color: pgt1_left.color
                   border.color: pgt1_left.border.color  // "transparent"
                   Layout.fillWidth: true
                   Layout.fillHeight: true
                   Layout.minimumWidth: 100
                   Layout.minimumHeight: 10
                   Layout.preferredWidth: 40
                   Layout.preferredHeight: 40
                    Text {
                       id : pgt1_right_text
                       anchors.right: parent.right   // Rectangle 의 오른쪽기준
                       anchors.verticalCenter: parent.verticalCenter // Rectangle 의 센터위치
                       anchors.rightMargin: 20 // 오른쪽 마진을 30 부여
                       font.pixelSize: font_size
                       //text :" Bar"

                       //text: parent.width + 'x' + parent.height
                        }
                    }
            }

        // PGT11 압력 표시 두번째
        RowLayout {
        id: pgt2
        //anchors.fill: parent
        spacing: 0    // 각 항목에 대한 공간
                Rectangle
                 {
                    id : pgt2_left
                    //Layout.alignment: Qt.AlignLeft
                    color: 'white'         // 배경색 지정
                    border.color: pgt1_left.border.color // 외곽선 지정
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: pgt1_left.Layout.preferredWidth
                    Layout.preferredHeight: pgt1_left.Layout.preferredHeight
                    Layout.minimumWidth: pgt1_left.Layout.minimumWidth
                    Layout.minimumHeight: pgt1_left.Layout.minimumHeight
                    Text {
                        id : pgt2_left_text
                        anchors.left: parent.left     // Rectangle 의 왼쪽편 일치
                        anchors.verticalCenter: parent.verticalCenter     // Rectangle 의 가운데에 일치
                        anchors.leftMargin: 5   // 왼쪽 마진 설정
                        text : "압력2"   //
                        font.pixelSize: font_size

                         }
                    }


                Rectangle {
                //Layout.alignment: Qt.AlignRight
                   id : pgt2_right
                   color: pgt2_left.color
                   border.color: pgt1_left.border.color    //"transparent"
                   Layout.fillWidth: true
                   Layout.fillHeight: true
                   Layout.minimumWidth: pgt1_right.Layout.minimumWidth
                   Layout.minimumHeight: pgt1_right.Layout.minimumHeight
                   Layout.preferredWidth: pgt1_right.Layout.preferredWidth
                   Layout.preferredHeight: pgt1_right.Layout.preferredHeight
                    Text {
                       id : pgt2_right_text
                       anchors.right: parent.right   // Rectangle 의 오른쪽기준
                       anchors.verticalCenter: parent.verticalCenter // Rectangle 의 센터위치
                       anchors.rightMargin: 20 // 오른쪽 마진을 30 부여
                       font.pixelSize: font_size
                       //text :" Bar"

                       //text: parent.width + 'x' + parent.height
                        }
                    }
            }

          RowLayout {
          id: flow
           //anchors.fill: parent
          spacing: 0
                Rectangle {
                    color: "white"
                    border.color: pgt1_left.border.color
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: pgt1_left.Layout.preferredWidth
                    Layout.preferredHeight: pgt1_left.Layout.preferredHeight
                    Layout.minimumWidth: pgt1_left.Layout.minimumWidth
                    Layout.minimumHeight: pgt1_left.Layout.minimumHeight
                    Text {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: pgt1_left_text.anchors.leftMargin
                        font.pixelSize: font_size
                        text : "유속"
                    //text: parent.width + 'x' + parent.height
                    }
                 }

                Rectangle {
                    color: "white"
                    border.color: pgt1_left.border.color
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumWidth: pgt1_right.Layout.minimumWidth
                    Layout.minimumHeight: pgt1_right.Layout.minimumHeight
                    Layout.preferredWidth: pgt1_right.Layout.preferredWidth
                    Layout.preferredHeight: pgt1_right.Layout.preferredHeight
                    Text {
                        id : flow_text
                        anchors.right: parent.right   // Rectangle 의 오른쪽기준
                        anchors.verticalCenter: parent.verticalCenter // Rectangle 의 센터위치
                        anchors.rightMargin: 20 // 오른쪽 마진을 30 부여
                        font.pixelSize: font_size
                        //text : " L/Min"
                        //text: parent.width + 'x' + parent.height
                        }
                }
            }

        RowLayout {
        id: rtime
        //anchors.fill: parent
        spacing: 0
                Rectangle {
                    color: "white"
                    border.color: pgt1_left.border.color
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: pgt1_left.Layout.preferredWidth
                    Layout.preferredHeight: pgt1_left.Layout.preferredHeight
                    Layout.minimumWidth: pgt1_left.Layout.minimumWidth
                    Layout.minimumHeight: pgt1_left.Layout.minimumHeight
                    Text {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: pgt1_left_text.anchors.leftMargin
                        font.pixelSize: font_size
                        text : "잔여시간"
                        //text: parent.width + 'x' + parent.height
                        }
                    }

                Rectangle {
                    color: "white"
                    border.color: pgt1_left.border.color
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumWidth: pgt1_right.Layout.minimumWidth
                    Layout.minimumHeight: pgt1_right.Layout.minimumHeight
                    Layout.preferredWidth: pgt1_right.Layout.preferredWidth
                    Layout.preferredHeight: pgt1_right.Layout.preferredHeight
                    Text {
                        id : remain
                        anchors.right: parent.right   // Rectangle 의 오른쪽기준
                        anchors.verticalCenter: parent.verticalCenter // Rectangle 의 센터위치
                        anchors.rightMargin: 20 // 오른쪽 마진을 30 부여
                        font.pixelSize: font_size
                        //text : " "
                        //text: parent.width + 'x' + parent.height
                        }
                }
         }

        RowLayout {
        id: layout4
        spacing: 0
        visible: false
               Rectangle {
                    id : adjust_box
                    color: 'lightgray'
                    border.color: pgt1_left.border.color
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: 50      //bssic_1.Layout.preferredWidth
                    Layout.preferredHeight: pgt1_left.Layout.preferredHeight+30
                    Layout.minimumWidth: 50        //basic_1.Layout.minimumWidth
                    Layout.minimumHeight: pgt1_left.Layout.minimumHeight+30
                    Button{
                    /*  background: Rectangle{
                        color: "lightgray"
                    } */
                        anchors.fill:parent
                        text : "보정"
                        font.pixelSize: font_size
                        onClicked: {
                            Qt.quit();
                        }
                    }
                }

                Rectangle {
                    color: 'lightgray'
                    border.color: pgt1_left.border.color
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumWidth: pgt1_left.Layout.minimumWidth
                    Layout.minimumHeight: pgt1_left.Layout.minimumHeight+30
                    Layout.preferredWidth: pgt1_left.Layout.preferredWidth
                    Layout.preferredHeight: pgt1_left.Layout.preferredHeight+30
                    SpinBox {
                        id: spinbox
                        from: 0
                        value: 75
                        //value: 92
                        to: 100 * 100
                        stepSize: 1
                        font.pixelSize: 60
                        anchors.centerIn: parent

                        property int decimals: 2
                        property real realValue: value / 100

                       validator: DoubleValidator {
                           bottom: Math.min(spinbox.from, spinbox.to)
                           top:  Math.max(spinbox.from, spinbox.to)
                            }

                        textFromValue: function(value, locale) {
                             return Number(value / 100).toLocaleString(locale, 'f', spinbox.decimals)
                            }

                        valueFromText: function(text, locale) {
                             return Number.fromLocaleString(locale, text) * 100
                            }
                     }
                }
                    Rectangle {
                    color: 'lightgray'
                    border.color: pgt1_left.border.color
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumWidth: pgt1_right.Layout.minimumWidth
                    Layout.minimumHeight: pgt1_right.Layout.minimumHeight+30
                    Layout.preferredWidth: pgt1_right.Layout.preferredWidth
                    Layout.preferredHeight: pgt1_right.Layout.preferredHeight+30

                            ColumnLayout{
                                    anchors.centerIn: parent
                                    spacing: 15
                                    RadioButton{
                                        id: se_one
                                        checked: true
                                        text:qsTr("2.8L")
                                        font.pixelSize: 35
                                    }
                                    RadioButton{
                                        id : se_two
                                        text:qsTr("10L")
                                        font.pixelSize: se_one.font.pixelSize
                                    }
                             }
                    }

            Rectangle {
//              id: ok_box1
              color: pgt1_right.color
              border.color: pgt1_left.border.color
              Layout.fillWidth: true
              Layout.fillHeight: true
              Layout.minimumWidth: 50 //basic_2.Layout.minimumWidth
              Layout.minimumHeight: pgt1_right.Layout.minimumHeight+30
              Layout.preferredWidth: 50 // basic_2.Layout.preferredWidth
              Layout.preferredHeight: pgt1_right.Layout.preferredHeight+30
              Button{
                /*  background: Rectangle{
                      color: "lightgray"
                  } */
                id: ok_box2
                anchors.fill:parent
                text : "적용"
                font.pixelSize: font_size
                  onClicked: {
                    serialPort.sendCoff(spinbox.value/100);
                    //serialPort.sendCVol(spinbox2.value/10);
                    layout5.visible=true
                    layout4.visible=false
                      if(se_one.checked==true){
                            serialPort.sendCVol(2.8);
                                             }
                      else{
                            serialPort.sendCVol(10);
                                              }
                            }
                    }
            }
        }

    RowLayout{
        id : layout5
        spacing: 0
        // visible : false
        Rectangle{
            id : logo_box1
            visible: true
            //border.color: basic_1.border.color
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: pgt1_left.Layout.preferredWidth
            Layout.preferredHeight: pgt1_left.Layout.preferredHeight+30
            Layout.minimumWidth: pgt1_left.Layout.minimumWidth
            Layout.minimumHeight: pgt1_left.Layout.minimumHeight+30
            Button{
                background: Rectangle{
                    color: "lightgray"
                }

                anchors.fill:parent
                text : "O2 Monitor"
                font.pixelSize: 80
                onClicked: {
                    layout5.visible=false
                    layout4.visible=true
                }
            }
        }
    }

  }
}
