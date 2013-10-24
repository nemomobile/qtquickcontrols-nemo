#ifndef NEMOPAGE_H
#define NEMOPAGE_H

#include <QQuickItem>

class NemoPage : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(Qt::ScreenOrientations allowedOrientations READ allowedOrientations WRITE setAllowedOrientations NOTIFY allowedOrientationsChanged)

public:
    explicit NemoPage(QQuickItem *parent = 0);
    
    Qt::ScreenOrientations allowedOrientations() const;
    void setAllowedOrientations(Qt::ScreenOrientations allowed);

signals:
    void allowedOrientationsChanged();

public slots:

private:
    Qt::ScreenOrientations m_allowedOrientations;
    
};

#endif // NEMOPAGE_H
