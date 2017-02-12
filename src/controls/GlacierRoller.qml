import QtQuick 2.0

Item {
    id: glacierRoller
    property alias model : view.model
    property alias label: label.text
    property alias delegate: view.delegate
    property int currentIndex: -1
    property int activateSize: 5
    property alias itemHeight: view.itemHeight

    property bool activated: false

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

    PathView{
        id: view
        property int itemHeight: 40
        property bool showRow: false

        interactive: activated
        width: parent.width-60
        height: 40
        clip: true

        anchors{
            top: label.top
            topMargin: 20
            left: label.left
            leftMargin: 30
        }

        pathItemCount: height/itemHeight
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        dragMargin: view.width

        path: Path {
            startX: view.width/2; startY: 0
            PathLine { x: view.width/2; y: view.pathItemCount*itemHeight }
        }

        snapMode: PathView.SnapToItem
    }


    Component.onCompleted: {
        if(activated)
        {
            view.showRow = false
            bottomLine.opacity = 1
            topLine.opacity = 1
            view.height = itemHeight*activateSize
        }
        else
        {
            view.showRow = true
            bottomLine.opacity = 0
            topLine.opacity = 0
            view.height = itemHeight
        }
    }

    onCurrentIndexChanged: {
        view.currentIndex = currentIndex
    }

    onActivatedChanged: {
        if(activated)
        {
            view.showRow = false
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
        NumberAnimation{target: bottomLine; property: "opacity"; to: 1; duration: 250}
        NumberAnimation{target: topLine; property: "opacity"; to: 1; duration: 250}
        NumberAnimation{target: view; property: "height"; to: itemHeight*activateSize; duration: 250}
    }

    ParallelAnimation {
        id: deActivateAnimations
        NumberAnimation{target: bottomLine; property: "opacity"; to: 0; duration: 250}
        NumberAnimation{target: topLine; property: "opacity"; to: 0; duration: 250}
        NumberAnimation{target: view; property: "height"; to: itemHeight; duration: 250}
        onStopped: {
            view.showRow = true
        }
    }
}
