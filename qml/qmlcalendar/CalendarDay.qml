// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle
{
    id: root

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

    Flickable
    {
        anchors.fill: parent
        contentWidth: col2.width
        contentHeight: col2.height

        Column
        {
            id: col2

            Repeater
            {
                model: hourList
                Rectangle
                {
                    height: 52
                    width: root.width
                    border.width: 0
                    x:
                    {
                        if(hour.visible)
                        {
                            return hour.width
                        }
                        return 0
                    }

                    color: "#cccccc"

                    Rectangle
                    {
                        id: hour
                        width: 50
                        x: -width

                        color: "transparent"

                        Text
                        {
                            anchors.centerIn: parent
                            visible: (index === 0) ? false : true
                            text: hour24
                            font.italic: true
                            font.pixelSize: 7
                        }
                    }

                    Column
                    {
                        Repeater
                        {
                            model: 4

                            Rectangle
                            {
                                height: 13
                                width: root.width
                                color: "white"

                                Rectangle
                                {
                                    visible: index === 2
                                    color: "silver"
                                    height: 1
                                    width: root.width
                                }

                                Rectangle
                                {
                                    visible: index === 0
                                    color: "#cccccc"
                                    height: 1
                                    width: root.width
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

//        Column
//        {
//            id: col
//            y: -26
//            Repeater
//            {
//                model: hourList
//                Rectangle
//                {
//                    height: 52
//                    width: 50
////                    border.width: 1
//                    Text
//                    {
//                        anchors.verticalCenter: parent.verticalCenter
//                        anchors.right: parent.right
//                        text:
//                        {
//                            // Skip the first (00.00) text
//                            if(index !== 0)
//                            {
////                                return hour24
//                            }
//                        }
//                    }
//                }
//            }
//        }

//        Rectangle
//        {
//            id: dayHourView
////            anchors.left: col.right
////            anchors.right: root.right
////            anchors.top: root.top
////            anchors.bottom: root.bottom

//            MouseArea
//            {
//                anchors.fill: parent
//                hoverEnabled: true

//                onPositionChanged:
//                {
//                    var rootItem = col2.childAt(mouseX, mouseY)
//                    var tempHeight = mouseY % rootItem.height
//                    var item = col2.childAt(mouseX, mouseY).childAt(0, 0).childAt(0, tempHeight)
//                    item.color = "red"
//                }

//                onEntered:
//                {
////                    var rootItem = col2.childAt(mouseX, mouseY)
////                    var tempHeight = mouseY % rootItem.height
////                    var item = col2.childAt(mouseX, mouseY).childAt(0, 0).childAt(0, tempHeight)
////                    item.color = "red"
////                    parent.color = "red"
//                }
//                onExited:
//                {
////                    var rootItem = col2.childAt(mouseX, mouseY)
////                    var tempHeight = mouseY % rootItem.height
////                    var item = col2.childAt(mouseX, mouseY).childAt(0, 0).childAt(0, tempHeight)
////                    item.color = "white"
////                    parent.color = "white"
//                }
//                onClicked:
//                {
//                    var rootItem = col2.childAt(mouseX, mouseY)
//                    var tempHeight = mouseY % rootItem.height
//                    var item = col2.childAt(mouseX, mouseY).childAt(0, 0).childAt(0, tempHeight)
//                    item.color = "red"




//                    console.log("Click... X: " + mouseX + " Y: " + mouseY + " ID: " + item.id)
////                    console.log("Click... X: " + tempWidth + " Y: " + tempWidth + " ID: " + item.id)
//                    console.log("Item Width: " + item.width + ", height: " + item.height)
//                    console.log(item)
//                }
//            }

//        }


//    }
//}
