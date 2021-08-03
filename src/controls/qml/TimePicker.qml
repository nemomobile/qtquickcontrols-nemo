/****************************************************************************************
**
** Copyright (C) 2018-2021 Chupligin Sergey <neochapay@gmail.com>
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

Item{
    id: timePicker
    width: 400
    height: width

    property date currentTime: new Date()

    property bool readOnly: true

    Item{
        id: clockWidget
        width: parent.width
        height: parent.width

        RingIndicator{
            id: hours12
            anchors.centerIn: parent

            width: parent.width - Theme.itemHeightExtraSmall
            height: parent.height - Theme.itemHeightExtraSmall

            startAngle: 0
            stopAngle: 360

            lineWidth: Theme.itemHeightExtraSmall/2
            color: Theme.accentColor
            opacity: 0.5
            visible: currentTime.getHours() >= 12
        }

        RingIndicator{
            id: hours
            anchors.centerIn: parent

            width: parent.width - Theme.itemHeightExtraSmall
            height: parent.height - Theme.itemHeightExtraSmall

            startAngle: 0
            stopAngle: 360/12*currentTime.getHours()

            lineWidth: Theme.itemHeightExtraSmall/2
            color: Theme.accentColor

            Label{
                id: hourLabel
                text: currentTime.getHours()
                font.pixelSize: hours.lineWidth
                font.bold: true

                anchors{
                    top: hours.top
                    topMargin: -hours.lineWidth/4
                    right: hours.horizontalCenter
                    rightMargin: hours.lineWidth/4
                }
            }
        }

        RingIndicator{
            id: minutes
            anchors.centerIn: parent

            width: parent.width
            height: parent.height

            startAngle: 0
            stopAngle: 360/60*currentTime.getMinutes()

            lineWidth: Theme.itemHeightExtraSmall/5
            color: Theme.accentColor

            Label{
                id: minuteLabel
                text: currentTime.getMinutes()
                font.pixelSize: minutes.lineWidth
                font.bold: true

                anchors{
                    top: minutes.top
                    topMargin: -minutes.lineWidth/4
                    right: minutes.horizontalCenter
                    rightMargin: minutes.lineWidth/4
                }
            }
        }
    }

    MouseArea{
        anchors.fill: parent
        onPressed: {
            if(readOnly)
            {
                return;
            }

            var minute_rad_max = clockWidget.width/2
            var minute_rad_min = clockWidget.width/2-Theme.itemHeightExtraSmall/5;

            var hour_rad_max = (clockWidget.width-Theme.itemHeightExtraSmall)/2
            var hour_rad_min = (clockWidget.width-Theme.itemHeightExtraSmall)/2-Theme.itemHeightExtraSmall/2

            var clickRad = Math.sqrt(Math.pow((mouseX-clockWidget.width/2),2)+Math.pow((mouseY-clockWidget.width/2),2))

            if(clickRad <= minute_rad_max && clickRad >= hour_rad_min)
            {
                var ang = getAngle(mouseX,mouseY)
                var d = new Date(currentTime);
                if(clickRad>=minute_rad_min)
                {
                    currentTime =  new Date(d.setMinutes(Math.round(60*ang/360)))
                }
                else if(clickRad <= hour_rad_max && clickRad >= hour_rad_min)
                {
                    if(currentTime.getHours() >= 12)
                    {
                        currentTime =  new Date(d.setHours(Math.round(12*ang/360)+12))
                    }
                    else
                    {
                        currentTime =  new Date(d.setHours(Math.round(12*ang/360)))
                    }
                }
            }
        }
    }

    function getMinuteAngle()
    {
        var minute = timePicker.minutes
        return 2*Math.PI/60*minute-0.5*Math.PI
    }

    function getAngle(x,y)
    {
        var a = (Math.atan((y - clockWidget.width/2)/(x - clockWidget.width/2)) * 180) / Math.PI + 90
        if (x < clockWidget.width/2)
        {
            a += 180
        }
        return a
    }
}
