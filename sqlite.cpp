#include <iostream>
#include <string>
#include <QCoreApplication>
#include <QFile>
#include <QSqlError>
#include <QDebug>
#include <QCoreApplication>
#include <QSqlQuery>
#include <QSqlRecord>
#include "sqlite.h"
Sqlite::Sqlite(QObject *parent) : QObject(parent)
{
    QString path = QCoreApplication::applicationDirPath().append("/info.db");
    if (!QFile::exists(path))
    {
        QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
        db.setDatabaseName(path);
        db.open();
        QSqlQuery query;
        query.exec("CREATE TABLE IF NOT EXISTS data(building TEXT, name TEXT, phone TEXT, vehicle TEXT, parking INTEGER, start TEXT, end TEXT, pay TEXT)");
    }
}
Sqlite::~Sqlite(){}
bool Sqlite::openDB(QSqlDatabase &db)
{
    if (QSqlDatabase::contains("qt_sql_default_connection"))
    {
        db = QSqlDatabase::database("qt_sql_default_connection");
    }
    else
    {
        db = QSqlDatabase::addDatabase("QSQLITE");
        db.setDatabaseName(QCoreApplication::applicationDirPath().append("/info.db"));
    }
    if (!db.isOpen())
        if (!db.open())
        {
            qDebug() << "Error: Failed to connect database" << db.lastError().text();
            return false;
        }
    return true;
}
Q_INVOKABLE QVariantMap Sqlite::getParkingInfo(QString parking)
{
    QSqlDatabase db;
    QVariantMap parkingInfo;
    if (!this->openDB(db))
        return parkingInfo;
    QSqlQuery query;
    query.prepare("SELECT * FROM data WHERE parking = ?");
    query.addBindValue(parking);
    if (query.exec())
    {
        query.next();
        parkingInfo.insert("building", query.value("building").toString());
        parkingInfo.insert("name", query.value("name").toString());
        parkingInfo.insert("phone", query.value("phone").toString());
        parkingInfo.insert("vehicle", query.value("vehicle").toString());
        parkingInfo.insert("start", query.value("start").toString());
        parkingInfo.insert("end", query.value("end").toString());
        parkingInfo.insert("pay", query.value("pay").toString());
    }
    else
        qDebug() << "Error: Fail to query table." << query.lastError().text();
    db.close();
    return parkingInfo;
}
Q_INVOKABLE bool Sqlite::setParkingInfo(QString building, QString name, QString phone, QString vehicle, QString parking, QString start, QString end, QString pay)
{
    QSqlDatabase db;
    if (!this->openDB(db))
        return false;
    QSqlQuery query;
    query.prepare("SELECT COUNT(*) FROM data WHERE parking = ?");
    query.addBindValue(parking);
    if (query.exec())
    {
        query.next();
        if (query.value(0).toInt() > 0)
        {
            query.prepare("UPDATE data SET building = ?, name = ?, phone = ?, vehicle = ?, start = ?, end = ?, pay = ? WHERE parking = ?");
            query.addBindValue(building);
            query.addBindValue(name);
            query.addBindValue(phone);
            query.addBindValue(vehicle);
            query.addBindValue(start);
            query.addBindValue(end);
            query.addBindValue(pay);
            query.addBindValue(parking);
            if (!query.exec())
            {
                qDebug() << "Error: UPDATE table is Error." << db.lastError().text();
                db.close();
                return false;
            }
        }
        else
        {
            query.prepare("INSERT INTO data (building, name, phone, vehicle, parking, start, end, pay) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            query.addBindValue(building);
            query.addBindValue(name);
            query.addBindValue(phone);
            query.addBindValue(vehicle);
            query.addBindValue(parking);
            query.addBindValue(start);
            query.addBindValue(end);
            query.addBindValue(pay);
            if (!query.exec())
            {
                qDebug() << "Error: INSERT table is Error." << db.lastError().text();
                db.close();
                return false;
            }
        }
    }
    else
    {
        qDebug() << "Error: Fail to query table." << query.lastError().text();
        db.close();
        return false;
    }
    db.close();
    emit this->updateParking(parking);
    return true;
}
Q_INVOKABLE QVariantList Sqlite::searchParkingInfo(int index, QString value)
{
    QVariantList mapList;
    QSqlDatabase db;
    if (!this->openDB(db))
        return mapList;
    QString sqlStr("SELECT * FROM data WHERE ");
    switch (index)
    {
    case 0:
        sqlStr.push_back("name = '");
        break;
    case 1:
        sqlStr.push_back("phone = '");
        break;
    case 2:
        sqlStr.push_back("vehicle = '");
        break;
    default:
        return mapList;
    }
    sqlStr.push_back(value);
    sqlStr.push_back("';");
    QSqlQuery query;
    if (query.exec(sqlStr))
    {
        while (query.next())
        {
            QVariantMap varMap;
            varMap.insert("building", query.value("building").toString());
            varMap.insert("name", query.value("name").toString());
            varMap.insert("phone", query.value("phone").toString());
            varMap.insert("vehicle", query.value("vehicle").toString());
            varMap.insert("parking", query.value("parking").toString());
            varMap.insert("start", query.value("start").toString());
            varMap.insert("end", query.value("end").toString());
            varMap.insert("pay", query.value("pay").toString());
            mapList.push_back(varMap);
        }
    }
    else
        qDebug() << "Error: search table is Error." << query.lastError().text();
    db.close();
    return mapList;
}
Q_INVOKABLE bool Sqlite::deleteParking(const QString &parking)
{
    QSqlDatabase db;
    if (!this->openDB(db))
        return false;
    QSqlQuery query;
    query.prepare("DELETE FROM data WHERE parking = ?");
    query.addBindValue(parking);
    if (!query.exec())
    {
        qDebug() << "Error: DELETE parking is Error." << db.lastError().text();
        db.close();
        return false;
    }
    db.close();
    emit this->updateParking(parking);
    return true;
}
