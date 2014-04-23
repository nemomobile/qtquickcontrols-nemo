#include "qquickfilteringmousearea.h"
#include <QQuickWindow>

QQuickFilteringMouseArea::QQuickFilteringMouseArea(QQuickItem *parent) :
    QQuickItem(parent),
    m_pressed(false),
    m_swipingX(false),
    m_swipingY(false),
    m_swipingThreshold(10)
{
    setFiltersChildMouseEvents(true);
    setAcceptedMouseButtons(Qt::LeftButton);
}

bool QQuickFilteringMouseArea::childMouseEventFilter(QQuickItem *i, QEvent *e)
{
    if (!isVisible() || !isEnabled())
        return QQuickItem::childMouseEventFilter(i, e);
    switch (e->type()) {
    case QEvent::MouseButtonPress:
    case QEvent::MouseMove:
    case QEvent::MouseButtonRelease:
        return sendMouseEvent(i, static_cast<QMouseEvent *>(e));
    case QEvent::UngrabMouse:
        if (window() && window()->mouseGrabberItem() && window()->mouseGrabberItem() != this) {
            // The grab has been taken away from a child and given to some other item.
            mouseUngrabEvent();
        }
        break;
    default:
        break;
    }

    return QQuickItem::childMouseEventFilter(i, e);
}

void QQuickFilteringMouseArea::mouseMoveEvent(QMouseEvent *event) {
    if (!isEnabled() || !isPressed()) {
        QQuickItem::mouseMoveEvent(event);
        return;
    }

    //TODO: we should only grab the mouse if there's a swipe ongoing.
    //The move event is very easy to trigger with touchscreens
    //so it's not a good measure of the fact that we want to swipe
    //grabMouse();

    setDeltaPos(QPointF(event->windowPos().x() - pressPos().x(), event->windowPos().y() - pressPos().y()));
    if (event->windowPos().x() - pressPos().x() > swipingThreshold()) setSwipingX(true);
    if (event->windowPos().y() - pressPos().y() > swipingThreshold()) setSwipingY(true);
    setPosition(event->localPos());
}

void QQuickFilteringMouseArea::mousePressEvent(QMouseEvent *event) {
    if (!isEnabled() || !(event->button() & acceptedMouseButtons())) {
        QQuickItem::mousePressEvent(event);
    } else {
        setPressPos(event->windowPos());
        emit pressed(event->localPos());
        setPressed(true);
        setPosition(event->localPos());
    }
}

void QQuickFilteringMouseArea::mouseReleaseEvent(QMouseEvent *event) {
    if (!isEnabled() && !isPressed()) {
        QQuickItem::mouseReleaseEvent(event);
    } else {
        QQuickWindow *w = window();
        if (w && w->mouseGrabberItem() == this && m_pressed){
            emit released(event->localPos());
            mouseUngrabEvent();
        }
    }
}

bool QQuickFilteringMouseArea::sendMouseEvent(QQuickItem *item, QMouseEvent *event) {
    QPointF localPos = mapFromScene(event->windowPos());
    QQuickWindow *c = window();
    QQuickItem *grabber = c ? c->mouseGrabberItem() : 0;

    if ((contains(localPos)) && (!grabber || !grabber->keepMouseGrab())) {
        QMouseEvent mouseEvent(event->type(), localPos, event->windowPos(), event->screenPos(),
                               event->button(), event->buttons(), event->modifiers());
        mouseEvent.setAccepted(false);

        switch (event->type()) {
        case QEvent::MouseMove:
            mouseMoveEvent(&mouseEvent);
            break;
        case QEvent::MouseButtonPress:
            mousePressEvent(&mouseEvent);
            break;
        case QEvent::MouseButtonRelease:
            mouseReleaseEvent(&mouseEvent);
            break;
        default:
            break;
        }
    }
    return false;
}

void QQuickFilteringMouseArea::mouseUngrabEvent() {
    setPressed(false);
    setSwipingX(false);
    setSwipingY(false);
    QQuickWindow *w = window();
    if (w && w->mouseGrabberItem() == this)
        ungrabMouse();
}

void QQuickFilteringMouseArea::grabMouseEvents() {
    qDebug() << "Glacier Header: Grabbing mouse!";
    grabMouse();
}

void QQuickFilteringMouseArea::ungrabMouseEvents() {
    ungrabMouse();
}
