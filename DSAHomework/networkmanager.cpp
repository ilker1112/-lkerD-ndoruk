#include "networkmanager.h"
#include <QNetworkReply>
#include <QNetworkRequest>

#include <QDir>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QObject>

NetworkManager::NetworkManager(QObject *parent) : QObject(parent)
{

    manager= new QNetworkAccessManager();
    connect(manager,SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinished(QNetworkReply*)));
}


//(function to load the webpage and receive timeseries data)
void NetworkManager::loadWebPage(){
    QNetworkRequest request;

    QString apikey = "4UNTQKKB06SUE9IB";

    QString urlString = QString("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=AAPL&apikey=%0").arg(apikey);

    QUrl url(urlString);
    request.setUrl(url);

    QNetworkReply *reply = manager->get(request);
}

//Function to deserialize JSON and obtain the key value pairs of the data of interest
void NetworkManager::replyFinished(QNetworkReply *reply)
{
    QByteArray webData = reply->readAll();

    // Store requested data in a file
    QFile *file = new QFile(QDir::currentPath() + "\\ilker.txt");
    if(file->open(QFile::Append))
    {
        file->write(webData);
        file->flush();
        file->close();
    }
    delete file;

    QList<QPair<QString,QString>> graphValuesOpen;
    QList<QPair<QString,QString>> graphValuesClose;
    QList<QPair<QString,QString>> graphValuesVolume;


    QJsonDocument doc = QJsonDocument::fromJson(webData);

    if(doc.isArray()==true){
        QJsonArray rootArray = doc.array();
        //retrieve array
    }

    else if (doc.isObject() == true){

        QJsonObject rootObject = doc.object();

        QJsonObject timeSeries = rootObject["Time Series (Daily)"].toObject();
        QStringList keys = timeSeries.keys();

        for (QString k :keys){
            QJsonObject dayValues = timeSeries[k].toObject();
            QString openValue = dayValues["1. open"].toString();
            QString closeValue = dayValues["4. close"].toString();
            QString volume = dayValues["5. volume"].toString();

            //            qDebug()<<volume;

            QPair<QString,QString> dataItem;
            dataItem.first = k;
            dataItem.second = openValue;

            QPair<QString,QString> dataItem2;
            dataItem2.first = k;
            dataItem2.second = closeValue;

            QPair<QString,QString> dataItem3;
            dataItem3.first = k;
            dataItem3.second = volume;



            graphValuesOpen.append(dataItem);
            graphValuesClose.append(dataItem2);
            graphValuesVolume.append(dataItem3);

        }

    }
    for (int i=0; i<graphValuesOpen.size(); i++){
        QPair<QString,QString> data = graphValuesOpen[i];
        //        qDebug()<<data.first <<" - "<<data.second;
        float list=data.second.toFloat();
        QDateTime xAxisValue; xAxisValue.setDate(QDate::fromString(data.first,"yyyy-MM-dd"));
        xAxisValue.toMSecsSinceEpoch();
        emit valueUpdated(QVariant(xAxisValue),QVariant(list));
    }

    for (int i=0; i<graphValuesClose.size(); i++){
        QPair<QString,QString> data = graphValuesClose[i];
        float list = data.second.toFloat();
        QDateTime xAxisValue; xAxisValue.setDate(QDate::fromString(data.first,"yyyy-MM-dd"));
        xAxisValue.toMSecsSinceEpoch();
        emit valueUpdated2(QVariant(xAxisValue),QVariant(list));
    }

    for (int i=0; i<graphValuesVolume.size(); i++){
        QPair<QString,QString> data = graphValuesVolume[i];
        float list=data.second.toFloat();
        QDateTime xAxisValue; xAxisValue.setDate(QDate::fromString(data.first,"yyyy-MM-dd"));
        xAxisValue.toMSecsSinceEpoch();
        emit valueUpdated3(QVariant(xAxisValue),QVariant(list));
    }

}

