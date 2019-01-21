/****************************************************************************************
**
** Copyright (C) 2013 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
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
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Controls.Nemo 1.0

CheckBoxStyle {   
    indicator: Rectangle {
        id: background
        color: "transparent"
        implicitWidth: Theme.itemWidthExtraSmall
        implicitHeight: Theme.itemHeightExtraSmall

        Rectangle {
            id: bgArea
            implicitWidth: Theme.itemWidthExtraSmall
            implicitHeight: Theme.itemHeightExtraSmall - Theme.itemSpacingExtraSmall
            color: control.checked ? Theme.accentColor : Theme.fillDarkColor
            anchors.centerIn: parent
        }


        Rectangle {
            id: ball
            width: Theme.itemHeightExtraSmall
            height: Theme.itemHeightExtraSmall
            radius: width/2
            anchors.verticalCenter: parent.verticalCenter

            clip: true

            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, Theme.itemHeightExtraSmall)
                source: ball
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Theme.textColor }
                    GradientStop { position: 1.0; color: Theme.fillDarkColor }
                }
            }

            x: control.checked ? background.width - ball.width : 0
        }

        Connections {
            target: control
            onCheckedChanged: {
                if(!indeterminate) {
                    if (control.checked) {
                        checkAnimation.restart()
                    } else {
                        unCheckAnimation.restart()
                    }
                }
            }

            onIndeterminateChanged: {
                indeterminateAnimation.stop()
                if(indeterminate) {
                    indeterminateAnimation.start()
                } else {
                    indeterminateAnimation.stop()
                    bgArea.color = control.checked ? Theme.accentColor : Theme.fillDarkColor
                }
            }
        }

        Component.onCompleted: {
            if(control.indeterminate){
                indeterminateAnimation.start()
            }
        }

        ParallelAnimation {
            id: checkAnimation
            running: false
            NumberAnimation {
                target: ball
                property: "x"
                to: background.width - ball.width
                duration: 400
            }
            PropertyAnimation {
                target: bgArea
                property: "color"
                to: Theme.accentColor
                duration: 400
            }
        }

        ParallelAnimation {
            id: unCheckAnimation
            running: false
            NumberAnimation {
                target: ball
                property: "x"
                to: 0
                duration: 400
            }
            PropertyAnimation {
                target: bgArea
                property: "color"
                to: Theme.fillDarkColor
                duration: 400
            }
        }

        SequentialAnimation{
            id: indeterminateAnimation
            running: false

            loops: Animation.Infinite

            PropertyAnimation {
                target: bgArea
                property: "color"
                to: control.checked ? Theme.fillDarkColor : Theme.accentColor
                duration: 500
            }

            PropertyAnimation {
                target: bgArea
                property: "color"
                to: control.checked ? Theme.accentColor : Theme.fillDarkColor
                duration: 500
            }
        }
    }

    label: Label {
        text: control.text
        font.pixelSize:control.fontSize
    }
    spacing: Theme.itemSpacingSmall
}
