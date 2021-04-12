#include "serialport.h"
#include <QDebug>
#include <QDateTime>
#include <unistd.h>

SerialPort::SerialPort(QObject *parent) : QObject(parent)
{
    qDebug() << "m_pSerialPort : " << m_pSerialPort;
    m_pSerialPort = new QSerialPort();
    //m_pSerialPort->setPortName("/dev/ttyACM0");           // 라즈베리 사용시 포트
    m_pSerialPort->setPortName("COM3");                     // pc 에 연결시
    m_pSerialPort->setBaudRate(QSerialPort::Baud115200);

    connect(m_pSerialPort, &QSerialPort::readyRead, this, &SerialPort::handleReadyRead);

    while (m_pSerialPort->open(QIODevice::ReadWrite) == false)
        {
            qDebug() << m_pSerialPort->errorString();
            sleep(1);
        }

    m_pTimer = std::make_shared<QTimer>();
    connect(m_pTimer.get(), SIGNAL(timeout()), this, SLOT(OnTimerCallbackFunc()));
    m_pTimer->start(1000);
}

SerialPort::~SerialPort()
{
    m_LogFile.flush();
    m_LogFile.close();
}

void SerialPort::handleReadyRead()
{
    OpenLogFile();

    QByteArray array = m_pSerialPort->readAll();
    m_arrRecv.append(array);
    QString str = QString::fromStdString(m_arrRecv.toStdString());
   // qDebug() << str;

    char* recvData = m_arrRecv.data();
    int iSize = m_arrRecv.size();
    //qDebug() << "iSize : " << iSize;

    if (iSize > 0)
      {
        int i = 0;
        int iPos = 0;
        bool bConti = true;
        while(bConti)
        {
          for (i = iPos; i < iSize; i++)
          {
            if (recvData[i] == '@')
            {
              iPos = i;
              //qDebug() << "@ Pos : " << iPos;
              break;
            }
          }
          if (i == iSize)
          {
            bConti = false;
            continue;
          }
          if (recvData[iPos + 9] != '#')
          {
            iSize = 0;
            bConti = false;
            //qDebug() << "no #";
            continue;
          }

          char cType = recvData[iPos + 1];
          //qDebug() << "cType : " << cType;
          switch (cType)
          {
            case '1':           //pgt11 bar 1 (측정값)
            case '2':           //pgt11 bar 2 (측정값)
            case '3':           //awm5104 flow (측정값)
            case '4':           //잔여시간 계산   (아두이노에서 별도로 보내지 않음)
            case '5':           //pgt11 bar 1 (아두이노 칼만 적용값)
            case '6':           //pgt11 bar 2 (아두이노 칼만 적용값)
            {
              char number[8];
              memset(number, 0, 8);
              memcpy(number, recvData + iPos + 2, 7);

              int iTemp = 0;
              iTemp = atoi(number);
              //qDebug() << "iTemp : " << fixed << float(iTemp);
              switch (cType)
              {
              case '1':                                 // PGT11 첫번째 값 수신 ( 1로 시작하는 값)
              {
                  int iBAR = iTemp / 100;
                  m_iBARRaw=iBAR;                       // 아두이노 BAR1 측정값 수령
                  m_vecBAR.push_back(iBAR);

                  if (m_vecBAR.size() > 10)  // 10개의 데이터 받아서 평균처리하여 데이터 출력
                      m_vecBAR.pop_front();
                  int iTotalBAR = 0.0f;
                  for (auto iter : m_vecBAR)
                  {
                      iTotalBAR += iter;
                  }
                  iTotalBAR /= m_vecBAR.size();
                  if(iTotalBAR<-30){                   // 압력이 1.0 bar 보다 낮으면 모두 0 처리
                      iTotalBAR=-30;
                  }
                  else if(iTotalBAR<1){
                      iTotalBAR=0;
                  }
                  m_iBAR = iTotalBAR;
                  //m_fBAR = 30.0f;
                  if (m_iBAR < m_limit)       // m_limit bar 이하이면 화면색 변경되도록 설정
                      m_bBARBelow50 = true;
                  else
                      m_bBARBelow50 = false;
              }
                  break;

              case '2':                                 // PGT11 2번째 항목 확인
              {
                  float fBAR2 = float(iTemp) / 100.0f;
                  m_fBARRaw2=fBAR2;
                  m_vecBAR2.push_back(fBAR2);
                  if (m_vecBAR2.size() > 10)  // 10개의 데이터 받아서 평균처리하여 데이터 출력
                      m_vecBAR2.pop_front();
                  float fTotalBAR2 = 0.0f;
                  for (auto iter : m_vecBAR2)
                  {
                      fTotalBAR2 += iter;
                  }
                  fTotalBAR2 /= m_vecBAR.size();

                  if(fTotalBAR2<-30.0f){
                      fTotalBAR2=-30.0f;
                  }
                  else if(fTotalBAR2<1.0f){
                      fTotalBAR2=0.0f;
                  }

                  m_fBAR2 = fTotalBAR2;
                  //m_fBAR2 = 15.0f;
                  if (m_fBAR2 < m_limit)       // m_limit bar 이하이면 화면색 변경되도록 설정
                      m_bBARBelow2_50 = true;
                  else
                      m_bBARBelow2_50 = false;
              }
                  break;

              case '3':                                 // 유속센서 값 수신 (2 로 시작하는 값)
              {
                  float fFlow = float(iTemp) / 100.0f;
                  m_fFlowRaw=fFlow;
                  m_vecFlow.push_back(fFlow);
                  if (m_vecFlow.size() > 10)   // 10개의 데이터 받아서 평균처리하여 데이터 출력
                      m_vecFlow.pop_front();
                  float fTotalFlow = 0.0f;
                  for (auto iter : m_vecFlow)
                  {
                      fTotalFlow += iter;
                  }
                  fTotalFlow /= m_vecFlow.size();

                  m_fFlow = fTotalFlow;
                  if(fFlow<=0.0f){
                      fFlow=0.0001f;
                  }

                  m_fFlow=fTotalFlow;
                 //   m_fFlow=0.2f;

              {
                  float PGT_1=0.0f;
                  float PGT_2=0.0f;

                  float fBAR = (float)m_iBAR;
                  if(fBAR>0.0f){
                    PGT_1 = (m_CVol * (fBAR * 0.1f) * 10.0f) / m_fFlow;       // pgt1 번 압력과 유속 계산으로 시간확안
                    qDebug()<<"pgt1_remain:"<<PGT_1;
                  }
                  if(m_fBAR2>0.0f){
                    PGT_2 = (m_CVol * (m_fBAR2 * 0.1f) * 10.0f) / m_fFlow;      // pgt2 번 압력과 유속 계산으로 시간확인
                    qDebug()<<"pgt2_remain:"<<PGT_2;
                  }
                  m_fRemain = PGT_1+PGT_2;

              }
              }
                  break;

              case '4':                                 // 아두이노로 부터 넘어오는 잔여시간 확인
               //   m_fRemain = float(iTemp) / 100.0f;
              {
                  float fBAR = (float)m_iBAR;
                  float PGT_1 = (m_CVol * (fBAR * 0.1f) * 10.0f) / m_fFlow;       // pgt1 번 압력과 유속 계산으로 시간확안
                  qDebug()<<"pgt1_remain:"<<PGT_1;
                  float PGT_2 = (m_CVol * (m_fBAR2 * 0.1f) * 10.0f) / m_fFlow;      // pgt2 번 압력과 유속 계산으로 시간확인
                  qDebug()<<"pgt2_remain:"<<PGT_2;
                  m_fRemain = PGT_1+PGT_2;

              }

                  break;

              case '5':                                 // PGT11 아두이노 칼만필터 통과값(BAR1)
              {
                  float fBAR2 = float(iTemp) / 100.0f;
                  kal_fBAR=fBAR2;  // 칼만필터 통과값(아두이노)

              }
                  break;

              case '6':                                 // PGT11 아두이노 칼만필터 통과값(BAR2)
              {
                  float fBAR2 = float(iTemp) / 100.0f;
                  kal_fBAR2=fBAR2;  // 칼만필터 통과값(아두이노)

              }
                  break;


            /*  case '5':
              {
                  float fTemp = float(iTemp) / 100.0f;
                  qDebug() << "_Coff : " << fTemp;
              }
                  break; */

              default:
                  break;
              }

              //memcpy(recvData, recvData + (iPos + 10), iSize - (iPos + 10));
              //iSize -= (iPos + 10);
              //qDebug() << "iSize : " << iSize;
              iPos += 10;
              QString Strbar2;
              Strbar2.sprintf("%02.01f",double(m_fBAR2));
              qDebug()<<"PGT2 :"<<m_fBAR2;
              qDebug()<<"PGT2_original: "<<kal_fBAR;


              QString Strbar;
              Strbar.sprintf("%02.01f",double(m_iBAR));
              //Strbar = QString("%01").arg(double(m_fBAR));
              //Strbar = QString::number(m_fBAR, 'f', 2);
              qDebug()<<"PGT1 :"<<m_iBAR;
              qDebug()<<"PGT2_original: "<<kal_fBAR2;

              QString Strflow;
              Strflow.sprintf("%02.02f",double(m_fFlow));
              //Strflow = QString("%01").arg(double(m_fFlow));
              //Strflow = QString::number(m_fFlow, 'f', 2);
              qDebug()<<"FLOW:"<<m_fFlow;

              emit newBar(Strbar);
              emit newFlow(Strflow);
              emit newBar2(Strbar2);
              {
                  int iHour = int(m_fRemain / 60.f);
                  float fMin = m_fRemain - float(iHour * 60);
                  int iMin = int(fMin);
                  //qDebug() << "Remain Time : " << m_fRemain << "iHour : " << iHour << "iMin : " << iMin;
                  QString strRemain;
                  strRemain.sprintf("%02d시%02d분", iHour, iMin);
                  //strRemain.sprintf("%002f", double(m_fRemain));
                  //strRemain = QString("%001시%002분").arg(iHour).arg(iMin);
                  qDebug()<<"남은시간 :"<<strRemain;
                  emit newRemain(strRemain);

                  {
                      QString strTime = QDateTime::currentDateTime().toString("hh_mm_ss");
                      QTextStream out(&m_LogFile);
                      out << strTime << "\t" << m_iBAR << "\t" << m_iBARRaw << "\t" << m_fBAR2 << "\t" << m_fBARRaw2 << "\t" << m_fFlow << "\t" << m_fFlowRaw << "\t" << kal_fBAR <<"\t" << kal_fBAR2<<"\t"<<strRemain << "\n";
                      //qDebug() << "strRemain : " << strRemain << endl;
                  }

                  // m_iBAR : 아두이노에서 받은 10개의 데이터를 평균낸값  (BAR1)
                  // m_iBARRaw : 아두이노에서 받은 그 자체 값 (BAR1)
                  // m_fBAR2 : 아두이노에서 받은 10개의 데이터를 평균낸값 (BAR2)
                  // m_fBARRaw2 : 아두이노에서 받은 그 자체 값 (BAR2)
                  // m_fFlow : 아두이노에서 받은 10개의 데이터를 평균낸값 (Flow)
                  // m_fFlowRaw : 아두이노에서 받은 그 자체 값 (flow)
                  // kal_fBAR : 아두이노에서 칼만필터를 통과한 값 (BAR1)
                  // kal_fBAR2 : 아두이노에서 칼만필터를 통과한 값 (BAR2)
              }

            }
            break;

            default:
            break;
          }
        }
       m_arrRecv = m_arrRecv.right(iSize - iPos);
       //qDebug() << "end.....";
      }
}

