import QtQuick 1.1

Grid
{
    id: yearOverview
    anchors.centerIn: parent
    rows: 3
    columns: 4
    spacing: 10

    property int calculatedWidthPerMonth: (width - (spacing * columns)) / columns
    property int calculatedHeightPerMonth: (height - (spacing * rows)) / rows

    Repeater
    {
        model: 12
        CalendarMonth
        {
//            width: 250
            width: yearOverview.calculatedWidthPerMonth
//            height: 175
            height: yearOverview.calculatedHeightPerMonth
            customMonth: index + 1
            date: year + "-" + customMonth
            state: "yearOverview"
        }
    }
}
