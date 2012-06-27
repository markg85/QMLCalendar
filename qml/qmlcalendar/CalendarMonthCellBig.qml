// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle
{
    smooth: true

    width: grid.cellWidth - root.gridSpacing
    height: grid.cellHeight - root.gridSpacing
    z: 1

    Rectangle
    {
        color: "transparent"
        anchors.fill: parent
        anchors.leftMargin: -1
        anchors.topMargin: -1

        z: 0
        border.width: root.bigCurrentDayBorderWidth
        visible:
        {
            if(CurrentMonth && root.highlightCurrentDay && monthData.monthFromCurrentDate && DayNumber === monthData.currentDay)
            {
                return true;
            }
            return false
        }

        border.color: root.bigCurrentDayBorderColor
    }

    color:
    {
        var modIndex = (index + 1) % 7;
        if(modIndex === 0 || modIndex === 6) // Sat, Sun .. other background
        {
            return root.bigWeekendBGColor;
        }
        else return root.bigDayBGColor
    }

    Behavior on color { ColorAnimation { duration: 200 } }

    Text
    {
        id: name
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 3
        anchors.topMargin: 3
        text:
        {
            if(root.showDayNamesInFirstRow && index <= 6) // first row. Remember, 0 counts as well so this is 7 days!
            {
                return dayNames.get(index).medName + " " + DayNumber
            }
            return DayNumber;
        }

        font.bold:
        {
            if(CurrentMonth)         return root.currentMonthBoldText;
            else if(PreviousMonth)   return root.previousMonthBoldText;
            else if(NextMonth)       return root.nextMonthBoldText;
            else                     return false;
        }

        color: root.bigTextColor
    }
}
