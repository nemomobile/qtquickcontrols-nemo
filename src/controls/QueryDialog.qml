import QtQuick 2.6

Item {
    id: shell
    anchors.fill: parent
    signal accepted()
    signal canceled()
    property alias cancelText: cancel.text
    property alias acceptText: accept.text
    property alias headingText: heading.text
    property alias subLabelText: subLabel.text


    Rectangle {
        anchors.fill: parent
        opacity: 0.65
        color: Theme.backgroundColor

    }
    Label {
        width: parent.width*0.8
        id: heading
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        font.weight: Theme.fontWeightLarge
        wrapMode: Text.Wrap
    }
    Label {
         id:subLabel
         width: parent.width*0.8
         wrapMode: Text.Wrap
         font.weight: Theme.fontWeightMedium
         horizontalAlignment: Text.AlignHCenter
         anchors {
             top:heading.bottom
             topMargin: Theme.itemSpacingLarge
             horizontalCenter: shell.horizontalCenter
         }
    }

    Button {
        id: cancel
        width: parent.width / 2
        height: Theme.itemHeightLarge
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
        height: Theme.itemHeightLarge
        primary: true
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
