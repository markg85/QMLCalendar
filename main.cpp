#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "qmonth.h"
#include "qmonthmodel.h"
#include "qcaleventmodel.h"
#include "utils.h"
#include <QDebug>

#include <QDeclarativeContext>
#include <QStandardItem>
#include <QList>
#include <QAbstractItemModel>

#include <QTreeView>

#include <akonadi/calendar/etmcalendar.h>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

//    QMonth month;

//    for(int i = 0; i < month.arrayMonth().size(); i++)
//    {
////        qDebug() << month.arrayCurrentMonth().size();
//        qDebug() << month.arrayMonth().at(i);
//    }

//    qDebug() << " -------------------------------------------------------------------- ";


//    QDate now = QDate::currentDate();


////    month.recalculate(now.year(), now.month() + 1);
//    month.recalculate("2012-5");


//    for(int i = 0; i < month.arrayMonth().size(); i++)
//    {
////        qDebug() << month.arrayCurrentMonth().size();
//        qDebug() << month.arrayMonth().at(i);
//    }

//    qDebug() << " -------------------------------------------------------------------- ";

    Akonadi::ETMCalendar* cal = new Akonadi::ETMCalendar();
    
    QAbstractItemModel* data = cal->unfilteredModel();
    
    qDebug() << data->rowCount();
    qDebug() << data->columnCount();
    
    QTreeView* test = new QTreeView();
    test->setModel(data);
    test->show();
    
    QCalEventModel eventModel;
    QList<QStandardItem*> list;

    QStandardItem* item = new QStandardItem();
    item->setData(QVariant(QTime(12, 10)), QCalEventModel::Start);
    item->setData(QVariant(QTime(14, 10)), QCalEventModel::End);

    QStandardItem* item2 = new QStandardItem();
    item2->setData(QVariant(QTime(8, 30)), QCalEventModel::Start);
    item2->setData(QVariant(QTime(11, 30)), QCalEventModel::End);

    QStandardItem* item3 = new QStandardItem();
    item3->setData(QVariant(QTime(16, 25)), QCalEventModel::Start);
    item3->setData(QVariant(QTime(22, 50)), QCalEventModel::End);

    QStandardItem* item4 = new QStandardItem();
    item4->setData(QVariant(QTime(3, 0)), QCalEventModel::Start);
    item4->setData(QVariant(QTime(6, 15)), QCalEventModel::End);

    list << item;
    list << item2;
    list << item3;
    list << item4;
    eventModel.appendColumn(list);

    QmlApplicationViewer viewer;
    Utils utils(&viewer);
    QDeclarativeContext *ctxt = viewer.rootContext();
    ctxt->setContextProperty("eventModel", &eventModel);
    ctxt->setContextProperty("utils", &utils);

    qmlRegisterType<QMonthModel>();
    qmlRegisterType<QMonth>("CalendarComponents", 1, 0, "QmlMonth");

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/qmlcalendar/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
