/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Virtual Keyboard module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.7
import QtQuick.Controls.Nemo 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Styles 2.1

KeyboardStyle {
    id: currentStyle
    readonly property bool compactSelectionList: [InputEngine.Pinyin, InputEngine.Cangjie, InputEngine.Zhuyin].indexOf(InputContext.inputEngine.inputMode) !== -1
    readonly property string fontFamily: "sans"
    readonly property real keyBackgroundMargin: Theme.itemSpacingExtraSmall/2
    readonly property real keyContentMargin: Math.round(45 * scaleHint)
    readonly property real keyIconScale: scaleHint * 0.6
    readonly property string resourcePrefix: ""

    readonly property real horizontalBorder: size.ratio(1)
    readonly property real topBorder: Theme.itemSpacingExtraSmall/2

    readonly property string inputLocale: InputContext.locale
    property color inputLocaleIndicatorColor: Theme.backgroundColor
    property Timer inputLocaleIndicatorHighlightTimer: Timer {
        interval: 1000
        onTriggered: inputLocaleIndicatorColor = Theme.fillColor
    }
    onInputLocaleChanged: {
        inputLocaleIndicatorColor = Theme.backgroundAccentColor
        inputLocaleIndicatorHighlightTimer.restart()
    }

    keyboardDesignWidth: size.ratio(854)//N9
    keyboardDesignHeight: size.ratio(480)
    keyboardRelativeLeftMargin: Theme.itemSpacingMedium / keyboardDesignWidth
    keyboardRelativeRightMargin: Theme.itemSpacingMedium / keyboardDesignWidth
    keyboardRelativeTopMargin: Theme.itemSpacingSmall / keyboardDesignWidth
    keyboardRelativeBottomMargin:Theme.itemSpacingExtraSmall/ keyboardDesignWidth

    keyboardBackground: Rectangle {
        color: Theme.fillColor
    }

    keyPanel: KeyPanel {
        BorderImage {
            id: bgImage
            border { left: horizontalBorder; top: topBorder; right: horizontalBorder; bottom:0 }
            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat
            source: "images/keyboard-key-portrait.png"
            anchors.fill: parent
            anchors.margins: keyBackgroundMargin

            Text {
                id: keySmallText
                text: control.smallText
                visible: control.smallTextVisible
                color: Theme.textColor
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: keyContentMargin / 3
                font {
                    family: fontFamily
                    pixelSize: Theme.fontSizeTiny
                    capitalization: control.uppercased ? Font.AllUppercase : Font.MixedCase
                }
            }
            Text {
                id: keyText
                text: control.displayText
                color: Theme.textColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                anchors.leftMargin: keyContentMargin
                anchors.topMargin: control.smallTextVisible ? keyContentMargin * 1.2 : keyContentMargin
                anchors.rightMargin: keyContentMargin
                anchors.bottomMargin: control.smallTextVisible ? keyContentMargin * 0.8 : keyContentMargin
                font {
                    family: fontFamily
                    pixelSize: Theme.fontSizeMedium
                    capitalization: control.uppercased ? Font.AllUppercase : Font.MixedCase
                }
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: bgImage
                    source:"images/keyboard-key-portrait-pressed.png"
                }
                PropertyChanges {
                    target: keyText
                    opacity: 0.5
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: bgImage
                    opacity: 0.75
                }
                PropertyChanges {
                    target: keyText
                    opacity: 0.05
                }
            }
        ]
    }

    backspaceKeyPanel: KeyPanel {
        id:panel
        BorderImage {
            id: backspaceBgimg
            border { left: horizontalBorder; top: topBorder; right: horizontalBorder; bottom:0 }
            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat
            source: "images/keyboard-key-portrait-function.png"
            anchors.fill: parent
            anchors.margins: keyBackgroundMargin
            Image {
                id: backspaceKeyIcon
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                sourceSize.width: width
                sourceSize.height: height
                width: Theme.fontSizeMedium //??
                smooth: true
                source: "images/icon-backspace.svg"
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: backspaceBgimg
                    source:"images/keyboard-key-portrait-function-pressed.png"

                }
                PropertyChanges {
                    target: backspaceKeyIcon
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: backspaceKeyIcon
                    opacity: 0.2
                }
            }
        ]
    }

    languageKeyPanel: KeyPanel {
        BorderImage {
            id: languageBgimg
            border { left: horizontalBorder; top: topBorder; right: horizontalBorder; bottom:0 }
            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat
            source: "images/keyboard-key-portrait-function.png"
            anchors.fill: parent
            anchors.margins: keyBackgroundMargin
            Image {
                id: languageKeyIcon
                anchors.centerIn: parent
                sourceSize.width: 144 * keyIconScale
                sourceSize.height: 144 * keyIconScale
                smooth: true
                source: resourcePrefix + "images/globe-868482.svg"
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: languageBgimg
                    source:"images/keyboard-key-portrait-function-pressed.png"
                }
                PropertyChanges {
                    target: languageKeyIcon
                    opacity: 0.75
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: languageKeyIcon
                    opacity: 0.2
                }
            }
        ]
    }

    enterKeyPanel: KeyPanel {
        BorderImage {
            id: enterBgimg
            border { left: horizontalBorder; top: topBorder; right: horizontalBorder; bottom:0 }
            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat
            source: "images/keyboard-key-portrait-function.png"
            anchors.fill: parent
            anchors.margins: keyBackgroundMargin
            Image {
                id: enterKeyIcon
                visible: enterKeyText.text.length === 0
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                readonly property size enterKeyIconSize: {
                    switch (control.actionId) {
                    case EnterKeyAction.Go:
                    case EnterKeyAction.Send:
                    case EnterKeyAction.Next:
                    case EnterKeyAction.Done:
                        return Qt.size(170, 119)
                    case EnterKeyAction.Search:
                        return Qt.size(148, 148)
                    default:
                        return Qt.size(211, 80)
                    }
                }
                sourceSize.width: enterKeyIconSize.width * keyIconScale
                sourceSize.height: enterKeyIconSize.height * keyIconScale
                width: Theme.fontSizeLarge
                smooth: true
                source: {
                    switch (control.actionId) {
                    case EnterKeyAction.Go:
                    case EnterKeyAction.Send:
                    case EnterKeyAction.Next:
                    case EnterKeyAction.Done:
                        return resourcePrefix + "images/check-868482.svg"
                    case EnterKeyAction.Search:
                        return resourcePrefix + "images/search-868482.svg"
                    default:
                        return "images/icon-m-input-methods-enter.svg"
                    }
                }
            }
            Text {
                id: enterKeyText
                visible: text.length !== 0
                text: control.actionId !== EnterKeyAction.None ? control.displayText : ""
                clip: true
                fontSizeMode: Text.HorizontalFit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: Theme.textColor
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: Theme.fontSizeMedium
                    capitalization: Font.AllUppercase
                }
                anchors.fill: parent
                anchors.margins: Math.round(42 * scaleHint)
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: enterBgimg
                    source:"images/keyboard-key-portrait-function-pressed.png"
                }
                PropertyChanges {
                    target: enterKeyIcon
                    opacity: 0.6
                }
                PropertyChanges {
                    target: enterKeyText
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: enterKeyIcon
                    opacity: 0.2
                }
                PropertyChanges {
                    target: enterKeyText
                    opacity: 0.2
                }
            }
        ]
    }

    hideKeyPanel: KeyPanel {
        BorderImage {
            id: hideKbdBgimg
            border { left: horizontalBorder; top: topBorder; right: horizontalBorder; bottom:0 }
            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat
            source: "images/keyboard-key-portrait-function.png"
            anchors.fill: parent
            anchors.margins: keyBackgroundMargin
            Image {
                id: hideKeyIcon
                anchors.centerIn: parent
                sourceSize.width: 144 * keyIconScale
                sourceSize.height: 127 * keyIconScale
                smooth: true
                source: resourcePrefix + "images/hidekeyboard-868482.svg"
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: hideKbdBgimg
                    source:"images/keyboard-key-portrait-function-pressed.png"
                }
                PropertyChanges {
                    target: hideKeyIcon
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: hideKeyIcon
                    opacity: 0.2
                }
            }
        ]
    }

    shiftKeyPanel: KeyPanel {
        BorderImage {
            id: shiftBgimg
            border { left: horizontalBorder; top: topBorder; right: horizontalBorder; bottom:0 }
            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat
            source: "images/keyboard-key-portrait-function.png"
            anchors.fill: parent
            anchors.margins: keyBackgroundMargin
            Image {
                id: shiftKeyIcon
                anchors.centerIn: parent
                sourceSize.width: width
                sourceSize.height: height
                smooth: true
                fillMode: Image.PreserveAspectFit
                width: Theme.fontSizeLarge
                source: "images/icon-shift.svg"
            }
            states: [
                State {
                    name: "capslock"
                    when: InputContext.capsLock

                    PropertyChanges {
                        target: shiftKeyIcon
                        source: "images/icon-shift-locked.svg"
                    }
                },
                State {
                    name: "shift"
                    when: InputContext.shift
                    PropertyChanges {
                        target: shiftKeyIcon
                        source: "images/icon-shift-pressed.svg"
                    }
                }
            ]
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed

                PropertyChanges {
                    target: shiftBgimg
                    source:"images/keyboard-key-portrait-function-pressed.png"

                }
                PropertyChanges {
                    target: shiftKeyIcon
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: shiftKeyIcon
                    opacity: 0.2
                }
            }
        ]
    }

    spaceKeyPanel: KeyPanel {
        BorderImage {
            id: spaceBgimg
            border { left: horizontalBorder; top: topBorder; right: horizontalBorder; bottom:0 }
            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat
            source: "images/keyboard-key-portrait-function.png"
            anchors.fill: parent
            anchors.margins: keyBackgroundMargin
            Text {
                id: spaceKeyText
                text: Qt.locale(InputContext.locale).nativeLanguageName
                color: Theme.textColor
                Behavior on color { PropertyAnimation { duration: 250 } }
                anchors.centerIn: parent
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: Theme.fontSizeMedium * scaleHint
                }
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: spaceBgimg
                    source:"images/keyboard-key-portrait-function-pressed.png"

                }
            },
            State {
                name: "disabled"
                when: !control.enabled
            }
        ]
    }

    symbolKeyPanel: KeyPanel {
        BorderImage {
            id: symbolBgimg
            border { left: horizontalBorder; top: topBorder; right: horizontalBorder; bottom:0 }
            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat
            source: "images/keyboard-key-portrait-function.png"
            anchors.fill: parent
            anchors.margins: keyBackgroundMargin
            Text {
                id: symbolKeyText
                text: control.displayText
                color: Theme.textColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                anchors.margins: keyContentMargin
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: Theme.fontSizeMedium * scaleHint
                    capitalization: Font.AllUppercase
                }
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: symbolBgimg
                    source:"images/keyboard-key-portrait-function-pressed.png"
                }
                PropertyChanges {
                    target: symbolKeyText
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    target: symbolKeyText
                    opacity: 0.2
                }
            }
        ]
    }

    modeKeyPanel: KeyPanel {
        BorderImage {
            id: modelBgimg
            border { left: horizontalBorder; top: topBorder; right: horizontalBorder; bottom:0 }
            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat
            source: "images/keyboard-key-portrait-function.png"
            anchors.fill: parent
            anchors.margins: keyBackgroundMargin
            Text {
                id: modeKeyText
                text: control.displayText
                color: Theme.textColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                anchors.margins: keyContentMargin
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: 44 * scaleHint
                    capitalization: Font.AllUppercase
                }
            }
            Rectangle {
                id: modeKeyIndicator
                implicitHeight: parent.height * 0.1
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: parent.width * 0.4
                anchors.rightMargin: parent.width * 0.4
                anchors.bottomMargin: parent.height * 0.12
                color: Theme.accentColor
                visible: control.mode
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: modelBgimg
                    source:"images/keyboard-key-portrait-function-pressed.png"
                }
                PropertyChanges {
                    target: modeKeyText
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    opacity: 0.8
                }
                PropertyChanges {
                    target: modeKeyText
                    opacity: 0.2
                }
            }
        ]
    }

    handwritingKeyPanel: KeyPanel {
        BorderImage {
            id: hwrBgimg
            border { left: horizontalBorder; top: topBorder; right: horizontalBorder; bottom:0 }
            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat
            source: "images/keyboard-key-portrait-function.png"
            anchors.fill: parent
            anchors.margins: keyBackgroundMargin
            Image {
                id: hwrKeyIcon
                anchors.centerIn: parent
                readonly property size hwrKeyIconSize: keyboard.handwritingMode ? Qt.size(124, 96) : Qt.size(156, 104)
                sourceSize.width: hwrKeyIconSize.width * keyIconScale
                sourceSize.height: hwrKeyIconSize.height * keyIconScale
                smooth: true
                source: resourcePrefix + (keyboard.handwritingMode ? "images/textmode-868482.svg" : "images/handwriting-868482.svg")
            }
        }
        states: [
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: hwrBgimg
                    source:"images/keyboard-key-portrait-function-pressed.png"
                }
                PropertyChanges {
                    target: hwrKeyIcon
                    opacity: 0.6
                }
            },
            State {
                name: "disabled"
                when: !control.enabled
                PropertyChanges {
                    opacity: 0.8
                }
                PropertyChanges {
                    target: hwrKeyIcon
                    opacity: 0.2
                }
            }
        ]
    }

    characterPreviewMargin: 0
    characterPreviewDelegate: Item {
        property string text
        id: characterPreview
        Image {
        id: popper
        source: "images/popper.png"
        anchors.fill: parent
            Text {
                id: characterPreviewText
                color: Theme.textColor
                text: characterPreview.text
                fontSizeMode: Text.HorizontalFit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                anchors.margins: Math.round(48 * scaleHint)
                font {
                    family: fontFamily
                    weight: Font.Normal
                    bold:true
                    pixelSize: Theme.fontSizeExtraLarge * scaleHint
                }
            }
        }
    }

    alternateKeysListItemWidth: characterPreview.width
    alternateKeysListItemHeight: characterPreview.height
    alternateKeysListDelegate: Item {
        id: alternateKeysListItem
        width: alternateKeysListItemWidth
        height: alternateKeysListItemHeight
        Text {
            id: listItemText
            text: model.text
            color: Theme.textColor
            opacity: 0.8
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize:  Theme.fontSizeExtraLarge * scaleHint
            }
            anchors.centerIn: parent
        }
        states: State {
            name: "current"
            when: alternateKeysListItem.ListView.isCurrentItem
            PropertyChanges {
                target: listItemText
                opacity: 1
            }
        }
    }
    alternateKeysListHighlight: Image {
        source: "images/popper.png"
    }
    alternateKeysListBackground: Rectangle {
        color: Theme.backgroundColor
    }

    selectionListHeight: 85 * scaleHint
    selectionListDelegate: SelectionListItem {
        id: selectionListItem
        width: Math.round(selectionListLabel.width + selectionListLabel.anchors.leftMargin * 2)
        Text {
            id: selectionListLabel
            anchors.left: parent.left
            anchors.leftMargin: Math.round((compactSelectionList ? 50 : 140) * scaleHint)
            anchors.verticalCenter: parent.verticalCenter
            text: decorateText(display, wordCompletionLength)
            color: Theme.accentColor
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: 44 * scaleHint
            }
            function decorateText(text, wordCompletionLength) {
                if (wordCompletionLength > 0) {
                    return text.slice(0, -wordCompletionLength) + '<u>' + text.slice(-wordCompletionLength) + '</u>'
                }
                return text
            }
        }
        Rectangle {
            id: selectionListSeparator
            width: 4 * scaleHint
            height: 36 * scaleHint
            radius: 2
            color: "#35322f"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.left
        }
        states: State {
            name: "current"
            when: selectionListItem.ListView.isCurrentItem
            PropertyChanges {
                target: selectionListLabel
                color: "white"
            }
        }
    }
    selectionListBackground: Rectangle {
        color: "#1e1b18"
    }
    selectionListAdd: Transition {
        NumberAnimation { property: "y"; from: wordCandidateView.height; duration: 200 }
        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 200 }
    }
    selectionListRemove: Transition {
        NumberAnimation { property: "y"; to: -wordCandidateView.height; duration: 200 }
        NumberAnimation { property: "opacity"; to: 0; duration: 200 }
    }

    navigationHighlight: Rectangle {
        color: "transparent"
        border.color: Theme.accentColor
        border.width: Theme.itemSpacingExtraSmall
    }

    traceInputKeyPanelDelegate: TraceInputKeyPanel {
        traceMargins: keyBackgroundMargin
        Rectangle {
            id: traceInputKeyPanelBackground
            color: Theme.fillDarkColor
            anchors.fill: parent
            anchors.margins: keyBackgroundMargin
            Text {
                id: hwrInputModeIndicator
                visible: control.patternRecognitionMode === InputEngine.HandwritingRecoginition
                text: InputContext.inputEngine.inputMode === InputEngine.Latin ? "Abc" : "123"
                color: Theme.textColor
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: keyContentMargin
                font {
                    family: fontFamily
                    weight: Font.Normal
                    pixelSize: Theme.fontSizeSmall * scaleHint
                    capitalization: {
                        if (InputContext.capsLock)
                            return Font.AllUppercase
                        if (InputContext.shift)
                            return Font.MixedCase
                        return Font.AllLowercase
                    }
                }
            }
        }
        Canvas {
            id: traceInputKeyGuideLines
            anchors.fill: traceInputKeyPanelBackground
            opacity: 0.1
            onPaint: {
                var ctx = getContext("2d")
                ctx.lineWidth = 1
                ctx.strokeStyle = Qt.rgba(0xFF, 0xFF, 0xFF)
                ctx.clearRect(0, 0, width, height)
                var i
                if (control.horizontalRulers) {
                    for (i = 0; i < control.horizontalRulers.length; i++) {
                        ctx.beginPath()
                        ctx.moveTo(0, control.horizontalRulers[i])
                        ctx.lineTo(width, control.horizontalRulers[i])
                        ctx.stroke()
                    }
                }
                if (control.verticalRulers) {
                    for (i = 0; i < control.verticalRulers.length; i++) {
                        ctx.beginPath()
                        ctx.moveTo(control.verticalRulers[i], 0)
                        ctx.lineTo(control.verticalRulers[i], height)
                        ctx.stroke()
                    }
                }
            }
        }
    }

    traceCanvasDelegate: TraceCanvas {
        id: traceCanvas
        onAvailableChanged: {
            if (!available)
                return
            var ctx = getContext("2d")
            if (parent.canvasType === "fullscreen") {
                ctx.lineWidth = 10
                ctx.strokeStyle = Qt.rgba(0, 0, 0)
            } else {
                ctx.lineWidth = 10 * scaleHint
                ctx.strokeStyle = Qt.rgba(0xFF, 0xFF, 0xFF)
            }
            ctx.lineCap = "round"
            ctx.fillStyle = ctx.strokeStyle
        }
        autoDestroyDelay: 800
        onTraceChanged: if (trace === null) opacity = 0
        Behavior on opacity { PropertyAnimation { easing.type: Easing.OutCubic; duration: 150 } }
    }

    popupListDelegate: SelectionListItem {
        property real cursorAnchor: popupListLabel.x + popupListLabel.width
        id: popupListItem
        width: popupListLabel.width + popupListLabel.anchors.leftMargin * 2
        height: popupListLabel.height + popupListLabel.anchors.topMargin * 2
        Text {
            id: popupListLabel
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: popupListLabel.height / 2
            anchors.topMargin: popupListLabel.height / 3
            text: decorateText(display, wordCompletionLength)
            color: Theme.accentColor
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: Qt.inputMethod.cursorRectangle.height * 0.8
            }
            function decorateText(text, wordCompletionLength) {
                if (wordCompletionLength > 0) {
                    return text.slice(0, -wordCompletionLength) + '<u>' + text.slice(-wordCompletionLength) + '</u>'
                }
                return text
            }
        }
        states: State {
            name: "current"
            when: popupListItem.ListView.isCurrentItem
            PropertyChanges {
                target: popupListLabel
                color: "black"
            }
        }
    }

    popupListBackground: Item {
        Rectangle {
            width: parent.width
            height: parent.height
            color: Theme.textColor
            border {
                width: 1
                color: "#929495"
            }
        }
    }

    popupListAdd: Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 200 }
    }

    popupListRemove: Transition {
        NumberAnimation { property: "opacity"; to: 0; duration: 200 }
    }

    languagePopupListEnabled: true

    languageListDelegate: SelectionListItem {
        id: languageListItem
        width: languageNameTextMetrics.width * 17
        height: languageNameTextMetrics.height + languageListLabel.anchors.topMargin + languageListLabel.anchors.bottomMargin
        Text {
            id: languageListLabel
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: languageNameTextMetrics.height / 2
            anchors.rightMargin: anchors.leftMargin
            anchors.topMargin: languageNameTextMetrics.height / 3
            anchors.bottomMargin: anchors.topMargin
            text: languageNameFormatter.elidedText
            color: Theme.textColor
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: Theme.fontSizeSmall * scaleHint
            }
        }
        TextMetrics {
            id: languageNameTextMetrics
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: Theme.fontSizeSmall * scaleHint
            }
            text: "X"
        }
        TextMetrics {
            id: languageNameFormatter
            font {
                family: fontFamily
                weight: Font.Normal
                pixelSize: Theme.fontSizeSmall * scaleHint
            }
            elide: Text.ElideRight
            elideWidth: languageListItem.width - languageListLabel.anchors.leftMargin - languageListLabel.anchors.rightMargin
            text: displayName
        }
        states: State {
            name: "current"
            when: languageListItem.ListView.isCurrentItem
            PropertyChanges {
                target: languageListLabel
                color: Theme.accentColor
            }
        }
    }

    languageListBackground: Rectangle {
        color: Theme.fillDarkColor
        border {
            width: 1
            color: Theme.fillColor
        }
    }

    languageListAdd: Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 200 }
    }

    languageListRemove: Transition {
        NumberAnimation { property: "opacity"; to: 0; duration: 200 }
    }

    selectionHandle: Image {
        sourceSize.width: 20
        source: resourcePrefix + "images/selectionhandle-bottom.svg"
    }

    fullScreenInputContainerBackground: Rectangle {
        color: "#FFF"
    }

    fullScreenInputBackground: Rectangle {
        color: "#FFF"
    }

    fullScreenInputMargins: Math.round(15 * scaleHint)

    fullScreenInputPadding: Math.round(30 * scaleHint)

    fullScreenInputCursor: Rectangle {
        width: 1
        color: Theme.accentColor
        visible: parent.blinkStatus
    }

    fullScreenInputFont.pixelSize: 58 * scaleHint
}
