#include "QDualQuaternionInterpolator.h"

QDualQuaternionInterpolator::QDualQuaternionInterpolator(QObject *parent)
    : QObject{parent}
{
}

void QDualQuaternionInterpolator::setFirst(QDualQuaternion *dq)
{
    _first = dq;
    set_interpolated_value(*_first, *_second, _t);
}

void QDualQuaternionInterpolator::setSecond(QDualQuaternion *dq)
{
    _second = dq;
    set_interpolated_value(*_first, *_second, _t);
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
        _result->setDualQuaternionf( initial.dualQuaternionf() + ( final.dualQuaternionf() - initial.dualQuaternionf() ) * t);
        emit valueChanged();
    }
}
