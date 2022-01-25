import Qt3D.Core 2.0
import Qt3D.Render 2.12
import Qt3D.Input 2.12
import Qt3D.Extras 2.15
import QtQuick 2.1 as QQ2

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
        position: Qt.vector3d( plane_entity.width, plane_entity.width / 2, plane_entity.height )
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

    WireframeMaterial {
        id: wireframeMaterial
        effect: WireframeEffect {}
        ambient: Qt.rgba( 0.2, 0.2, 0.2, 1.0 )
        diffuse: Qt.rgba( 0.8, 0.8, 0.8, 1.0 )

//        QQ2.SequentialAnimation {
//            loops: QQ2.Animation.Infinite
//            running: true

//            QQ2.NumberAnimation {
//                target: wireframeMaterial;
//                property: "lineWidth";
//                duration: 1000;
//                from: 0.8
//                to: 1.8
//            }

//            QQ2.NumberAnimation {
//                target: wireframeMaterial;
//                property: "lineWidth";
//                duration: 1000;
//                from: 1.8
//                to: 0.8
//            }

//            QQ2.PauseAnimation { duration: 1500 }
//        }
    }

    PlaneEntity {
        id: plane_entity
        material: wireframeMaterial
    }

    AxesEntity {
        id: interpolated_axes

        position: sceneRoot.position
        rotation: sceneRoot.rotation
    }
}
