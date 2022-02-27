#ifndef QDISKGEOMETRY_H
#define QDISKGEOMETRY_H

#include <Qt3DRender/qgeometry.h>
#include <QAttribute>
#include <QBuffer>
#include <QPointer>
#include <QtQml/qqml.h>


class QDiskGeometry : public Qt3DRender::QGeometry
{
    Q_OBJECT

    Q_PROPERTY(int slices READ slices WRITE setSlices NOTIFY slicesChanged)
    Q_PROPERTY(Qt3DRender::QAttribute *positionAttribute READ positionAttribute CONSTANT)
    Q_PROPERTY(Qt3DRender::QAttribute *normalAttribute READ normalAttribute CONSTANT)
    Q_PROPERTY(Qt3DRender::QAttribute *texCoordAttribute READ texCoordAttribute CONSTANT)

    QML_NAMED_ELEMENT(DiskGeometry)
public:
    explicit QDiskGeometry(QNode *parent = nullptr);
    ~QDiskGeometry();

    void updateVertices();

    int slices() const;

    Qt3DRender::QAttribute *positionAttribute() const;
    Qt3DRender::QAttribute *normalAttribute() const;
    Qt3DRender::QAttribute *texCoordAttribute() const;

public slots:
    void setSlices(int s);

signals:
    void slicesChanged(int s);

protected:
    int _slices = 360;
    QPointer<Qt3DRender::QAttribute> _positionAttribute;
    QPointer<Qt3DRender::QAttribute> _normalAttribute;
    QPointer<Qt3DRender::QAttribute> _texCoordAttribute;
    QPointer<Qt3DRender::QBuffer>    _vertexBuffer;

    void init();
};

#endif // QDISKGEOMETRY_H
