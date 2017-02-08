import QtQuick 2.0

Item {
    id: glacierRoller
    property alias model : view.model
    property alias label: label.text
    property alias delegate: view.delegate

    property int currentIndex: -1
    property int activateSize: 5
    property int itemHeight: 40

    property bool active: false

    signal clicked();
    signal select(int currentItem);

    width: parent.width
    height: childrenRect.height

    Text{
        id: label
        visible: label.text != ""
        font.capitalization: Font.AllUppercase
        font.pixelSize: 14
        color: "white"

        anchors{
            top: parent.top
            left: parent.left
            leftMargin: itemHeight/2
        }
    }

    Rectangle{
        id: topLine
        width: view.width
        height: 1
        color: "white"
        anchors.top: view.top
        z: 2
    }

    Rectangle{
        id: bottomLine
        width: view.width
        height: 3
        color: "white"
        anchors.bottom: view.bottom
        z: 2
    }

    ListView{
        id: view

        interactive: active
        width: parent.width
        height: 40
        clip: true

        anchors{
            top: label.top
            topMargin: 20
            left: label.left
            leftMargin: 30
        }

        snapMode: ListView.SnapToItem

        Image{
            id: arrowDown
            source: "images/glacierroller-icon-arrow-down.svg"
            width: itemHeight/4
            height: width

            sourceSize.width: width
            sourceSize.height: height

            x: view.currentItem.width+25

            anchors{
                verticalCenter: view.verticalCenter
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    active = true
                }
            }
        }
    }

    Component.onCompleted: {
        if(active)
        {
            bottomLine.opacity = 1
            topLine.opacity = 1
            view.height = itemHeight*activateSize
            arrowDown.visible = false
        }
        else
        {
            bottomLine.opacity = 0
            topLine.opacity = 0
            view.height = itemHeight
            arrowDown.visible = true
        }
    }

    onCurrentIndexChanged: {
        view.currentIndex = currentIndex
        arrowDown.x = view.currentItem.width+25
    }

    onActiveChanged: {
        if(active)
        {
            arrowDown.visible = false
            activateAnimations.start()
        }
        else
        {
            deActivateAnimations.start()
            view.positionViewAtIndex(currentIndex,ListView.SnapPosition)
        }
    }

    ParallelAnimation {
        id: activateAnimations
        NumberAnimation{target: bottomLine; property: "opacity"; to: 1; duration: 400}
        NumberAnimation{target: topLine; property: "opacity"; to: 1; duration: 400}
        NumberAnimation{target: view; property: "height"; to: itemHeight*activateSize; duration: 400}
    }

    ParallelAnimation {
        id: deActivateAnimations
        NumberAnimation{target: bottomLine; property: "opacity"; to: 0; duration: 400}
        NumberAnimation{target: topLine; property: "opacity"; to: 0; duration: 400}
        NumberAnimation{target: view; property: "height"; to: itemHeight; duration: 400}
        onStopped: {
            arrowDown.visible = true
        }
    }
}
