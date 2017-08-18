#ifndef SIZING_H
#define SIZING_H

#include <QObject>

#if QT_VERSION < QT_VERSION_CHECK(5,6,0)
#ifndef Q_ENUM
#define Q_ENUM(x) Q_ENUMS(x)
#endif
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
#if QT_VERSION < QT_VERSION_CHECK(5,6,0)
    Q_ENUM(Densities)
#else
    Q_ENUMS(Densities)
#endif
    bool isValid(){return m_valid;}

    float getMmScaleFactor(){return m_mm_factor;}
    float getDpScaleFactor(){return m_dp_factor;}

    int getLauncherIconSize(){return m_launcher_icon_size;}

    Densitie getDensitie();

    Q_INVOKABLE float mm(float value);
    Q_INVOKABLE float dp(float value);

    Q_INVOKABLE void setMmScaleFactor(float value);
    Q_INVOKABLE void setDpScaleFactor(float value);

private:
    bool m_valid;

    int m_p_width;
    int m_p_height;

    int m_width;
    int m_height;

    int m_launcher_icon_size;

    float m_mm_factor;
    float m_dp_factor;

    qreal m_dpi;

    Densitie m_densitie;

    void setMmScaleFactor();
    void setDpScaleFactor();

};

#endif // SIZING_H
