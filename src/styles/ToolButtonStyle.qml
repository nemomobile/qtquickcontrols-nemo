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
import QtQuick.Controls.Private 1.0


// TODO: USE ToolButtonStyle from official QQC!
// ToolButtonStyle is private in QQC 5.1.0

Style {
    readonly property ToolButton control: __control
    property Component panel: Item {
        id: styleitem

        //TODO: Maybe we want to add a descriptive text at the bottom of the icon?
        implicitWidth: Theme.itemHeightMedium
        implicitHeight: implicitWidth

        opacity: control.pressed ? 0.5 : 1

        Text {
            id: label
            visible: icon.status != Image.Ready
            anchors.centerIn: parent
            text: control.text
        }

        Image {
            id: icon
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            anchors.margins: Theme.itemSpacingExtraSmall
            source: control.iconSource
        }
    }
}
