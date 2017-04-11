import QtQuick 2.1
import QtQuick.Controls.Nemo 1.0

import QtGraphicalEffects 1.0

Item {
    id: root
    width: parent.width
    height: 60

    property string label: ""

    property string description: ""
    property string subdescription: ""
    property string icon: ""
    property string page: ""

    property bool showNext: true

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
        color: "#474747"

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
            height: parent.height-size.dp(10)
            width: height
            anchors{
                left: parent.left
                leftMargin: size.dp(20)
                top: parent.top
                topMargin: size.dp(5)
            }

            sourceSize.width: width
            sourceSize.height: height

            source: (icon != "") ? icon : "images/listview-icon-template-s.svg"
            fillMode: Image.PreserveAspectFit
        }

        Rectangle{
            id: dataArea
            width: parent.width-itemIcon.width-arrowItem.width-size.dp(60)
            height: labelItem.height+(description != "" ? descriptionItem.height : 0)+(subdescription != "" ? subDescriptionItem.height : 0)
            clip: true

            anchors{
                left:itemIcon.right
                leftMargin: size.dp(20)
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
                font.pixelSize: size.dp(30)
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
                font.pixelSize: size.dp(18)
                clip: true
                visible: description != ""
            }

            Text{
                id: subDescriptionItem
                color: "#ffffff"
                text: subdescription
                anchors{
                    left: parent.left
                    right: parent.right
                    top: descriptionItem.bottom
                }
                font.pixelSize: size.dp(18)
                clip: true
                visible: subdescription != ""
            }

            Item{
                width: size.dp(15)
                height: parent.height
                anchors{
                    top: parent.top
                    right: parent.right
                }
                visible: !mouse.pressed
                LinearGradient{
                    anchors.fill: parent
                    start: Qt.point(0, 0)
                    end: Qt.point(size.dp(15), 0)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "transparent" }
                        GradientStop { position: 1.0; color: "black" }
                    }
                }
            }
        }

        Image {
            id: arrowItem
            height: parent.height-size.dp(10)
            width: height

            anchors{
                right: parent.right
                rightMargin: size.dp(20)
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
