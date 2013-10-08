/*
 * Copyright (C) 2013 Lucien Xu <sfietkonstantin@free.fr>
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

// This class is autogenerated using themehelper.py
// Any modification done in this file will be overridden

#ifndef NEMOTHEME_H
#define NEMOTHEME_H

#include <QtCore/QObject>
#include <QtCore/QString>
#include "nemothemebutton.h"
#include "nemothemegroove.h"
#include "nemothemetextfield.h"

class NemoTheme: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(QString description READ description NOTIFY descriptionChanged)
    Q_PROPERTY(NemoThemeButton * button READ button CONSTANT)
    Q_PROPERTY(NemoThemeButton * primaryButton READ primaryButton CONSTANT)
    Q_PROPERTY(NemoThemeGroove * groove READ groove CONSTANT)
    Q_PROPERTY(NemoThemeTextField * textField READ textField CONSTANT)
    Q_PROPERTY(QString fontFamily READ fontFamily CONSTANT)
public:
    explicit NemoTheme(QObject *parent = 0);
    QString name() const;
    void setName(const QString &name);
    QString description() const;
    void setDescription(const QString &description);
    NemoThemeButton * button() const;
    NemoThemeButton * primaryButton() const;
    NemoThemeGroove * groove() const;
    NemoThemeTextField * textField() const;
    QString fontFamily() const;
public Q_SLOTS:
    void loadFromFile(const QString &fileName);
Q_SIGNALS:
    void nameChanged();
    void descriptionChanged();
private:
    QString m_name;
    QString m_description;
    NemoThemeButton * m_button;
    NemoThemeButton * m_primaryButton;
    NemoThemeGroove * m_groove;
    NemoThemeTextField * m_textField;
    QString m_fontFamily;
};

#endif //NEMOTHEME_H