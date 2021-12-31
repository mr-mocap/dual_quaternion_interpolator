#ifndef UTILITY_H
#define UTILITY_H

#include <QVector3D>
#include <QQuaternion>
#include "math/Quaternion.h"

constexpr inline auto ToTriple(QVector3D v) -> triple<float>
{
    return std::make_tuple( v.x(), v.y(), v.z() );
}

inline auto ToQuaternionf(QQuaternion q) -> Quaternionf
{
    return Quaternionf(q.scalar(), q.x(), q.y(), q.z());
}

#endif // UTILITY_H
