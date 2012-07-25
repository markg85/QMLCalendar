#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "qmonth.h"
#include "qmonthmodel.h"
#include "qcaleventmodel.h"
#include <QDebug>

#include <QDeclarativeContext>
#include <QStandardItem>
#include <QList>

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

    QCalEventModel eventModel;

    QStandardItem* item = new QStandardItem();
    item->setData(QVariant(QTime(12, 10)), QCalEventModel::Start);
    item->setData(QVariant(QTime(14, 10)), QCalEventModel::End);

    eventModel.appendRow(item);


    QStandardItem* item2 = new QStandardItem();
    item2->setData(QVariant(QTime(8, 30)), QCalEventModel::Start);
    item2->setData(QVariant(QTime(11, 30)), QCalEventModel::End);

    eventModel.appendRow(item2);


    QStandardItem* item3 = new QStandardItem();
    item3->setData(QVariant(QTime(16, 25)), QCalEventModel::Start);
    item3->setData(QVariant(QTime(22, 50)), QCalEventModel::End);

    eventModel.appendRow(item3);


    QStandardItem* item4 = new QStandardItem();
    item4->setData(QVariant(QTime(3, 0)), QCalEventModel::Start);
    item4->setData(QVariant(QTime(6, 15)), QCalEventModel::End);

    eventModel.appendRow(item4);


    QmlApplicationViewer viewer;
    QDeclarativeContext *ctxt = viewer.rootContext();
    ctxt->setContextProperty("eventModel", &eventModel);

    qmlRegisterType<QMonthModel>();
    qmlRegisterType<QMonth>("CalendarComponents", 1, 0, "QmlMonth");

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/qmlcalendar/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
