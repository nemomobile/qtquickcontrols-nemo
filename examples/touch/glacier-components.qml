/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
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
import QtQuick.Layouts 1.0
import "content"

ApplicationWindow {

    id: appWindow

    contentOrientation: Screen.orientation

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
            title: "Live-Coding Arena"
            page: "content/LiveCoding.qml"
        }
        ListElement {
            title: "Buttons (locked to portrait)"
            page: "content/ButtonPage.qml"
        }
        ListElement {
            title: "Sliders"
            page: "content/SliderPage.qml"
        }
        ListElement {
            title: "ProgressBar"
            page: "content/ProgressBarPage.qml"
        }
        ListElement {
            title: "DatePicker"
            page: "content/DatePickerPage.qml"
        }
        ListElement {
            title: "Tabs"
            page: "content/TabBarPage.qml"
        }
        ListElement {
            title: "TextInput"
            page: "content/TextInputPage.qml"
        }
        ListElement {
            title: "Spinner"
            page: "content/SpinnerPage.qml"
        }
        ListElement {
            title: "SelectRoller"
            page: "content/SelectRollerPage.qml"
        }
        ListElement {
            title: "ListView"
            page: "content/ListViewPage.qml"
        }
        ListElement {
            title: "Labels (no orientation locks)"
            page: "content/LabelPage.qml"
        }
        ListElement {
            title: "Switches"
            page: "content/CheckboxPage.qml"
        }
        ListElement {
            title: "ButtonRow (locked to landscape)"
            page: "content/ButtonRowPage.qml"
        }
        ListElement {
            title: "Query Dialog"
            page: "content/QueryDialogPage.qml"
        }
        ListElement {
            title: "Icons"
            page: "content/IconPage.qml"
        }
        ListElement {
            title: "Notifications"
            page: "content/NotificationsPage.qml"
        }
    }


    initialPage: Page {
        id: pageItem

        headerTools: HeaderToolsLayout {
            id: tools

            title: "Nemo Touch Gallery"
            tools: [ ToolButton { iconSource: "/usr/share/glacier-components/images/icon_cog.png"},
                ToolButton { iconSource: "/usr/share/glacier-components/images/icon_edit.png"},
                ToolButton { iconSource: "/usr/share/glacier-components/images/icon_refresh.png"} ]

            //The parent of these items is null when this ToolsLayout is not used
            //(i.e. you're on a different page) so we need to check the parent,
            //just like in MeeGo's ToolbarLayout (when you don't use the automatic layout)

            //TODO: Add automatic layout logic (see ToolbarLayout in MeeGo)
            drawerLevels: [
                Button {
                    anchors.horizontalCenter: (parent==undefined) ? undefined : parent.horizontalCenter;
                    text: "Nemo"
                },
                Button {
                    anchors.horizontalCenter: (parent==undefined) ? undefined : parent.horizontalCenter;
                    text: "Mobile"
                },
                Button {
                    anchors.horizontalCenter: (parent==undefined) ? undefined : parent.horizontalCenter;
                    text: "FTW"
                },
                RowLayout {
                    anchors.left: (parent==undefined) ? undefined : parent.left
                    anchors.right: (parent==undefined) ? undefined : parent.right
                    anchors.margins: 20
                    Layout.preferredHeight: 100
                    Label {
                        anchors.left: parent.left;
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Drawer Test"}
                    CheckBox {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        width : 20
                    }
                },
                RowLayout {
                    anchors.left: (parent==undefined) ? undefined : parent.left
                    anchors.right: (parent==undefined) ? undefined : parent.right
                    anchors.margins: 20
                    Layout.preferredHeight: 100
                    Label {
                        anchors.left: parent.left;
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Drawer Test 2"}
                    ToolButton {
                        id: tool1
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        iconSource: "/usr/share/glacier-components/images/icon_cog.png"
                    }
                    ToolButton {
                        id: tool2
                        anchors.right: tool1.left
                        anchors.verticalCenter: parent.verticalCenter
                        iconSource: "/usr/share/glacier-components/images/icon_edit.png"
                    }
                    ToolButton {
                        id: tool3
                        anchors.right: tool2.left
                        anchors.verticalCenter: parent.verticalCenter
                        iconSource: "/usr/share/glacier-components/images/icon_refresh.png"
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
