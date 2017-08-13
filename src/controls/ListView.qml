import QtQuick 2.6
import QtQuick.Controls 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles.Nemo 1.0

ListView {
    id: listView

    signal hideAllActions(int hideIndex)

    property bool showDecorator: false
    property color delegateColor: Theme.backgroundColor
    property color bottomGradientColor: Theme.backgroundColor
    property color scrollerDecoratorColor: Theme.accentColor

    section.criteria: ViewSection.FullString
    section.delegate: Component{
        id: sectionHeading
        Rectangle {
            width: listView.width
            height: size.dp(44)
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
                height: 1
                color: Theme.textColor
                width: listView.width-sectionText.width-size.dp(30)
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
        height: size.dp(30)
        anchors.bottom: parent.bottom

        visible: listView.contentHeight > listView.height

        LinearGradient{
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(0, size.dp(30))
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 1.0; color: bottomGradientColor }
            }

        }
    }

    Rectangle{
        id: scrollerDecorator
        visible: (listView.showDecorator && listView.contentHeight > listView.height)
        color: scrollerDecoratorColor

        width: size.dp(5)
        height: listView.height*listView.height/listView.contentHeight
        y: (listView.height)/listView.contentHeight*listView.contentY

        anchors{
            right: listView.right
            rightMargin: size.dp(4)
        }
    }
}

