#include "QAxisAngle.h"

QAxisAngle::QAxisAngle(QObject *parent)
    : QObject{parent}
{

}

void QAxisAngle::setAxis(const QVector3D &axis)
{
    if (_axis != axis)
    {
        _axis = axis;
        emit axisChanged(_axis);
    }
}

void QAxisAngle::setAngle(const float angle_radians)
{
    if (_angle != angle_radians)
    {
        _angle = angle_radians;
        emit angleChanged(_angle);
    }
}

QQuaternion QAxisAngle::toQuaternion() const
{
    if ( qFuzzyCompare(_angle, 0.0f) )
    {
        // Ok, we are basically a unit quaternion
        return QQuaternion(1.0f, 0.0f, 0.0f, 0.0f);
    }
    else
        return QQuaternion::fromAxisAndAngle(_axis, _angle);
}

void QAxisAngle::fromQuaternion(const QQuaternion &quaternion)
{
    QVector3D new_axis;
    float     new_angle;
    bool      axis_changed = false;
    bool      angle_changed = false;

    quaternion.getAxisAndAngle(&new_axis, &new_angle);

    if ( qFuzzyCompare(new_angle, 0.0f) )
    {
        // Special case: The rotation becomes 0 but the axis shouldn't change.

        // Only mark a change if it really changed...
        if ( !qFuzzyCompare(new_angle, _angle) )
        {
            _angle = new_angle;
            emit angleChanged(_angle);
            return; // Don't change the axis, since a 0 rotation about any axis is equivalent
        }
    }

    new_axis.normalize();

    // Ok, we have some kind of rotation, which means the axis and/or angle may have changed.
    if ( !qFuzzyCompare(new_axis, _axis) )
    {
        _axis = new_axis;
        axis_changed = true;
    }
    if ( !qFuzzyCompare(new_angle, _angle) )
    {
        _angle = new_angle;
        angle_changed = true;
    }
    if (axis_changed && angle_changed)
        emit valueChanged();
    else if (axis_changed)
        emit axisChanged(_axis);
    else if (angle_changed)
        emit angleChanged(_angle);
}

bool QAxisAngle::hasRotation(const QQuaternion &q)
{
    QVector3D axis;
    float     angle;

    q.getAxisAndAngle(&axis, &angle);
    return !qFuzzyCompare(angle, 0.0f);
}

void QAxisAngle::setAxisOfRotation(const QQuaternion &q)
{
    QVector3D axis;
    float     angle;

    q.getAxisAndAngle(&axis, &angle);
    axis.normalize();
    if ( !qFuzzyCompare(axis, _axis) )
    {
        _axis = axis;
        emit axisChanged(_axis);
    }
}
