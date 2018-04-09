/****************************************************************************************
**
** Copyright (C) 2014 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
** Copyright (C) 2017 Sergey Chupligin <neochapay@gmail.com>
** All rights reserved.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the author nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

import QtQuick 2.6
import QtQuick.Controls.Styles.Nemo 1.0

Rectangle {
    id: main
    implicitWidth: fixedWidth ? fixedWidth  : childrenRectWidth()
    color: Theme.fillDarkColor
    height: Theme.itemHeightSmall
    property ListModel model: ListModel {}
    property bool enabled: true
    property int currentIndex: -1
    property int fixedWidth

    function childrenRectWidth() {
        var childWidth = 0
        for(var i=0; i < rectangles.count; i++) {
            childWidth = childWidth + rectangles.itemAt(i).width
        }
        return childWidth
    }

    Image {
        anchors.fill: parent
        visible: !main.enabled
        source: "images/disabled-overlay.png"
        fillMode: Image.Tile
    }
    Rectangle{
        id: selecter
        //x: main.currentIndex > -1 ? rowElement.children[main.currentIndex].x  : 0
        anchors.verticalCenter: rowElement.verticalCenter

        height: Theme.itemHeightMedium
        color: Theme.accentColor
        clip: true
        visible: main.currentIndex > -1

        Behavior on x {
            NumberAnimation { duration: 200; easing.type: Easing.OutCubic}
        }
        Behavior on width {
            NumberAnimation { duration: 200; easing.type: Easing.OutCubic}
        }
    }
    MouseArea {
        id:dragArea
        anchors.fill:parent
        enabled: main.enabled
        drag.target: main.enabled ? selecter.visible ? selecter : null : null
        drag.axis: Drag.XAxis
        drag.minimumX: x
        drag.maximumX: main.width - selecter.width
        property int inBoundsX
        hoverEnabled: true
        onReleased: {
            if(inBoundsX > -1) {
                if(mouseX < drag.minimumX)
                    rowElement.childAt(inBoundsX,y).changeIndex()
                else if (mouseX > drag.maximumX+selecter.width)
                    rowElement.childAt(inBoundsX+selecter.width, y).changeIndex()
                else rowElement.childAt(mouseX,y).changeIndex()
                selecter.x = rowElement.children[main.currentIndex].x
                selecter.width = main.currentIndex > -1 ? rowElement.children[main.currentIndex].width : 0
            }
        }
        onClicked: {
            inBoundsX = -1
            rowElement.childAt(mouseX,y).changeIndex()
            selecter.x = rowElement.children[main.currentIndex].x
            selecter.width= main.currentIndex > -1 ? rowElement.children[main.currentIndex].width : 0
        }
        onPositionChanged: if(mouseX>=drag.minimumX && mouseX <= drag.maximumX) inBoundsX = mouseX
    }

    Row {
        id: rowElement
        Repeater {
            id: rectangles
            model: main.model
            delegate: Rectangle {
                id: rowItem
                height: Theme.itemHeightSmall
                width: main.fixedWidth ? (main.fixedWidth/main.model.count) : (text.width+(text.width/name.length*2))
                color: "transparent"
                function changeIndex() { main.currentIndex = index}
                Label {
                    id: text
                    text: name
                    height: parent.heigh
                    elide:Text.ElideNone
                    anchors.centerIn: parent

                    Component.onCompleted: {
                        width = paintedWidth
                    }
                    font.weight: main.currentIndex == index ? Theme.fontWeightLarge : Theme.fontWeightMedium

                }
            }
        }
    }
}
