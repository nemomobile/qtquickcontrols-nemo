/****************************************************************************************
**
** Copyright (C) 2019-2021 Chupligin Sergey <neochapay@gmail.com>
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
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Button {
    id: toolButton
    property alias iconSource: iconImage.source
    property bool showCounter: false
    property bool showZeroCounter: false
    property bool active: false
    property int counterValue: 0

    NemoIcon {
        id: iconImage
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        anchors.margins: Theme.itemSpacingExtraSmall
        color: active ? Theme.accentColor : Theme.textColor
    }

    Rectangle{
        id: counter
        width: counterText.paintedWidth*1.2 > toolButton.width/3 ? counterText.paintedWidth*1.2 : toolButton.width/3
        height: toolButton.width/3

        color: Theme.accentColor

        radius: counter.height/2

        visible: showCounter && ((showZeroCounter && counterValue == 0) || counterValue > 0)

        anchors{
            bottom: iconImage.bottom
            bottomMargin: -counter.height/2
            right: iconImage.right
            rightMargin: -counter.height/2
        }

        Text {
            id: counterText
            text: toolButton.counterValue >= 100 ? "99+" : toolButton.counterValue
            color: Theme.textColor
            anchors.centerIn: parent
            font.pixelSize: counter.height*0.8
        }
    }

    style: ToolButtonStyle{}
}
