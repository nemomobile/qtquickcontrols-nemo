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

#include "nemofocussingleton.h"

void NemoFocusSingleton::nemoregister(QObject *edit)
{
    m_edit = edit;
}
NemoFocusSingleton *NemoFocusSingleton::instance() {
    static NemoFocusSingleton * _instance = 0;
    if ( _instance == 0 ) {
        _instance = new NemoFocusSingleton();
    }
    return _instance;
}

QObject *NemoFocusSingleton::edit() const
{
    return m_edit;
}
