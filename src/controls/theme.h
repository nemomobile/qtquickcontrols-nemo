#ifndef THEME_He5
#define THEME_H

#include <QObject>

class Theme : public QObject
{
    Q_OBJECT

    Q_PROPERTY(qreal itemWidthLarge READ itemWidthLarge NOTIFY itemWidthLargeChanged)
    Q_PROPERTY(qreal itemWidthMedium READ itemWidthMedium NOTIFY itemWidthMediumChanged)
    Q_PROPERTY(qreal itemWidthSmall READ itemWidthSmall NOTIFY itemWidthSmallChanged)

    Q_PROPERTY(qreal itemHeightHuge READ itemHeightHuge NOTIFY itemHeightHugeChanged)
    Q_PROPERTY(qreal itemHeightExtraLarge READ itemHeightExtraLarge NOTIFY itemHeightExtraLargeChanged)
    Q_PROPERTY(qreal itemHeightLarge READ itemHeightLarge NOTIFY itemHeightLargeChanged)
    Q_PROPERTY(qreal itemHeightMedium READ itemHeightMedium NOTIFY itemHeightMediumChanged)
    Q_PROPERTY(qreal itemHeightSmall READ itemHeightSmall NOTIFY itemHeightSmallChanged)
    Q_PROPERTY(qreal itemHeightExtraSmall READ itemHeightExtraSmall NOTIFY itemHeightExtraSmallChanged)

    Q_PROPERTY(qreal itemSpacingHuge READ itemSpacingHuge NOTIFY itemSpacingHugeChanged)
    Q_PROPERTY(qreal itemSpacingLarge READ itemSpacingLarge NOTIFY itemSpacingLargeChanged)
    Q_PROPERTY(qreal itemSpacingMedium READ itemSpacingMedium NOTIFY itemSpacingMediumChanged)
    Q_PROPERTY(qreal itemSpacingSmall READ itemSpacingSmall NOTIFY itemSpacingSmallChanged)
    Q_PROPERTY(qreal itemExtraSmall READ itemExtraSmall NOTIFY itemExtraSmallChanged)

    Q_PROPERTY(int fontSizeExtraLarge READ fontSizeExtraLarge NOTIFY fontSizeExtraLargeChanged)
    Q_PROPERTY(int fontSizeLarge READ fontSizeLarge NOTIFY fontSizeLargeChanged)
    Q_PROPERTY(int fontSizeMedium READ fontSizeMedium NOTIFY fontSizeMediumChanged)
    Q_PROPERTY(int fontSizeSmall READ fontSizeSmall NOTIFY fontSizeSmallChanged)
    Q_PROPERTY(int fontSizeTiny READ fontSizeTiny NOTIFY fontSizeTinyChanged)
    Q_PROPERTY(int fontWeightLarge READ fontWeightLarge NOTIFY fontWeightLargeChanged)
    Q_PROPERTY(int fontWeightMedium READ fontWeightMedium NOTIFY fontWeightMediumChanged)

    Q_PROPERTY(QString fontFamily READ fontFamily NOTIFY fontFamilyChanged)

    Q_PROPERTY(QString accentColor READ accentColor NOTIFY accentColorChanged)
    Q_PROPERTY(QString fillColor READ fillColor NOTIFY fillColorChanged)
    Q_PROPERTY(QString fillDarkColor READ fillDarkColor NOTIFY fillDarkColorChanged)
    Q_PROPERTY(QString textColor READ textColor NOTIFY textColorChanged)
    Q_PROPERTY(QString backgroundColor READ backgroundColor NOTIFY backgroundColorChanged)
    Q_PROPERTY(QString backgroundAccentColor READ backgroundAccentColor NOTIFY backgroundAccentColorChanged)

public:
    explicit Theme(QObject *parent = 0);

    bool loadTheme(QString name);
    qreal itemWidthLarge(){return m_itemWidthLarge;}
    qreal itemWidthMedium(){return m_itemWidthMedium;}
    qreal itemWidthSmall(){return m_itemWidthSmall;}

