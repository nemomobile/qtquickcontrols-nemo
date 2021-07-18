#include "theme.h"
#include <math.h>
#include <QFile>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>

Theme::Theme(QObject *parent) : QObject(parent)
{
    size = new Sizing;
    m_dp = size->getDpScaleFactor();
    m_iconSizeLauncher = size->getLauncherIconSize();
    m_scaleRatio = size->getScaleRatio();
    m_fontRatio = size->getFontRatio();

    loadDefaultValue();

    MGConfItem *desktopModeValue = new MGConfItem(QStringLiteral("/nemo/apps/libglacier/desktopmode"));
    m_themeValue = new MGConfItem(QStringLiteral("/nemo/apps/libglacier/themePath"));

    m_desktopMode = desktopModeValue->value().toBool();
    m_theme = m_themeValue->value().toString();

    connect(desktopModeValue, &MGConfItem::valueChanged, this, &Theme::desktopModeValueChanged);
    connect(m_themeValue, &MGConfItem::valueChanged, this, &Theme::themeValueChanged);

    loadTheme(m_theme);
}

bool Theme::loadTheme(QString fileName)
{
    QFile themeFile(fileName);

    if(!themeFile.exists()) {
        qDebug() << "Theme file " << fileName << " not found";
        return false;
    }

    if(fileName != m_theme) {
        m_themeValue->set(fileName);
    } else {
        setThemeValues();
    }
    return true;
}

void Theme::setThemeValues()
{
    QString themeJsonString;

    bool updated = false;

    QFile themeFile(m_theme);

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
           floor(theme.value("itemWidthLarge").toString().toFloat()) != m_itemWidthLarge)
    {
        m_itemWidthLarge = floor(theme.value("itemWidthLarge").toString().toFloat()*m_scaleRatio);
        emit itemWidthLargeChanged();
        updated = true;
    }
    if(theme.value("itemWidthMedium").toString().toFloat() != 0 &&
           floor(theme.value("itemWidthMedium").toString().toFloat()) != m_itemWidthMedium)
    {
        m_itemWidthMedium = floor(theme.value("itemWidthMedium").toString().toFloat()*m_scaleRatio);
        emit itemWidthMediumChanged();
        updated = true;
    }
    if(theme.value("itemWidthSmall").toString().toFloat() != 0 &&
           floor(theme.value("itemWidthSmall").toString().toFloat()) != m_itemWidthSmall)
    {
        m_itemWidthSmall = floor(theme.value("itemWidthSmall").toString().toFloat()*m_scaleRatio);
        emit itemWidthSmallChanged();
        updated = true;
    }
    if(theme.value("itemWidthExtraSmall").toString().toFloat() != 0 &&
           floor(theme.value("itemWidthExtraSmall").toString().toFloat()) != m_itemWidthExtraSmall)
    {
        m_itemWidthExtraSmall = floor(theme.value("itemWidthExtraSmall").toString().toFloat()*m_scaleRatio);
        emit itemWidthExtraSmallChanged();
        updated = true;
    }

    if(theme.value("itemHeightHuge").toString().toFloat() != 0 &&
           floor(theme.value("itemHeightHuge").toString().toFloat()) != m_itemHeightHuge)
    {
        m_itemHeightHuge = floor(theme.value("itemHeightHuge").toString().toFloat()*m_scaleRatio);
        emit itemHeightHugeChanged();
        updated = true;
    }
    if(theme.value("itemHeightExtraLarge").toString().toFloat() != 0 &&
           floor(theme.value("itemHeightExtraLarge").toString().toFloat()) != m_itemHeightExtraLarge)
    {
        m_itemHeightExtraLarge = floor(theme.value("itemHeightExtraLarge").toString().toFloat()*m_scaleRatio);
        emit itemHeightExtraLargeChanged();
        updated = true;
    }
    if(theme.value("itemHeightLarge").toString().toFloat() != 0 &&
           floor(theme.value("itemHeightLarge").toString().toFloat()) != m_itemHeightLarge)
    {
        m_itemHeightLarge = floor(theme.value("itemHeightLarge").toString().toFloat()*m_scaleRatio);
        emit itemHeightLargeChanged();
        updated = true;
    }
    if(theme.value("itemHeightMedium").toString().toFloat() != 0 &&
           floor(theme.value("itemHeightMedium").toString().toFloat()) != m_itemHeightMedium)
    {
        m_itemHeightMedium = floor(theme.value("itemHeightMedium").toString().toFloat()*m_scaleRatio);
        emit itemHeightMediumChanged();
        updated = true;
    }
    if(theme.value("itemHeightSmall").toString().toFloat() != 0 &&
           floor(theme.value("itemHeightSmall").toString().toFloat()) != m_itemHeightSmall)
    {
        m_itemHeightSmall = floor(theme.value("itemHeightSmall").toString().toFloat()*m_scaleRatio);
        emit itemHeightSmallChanged();
        updated = true;
    }
    if(theme.value("itemHeightExtraSmall").toString().toFloat() != 0 &&
           floor(theme.value("itemHeightExtraSmall").toString().toFloat()) != m_itemHeightExtraSmall)
    {
        m_itemHeightExtraSmall = floor(theme.value("itemHeightExtraSmall").toString().toFloat()*m_scaleRatio);
        emit itemHeightExtraSmallChanged();
        updated = true;
    }


    if(theme.value("itemSpacingHuge").toString().toFloat() != 0 &&
           floor(theme.value("itemSpacingHuge").toString().toFloat()) != m_itemSpacingHuge)
    {
        m_itemSpacingHuge = floor(theme.value("itemSpacingHuge").toString().toFloat()*m_scaleRatio);
        emit itemSpacingHugeChanged();
        updated = true;
    }
    if(theme.value("itemSpacingLarge").toString().toFloat() != 0 &&
           floor(theme.value("itemSpacingLarge").toString().toFloat()) != m_itemSpacingLarge)
    {
        m_itemSpacingLarge = floor(theme.value("itemSpacingLarge").toString().toFloat()*m_scaleRatio);
        emit itemSpacingLargeChanged();
        updated = true;
    }
    if(theme.value("itemSpacingMedium").toString().toFloat() != 0 &&
           floor(theme.value("itemSpacingMedium").toString().toFloat()) != m_itemSpacingMedium)
    {
        m_itemSpacingMedium = floor(theme.value("itemSpacingMedium").toString().toFloat()*m_scaleRatio);
        emit itemSpacingMediumChanged();
        updated = true;
    }
    if(theme.value("itemSpacingSmall").toString().toFloat() != 0 &&
           floor(theme.value("itemSpacingSmall").toString().toFloat()) != m_itemSpacingSmall)
    {
        m_itemSpacingSmall = floor(theme.value("itemSpacingSmall").toString().toFloat()*m_scaleRatio);
        emit itemSpacingSmallChanged();
        updated = true;
    }
    if(theme.value("itemSpacingExtraSmall").toString().toFloat() != 0 &&
           floor(theme.value("itemSpacingExtraSmall").toString().toFloat()) != m_itemSpacingExtraSmall)
    {
        m_itemSpacingExtraSmall = floor(theme.value("itemSpacingExtraSmall").toString().toFloat()*m_scaleRatio);
        emit itemSpacingExtraSmallChanged();
        updated = true;
    }

    if(theme.value("fontSizeExtraLarge").toInt() != 0 &&
           floor(theme.value("fontSizeExtraLarge").toInt()) != m_fontSizeExtraLarge)
    {
        m_fontSizeExtraLarge = floor(theme.value("fontSizeExtraLarge").toInt()*m_fontRatio);
        emit fontSizeExtraLargeChanged();
        updated = true;
    }
    if(theme.value("fontSizeLarge").toInt() != 0 &&
            floor(theme.value("fontSizeLarge").toInt()) != m_fontSizeLarge)
    {
        m_fontSizeLarge = floor(theme.value("fontSizeLarge").toInt()*m_fontRatio);
        emit fontSizeLargeChanged();
        updated = true;
    }
    if(theme.value("fontSizeMedium").toInt() != 0 &&
            floor(theme.value("fontSizeMedium").toInt()) != m_fontSizeMedium)
    {
        m_fontSizeMedium = floor(theme.value("fontSizeMedium").toInt()*m_fontRatio);
        emit fontSizeMediumChanged();
        updated = true;
    }
    if(theme.value("fontSizeSmall").toInt() != 0 &&
            floor(theme.value("fontSizeSmall").toInt()) != m_fontSizeSmall)
    {
        m_fontSizeSmall = floor(theme.value("fontSizeSmall").toInt()*m_fontRatio);
        emit fontSizeSmallChanged();
        updated = true;
    }
    if(theme.value("fontSizeTiny").toInt() != 0 &&
            floor(theme.value("fontSizeTiny").toInt()) != m_fontSizeTiny)
    {
        m_fontSizeTiny = floor(theme.value("fontSizeTiny").toInt()*m_fontRatio);
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
            qDebug() << "Font file " << fontFile.fileName() << " not found";
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
    }
}

