#include "QDualQuaternionInterpolator.h"
#include "math/Qt/QDualQuaternion.h"
#include "utility.h"


QDualQuaternionInterpolator::QDualQuaternionInterpolator(QObject *parent)
    : QObject{parent}
    , _first{  new QDualQuaternion() }
    , _second{ new QDualQuaternion() }
    , _result{ new QDualQuaternion() }
{
    connect(_first, &QDualQuaternion::valueChanged,
            this,   &QDualQuaternionInterpolator::onDualQuaternionValueChanged);
    connect(_second, &QDualQuaternion::valueChanged,
            this,    &QDualQuaternionInterpolator::onDualQuaternionValueChanged);
    connect(_result, &QDualQuaternion::valueChanged,
            this,    &QDualQuaternionInterpolator::valueChanged);
}

QDualQuaternion *QDualQuaternionInterpolator::first()
{
    return _first.data();
}

QDualQuaternion *QDualQuaternionInterpolator::second()
{
    return _second.data();
}

QDualQuaternion *QDualQuaternionInterpolator::result()
{
    return _result.data();
}

float QDualQuaternionInterpolator::fraction() const
{
    return _t;
}

void QDualQuaternionInterpolator::setFirst(QDualQuaternion *dq)
{
    if (_first)
        disconnect(_first, &QDualQuaternion::valueChanged,
                   this,   &QDualQuaternionInterpolator::onDualQuaternionValueChanged);

    _first = dq;

    if (_first) {
        connect(_first, &QDualQuaternion::valueChanged,
                this,   &QDualQuaternionInterpolator::onDualQuaternionValueChanged);
        set_interpolated_value(*_first, *_second, _t);
    }
}

void QDualQuaternionInterpolator::setSecond(QDualQuaternion *dq)
{
    if (_second)
        disconnect(_second, &QDualQuaternion::valueChanged,
                   this,    &QDualQuaternionInterpolator::onDualQuaternionValueChanged);

    _second = dq;

    if (_second) {
        connect(_second, &QDualQuaternion::valueChanged,
                this,    &QDualQuaternionInterpolator::onDualQuaternionValueChanged);
        set_interpolated_value(*_first, *_second, _t);
    }
}

void QDualQuaternionInterpolator::setFraction(const float t)
{
    if (t != _t) {
        _t = t;
        set_interpolated_value(*_first, *_second, _t);
    }
}

void QDualQuaternionInterpolator::set_interpolated_value( const QDualQuaternion &initial,
                                                          const QDualQuaternion &final,
                                                          const float            t )
{
    if ( t >= 0.0 && t <= 1.0 ) {
        _result->setDualQuaternionf( blend(initial.dualQuaternionf(), final.dualQuaternionf(), t) );
        //emit valueChanged();
    }
}

void QDualQuaternionInterpolator::onDualQuaternionValueChanged()
{
    set_interpolated_value(*_first, *_second, _t);
}

QQuaternion QDualQuaternionInterpolator::quaternion_from_axis_and_angle(QVector3D axis, float angle_degrees)
{
    return QQuaternion::fromAxisAndAngle(axis, angle_degrees);
}
