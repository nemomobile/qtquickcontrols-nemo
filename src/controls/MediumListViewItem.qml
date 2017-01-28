import QtQuick 2.1
import QtQuick.Controls.Nemo 1.0

import QtGraphicalEffects 1.0

Item {
    id: root
    width: parent.width
    height: 88

    property string label: ""

    property string description: ""
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
            leftMargin: 20
            top: parent.top
            topMargin: 5
        }

        sourceSize.width: width
        sourceSize.height: height

        source: (icon != "") ? icon : "images/listview-icon-template-s.svg"
        //visible: (icon != "")
    }

    Rectangle{
        id: dataArea
        width: parent.width-itemIcon.width-arrowItem.width-60
        height: (description != "") ? childrenRect.height : labelItem.height
        clip: true

        anchors{
            left:itemIcon.right
            leftMargin: 20
            verticalCenter: itemIcon.verticalCenter
        }
        color: "transparent"

        Text {
            id: labelItem
            color: "#ffffff"
            text: label
            anchors{
                left: parent.left
                right: parent.right
            }
            font.pixelSize: 35
            clip: true
        }

        Text{
            id: descriptionItem
            color: "#ffffff"
            text: description
            anchors{
                left: parent.left
                right: parent.right
                top: labelItem.bottom
            }
            font.pixelSize: 20
            clip: true
            visible: text != ""
        }

        Item{
            width: 15
            height: parent.height
            anchors{
                top: parent.top
                right: parent.right
            }
            visible: !mouse.pressed
            LinearGradient{
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(15, 0)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: "black" }
                }
            }
        }
    }

    Image {
        id: arrowItem
        height: parent.height-10
        width: height

        anchors{
            right: parent.right
            rightMargin: 20
            verticalCenter: parent.verticalCenter
        }

        sourceSize.width: width
        sourceSize.height: height

        source: "images/listview-icon-arrow.svg"
        //visible: (page != "")
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
