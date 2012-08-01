import QtQuick 1.1

Rectangle
{
    id: root

    property int widthOffset: 50

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
            height: 54 // 13 height for every 15 minutes (4x = 52). + 1 for the top line + 1 for the half hour devider. Adds up to 54
            color: "transparent"

            Rectangle
            {
                width: root.widthOffset
                height: 20
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
                    height: 1
                    width: parent.width
                    color: "silver"
                }

                // first half hour
                Rectangle
                {
                    height: 26
                    width: parent.width
                    color: "white"
                }

                // half hour devider
                Rectangle
                {
                    height: 1
                    width: parent.width
                    color: "#E6E6E6"
                }

                // last half hour
                Rectangle
                {
                    height: 26
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

        signal anchorTop(bool top)
        signal anchorRelease()

        onAnchorTop:
        {
            if(top)
            {
                newCalendarEvent.anchors.top = placeholderHack.top
                newCalendarEvent.anchors.bottom = undefined
            }
            else
            {
                newCalendarEvent.anchors.bottom = placeholderHack.bottom
                newCalendarEvent.anchors.top = undefined
            }
        }

        onAnchorRelease:
        {
            newCalendarEvent.anchors.bottom = undefined
            newCalendarEvent.anchors.top = undefined
        }

        function calculatePosition(numberOfHours, numberOfQuarters)
        {
            var hoursPos = numberOfHours * 54
            var quarterPos = numberOfQuarters * 13

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

            // We only added top lines, so the last entry has no line. This one fills that up.
            // Bottom silver line
            Rectangle
            {
                height: 1
                width: parent.width
                color: "silver"
            }
        }

        // this element MUST have the same height as a 15 minutes (1 quarter) have!
        Rectangle
        {
            id: placeholderHack
            width: 13
            height: 13
            radius: 6.5
            x: root.widthOffset
            color: "purple"
            visible: false
        }

        CalendarDayEvent
        {
            id: newCalendarEvent
            width: parent.width
            height: 13
            x: root.widthOffset
            visible: false
        }

        function calculateTimePosition(hours, minutes)
        {
            var newYPos = 0;
            var pixelsPerHour = 54
            var percentageMinutes = (minutes / 59)
            newYPos += (hours * pixelsPerHour) + (pixelsPerHour * percentageMinutes)

            return newYPos
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

                    var startPosition = container.calculateTimePosition(splittedStartTime[0], splittedStartTime[1])
                    var endPosition = container.calculateTimePosition(splittedEndTime[0], splittedEndTime[1])
                    var newHeight = Math.abs(endPosition - startPosition)
                    y = startPosition
                    height = newHeight
                    visible = true

                    console.log(".... someone .... " + index)
                }

                onDisableMousearea:
                {
                    encapsulatingMouseArea.enabled = false
                }

                onEnableMousearea:
                {
                    encapsulatingMouseArea.enabled = true
                }

                width: container.width
                x: root.widthOffset
            }
        }


        Rectangle
        {
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

            height: 1
            width: parent.width
            color: "red"
            x: root.widthOffset
            y: calculateTimeRulerPosition()
        }

        MouseArea
        {
            property int initNumOfHours: 0
            property int initNumOfQuarters: 0

            property int lastNumOfHours: 0
            property int lastNumOfQuarters: 0

            property bool lastAnchorTop: false

            acceptedButtons: Qt.LeftButton
            width: parent.width
            height: parent.height
            x: root.widthOffset
            enabled: true
            id: encapsulatingMouseArea
            preventStealing: true

            function calculateCellInDay()
            {
                if(mouseY < 0 || mouseY > height) return;

                var numberOfHours = Math.floor(mouseY / 54)
                var remainingPosition = mouseY % 54


                if(remainingPosition <= 27) // 2x13 + 1 for the top border
                {
                   remainingPosition -= 1 // subtract 1 since the top border doesn't count
                }
                else if(remainingPosition > 27) // this number included the top border and the half hour divider
                {
                    remainingPosition -= 2 // subtract 2, 1 for the top border, one for the half hour divider
                }

                var numberOfQuarters = Math.floor(remainingPosition / 13)

    //            if(lastNumOfHours === numberOfHours && lastNumOfQuarters === numberOfQuarters)
    //            {
    //                console.log("-- 001")
    //                return
    //            }

                var anchoringTop = lastAnchorTop
                if(numberOfQuarters < 0) return;

                if(numberOfHours > initNumOfHours)
                {
                    anchoringTop = true
                }
                else if(numberOfHours == initNumOfHours && numberOfQuarters >= initNumOfQuarters)
                {
                    anchoringTop = true
                }
                else if(numberOfHours == initNumOfHours && numberOfQuarters < initNumOfQuarters)
                {
                    anchoringTop = false
                }
                else
                {
                    anchoringTop = false
                }

                if(lastAnchorTop !== anchoringTop)
                {
                    container.anchorTop(anchoringTop)
                }

                lastNumOfHours = numberOfHours
                lastNumOfQuarters = numberOfQuarters
                lastAnchorTop = anchoringTop

                return {numOfHours: numberOfHours, numOfQuarters: numberOfQuarters, anchoringTop: anchoringTop}
            }

            onPositionChanged:
            {
                var cellData = calculateCellInDay()
                if(cellData)
                {
                    var placementPosition = container.calculatePosition(cellData.numOfHours, cellData.numOfQuarters)
                    var initPosition = container.calculatePosition(initNumOfHours, initNumOfQuarters)
                    var newHeight = Math.abs(placementPosition - initPosition)

                    // the added 13 is to select the curent hoverinh row.
                    newCalendarEvent.height = 13 + newHeight
                }
            }

            onPressed:
            {
                console.log("pressed")
                var cellData = calculateCellInDay()
                if(cellData)
                {
                    var placementPosition = container.calculatePosition(cellData.numOfHours, cellData.numOfQuarters)
                    initNumOfHours = cellData.numOfHours
                    initNumOfQuarters = cellData.numOfQuarters
                    placeholderHack.y = placementPosition
                    container.anchorTop(true)
                    placeholderHack.visible = true
                    newCalendarEvent.visible = true
                    newCalendarEvent.height = 13
                }

            }

            onReleased:
            {
                console.log("released")
                placeholderHack.visible = false
                initNumOfHours = 0
                initNumOfQuarters = 0
                container.anchorRelease()
            }

        }
    }

}