void SerialPort::sendCoff(float fCoff)
{
    int iCoff = int(fCoff * 100.0f);
    QString strBuff;
    strBuff.sprintf("@4%07d#", iCoff);
    QByteArray array = strBuff.toLocal8Bit();
    m_pSerialPort->write(array.data());
    //qDebug()<<"coff"<<fCoff;
}

void SerialPort::sendCVol(float fCVol)
{
    m_CVol=fCVol;
    //qDebug()<<"CVol"<<fCVol;
}

void SerialPort::SetPath(QString str)
{
    m_strPath = str;
   // qDebug() << m_strPath;
}

void SerialPort::OpenLogFile()
{
    QTime time = QTime::currentTime();
    if (m_nHour == time.hour())
        return;

    m_nHour = time.hour();

    if (m_LogFile.isOpen())
    {
        m_LogFile.flush();
        m_LogFile.close();
    }

    QString strDateTime = QDateTime::currentDateTime().toString("yyyy_MM_dd_hh_mm_ss");
    QString strFileName = m_strPath;
    strFileName += "/";
    strFileName += strDateTime;
    strFileName += ".txt";
    //qDebug() << strFileName;

    m_LogFile.setFileName(strFileName);
    if (!m_LogFile.open(QFile::WriteOnly | QFile::Text))
        qDebug() << "Fail to open";

    QTextStream out(&m_LogFile);
    out << "DateTime\t" << "Bar1\t" <<"BAR1_Raw\t" << "Bar2\t" << "BAR2_Raw2\t" << "Flow\t" << "FlowRaw\t" << "ori_BAR1\t" << "ori_BAR2\t"<< "RemainTime\n";
}

void SerialPort::OnTimerCallbackFunc()
{
    if (m_bBARBelow50)
    {
        static bool bColor = true;
        if (bColor)
        {
            changeColor("red");
            bColor = false;
        }
        else
        {
            changeColor("white");
            bColor = true;
        }
    }
    else
        changeColor("white");

    if (m_bBARBelow2_50)
    {
        static bool bColor = true;
        if (bColor)
        {
            changeColor2("red");
            bColor = false;
        }
        else
        {
            changeColor2("white");
            bColor = true;
        }
    }
    else
        changeColor2("white");
}


