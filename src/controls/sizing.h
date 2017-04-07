#ifndef SIZING_H
#define SIZING_H

#include <QObject>

class Sizing : public QObject
{
    Q_OBJECT
public:
    explicit Sizing(QObject *parent = 0);
    bool isValid(){return m_valid;}
    int getScaleFactor(){return m_scale_factor;}

private:
    bool m_valid;

    int m_p_width;
    int m_p_height;
    int m_width;
    int m_height;

    int m_scale_factor;

    void scaleFactor();
};

#endif // SIZING_H
