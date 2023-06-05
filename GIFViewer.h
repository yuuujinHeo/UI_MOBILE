#ifndef GIFVIEWER_H
#define GIFVIEWER_H

#include <QTimer>
#include <QObject>
#include <QMovie>
#include "GlobalHeader.h"

class GIFViewer : public QQuickItem
{
    Q_OBJECT
public:
    GIFViewer(QQuickItem *parent = Q_NULLPTR);
    Q_INVOKABLE void setGIF(QString filename);

private:
    QMovie m_movie;
};

#endif // GIFVIEWER_H
