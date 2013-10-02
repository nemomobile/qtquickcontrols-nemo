/*
 * Copyright (C) 2013 Tomasz Olszak <olszak.tomasz@gmail.com>
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
import QtQuick.Controls.Nemo 1.0

QtObject {
    readonly property string fontFamily: fontLoader.name

    property QtObject fontLoader: FontLoader {
        source: "/usr/share/fonts/google-opensans/OpenSans-Regular.ttf"
    }

    // The binding updates this var when NemoControls.setTheme succeeds
    readonly property var themeConfig: NemoControls.currentThemeConfig
    readonly property string themeName: themeConfig.themeName

    onThemeNameChanged: console.log("Theme successfully updated to " + themeName)

    // ({ }) is QML notation for assigning JS object to a var property
    // Automagically updated when themeConfig is updated
    property var button :
        ({
             backgroundColor: themeConfig.button.background,
             text: {
                 color: themeConfig.button.text,
                 font: {
                     pointSize: 24,
                     weight: 25 //Font.Light
                 }
             },
             pressedGradient: {
                 width: 240,
                 height: 240,
                 center: 0.29,
                 edge: 0.5,
                 centerColor: themeConfig.button.pressedGradient.centerColor,
                 edgeColor: themeConfig.button.pressedGradient.edgeColor
             }
         })

    // Only holds special styling for the primary button, the rest is in button
    property var primaryButton:
        ({
             backgroundColor: themeConfig.primaryButton.background,
             text: {
                 font: {
                     weight: 63 //Font.DemiBold
                 }
             },
             pressedGradient: {
                 centerColor: themeConfig.primaryButton.pressedGradient.centerColor,
                 edgeColor: themeConfig.primaryButton.pressedGradient.edgeColor
             }
         })

    property var groove:
        ({
             foregroundColor: themeConfig.groove.foreground,
             backgroundColor: themeConfig.groove.background,
         })
}

