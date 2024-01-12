#ifndef ENGINECONFIGURATION_H
#define ENGINECONFIGURATION_H

#include <QObject>
#include <QVector>
#include <QString>

class EngineConfiguration : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int getSpeed READ getSpeed WRITE setSpeed NOTIFY speedChanged )
    Q_PROPERTY(QString getDistance READ getDistance WRITE setDistance NOTIFY distanceChanged);
public:
    EngineConfiguration();
    void setSpeed(int speed);
    int getSpeed() const;
    void setDistance(QString distance);
    QString getDistance() const;
    Q_INVOKABLE void accelerate(bool acc);
    Q_INVOKABLE void applyBrake(bool braks);
public slots:
    void calculateSpeed();
    void calculateDistance();
signals:
    void speedChanged();
    void distanceChanged();
private:
    int m_speed;
    bool isAccelrerating;
    bool isBraking;
    double m_distance;
    QString m_distanceString;
};

#endif // ENGINECONFIGURATION_H
