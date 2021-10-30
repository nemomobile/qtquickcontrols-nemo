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

#ifndef NEMOBLURREDIMAGE_H
#define NEMOBLURREDIMAGE_H

#include <QQuickPaintedItem>
#include <QPainter>

class NemoBlurredImage: public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(int radius READ radius WRITE setRadius NOTIFY radiusChanged)
    Q_PROPERTY(qreal opacity READ opacity WRITE setOpacity NOTIFY opacityChanged)
    Q_PROPERTY(QColor dimColor READ dimColor WRITE setDimColor NOTIFY dimColorChanged)
    Q_PROPERTY(FillMode fillMode READ fillMode WRITE setFillMode NOTIFY fillModeChanged)

public:
    enum class FillMode{
        Stretch,
        PreserveAspectFit,
        PreserveAspectCrop
    };

    Q_ENUMS(FillMode);

    explicit NemoBlurredImage(QQuickItem *parent = 0);
    void paint(QPainter *painter);
    QString source() {return m_source;}
    void setSource(QString path);

    int radius() {return m_radius;}
    void setRadius(int radius);

    qreal opacity() {return m_opacity;}
    void setOpacity(qreal opacity);

    QColor dimColor() {return m_dimColor;}
    void setDimColor(QColor dimColor);

    FillMode fillMode() {return m_fillMode;}
    void setFillMode(FillMode mode);

signals:
    void sourceChanged();
    void radiusChanged();
    void opacityChanged();
    void dimColorChanged();
    void fillModeChanged();

private:
    QImage makeBlurred(QImage &image, const QRect& rect, int radius, bool alphaOnly = false);
    QString m_source;
    FillMode m_fillMode;
    int m_radius;
    qreal m_opacity;
    QColor m_dimColor;
};

#endif // NEMOBLURREDIMAGE_H
