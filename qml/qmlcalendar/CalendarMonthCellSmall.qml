import QtQuick 1.1

Rectangle
{
    smooth: true

    width: grid.cellWidth - root.gridSpacing
    height: grid.cellHeight - root.gridSpacing
    color:
    {
        if(CurrentMonth && root.highlightCurrentDay && monthData.monthFromCurrentDate && DayNumber === monthData.currentDay)
        {
            return root.highlightCurrentBGColor;
        }
        else if(CurrentMonth)        return root.currentMonthBGColor;
        else if(PreviousMonth)       return root.previousMonthBGColor;
        else if(NextMonth)           return root.nextMonthBGColor;
        else                         return "purple"
    }

    Behavior on color { ColorAnimation { duration: 200 } }

    Text
    {
        id: name
        anchors.centerIn: parent
        text: DayNumber
        font.bold:
        {
            if(CurrentMonth)         return root.currentMonthBoldText;
            else if(PreviousMonth)   return root.previousMonthBoldText;
            else if(NextMonth)       return root.nextMonthBoldText;
            else                     return false;
        }

        color:
        {
            if(CurrentMonth)         return root.currentMonthTextColor;
            else if(PreviousMonth)   return root.previousMonthTextColor;
            else if(NextMonth)       return root.nextMonthTextColor;
            else                     return "purple"
        }
    }
}
