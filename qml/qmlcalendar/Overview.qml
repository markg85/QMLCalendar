import QtQuick 1.1

Rectangle
{
    id: root
    Rectangle
    {
        id: overviewTop
        width: parent.width
        height: 100
        color: "purple"

        Row
        {
            anchors.centerIn: parent
            spacing: 5
            Text
            {
                text: "Overview"
            }
            Text
            {
                text: "Day"
            }
            Text
            {
                text: "Week"
            }
            Text
            {
                text: "Month"
            }
            Text
            {
                text: "Year"
            }
        }
    }

    Row
    {
        anchors.top: overviewTop.bottom
        spacing: 0
        property int newHeight: parent.height - overviewTop.height
        Rectangle
        {
            width: root.width / 2
            height: parent.newHeight
            color: "red"

            Rectangle
            {
                id: top
                width: parent.width
                height: 200
                color: "green"

                CalendarMonth
                {
                    anchors.right: parent.right
                    width: 250
                    height: parent.height
                    state: "monthOverviewClean"
                }
            }

        }

        Rectangle
        {
            width: root.width / 2
            height: parent.newHeight
            color: "red"
            clip: true

            CalendarDay
            {
                anchors.fill: parent
            }
        }
    }
}
