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

import QtQuick 2.6
import QtQuick.Controls.Styles 1.0
import QtQuick.Controls.Nemo 1.0

SliderStyle{
    readonly property double handleValue: control.value / control.maximumValue
    readonly property double _multiple: (handleValue  > 0.8) ? (control.maximumValue/control.value-1) / 0.25  : 1
    readonly property double _multiple2: (handleValue  > 0.8) ? (handleValue - 0.8) / 0.2  : 1
    property bool useSpecSlider: control.useSpecSlider
    property bool alwaysUp: control.alwaysUp
    handle: Rectangle {
        id: handle
        anchors.verticalCenter:useSpecSlider ? undefined : parent.verticalCenter
        y: useSpecSlider ? (control.pressed ? alwaysUp ? parent.y - Theme.itemHeightLarge : ((handleValue  > 0.8) ? parent.y - (Theme.itemHeightLarge*_multiple2) : parent.y ) :  parent.y) : undefined
        x: useSpecSlider ? (control.pressed ? alwaysUp ? Theme.itemHeightExtraSmall / 2 : (handleValue > 0.8) ? (_multiple*Theme.itemHeightHuge)  : Theme.itemHeightHuge : 0) : undefined
        color: Theme.backgroundColor
        border.color: Theme.textColor
        border.width: size.ratio(2)
        implicitWidth: Theme.itemHeightExtraSmall
        implicitHeight: Theme.itemHeightExtraSmall
        radius: implicitHeight / 2
        visible: control.enabled

        scale: control.pressed ? 1.2 : 1

        Text{
            id: valueLabel
            anchors.centerIn: parent
            text: parseInt(control.value)
            visible: control.showValue
            color: Theme.textColor
            font.pixelSize: control.valueFontSize
        }
    }

    groove: Rectangle{
        id: grove

        implicitHeight: Theme.itemHeightExtraSmall / 2
        implicitWidth: Theme.itemWidthLarge + Theme.itemWidthSmall
        color: Theme.fillDarkColor
        z: 1
        Rectangle{
            id: dataLine
            height: parent.height
            width: styleData.handlePosition
            color: Theme.accentColor
        }

        Rectangle{
            id: strecthLine
            x: dataLine.width
            width: left.x-x + (handleValue < 0.85 ? Theme.itemSpacingLarge : 0)
            visible: useSpecSlider ? alwaysUp ? false : (control.pressed && handleValue > 0.80) : false
            height: parent.height
            color: Theme.accentColor
            opacity:0.3
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
            x: (useSpecSlider && control.pressed ? alwaysUp ? dataLine.width+width : (handleValue  > 0.80) ? dataLine.width +Theme.itemHeightExtraSmall/2 +_multiple*Theme.itemHeightHuge : dataLine.width + Theme.itemHeightHuge : dataLine.width) - width
            anchors{
                bottom: useSpecSlider ? ((control.pressed && (handleValue > 0.80 || alwaysUp)) ? dataLine.bottom : undefined) : undefined
                verticalCenter: useSpecSlider ? ((control.pressed && (handleValue > 0.80 || alwaysUp)) ? undefined :  dataLine.verticalCenter) : dataLine.verticalCenter
            }
            source: useSpecSlider && control.pressed ? (handleValue  > 0.80)  || alwaysUp ? "images/slider-trumpet-up.png" : "images/slider-trumpet-stretch.png" : "images/slider-trumpet.png"
            height:  control.pressed && useSpecSlider ? alwaysUp ? Theme.itemHeightLarge : (handleValue > 0.80) ? (Theme.itemHeightLarge*_multiple2) : Theme.itemHeightExtraSmall : Theme.itemHeightExtraSmall
            visible: control.enabled
            width:  control.pressed && useSpecSlider ? ((handleValue > 0.80) || alwaysUp ? Theme.itemHeightExtraSmall  : Theme.itemHeightHuge)  : (styleData.handlePosition >  Theme.itemHeightHuge) ?  Theme.itemHeightHuge : styleData.handlePosition
            sourceSize.width: width
            sourceSize.height: height
        }
    }
}
