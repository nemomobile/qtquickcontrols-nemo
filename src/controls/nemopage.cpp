#include "nemopage.h"
#include "hacks.h"

NemoPage::NemoPage(QQuickItem *parent) :
    QQuickItem(parent)
{
}

Qt::ScreenOrientations NemoPage::allowedOrientations() const
{
    return m_allowedOrientations;
}

void NemoPage::setAllowedOrientations(Qt::ScreenOrientations allowed)
{
    //This way no invalid values can get assigned to allowedOrientations
    if (m_allowedOrientations != allowed && Hacks::isOrientationMaskValid(allowed)) {
        m_allowedOrientations = allowed;
        emit allowedOrientationsChanged();
    }
}
