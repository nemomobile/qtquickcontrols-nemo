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

import QtQuick.Window 2.0
import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

NemoWindow {
    id: root

    width: 320
    height: 240

    /*! \internal */
    default property alias data: contentArea.data

    property alias pageStack: stackView
    property alias initialPage: stackView.initialItem

    property alias orientation: contentArea.uiOrientation
    readonly property var _bgColor: Theme.window.background
    color: _bgColor

    readonly property int defaultAllowedOrientations: Qt.PortraitOrientation | Qt.LandscapeOrientation

    //these are application-wise allowed orientations, i.e. what is used if the current Page doesn't set any
    allowedOrientations: defaultAllowedOrientations

    onAllowedOrientationsChanged: {
        orientationConstraintsChanged()
    }

    Screen.onOrientationChanged: {
        if (root.isOrientationAllowed(Screen.orientation)) {
            contentArea.filteredOrientation = Screen.orientation
        }
    }

    function orientationConstraintsChanged()
    {
        //if the current orientation is not allowed anymore, fallback to an allowed one
        //stackInitialized check prevents setting an orientation before the stackview
        //(but more importantly the initialItem of the stack) has been created
        if (stackView.stackInitialized && !isOrientationAllowed(contentArea.filteredOrientation)) {
            fallbackToAnAllowedOrientation()
        }
    }

    function fallbackToAnAllowedOrientation()
    {
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
    property bool __transpose: (rotationToTransposeToPortrait() % 180) != 0

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

        anchors.centerIn: parent
        width: __transpose ? Screen.height : Screen.width
        height: __transpose ? Screen.width : Screen.height
        rotation: rotationToTransposeToPortrait()

        //This is the rotating item
        Item {
            id: contentArea
            width: parent.width
            height: parent.height
            anchors.centerIn: parent

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
                width: parent.width
                height: parent.height

                Component.onCompleted: stackInitialized = true
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
                onCurrentItemChanged: if (_isCurrentItemNemoPage() && currentItem.allowedOrientations)
                                          root.orientationConstraintsChanged()

                //This properties are accessible for free by the Page via Stack.view.<property>
                readonly property int orientation: contentArea.uiOrientation
                property alias allowedOrientations: root.allowedOrientations
                property alias orientationTransitionRunning: contentArea.orientationTransitionRunning

                Connections {
                    id: pageConn
                    target: stackView._isCurrentItemNemoPage() ? stackView.currentItem : null
                    onAllowedOrientationsChanged: root.orientationConstraintsChanged()
                }

                delegate: StackViewDelegate {
                    pushTransition: Component {
                        StackViewTransition {
                            PropertyAnimation {
                                target: enterItem
                                property: "x"
                                from: target.width
                                to: 0
                                duration: Theme.pageStack.transitionDuration
                                easing.type: Easing.OutQuad
                            }
                            PropertyAnimation {
                                target: exitItem
                                property: "x"
                                from: 0
                                to: -target.width
                                duration: Theme.pageStack.transitionDuration
                                easing.type: Easing.OutQuad
                            }
                        }
                    }
                    popTransition: Component {
                        StackViewTransition {
                            PropertyAnimation {
                                target: enterItem
                                property: "x"
                                from: -target.width
                                to: 0
                                duration: Theme.pageStack.transitionDuration
                                easing.type: Easing.OutQuad
                            }
                            PropertyAnimation {
                                target: exitItem
                                property: "x"
                                from: 0
                                to: target.width
                                duration: Theme.pageStack.transitionDuration
                                easing.type: Easing.OutQuad
                            }
                        }
                    }

                }
            }

            Item {
                id: orientationState

                state: 'Unanimated'

                states: [
                    State {
                        name: 'Unanimated'
                        when: !stackView || !stackInitialized
                    },
                    State {
                        name: 'Portrait'
                        when: contentArea.filteredOrientation === Qt.PortraitOrientation// && stackInitialized
                        PropertyChanges {
                            target: contentArea
                            restoreEntryValues: false
                            width: _horizontalDimension
                            height: _verticalDimension
                            rotation: 0
                            uiOrientation: Qt.PortraitOrientation
                        }
                    },
                    State {
                        name: 'Landscape'
                        when: contentArea.filteredOrientation === Qt.LandscapeOrientation //&& stackInitialized
                        PropertyChanges {
                            target: contentArea
                            restoreEntryValues: false
                            width: _verticalDimension
                            height: _horizontalDimension
                            rotation: 90
                            uiOrientation: Qt.LandscapeOrientation
                        }
                    },
                    State {
                        name: 'PortraitInverted'
                        when: contentArea.filteredOrientation === Qt.InvertedPortraitOrientation //&& stackInitialized
                        PropertyChanges {
                            target: contentArea
                            restoreEntryValues: false
                            width: _horizontalDimension
                            height: _verticalDimension
                            rotation: 180
                            uiOrientation: Qt.InvertedPortraitOrientation
                        }
                    },
                    State {
                        name: 'LandscapeInverted'
                        when: contentArea.filteredOrientation === Qt.InvertedLandscapeOrientation //&& stackInitialized
                        PropertyChanges {
                            target: contentArea
                            restoreEntryValues: false
                            width: _verticalDimension
                            height: _horizontalDimension
                            rotation: 270
                            uiOrientation: Qt.InvertedLandscapeOrientation
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
                        NumberAnimation {
                            target: contentArea
                            property: 'opacity'
                            to: 0
                            duration: 150
                        }
                        PropertyAction {
                            target: contentArea
                            properties: 'width,height,rotation,uiOrientation'
                        }
                        NumberAnimation {
                            target: contentArea
                            property: 'opacity'
                            to: 1
                            duration: 150
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

