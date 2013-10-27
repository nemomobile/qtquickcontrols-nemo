#ifndef NEMOWINDOW_H
#define NEMOWINDOW_H

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

#include <QQuickWindow>
#include <QtCore/qnamespace.h>
class NemoWindow : public QQuickWindow
{
    Q_OBJECT
    Q_PROPERTY(Qt::ScreenOrientations allowedOrientations READ allowedOrientations WRITE setAllowedOrientations NOTIFY allowedOrientationsChanged)
public:
    explicit NemoWindow(QWindow *parent = 0);
    
    Qt::ScreenOrientations allowedOrientations() const;
    void setAllowedOrientations(Qt::ScreenOrientations allowed);

signals:
    void allowedOrientationsChanged();

public slots:

private:
    Qt::ScreenOrientations m_allowedOrientations;
};

#endif // NEMOWINDOW_H
