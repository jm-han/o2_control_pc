/*
 * FlowRateSensorTest
 *
 * Fetch and print values from a Honeywell 
 * Zephyr HAF Pressure Sensor over I2C
 * 
 * The sensor values used in this demo are 
 * for a 50 SCCM sensor with address 0x49
 * (PN: HAF BLF 0050 C4AX5)
 * 
 */
#include <SimpleKalmanFilter.h>     /// 칼만심플필터 헤더
#include "HoneywellZephyrI2C.h"


/*
 This sample code demonstrates how to use the SimpleKalmanFilter object. 
 Use a potentiometer in Analog input A0 as a source for the reference real value.
 Some random noise will be generated over this value and used as a measured value.
 The estimated value obtained from SimpleKalmanFilter should match the real
 reference value.

 SimpleKalmanFilter(e_mea, e_est, q);
 e_mea: Measurement Uncertainty 
 e_est: Estimation Uncertainty 
 q: Process Noise
 */

 // 칼만필터 
SimpleKalmanFilter simpleKalmanFilter1(2, 2, 0.01);
SimpleKalmanFilter simpleKalmanFilter2(2, 2, 0.01);


// Serial output refresh time
const long SERIAL_REFRESH_TIME = 100;   // 반복시간 100ms
long refresh_time;



// construct a 50 SCCM sensor with address 0x49
ZephyrFlowRateSensor sensor(0x49, 50);

/* 산소통 Tank 의 용량를 입력해줍니다. */
   float fTank = 2.8f; // 탱크 용량이 기입이 되어야 합니다.
   float flow_temp= 0.0f;
   float fFlow = 0.0f;    
   float fFlow2 = 0.0f;
   float PGT11_BAR1 = 0.0f;  // 입력되는 전압 아날로그 값 데이터 (0~1023)
   float PGT11_BAR2 = 0.0f;  // 입력되는 전압 아날로그 값 데이터 (0~1023)
   float fBAR = 0.0f;  // 계산해서 출력되는 실제 전압 데이터
   float fBAR2 = 0.0f;  // 계산해서 출력되는 실제 전압 데이터
   float kal_fBAR = 0.0f; // 칼만필터 통과한 값
   float kal_fBAR2 = 0.0f; // 칼만필터 통과한 값
   float fMPA = 0.0; // fBAR를 fMPA로 바꾸어 주어야 합니다.
   float fMPA2 = 0.0; // fBAR를 fMPA로 바꾸어 주어야 합니다.
   float fAvailableTime = 0.0f; // 계산을 해 내야 하는 잔여 시간(분)입니다.
   float fAvailableTime2 = 0.0f; // 계산을 해 내야 하는 잔여 시간(분)입니다.

char recvData[255];
int iPos = 0;
float fCoff = 0.75f;
void SendData(char type, float fValue)
{
  int iValue = (int)(fValue * 100.0f);
  char buffer[255];
  //sprintf(buffer, "@%1d%08.2f#", 1, -123.45f);
  sprintf(buffer, "@%1d%07d#", type, iValue);

  Serial.print(buffer);
}
  
