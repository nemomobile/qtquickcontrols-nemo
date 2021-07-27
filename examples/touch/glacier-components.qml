/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Copyright (C) 2017-2021 Chupligin Sergey <neochapay@gmail.com>
** Contact: http://www.qt-project.org/legal
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
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0
import QtQuick.Window 2.1

import "content"

ApplicationWindow {

    id: appWindow

    contentOrientation: Screen.orientation
    allowedOrientations:  Qt.PortraitOrientation | Qt.LandscapeOrientation | Qt.InvertedLandscapeOrientation | Qt.InvertedPortraitOrientation

    // Implements back key navigation
    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            if (pageStack.depth > 1) {
                pageStack.pop();
                event.accepted = true;
            } else { Qt.quit(); }
        }
    }

    ListModel {
        id: pageModel
        ListElement {
            title: qsTr("Live-Coding Arena")
            page: "content/LiveCoding.qml"
        }
        ListElement {
            title: qsTr("Buttons (locked to portrait)")
            page: "content/ButtonPage.qml"
        }
        ListElement {
            title: qsTr("Sliders")
            page: "content/SliderPage.qml"
        }
        ListElement {
            title: qsTr("ProgressBar")
            page: "content/ProgressBarPage.qml"
        }
        ListElement {
            title: qsTr("DatePicker")
            page: "content/DatePickerPage.qml"
        }
        ListElement {
            title: qsTr("TimePicker")
            page: "content/TimePickerPage.qml"
        }
        ListElement {
            title: qsTr("Tabs")
            page: "content/TabBarPage.qml"
        }
        ListElement {
            title: qsTr("TextInput")
            page: "content/TextInputPage.qml"
        }
        ListElement {
            title: qsTr("Spinner")
            page: "content/SpinnerPage.qml"
        }
        ListElement {
            title: qsTr("SelectRoller")
            page: "content/SelectRollerPage.qml"
        }
        ListElement {
            title: qsTr("ListView")
            page: "content/ListViewPage.qml"
        }
        ListElement {
            title: qsTr("Labels (no orientation locks)")
            page: "content/LabelPage.qml"
        }
        ListElement {
            title: qsTr("Switches")
            page: "content/CheckboxPage.qml"
        }
        ListElement {
            title: qsTr("ButtonRow (locked to landscape)")
            page: "content/ButtonRowPage.qml"
        }
        ListElement {
            title: qsTr("Dialogs")
            page: "content/DialogsPage.qml"
        }
        ListElement {
            title: qsTr("Icons")
            page: "content/IconPage.qml"
        }
        ListElement {
            title: qsTr("Notifications")
            page: "content/NotificationsPage.qml"
        }
        ListElement {
            title: qsTr("Status icon")
            page: "content/StatusNotifyPage.qml"
        }
        ListElement {
            title: qsTr("Broken page")
            page: "content/BrokenPage.qml"
        }
    }

    initialPage: Page {
        id: pageItem

        headerTools: HeaderToolsLayout {
            id: tools

            title: qsTr("Nemo components gallery")
            tools: [
                ToolButton {
                    iconSource: "image://theme/cog"
                    showCounter: false
                },
                ToolButton {
                    id: editIcon
                    iconSource: "image://theme/edit"
                    showCounter: true
                    counterValue: 0

                    onClicked: {
                        editIcon.counterValue++
                    }

                    active: true
                },
                ToolButton {
                    iconSource: "image://theme/refresh"
                    showCounter: true
                    showZeroCounter: true
                }
            ]

            //The parent of these items is null when this ToolsLayout is not used
            //(i.e. you're on a different page) so we need to check the parent,
            //just like in MeeGo's ToolbarLayout (when you don't use the automatic layout)

            //TODO: Add automatic layout logic (see ToolbarLayout in MeeGo)
            drawerLevels: [
                Button {
                    anchors.horizontalCenter: (parent==undefined) ? undefined : parent.horizontalCenter;
                    text: qsTr("Black theme")
                    primary: Theme.themePath == "/usr/lib/qt/qml/QtQuick/Controls/Styles/Nemo/themes/glacier_black.json"
                    onClicked: {
                        Theme.loadTheme("/usr/lib/qt/qml/QtQuick/Controls/Styles/Nemo/themes/glacier_black.json")
                    }
                },
                Button {
                    anchors.horizontalCenter: (parent==undefined) ? undefined : parent.horizontalCenter;
                    text: qsTr("White theme")
                    primary: Theme.themePath == "/usr/lib/qt/qml/QtQuick/Controls/Styles/Nemo/themes/glacier_white.json"
                    onClicked: {
                        Theme.loadTheme("/usr/lib/qt/qml/QtQuick/Controls/Styles/Nemo/themes/glacier_white.json")
                    }
                },
                Row {
                    id: drawerTestRow
                    width: appWindow.width
                    height: Theme.itemHeightMedium

                    anchors{
                        left: (parent==undefined) ? undefined : parent.left
                        right: (parent==undefined) ? undefined : parent.right
                        margins: Theme.itemSpacingLarge
                    }

                    Label {
                        id: drawerTestLabel
                        text: qsTr("Drawer Test")
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Rectangle{
                        id: spacer1
                        width: parent.width-drawerTestLabel.width-drawerTestCheckBox.width
                        color: "transparent"
                        height: 1
                    }

                    CheckBox {
                        id: drawerTestCheckBox
                        anchors.verticalCenter: parent.verticalCenter
                    }
                },
                Row{
                    id: drawerTest2Row
                    width: appWindow.width
                    height: Theme.itemHeightMedium

                    anchors{
                        left: (parent==undefined) ? undefined : parent.left
                        right: (parent==undefined) ? undefined : parent.right
                        margins: Theme.itemSpacingLarge
                    }

                    Label {
                        id: drawerTest2Label
                        text: qsTr("Drawer Test 2")
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Rectangle{
                        id: spacer2
                        width: parent.width-drawerTest2Label.width-tool1.width-tool2.width-tool3.width
                        color: "transparent"
                        height: 1
                    }

                    ToolButton {
                        id: tool1
                        iconSource: "image://theme/cog"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ToolButton {
                        id: tool2
                        iconSource: "image://theme/edit"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ToolButton {
                        id: tool3
                        iconSource: "image://theme/refresh"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                },
                ButtonRow {
                    id: buttonRowExample
                    model: ListModel {
                        ListElement {
                            name: "swim"
                        }
                        ListElement {
                            name: "cruise"
                        }
                        ListElement {
                            name: "row"
                        }
                        ListElement {
                            name: "fish"
                        }
                        ListElement {
                            name: "dive"
                        }
                    }
                }

            ]
        }

        ListView {
            id: mainList
            model: pageModel
            anchors.fill: parent
            clip: true
            delegate: ListViewItemWithActions {
                iconVisible: false
                label: title
                onClicked: pageItem.Stack.view.push(Qt.resolvedUrl(page))
            }

            ScrollDecorator{
                flickable: mainList
            }
        }
    }
}
