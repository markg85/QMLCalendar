#ifndef QMONTHMODEL_H
#define QMONTHMODEL_H

#include <QStandardItemModel>

class QMonthModel : public QStandardItemModel
{
public:
    enum MonthRoles
    {
        PreviousMonth = Qt::UserRole + 1,
        NextMonth,
        CurrentMonth,
        DayNumber
    };

    QMonthModel();
};

#endif // QMONTHMODEL_H
