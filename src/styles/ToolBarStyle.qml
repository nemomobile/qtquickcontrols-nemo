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
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Style {
    padding.left: 6
    padding.right: 6
    padding.top: 3
    padding.bottom: 3

    property Component panel: Item {
        implicitHeight: size.dp(75)
        implicitWidth: size.dp(40)
        Rectangle {
            anchors.fill: parent
            color: Theme.toolBar.background
        }
    }
}
