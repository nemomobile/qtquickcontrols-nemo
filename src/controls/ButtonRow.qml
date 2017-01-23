/****************************************************************************************
**
** Copyright (C) 2014 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
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

import QtQuick 2.1
import QtQuick.Controls.Styles.Nemo 1.0

Rectangle {
    id: main
    width: childrenRect.width
    color: "#313131"
    height: 40
    property ListModel model: ListModel {}
    property bool enabled: true
    property int currentIndex: -1

    Image {
        anchors.fill: parent
        visible: !main.enabled
        source: "images/disabled-overlay.png"
        fillMode: Image.Tile
    }

    Rectangle{
        id: selecter
        x: rowElement.children[main.currentIndex].x || 0
        y: -5

        width: rowElement.children[main.currentIndex].width || 0
        height: 50
        color: "#0091e5"

        visible: main.currentIndex > -1

        Behavior on x {
            NumberAnimation { duration: 200 }
        }
        Behavior on width {
            NumberAnimation { duration: 200 }
        }
    }

    Row {
        id: rowElement
        Repeater {
            id: rectangles
            model: main.model
            delegate: Rectangle {
                id: rowItem
                height: 50
                width: text.width+(text.width/name.length*2)

                y: -5

                color: "transparent"
                MouseArea {
                    width: parent.width
                    height: parent.height

                    enabled: main.enabled

                    onClicked: {
                        main.currentIndex = index
                    }
                }
                Label {
                    id: text
                    text: name

                    anchors.horizontalCenter: parent.horizontalCenter

                    Component.onCompleted: {
                        width = paintedWidth
                    }
                    font.bold: main.currentIndex == index
                }
            }
        }
    }
}
