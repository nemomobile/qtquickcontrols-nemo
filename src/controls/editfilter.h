/*
 * Copyright (C) 2017 Eetu Kahelin
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
#ifndef EDITFILTER_H
#define EDITFILTER_H

#include <QObject>
#include <QEvent>
#include <QString>
#include <QVariant>
#include "nemofocussingleton.h"

class EditFilter : public QObject
{
    Q_OBJECT
public:
     explicit EditFilter(QObject *parent = 0);
protected:
    bool eventFilter(QObject *obj, QEvent *event);
};
#endif // EDITFILTER_H
