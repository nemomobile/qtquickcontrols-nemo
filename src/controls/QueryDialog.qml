import QtQuick 2.6

Rectangle {
    id: shell
    anchors.fill: parent
    opacity: 0.7
    color: Theme.backgroundColor
    signal accepted()
    signal canceled()
    property alias cancelText: cancel.text
    property alias acceptText: accept.text
    property alias headingText: heading.text

    Label {
        width: parent.width*0.8
        id: heading
        anchors.centerIn: parent
        wrapMode: Text.Wrap
    }

    Button {
        id: cancel
        width: parent.width / 2
        anchors {
            left: parent.left
            bottom: parent.bottom
        }
        onClicked: {
            shell.canceled()
            shell.destroy()
        }
    }
    Button {
        id: accept
        width: parent.width / 2
        anchors {
            left: cancel.right
            bottom: parent.bottom
        }
        onClicked: {
            shell.accepted()
            shell.destroy()
        }
    }
}
