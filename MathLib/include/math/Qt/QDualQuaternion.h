#ifndef QDUALQUATERNION_H
#define QDUALQUATERNION_H

#include <QObject>
#include <QQuaternion>
#include <QVector3D>
#include <QtQml/QtQml>
#include <math/DualQuaternion.h>

class QDualQuaternion : public QObject
{
    Q_OBJECT

    Q_PROPERTY( QQuaternion real READ real NOTIFY realChanged )
    Q_PROPERTY( QQuaternion dual READ dual NOTIFY dualChanged )
    Q_PROPERTY( QQuaternion rotation    READ rotation    NOTIFY rotationChanged )
    Q_PROPERTY( QVector3D   translation READ translation NOTIFY translationChanged )

    QML_ELEMENT
public:
    explicit QDualQuaternion( QObject* parent = nullptr );
    explicit QDualQuaternion(DualQuaternionf q) : _dq( q ) { }

    QQuaternion real() const { return QQuaternion { _dq.real.real(), _dq.real.i(), _dq.real.j(), _dq.real.k() }; }
    QQuaternion dual() const { return QQuaternion { _dq.dual.real(), _dq.dual.i(), _dq.dual.j(), _dq.dual.k() }; }

    QQuaternion rotation() const { return QQuaternion { _dq.real.real(), _dq.real.i(), _dq.real.j(), _dq.real.k() }; }
    QVector3D   translation() const
    {
        Quaternionf result { 2.0f * _dq.dual * _dq.real.inverse() };

        return QVector3D { result.i(), result.j(), result.k() };
    }

    QDualQuaternion& conjugate()
    {
        _dq = ::conjugate(_dq);
        return *this;
    }

    QDualQuaternion &operator +(const QDualQuaternion &right_side)
    {
        _dq = _dq + right_side._dq;
        return *this;
    }

    QDualQuaternion &operator -(const QDualQuaternion &right_side)
    {
        _dq = _dq - right_side._dq;
        return *this;
    }

    QDualQuaternion &operator *(const QDualQuaternion &right_side)
    {
        _dq = _dq * right_side._dq;
        return *this;
    }
signals:
    void realChanged();
    void dualChanged();
    void rotationChanged();
    void translationChanged();

protected:
    DualQuaternionf _dq;
};


#endif // QDUALQUATERNION_H
