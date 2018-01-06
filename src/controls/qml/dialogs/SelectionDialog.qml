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

    property real bgOpacity: 1;

    property alias model: selectionListView.model
    property int selectedIndex: -1

    property Component delegate: ListViewItemWithActions{
        label: name
        showNext: false
        iconVisible: false

        onClicked: {
            shell.selectedIndex = index
        }
    }

    function open(){
        shell.visible = true
    }

    function close(){
        shell.visible = false
    }

    Rectangle {
        id: shadow
        width: parent.width
        height: parent.height-cancel.height
        opacity: shell.bgOpacity
        color: Theme.backgroundColor
        anchors.bottom: cancel.top
    }

    Label {
        id: heading
        width: parent.width*0.95
        height: Theme.itemHeightLarge

        anchors{
            top: parent.top
        }

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        font.weight: Theme.fontWeightLarge
        font.pixelSize:  Theme.fontSizeSmall
        wrapMode: Text.Wrap
    }

    Label {
         id:subLabel
         width: parent.width*0.95
         wrapMode: Text.Wrap
         font.weight: Theme.fontWeightMedium
         font.pixelSize:  Theme.fontSizeSmall
         horizontalAlignment: Text.AlignHCenter
         anchors {
             top:heading.bottom
             topMargin: Theme.itemSpacingLarge
             horizontalCenter: shell.horizontalCenter
         }
    }

    ListView{
        id: selectionListView
        width: parent.width
        height: (subLabel.text != "") ? parent.height-heading.height-subLabel.height-cancel.height-Theme.itemSpacingLarge
                                      : parent.height-heading.height-cancel.height-Theme.itemSpacingLarge
        delegate: shell.delegate

        anchors.top: subLabel.bottom

        ScrollDecorator{
            flickable: selectionListView
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
            close();
        }
    }
}
