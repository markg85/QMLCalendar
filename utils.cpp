#include "utils.h"
#include <QCursor>

Utils::Utils(QmlApplicationViewer* app, QObject *parent) :
    QObject(parent),
    m_app(app)
{
}

void Utils::setCursor(int shape)
{
    m_app->setCursor(QCursor((Qt::CursorShape)shape));
}
