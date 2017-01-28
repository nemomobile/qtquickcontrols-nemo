import QtQuick 2.1
import QtQuick.Controls 1.0

import QtQuick.Controls.Styles.Nemo 1.0

ListView {
    id: listView
    section.criteria: ViewSection.FullString
    section.delegate: Component{
        id: sectionHeading
        Rectangle {
            width: listView.width
            height: 44
            color: "black"

            Text {
                id: sectionText
                text: section
                font.capitalization: Font.AllUppercase
                font.pixelSize: 20
                color: "white"
                anchors{
                    left: parent.left
                    leftMargin: 10
                    verticalCenter: parent.verticalCenter
                }
            }

            Rectangle{
                id: line
                height: 1
                color: "white"
                width: listView.width-sectionText.width-30
                anchors{
                    left: sectionText.right
                    leftMargin: 10
                    verticalCenter: sectionText.verticalCenter
                }
            }
        }
    }
}

