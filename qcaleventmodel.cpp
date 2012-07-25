#include "qcaleventmodel.h"

#include <QHash>

QCalEventModel::QCalEventModel()
{
    QHash<int, QByteArray> roles;
    roles[Start]                = "Start";
    roles[End]                  = "End";
    roles[MultipleSameStart]    = "MultipleSameStart";
    roles[Overlapping]          = "Overlapping";

    setRoleNames(roles);
}
