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
import QtQuick.Controls.Styles.Nemo 1.0

SliderStyle{
    handle: Rectangle {
        id: handle
        anchors.centerIn: parent
        color: "black"
        border.color: "#0091e5"
        border.width: 2
        implicitWidth: 3.4*mm
        implicitHeight: 3.4*mm
        radius: 1.6*mm
        visible: control.enabled

        Text{
            id: valueLabel
            anchors.centerIn: parent
            text: parseInt(control.value*100)
            visible: control.showValue
            color: "white"
        }
    }

    groove: Rectangle{
        id: grove

        implicitHeight: 1.6*mm
        implicitWidth: 44*mm
        color: "#313131"
        z: 1
        Rectangle{
            id: dataLine
            height: parent.height
            width: styleData.handlePosition
            color: "#0091e5"
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
            height: 3.4*mm
            visible: control.enabled
            width: (styleData.handlePosition > 8*mm) ? 8*mm : styleData.handlePosition
            sourceSize.width: width
            sourceSize.height: height
        }
    }
}
