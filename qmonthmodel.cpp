#include "qmonthmodel.h"

#include <QHash>

QMonthModel::QMonthModel()
{
    QHash<int, QByteArray> roles;
    roles[PreviousMonth]    = "PreviousMonth";
    roles[NextMonth]        = "NextMonth";
    roles[CurrentMonth]     = "CurrentMonth";
    roles[DayNumber]        = "DayNumber";
    setRoleNames(roles);
}
