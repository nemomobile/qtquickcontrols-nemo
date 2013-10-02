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
import QtQuick.Controls.Styles.Nemo 1.0

TextFieldStyle {
    selectedTextColor: Theme.textField.selectedTextColor
    selectionColor: Theme.textField.selectionColor
    textColor: Theme.textField.selectedTextColor
    font.pixelSize: 24
    background: Item {
        implicitHeight: 40
        implicitWidth: 320
        anchors.leftMargin: 16
        anchors.rightMargin: 16
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
            color: Theme.textField.selectionColor
        }
    }
}
