/*
 * Copyright (C) 2013 Andrea Bernabei <and.bernabei@gmail.com>
 * Copyright (C) 2017 Chupligin Sergey <neochapay@gmail.com>
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
import QtQuick.Controls.Styles.Nemo 1.0

TabViewStyle {
    tabsAlignment: Qt.AlignVCenter
    tabOverlap: 0
    frame: Item { }
    tab: Item {
        implicitWidth: control.width/control.count
        implicitHeight: Theme.itemHeightMedium
        BorderImage {
            anchors.fill: parent
            border.bottom:Theme.itemSpacingExtraSmall
            border.top: Theme.itemSpacingExtraSmall
            Text {
                anchors.centerIn: parent
                color: (styleData.selected) ? Theme.accentColor : Theme.textColor
                text: styleData.title.toUpperCase()
                font.pixelSize: Theme.fontSizeTiny
            }
            Rectangle {
                visible: index > 0
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.margins: Theme.itemSpacingExtraSmall
                width: size.ratio(1)
                color: Theme.fillDarkColor
            }
            Rectangle{
                visible: styleData.selected
                width: parent.width
                height: size.ratio(1)
                color: Theme.accentColor
                anchors{
                    bottom: parent.bottom
                }
            }
        }
    }
}
