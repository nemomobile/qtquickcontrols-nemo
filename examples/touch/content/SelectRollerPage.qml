/****************************************************************************
**
** Copyright (C) 2021 Chupligin Sergey <neochapay@gmail.com>
**
** This file is part of the Qt Quick Controls module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.6
import QtQuick.Controls 1.0 //needed for the Stack attached property
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Page {
    id: root

    headerTools: HeaderToolsLayout {
        showBackButton: true;
        title: qsTr("Select roller")
    }
    allowedOrientations: Qt.PortraitOrientation | Qt.LandscapeOrientation | Qt.InvertedLandscapeOrientation | Qt.InvertedPortraitOrientation

    Column {
        spacing: Theme.itemSpacingHuge
        width: parent.width
        anchors{
            top: parent.top
            topMargin: Theme.itemSpacingHuge
        }

        ListModel {
            id: animalsModel
            ListElement { name: "Ant";}
            ListElement { name: "Flea"; }
            ListElement { name: "Parrot"; }
            ListElement { name: "Guinea pig";}
            ListElement { name: "Rat";}
            ListElement { name: "Butterfly";}
            ListElement { name: "Dog";}
            ListElement { name: "Cat";}
            ListElement { name: "Pony";}
            ListElement { name: "Koala";}
            ListElement { name: "Horse";}
            ListElement { name: "Tiger";}
            ListElement { name: "Giraffe";}
            ListElement { name: "Elephant";}
            ListElement { name: "Whale";}
        }

        GlacierRoller {
            id: simpleRoller
            width: parent.width

            clip: true
            model: animalsModel
            label: qsTr("Choose your favorite animal")
            delegate: GlacierRollerItem{
                Text{
                    height: simpleRoller.itemHeight
                    verticalAlignment: Text.AlignVCenter
                    text: name
                    color: Theme.textColor
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: (simpleRoller.activated && simpleRoller.currentIndex === index)
                }
            }
        }

        GlacierRoller {
            id: simpleRoller2
            width: parent.width

            clip: true
            model: animalsModel
            label: qsTr("Choose your second favorite animal")

            delegate: GlacierRollerItem{
                Text{
                    height: simpleRoller2.itemHeight
                    verticalAlignment: Text.AlignVCenter
                    text: name
                    color: Theme.textColor
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: (simpleRoller2.activated && simpleRoller2.currentIndex === index)
                }
            }
        }
    }
}
