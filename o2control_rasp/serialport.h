#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QObject>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QFile>
#include <QVector>
#include <QTimer>
#include <memory>

class SerialPort : public QObject
{
    Q_OBJECT
public:
    explicit SerialPort(QObject *parent = nullptr);
    ~SerialPort();

signals:
    void newBar(QString fBar);
    void newBar2(QString fBar2);
    void newFlow(QString fFlow);
    void newRemain(QString strRemain);
    void changeColor(QString strColor);
    void changeColor2(QString strColor);

public slots:
    void handleReadyRead();
    void sendCoff(float fCoff);
    void sendCVol(float fCVol);
    void OnTimerCallbackFunc();

private:
    QSerialPort* m_pSerialPort = nullptr;
    QByteArray m_arrRecv;
    QVector<float> m_vecBAR;
    QVector<float> m_vecBAR2;
    QVector<float> m_vecFlow;
private:
    float m_fBAR = 0.0f;
    float m_fBARRaw= 0.0f;
    float m_fBAR2 = 0.0f;
    float m_fBARRaw2= 0.0f;
    float m_fFlow = 0.0f;
    float m_fFlowRaw = 0.0f;
    float m_fRemain = 0.0f;
    float m_CVol=2.8;
    float m_limit = 50.0f;

private:
    QString m_strPath;
public:
    void SetPath(QString str);

private:
    int m_nHour = -1;
    QFile m_LogFile;
protected:
    void OpenLogFile();

private:
    std::shared_ptr<QTimer> m_pTimer;
    bool m_bBARBelow50 = false;
    bool m_bBARBelow2_50 = false;
};

#endif // SERIALPORT_H
