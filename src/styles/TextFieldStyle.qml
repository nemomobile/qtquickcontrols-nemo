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
import QtQuick.Controls.Styles 1.0
import QtQuick.Controls.Nemo 1.0

TextFieldStyle {
    selectedTextColor: Theme.textColor
    selectionColor: Theme.accentColor
    textColor: Theme.textColor
    font.pointSize: Theme.fontSizeTiny
    font.family: Theme.fontFamily

    background: Item {
        anchors{
            leftMargin: Theme.itemSpacingMedium
            rightMargin: Theme.itemSpacingMedium
        }

        implicitHeight: Theme.itemHeightMedium
        implicitWidth: Theme.itemWidthLarge
        opacity: control.enabled ? 1 : 0.6
        Image {
            anchors.fill: parent
            visible: !control.enabled
            source: "images/disabled-overlay-inverse.png"
            fillMode: Image.Tile
        }
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 2
            width: parent.width
            color: control.readOnly ? Theme.fillDarkColor : Theme.accentColor
        }
    }
}
