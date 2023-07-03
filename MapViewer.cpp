#include "MapViewer.h"

MapViewer::MapViewer(QQuickItem *parent):
    QQuickPaintedItem(parent)
{
    timer = new QTimer(this);
    connect(timer,SIGNAL(timeout()),this,SLOT(onTimer()));
    timer->start(100);
}

void MapViewer::onTimer(){
    update();
}
void MapViewer::paint(QPainter *painter){
    painter->drawPixmap(0,0,width(),height(),pmap->map);
}
