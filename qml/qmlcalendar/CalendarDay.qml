import QtQuick 1.1

Rectangle
{
    id: root

    property int leftTextOffset: 75

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
        id: rowDelegate


        Rectangle
        {
            width: root.width
            height: 52
            color: "transparent"

            property int leftTextOffset: root.leftTextOffset

            Text
            {
                width: root.leftTextOffset
                anchors.top: one.top
                text: hour24
                anchors.topMargin: - (font.pointSize / 2) - 3 // i have to add "-3" to make it look nicely centered.. Why?
                horizontalAlignment: Text.AlignRight
                x: -5
                visible: (index === 0 || hourList.count === index) ? false : true
            }

            /**
              Yes, the following code could be done a lot smaller using a repeater with a model number of 4.
              It would be cleaner but a lot harder to figure out what's wrong when something goos bad.

              This code is meant to have a readable structure of how an hour is represented.
            **/

            // The first "15 minutes" are id one.
            Rectangle
            {
                id: one
                width: parent.width
                x: root.leftTextOffset
                height: 13
            }

            // We only paint the top grey line if it's the first hour (0.00) otherwise we don't need this line.
            // Note, no need to anchor because this item is drawn after the "one" item and draws on top of it.
            Rectangle
            {
                width: parent.width
                x: root.leftTextOffset
                height: 1
                color: "silver"
                visible: (index === 0) ? true : false
            }

            // The second 15 minutes (.15 till .30)
            Rectangle
            {
                id: two
                x: root.leftTextOffset
                anchors.top: one.bottom
                width: parent.width
                height: 13
            }

            // Half hour seperator
            Rectangle
            {
                anchors.bottom: two.bottom
                x: root.leftTextOffset
                width: parent.width
                height: 1
                color: "#E6E6E6"
            }

            // Third 15 minutes (.30 till .45)
            Rectangle
            {
                id: three
                x: root.leftTextOffset
                anchors.top: two.bottom
                width: parent.width
                height: 13
            }

            // Fourth 15 minutes (.45 till .00)
            Rectangle
            {
                id: four
                x: root.leftTextOffset
                anchors.top: three.bottom
                width: parent.width
                height: 13
            }

            // The bottom hour seperator. This seperator is always drawn and also serves as top hour seperator (after 0.00)
            Rectangle
            {
                anchors.bottom: four.bottom
                x: root.leftTextOffset
                width: parent.width
                height: 1
                color: "silver"
            }
        }
    }

    Flickable
    {
        anchors.fill: parent
        contentWidth: contentList.width
        contentHeight: contentList.height
        interactive: false

        MouseArea
        {
            anchors.fill: parent
            anchors.leftMargin: root.leftTextOffset
            z: 1
            property bool activeSelection: false



            function calculateNewPosition()
            {
                var rootItem = contentList.childAt(mouseX, mouseY)
                if(rootItem === null)
                {
                    return
                }

                var tempY = mouseY % rootItem.height
                var tempX = mouseX % rootItem.width
                var item = rootItem.childAt(tempX, tempY)

                if(item === null)
                {
                    return
                }

                if(item.height === 13)
                {
                    var newXPos = parent.x
                    var newYPos = (mouseY - tempY) + (item.y - item.height) + 13

                    return {x: newXPos, y: newYPos}
                }
            }

            onPositionChanged:
            {
                var newPositions = calculateNewPosition()
                if(newPositions)
                {
                    if(!activeSelection)
                    {
                        // Set our ugly anchor hacking element
                        uglyAnchorHack.x = newPositions.x + root.leftTextOffset
                        uglyAnchorHack.y = newPositions.y

                        activeSelection = true
                    }

                    var tempHeight = Math.abs(newPositions.y - uglyAnchorHack.y)

                    if(tempHeight === rowSelection.lastHeight)
                    {
                        // Same height, skip it.
                        return
                    }

                    if((newPositions.y - uglyAnchorHack.y) >= 0 && rowSelection.state !== "topAchored")
                    {
                        rowSelection.state = "topAchored"
                        console.log("Top anchored")
                    }

                    if((newPositions.y - uglyAnchorHack.y) < 0 && rowSelection.state !== "bottomAchored")
                    {
                        rowSelection.state = "bottomAchored"
                        console.log("Bottom anchored")
                    }

                    if(tempHeight < 13)
                    {
                        tempHeight = 13
                    }

                    console.log(tempHeight)

                    rowSelection.height = tempHeight
                    rowSelection.lastHeight = tempHeight
                }
            }

            onReleased:
            {
                rowSelection.state = "clearAnchors"
                activeSelection = false
            }
        }

        Rectangle
        {
            id: rowSelection
            width: 100
            height: 100
            color: "red"
            opacity: 0.5
            z: 2

            Behavior on opacity
            {
                NumberAnimation {}
            }

            states: [
                State {
                    name: "topAchored"
                    AnchorChanges {
                        target: rowSelection
                        anchors.top: uglyAnchorHack.top
                        anchors.left: uglyAnchorHack.left
                    }
                },
                State {
                    name: "bottomAchored"
                    AnchorChanges {
                        target: rowSelection
                        anchors.bottom: uglyAnchorHack.bottom
                        anchors.left: uglyAnchorHack.left
                    }
                },
                State {
                    name: "clearAnchors"
                    AnchorChanges {
                        target: rowSelection
                        anchors.top: undefined
                        anchors.bottom: undefined
                        anchors.left: undefined
                    }
                    PropertyChanges { target: rowSelection; opacity: 1.0 }
                }
            ]

            property int lastHeight: 0
        }

        Rectangle
        {
            id: uglyAnchorHack
            color: "purple"
            z: 100
            width: 13
            height: 13
        }

        Column
        {
            id: contentList

            Repeater
            {
                model: hourList
                delegate: rowDelegate
            }
        }

    }
}
