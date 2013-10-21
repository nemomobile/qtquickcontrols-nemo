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

    function orientationConstraintsChanged() {
        if (!isOrientationAllowed(contentArea.filteredOrientation)) {
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
    }

    // TODO: We're assuming default fb orientation of the hw is portrait
    // Soon a compositor fix will be published that will make that consistent on all hw
    // i.e. Screen.width will be width of portrait orientation on all hardware!
    // (at the moment, Screen.width is the width of the screen in landscape mode in N9/N950, while on
    // other hardware it could be width of the screen in portrait mode)
    property bool __transpose: (rotationToTrasposeToPortrait() % 180) != 0

    // XXX: This is to account for HW screen rotation
    // Sooner or later we will get rid of this as the compositor will
    // do that for us
    function rotationToTrasposeToPortrait() {
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

    function isOrientationAllowed(orientationToBeChecked) {

        var allowedOrientations = root.allowedOrientations

        //use Page's allowed orientations if available
        if (stackView._isCurrentItemNemoPage() && stackView.currentItem.allowedOrientations) {
            allowedOrientations = stackView.currentItem.allowedOrientations
        }

        //this shouldn't happen, as orientation 0 is not part of Qt ENUM
        if (!orientationToBeChecked) {
            console.log("Hi! I'm a bug, report me to faenil (trying to set invalid orientation)")
            return false
        }
        //check if orientation is part of the allowed orientations mask
        //bit-by-bit AND
        return (orientationToBeChecked & allowedOrientations)
    }

    SystemPalette {id: syspal}

    Item {
        id: backgroundItem

        anchors.centerIn: parent
        width: __transpose ? Screen.height : Screen.width
        height: __transpose ? Screen.width : Screen.height
        rotation: rotationToTrasposeToPortrait()

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
            property int filteredOrientation: Qt.PortraitOrientation

            //this is the reliable value which changes during the orientation transition
            //the default value is set to Qt.PortraitOrientation
            property int uiOrientation: Qt.PortraitOrientation

            property bool orientationTransitionRunning: false

            Screen.onOrientationChanged: {
                if (root.isOrientationAllowed(Screen.orientation)) filteredOrientation = Screen.orientation
            }

            StackView {
                id: stackView
                width: parent.width
                height: parent.height

                //this has to be a function, property won't work inside onCurrentItemChanged, as currentItem in that slot will be outdated
                //(i.e. not yet updated to the new value)
                function _isCurrentItemNemoPage() { return currentItem && currentItem.hasOwnProperty("__isNemoPage") }

                //This properties are accessible for free by the Page via Stack.view.<property>
                readonly property int orientation: contentArea.uiOrientation
                property alias allowedOrientations: root.allowedOrientations
                property alias orientationTransitionRunning: contentArea.orientationTransitionRunning

                //TODO: CHECK IF THE TARGET IS ACTUALLY CHANGING (i.e. function works like a binding)
                Connections {
                    id: pageConn
                    target: stackView._isCurrentItemNemoPage() ? stackView.currentItem : null
                    onAllowedOrientationsChanged: root.orientationConstraintsChanged()
                }
            }

            Item {
                id: orientationState

                state: 'Unanimated'

                states: [
                    State {
                        name: 'Unanimated'
                        when: !stackView
                    },
                    State {
                        name: 'Portrait'
                        when: contentArea.filteredOrientation === Qt.PortraitOrientation
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
                        when: contentArea.filteredOrientation === Qt.LandscapeOrientation
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
                        when: contentArea.filteredOrientation === Qt.InvertedPortraitOrientation
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
                        when: contentArea.filteredOrientation === Qt.InvertedLandscapeOrientation
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

