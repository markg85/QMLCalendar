import QtQuick 1.1

Item
{
    id: calendarEventlistRoot
    property Item rootElement: null
    property int repeaterIndex: 0

    Component
    {
        id: hourDelegate

        Rectangle
        {
            width: calendarEventlistRoot.width
            height: appRoot.hourHeight // 13 height for every 15 minutes (4x = 52). + 1 for the top line + 1 for the half hour devider. Adds up to 54
            color: "transparent"

            Column
            {
                anchors.fill: parent

                // Top silver line
                Rectangle
                {
                    height: appRoot.hourSeperatorHeight
                    width: parent.width
                    color: "silver"
                }

                // first half hour
                Rectangle
                {
                    height: appRoot.halfHourHeight
                    width: parent.width
                    color: "white"
                }

                // half hour devider
                Rectangle
                {
                    height: appRoot.halfHourSeperatorHeight
                    width: parent.width
                    color: "#E6E6E6"
                }

                // last half hour
                Rectangle
                {
                    height: appRoot.halfHourHeight
                    width: parent.width
                    color: "white"
                }
            }
        }
    }

    Column
    {
        id: data
        width: calendarEventlistRoot.width
        Repeater
        {
            model: 24 // A day has 24 hours..
            delegate: hourDelegate
        }

        // We only added top lines, so the last entry has no bottom line. This one fills that up.
        // Bottom silver line
        Rectangle
        {
            height: 1
            width: parent.width
            color: "silver"
        }
    }

    function timeToPosition(hours, minutes)
    {
        var newYPos = 0;
        var percentageMinutes = (minutes / 59)
        newYPos += (hours * hourHeight) + (hourHeight * percentageMinutes)

        return newYPos
    }

    function timeBlockToPosition(numberOfHours, numberOfQuarters)
    {
        var hoursPos = numberOfHours * hourHeight
        var quarterPos = numberOfQuarters * quarterHeight

        if(numberOfQuarters < 2)
        {
            quarterPos += 1
        }
        else if(numberOfQuarters >= 2)
        {
            quarterPos += 2
        }

        return hoursPos + quarterPos
    }

    function mouseToTimePosition(mouseY)
    {
        if(mouseY < 0 || mouseY > data.height) return;

        var numberOfHours = Math.floor(mouseY / hourHeight)
        var remainingPosition = mouseY % hourHeight
        var numberOfQuarters = Math.floor(remainingPosition / quarterHeight)

        return {numOfHours: numberOfHours, numOfQuarters: numberOfQuarters}
    }

    // convenient function so that i only need one call to get the position
    function mouseToPosition(mouseY)
    {
        var cellData = mouseToTimePosition(mouseY)
        return timeBlockToPosition(cellData.numOfHours, cellData.numOfQuarters)
    }

    MouseArea
    {
        acceptedButtons: Qt.LeftButton
        width: parent.width
        height: parent.height
        enabled: true
        id: encapsulatingMouseArea
        preventStealing: true
        property int yStartPosition: 0

        signal enableArea()
        signal disableArea()

        onEnableArea:
        {
            enabled = true
        }

        onDisableArea:
        {
            enabled = false
        }

        onPressed:
        {
            yStartPosition = mouseY
            newCalendarEvent.y = calendarEventlistRoot.mouseToPosition(mouseY)
            newCalendarEvent.height = appRoot.quarterHeight
            newCalendarEvent.visible = true
        }

        onPositionChanged:
        {
            newCalendarEvent.height = (mouseY - yStartPosition) + 5
        }

        onReleased:
        {

        }
    }

    Repeater
    {
        model: eventModel

        CalendarDayEvent
        {
            Component.onCompleted:
            {
                var timeStart = String(Start)
                var splittedStartTime = timeStart.split(":")

                var timeEnd = String(End)
                var splittedEndTime = timeEnd.split(":")

                var startPosition = calendarEventlistRoot.timeToPosition(splittedStartTime[0], splittedStartTime[1])
                var endPosition = calendarEventlistRoot.timeToPosition(splittedEndTime[0], splittedEndTime[1])
                var newHeight = Math.abs(endPosition - startPosition)
                y = startPosition
                height = newHeight
                visible = true

                console.log("Index: " + index + ' - Y: ' + y + ', Height: ' + height)
            }
            width: calendarEventlistRoot.width
            listIndex: calendarEventlistRoot.repeaterIndex
        }
    }

    CalendarDayEvent
    {
        id: newCalendarEvent
        width: parent.width
        height: appRoot.quarterHeight
        visible: false
    }
}