void setup() {
  Serial.begin(115200); // start Serial communication
  Wire.begin(); // start 2-wire communication
  Wire.setClock(400000L); // this sensor supports fast-mode
  sensor.begin(); // run sensor initialization

  pinMode(A1,INPUT); // 유속 센서
  pinMode(A2,INPUT); // PGT11 첫번째 센서 (BAR1)
  pinMode(A3,INPUT); // PGT11 두번째 센서 (BAR2)

  memset(recvData, 0, 255);
  delay(1000);
  //Serial.println("Bar/Flow(old)/Time/Flow2(new)/Time2/Flow-Flow2");
}

      
void loop() {
    
  {
     
    // the sensor returns 0 when new data is ready
    if( sensor.readSensor() == 0 ){ 
    fFlow = sensor.flow();
//    Serial.print( "Flow rate: " );
//    Serial.print( sensor.flow() );
//    Serial.println( " [SCCM]" );
  }

    //delay( 100 ); // Slow down sampling to 10 Hz. This is just a test.
  }

   {
     float temp;
     PGT11_BAR1=analogRead(A2); // PGT11 첫번째입력
     PGT11_BAR2 =analogRead(A3); // PGT11 두번째입력
//   input_vol = 200.0f;  //test 입력값

     /* Analog 값은 0 ~1023 데이터를 받음
      * WIKA 압력게이지 Model : PGT11 은 4mA ~ 20mA 의 전류를 발생시킴
      * MAX 20mA 를 1024 단계로(입력값이 0~1023이므로) 나누면 51.2 가 나오므로
      * MIN 4mA 일때 4*51.2 = 204.8 이 나오게 됨
      * 결국 0 Bar 일때 4mA 가 흐르므로 아래의 식을 적용함
      */

      /* 단위 변환 
       *    1 bar = 0.1 Mpa
       *    1 Mpa = 10.1972 kgf/cm2
       */
     fBAR = ((PGT11_BAR1-200.0f)/823.0f)*400;    //pgt11 1번의 압력계산

    // 칼만-----------------------------
    float measured_value = fBAR + random(-100,100)/100.0;
    float estimated_value = simpleKalmanFilter1.updateEstimate(measured_value);
    // 칼만------------------------------
    
     kal_fBAR = estimated_value;           // PGT11 1번 칼만필터 통과값
     
     fMPA = fBAR * 0.1f;        // 1BAR = 0.1MPa

     fBAR2 = ((PGT11_BAR2-200.0f)/823.0f)*400;  //pgt11 2번의 압력계산
    // 칼만-----------------------------
    float measured_value2 = fBAR2 + random(-100,100)/100.0;
    float estimated_value2 = simpleKalmanFilter2.updateEstimate(measured_value2);
    // 칼만------------------------------

     kal_fBAR2=estimated_value2;         // PGT11 2번 칼만필터 통과값
     
     fMPA2 = fBAR2 * 0.1f;      // 1BAR = 0.1MPa
   
  }

  {
     float flow_temp=(float)analogRead(A1); // AWM5104 FLOW sensor 입력
     flow_temp *= (5.0f / 1024.0f);
     //flow_temp = 5.0f;

     // (flow_temp-0.1f) ---> 0.1 을 0.75 로 변경
     fFlow2 = (flow_temp-fCoff)*4.0f - 1.0f;    //Flow2 센서값 계산
     //fFlow2 = flow_temp;    //Flow2 센서값 계산
  }  


 if (millis() > refresh_time) {
  static int iCnt = 0;
  if (iCnt++ % 5 == 0)
  { 
    // 데이터 정리 출력 
//    Serial.print(fBAR);
//    Serial.print("/\t");
//    Serial.print(fFlow);
//    Serial.print("/\t");
//    fAvailableTime = (fTank * fMPA * 10.0f) / fFlow;
//    Serial.print(fAvailableTime);
//    Serial.print("/\t");
//    fAvailableTime2 = (fTank * fMPA * 10.0f) / fFlow2;
//    Serial.print(fFlow2);
//    Serial.print("/\t");
//    Serial.print(fAvailableTime2);
//    Serial.print("/\t");
//    Serial.println(fFlow-fFlow2);

  fAvailableTime2 = (fTank * fMPA * 10.0f) / fFlow2;
    
  
  
 // fFlow2=0.20f;
  SendData(5, fBAR);              // PGT11 첫번째 데이터 보냄(BAR1) [ 핀으로 부터 받은 데이터를 계산한값 _row data]
  SendData(6, fBAR2);             // PGT11 두번째 데이터 보냄(BAR2) [ 핀으로 부터 받은 데이터를 계산한값 _row data]
  SendData(3, fFlow2);            // 유속센서 데이터 보냄
  //SendData(4, fAvailableTime2);   // 사용가능시간 보냄
  SendData(1, kal_fBAR);             // 칼만필터 적용값(BAR1)
  SendData(2, kal_fBAR2);            // 칼만필터 적용값(BAR2)


  /*  본소스 
    //Serial.print("Input Analog Value :");
    //Serial.println(input_vol);
    Serial.print("Input Pressure Value :");
    Serial.print(fBAR);
    Serial.print(" Bar");
    Serial.print("\n");
    Serial.print("Flow : ");
    Serial.print(fFlow);
    Serial.println(" L/min");
    //Serial.println("");
    
    Serial.print("Flow2(new) :");
    Serial.println(fFlow2);
    
    Serial.print("Flow(old) - Flow(new):");
    Serial.println(fFlow-fFlow2);

    fAvailableTime = (fTank * fMPA * 10.0f) / fFlow;
    Serial.print("Available Time : ");
    Serial.print(fAvailableTime);
    Serial.println(" Min");
    
    fAvailableTime2 = (fTank * fMPA * 10.0f) / fFlow2;
    Serial.print("Available Time2 : ");
    Serial.print(fAvailableTime2);
    Serial.println(" Min");
    Serial.println("");
  */  
  }

  while (Serial.available())
    recvData[iPos++] = Serial.read();
  //Serial.print(recvData);
  if (iPos > 0)
  {    
    int i = 0;
    int iAt = -1;
    boolean bConti = true;
    while(bConti)
    {
      iAt = -1;
      for (i = 0; i < iPos; i++)
      {
        if (recvData[i] == '@')
        {
          iAt = i;
          //Serial.print(iAt);
          break;
        }
      }
      if (iAt == -1)
      {
        bConti = false;
        continue;
      }
      if (recvData[iAt + 9] != '#')
      {
        Serial.print("error 0 : ");
        Serial.println(recvData[iAt + 9]);
        iPos = 0;
        bConti = false;
        continue;
      }
      
      char cType = recvData[iAt + 1];
      switch (cType)
      {
        case '4':
        {
          char number[8];
          memset(number, 0, 8);
          memcpy(number, recvData + iAt + 2, 7);
          int iCoff = atoi(number);
          //Serial.println(iCoff);
          fCoff = (float)(iCoff) / 100.0f;
          //Serial.println(fCoff);
          SendData(5, fCoff);
  
          memcpy(recvData, recvData + (iAt + 10), 255 - (iAt + 10));
          iPos -= (iAt + 10);
        }
        break;
        
        default:
        break;
      }
    }
  }
  
  
  //delay( 100 );

    refresh_time = millis() + SERIAL_REFRESH_TIME;
   }

}
