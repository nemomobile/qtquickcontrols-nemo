import QtQuick 2.6
import QtQuick.Controls.Nemo 1.0

Item {
    id: shell
    anchors.fill: parent
    signal accepted()
    signal canceled()
    property alias cancelText: cancel.text
    property alias acceptText: accept.text
    property alias headingText: heading.text
    property alias subLabelText: subLabel.text

    property string icon: ""
    property string image: ""

    Image{
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: shell.image
        visible: shell.image != ""
    }

    Rectangle {
        id: shadow
        width: parent.width
        height: (shell.image != "" && shell.icon == "") ? (parent.height-cancel.height)/3 : parent.height-cancel.height
        opacity: 0.65
        color: Theme.backgroundColor
        anchors.bottom: cancel.top
    }

    Image{
        id: icon
        source: shell.icon
        width: Theme.itemHeightMedium
        height: width
        anchors{
            top: shell.top
            topMargin: Theme.itemSpacingHuge
            horizontalCenter: shell.horizontalCenter
        }
        visible: shell.icon != ""
        fillMode: Image.PreserveAspectCrop
    }

    Label {
        id: heading
        width: parent.width*0.95
        anchors{
            centerIn: (shell.image != "" && shell.icon == "") ? shadow : parent
        }
        horizontalAlignment: Text.AlignHCenter
        font.weight: Theme.fontWeightLarge
        font.pixelSize:  (shell.image != "" && shell.icon == "") ? Theme.fontSizeTiny : Theme.fontSizeSmall
        wrapMode: Text.Wrap
    }

    Label {
         id:subLabel
         width: parent.width*0.95
         wrapMode: Text.Wrap
         font.weight: Theme.fontWeightMedium
         font.pixelSize:  (shell.image != "" && shell.icon == "") ? Theme.fontSizeTiny : Theme.fontSizeSmall
         horizontalAlignment: Text.AlignHCenter
         anchors {
             top:heading.bottom
             topMargin: (shell.image != "" && shell.icon == "") ? Theme.itemSpacingSmall : Theme.itemSpacingLarge
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
