#ifndef QAXISANGLE_H
#define QAXISANGLE_H

#include <QObject>
#include <QVector3D>
#include <QQuaternion>
#include <QtQml/qqml.h>

class QAxisAngle : public QObject
{
    Q_OBJECT

    Q_PROPERTY( QVector3D axis   READ axis   WRITE setAxis  NOTIFY axisChanged  )
    Q_PROPERTY( float     angle  READ angle  WRITE setAngle NOTIFY angleChanged )

    QML_ELEMENT
public:
    explicit QAxisAngle(QObject *parent = nullptr);

    const QVector3D &axis() const { return _axis; }
    float angle() const { return _angle; }

    void setAxis(const QVector3D &axis);
    void setAngle(const float angle_radians);

    QQuaternion toQuaternion() const;
    void        fromQuaternion(const QQuaternion &quaternion);

public slots:
    bool hasRotation(const QQuaternion &q);
    void setAxisOfRotation(const QQuaternion &q);

signals:
    void axisChanged(const QVector3D &new_axis);
    void angleChanged(float new_angle);
    void valueChanged(); // When both values change together

protected:
    QVector3D _axis  { 0.0, 0.0, 1.0 };
    float     _angle { 0.0 };
};

#endif // QAXISANGLE_H
