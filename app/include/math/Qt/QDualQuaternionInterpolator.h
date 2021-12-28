#ifndef QDUALQUATERNIONINTERPOLATOR_H
#define QDUALQUATERNIONINTERPOLATOR_H

#include <QObject>
#include <QPointer>
#include "math/Qt/QDualQuaternion.h"


class QDualQuaternionInterpolator : public QObject
{
    Q_OBJECT
    Q_PROPERTY( QDualQuaternion *first    READ first    WRITE setFirst    NOTIFY valueChanged )
    Q_PROPERTY( QDualQuaternion *second   READ second   WRITE setSecond   NOTIFY valueChanged )
    Q_PROPERTY( float            fraction READ fraction WRITE setFraction NOTIFY valueChanged )
    Q_PROPERTY( QDualQuaternion *result   READ result                     NOTIFY valueChanged )

    QML_ELEMENT
public:
    explicit QDualQuaternionInterpolator(QObject *parent = nullptr);

    QDualQuaternion *first() { return _first; }
    QDualQuaternion *second() { return _second; }
    QDualQuaternion *result() { return _result; }
    float fraction() const { return _t; }

    void setFirst(QDualQuaternion *dq);
    void setSecond(QDualQuaternion *dq);
    void setFraction(const float t);
signals:
    void valueChanged();

protected:
    QPointer<QDualQuaternion> _first;
    QPointer<QDualQuaternion> _second;
    QPointer<QDualQuaternion> _result;
    float _t = 0.0f;

    void set_interpolated_value(const QDualQuaternion &initial, const QDualQuaternion &final, const float t);
};

#endif // QDUALQUATERNIONINTERPOLATOR_H
