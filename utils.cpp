#include "utils.h"
#include <QCursor>

Utils::Utils(QmlApplicationViewer* app, QObject *parent) :
    m_app(app)
    ,QObject(parent)
{
}

void Utils::setCursor(int shape)
{
    if(shape == Qt::SizeVerCursor)
    {
        m_app->setCursor(QCursor(Qt::SizeVerCursor));
    }
    else
    {
        m_app->setCursor(QCursor(Qt::ArrowCursor));
    }
}
