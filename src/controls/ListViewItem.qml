import QtQuick 2.1
import QtQuick.Controls.Nemo 1.0

Item {
    id: root
    width: parent.width
    height: 88

    property alias label: labelItem.text
    //property alias description: descriptionItem.text

    property string icon: ""
    property string page: ""

    signal clicked

    Rectangle {
        anchors.fill: parent
        color: "#11ffffff"
        visible: mouse.pressed
    }

    Image{
        id: itemIcon
        height: parent.height-10
        width: height
        anchors{
            left: parent.left
            leftMargin: 5
            top: parent.top
            topMargin: 5
        }

        sourceSize.width: width
        sourceSize.height: height

        source: (icon != "") ? icon : "images/listview-icon-template-s.svg"
        //visible: (icon != "")
    }

    Label {
        id: labelItem
        text: modelData
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: itemIcon.right
        anchors.leftMargin: 20
        anchors.right: arrow.left
        anchors.rightMargin: 20
        clip: true
    }

    Image {
        id: arrow
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        source: "images/listview-icon-arrow.svg"
        //visible: (page != "")
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
