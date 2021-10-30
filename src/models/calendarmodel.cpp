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

#include "calendarmodel.h"

CalendarModel::CalendarModel(QObject *parent) :
    QAbstractListModel(parent)
{

    m_hash.insert(Qt::UserRole ,QByteArray("isOtherMonthDay"));
    m_hash.insert(Qt::UserRole+1 ,QByteArray("isCurrentDay"));
    m_hash.insert(Qt::UserRole+2 ,QByteArray("isSelectedDay"));
    m_hash.insert(Qt::UserRole+3 ,QByteArray("hasEventDay"));
    m_hash.insert(Qt::UserRole+4 ,QByteArray("dateOfDay"));

    m_currentDate = QDate::currentDate();
    m_selectedDate = m_currentDate;

    fill();
}

int CalendarModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_dateList.count();
}

QVariant CalendarModel::data(const QModelIndex &index, int role) const
{
    Q_UNUSED(role);
    if(!index.isValid())
    {
        return QVariant();
    }

    if(index.row() >= m_dateList.size())
    {
        return QVariant();
    }

    DateItem item = m_dateList.at(index.row());
    switch (role)
    {
    case Qt::UserRole:
        return item.isOtherMonthDay;
    case Qt::UserRole+1:
        return item.isCurrentDay;
    case Qt::UserRole+2:
        return item.isSelectedDay;
    case Qt::UserRole+3:
        return item.hasEventDay;
    case Qt::UserRole+4:
        return item.dateOfDay;
    default:
        return QVariant();
    }
}

QVariant CalendarModel::get(const int idx) const
{
    if(idx >= m_dateList.size())
    {
        return QVariant();
    }

    QMap<QString, QVariant> itemData;
    DateItem item = m_dateList.at(idx);

    itemData.insert("isOtherMonthDay",item.isOtherMonthDay);
    itemData.insert("isCurrentDay",item.isCurrentDay);
    itemData.insert("isSelectedDay",item.isSelectedDay);
    itemData.insert("hasEventDay",item.hasEventDay);
    itemData.insert("dateOfDay",item.dateOfDay);

    return QVariant(itemData);
}

void CalendarModel::setSelectedDate(QDate date)
{
    if(m_selectedDate != date)
    {
        m_selectedDate = date;
        emit selectedDateChanged();

        fill();
    }
}

void CalendarModel::fill()
{
    m_dateList.clear();

    QDate firstDayOfSelectedMonth = QDate(m_selectedDate.year(),m_selectedDate.month(),1);
    int startWeekDay = firstDayOfSelectedMonth.dayOfWeek();

    /*If first dayof moth not Monday add form preview month*/
    if(startWeekDay != 1)
    {
        int needToAdd = 1-startWeekDay;
        for(int n=needToAdd; n<0; n++)
        {
            m_dateList.append(createDateItem(firstDayOfSelectedMonth.addDays(n),true));
        }
    }

    for(int n=0; n < firstDayOfSelectedMonth.daysInMonth();n++)
    {
        QDate date = firstDayOfSelectedMonth.addDays(n);
        m_dateList.append(createDateItem(date,false,date == m_currentDate));
    }
    /*if last day of moth not Sunday add from next mont*/
    QDate lastDayOfSelectedMonth = QDate(m_selectedDate.year(),m_selectedDate.month(),firstDayOfSelectedMonth.daysInMonth());
    int endWeekDay = lastDayOfSelectedMonth.dayOfWeek();
    if(endWeekDay != 7)
    {
        int needToAdd = 7-endWeekDay;
        for(int n=1;n<=needToAdd;n++)
        {
            m_dateList.append(createDateItem(lastDayOfSelectedMonth.addDays(n),true));
        }
    }
    dataChanged(createIndex(0, 0), createIndex(rowCount()-1, 0));
}

CalendarModel::DateItem CalendarModel::createDateItem(QDate dateOfDay, bool isOtherMonthDay, bool isCurrentDay, bool isSelectedDay, bool hasEventDay)
{
    DateItem dateItem;
    dateItem.dateOfDay =  dateOfDay;
    dateItem.hasEventDay = hasEventDay;
    dateItem.isCurrentDay = isCurrentDay;
    dateItem.isOtherMonthDay = isOtherMonthDay;
    dateItem.isSelectedDay = isSelectedDay;

    return dateItem;
}
