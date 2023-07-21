#include <fstream>
#include <QDebug>
#include <QCoreApplication>
#include "log.h"
void msgOutput(QtMsgType type, const QMessageLogContext &context, const QString &str)
{
    QString formatMsg = qFormatLogMessage(type, context, str);
    QByteArray arr = formatMsg.toLocal8Bit();
    const char *data = arr.constData();
    time_t current = time(nullptr);
    struct tm *timerinfo = localtime(&current);
    char buffer[80];
    strftime(buffer, 80, "%Y%m%d", timerinfo);
    std::ofstream ofs(QCoreApplication::applicationDirPath().append("/").append(buffer).append(".log").toStdString(), std::ios::out | std::ios::app);
    if (ofs.is_open())
    {
        ofs << data << std::endl;
        ofs.close();
    }
    return;
}