void Theme::desktopModeValueChanged()
{
    m_desktopMode = MGConfItem(QStringLiteral("/nemo/apps/libglacier/desktopmode")).value().toBool();
    emit desktopModeChanged();

}

void Theme::themeValueChanged()
{
    m_theme = m_themeValue->value().toString();
    setThemeValues();
}

void Theme::loadDefaultValue()
{
    //Load defaults
    m_itemWidthLarge = floor(320*m_scaleRatio);
    m_itemWidthMedium = floor(240*m_scaleRatio);
    m_itemWidthSmall = floor(120*m_scaleRatio);
    m_itemWidthExtraSmall = floor(72*m_scaleRatio);

    m_itemHeightHuge = floor(80*m_scaleRatio);
    m_itemHeightExtraLarge = floor(75*m_scaleRatio);
    m_itemHeightLarge = floor(63*m_scaleRatio);
    m_itemHeightMedium = floor(50*m_scaleRatio);
    m_itemHeightSmall = floor(40*m_scaleRatio);
    m_itemHeightExtraSmall = floor(32*m_scaleRatio);

    m_itemSpacingHuge = floor(40*m_scaleRatio);
    m_itemSpacingLarge = floor(20*m_scaleRatio);
    m_itemSpacingMedium = floor(15*m_scaleRatio);
    m_itemSpacingSmall = floor(10*m_scaleRatio);
    m_itemSpacingExtraSmall = floor(8*m_scaleRatio);


    m_fontSizeExtraLarge = floor(44*m_fontRatio);
    m_fontSizeLarge = floor(35*m_fontRatio);
    m_fontSizeMedium = floor(28*m_fontRatio);
    m_fontSizeSmall = floor(24*m_fontRatio);
    m_fontSizeTiny = floor(16*m_fontRatio);
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
