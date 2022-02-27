#include "QDiskGeometry.h"
#include <QBufferDataGenerator>
#include <cmath>

using namespace Qt3DRender;

namespace {

int vertexCount(int slices)
{
    return 3 + slices - 1;
}

void createDiskVertices(float *&verticesPtr, int slices)
{
    const float dTheta = (M_PI * 2) / static_cast<float>(slices);
    const double zNormal = 1.0f;

    // Origin...

    // Position
    *verticesPtr++ = 0.0f;
    *verticesPtr++ = 0.0f;
    *verticesPtr++ = 0.0f;

    // Texture coordinate
    *verticesPtr++ = 0.0f;
    *verticesPtr++ = 0.0f;

    // Normal
    *verticesPtr++ = 0.0f;
    *verticesPtr++ = 0.0f;
    *verticesPtr++ = zNormal;


    for (int slice = 0; slice < slices; ++slice)
    {
        const float theta = static_cast<float>(slice) * dTheta;
        const float ct = std::cos(theta);
        const float st = std::sin(theta);

        // Position
        *verticesPtr++ = ct;
        *verticesPtr++ = st;
        *verticesPtr++ = 0.0f;

        // Texture coordinate
        *verticesPtr++ = ct;
        *verticesPtr++ = st;

        // Normal
        *verticesPtr++ = 0.0f;
        *verticesPtr++ = 0.0f;
        *verticesPtr++ = zNormal;
    }

    // first point on circle again...
    const float ct = std::cos(0.0f);
    const float st = std::sin(0.0f);

    // Position
    *verticesPtr++ = ct;
    *verticesPtr++ = st;
    *verticesPtr++ = 0.0f;

    // Texture coordinate
    *verticesPtr++ = ct;
    *verticesPtr++ = st;

    // Normal
    *verticesPtr++ = 0.0f;
    *verticesPtr++ = 0.0f;
    *verticesPtr++ = zNormal;
}

}

class DiskVertexDataFunctor : public QBufferDataGenerator
{
public:
    DiskVertexDataFunctor(int slices) : m_slices(slices) { }

    QByteArray operator ()() override
    {
        const int verticesCount = vertexCount(m_slices);

        // vec3 pos, vec2 texCoord, vec3 normal
        const quint32 numberOfElements = 3 + 2 + 3;

        std::vector<float> verticesData;

        verticesData.resize(numberOfElements * verticesCount);
        float *verticesPtr = verticesData.data();

        createDiskVertices(verticesPtr, m_slices);

        return QByteArray(reinterpret_cast<char *>(verticesData.data()), verticesData.size() * sizeof(float));
    }

    bool operator ==(const QBufferDataGenerator &other) const override
    {
        const DiskVertexDataFunctor *otherFunctor = functor_cast<DiskVertexDataFunctor>(&other);
        if (otherFunctor != nullptr)
            return (otherFunctor->m_slices == m_slices);
        return false;
    }

    QT3D_FUNCTOR(DiskVertexDataFunctor)

private:
    int m_slices;
};

QDiskGeometry::QDiskGeometry(QNode *parent)
    :
    QGeometry()
    , _positionAttribute(new QAttribute(parent))
    , _normalAttribute(new QAttribute(parent))
    , _texCoordAttribute(new QAttribute(parent))
    , _vertexBuffer(new QBuffer(parent))
{
    init();
}

QDiskGeometry::~QDiskGeometry()
{
}

int QDiskGeometry::slices() const
{
    return _slices;
}

void QDiskGeometry::setSlices(int s)
{
    if (s != _slices)
    {
        _slices = s;
        updateVertices();
        emit slicesChanged(_slices);
    }
}

void QDiskGeometry::updateVertices()
{
    const int nVerts = vertexCount(_slices);

    _positionAttribute->setCount(nVerts);
    _texCoordAttribute->setCount(nVerts);
    _normalAttribute->setCount(nVerts);
    _vertexBuffer->setDataGenerator(QSharedPointer<DiskVertexDataFunctor>::create(_slices));
}

Qt3DRender::QAttribute *QDiskGeometry::positionAttribute() const
{
    return _positionAttribute;
}

Qt3DRender::QAttribute *QDiskGeometry::normalAttribute() const
{
    return _normalAttribute;
}

Qt3DRender::QAttribute *QDiskGeometry::texCoordAttribute() const
{
    return _texCoordAttribute;
}

void QDiskGeometry::init()
{
    // vec3 pos, vec2 tex, vec3 normal
    const quint32 elementSize = 3 + 2 + 3;
    const quint32 stride = elementSize * sizeof(float);
    const int nVerts = vertexCount(_slices);

    _positionAttribute->setName(QAttribute::defaultPositionAttributeName());
    _positionAttribute->setVertexBaseType(QAttribute::Float);
    _positionAttribute->setVertexSize(3);
    _positionAttribute->setAttributeType(QAttribute::VertexAttribute);
    _positionAttribute->setBuffer(_vertexBuffer);
    _positionAttribute->setByteStride(stride);
    _positionAttribute->setCount(nVerts);

    _texCoordAttribute->setName(QAttribute::defaultTextureCoordinateAttributeName());
    _texCoordAttribute->setVertexBaseType(QAttribute::Float);
    _texCoordAttribute->setVertexSize(2);
    _texCoordAttribute->setAttributeType(QAttribute::VertexAttribute);
    _texCoordAttribute->setBuffer(_vertexBuffer);
    _texCoordAttribute->setByteStride(stride);
    _texCoordAttribute->setByteOffset(3 * sizeof(float));
    _texCoordAttribute->setCount(nVerts);

    _normalAttribute->setName(QAttribute::defaultNormalAttributeName());
    _normalAttribute->setVertexBaseType(QAttribute::Float);
    _normalAttribute->setVertexSize(3);
    _normalAttribute->setAttributeType(QAttribute::VertexAttribute);
    _normalAttribute->setBuffer(_vertexBuffer);
    _normalAttribute->setByteStride(stride);
    _normalAttribute->setByteOffset(5 * sizeof(float));
    _normalAttribute->setCount(nVerts);

    _vertexBuffer->setDataGenerator(QSharedPointer<DiskVertexDataFunctor>::create(_slices));

    addAttribute(_positionAttribute);
    addAttribute(_texCoordAttribute);
    addAttribute(_normalAttribute);
}
