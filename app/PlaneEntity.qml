import Qt3D.Core 2.0
import Qt3D.Render 2.12
import Qt3D.Extras 2.15

Entity {
    id: root

    Entity {
        Transform {
            id: plane_transform

            translation: Qt.vector3d(0, 0, 0)
        }

        PlaneMesh {
            id: plane_mesh

            height: 100
            width: 100
            meshResolution: Qt.size(20, 20)
        }

        GoochMaterial {
            id: material

            diffuse: "grey"
        }

        components: [ plane_transform, plane_mesh, material ]
    }
}
