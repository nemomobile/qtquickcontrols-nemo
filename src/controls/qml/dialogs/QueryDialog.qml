import QtQuick 2.6
import QtQuick.Controls.Nemo 1.0

Item {
    id: shell
    anchors.fill: parent
    signal accepted()
    signal canceled()
    signal selected()
    property alias cancelText: cancel.text
    property alias acceptText: accept.text
    property alias headingText: heading.text
    property alias subLabelText: subLabel.text

    property real bgOpacity: 1;

    property string icon: ""
    property bool inline: true

    function open(){
        shell.visible = true
    }

    function close(){
        shell.visible = false
    }

    Rectangle {
        id: shadow
        width: parent.width
        height: inline ? (parent.height-cancel.height)/3 : parent.height-cancel.height
        opacity: shell.bgOpacity
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
        visible: shell.icon != "" && !inline
        fillMode: Image.PreserveAspectCrop
    }

    Label {
        id: heading
        width: parent.width*0.95
        anchors{
            centerIn: inline ? shadow : parent
        }
        horizontalAlignment: Text.AlignHCenter
        font.weight: Theme.fontWeightLarge
        font.pixelSize:  inline ? Theme.fontSizeTiny : Theme.fontSizeSmall
        wrapMode: Text.Wrap
    }

    Label {
         id:subLabel
         width: parent.width*0.95
         wrapMode: Text.Wrap
         font.weight: Theme.fontWeightMedium
         font.pixelSize:  inline ? Theme.fontSizeTiny : Theme.fontSizeSmall
         horizontalAlignment: Text.AlignHCenter
         anchors {
             top:heading.bottom
             topMargin: inline ? Theme.itemSpacingSmall : Theme.itemSpacingLarge
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
            shell.selected()
            close()
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
            shell.selected()
            close();
        }
    }
}
