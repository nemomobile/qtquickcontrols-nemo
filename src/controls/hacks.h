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

#ifndef HACKS_H
#define HACKS_H

#include <QObject>
#include <QQmlEngine>

// NEMOHACKS
// A UTILITY CLASS WHICH EXPOSES HACKS TO QML via NemoHacks identifier
// IT WILL BE USEFUL WHILE DEVELOPING COMPONENTS

class Hacks : public QObject
{
    Q_OBJECT
public:
    explicit Hacks(QQmlEngine* engine, QObject *parent = 0);
    
signals:
    
public slots:

private:
    QQmlEngine* m_engine;
};

#endif // HACKS_H
