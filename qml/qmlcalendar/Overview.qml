import QtQuick 1.1
import org.kde.plasma.components 0.1 as PlasmaComponents

Rectangle
{
    id: root

    Component.onCompleted:
    {
        console.log("width: " + root.width)
        console.log("height: " + root.height)
    }

    Row
    {
        anchors.fill: parent
        spacing: 0
        property int newHeight: parent.height
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

                Rectangle
                {
                    height: parent.height
                    anchors.right: calenderMonth.left
                    anchors.left: parent.left

                    Column
                    {
                        // This stuff should obviously be changed and done through a Qt library or a KDE library.
                        property date jsDate: new Date()
                        property variant dateArray: ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
                        property variant monthArray: ["January","February","March","April","May","June","July","August","September","October","November","December"]

                        Text
                        {
                            x: 5
                            font.pointSize: 85
                            text: parent.jsDate.getDate()
                            color: "#a1a6a9"
                        }

                        Text
                        {
                            x: 5
                            font.pointSize: 15
                            text: parent.dateArray[parent.jsDate.getDay()] + ', ' + parent.monthArray[parent.jsDate.getMonth()] + ', ' + parent.jsDate.getFullYear()
                            color: "#a1a6a9"
                        }
                    }
                }

                CalendarMonth
                {
                    id: calenderMonth
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
            clip: true

            CalendarDay
            {
                anchors.fill: parent
            }
        }
    }
}
