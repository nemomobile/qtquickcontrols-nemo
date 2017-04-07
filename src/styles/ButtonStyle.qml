/*
 * Copyright (C) 2013 Andrea Bernabei <and.bernabei@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtGraphicalEffects 1.0

//Styles.Nemo provides Theme
import QtQuick.Controls.Styles.Nemo 1.0

ButtonStyle {
    id: buttonstyle

    // The background of the button.
    background: Rectangle {
        implicitWidth: size.dp(240)
        implicitHeight: size.dp(50)
        clip: true
        color: control.primary ? Theme.primaryButton.background
                               : Theme.button.background
        Image {
            id: disabledImg
            anchors.fill: parent
            visible: !control.enabled
            source: "images/disabled-overlay.png"
            fillMode: Image.Tile
        }

        // The effect which shows the pressed state
        RadialGradient {
            x: control.pressX - width/2
            y: control.pressY - height/2
            width: Theme.button.pressedGradient.width
            height: Theme.button.pressedGradient.height
            visible: control.pressed

            gradient: Gradient {
                GradientStop {
                    position: Theme.button.pressedGradient.center;
                    color: control.primary ? Theme.primaryButton.pressedGradient.centerColor
                                           : Theme.button.pressedGradient.centerColor
                }
                GradientStop {
                    position: Theme.button.pressedGradient.edge;
                    color: control.primary ? Theme.primaryButton.pressedGradient.edgeColor
                                           : Theme.button.pressedGradient.edgeColor
                }
            }
        }
    }

    // The label of the button.
    label: Text {
        renderType: Text.NativeRendering
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: control.text
        color: Theme.button.text.color
        font.family: Theme.fontFamily
        font.pointSize: Theme.button.text.font.pointSize
        font.weight: control.primary ? Theme.primaryButton.text.font.weight : Theme.button.text.font.weight
        opacity: control.enabled ? 1.0 : 0.3
    }
}
