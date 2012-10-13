import QtQuick 1.1
import QtDesktop 0.1
import org.kde.plasma.components 0.1 as PlasmaComponents

Rectangle
{
    id: appRoot
    width: 1000
    height: 600
    state: "Day"

    // height properties
    property int hourHeight: (quarterHeight * 4) + halfHourSeperatorHeight + hourSeperatorHeight
    property int quarterHeight: 13
    property int halfHourHeight: quarterHeight * 2 // just convenience
    property int halfHourSeperatorHeight: 1
    property int hourSeperatorHeight: 1
    property int completeDayHeight: hourHeight * 24

    states:
    [
        State
        {
            name: "Day"
            PropertyChanges { target: contentContainer; loaderSource: "Overview.qml" }
        },
        State
        {
            name: "Week"
            PropertyChanges { target: contentContainer; loaderSource: "CalendarWeek.qml" }
        },
        State
        {
            name: "Month"
            PropertyChanges { target: contentContainer; loaderSource: "CalendarMonthHelper.qml" }
        },
        State
        {
            name: "Year"
            PropertyChanges { target: contentContainer; loaderSource: "CalendarYear.qml" }
        }
    ]

    Rectangle
    {
        id: overviewTop
        width: parent.width
        height: 100

        Row
        {
            anchors.centerIn: parent
            spacing: 5
            PlasmaComponents.ButtonRow
            {
                PlasmaComponents.Button
                {
                    text: "Day"
                    onClicked:
                    {
                        appRoot.state = text
                        console.log("Clicked " + text)
                    }
                }

                PlasmaComponents.Button
                {
                    text: "Week"
                    onClicked:
                    {
                        appRoot.state = text
                        console.log("Clicked " + text)
                    }
                }

                PlasmaComponents.Button
                {
                    text: "Month"
                    onClicked:
                    {
                        appRoot.state = text
                        console.log("Clicked " + text)
                    }
                }

                PlasmaComponents.Button
                {
                    text: "Year"
                    onClicked:
                    {
                        appRoot.state = text
                        console.log("Clicked " + text)
                    }
                }
            }
        }
    }

    Rectangle
    {
        id: contentContainer
        anchors.top: overviewTop.bottom
        anchors.bottom: parent.bottom
        width: parent.width

        property string loaderSource: ""
        Loader
        {
            anchors.fill: parent
            source: contentContainer.loaderSource
        }
    }


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

//    Overview
//    {
//        anchors.fill: parent
//    }
}
