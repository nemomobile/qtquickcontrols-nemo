/*
 * Copyright (C) 2013 Andrea Bernabei <and.bernabei@gmail.com>
 * Copyright (C) 2013 Jolla Ltd.
 * Copyright (C) 2017 Eetu Kahelin
 * Copyright (C) 2021 Chupligin Sergey <neochapay@gmail.com>
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

import QtQuick.Window 2.2
import QtQuick 2.6
import QtQuick.Controls 1.0

import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

NemoWindow {
    id: root

    property alias header: toolBar
    /*! \internal */
    default property alias data: contentArea.data

    property alias pageStack: stackView
    property alias initialPage: stackView.initialItem
    property bool applicationActive: Qt.application.active

    //property alias orientation: contentArea.uiOrientation
    readonly property int isUiPortrait: root.width < root.height
    //is this safe? can there be some situation in which it's neither portrait nor landscape?
    readonly property int isUiLandscape: !isUiPortrait

    readonly property var _bgColor: Theme.backgroundColor
    color: _bgColor

    //Handles orientation of keyboard, MInputMethodQuick.appOrientation.
    //contentOrientation: orientation
    /*onOrientationChanged: {
        contentOrientation=orientation
    }*/

    //README: allowedOrientations' default value is set in NemoWindow's c++ implementation
    //The app developer can overwrite it from QML

    onAllowedOrientationsChanged: {
        orientationConstraintsChanged()
    }

    //Safety version of pageStack.push - if we can't load component - show error page page with
    //error message and back button

    function push(url, params) {
        if(!params){
            params = {}
        }
        console.log("##", url, params, pageStack)
        var component = Qt.createComponent(url)
        if (component.status === Component.Ready) {
            pageStack.push(component.createObject(pageStack, params))
        } else {
            console.warn("Error loading component", url, component.errorString())
            pageStack.push(Qt.resolvedUrl("ErrorStackPage.qml"), {error: component.errorString()})
        }
    }

    Timer {
        id: _errorTimer
        property string errorString
        interval: 50
        repeat: false
        onTriggered: {
            pageStack.replace(Qt.resolvedUrl("ErrorStackPage.qml"), {error: errorString})
            errorString = ""
        }
    }

    Connections {
        target: pageStack
        function onBusyChanged(busy) {
            if (_errorTimer.errorString && !pageStack.busy) {
                _errorTimer.start()
            }
        }

        function onCurrentItemChanged(currentItem) {
            var qmltype = pageStack.currentItem.toString()
            if (qmltype.slice(0, 10) === "QQuickText") {
                _errorTimer.errorString = pageStack.currentItem.text
            }
        }
    }

    function orientationConstraintsChanged()
    {
        return; ///FIX IT!
        //if the current orientation is not allowed anymore, fallback to an allowed one
        //stackInitialized check prevents setting an orientation before the stackview
        //(but more importantly the initialItem of the stack) has been created
        if (stackView.stackInitialized) {
            //- This is to give priority to the current screen orientation
            //- This case happens when, for example, you're on a landscape only page,
            //  the phone is in portrait, and a page allowing portrait mode is pushed on the stack.
            //  When the page is pushed, we don't get any orientationChanged signal from the Screen element
            //  because the phone was already held in portrait mode, se we have to enforce it here.
            if (isOrientationAllowed(root.orientation)) {
                contentArea.filteredOrientation = root.orientation
            }
            //- If neither the current screen orientation nor the one which the UI is already presented in (filteredOrientation)
            //  are allowed, then fallback to an allowed orientation.
            else if (!isOrientationAllowed(contentArea.filteredOrientation)) {
                fallbackToAnAllowedOrientation()
            }
        }
    }

    function fallbackToAnAllowedOrientation()
    {
        return; //FIX IT
        var orientations = [Qt.PortraitOrientation, Qt.LandscapeOrientation,
                            Qt.InvertedPortraitOrientation, Qt.InvertedLandscapeOrientation]

        //TODO: use a better algo to fall back to the *closest* UI orientation
        //example: don't go from InvertedLandscape to Landscape, but to InvertedPortrait/Portrait, if allowed
        for (var i=0; i<orientations.length; i++) {
            if (isOrientationAllowed(orientations[i])) {
                contentArea.filteredOrientation = orientations[i]
                break
            }
        }
    }

    // TODO: We're assuming default fb orientation of the hw is portrait
    // Soon a compositor fix will be published that will make that consistent on all hw
    // i.e. Screen.width will be width of portrait orientation on all hardware!
    // (at the moment, Screen.width is the width of the screen in landscape mode in N9/N950, while on
    // other hardware it could be width of the screen in portrait mode)
    //property bool __transpose: (rotationToTransposeToPortrait() % 180) != 0

    // XXX: This is to account for HW screen rotation
    // Sooner or later we will get rid of this as the compositor will
    // do that for us
    function rotationToTransposeToPortrait()
    {
        switch (Screen.primaryOrientation) {
        case Qt.PortraitOrientation:
            return 0
        case Qt.LandscapeOrientation:
            return -90
        case Qt.InvertedPortraitOrientation:
            return -180
        case Qt.InvertedLandscapeOrientation:
            return -270
        }
    }

    function isOrientationAllowed(orientationToBeChecked)
    {
        var allowedOrientations = root.allowedOrientations

        //use Page's allowed orientations if available
        if (stackView._isCurrentItemNemoPage() && stackView.currentItem.allowedOrientations) {
            allowedOrientations = stackView.currentItem.allowedOrientations
        }

        //check if orientation is part of the allowed orientations mask
        //bit-by-bit AND
        //NOTE: this also returns false if orientationToBeChecked == 0,
        //so we don't need additional checks for that
        return (orientationToBeChecked & allowedOrientations)
    }

    SystemPalette {id: syspal}

    Item {
        id: backgroundItem
        anchors.fill: parent

        Item {
            id: clipping

            z: 1
            width: parent.width  - (isUiLandscape ? stackView.panelSize : 0)
            height: parent.height  - (isUiPortrait ? stackView.panelSize : 0)
            clip: stackView.panelSize > 0


            //This is the rotating item
            Item {
                id: contentArea
                anchors.centerIn: parent

                transform: Scale {
                    id: contentScale
                    property bool animationRunning: xAnim.running || yAnim.running
                    Behavior on xScale { NumberAnimation { id: xAnim; duration: 100 } }
                    Behavior on yScale { NumberAnimation { id: yAnim; duration: 100 } }
                }

                property int _horizontalDimension: parent ? parent.width : 0
                property int _verticalDimension: parent ? parent.height : 0

                property alias defaultOrientationTransition: orientationState.defaultTransition

                // This is used for states switching
                property int filteredOrientation

                //this is the reliable value which changes during the orientation transition
                property int uiOrientation

                property bool orientationTransitionRunning: false

                StackView {
                    id: stackView
                    anchors.top: root.isUiPortrait ? toolBar.bottom : parent.top
                    anchors.right: parent.right
                    anchors.left: root.isUiPortrait ? parent.left : toolBar.right
                    anchors.bottom: parent.bottom

                    property real panelSize: 0
                    property real previousImSize: 0
                    property real imSize: !root.applicationActive ? 0 : (isUiPortrait ? (root._transpose ? Qt.inputMethod.keyboardRectangle.width
                                                                                                         : Qt.inputMethod.keyboardRectangle.height)
                                                                                      : (root._transpose ? Qt.inputMethod.keyboardRectangle.height
                                                                                                         : Qt.inputMethod.keyboardRectangle.width))

                    onImSizeChanged: {
                        if (imSize <= 0 && previousImSize > 0) {
                            imShowAnimation.stop()
                            imHideAnimation.start()
                        } else if (imSize > 0 && previousImSize <= 0) {
                            imHideAnimation.stop()
                            imShowAnimation.to = imSize
                            imShowAnimation.start()
                        } else {
                            panelSize = imSize
                        }

                        previousImSize = imSize
                    }
                    clip: true
                    Component.onCompleted: {
                        stackInitialized = true
                    }
                    //IMPORTANT: this property makes it so that at app startup we wait for the initial page to be pushed
                    //before determining the initial ui orientation (see the states logic below)
                    //If we don't use this, the orientation will change first time based on NemoWindow's allowedOrientation,
                    //and the second time based on the allowedOrientations of the initialItem of the stack.
                    //Using this property avoids that, and make the UI directly start in the correct orientation
                    //TODO: find a cleaner way to do it (if there's any)
                    property bool stackInitialized: false
                    onStackInitializedChanged: if (stackInitialized) {
                                                   //set Screen.orientation as default, if allowed
                                                   if (root.isOrientationAllowed(Screen.orientation)) {
                                                       contentArea.filteredOrientation = Screen.orientation
                                                   } else {
                                                       //let the window handle it, it will fall back to an allowed orientation
                                                       root.fallbackToAnAllowedOrientation()
                                                   }
                                               }

                    //this has to be a function, property won't work inside onCurrentItemChanged, as the property binding hasn't been updated yet there
                    //(hence we'd be using the old currentItem)
                    function _isCurrentItemNemoPage()
                    {
                        return currentItem && currentItem.hasOwnProperty("__isNemoPage")
                    }

                    //update orientation constraints when a Page is pushed/popped
                    onCurrentItemChanged: {
                        if (_isCurrentItemNemoPage())
                            root.orientationConstraintsChanged()
                    }

                    //This properties are accessible for free by the Page via Stack.view.<property>
                    readonly property int orientation: contentArea.uiOrientation
                    property alias allowedOrientations: root.allowedOrientations
                    property alias orientationTransitionRunning: contentArea.orientationTransitionRunning

                    Connections {
                        id: pageConn
                        target: stackView._isCurrentItemNemoPage() ? stackView.currentItem : null
                        function onAllowedOrientationsChanged() { root.orientationConstraintsChanged() }
                    }

                    delegate: StackViewDelegate {
                        pushTransition: Component {
                            StackViewTransition {
                                ScriptAction {
                                    script: {
                                        imShowAnimation.stop()
                                        imHideAnimation.start()
                                    }
                                }
                                PropertyAnimation {
                                    target: enterItem
                                    property: "x"
                                    from: target.width
                                    to: 0
                                    duration: 500
                                    easing.type: Easing.OutQuad
                                }
                                PropertyAnimation {
                                    target: exitItem
                                    property: "x"
                                    from: 0
                                    to: -target.width
                                    duration: 500
                                    easing.type: Easing.OutQuad
                                }
                            }
                        }
                        popTransition: Component {
                            StackViewTransition {
                                ScriptAction {
                                    script: {
                                        imShowAnimation.stop()
                                        imHideAnimation.start()
                                    }
                                }
                                PropertyAnimation {
                                    target: enterItem
                                    property: "x"
                                    from: -target.width
                                    to: 0
                                    duration: 500
                                    easing.type: Easing.OutQuad
                                }
                                PropertyAnimation {
                                    target: exitItem
                                    property: "x"
                                    from: 0
                                    to: target.width
                                    duration: 500
                                    easing.type: Easing.OutQuad
                                }
                            }
                        }

                    }
                    SequentialAnimation {
                        id: imHideAnimation
                        PauseAnimation {
                            duration:  200
                        }
                        NumberAnimation {
                            target: stackView
                            property: 'panelSize'
                            to: 0
                            duration:200
                            easing.type: Easing.InOutQuad
                        }
                    }

                    NumberAnimation {
                        id: imShowAnimation
                        target: stackView
                        property: 'panelSize'
                        duration:  200
                        easing.type: Easing.InOutQuad
                    }

                }

                Header {
                    id: toolBar
                    stackView: root.pageStack
                    appWindow: root
                }

                Item {
                    id: orientationState

                    state: 'Unanimated'

                    states: [
                        State {
                            name: 'Unanimated'
                            when: !stackView || !stackView.stackInitialized
                        },
                        State {
                            name: 'Portrait'
                            when: root.orientation === Qt.PortraitOrientation// && stackInitialized
                            PropertyChanges {
                                target: contentArea
                                restoreEntryValues: false
                                width: _horizontalDimension
                                height: _verticalDimension
                                //rotation: 0
                                uiOrientation: Qt.PortraitOrientation
                            }
                            AnchorChanges {
                                target: clipping
                                anchors.top: parent.top
                                anchors.left: parent.left
                                anchors.right: undefined
                                anchors.bottom: undefined
                            }
                        },
                        State {
                            name: 'Landscape'
                            when: root.width < root.height //root.orientation === Qt.LandscapeOrientation //&& stackInitialized
                            PropertyChanges {
                                target: contentArea
                                restoreEntryValues: false
                                width: _verticalDimension
                                height: _horizontalDimension
                                rotation: 90
                                uiOrientation: Qt.LandscapeOrientation
                            }
                            AnchorChanges {
                                target: clipping
                                anchors.top: undefined
                                anchors.left: undefined
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                            }
                            AnchorChanges {
                                target: inputClipping
                                anchors.top: undefined
                                anchors.left: parent.left
                                anchors.right: undefined//clipping.left
                                anchors.bottom: parent.bottom
                            }
                        },
                        State {
                            name: 'PortraitInverted'
                            when: root.orientation === Qt.InvertedPortraitOrientation //&& stackInitialized
                            PropertyChanges {
                                target: contentArea
                                restoreEntryValues: false
                                width: _horizontalDimension
                                height: _verticalDimension
                                rotation: 180
                                uiOrientation: Qt.InvertedPortraitOrientation
                            }
                            AnchorChanges {
                                target: clipping
                                anchors.top: undefined
                                anchors.left: undefined
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                            }
                            AnchorChanges {
                                target: inputClipping
                                anchors.top: undefined
                                anchors.left: undefined
                                anchors.right: clipping.right
                                anchors.bottom: clipping.top
                            }
                        },
                        State {
                            name: 'LandscapeInverted'
                            when: root.orientation === Qt.InvertedLandscapeOrientation //&& stackInitialized
                            PropertyChanges {
                                target: contentArea
                                restoreEntryValues: false
                                width: _verticalDimension
                                height: _horizontalDimension
                                rotation: 270
                                uiOrientation: Qt.InvertedLandscapeOrientation
                            }
                            AnchorChanges {
                                target: clipping
                                anchors.top: undefined
                                anchors.left: parent.left
                                anchors.right: undefined
                                anchors.bottom: parent.bottom
                            }
                            AnchorChanges {
                                target: inputClipping
                                anchors.top: undefined
                                anchors.left: undefined//clipping.right
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                            }
                        }
                    ]

                    property Transition defaultTransition: Transition {
                        to: 'Portrait,Landscape,PortraitInverted,LandscapeInverted'
                        from: 'Portrait,Landscape,PortraitInverted,LandscapeInverted'
                        SequentialAnimation {
                            PropertyAction {
                                target: contentArea
                                property: 'orientationTransitionRunning'
                                value: true
                            }
                            ParallelAnimation {
                                NumberAnimation {
                                    target: contentArea
                                    property: 'opacity'
                                    to: 0
                                    duration: 150
                                }
                                NumberAnimation {
                                    target: inputPanel
                                    property: 'opacity'
                                    to: 0
                                    duration: 150
                                }
                            }
                            PropertyAction {
                                target: contentArea
                                properties: 'width,height,rotation,uiOrientation'
                            }
                            AnchorAnimation {
                                duration: 0
                            }
                            ParallelAnimation {
                                NumberAnimation {
                                    target: contentArea
                                    property: 'opacity'
                                    to: 1
                                    duration: 150
                                }
                                NumberAnimation {
                                    target: inputPanel
                                    property: 'opacity'
                                    to: 1
                                    duration: 150
                                }
                            }
                            PropertyAction {
                                target: contentArea
                                property: 'orientationTransitionRunning'
                                value: false
                            }
                        }
                    }

                    Component.onCompleted: {
                        if (transitions.length === 0) {
                            transitions = [ defaultTransition ]
                        }
                    }
                }
            }
        }
    }
}

