import QtQuick 1.1

// A calendar week consists of multiple calendar days (7) to show a full week.
Rectangle
{
    id: calendarWeek
    clip: true

    Flickable
    {
        id: container
        anchors.fill: parent
        contentWidth: calendarWeek.width
        contentHeight: appRoot.completeDayHeight
        flickableDirection: Flickable.VerticalFlick

        property int widthPerDay: (calendarWeek.width - widthOfTimelist) / numOfDays
        property int numOfDays: 7

        Row
        {
            CalendarDayTimelist
            {
                id: timeList
                width: appRoot.widthOfTimelist
                height: appRoot.completeDayHeight
            }

            Repeater
            {
                model: container.numOfDays
                id: repeaterElement
                CalendarDayEventlist
                {
                    rootElement: repeaterElement
                    width: container.widthPerDay
                    height: appRoot.completeDayHeight
                    repeaterIndex: index
                }
            }
        }
    }
}
