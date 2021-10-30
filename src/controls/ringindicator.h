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

#ifndef RINGINDICATOR_H
#define RINGINDICATOR_H

#include <QObject>
#include <QPainter>
#include <QQuickPaintedItem>

class RingIndicator : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(float startAngle READ startAngle WRITE setStartAngle NOTIFY startAngleChanged)
    Q_PROPERTY(float stopAngle READ stopAngle WRITE setStopAngle NOTIFY stopAngleChanged)
    Q_PROPERTY(float lineWidth READ lineWidth WRITE setLineWidth NOTIFY lineWidthChanged)
    Q_PROPERTY(bool rounded READ rounded WRITE setRounded NOTIFY roundedChanged)
    Q_PROPERTY(QString color READ color WRITE setColor NOTIFY colorChanged)

public:
    RingIndicator(QQuickItem *parent = nullptr);
    void paint(QPainter *painter) override;

    float startAngle() {return m_startAngle;}
    float stopAngle() {return m_stopAngle;}
    float lineWidth() {return m_lineWidth;}
    bool rounded() {return m_rounded;}
    QString color() {return m_color.name();}

    void setStartAngle(float startAngle);
    void setStopAngle(float stopAngle);
    void setLineWidth(float height);
    void setRounded(bool round);
    void setColor(QString color);

signals:
    void startAngleChanged();
    void stopAngleChanged();
    void lineWidthChanged();
    void roundedChanged();
    void colorChanged();

private:
    float m_startAngle;
    float m_stopAngle;
    float m_lineWidth;
    bool m_rounded;
    QColor m_color;

    float normalizeAngile(float ang);
};

#endif // RINGINDICATOR_H
