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
#include "hacks.h"

NemoWindow::NemoWindow(QWindow *parent) :
    QQuickWindow(parent),
    m_defaultAllowedOrientations(Qt::PortraitOrientation | Qt::LandscapeOrientation)
{
    m_allowedOrientations = m_defaultAllowedOrientations;
    m_filter = new EditFilter();
    this->installEventFilter(m_filter);
}

Qt::ScreenOrientations NemoWindow::allowedOrientations() const
{
    return m_allowedOrientations;
}

const Qt::ScreenOrientations NemoWindow::defaultAllowedOrientations() const
{
    return m_defaultAllowedOrientations;
}

void NemoWindow::setAllowedOrientations(Qt::ScreenOrientations allowed)
{
    //This way no invalid values can get assigned to allowedOrientations
    if (m_allowedOrientations != allowed) {
        if (Hacks::isOrientationMaskValid(allowed)) {
            m_allowedOrientations = allowed;
            emit allowedOrientationsChanged();
        } else {
            qDebug() << "NemoWindow: invalid allowedOrientation!";
        }
    }
}
