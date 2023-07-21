//#include <qqml.h>
#include <QAbstractTableModel>
class ParkModel : public QAbstractTableModel
{
    Q_OBJECT
    //QML_ELEMENT
public:
    explicit ParkModel(QObject *parent = nullptr);
    virtual ~ParkModel() override;
    Q_INVOKABLE virtual QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    virtual int columnCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    virtual QVariant data(const QModelIndex&, int) const Q_DECL_OVERRIDE;
    //virtual QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;
    Q_INVOKABLE void setData(const QVariantList&);
private:
    QVariantList varList;
};
