import QtQuick 2.6
import QtQuick.Controls 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles.Nemo 1.0

ListView {
    id: listView

    signal hideAllActions(int hideIndex)

    property color delegateColor: Theme.backgroundColor
    property color bottomGradientColor: Theme.backgroundColor

    section.criteria: ViewSection.FullString
    section.delegate: Component{
        id: sectionHeading
        Rectangle {
            width: listView.width
            height: Theme.itemHeightMedium
            color: delegateColor

            Text {
                id: sectionText
                text: section
                font.capitalization: Font.AllUppercase
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.textColor
                anchors{
                    left: parent.left
                    leftMargin: Theme.itemSpacingSmall
                    verticalCenter: parent.verticalCenter
                }
            }

            Rectangle{
                id: line
                height: size.ratio(1)
                color: Theme.textColor
                width: listView.width-sectionText.width-Theme.itemHeightExtraSmall
                anchors{
                    left: sectionText.right
                    leftMargin: Theme.itemSpacingSmall
                    verticalCenter: sectionText.verticalCenter
                }
            }
        }
    }

    Item{
        id: bottom
        width: parent.width
        height: Theme.itemHeightExtraSmall
        anchors.bottom: parent.bottom

        visible: listView.contentHeight > listView.height

        LinearGradient{
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(0, Theme.itemHeightExtraSmall)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 1.0; color: bottomGradientColor }
            }

        }
    }
}

