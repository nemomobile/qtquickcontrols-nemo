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

#include "nemoblurredimage.h"
#include "theme.h"

NemoBlurredImage::NemoBlurredImage(QQuickItem *parent)
    :QQuickPaintedItem(parent)
    , m_source("")
    , m_fillMode(FillMode::Stretch)
    , m_radius(50)
    , m_opacity(0.5)
    , m_dimColor(Qt::black)
{

}

void NemoBlurredImage::paint(QPainter *painter)
{
    QSizeF itemSize = size();
    QRectF target(0, 0, itemSize.width(), itemSize.height());
    QImage source(m_source);

    QImage blurr = makeBlurred(source, source.rect(), m_radius);
    Qt::AspectRatioMode aspectMode = Qt::IgnoreAspectRatio;

    if(m_fillMode == FillMode::PreserveAspectFit) {
        aspectMode = Qt::KeepAspectRatio;
    }

    if(m_fillMode == FillMode::PreserveAspectCrop) {
        aspectMode = Qt::KeepAspectRatioByExpanding;
    }


    blurr = blurr.scaled(QSize(itemSize.width(), itemSize.height()), aspectMode);

    painter->drawImage(blurr.rect(), blurr);

    painter->setBrush(QBrush(m_dimColor));
    painter->setOpacity(m_opacity);
    painter->drawRect(blurr.rect());
}

void NemoBlurredImage::setSource(QString path)
{
    if(path == m_source) {
        return;
    }

    QFile imgFile(path);
    if(!imgFile.exists()) {
        qWarning() << "Not exists!!!" << path;
        return;
    }

    m_source = path;
    emit sourceChanged();
    update();
}

void NemoBlurredImage::setRadius(int radius)
{
    if(radius != m_radius) {
        m_radius = radius;
        emit radiusChanged();
        update();
    }
}

void NemoBlurredImage::setOpacity(qreal opacity)
{
    if(opacity != m_opacity) {
        m_opacity = opacity;
        emit opacityChanged();
        update();
    }
}

void NemoBlurredImage::setDimColor(QColor dimColor)
{
    if(dimColor != m_dimColor) {
        m_dimColor = dimColor;
        emit dimColorChanged();
        update();
    }
}

void NemoBlurredImage::setFillMode(FillMode mode)
{
    if(mode != m_fillMode) {
        m_fillMode = mode;
        emit fillModeChanged();
        update();
    }
}

QImage NemoBlurredImage::makeBlurred(QImage& image, const QRect& rect, int radius, bool alphaOnly)
{
    int tab[] = { 14, 10, 8, 6, 5, 5, 4, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2 };
    int alpha = (radius < 1)  ? 16 : (radius > 17) ? 1 : tab[radius-1];

    QImage result = image.convertToFormat(QImage::Format_ARGB32_Premultiplied);
    int r1 = rect.top();
    int r2 = rect.bottom();
    int c1 = rect.left();
    int c2 = rect.right();

    int bpl = result.bytesPerLine();
    int rgba[4];
    unsigned char* p;

    int i1 = 0;
    int i2 = 3;

    if (alphaOnly) {
        i1 = i2 = (QSysInfo::ByteOrder == QSysInfo::BigEndian ? 0 : 3);
    }

    for (int col = c1; col <= c2; col++) {
        p = result.scanLine(r1) + col * 4;
        for (int i = i1; i <= i2; i++)
            rgba[i] = p[i] << 4;

        p += bpl;
        for (int j = r1; j < r2; j++, p += bpl)
            for (int i = i1; i <= i2; i++)
                p[i] = (rgba[i] += ((p[i] << 4) - rgba[i]) * alpha / 16) >> 4;
    }

    for (int row = r1; row <= r2; row++) {
        p = result.scanLine(row) + c1 * 4;
        for (int i = i1; i <= i2; i++)
            rgba[i] = p[i] << 4;

        p += 4;
        for (int j = c1; j < c2; j++, p += 4)
            for (int i = i1; i <= i2; i++)
                p[i] = (rgba[i] += ((p[i] << 4) - rgba[i]) * alpha / 16) >> 4;
    }

    for (int col = c1; col <= c2; col++) {
        p = result.scanLine(r2) + col * 4;
        for (int i = i1; i <= i2; i++)
            rgba[i] = p[i] << 4;

        p -= bpl;
        for (int j = r1; j < r2; j++, p -= bpl)
            for (int i = i1; i <= i2; i++)
                p[i] = (rgba[i] += ((p[i] << 4) - rgba[i]) * alpha / 16) >> 4;
    }

    for (int row = r1; row <= r2; row++) {
        p = result.scanLine(row) + c2 * 4;
        for (int i = i1; i <= i2; i++)
            rgba[i] = p[i] << 4;

        p -= 4;
        for (int j = c1; j < c2; j++, p -= 4)
            for (int i = i1; i <= i2; i++)
                p[i] = (rgba[i] += ((p[i] << 4) - rgba[i]) * alpha / 16) >> 4;
    }

    return result;
}
