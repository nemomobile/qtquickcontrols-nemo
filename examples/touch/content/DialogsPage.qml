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

    ListModel {
        id: animalsModel
        ListElement { name: "Ant"; }
        ListElement { name: "Flea"; }
        ListElement { name: "Parrot"; }
        ListElement { name: "Guinea pig"; }
        ListElement { name: "Rat"; }
        ListElement { name: "Butterfly"; }
        ListElement { name: "Dog"; }
        ListElement { name: "Cat"; }
        ListElement { name: "Pony"; }
        ListElement { name: "Koala"; }
        ListElement { name: "Horse"; }
        ListElement { name: "Tiger"; }
        ListElement { name: "Giraffe"; }
        ListElement { name: "Elephant"; }
        ListElement { name: "Whale"; }
    }

    function hideButton(){
        standartButton.visible = false
        inlineButton.visible = false
        simpleButton.visible = false
        selectionButton.visible = false
    }

    function showButton(){
        standartButton.visible = true
        inlineButton.visible = true
        simpleButton.visible = true
        selectionButton.visible = true
    }

    Button {
        id: standartButton
        anchors{
            top: parent.top
            margins: 20
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("Standart query dialog")
        onClicked: {
            deleteDialog.inline = false
            deleteDialog.open()
            hideButton();
        }
    }

    Button {
        id: inlineButton
        anchors{
            top: standartButton.bottom
            margins: 20
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("Inline query dialog")
        onClicked: {
            deleteDialog.inline = true
            deleteDialog.open()
            hideButton();
        }
    }

    Button {
        id: simpleButton
        anchors{
            top: inlineButton.bottom
            margins: 20
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("Simple dialog")
        onClicked: {
            hideButton();
            simpleDialog.open();
        }
    }

    Button {
        id: selectionButton
        anchors{
            top: inlineButton.bottom
            margins: 20
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("Selection dialog")
        onClicked: {
            hideButton();
            selectionDialog.open();
        }
    }

    Dialog{
        id: simpleDialog
        acceptText: qsTr("Ok")
        headingText: qsTr("Simple dialog")
        subLabelText: qsTr("Simple diaolg is open")

        inline: false

        icon: "image://theme/exclamation-triangle"

        onAccepted: {
            showButton();
            simpleDialog.close();
        }
    }

    SelectionDialog{
        id: selectionDialog
        visible: false

        cancelText: qsTr("Cancel")
        acceptText: qsTr("Ok")
        headingText: qsTr("Select you favorite animal?")
        subLabelText: qsTr("")

        model: animalsModel

        onSelectedIndexChanged: selectionDialog.close()
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
            showButton();
            deleteDialog.close()
        }
    }

    Label {
        id: result
        anchors.centerIn: parent
    }
}
