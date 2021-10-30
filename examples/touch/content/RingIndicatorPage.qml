/****************************************************************************************
**
** Copyright (C) 2021 Chupligin Sergey <neochapay@gmail.com>
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

import QtQuick 2.1
import QtQuick.Controls 1.0 //needed for the Stack attached property
import QtQuick.Controls.Nemo 1.0

Page {
    id: root

    headerTools: HeaderToolsLayout {
        showBackButton: true;
        title: qsTr("Ring Indicator")
    }

    ScrollDecorator{
        flickable: content
    }

    Flickable{
        id: content
        width: parent.width
        height: parent.height

        contentHeight: mainColumn.height

        Column {
            id: mainColumn
            spacing: 40
            width: content.width-Theme.itemSpacingMedium*2

            anchors{
                left: parent.left
                leftMargin: Theme.itemSpacingMedium
                right: parent.right
                rightMargin: Theme.itemSpacingMedium
            }

            RingIndicator{
                id: ring
                width: 200
                height: 200
                startAngle: startAngleSlider.value
                stopAngle: stopAngleSlider.value
                rounded: roundCheckbox.checked
                lineWidth: lineWidthSlider.value
                color: Theme.accentColor
            }

            Label{
                text: qsTr("Start angle")
                width: mainColumn.width
            }

            Slider {
                width: 250
                id: startAngleSlider
                anchors.margins: 20
                value: 0
                showValue: true
                minimumValue: 0
                maximumValue: 360
                stepSize: 1
                alwaysUp: true
            }

            Label{
                text: qsTr("Stop angle")
                width: mainColumn.width
            }

            Slider {
                width: 250
                id: stopAngleSlider
                anchors.margins: 20
                value: 90
                showValue: true
                minimumValue: 0
                maximumValue: 360
                stepSize: 1
                alwaysUp: true
            }

            Label{
                text: qsTr("Line width")
                width: mainColumn.width
            }

            Slider {
                width: 250
                id: lineWidthSlider
                anchors.margins: 20
                value: 10
                showValue: true
                minimumValue: 0
                maximumValue: 100
                stepSize: 1
                alwaysUp: true
            }

            CheckBox {
                id: roundCheckbox
                text: qsTr("Rounding")
            }
        }
    }
}
