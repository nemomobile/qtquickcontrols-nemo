/*
 * Copyright (C) 2021 Chupligin Sergey (NeoChapay) <neochapay@gmail.com>
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

Page {
    id: root

    headerTools: HeaderToolsLayout {
        showBackButton: false;
        title: qsTr("Blurred page")
    }



    ScrollDecorator{
        flickable: mainContent
    }


    Flickable{
        id: mainContent
        width: parent.width
        height: parent.height

        contentHeight: contentColumn.height+Theme.itemHeightExtraLarge

        Column {
            id: contentColumn
            spacing: Theme.itemSpacingLarge*2
            width: parent.width

            anchors{
                top: parent.top
                topMargin: Theme.itemSpacingLarge
                left: parent.left
                leftMargin: Theme.itemSpacingLarge
            }

            NemoBlurredImage{
                id: blurred
                width: parent.width - Theme.itemSpacingLarge*2
                height: root.height/3

                source: "/usr/share/glacier-components/images/example.jpg"
            }

            Label {
                text: qsTr("Select dim color")
            }

            Row{
                width: parent.width - Theme.itemSpacingLarge*2
                height: Theme.itemHeightExtraLarge

                Rectangle{
                    width: parent.width/3
                    height: parent.height
                    color: "red"
                    Label{
                        anchors.fill: parent
                        text: "Red"
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: blurred.dimColor = "red"
                    }
                }


                Rectangle{
                    width: parent.width/3
                    height: parent.height
                    color: "black"
                    Label{
                        anchors.fill: parent
                        text: "Black"
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: blurred.dimColor = "black"
                    }
                }

                Rectangle{
                    width: parent.width/3
                    height: parent.height
                    color: "white"
                    Label{
                        anchors.fill: parent
                        text: "White"
                        color: "black"
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: blurred.dimColor = "white"
                    }
                }
            }

            Label {
                text: qsTr("Blur radius")
            }

            Slider {
                id: radiusSlider
                anchors.margins: 20
                minimumValue: 0
                maximumValue: 100
                value: blurred.radius
                width: parent.width - Theme.itemSpacingLarge*2
                onValueChanged: {
                    blurred.radius = radiusSlider.value
                }
            }


            Label {
                text: qsTr("Opacity")
            }

            Slider {
                id: opacitySlider
                anchors.margins: 20
                value: blurred.opacity
                minimumValue: 0
                maximumValue: 1
                width: parent.width - Theme.itemSpacingLarge*2
                onValueChanged: {
                    blurred.opacity = opacitySlider.value
                }
            }
        }
    }
}

