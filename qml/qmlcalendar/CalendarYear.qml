import QtQuick 1.1

Grid
{
    anchors.centerIn: parent
    rows: 3
    columns: 4
    spacing: 10
    Repeater
    {
        model: 12
        CalendarMonth
        {
            width: 250
            height: 175
            customMonth: index + 1
            date: year + "-" + customMonth
            state: "yearOverview"
        }
    }
}
