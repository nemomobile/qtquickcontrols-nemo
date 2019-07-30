import QtQuick 2.6
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

//This item handles the UI representation for the toolbar
//The UI representation of the drawerLevels is inside the header
//(we may consider having a DrawerLayout element in the future)
Item {
    id: toolsLayoutItem

    anchors.fill: parent

    property alias title: titleTxt.text
    //these have to be initialized when the HeaderToolsLayout is instantiated
    property Header header
    property list<Item> tools
    property list<Item> drawerLevels

    //we'll get rid of this once we'll have the appWindow accessible everywhere
    property bool isUiPortrait: header && header.appWindow.isUiPortrait

    property bool showBackButton: false
    property int toolMeasure: Theme.itemHeightSmall
    height: toolMeasure
    Rectangle {
        id: backButton
        width: opacity ? Theme.itemHeightHuge : 0
        anchors.leftMargin: Theme.itemSpacingLarge
        //check if Stack.view has already been initialized as well
        anchors.verticalCenter: parent.verticalCenter
        antialiasing: true
        height: width
        radius: Theme.itemSpacingExtraSmall / 2
        color: backmouse.pressed ? "#222" : "transparent"

        rotation: isUiPortrait ? 0 : 90

        visible: showBackButton

        NemoIcon {
            anchors.centerIn: parent
            height: toolMeasure
            width: height
            fillMode: Image.PreserveAspectFit
            sourceSize.width: width
            sourceSize.height: height
            source: "image://theme/chevron-left"
        }

        MouseArea {
            id: backmouse
            anchors.fill: parent
            anchors.margins: -Theme.itemSpacingSmall
            onClicked: header && header.stackView && header.stackView.pop()
        }
    }

    Label {
        id: titleTxt
        anchors{
            right: toolButtonsContainer.left
            left: backButton.visible ? backButton.right : parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: Theme.itemSpacingLarge
            rightMargin: Theme.itemSpacingLarge
        }
        clip: true
        font.family: Theme.fontFamily
        color: Theme.textColor
        font.pixelSize: Theme.fontSizeMedium
        font.weight: Font.Bold
        LinearGradient {
            anchors.right: parent.right
            width: Theme.itemHeightMedium
            height: parent.paintedHeight
            visible: titleTxt.paintedWidth >  titleTxt.width
            start: Qt.point(0,0)
            end: Qt.point(width,0)
            gradient: Gradient { GradientStop { position: 0; color: "transparent"}
                GradientStop {position: 0.9; color: Theme.backgroundColor } }
        }
    }


    Item {
        id: toolButtonsContainer
        anchors.right: dots.visible ? dots.left : parent.right
        anchors.rightMargin: Theme.itemSpacingLarge
        anchors.verticalCenter: parent.verticalCenter
        width: tools ? (Theme.itemHeightMedium * Math.min(maxNumberOfToolButtons, tools.length)) : 0
        property int maxNumberOfToolButtons: 3

        RowLayout {
            id: toolsRow
            anchors.centerIn: parent
            height: toolMeasure
            function assignRotationBindings() {
                for (var i=0; i<children.length; ++i) {
                    children[i].rotation = Qt.binding(function() { return isUiPortrait ? 0 : 90 })
                }
            }

            //TODO: THIS IS STUPID :D This is run once every added item (i.e. EVEN IF you add 3 items at the same time)
            //but it's not critical since it will always have a very limited amount of children
            onChildrenChanged: {
                assignRotationBindings()
            }
            children: tools
        }
    }

    NemoIcon {
        id: dots
        anchors{
            right: parent.right
            rightMargin: Theme.itemSpacingLarge
            verticalCenter: parent.verticalCenter
        }
        fillMode: Image.PreserveAspectFit
        height: toolMeasure
        sourceSize.height: height
        visible: drawerLevels && drawerLevels.length > 1
        source: "image://theme/ellipsis-v"
        rotation: isUiPortrait ? 0 : 90
    }
}
