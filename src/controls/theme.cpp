#include "theme.h"
#include "sizing.h"

#include <QFile>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>

Theme::Theme(QObject *parent) : QObject(parent)
{
    Sizing *size = new Sizing;
    m_dp = size->getDpScaleFactor();
    m_iconSizeLauncher = size->getLauncherIconSize();
    //Load defaults
    m_itemWidthLarge = 320*m_dp;
    m_itemWidthMedium = 240*m_dp;
    m_itemWidthSmall = 120*m_dp;
    m_itemWidthExtraSmall = 72*m_dp;

    m_itemHeightHuge = 80*m_dp;
    m_itemHeightExtraLarge = 75*m_dp;
    m_itemHeightLarge = 63*m_dp;
    m_itemHeightMedium = 50*m_dp;
    m_itemHeightSmall = 40*m_dp;
    m_itemHeightExtraSmall = 32*m_dp;

    m_itemSpacingHuge = 40*m_dp;
    m_itemSpacingLarge = 20*m_dp;
    m_itemSpacingMedium = 15*m_dp;
    m_itemSpacingSmall = 10*m_dp;
    m_itemSpacingExtraSmall = 8*m_dp;

    m_fontSizeExtraLarge = 30*m_dp;
    m_fontSizeLarge = 24*m_dp;
    m_fontSizeMedium = 20*m_dp;
    m_fontSizeSmall = 18*m_dp;
    m_fontSizeTiny = 16*m_dp;
    m_fontWeightLarge = 63*m_dp;
    m_fontWeightMedium = 25*m_dp;
    m_fontFamily = "/usr/share/fonts/google-opensans/OpenSans-Regular.ttf";

    m_accentColor = "#0091e5";
    m_fillColor = "#474747";
    m_fillDarkColor = "#313131";
    m_textColor = "#ffffff";
    m_backgroundColor = "#000000";
    m_backgroundAccentColor = "#ffffff";
}

