/****************************************************************************************
**
** Copyright (C) 2014 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
** Copyright (C) 2017 Chupligin Sergey <neochapay@gmail.com>
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
import QtQuick.Controls 1.0 //needed for the Stack attached property
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import Nemo.Dialogs 1.0

Page {
    id: root

    headerTools: HeaderToolsLayout { showBackButton: true; title: qsTr("Query dialog example") }

    Image {
        id: bgImage
        source: "/usr/share/glacier-components/images/example.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Button {
        id: standartButton
        anchors{
            top: parent.top
            margins: 20
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("Standart dialog")
        onClicked: {
            deleteDialog.inline = false
            deleteDialog.visible = true
            standartButton.visible = false
            inlineButton.visible = false
        }
    }

    Button {
        id: inlineButton
        anchors{
            top: standartButton.bottom
            margins: 20
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("Inline dialog")
        onClicked: {
            deleteDialog.inline = true
            deleteDialog.visible = true
            standartButton.visible = false
            inlineButton.visible = false
        }
    }

    QueryDialog {
        id: deleteDialog
        visible: false

        cancelText: qsTr("Cancel")
        acceptText: qsTr("Delete")
        headingText: qsTr("Are you sure you want to delete this?")
        subLabelText: qsTr("Do you want to continue?")

        icon: "image://theme/trash"

        onAccepted: {
            result.text = qsTr("User accepted")
        }
        onCanceled: {
            result.text = qsTr("User canceled")
        }
        onSelected: {
            standartButton.visible = true
            inlineButton.visible = true
            visible = false
        }
    }
    Label {
        id: result
        anchors.centerIn: parent
    }
}
