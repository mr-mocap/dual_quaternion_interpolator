#include "math/Qt/QDualQuaternion.h"


namespace
{

constexpr auto ToTriple(QVector3D *v) -> triple<float>
{
    return std::make_tuple( v->x(), v->y(), v->z() );
}

inline auto ToQuaternionf(QQuaternion *q) -> Quaternionf
{
    return Quaternionf(q->scalar(), q->x(), q->y(), q->z());
}

}


QDualQuaternion::QDualQuaternion(QObject *parent)
    : QObject{parent}
    , _dq{ Quaternionf::unit(), Quaternionf::zero() }
    , _real{ _dq.real.real(), _dq.real.i(), _dq.real.j(), _dq.real.k() }
    , _dual{ _dq.dual.real(), _dq.dual.i(), _dq.dual.j(), _dq.dual.k() }
{
    extractTranslation(_dq);
}

void QDualQuaternion::setRotation(QQuaternion *r)
{
    // Transform it into the form needed in the dual part...
    DualQuaternionf new_object = make_coordinate_system( ToQuaternionf(r), _dq.dual.imaginary() ); // Use the existing translation

    setDualQuaternionf(new_object);
}

void QDualQuaternion::setTranslation(QVector3D *t)
{
    // Transform it into the form needed in the dual part...
    DualQuaternionf new_object = make_coordinate_system(_dq.real, ToTriple(t)); // Use the existing rotation

    setDualQuaternionf(new_object);
}

void QDualQuaternion::setDualQuaternionf(const DualQuaternionf &dq)
{
    if (dq != _dq) {
        _dq = dq;
        extractParts(_dq);
        extractTranslation(_dq);
        emit valueChanged();
    }
}

void QDualQuaternion::extractTranslation(const DualQuaternionf &dq)
{
    Quaternionf result { 2.0f * dq.dual * dq.real.inverse() };

    _translation.setX( result.i() );
    _translation.setY( result.j() );
    _translation.setZ( result.k() );
}

void QDualQuaternion::extractParts(const DualQuaternionf &dq)
{
    _real.setScalar( dq.real.real() );
    _real.setX( dq.real.i() );
    _real.setY( dq.real.j() );
    _real.setZ( dq.real.k() );

    _dual.setScalar( dq.dual.real() );
    _dual.setX( dq.dual.i() );
    _dual.setY( dq.dual.j() );
    _dual.setZ( dq.dual.k() );
}

void QDualQuaternion::set_coordinate_system(QQuaternion *rotation, QVector3D *translation)
{
    DualQuaternionf coord_sys = ::make_coordinate_system( ToQuaternionf(rotation), ToTriple(translation) );

    setDualQuaternionf(coord_sys);
}
