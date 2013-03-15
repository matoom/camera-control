#include <QtCore/QCoreApplication>
#include <QtCore/QString>
#include <QtCore/QStringList>
#include <qextserialport.h>
#include <iostream>
#include <QDebug>
#include <qregexp.h>

using namespace std;

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    QStringList arg = a.arguments();

    if(arg.count() < 3){
        qDebug("Usage: usb_port action [lcd_text]");
    } else {
        QRegExp rx_linux("^/dev/ttyUSB[0-9]$");
        QRegExp rx_win("^COM[0-9]$");

        if(!rx_linux.exactMatch(arg[1]) && !rx_win.exactMatch(arg[1])){
            qDebug("Invalid usb port.\r\n");
        } else {
            PortSettings portSettings;
            portSettings.BaudRate = BAUD9600;
            portSettings.DataBits = DATA_8;
            portSettings.Parity = PAR_NONE;
            portSettings.StopBits = STOP_1;
            portSettings.FlowControl = FLOW_OFF;
            portSettings.Timeout_Millisec = 0;

            QextSerialPort* port = new QextSerialPort(arg[1], portSettings);

            bool res = false;
            res = port->open(QextSerialPort::ReadWrite);

            if(!res){
                qDebug("Connection failed!!\n");
            } else {
                qDebug("Connected!!\n");

                QString action(arg[2]);

                int total = port->write(action.toAscii(), action.length());

                QString separator("#");
                total += port->write(separator.toAscii(), action.length());

                QString lcd_text;

                for(int i = 3; i < arg.length(); i++){
                    lcd_text += arg[i] + " ";
                }

                total += port->write(lcd_text.toAscii(), lcd_text.length());

                qDebug ("Total written = %d", total);
            }

            port->close();
        }
    }
    a.exit(0);
}
