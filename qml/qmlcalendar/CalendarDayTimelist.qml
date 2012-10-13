import QtQuick 1.1

Rectangle
{
    id: root
    ListModel
    {
        id: hourList

        ListElement {
            // Don't show the 00.00 time
            hour24: ""
            hour12: ""
//            hour24: "00:00"
//            hour12: "12:00"
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

        Item
        {
            width: root.width
            height: appRoot.hourHeight // 13 height for every 15 minutes (4x = 52). + 1 for the top line + 1 for the half hour devider. Adds up to 54

            Item
            {
                y: -(height / 2)
                width: parent.width

                Text
                {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.rightMargin: 5
                    font.italic: true
                    font.pointSize: 9
                    text: hour24
                    color: "#4c4c4c"
                }
            }
        }
    }

    Column
    {
        anchors.fill: parent
        Repeater
        {
            model: hourList
            delegate: hourDelegate
        }
    }
}
