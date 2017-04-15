import QtQuick 2.0
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

    Rectangle {
        id: backButton
        width: opacity ? size.dp(60) : 0
        anchors.leftMargin: Theme.itemSpacingLarge
        //check if Stack.view has already been initialized as well
        anchors.verticalCenter: parent.verticalCenter
        antialiasing: true
        height: width
        radius: size.dp(4)
        color: backmouse.pressed ? "#222" : "transparent"

        rotation: isUiPortrait ? 0 : 90

        visible: showBackButton

        Image {
            anchors.centerIn: parent
            source: "../Styles/Nemo/images/icon-triangle-left.png"
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
        font.pointSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        LinearGradient {
            anchors.right: parent.right
            width: size.dp(50)
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
        anchors.rightMargin: size.dp(20)
        anchors.verticalCenter: parent.verticalCenter
        width: tools ? (size.dp(50) * Math.min(maxNumberOfToolButtons, tools.length)) : 0

        property int maxNumberOfToolButtons: 3

        RowLayout {
            id: toolsRow
            anchors.centerIn: parent

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

    Image {
        id: dots
        anchors{
            right: parent.right
            rightMargin: Theme.itemSpacingLarge
            verticalCenter: parent.verticalCenter
        }
        visible: drawerLevels && drawerLevels.length > 1
        source: "../Styles/Nemo/images/dots-vertical.png"
        rotation: isUiPortrait ? 0 : 90
    }
}
