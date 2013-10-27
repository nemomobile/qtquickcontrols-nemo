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

SliderStyle {
    GrooveStyle {
        id: grooveStyle
    }

    Image {
        id: ball
        source: "images/slider-ball.png"
        z: 1
        visible: control.enabled
    }

    handle: Canvas {
        Connections {
            target: control
            onValueChanged: {
                if (Math.abs(((control.value*1000) - lastValue)) > 10) {
                    requestPaint()
                    lastValue = control.value*1000
                }
            }
        }
        id: canvas
        width: 125
        height: 50
        property color strokeStyle: Theme.groove.foreground
        property color fillStyle: Theme.groove.foreground
        property bool fill: true
        property bool stroke: true
        property real alpha: 1.0
        property real lastValue: 0
        antialiasing: true

        onPaint: {
            canvas.loadImage("images/slider-ball.png");

            var ctx = canvas.getContext('2d');
            ctx.save();
            ctx.translate(0,8);
            ctx.fillStyle = canvas.fillStyle;
            ctx.beginPath();
            ctx.lineWidth = 1;
            ctx.moveTo(0,38);
            ctx.bezierCurveTo(0, 8, 0, 8, 0, 8);
            ctx.bezierCurveTo(55, 8, 55, 8, 55, 8);
            ctx.bezierCurveTo(85, 0, 85, 0, 85, 0);
            ctx.bezierCurveTo(85, 32, 85, 32, 85, 32);
            ctx.bezierCurveTo(55, 25, 55, 25, 55, 25);
            ctx.bezierCurveTo(0, 24, 0, 24, 0, 24);
            ctx.closePath();
            ctx.fill();
            ctx.drawImage("images/slider-ball.png", 75, -3, 45,45);
            ctx.fillStyle="white";
            ctx.font="Bold 24px";
            ctx.fillText(parseInt(control.value*100), 84, 27);
            ctx.restore();
        }
    }
    groove: grooveStyle;
}
