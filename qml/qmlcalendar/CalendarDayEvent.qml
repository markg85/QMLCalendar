import QtQuick 1.1

Item
{
    id: cell
//    opacity: 0.5


    Rectangle
    {
        id: content
        property bool handleOnTop: true
        property bool lastConfig: true

        anchors.top: topHandle.top
        anchors.bottom: bottomHandle.bottom
        width: parent.width
        color: contentMouseArea.pressed ? "orange" : "blue"

        MouseArea
        {
            id: contentMouseArea
            anchors.fill: parent
            drag.target: cell
            drag.axis: Drag.YAxis
            hoverEnabled: true
            onEntered:
            {
                cell.z = 1
            }
            onExited:
            {
                cell.z = 0
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
        height: 20
        color: handleTopMouseArea.pressed ? "orange" : "red"

        MouseArea
        {
            id: handleTopMouseArea
            anchors.fill: parent
            drag.target: topHandle
            drag.axis: Drag.YAxis

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
        height: 20
        y: cell.height - height
        color: handleBottomMouseArea.pressed ? "green" : "yellow"

        MouseArea
        {
            id: handleBottomMouseArea
            anchors.fill: parent
            drag.target: bottomHandle
            drag.axis: Drag.YAxis

            onReleased:
            {
                // Note: the time could also be calculated based on the
                console.log("Handle is released. Recalculate the time of this event.")
            }
        }
    }
}
