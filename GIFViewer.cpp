#include "GIFViewer.h"

GIFViewer::GIFViewer(QQuickItem *parent):
    QQuickItem(parent)
{
}

void GIFViewer::setGIF(QString filename){
    qDebug() << "setGIF" << filename;
    m_movie.setFileName(filename);
//    m_movie = new QMovie("image/face_cry.gif");
    m_movie.start();
}
