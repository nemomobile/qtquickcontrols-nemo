#ifndef SIZING_H
#define SIZING_H

#include <QObject>

#ifndef Q_ENUM
#define Q_ENUM(x) Q_ENUMS(x)
#endif

class Sizing : public QObject
{
    Q_OBJECT
public:
    explicit Sizing(QObject *parent = 0);

    enum Densitie{
        ldpi,
        mdpi,
        hdpi,
        xhdpi,
        xxhdpi,
        xxxhdpi
    };
    Q_ENUM(Densities)

    bool isValid(){return m_valid;}

    float getMmScaleFactor(){return m_mm_factor;}
    float getDpScaleFactor(){return m_dp_factor;}

    Densitie getDensitie();

    Q_INVOKABLE float mm(float value);
    Q_INVOKABLE float dp(float value);

private:
    bool m_valid;

    int m_p_width;
    int m_p_height;

    int m_width;
    int m_height;

    float m_mm_factor;
    float m_dp_factor;

    qreal m_dpi;

    Densitie m_densitie;

    void setMmScaleFactor();
    void setDpScaleFactor();

};

#endif // SIZING_H