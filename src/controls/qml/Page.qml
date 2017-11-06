/****************************************************************************************
**
** Copyright (C) 2013 Andrea Bernabei <and.bernabei@gmail.com>
** All rights reserved.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the author nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

import QtQuick 2.6
import QtQuick.Controls 1.0 // Needed for things like Stack attached properties
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0
import QtQuick.Window 2.0

NemoPage {
    id: page

    width: parent.width
    height: parent.height

    property alias color: background.color
    property int status: pageStack ? Stack.status : Stack.Inactive
    property variant headerTools
    readonly property StackView pageStack: Stack.view

    //Children of "page" will be automatically reparented to "content"
    default  property alias __content: content.data

    property int orientation
    //This keeps orientation synced to that of Nemo's StackView
    //If the page isn't pushed on Nemo's StackView, the orientation value will be unreliable
    Binding on orientation {
        when: pageStack && pageStack.hasOwnProperty("orientation")
        value: if (pageStack) pageStack.orientation //"if (pageStack)" is just needed to silence a TypeError at page initalization
    }

    //TODO: alias these properties with those of the applicationWindow
    //property alias orientationTransitions
    //property alias defaultOrientationTransition
    readonly property bool orientationTransitionRunning: pageStack ? pageStack.orientationTransitionRunning : false

    readonly property bool isPortrait: (orientation === Qt.PortraitOrientation || orientation === Qt.InvertedPortraitOrientation)
    readonly property bool isLandscape: (orientation === Qt.LandscapeOrientation || orientation === Qt.InvertedLandscapeOrientation)

    property bool __isNemoPage

    Rectangle {
        id: background
        anchors.fill: parent
        color: Theme.backgroundColor
    }

    Item {
        id: content
        anchors.fill: parent
    }
}
