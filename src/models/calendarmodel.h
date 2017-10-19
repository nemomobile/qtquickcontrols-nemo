/****************************************************************************************
**
** Copyright (C) 2017 Chupligin Sergey <neochapay@gmail.com>
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

#ifndef DATELISTMODEL_H
#define DATELISTMODEL_H

#include <QAbstractListModel>
#include <QDate>

class CalendarModel : public QAbstractListModel
{
    Q_OBJECT
    struct dateItem{
        bool isOtherMonthDay;
        bool isCurrentDay;
        bool isSelectedDay;
        bool hasEventDay;
        QDate dateOfDay;
    };

    Q_PROPERTY(QDate currentDate READ currentDate)
    Q_PROPERTY(int month READ month WRITE setMonth NOTIFY monthChanged)
    Q_PROPERTY(int year READ year WRITE setYear NOTIFY yearChanged)
    Q_PROPERTY(QDate selectedDate READ selectedDate WRITE setSelectedDate NOTIFY selectedDateChanged)

public:
    explicit CalendarModel(QObject *parent = 0);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const {return m_hash;}

    void setSelectedDate(QDate date);
    void setMonth(int month);
    void setYear(int year);

    const QDate currentDate(){return m_currentDate;}
    QDate selectedDate(){return m_selectedDate;}

    int month(){return m_month;}
    int year(){return m_year;}
public slots:
    QVariant get(const int idx) const;

signals:
    void selectedDateChanged();
    void monthChanged();
    void yearChanged();

private:
    QHash<int,QByteArray> m_hash;
    QList<dateItem> m_dateList;

    void fill();

    QDate m_currentDate;
    QDate m_selectedDate;

    int m_month;
    int m_year;
};

#endif // DATELISTMODEL_H
