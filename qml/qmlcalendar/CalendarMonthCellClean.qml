import QtQuick 1.1

Rectangle
{
    smooth: true

    width: grid.cellWidth - root.gridSpacing
    height: grid.cellHeight - root.gridSpacing
    visible: CurrentMonth
    color: root.currentMonthBGColor

    Behavior on color { ColorAnimation { duration: 200 } }

    Text
    {
        id: name
        anchors.centerIn: parent
        text: DayNumber
        visible: CurrentMonth
        font.bold:
        {
            if(CurrentMonth && root.highlightCurrentDay && monthData.monthFromCurrentDate && DayNumber === monthData.currentDay)
            {
                return root.currentDayBoldText
            }
            return root.currentMonthBoldText
        }

        color:
        {
            if(CurrentMonth && root.highlightCurrentDay && monthData.monthFromCurrentDate && DayNumber === monthData.currentDay)
            {
                return root.currentDayTextColor
            }
            return root.currentMonthTextColor
        }
    }
}
