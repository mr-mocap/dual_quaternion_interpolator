#ifndef QDISKMESH_H
#define QDISKMESH_H

#include <QObject>
#include <Qt3DRender/qgeometryrenderer.h>
#include <QPointer>
#include <QtQml/qqml.h>


class QDiskGeometry;

class QDiskMesh : public Qt3DRender::QGeometryRenderer
{
    Q_OBJECT

    Q_PROPERTY(int slices READ slices WRITE setSlices NOTIFY slicesChanged)

    QML_NAMED_ELEMENT(DiskMesh)
public:
    explicit QDiskMesh(Qt3DCore::QNode *parent = nullptr);

    int slices() const;

public slots:
    void setSlices(int s);

signals:
    void slicesChanged(int s);

protected:
    const QDiskGeometry *thisGeometry() const;
          QDiskGeometry *thisGeometry();
};

#endif // QDISKMESH_H
