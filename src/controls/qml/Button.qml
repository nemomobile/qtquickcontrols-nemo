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
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Button {
    id: butt

    property int pressX: 0
    property int pressY: 0

    // A primary button is the main button of a view, and it is styled accordingly.
    property bool primary: false

    // XXX HACK: Workaround for QQC Button not exposing x/y of pressed state
    // We need those for Glacier's Button pressed effect
    Connections {
        target: butt.__behavior
        function onPressed(mouse) {
            pressX = mouse.x
            pressY = mouse.y
        }
        function onPositionChanged(mouse) {
            pressX = mouse.x
            pressY = mouse.y
        }
    }

    style: ButtonStyle{}
}


