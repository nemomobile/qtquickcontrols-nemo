import QtQuick 2.6

Rectangle{
    id: glacierRollerItem
    color: "transparent"
    width: parent.width
    height: parent.itemHeight

    property alias cWidth: dataLine.width

    default property alias contentItem: dataLine.children
    Rectangle{
        id: dataLine
        width: childrenRect.width
        height: parent.height
        color: "transparent"
        anchors.verticalCenter: glacierRollerItem.verticalCenter
    }

    Image{
        id: arrowDown
        source: "images/glacierroller-icon-arrow-down.svg"
        height: parent.height / 3
        sourceSize.width: width
        sourceSize.height: height

        visible: glacierRollerItem.parent.showRow
        fillMode: Image.PreserveAspectFit
        anchors{
            verticalCenter: glacierRollerItem.verticalCenter
            left: dataLine.right
            leftMargin: width
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                glacierRollerItem.parent.parent.activated = true
            }
        }
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            if(!glacierRollerItem.parent.parent.activated)
            {
                glacierRollerItem.parent.parent.activated = true;
            }
            else
            {
                glacierRollerItem.parent.parent.currentIndex = index
                glacierRollerItem.parent.parent.activated = false
            }
        }
    }
}
