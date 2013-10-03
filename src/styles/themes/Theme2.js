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

var themeName = "Ugly Test Theme"

// ACCENT IS THE MAIN THEME COLOUR
var accentColor = "#FF7F00"

var fillColor = "#474747"
var fillColorDark = "#202020"

// BUTTON STYLING
var button = {
    background: fillColor,
    text: "blue",
    pressedGradient: {
        centerColor: accentColor,
        edgeColor: "transparent"
    }
}

// PRIMARY BUTTON STYLING
var primaryButton = {
    background: accentColor,
    pressedGradient: {
        centerColor: "white",
        edgeColor: accentColor
    }
}

// STYLE FOR SLIDER AND PROGRESS BAR GROOVES
var groove = {
    foreground: accentColor,
    background: fillColorDark,
}

// TEXTFIELD INPUT
var textField = {
    selectedTextColor: "#ffffff",
    selectionColor: "#0091e5",
}
