#include "speedometerData.h"
#include <iostream>
#include <QTimer>
#include <thread>
#include <chrono>

EngineConfiguration::EngineConfiguration()
    : m_distance(0),
    m_distanceString(QString::number(m_distance, 'f', 3)),
    isAccelrerating(false),
    isBraking(false),
    m_speed(0)
{
    // When the timer times out every 100 milliseconds, it emits a signal,
    // meaning calculateSpeed has to change the value.
    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &EngineConfiguration::calculateSpeed);
    timer->start(100);

    QTimer *distanceTimer = new QTimer(this);
    connect(distanceTimer, &QTimer::timeout, this, &EngineConfiguration::calculateDistance);
    distanceTimer->start(100);
}

void EngineConfiguration::setSpeed(int speed) {
    m_speed = speed;
}
int EngineConfiguration::getSpeed() const {
    return m_speed;
}
void EngineConfiguration::applyBrake(bool brakes)
{
    if(brakes == true) {
        isBraking = true;
        isAccelrerating = false;
        emit speedChanged();

    }else {
        isBraking = false;
        emit speedChanged();
    }
    // Add an else block if needed
}

void EngineConfiguration::accelerate(bool acc)
{
    if(acc == true) {
        isBraking = false;
        isAccelrerating = true;
        emit speedChanged();

    }else {
        isAccelrerating = false;
        emit speedChanged();
    }
}

void EngineConfiguration::setDistance(QString distance) {
    m_distanceString = distance;
}

QString EngineConfiguration::getDistance() const {
    return m_distanceString;
}

void EngineConfiguration::calculateSpeed()
{
    // Rotate needle clockwise
    if (isAccelrerating && m_speed < 280)
    {
        m_speed += 5;
    } else if(isBraking && !isAccelrerating && m_speed>=0){
        if(m_speed<6){
            m_speed=0;
        }else{
            m_speed-=5;
        }
    }
    emit speedChanged();
}
void EngineConfiguration::calculateDistance()
{
    m_distance += m_speed * 0.4;
    m_distanceString = QString::number(m_distance, 'f', 3);
    emit distanceChanged();
}
