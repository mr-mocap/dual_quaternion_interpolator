#ifndef QDUALQUATERNION_H
#define QDUALQUATERNION_H

#include <QObject>
#include <QQuaternion>
#include <QVector3D>
#include <QtQml/qqml.h>
#include "math/DualQuaternion.h"


class QDualQuaternion : public QObject
{
    Q_OBJECT

    Q_PROPERTY( QQuaternion real READ real NOTIFY valueChanged )
    Q_PROPERTY( QQuaternion dual READ dual NOTIFY valueChanged )
    Q_PROPERTY( QQuaternion rotation    READ rotation    WRITE setRotation    NOTIFY valueChanged )
    Q_PROPERTY( QVector3D   translation READ translation WRITE setTranslation NOTIFY valueChanged )

    QML_ELEMENT
public:
    explicit QDualQuaternion( QObject* parent = nullptr );

    QQuaternion real();
    QQuaternion dual();

    QQuaternion rotation();
    QVector3D   translation();

    void setRotation(QQuaternion r);
    void setTranslation(QVector3D t);

    // Allows for getting/setting the underlying object
    const DualQuaternionf &dualQuaternionf() const { return _dq; };
    void setDualQuaternionf(const DualQuaternionf &dq);

public slots:
    void set_coordinate_system(QQuaternion rotation, QVector3D translation);

signals:
    void valueChanged();

protected:
    DualQuaternionf _dq;
    QQuaternion _real;
    QQuaternion _dual;
    QVector3D   _translation;

    void extractTranslation(const DualQuaternionf &dq);
    void extractParts(const DualQuaternionf &dq);
};


inline bool operator ==(const QDualQuaternion &dq1, const QDualQuaternion &dq2)
{
    return dq1.dualQuaternionf() == dq2.dualQuaternionf();
}

inline bool operator !=(const QDualQuaternion &dq1, const QDualQuaternion &dq2)
{
    return !operator ==(dq1, dq2);
}

#endif // QDUALQUATERNION_H
