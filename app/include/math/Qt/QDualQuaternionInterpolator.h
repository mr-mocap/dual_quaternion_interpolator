#ifndef QDUALQUATERNIONINTERPOLATOR_H
#define QDUALQUATERNIONINTERPOLATOR_H

#include <QObject>
#include <QPointer>
#include <QQuaternion>
#include <QtQml/qqml.h>

class QDualQuaternion;

class QDualQuaternionInterpolator : public QObject
{
    Q_OBJECT
    Q_PROPERTY( QDualQuaternion *first    READ first    WRITE setFirst    NOTIFY valueChanged )
    Q_PROPERTY( QDualQuaternion *second   READ second   WRITE setSecond   NOTIFY valueChanged )
    Q_PROPERTY( float            fraction READ fraction WRITE setFraction NOTIFY valueChanged )
    Q_PROPERTY( QDualQuaternion *result   READ result                     NOTIFY valueChanged )

    QML_NAMED_ELEMENT(DualQuaternionInterpolator)
public:
    explicit QDualQuaternionInterpolator(QObject *parent = nullptr);

    QDualQuaternion *first();
    QDualQuaternion *second();
    QDualQuaternion *result();
    float fraction() const;

    void setFirst(QDualQuaternion *dq);
    void setSecond(QDualQuaternion *dq);
    void setFraction(const float t);
signals:
    void valueChanged();

public slots:
    QQuaternion quaternion_from_axis_and_angle(QVector3D axis, float angle_degrees);

protected:
    QPointer<QDualQuaternion> _first;
    QPointer<QDualQuaternion> _second;
    QPointer<QDualQuaternion> _result;
    float _t = 0.0f;

    void set_interpolated_value(const QDualQuaternion &initial, const QDualQuaternion &final, const float t);

protected slots:
    void onDualQuaternionValueChanged();
};

#endif // QDUALQUATERNIONINTERPOLATOR_H
