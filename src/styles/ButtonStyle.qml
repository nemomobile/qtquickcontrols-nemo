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

import QtQuick 2.6
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtGraphicalEffects 1.0

import QtQuick.Controls.Nemo 1.0

ButtonStyle {
    id: buttonstyle

    // The background of the button.
    background: Rectangle {
        implicitWidth: Theme.itemWidthMedium
        implicitHeight: Theme.itemHeightMedium
        clip: true
        color: control.primary ? Theme.accentColor
                               : Theme.fillColor
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
            width: Theme.itemWidthSmall
            height: width
            visible: control.pressed

            gradient: Gradient {
                GradientStop {
                    position: 0.29
                    color: control.primary ? Theme.backgroundAccentColor
                                           : Theme.accentColor
                }
                GradientStop {
                    position: 0.5;
                    color: control.primary ? Theme.accentColor
                                           : "transparent"
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
        color: Theme.textColor
        font.family: Theme.fontFamily
        font.pointSize: Theme.fontSizeLarge
        font.weight: control.primary ? Theme.fontWeightLarge : Theme.fontWeightMedium
        opacity: control.enabled ? 1.0 : 0.3
    }
}
