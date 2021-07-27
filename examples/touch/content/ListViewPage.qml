/****************************************************************************************
**
** Copyright (C) 2017-2021 Chupligin Sergey <neochapay@gmail.com>
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

Page {
    id: listViewPage

    headerTools: HeaderToolsLayout {
        showBackButton: true;
        title: qsTr("ListView")
    }


    ListModel {
        id: animalsModel
        ListElement { name: "Ant"; desc: "Small description"; size: "Tiny"; canRemove: true}
        ListElement { name: "Flea"; desc: ""; size: "Tiny"; canRemove: false }
        ListElement { name: "Parrot"; desc: ""; size: "Small"; canRemove: true }
        ListElement { name: "Guinea pig"; desc: "The guinea pig, cavy or domestic guinea pig, or cuy for livestock breeds, is a species of rodent belonging to the family Caviidae and the genus Cavia"; size: "Small"; canRemove: false }
        ListElement { name: "Rat"; desc: ""; size: "Small"; canRemove: true }
        ListElement { name: "Butterfly"; desc: ""; size: "Small"; canRemove: false }
        ListElement { name: "Dog"; desc: ""; size: "Medium"; canRemove: true }
        ListElement { name: "Cat"; desc: ""; size: "Medium"; canRemove: false }
        ListElement { name: "Pony"; desc: ""; size: "Medium"; canRemove: true }
        ListElement { name: "Koala"; desc: ""; size: "Medium"; canRemove: false }
        ListElement { name: "Horse"; desc: ""; size: "Large"; canRemove: true }
        ListElement { name: "Tiger"; desc: ""; size: "Large"; canRemove: false }
        ListElement { name: "Giraffe"; desc: ""; size: "Large"; canRemove: true }
        ListElement { name: "Elephant"; desc: ""; size: "Huge"; canRemove: false }
        ListElement { name: "Whale"; desc: ""; size: "Huge"; canRemove: true }
    }

    ListView {
        id: view
        anchors.fill: parent
        clip: true
        model: animalsModel
        delegate: ListViewItemWithActions {
            id: item
            label: name
            description: desc
            showNext: false
            showActions: canRemove

            width: parent.width
            height: Theme.itemHeightLarge

            actions:[
                ActionButton {
                    iconSource: "image://theme/times"
                }

            ]
        }
        section.property: "size"
    }
}
