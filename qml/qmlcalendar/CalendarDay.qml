import QtQuick 1.1

Rectangle
{
    id: root

    property int widthOffset: 50

    // height properties
    property int hourHeight: (quarterHeight * 4) + halfHourSeperatorHeight + hourSeperatorHeight
    property int quarterHeight: 13
    property int halfHourHeight: quarterHeight * 2 // just convenience
    property int halfHourSeperatorHeight: 1
    property int hourSeperatorHeight: 1


    ListModel
    {
        id: hourList

        ListElement {
            hour24: "00:00"
            hour12: "12:00"
        }
        ListElement {
            hour24: "01:00"
            hour12: "1:00"
        }
        ListElement {
            hour24: "02:00"
            hour12: "2:00"
        }
        ListElement {
            hour24: "03:00"
            hour12: "3:00"
        }
        ListElement {
            hour24: "04:00"
            hour12: "4:00"
        }
        ListElement {
            hour24: "05:00"
            hour12: "5:00"
        }
        ListElement {
            hour24: "06:00"
            hour12: "6:00"
        }
        ListElement {
            hour24: "07:00"
            hour12: "7:00"
        }
        ListElement {
            hour24: "08:00"
            hour12: "8:00"
        }
        ListElement {
            hour24: "09:00"
            hour12: "9:00"
        }
        ListElement {
            hour24: "10:00"
            hour12: "10:00"
        }
        ListElement {
            hour24: "11:00"
            hour12: "11:00"
        }
        ListElement {
            hour24: "12:00"
            hour12: "12:00"
        }
        ListElement {
            hour24: "13:00"
            hour12: "1:00"
        }
        ListElement {
            hour24: "14:00"
            hour12: "2:00"
        }
        ListElement {
            hour24: "15:00"
            hour12: "3:00"
        }
        ListElement {
            hour24: "16:00"
            hour12: "4:00"
        }
        ListElement {
            hour24: "17:00"
            hour12: "5:00"
        }
        ListElement {
            hour24: "18:00"
            hour12: "6:00"
        }
        ListElement {
            hour24: "19:00"
            hour12: "7:00"
        }
        ListElement {
            hour24: "20:00"
            hour12: "8:00"
        }
        ListElement {
            hour24: "21:00"
            hour12: "9:00"
        }
        ListElement {
            hour24: "22:00"
            hour12: "10:00"
        }
        ListElement {
            hour24: "23:00"
            hour12: "11:00"
        }
    }

    Component
    {
        id: hourDelegate
        Rectangle
        {
            width: root.width - root.widthOffset
            height: root.hourHeight // 13 height for every 15 minutes (4x = 52). + 1 for the top line + 1 for the half hour devider. Adds up to 54
            color: "transparent"

            Rectangle
            {
                width: root.widthOffset
                x: -(root.widthOffset)
                y: -(height / 2)
                visible: index !== 0

                Text
                {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.rightMargin: 5
                    font.italic: true
                    font.pointSize: 9
                    text: hour24
                }
            }

            Column
            {
                anchors.fill: parent

                // Top silver line
                Rectangle
                {
                    height: hourSeperatorHeight
                    width: parent.width
                    color: "silver"
                }

                // first half hour
                Rectangle
                {
                    height: halfHourHeight
                    width: parent.width
                    color: "white"
                }

                // half hour devider
                Rectangle
                {
                    height: halfHourSeperatorHeight
                    width: parent.width
                    color: "#E6E6E6"
                }

                // last half hour
                Rectangle
                {
                    height: halfHourHeight
                    width: parent.width
                    color: "white"
                }
            }
        }
    }


    Flickable
    {
        id: container
        anchors.fill: parent
        contentWidth: data.width
        contentHeight: data.height
        flickableDirection: Flickable.VerticalFlick

        Column
        {
            id: data
            width: root.width - root.widthOffset
            x: root.widthOffset
            Repeater
            {
                model: hourList
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
            x: root.widthOffset
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
                newCalendarEvent.y = container.mouseToPosition(mouseY)
                newCalendarEvent.height = quarterHeight
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

                    var startPosition = container.timeToPosition(splittedStartTime[0], splittedStartTime[1])
                    var endPosition = container.timeToPosition(splittedEndTime[0], splittedEndTime[1])
                    var newHeight = Math.abs(endPosition - startPosition)
                    y = startPosition
                    height = newHeight
                    visible = true

                    console.log("Index: " + index)
                }

                width: container.width
                x: root.widthOffset
            }
        }

        CalendarDayEvent
        {
            id: newCalendarEvent
            width: parent.width
            height: quarterHeight
            x: root.widthOffset
            visible: false
        }

        Rectangle
        {
            height: 1
            width: parent.width
            color: "red"
            x: root.widthOffset
            y: calculateTimeRulerPosition()

            function calculateTimeRulerPosition()
            {
                var currentTime = new Date()
                var newYPos = 0;
                var pixelsPerHour = 54
                var hours = currentTime.getHours()
                var percentageMinutes = (currentTime.getMinutes() / 59)
                newYPos += (hours * pixelsPerHour) + (pixelsPerHour * percentageMinutes)

                return newYPos
            }

            Timer
            {
                interval: 60000 // one minute
                running: true
                repeat: true
                onTriggered: parent.y = parent.calculateTimeRulerPosition()
            }
        }
    }
}
