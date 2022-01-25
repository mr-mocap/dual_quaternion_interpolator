import Qt3D.Core 2.0
import Qt3D.Render 2.12
import Qt3D.Extras 2.15

Entity {
    id: root

    property size resolution: Qt.size(20, 20)
    property real width: 80
    property real height: 80
    property Material material

    Entity {
        Transform {
            id: plane_transform

            translation: Qt.vector3d(0, 0, 0)
        }

        PlaneMesh {
            id: plane_mesh

            height: root.height
            width: root.width
            meshResolution: root.resolution
        }

        components: [ plane_transform, plane_mesh, material ]
    }
}
