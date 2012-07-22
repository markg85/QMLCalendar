import QtQuick 1.1
import CalendarComponents 1.0


Rectangle
{
    id: root
    color: "transparent"

    function nextMonth()
    {
        monthData.nextMonth()
    }

    function previousMonth()
    {
        monthData.previousMonth()
    }

    // Bold
    property bool previousMonthBoldText:    false
    property bool nextMonthBoldText:        false
    property bool currentMonthBoldText:     false
    property bool currentDayBoldText:       false

    // Text color
    property color previousMonthTextColor:  "#a9a9a9"
    property color nextMonthTextColor:      "#a9a9a9"
    property color currentMonthTextColor:   "#4c4c4c"
    property color currentDayTextColor:     "#5e9be3"

    // Background
    property color previousMonthBGColor:    "#f2f2f2"
    property color nextMonthBGColor:        "#f2f2f2"
    property color currentMonthBGColor:     "white"

    // Grid control
    property color gridLineColor:           "#dedede"
    property int gridSpacing:               1 // The specing between 2 grid elements. This is also the border around the grid.

    // Header control
    property bool includeHeader:            true
    property bool enableMonthName:          true
    property bool enableDayNames:           true
    property bool displayDayNamesInBold:    false
    property color headerBGColorCurrentMonth:"#5e9be3"
    property color dayNamesTextColorNormal: "#a1a6a9"
    property color dayNamesTextColorCurrent:"#a6c5ed"
    property color currentMonthSunkenColor: "#5085ca"

    // Big control (for 1 month overview)
    property color bigWeekendBGColor:       "#f9f9f9"
    property color bigDayBGColor:           "white"
    property color bigTextColor:            "#a5a5a5"
    property color bigCurrentDayBorderColor:"#5e9be3"
    property int   bigCurrentDayBorderWidth:1

    // Other
    property bool highlightCurrentDay:      true
    property bool showDayNamesInFirstRow:   false
    property color highlightCurrentBGColor: "#5e9be3"

    // Month properties
    property alias year: monthData.year
    property alias date: monthData.date
    property alias customMonth: monthData.customMonth
    property alias monthName: monthData.monthName

    states: [
        State {
            name: "yearOverview"
            PropertyChanges { target: monthData; loaderSource: "CalendarMonthCellSmall.qml" }
        },
        State {
            name: "monthOverview"
            PropertyChanges { target: monthData; loaderSource: "CalendarMonthCellBig.qml" }

            // set the default values
            PropertyChanges { target: root; includeHeader:              false }
            PropertyChanges { target: root; showDayNamesInFirstRow:     true }
        },
        State {
            name: "monthOverviewClean" // So clean, all transparent cells, not showing the days befora and after the current month.
            PropertyChanges { target: monthData; loaderSource: "CalendarMonthCellClean.qml" }

            // set the default values
            PropertyChanges { target: root; includeHeader:              true }
            PropertyChanges { target: root; enableMonthName:            false }
            PropertyChanges { target: root; displayDayNamesInBold:      true }
            PropertyChanges { target: root; currentDayBoldText:         true }
            PropertyChanges { target: root; currentMonthTextColor:      "#a1a6a9" }
            PropertyChanges { target: root; dayNamesTextColorNormal:    "#a1a6a9" }
            PropertyChanges { target: root; gridLineColor:              "transparent" }
        }
    ]

    QmlMonth
    {
        id: monthData
        property string loaderSource: ""

        ListModel
        {
            id: dayNames

            ListElement {
                charName: "M"
                medName: "Mon"
                longName: "Monday"
            }
            ListElement {
                charName: "T"
                medName: "Tue"
                longName: "Tuesday"
            }
            ListElement {
                charName: "W"
                medName: "Wed"
                longName: "Wednesday"
            }
            ListElement {
                charName: "T"
                medName: "Thu"
                longName: "Thursday"
            }
            ListElement {
                charName: "F"
                medName: "Fri"
                longName: "Friday"
            }
            ListElement {
                charName: "S"
                medName: "Sat"
                longName: "Saturday"
            }
            ListElement {
                charName: "S"
                medName: "Sun"
                longName: "Sunday"
            }
        }
    }

    Rectangle
    {
        id: subRect
        width: root.gridSpacing + Math.floor((parent.width - root.gridSpacing) / 7) * 7
        height:
        {
            var newHeight = root.gridSpacing + Math.floor((parent.height - root.gridSpacing) / 6) * 6
            if(root.includeHeader)
            {
                // Required because of margins.
                newHeight -= root.gridSpacing;
            }
            return newHeight
        }
        color: root.gridLineColor // We give the lines a color by giving the background a color. Tricky huh ;)


        Rectangle
        {
            id: header
            height:
            {
                // There must be a better way to do this.. This is most certainly going to cause an issue at some point in time.
                if(root.enableMonthName)
                {
                    return 40
                }
                return 20
            }

            visible: includeHeader
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin:
            {
                if(root.includeHeader)
                {
                    // Required because of margins.
                    return root.gridSpacing;
                }
                return 0;
            }
            color:
            {
                //if(monthData.customMonth === monthData.currentMonth)
                if(monthData.customMonth === monthData.currentMonth)
                {
                    return root.headerBGColorCurrentMonth;
                }
                else return "transparent"

            }

            Text
            {
                id: headerText
                text: monthData.monthName
                x: 6
                y: 2
                visible: root.enableMonthName
                font.pixelSize: 14
                font.bold: true
                font.capitalization: Font.Capitalize

                color:
                {
                    if(monthData.customMonth === monthData.currentMonth)
                    {
                        style = Text.Sunken
                        styleColor = currentMonthSunkenColor
                        return "white"
                    }
                    return "black"
                }
            }

            Row
            {
                width: parent.width
                anchors.bottom: parent.bottom
                Repeater
                {
                    model: dayNames
                    Item
                    {
                        width: parent.width/7;
                        height: 20
                        Text
                        {
                            text: medName
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pointSize: 7
                            font.bold: root.displayDayNamesInBold

                            color:
                            {
                                if(monthData.customMonth === monthData.currentMonth)
                                {
                                    return dayNamesTextColorCurrent
                                }
                                return dayNamesTextColorNormal
                            }
                        }
                    }
                }
            }

            anchors.top: parent.top
        }

        GridView
        {
            id: grid
            anchors.bottom: parent.bottom
            anchors.top:
            {
                if(root.includeHeader)
                {
                    return header.bottom
                }
                return parent.top
            }

            anchors.topMargin: 1
            x: 1

            width: parent.width
            interactive: false
            cellWidth: width / 7
            cellHeight: height / 6

            Component
            {
                id: contactsDelegate
                Item
                {
                    Loader { source: monthData.loaderSource }
                }
            }

            model: monthData.model
            delegate: contactsDelegate
            focus: true
        }


    }
}
