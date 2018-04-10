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

import QtQuick 2.6
import QtQuick.Controls 1.0 //needed for the Stack attached property
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0
import QtQuick.Layouts 1.0

Page {
    id: root

    property var oldItem
    property var newItem

    headerTools: HeaderToolsLayout { showBackButton: true; title: "Live Coding Arena" }

    SplitView {
        anchors.fill: parent

        //If we don't wrap ColumnLayout in an Item, the split view doesn't work :/
        Item {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width / 3

            Button {
                id: btn
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                text: "Update LiveItem"
                onClicked: {
                    txt.qmlError = false
                    try {
                        newItem = Qt.createQmlObject(txt.text, compItem, "LiveCodingItem")
                    }
                    catch (err) {
                        txt.qmlError = true
                        errorTxt.text = ""
                        for (var i=0; i<err.qmlErrors.length; i++) {
                            var errorString = "Line " + err.qmlErrors[i].lineNumber + ": " +
                                    err.qmlErrors[i].message + "\n"
                            errorTxt.text += errorString
                        }
                    }

                    if (!txt.qmlError) errorTxt.text = "No errors"

                    if (oldItem) oldItem.destroy()

                    if (newItem) {
                        oldItem = newItem
                    }
                }
            }

            TextArea {
                id: txt
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: btn.bottom
                anchors.bottom: errorBox.top
                wrapMode: TextEdit.Wrap
                textFormat: Text.PlainText

                property bool qmlError: false
                property int oldCursorPosition: 0
                property int currentLine: 0
                onCursorPositionChanged: {
                    //------->VERY INEFFICIENT...But it works for our case, see TODO few lines below
                    txt.currentLine = 1 + txt.countNewLinesBetween(0, txt.cursorPosition)
                }

                //this is to avoid updating line count too often
                //
                //------->TODO: Unfortunately this solution doesn't work in the case the user deletes text
                //as we would need a way to diff old and new text, and see the delta of newlines
                //Timer {
                //    id: lineUpdateTimer
                //    running: false
                //    interval: 200
                //    onTriggered: {
                //        if (txt.oldCursorPosition <= txt.cursorPosition) {
                //            txt.currentLine += txt.countNewLinesBetween(txt.oldCursorPosition, txt.cursorPosition)
                //        } else {
                //            txt.currentLine -= txt.countNewLinesBetween(txt.cursorPosition, txt.oldCursorPosition)
                //        }
                //       txt.oldCursorPosition = txt.cursorPosition
                //    }
                //}

                function countNewLinesBetween(start, end) {
                    var newLinesFound = 0;
                    if (start > end) {
                        console.log("Updating line count with wrong parameters")
                        return
                    }
                    if (start === end) {
                        return newLinesFound
                    }
                    for (var i=start; i < end; i++) {
                        if (txt.text[i] == "\n") newLinesFound++
                    }
                    return newLinesFound
                }

                Rectangle {
                    color: "lightgray"
                    radius: 5
                    width: lineTxt.width + 20
                    height: lineTxt.height + 20
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.margins: 10
                    Text {
                        id: lineTxt
                        anchors.centerIn: parent

                        text: "Line: " + txt.currentLine
                    }
                }
            }

            Rectangle {
                id: errorBox
                color: "lightgray"
                radius: 10
                height: 100
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                Flickable {
                    id: flickTxt
                    anchors.fill: parent
                    anchors.margins: 10
                    contentHeight: errorTxt.height
                    contentWidth: errorTxt.width
                    flickableDirection: Flickable.VerticalFlick
                    clip: true

                    Text {
                        id: errorTxt
                        width: flickTxt.width
                        wrapMode: Text.Wrap
                    }
                }
            }
        }

        Item {
            id: compItem
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }
    }
}
