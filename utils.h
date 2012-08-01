#ifndef UTILS_H
#define UTILS_H

#include <QObject>
#include "qmlapplicationviewer.h"

class Utils : public QObject
{
    Q_OBJECT
public:
    explicit Utils(QmlApplicationViewer* app, QObject *parent = 0);

    Q_INVOKABLE void setCursor(int shape);
    
signals:
    
public slots:
    
private:
    QmlApplicationViewer* m_app;
};

#endif // UTILS_H
