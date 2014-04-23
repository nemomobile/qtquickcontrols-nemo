#ifndef QQUICKFILTERINGMOUSEAREA_H
#define QQUICKFILTERINGMOUSEAREA_H

#include <QQuickItem>
#include <QMouseEvent>

class QQuickFilteringMouseArea : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(bool pressed READ isPressed NOTIFY pressedChanged)
    Q_PROPERTY(QPointF pressPos READ pressPos NOTIFY pressPosChanged)
    Q_PROPERTY(QPointF deltaPos READ deltaPos NOTIFY deltaPosChanged)
    Q_PROPERTY(bool swipingX READ isSwipingX NOTIFY swipingXChanged)
    Q_PROPERTY(bool swipingY READ isSwipingY NOTIFY swipingYChanged)
    Q_PROPERTY(int swipingThreshold READ swipingThreshold WRITE setSwipingThreshold NOTIFY swipingThresholdChanged)

public:
    explicit QQuickFilteringMouseArea(QQuickItem *parent = 0);

    bool handlePress();
    bool handleMove();
    bool handleRelease();

    bool isPressed() const { return m_pressed; }
    void setPressed(const bool pressed) {
        if (m_pressed != pressed) {
            m_pressed = pressed;
            emit pressedChanged();
        }
    }

    QPointF position() const { return m_lastPos; }
    void setPosition(const QPointF &pos) {
        if (m_lastPos != pos) {
            m_lastPos = pos;
            emit positionChanged(pos);
        }
    }

    QPointF pressPos() const { return m_pressPos; }
    void setPressPos(const QPointF &pos) {
        if (m_pressPos != pos) {
            m_pressPos = pos;
            emit pressPosChanged();
        }
    }

    QPointF deltaPos() const { return m_deltaPos; }
    void setDeltaPos(const QPointF &pos) {
        if (m_deltaPos != pos) {
            m_deltaPos = pos;
            emit deltaPosChanged();
        }
    }

    bool isSwipingX() const { return m_swipingX; }
    void setSwipingX(const bool swiping) {
        if (m_swipingX != swiping) {
            m_swipingX = swiping;
            emit swipingXChanged();
        }
    }

    bool isSwipingY() const { return m_swipingY; }
    void setSwipingY(const bool swiping) {
        if (m_swipingY != swiping) {
            m_swipingY = swiping;
            emit swipingYChanged();
        }
    }

    int swipingThreshold() const { return m_swipingThreshold; }
    void setSwipingThreshold(const int threshold) {
        if (m_swipingThreshold != threshold) {
            m_swipingThreshold = threshold;
            emit swipingThresholdChanged();
        }
    }

signals:
    void pressedChanged();
    void pressed(const QPointF &pos);
    void released(const QPointF &pos);
    void positionChanged(const QPointF &pos);
    void pressPosChanged();
    void deltaPosChanged();
    void swipingXChanged();
    void swipingYChanged();
    void swipingThresholdChanged();

public slots:
    void grabMouseEvents();
    void ungrabMouseEvents();

protected:
    virtual bool childMouseEventFilter(QQuickItem *, QEvent *);
    virtual void mousePressEvent(QMouseEvent *event);
    virtual void mouseMoveEvent(QMouseEvent *event);
    virtual void mouseReleaseEvent(QMouseEvent *event);
    virtual void mouseUngrabEvent();
    bool sendMouseEvent(QQuickItem *item, QMouseEvent *event);

private:
    bool m_pressed;
    QPointF m_lastPos;
    QPointF m_pressPos;
    QPointF m_deltaPos;
    bool m_swipingX;
    bool m_swipingY;
    int m_swipingThreshold;
};

#endif // QQUICKFILTERINGMOUSEAREA_H
