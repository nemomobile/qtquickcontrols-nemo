#include "theme.h"

Theme::Theme(QObject *parent) : QObject(parent)
{

}

bool Theme::loadTheme(QString name)
{
    emit themeUpdate();
    return true;
}
