#ifndef QCALEVENTMODEL_H
#define QCALEVENTMODEL_H

#include <QStandardItemModel>

class QCalEventModel : public QStandardItemModel
{
public:

    enum CalendarEventRoles
    {
        // This flag indicates the start time of an event in HH:MM
        Start = Qt::UserRole + 1,

        // This flag indicates the end time of an event in HH:MM
        End,

        // This flag indicates if there are multiple events with the same starting time
        MultipleSameStart,

        // This flag indicates if there are events that overlap the current one
        Overlapping
    };

    QCalEventModel();
};

#endif // QCALEVENTMODEL_H
