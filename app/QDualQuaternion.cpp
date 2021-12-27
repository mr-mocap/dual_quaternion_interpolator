#include "math/Qt/QDualQuaternion.h"


namespace {

constexpr auto ToTuple( QVector3D v ) -> triple<float>
{
    return std::make_tuple( v.x(), v.y(), v.z() );
}

inline auto ToQuaternionf( const QQuaternion& r ) -> Quaternionf
{
    return Quaternionf { r.scalar(), r.x(), r.y(), r.z() };
}

constexpr auto ToQVector3D( triplef t ) -> QVector3D
{
    return QVector3D { std::get<0>( t ), std::get<1>( t ), std::get<2>( t ) };
}

inline auto ToQQuaternion(Quaternionf q) -> QQuaternion
{
    return QQuaternion{ q.real(), q.i(), q.j(), q.k() };
}

}


QDualQuaternion::QDualQuaternion(QObject *parent)
    : QObject{parent}
{

}

QDualQuaternion::QDualQuaternion(const QDualQuaternion &dq)
    :
    QObject()
    , _dq(dq._dq)
{
}

QDualQuaternion::QDualQuaternion(QDualQuaternion &&dq)
    :
    _dq(dq._dq)
{
}

QDualQuaternion &QDualQuaternion::operator =(const QDualQuaternion &p)
{
    if (this != &p)
    {
        _dq = p._dq;
    }
    return *this;
}

QDualQuaternion &QDualQuaternion::operator =(QDualQuaternion &&p)
{
    _dq = std::move(p._dq);
    return *this;
}

void QDualQuaternion::set_coordinate_system( const QQuaternion &rotation, const QVector3D &translation )
{
    _dq = ::make_coordinate_system( ToQuaternionf( rotation ), ToTuple( translation ) );
    emit valueChanged();
}

void QDualQuaternion::set_coordinate_system( const float rotation, const QVector3D& rotation_axes, const QVector3D& translation )
{
    set_coordinate_system( QQuaternion::fromAxisAndAngle(rotation_axes, rotation) , translation );
}

void QDualQuaternion::set_interpolated_value(const QVariant &initial, const QVariant &final, const float t)
{
    // NOTE:  Why are the initial and final always a default-constructed object?
    QDualQuaternion begin = initial.value<QDualQuaternion>();
    QDualQuaternion end   = final.value<QDualQuaternion>();

    set_interpolated_value2( begin, end, t );
}

void QDualQuaternion::set_interpolated_value2( const QDualQuaternion &initial,
                                              const QDualQuaternion &final,
                                              const float            t )
{
    if ( t >= 0.0 && t <= 1.0 ) {
        _dq = initial._dq + ( final._dq - initial._dq ) * t;
        emit valueChanged();
    }
}
