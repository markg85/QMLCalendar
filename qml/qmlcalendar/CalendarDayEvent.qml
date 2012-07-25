import QtQuick 1.1

Item
{
    // Note, the start.. and end... properties are here for storage purpose only.
    // It's actually being stored in the C++ side which in turn is stored in Akonadi?

    // Start time
    property string startTime: "00:00"           // set externally. Must be set in HH:MM in 24 h format (00:00 - 23:59 max)

    // End time
    property string endTime: "00:00"             // set externally. Must be set in HH:MM in 24 h format (00:00 - 23:59 max)

    Rectangle
    {
        id: content
        anchors.fill: parent
        radius: 5
        border.width: 2
        border.color: "#cccccc"
        color: "#7dcccccc"
        visible: parent.visible
        clip: true

        Text
        {
            x: 5
            y: 5
//            text: "New Event"
        }
    }
}
