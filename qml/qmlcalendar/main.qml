// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle
{
    width: 800
    height: 600

//    Grid
//    {
//        anchors.centerIn: parent
//        rows: 3
//        columns: 4
//        spacing: 10
//        Repeater
//        {
//            model: 12
//            CalendarMonth
//            {
//                width: 250
//                height: 175
//                customMonth: index + 1
//                date: year + "-" + customMonth
//                state: "yearOverview"
//            }
//        }
//    }

//    CalendarMonth
//    {
//        anchors.fill: parent
//        state: "monthOverview"
//    }


    CalendarMonth
    {
        anchors.centerIn: parent
        width: 250
        height: 175
        state: "monthOverviewClean"
    }

//    CalendarDay
//    {
//        anchors.fill: parent
//    }
}
