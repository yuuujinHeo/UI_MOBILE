#include "Logger.h"
#include "GlobalHeader.h"

#include <iostream>
#include <QDebug>



Logger Logger::instance;


Logger::Logger()
{
    filename = getFileName();
    file = new QFile;
    file->setFileName(filename);
    file->open(QIODevice::Append | QIODevice::Text);

}

void Logger::write(const QString &str, bool print){
    QString text = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss") + " " + str + "\n";


    QString tempname = instance.getFileName();
    if(tempname != instance.filename){
        // date changed
        if(instance.file->isOpen()){
            instance.file->close();
            delete instance.file;
        }
        instance.filename = tempname;
        instance.file = new QFile;
        instance.file->setFileName(instance.filename);
        instance.file->open(QIODevice::Append | QIODevice::Text);
    }

    if(print == true)
        qDebug() << str;

    QTextStream out(instance.file);
    out.setCodec("UTF-8");

    if(instance.file != nullptr){
        out << text;
    }
}

void Logger::write_space(){
    QString tempname = instance.getFileName();
    if(tempname != instance.filename){
        // date changed
        if(instance.file->isOpen()){
            instance.file->close();
            delete instance.file;
        }
        instance.filename = tempname;
        instance.file = new QFile;
        instance.file->setFileName(instance.filename);
        instance.file->open(QIODevice::Append | QIODevice::Text);
    }

    QTextStream out(instance.file);
    out.setCodec("UTF-8");

    if(instance.file != nullptr){
        out << "\n\n\n";
    }
}

QString Logger::getFileName(){
    QString tempname = QDateTime::currentDateTime().toString("log/yyyy_MM_dd") + ".txt";
    return tempname;
}
