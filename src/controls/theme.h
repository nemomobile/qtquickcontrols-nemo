#ifndef THEME_He5
#define THEME_H

#include <QObject>

class Theme : public QObject
{
    Q_OBJECT

public:
    explicit Theme(QObject *parent = 0);

    bool loadTheme(QString name);

    qreal itemWidthLarge;        //320
    qreal itemWidthMedium;       //240
    qreal itemWidthSmall;        //120

    qreal itemHeightHuge;        //80
    qreal itemHeightExtraLarge;  //75
    qreal itemHeightLarge;       //63
    qreal itemHeightMedium;      //50
    qreal itemHeightSmall;       //40

    qreal itemSpacingHuge;        //40
    qreal itemSpacingLarge;       //20
    qreal itemSpacingMedium;      //15
    qreal itemSpacingSmall;       //10
    qreal itemExtraSmall;         //8

    int fontSizeExtraLarge;     //30
    int fontSizeLarge;          //24
    int fontSizeMedium;         //20
    int fontSizeSmall;          //18
    int fontSizeTiny;           //16

    QString accentColor;        //#0091e5
    QString fillColor;          //#474747
    QString fillDarkColor;      //#313131
    QString textColor;          //#ffffff
    QString backgroundColor;    //#000000

signals:
    void themeUpdate();

public slots:
};

#endif // THEME_H
