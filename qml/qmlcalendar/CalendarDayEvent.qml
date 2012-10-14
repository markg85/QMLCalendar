import QtQuick 1.1

Item
{
    id: cell
    property int listIndex: 0
    property QtObject newParent: null
    state: "default"

    states:
    [
        State {
            name: "reparent"
            ParentChange { target: cell; parent: cell.newParent; x: 0; }
            PropertyChanges { target: cell; state: "default"; }
        },
        State {
            name: "default"
        }
    ]

    Rectangle
    {
        id: content
        property bool handleOnTop: true
        property bool lastConfig: true

        anchors.top: topHandle.top
        anchors.bottom: bottomHandle.bottom
        width: parent.width
        color: "#5e9be3"
        opacity: contentMouseArea.pressed ? 0.5 : 0.8
        border.width: 1
        border.color: "orange"
        radius: 5

        MouseArea
        {
            id: contentMouseArea
            anchors.fill: parent
            drag.target: cell
            drag.axis: Drag.YAxis
            hoverEnabled: true
            property bool isInDrag: false

            onEntered:
            {
                if(isInDrag) return; // As long we are in dragging mode the entered and exited events are ignored
                cell.z = 1
                utils.setCursor(Qt.OpenHandCursor)
            }
            onExited:
            {
                if(isInDrag) return; // As long we are in dragging mode the entered and exited events are ignored
                cell.z = 0
                utils.setCursor(Qt.ArrowCursor)
            }

            onPressed:
            {
                isInDrag = true
                utils.setCursor(Qt.ClosedHandCursor)
                console.log("dragging...")
            }

            onReleased:
            {
                isInDrag = false
                utils.setCursor(Qt.OpenHandCursor)
                console.log("released...")
            }

            onPositionChanged:
            {
                // ehh, this doesn't work as expected. I'd expect this to prevent draging and event on some place where you
                // don't have any lists anymore, but using this locks it in it's current list...
                // TODO: have to figure this one out and fix it.
//                if(cell.parent.rootElement)
//                {
//                    return;
//                }

                if(mouseX < 0)
                {
                    cell.state = "default"
                    cell.listIndex--
                    cell.newParent = cell.parent.rootElement.itemAt(cell.listIndex)
                    cell.state = "reparent"
                }

                if(mouseX > cell.parent.width)
                {
                    cell.state = "default"
                    cell.listIndex++
                    cell.newParent = cell.parent.rootElement.itemAt(cell.listIndex)
                    cell.state = "reparent"
                }
            }
        }

        onHandleOnTopChanged:
        {
            if (handleOnTop)
            {
                anchors.top = topHandle.top;
                anchors.bottom = bottomHandle.bottom;
            }
            else
            {
                anchors.bottom = topHandle.bottom;
                anchors.top = bottomHandle.bottom;
            }
        }

        onHeightChanged:
        {
            // the lastConfig flag is a workaround to avoid the slot
            // onHandleOnTopChanged to be executed more than one time
            // when the mouse is moved too fast during the dragging.
            if (height <= 0 && lastConfig === handleOnTop)
            {
                handleOnTop = !handleOnTop;
                lastConfig = handleOnTop;
            }
        }
    }

    Rectangle
    {
        id: topHandle
        width: parent.width
        height: 10
//        color: handleTopMouseArea.pressed ? "orange" : "red"
        color: "transparent"

        MouseArea
        {
            id: handleTopMouseArea
            anchors.fill: parent
            drag.target: topHandle
            drag.axis: Drag.YAxis
            hoverEnabled: true

            // Untill we have Qt Quick 2 we have to use the utilities object to change the cursor.
            onEntered:
            {
                utils.setCursor(Qt.SizeVerCursor)
            }
            onExited:
            {
                utils.setCursor(Qt.ArrowCursor)
            }

            onReleased:
            {
                // Note: the time could also be calculated based on the
                console.log("Handle is released. Recalculate the time of this event.")
            }
        }
    }

    Rectangle
    {
        id: bottomHandle
        width: parent.width
        height: 10
        y: cell.height - height
//        color: handleBottomMouseArea.pressed ? "green" : "yellow"
        color: "transparent"

        MouseArea
        {
            id: handleBottomMouseArea
            anchors.fill: parent
            drag.target: bottomHandle
            drag.axis: Drag.YAxis
            hoverEnabled: true

            // Untill we have Qt Quick 2 we have to use the utilities object to change the cursor.
            onEntered:
            {
                utils.setCursor(Qt.SizeVerCursor)
            }
            onExited:
            {
                utils.setCursor(Qt.ArrowCursor)
            }

            onReleased:
            {
                // Note: the time could also be calculated based on the
                console.log("Handle is released. Recalculate the time of this event.")
            }

            onPositionChanged:
            {
                if(mouseX < 0)
                {
                    cell.state = "default"
                    cell.listIndex--
                    cell.newParent = cell.parent.rootElement.itemAt(cell.listIndex)
                    cell.state = "reparent"
                }

                if(mouseX > cell.parent.width)
                {
                    cell.state = "default"
                    cell.listIndex++
                    cell.newParent = cell.parent.rootElement.itemAt(cell.listIndex)
                    cell.state = "reparent"
                }
            }
        }
    }
}
