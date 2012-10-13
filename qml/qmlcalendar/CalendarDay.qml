import QtQuick 1.1

Item
{
    id: calendarDayRoot
    Flickable
    {
        id: container
        anchors.fill: parent
        contentWidth: calendarDayRoot.width
        contentHeight: appRoot.completeDayHeight
        flickableDirection: Flickable.VerticalFlick

        Row
        {
            CalendarDayTimelist
            {
                id: timeList
                width: 50
                height: appRoot.completeDayHeight
            }

            CalendarDayEventlist
            {
                rootElement: container
                width: calendarDayRoot.width - timeList.width
                height: appRoot.completeDayHeight
            }
        }
    }
}
