import Qt3D.Core 2.0
import Qt3D.Render 2.12
import Qt3D.Input 2.12
import Qt3D.Extras 2.15

Entity {
    id: sceneRoot

    property alias position: interpolated_axes.position
    property alias rotation: interpolated_axes.rotation

    Camera {
        id: camera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d( 0.0, 0.0, 40.0 )
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
    }

    FirstPersonCameraController { camera: camera }

    components: [
        RenderSettings {
            id: renderSettings
            activeFrameGraph: ForwardRenderer {
                camera: camera
                clearColor: "transparent"
            }
        },
        InputSettings { }
    ]

    AxesEntity {
        id: interpolated_axes

        position: sceneRoot.position
        rotation: sceneRoot.rotation
    }
}
