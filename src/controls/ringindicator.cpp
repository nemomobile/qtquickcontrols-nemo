/****************************************************************************************
**
** Copyright (C) 2021 Chupligin Sergey <neochapay@gmail.com>
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

#include "ringindicator.h"

RingIndicator::RingIndicator(QQuickItem *parent)
    : QQuickPaintedItem(parent)
    , m_startAngle(0)
    , m_stopAngle(90)
    , m_lineWidth(1)
    , m_rounded(false)
    , m_color(Qt::white)
{
}

void RingIndicator::paint(QPainter *painter)
{
    QSizeF itemSize = size();
    Qt::PenCapStyle startStyle = Qt::FlatCap;
    if(m_rounded) {
        startStyle = Qt::RoundCap;
    }


    QPen pen(m_color, m_lineWidth, Qt::SolidLine, startStyle , Qt::BevelJoin);
    QRect painedRect(0+m_lineWidth/2,
                     0+m_lineWidth/2,
                     itemSize.width()-m_lineWidth,
                     itemSize.height()-m_lineWidth);

    painter->setPen(pen);
    painter->setRenderHint(QPainter::Antialiasing);

    painter->drawArc(painedRect,(90-m_startAngle)*16,(m_startAngle-m_stopAngle)*16);
}


void RingIndicator::setStartAngle(float startAngle)
{
    startAngle = normalizeAngile(startAngle);

    if(startAngle != m_startAngle) {
        m_startAngle = startAngle;
        emit startAngleChanged();
        update();
    }
}

void RingIndicator::setStopAngle(float stopAngle)
{
    stopAngle = normalizeAngile(stopAngle);

    if(stopAngle != m_stopAngle) {
        m_stopAngle = stopAngle;
        emit stopAngleChanged();
        update();
    }
}

void RingIndicator::setLineWidth(float lineHeight)
{
    if(lineHeight >= 0 && lineHeight != m_lineWidth) {
        m_lineWidth = lineHeight;
        emit lineWidthChanged();
        update();
    }
}

void RingIndicator::setRounded(bool round)
{
    if(round != m_rounded) {
        m_rounded = round;
        emit roundedChanged();
        update();
    }
}


void RingIndicator::setColor(QString color)
{
    QColor newColor(color);
    if(newColor != m_color) {
        m_color = newColor;
        emit colorChanged();
        update();
    }
}

float RingIndicator::normalizeAngile(float ang)
{
    if(ang > 360) {
        int circles = (int)(ang/360);
        ang = ang-360*circles;
    }

    if(ang < 0) {
        int circles = (int)(ang/360);
        ang = ang+360*circles;
    }

    return abs(ang);
}
