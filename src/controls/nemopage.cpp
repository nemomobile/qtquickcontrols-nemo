#include "nemopage.h"
#include "hacks.h"

NemoPage::NemoPage(QQuickItem *parent) :
    QQuickItem(parent),
    m_allowedOrientations(0) //- The value 0 means Page's allowedOrientations will be ignored
  //- The value 0 can't be set from QML on purpose (see Hacks::isOrientationMaskValid impl.),
  //  so that we can use the value 0 to know that the app developer has not touched this value
  //  (in fact, as just said, once it's changed from QML, the app dev can't set it back to 0 from QML)
{
}

Qt::ScreenOrientations NemoPage::allowedOrientations() const
{
    return m_allowedOrientations;
}

void NemoPage::setAllowedOrientations(Qt::ScreenOrientations allowed)
{
    //This way no invalid values can get assigned to allowedOrientations
    if (m_allowedOrientations != allowed) {
        if (Hacks::isOrientationMaskValid(allowed)) {
            m_allowedOrientations = allowed;
            emit allowedOrientationsChanged();
        } else {
            qDebug() << "NemoPage: invalid allowedOrientation!";
        }
    }
}
