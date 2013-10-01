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

import QtQml 2.1
import "../../Styles/Nemo/themes/Theme1.js" as Theme1
import "../../Styles/Nemo/themes/Theme2.js" as Theme2

QtObject {
    readonly property var themes: [Theme1.themeName, Theme2.themeName]

    //THIS IS WHAT IS RESPONSIBLE FOR THE THEME CHANGE, changing this will change all the rest
    //THEME CONFIG IS THE REFERENCE TO THE .JS FILE HOLDING THE THEME CONFIGS
    property var currentThemeConfig: Theme1

    function setTheme(theme) {
        if (themes.indexOf(theme) >= 0) {
            var newThemeConfig = getThemeConfigOf(theme)
            if (newThemeConfig !== undefined) {
                currentThemeConfig = newThemeConfig
            } else {
                console.log("Theme config not handled, the theme was not changed")
            }
        } else {
            console.log("Theme " + theme + " is not handled");
        }
    }

    function getThemeConfigOf(theme) {
        switch (theme) {
        case Theme1.themeName:
            return Theme1
        case Theme2.themeName:
            return Theme2
        default:
            console.log("There is no theme config for the theme " + theme)
            return undefined
        }
    }
}

