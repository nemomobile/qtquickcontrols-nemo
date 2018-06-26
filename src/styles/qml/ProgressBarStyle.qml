/*
 * Copyright (C) 2013 Andrea Bernabei <and.bernabei@gmail.com>
 * Copyright (C) 2018 Chupligin Sergey <neochapay@gmail.com>
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
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles 1.0

ProgressBarStyle {
    panel: Rectangle {
        implicitHeight: Theme.itemHeightSmall/2
        implicitWidth: Theme.itemWidthLarge + Theme.itemWidthSmall
        color: Theme.fillDarkColor

        Rectangle {
            antialiasing: true
            radius: 1
            visible: !control.indeterminate
            color: control.indeterminate ? "transparent" : Theme.accentColor
            height: parent.height
            width: parent.width * control.value / control.maximumValue
        }

        Item {
            anchors.fill: parent
            anchors.margins: 1
            visible: control.indeterminate
            clip: true

            Row {
                Repeater {
                    Rectangle {
                        color: index % 2 ? Theme.fillDarkColor : Theme.accentColor
                        width: Theme.itemHeightExtraSmall/3
                        height: control.height*2
                        rotation: 40
                        y: -control.height/2
                    }
                    model: control.width/Theme.itemHeightExtraSmall*3+4
                }
                XAnimator on x {
                    from: -(Theme.itemHeightExtraSmall/3*2) ; to: 0
                    loops: Animation.Infinite
                    running: control.indeterminate
                }
            }
        }
    }
}
