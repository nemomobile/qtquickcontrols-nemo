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

#include "nemowindow.h"
#include <QDebug>
NemoWindow::NemoWindow(QWindow *parent) :
    QQuickWindow(parent)
{
}

Qt::ScreenOrientations NemoWindow::allowedOrientations() const {
    return m_allowedOrientations;
}

void NemoWindow::setAllowedOrientations(Qt::ScreenOrientations allowed) {

    //This way no invalid values can get assigned to allowedOrientations
    //README: This is needed because otherwise you could assign it
    //things like (Qt.PortraitOrientation | 444) from QML
    Qt::ScreenOrientations max = (Qt::PortraitOrientation | Qt::LandscapeOrientation
            | Qt::InvertedPortraitOrientation | Qt::InvertedLandscapeOrientation);

    if (m_allowedOrientations != allowed && allowed <= max) {
        m_allowedOrientations = allowed;
        emit allowedOrientationsChanged();
    }
}
