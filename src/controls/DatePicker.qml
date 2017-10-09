/****************************************************************************************
**
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
import QtQuick.Controls.Nemo 1.0

Item {
    id: datePicker

    width: parent.width
    height: childrenRect.height

    property date currentDate: new Date()

    property var monthNames: [qsTr("January"), qsTr("February"), qsTr("March"), qsTr("April"), qsTr("May"), qsTr("June"),qsTr("July"), qsTr("August"), qsTr("September"), qsTr("October"), qsTr("November"), qsTr("December")];

    signal monthChanged()
    signal dateSelect(var date)

    Item {
        id: header
        width: parent.width
        height: Theme.itemHeightLarge
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
        }

        Image{
            id: leftArrow
            width: Theme.itemHeightMedium
            height: width

            anchors{
                left: parent.left
                leftMargin: (Theme.itemHeightLarge-Theme.itemHeightMedium)/2
                top: parent.top
                topMargin: (Theme.itemHeightLarge-Theme.itemHeightMedium)/2
            }
            source: "image://theme/caret-left"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    var newDate = currentDate;
                    if(newDate.getMonth() == 1)
                    {
                        newDate.setFullYear(currentDate.getFullYear()-1)
                        newDate.setMonth(12)
                    }
                    else
                    {
                        newDate.setMonth(currentDate.getMonth()-1)
                    }
                    datePicker.currentDate = newDate
                    monthChanged()
                }
            }
        }

        Label{
            id: monthLabel
            anchors.centerIn: parent
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.textColor
            text: monthNames[currentDate.getMonth()]
        }

        Image{
            id: rightArrow
            width: Theme.itemHeightMedium
            height: width

            anchors{
                right: parent.right
                rightMargin: (Theme.itemHeightLarge-Theme.itemHeightMedium)/2
                top: parent.top
                topMargin: (Theme.itemHeightLarge-Theme.itemHeightMedium)/2
            }
            source: "image://theme/caret-right"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    var newDate = currentDate;
                    if(newDate.getMonth() == 12)
                    {
                        newDate.setFullYear(currentDate.getFullYear()+1)
                        newDate.setMonth(1)
                    }
                    else
                    {
                        newDate.setMonth(currentDate.getMonth()+1)
                    }
                    datePicker.currentDate = newDate
                    monthChanged()
                }
            }
        }
    }

    Item{
        id: weekDays
        width: parent.width
        height: width/7

        anchors{
            top: header.bottom
            topMargin: Theme.itemSpacingSmall
        }

        ListModel{
            id: weekendModel
            ListElement{
                label: qsTr("Mon")
                isWeekEnd: false
            }
            ListElement{
                label: qsTr("Tue")
                isWeekEnd: false
            }
            ListElement{
                label: qsTr("Wed")
                isWeekEnd: false
            }
            ListElement{
                label: qsTr("Thu")
                isWeekEnd: false
            }
            ListElement{
                label: qsTr("Fri")
                isWeekEnd: false
            }
            ListElement{
                label: qsTr("Sat")
                isWeekEnd: true
            }
            ListElement{
                label: qsTr("Sun")
                isWeekEnd: true
            }
        }

        ListView{
            id: weekendListView
            width: parent.width
            height: parent.height
            model: weekendModel
            orientation: ListView.Horizontal
            delegate: Item{
                height: parent.height
                width: height

                Label{
                    text: label
                    anchors.centerIn: parent
                    color: isWeekEnd ? Theme.accentColor : Theme.textColor
                    font.pixelSize: (parent.height*0.45 < Theme.fontSizeLarge) ? parent.height*0.45 : Theme.fontSizeLarge
                }
            }
        }
    }

    GridView {
        id: daysGrid
        width: parent.width
        height: width

        anchors {
            top: weekDays.bottom
            topMargin: Theme.itemSpacingSmall
        }

        cellWidth: width / 7 - 1
        cellHeight: width / 6

        model: dateModel

        delegate: Item{
            id: dayCell

            width: parent.width/7
            height: parent.height/6

            property bool isOtherMonthDay: false
            property bool isCurrentDay: false
            property bool isSelectedDay: false
            property bool hasEventDay: false

            property date dateOfDay

            function setColor(model)
            {
                var color = Theme.textColor;
                /*If weekend*/
                if(model.dateOfDay.getDay() === 0 || model.dateOfDay.getDay() === 6)
                {
                    if(model.isCurrentDay)
                    {
                        color = Theme.textColor
                    }
                    else
                    {
                        color = Theme.accentColor;
                    }
                }

                if(model.isOtherMonthDay)
                {
                    color = Theme.fillDarkColor
                }
                return color;
            }

            Rectangle{
                width: parent.width
                height: parent.height
                color: Theme.accentColor
                visible: model.isCurrentDay
            }

            Label{
                text: model.dateOfDay.getDate()
                anchors.centerIn: parent
                color: setColor(model)
                font.pixelSize: (parent.height*0.45 < Theme.fontSizeLarge) ? parent.height*0.45 : Theme.fontSizeLarge
            }


            MouseArea{
                anchors.fill: parent
                onClicked: {
                    datePicker.dateSelect(model.dateOfDay)
                }
            }
        }

        Component.onCompleted: {
            dateModel.currentDate = currentDate
            dateModel.fillModel()
        }
    }

    onMonthChanged: {
        dateModel.selectedDate = datePicker.currentDate
        dateModel.clear()
        dateModel.fillModel()
    }

    ListModel {
        id: dateModel

        signal monthChanged()

        property int firstDayOffset: 0
        property date selectedDate: new Date()
        property date currentDate: new Date()

        //public:
        function setEvent(eventDate, enable) {
            if (eventDate.getMonth() !== selectedDate.getMonth() && eventDate.getFullYear() !== selectedDate.getFullYear())
                return
            setProperty(eventDate.getDate() + firstDayOffset, "hasEventDay", enable)
        }

        function getMonthYearString() {
            return Qt.formatDate(selectedDate, "MMMM yyyy")
        }

        function changeModel(_selectedDate) {
            clear()
            selectedDate = _selectedDate

            fillModel()
            monthChanged()
        }

        function showNext() {
            showOtherMonth(selectedDate.getMonth() + 1)
        }

        function showPrevious() {
            showOtherMonth(selectedDate.getMonth() - 1)
        }

        //private:
        function fillModel() {
            firstDayOffset = getFirstDayOffset(selectedDate)
            for(var i = 0; i < 6 * 7; ++i) {
                var objectDate = selectedDate;
                objectDate.setDate(selectedDate.getDate() - (selectedDate.getDate() - 1 + firstDayOffset - i))
                appendDayObject(objectDate)
            }
        }

        function appendDayObject(dateOfDay) {
            append({
                       "dateOfDay" : dateOfDay,
                       "isCurrentDay" : dateOfDay.getDate() === currentDate.getDate() &&
                                        dateOfDay.getMonth() === currentDate.getMonth() &&
                                        dateOfDay.getFullYear() === currentDate.getFullYear(),
                       "isOtherMonthDay" : dateOfDay.getMonth() !== selectedDate.getMonth(),
                       "hasEventDay" : false
                   })
        }

        function showOtherMonth(month) {
            var newDate = selectedDate
            var currentDay = selectedDate.getDate()
            currentDay = getValidDayByMonthAndDay(month, currentDay, isLeapYear(selectedDate.getFullYear()));
            newDate.setMonth(month, currentDay)
            changeModel(newDate)
        }

        function getFirstDayOffset(currentDate) {
            var tmpDate = currentDate
            tmpDate.setDate(currentDate.getDate() - (currentDate.getDate() - 1))
            var firstDayWeekDay = tmpDate.getDay()
            if (firstDayWeekDay === 0)
                firstDayWeekDay = 6
            else
                firstDayWeekDay--
            return firstDayWeekDay
        }

        function getValidDayByMonthAndDay(month, day, leapYear) {
            if (month === 12)
                month = 0
            if (month === -1)
                month = 11

            if (month === 0 ||
                    month === 2 ||
                    month === 4 ||
                    month === 6 ||
                    month === 7 ||
                    month === 9 ||
                    month === 11)
                return day

            if (month !== 1) {
                if (day < 31)
                    return day
                return 30
            }

            if (day < 29)
                return day

            if (leapYear)
                return 29
            return 28
        }

        function isLeapYear(year) {
            if(year % 4 === 0) {
                if(year % 100 === 0) {
                    if(year % 400 === 0) {
                        return true;
                    }
                    else
                        return false;
                }
                else
                    return true;
            }
            return false;
        }
    }
}