    qreal itemHeightHuge(){return m_itemHeightHuge;}
    qreal itemHeightExtraLarge(){return m_itemHeightExtraLarge;}
    qreal itemHeightLarge(){return m_itemHeightLarge;}
    qreal itemHeightMedium(){return m_itemHeightMedium;}
    qreal itemHeightSmall(){return m_itemHeightSmall;}
    qreal itemHeightExtraSmall(){return m_itemHeightExtraSmall;}

    qreal itemSpacingHuge(){return m_itemSpacingHuge;}
    qreal itemSpacingLarge(){return m_itemSpacingLarge;}
    qreal itemSpacingMedium(){return m_itemSpacingMedium;}
    qreal itemSpacingSmall(){return m_itemSpacingSmall;}
    qreal itemExtraSmall(){return m_itemExtraSmall;}

    int fontSizeExtraLarge(){return m_fontSizeExtraLarge;}
    int fontSizeLarge(){return m_fontSizeLarge;}
    int fontSizeMedium(){return m_fontSizeMedium;}
    int fontSizeSmall(){return m_fontSizeSmall;}
    int fontSizeTiny(){return m_fontSizeTiny;}
    int fontWeightLarge(){return m_fontWeightLarge;}
    int fontWeightMedium(){return m_fontWeightMedium;}

    QString fontFamily(){return m_fontFamily;}

    QString accentColor(){return m_accentColor;}
    QString fillColor(){return m_fillColor;}
    QString fillDarkColor(){return m_fillDarkColor;}
    QString textColor(){return m_textColor;}
    QString backgroundColor(){return m_backgroundColor;}
    QString backgroundAccentColor(){return m_backgroundAccentColor;}

signals:
    void themeUpdate();

    void itemWidthLargeChanged();
    void itemWidthMediumChanged();
    void itemWidthSmallChanged();

    void itemHeightHugeChanged();
    void itemHeightExtraLargeChanged();
    void itemHeightLargeChanged();
    void itemHeightMediumChanged();
    void itemHeightSmallChanged();
    void itemHeightExtraSmallChanged();

    void itemSpacingHugeChanged();
    void itemSpacingLargeChanged();
    void itemSpacingMediumChanged();
    void itemSpacingSmallChanged();
    void itemExtraSmallChanged();

    void fontSizeExtraLargeChanged();
    void fontSizeLargeChanged();
    void fontSizeMediumChanged();
    void fontSizeSmallChanged();
    void fontSizeTinyChanged();
    void fontWeightLargeChanged();
    void fontWeightMediumChanged();
    void fontFamilyChanged();

    void accentColorChanged();
    void fillColorChanged();
    void fillDarkColorChanged();
    void textColorChanged();
    void backgroundColorChanged();
    void backgroundAccentColorChanged();

public slots:

private:
    qreal m_itemWidthLarge;        //320
    qreal m_itemWidthMedium;       //240
    qreal m_itemWidthSmall;        //120

    qreal m_itemHeightHuge;        //80
    qreal m_itemHeightExtraLarge;  //75
    qreal m_itemHeightLarge;       //63
    qreal m_itemHeightMedium;      //50
    qreal m_itemHeightSmall;       //40
    qreal m_itemHeightExtraSmall;  //32

    qreal m_itemSpacingHuge;        //40
    qreal m_itemSpacingLarge;       //20
    qreal m_itemSpacingMedium;      //15
    qreal m_itemSpacingSmall;       //10
    qreal m_itemExtraSmall;         //8

    int m_fontSizeExtraLarge;     //30
    int m_fontSizeLarge;          //24
    int m_fontSizeMedium;         //20
    int m_fontSizeSmall;          //18
    int m_fontSizeTiny;           //16
    int m_fontWeightLarge;        //63
    int m_fontWeightMedium;       //25
    QString m_fontFamily;         //???

    QString m_accentColor;            //#0091e5
    QString m_fillColor;              //#474747
    QString m_fillDarkColor;          //#313131
    QString m_textColor;              //#ffffff
    QString m_backgroundColor;        //#000000
    QString m_backgroundAccentColor;  //#ffffff

    qreal m_dp;
};

#endif // THEME_H
