#include "parkmodel.h"
ParkModel::ParkModel(QObject *parent) : QAbstractTableModel(parent){}
Q_INVOKABLE QVariant ParkModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole)
    {
        switch (section)
        {
        case 0:
            return QString::fromWCharArray(L"楼栋");
        case 1:
            return QString::fromWCharArray(L"姓名");
        case 2:
            return QString::fromWCharArray(L"电话");
        case 3:
            return QString::fromWCharArray(L"车牌");
        case 4:
            return QString::fromWCharArray(L"车位");
        case 5:
            return QString::fromWCharArray(L"起始日期");
        case 6:
            return QString::fromWCharArray(L"终止日期");
        case 7:
            return QString::fromWCharArray(L"缴费日期");
        }
    }
    return QVariant();
}
int ParkModel::rowCount(const QModelIndex &parent) const
{
    return this->varList.count();
}
int ParkModel::columnCount(const QModelIndex &parent) const
{
    return 8;
}
QVariant ParkModel::data(const QModelIndex &index, int role) const
{
    switch (role)
    {
    case Qt::DisplayRole:
        switch (index.column())
        {
        case 0:
            return this->varList.at(index.row()).toMap().value("building").toString();
        case 1:
            return this->varList.at(index.row()).toMap().value("name").toString();
        case 2:
            return this->varList.at(index.row()).toMap().value("phone").toString();
        case 3:
            return this->varList.at(index.row()).toMap().value("vehicle").toString();
        case 4:
            return this->varList.at(index.row()).toMap().value("parking").toString();
        case 5:
            return this->varList.at(index.row()).toMap().value("start").toString();
        case 6:
            return this->varList.at(index.row()).toMap().value("end").toString();
        case 7:
            return this->varList.at(index.row()).toMap().value("pay").toString();
        }
    default:
        break;
    }
    return QVariant();
}
/*
QHash<int, QByteArray> ParkModel::roleNames() const
{
    return { {Qt::DisplayRole, "display"} };
}
*/
Q_INVOKABLE void ParkModel::setData(const QVariantList &var)
{
    this->beginInsertRows(QModelIndex(), this->rowCount(), this->rowCount());
    this->varList = var;
    this->endInsertRows();
    return;
}
ParkModel::~ParkModel(){}
