/*
 * Copyright (C) 2013 Andrea Bernabei <and.bernabei@gmail.com>
 * Copyright (C) 2017 Chupligin Sergey <mail@neochapay.ru>
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

SliderStyle{
    handle: Rectangle {
        id: handle
        anchors.centerIn: parent
        color: Theme.backgroundColor
        border.color: Theme.accentColor
        border.width: 2
        implicitWidth: size.dp(34)
        implicitHeight: size.dp(34)
        radius: size.dp(16)
        visible: control.enabled

        Text{
            id: valueLabel
            anchors.centerIn: parent
            text: parseInt(control.value*100)
            visible: control.showValue
            color: Theme.textColor
        }
    }

    groove: Rectangle{
        id: grove

        implicitHeight: size.dp(16)
        implicitWidth: size.dp(440)
        color: Theme.fillDarkColor
        z: 1
        Rectangle{
            id: dataLine
            height: parent.height
            width: styleData.handlePosition
            color: Theme.accentColor
        }

        Image {
            id: disabledImg
            anchors.fill: parent
            visible: !control.enabled
            source: "images/disabled-overlay.png"
            fillMode: Image.Tile
        }

        Image{
            id: left
            anchors{
                right: dataLine.right
                verticalCenter: dataLine.verticalCenter
            }
            source: "images/slider-handle-left.svg"
            height: size.dp(34)
            visible: control.enabled
            width: (styleData.handlePosition > size.dp(80)) ? size.dp(80) : styleData.handlePosition
            sourceSize.width: width
            sourceSize.height: height
        }
    }
}
