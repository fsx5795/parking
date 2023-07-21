#include <QSettings>
#include <QCoreApplication>
#include <QDate>
#include "configure.h"
#include "sqlite.h"
Configure::Configure(QObject *parent) : remindDays(-1), QObject(parent){}
Configure::~Configure(){}
Q_INVOKABLE int Configure::getRemindDays()
{
    QSettings settings(QCoreApplication::applicationDirPath().append("/config.ini"), QSettings::IniFormat);
    settings.beginGroup("over");
    this->remindDays = settings.value("days").toInt();
    settings.endGroup();
    return this->remindDays;
}
Q_INVOKABLE void Configure::setRemindDays(int num)
{
    QSettings settings(QCoreApplication::applicationDirPath().append("/config.ini"), QSettings::IniFormat);
    settings.beginGroup("over");
    settings.setValue("days", num);
    settings.endGroup();
    this->remindDays = num;
    emit this->updateOverState();
    return;
}
Q_INVOKABLE QColor Configure::getOverState(QString parking)
{
    Sqlite sqlite;
    QVariantMap variantMap = sqlite.getParkingInfo(parking);
    QString dateStr = variantMap.value("end").toString();
    if (dateStr.isEmpty())
        return QColor(40, 44, 52);
    qint64 diff = QDate::currentDate().daysTo(QDate::fromString(dateStr, "yyyyMMdd"));
    if (diff < 0)
        return QColor(255, 0, 151);
    if (this->remindDays < 0)
        this->getRemindDays();
    return diff <= this->remindDays ? QColor(96, 60, 186) : QColor(27, 161, 226);
}
