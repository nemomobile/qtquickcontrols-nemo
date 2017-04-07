/*
 * Copyright (C) 2013 Simonas Leleiva <simonas.leleiva@gmail.com>
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
import QtQuick.Controls.Styles.Nemo 1.0

Component {
    Rectangle {
        implicitHeight: 1.6*mm
        implicitWidth: 44*mm
        color: Theme.groove.background
        Rectangle {
            antialiasing: true
            radius: 1
            color: Theme.groove.foreground
            height: parent.height
            width: parent.width * control.value / control.maximumValue
        }
    }
}

