#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "qmonth.h"
#include "qmonthmodel.h"
#include <QDebug>

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


    QmlApplicationViewer viewer;

    qmlRegisterType<QMonthModel>();
    qmlRegisterType<QMonth>("CalendarComponents", 1, 0, "QmlMonth");

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/qmlcalendar/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
