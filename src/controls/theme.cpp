#include "theme.h"
#include "sizing.h"

Theme::Theme(QObject *parent) : QObject(parent)
{
    Sizing *size = new Sizing;
    m_dp = size->getDpScaleFactor();
//Load defaults
    m_itemWidthLarge = 320*m_dp;
    m_itemWidthMedium = 240*m_dp;
    m_itemWidthSmall = 120*m_dp;

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
    m_itemExtraSmall = 8*m_dp;

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

bool Theme::loadTheme(QString name)
{
    emit themeUpdate();
    return true;
}