bool Theme::loadTheme(QString fileName)
{
    QString themeJsonString;

    bool updated = false;

    QFile themeFile;
    themeFile.setFileName(fileName);
    if(!themeFile.exists())
    {
        qDebug() << "Theme file " << fileName << " not found";
        return false;
    }

    themeFile.open(QIODevice::ReadOnly | QIODevice::Text);
    themeJsonString = themeFile.readAll();
    themeFile.close();

    QJsonDocument t = QJsonDocument::fromJson(themeJsonString.toUtf8());
    QJsonObject theme = t.object();

    if(theme.value("iconSizeLauncher").toString().toFloat() != 0 &&
            theme.value("iconSizeLauncher").toString().toFloat() != m_iconSizeLauncher)
    {
        m_iconSizeLauncher = theme.value("iconSizeLauncher").toString().toFloat();
        emit iconSizeLauncherChanged();
        updated = true;
    }

    if(theme.value("itemWidthLarge").toString().toFloat() != 0 &&
            theme.value("itemWidthLarge").toString().toFloat() != m_itemWidthLarge)
    {
        m_itemWidthLarge = theme.value("itemWidthLarge").toString().toFloat()*m_dp;
        emit itemWidthLargeChanged();
        updated = true;
    }
    if(theme.value("itemWidthMedium").toString().toFloat() != 0 &&
            theme.value("itemWidthMedium").toString().toFloat() != m_itemWidthMedium)
    {
        m_itemWidthMedium = theme.value("itemWidthMedium").toString().toFloat()*m_dp;
        emit itemWidthMediumChanged();
        updated = true;
    }
    if(theme.value("itemWidthSmall").toString().toFloat() != 0 &&
            theme.value("itemWidthSmall").toString().toFloat() != m_itemWidthSmall)
    {
        m_itemWidthSmall = theme.value("itemWidthSmall").toString().toFloat()*m_dp;
        emit itemWidthSmallChanged();
        updated = true;
    }
    if(theme.value("itemWidthExtraSmall").toString().toFloat() != 0 &&
            theme.value("itemWidthExtraSmall").toString().toFloat() != m_itemWidthExtraSmall)
    {
        m_itemWidthExtraSmall = theme.value("itemWidthExtraSmall").toString().toFloat()*m_dp;
        emit itemWidthExtraSmallChanged();
        updated = true;
    }

    if(theme.value("itemHeightHuge").toString().toFloat() != 0 &&
            theme.value("itemHeightHuge").toString().toFloat() != m_itemHeightHuge)
    {
        m_itemHeightHuge = theme.value("itemHeightHuge").toString().toFloat()*m_dp;
        emit itemHeightHugeChanged();
        updated = true;
    }
    if(theme.value("itemHeightExtraLarge").toString().toFloat() != 0 &&
            theme.value("itemHeightExtraLarge").toString().toFloat() != m_itemHeightExtraLarge)
    {
        m_itemHeightExtraLarge = theme.value("itemHeightExtraLarge").toString().toFloat()*m_dp;
        emit itemHeightExtraLargeChanged();
        updated = true;
    }
    if(theme.value("itemHeightLarge").toString().toFloat() != 0 &&
            theme.value("itemHeightLarge").toString().toFloat() != m_itemHeightLarge)
    {
        m_itemHeightLarge = theme.value("itemHeightLarge").toString().toFloat()*m_dp;
        emit itemHeightLargeChanged();
        updated = true;
    }
    if(theme.value("itemHeightMedium").toString().toFloat() != 0 &&
            theme.value("itemHeightMedium").toString().toFloat() != m_itemHeightMedium)
    {
        m_itemHeightMedium = theme.value("itemHeightMedium").toString().toFloat()*m_dp;
        emit itemHeightMediumChanged();
        updated = true;
    }
    if(theme.value("itemHeightSmall").toString().toFloat() != 0 &&
            theme.value("itemHeightSmall").toString().toFloat() != m_itemHeightSmall)
    {
        m_itemHeightSmall = theme.value("itemHeightSmall").toString().toFloat()*m_dp;
        emit itemHeightSmallChanged();
        updated = true;
    }
    if(theme.value("itemHeightExtraSmall").toString().toFloat() != 0 &&
            theme.value("itemHeightExtraSmall").toString().toFloat() != m_itemHeightExtraSmall)
    {
        m_itemHeightExtraSmall = theme.value("itemHeightExtraSmall").toString().toFloat()*m_dp;
        emit itemHeightExtraSmallChanged();
        updated = true;
    }


    if(theme.value("itemSpacingHuge").toString().toFloat() != 0 &&
            theme.value("itemSpacingHuge").toString().toFloat() != m_itemSpacingHuge)
    {
        m_itemSpacingHuge = theme.value("itemSpacingHuge").toString().toFloat()*m_dp;
        emit itemSpacingHugeChanged();
        updated = true;
    }
    if(theme.value("itemSpacingLarge").toString().toFloat() != 0 &&
            theme.value("itemSpacingLarge").toString().toFloat() != m_itemSpacingLarge)
    {
        m_itemSpacingLarge = theme.value("itemSpacingLarge").toString().toFloat()*m_dp;
        emit itemSpacingLargeChanged();
        updated = true;
    }
    if(theme.value("itemSpacingMedium").toString().toFloat() != 0 &&
            theme.value("itemSpacingMedium").toString().toFloat() != m_itemSpacingMedium)
    {
        m_itemSpacingMedium = theme.value("itemSpacingMedium").toString().toFloat()*m_dp;
        emit itemSpacingMediumChanged();
        updated = true;
    }
    if(theme.value("itemSpacingSmall").toString().toFloat() != 0 &&
            theme.value("itemSpacingSmall").toString().toFloat() != m_itemSpacingSmall)
    {
        m_itemSpacingSmall = theme.value("itemSpacingSmall").toString().toFloat()*m_dp;
        emit itemSpacingSmallChanged();
        updated = true;
    }
    if(theme.value("itemSpacingExtraSmall").toString().toFloat() != 0 &&
            theme.value("itemSpacingExtraSmall").toString().toFloat() != m_itemSpacingExtraSmall)
    {
        m_itemSpacingExtraSmall = theme.value("itemSpacingExtraSmall").toString().toFloat()*m_dp;
        emit itemSpacingExtraSmallChanged();
        updated = true;
    }

    if(theme.value("fontSizeExtraLarge").toInt() != 0 &&
            theme.value("fontSizeExtraLarge").toInt() != m_fontSizeExtraLarge)
    {
        m_fontSizeExtraLarge = theme.value("itemSpacingExtraSmall").toInt()*m_dp;
        emit fontSizeExtraLargeChanged();
        updated = true;
    }
    if(theme.value("fontSizeLarge").toInt() != 0 &&
            theme.value("fontSizeLarge").toInt() != m_fontSizeLarge)
    {
        m_fontSizeLarge = theme.value("fontSizeLarge").toInt()*m_dp;
        emit fontSizeLargeChanged();
        updated = true;
    }
    if(theme.value("fontSizeMedium").toInt() != 0 &&
            theme.value("fontSizeMedium").toInt() != m_fontSizeMedium)
    {
        m_fontSizeMedium = theme.value("fontSizeMedium").toInt()*m_dp;
        emit fontSizeMediumChanged();
        updated = true;
    }
    if(theme.value("fontSizeSmall").toInt() != 0 &&
            theme.value("fontSizeSmall").toInt() != m_fontSizeSmall)
    {
        m_fontSizeSmall = theme.value("fontSizeSmall").toInt()*m_dp;
        emit fontSizeSmallChanged();
        updated = true;
    }
    if(theme.value("fontSizeTiny").toInt() != 0 &&
            theme.value("fontSizeTiny").toInt() != m_fontSizeTiny)
    {
        m_fontSizeTiny = theme.value("fontSizeTiny").toInt()*m_dp;
        emit fontSizeTinyChanged();
        updated = true;
    }
    if(theme.value("fontWeightLarge").toInt() != 0 &&
            theme.value("fontWeightLarge").toInt() != m_fontWeightLarge)
    {
        m_fontWeightLarge = theme.value("fontWeightLarge").toInt()*m_dp;
        emit fontWeightLargeChanged();
        updated = true;
    }
    if(theme.value("fontWeightMedium").toInt() != 0 &&
            theme.value("fontWeightMedium").toInt() != m_fontWeightMedium)
    {
        m_fontWeightMedium = theme.value("fontWeightMedium").toInt()*m_dp;
        emit fontWeightMediumChanged();
        updated = true;
    }

    if(theme.value("fontFamily").toString() != "" &&
            theme.value("fontFamily").toString() != m_fontFamily)
    {
        QFile fontFile;
        fontFile.setFileName(theme.value("fontFamily").toString());
        if(!themeFile.exists())
        {
            qDebug() << "Font file " << fileName << " not found";
        }
        else
        {
            m_fontFamily = theme.value("fontFamily").toString();
            emit fontFamilyChanged();
            updated = true;
        }
    }

    if(theme.value("accentColor").toString() != "" &&
            theme.value("accentColor").toString()!= m_accentColor)
    {
        m_accentColor = theme.value("accentColor").toString();
        emit accentColorChanged();
        updated = true;
    }
    if(theme.value("fillColor").toString() != "" &&
            theme.value("fillColor").toString() != m_fillColor)
    {
        m_fillColor = theme.value("fillColor").toString();
        emit fillColorChanged();
        updated = true;
    }
    if(theme.value("fillDarkColor").toString() != "" &&
            theme.value("fillDarkColor").toString() != m_fillDarkColor)
    {
        m_fillDarkColor = theme.value("fillDarkColor").toString();
        emit fillDarkColorChanged();
        updated = true;
    }
    if(theme.value("textColor").toString() != "" &&
            theme.value("textColor").toString() != m_textColor)
    {
        m_textColor = theme.value("textColor").toString();
        emit textColorChanged();
        updated = true;
    }
    if(theme.value("backgroundColor").toString() != "" &&
            theme.value("backgroundColor").toString() != m_backgroundColor)
    {
        m_backgroundColor = theme.value("backgroundColor").toString();
        emit backgroundColorChanged();
        updated = true;
    }
    if(theme.value("backgroundAccentColor").toString() != "" &&
            theme.value("backgroundAccentColor").toString() != m_backgroundAccentColor)
    {
        m_backgroundAccentColor = theme.value("backgroundAccentColor").toString();
        emit backgroundAccentColorChanged();
        updated = true;
    }

    if(updated)
    {
        emit themeUpdate();
        return true;
    }
    return false;
}
