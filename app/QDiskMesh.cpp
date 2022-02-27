#include "QDiskMesh.h"
#include "QDiskGeometry.h"


QDiskMesh::QDiskMesh(Qt3DCore::QNode *parent)
    :
    QGeometryRenderer(parent)
{
    QDiskGeometry *geometry = new QDiskGeometry(this);

    QObject::connect(geometry, &QDiskGeometry::slicesChanged, this, &QDiskMesh::slicesChanged);

    QGeometryRenderer::setGeometry(geometry);
    setPrimitiveType(TriangleFan);
}

int QDiskMesh::slices() const
{
    return thisGeometry()->slices();
}

void QDiskMesh::setSlices(int s)
{
    thisGeometry()->setSlices(s);
}

const QDiskGeometry *QDiskMesh::thisGeometry() const
{
    return static_cast<QDiskGeometry *>(geometry());
}

QDiskGeometry *QDiskMesh::thisGeometry()
{
    return static_cast<QDiskGeometry *>(geometry());
}
