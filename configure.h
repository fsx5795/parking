#ifndef CONFIGURE_H
#define CONFIGURE_H
#include <QObject>
#include <QColor>
class Configure : public QObject
{
    Q_OBJECT
public:
    explicit Configure(QObject *parent = Q_NULLPTR);
    virtual ~Configure() Q_DECL_OVERRIDE;
    Q_INVOKABLE int getRemindDays();
    Q_INVOKABLE void setRemindDays(int);
    Q_INVOKABLE QColor getOverState(QString);
private:
    //Sqlite sqlite;
    int remindDays;
signals:
    void updateOverState();
};
#endif
