import QtQuick 1.1

Rectangle
{
    width: 800
    height: 600

//    CalendarYear
//    {
//        anchors.centerIn: parent
//        //todo: this one should just fit in a given width/height.
//    }

//    CalendarMonth
//    {
//        anchors.fill: parent
//        state: "monthOverview"
//    }


//    CalendarMonth
//    {
//        anchors.centerIn: parent
//        width: 250
//        height: 175
//        state: "monthOverviewClean"
//    }

//    CalendarDay
//    {
//        anchors.fill: parent
//    }
    Overview
    {
        anchors.fill: parent
    }
}
