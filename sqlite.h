#ifndef SQLITE_H
#define SQLITE_H
#include <QObject>
#include <QVariantMap>
#include <QSqlDatabase>
class Sqlite : public QObject
{
    Q_OBJECT
public:
    explicit Sqlite(QObject *parent = Q_NULLPTR);
    virtual ~Sqlite() Q_DECL_OVERRIDE;
    Q_INVOKABLE QVariantMap getParkingInfo(QString);
    Q_INVOKABLE bool setParkingInfo(QString, QString, QString, QString, QString, QString, QString, QString);
    Q_INVOKABLE QVariantList searchParkingInfo(int, QString);
    Q_INVOKABLE bool deleteParking(const QString&);
private:
    bool openDB(QSqlDatabase&);
signals:
    void updateParking(const QString&);
};
#endif
