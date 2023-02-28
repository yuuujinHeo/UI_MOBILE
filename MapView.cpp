#include "MapView.h"

PixmapContainer::PixmapContainer(QObject *parent){
}

MapView::MapView(QQuickItem *parent):
    QQuickPaintedItem(parent)
{
}

void MapView::setMap(QObject *pixmapContainer){
    PixmapContainer *pc = qobject_cast<PixmapContainer*>(pixmapContainer);
    Q_ASSERT(pc);
    qDebug() << "SetMap ";
    m_pixmapContainer.pixmap = pc->pixmap;
    update();
}

void MapView::paint(QPainter *painter){
    painter->drawPixmap(0,0,width(),height(),m_pixmapContainer.pixmap);
}
