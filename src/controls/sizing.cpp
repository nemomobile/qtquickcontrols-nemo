#include "sizing.h"

#include <QScreen>
#include <QDebug>
#include <QGuiApplication>

Sizing::Sizing(QObject *parent) : QObject(parent)
{
    m_valid = false;
    m_scale_factor = 10;

    m_p_height = qgetenv("QT_QPA_EGLFS_PHYSICAL_HEIGHT").toInt();
    m_p_width = qgetenv("QT_QPA_EGLFS_PHYSICAL_WIDTH").toInt();

    QScreen *screen = QGuiApplication::primaryScreen();

    m_height = screen->size().height();
    m_width = screen->size().width();

    if(m_p_height > 0 && m_p_width >0){
        m_valid = true;
        scaleFactor();
    }else{
        if(m_p_height == 0){
            qWarning("QT_QPA_EGLFS_PHYSICAL_HEIGHT is not set!");
        }

        if(m_p_width == 0){
            qWarning("QT_QPA_EGLFS_PHYSICAL_WIDTH is not set!");
        }

        qWarning("Device sizing don`t work");
    }
}

void Sizing::scaleFactor()
{
    if(m_p_width != 0){
        m_scale_factor = m_width/m_p_width;
    }

    qDebug() << "Scale factor is " << m_scale_factor;
}


