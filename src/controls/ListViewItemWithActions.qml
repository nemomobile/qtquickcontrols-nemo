import QtQuick 2.6
import QtQuick.Controls.Nemo 1.0

import QtGraphicalEffects 1.0

Item {
    id: root
    width: parent.width
    height: Theme.itemHeightLarge

    property string label: ""

    property string description: ""
    property string subdescription: ""
    property string icon: ""

    property bool showNext: true
    property bool iconVisible: true

    property alias actions: actionsLoader.sourceComponent

    signal clicked

    function hideAllActions() {
        root.ListView.view.hideAllActions(index)
    }

    Connections {
        target: root.ListView.view
        onHideAllActions: {
            if (hideIndex != index) {
                listArea.x = 0
            }
        }
    }

    Rectangle{
        id: actionsArea
        color: Theme.fillColor

        anchors.right: listArea.left

        height: listArea.height
        width: childrenRect.width

        Loader {
            id: actionsLoader
        }
    }

    Rectangle{
        id: listArea
        width: root.width
        height: root.height
        color: "transparent"

        Behavior on x{
            NumberAnimation { duration: 200}
        }

        Rectangle {
            anchors.fill: parent
            color: "#11ffffff"
            visible: mouse.pressed
        }

        Image{
            id: itemIcon
            height: iconVisible ? parent.height-Theme.itemSpacingSmall : 0
            width: height
            anchors{
                left: parent.left
                leftMargin: Theme.itemSpacingLarge
                verticalCenter:parent.verticalCenter
            }

            sourceSize.width: width
            sourceSize.height: height
            visible: iconVisible
            source: (icon != "") ? icon : iconVisible ? "images/listview-icon-template-s.svg" : ""
            fillMode: Image.PreserveAspectFit
        }

        Rectangle{
            id: dataArea
            width: parent.width-itemIcon.width-Theme.itemHeightLarge - (showNext ? arrowItem.width : 0)
            height: labelItem.height+(description != "" ? descriptionItem.height : 0)+(subdescription != "" ? subDescriptionItem.height : 0)
            clip: true

            anchors{
                left: iconVisible ? itemIcon.right : parent.left
                leftMargin: Theme.itemSpacingLarge
                verticalCenter: iconVisible ? itemIcon.verticalCenter : parent.verticalCenter
            }
            color: "transparent"

            Label {
                id: labelItem
                color: Theme.textColor
                text: label
                anchors{
                    left: parent.left
                    right: parent.right
                }
                font.pixelSize: Theme.fontSizeMedium
                clip: true
            }

            Label {
                id: descriptionItem
                color: Theme.textColor
                text: description
                anchors{
                    left: parent.left
                    right: parent.right
                    top: labelItem.bottom
                }
                font.pixelSize: Theme.fontSizeTiny
                clip: true
                visible: description != ""
            }

            Label {
                id: subDescriptionItem
                color: Theme.textColor
                text: subdescription
                anchors{
                    left: parent.left
                    right: parent.right
                    top: descriptionItem.bottom
                }
                font.pixelSize: Theme.fontSizeTiny
                clip: true
                visible: subdescription != ""
            }

            Item{
                width: Theme.itemHeightExtraSmall / 2
                height: parent.height
                anchors{
                    top: parent.top
                    right: parent.right
                }
                visible: showNext ? !mouse.pressed : false
                LinearGradient{
                    anchors.fill: parent
                    start: Qt.point(0, 0)
                    end: Qt.point( Theme.itemHeightExtraSmall / 2, 0)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "transparent" }
                        GradientStop { position: 1.0; color: "black" }
                    }
                }
            }
        }

        Image {
            id: arrowItem
            height: parent.height- Theme.itemSpacingSmall
            width: height

            anchors{
                right: parent.right
                rightMargin: Theme.itemSpacingLarge
                verticalCenter: parent.verticalCenter
            }

            sourceSize.width: width
            sourceSize.height: height

            source: "images/listview-icon-arrow.svg"
            visible: showNext
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            onClicked: {
                //if actions is hide
                if(listArea.x === 0)
                {
                    root.clicked()
                }
                else
                {
                    listArea.x = 0
                }
            }

            onPressed: {
                hideAllActions()
            }

            onPressAndHold: {
                if (actionsLoader.item) {
                    listArea.x = actionsArea.width
                }
            }
        }
    }
}
