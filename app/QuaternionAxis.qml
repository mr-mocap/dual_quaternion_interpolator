import Qt3D.Core 2.0
import Qt3D.Render 2.12
import Qt3D.Input 2.12
import Qt3D.Extras 2.15
import MathLib.Qt 1.0


Entity {
    id: root

    property vector3d   position: Qt.vector3d(0, 0, 0)
    property quaternion rotation: Qt.quaternion(1.0, 0.0, 0.0, 0.0)
    property QAxisAngle defaultRotationAxis: QAxisAngle { axis: Qt.vector3d(0, 1, 0); angle: 0 }
    property Material   material: WireframeMaterial {
        id: disc_material
        effect: WireframeEffect {}
        ambient: Qt.rgba( 0.2, 0.2, 0.0, 1.0 )
        diffuse: Qt.rgba( 0.8, 0.8, 0.0, 1.0 )
        lineColor: diffuse
    }

    Entity {
        Transform {
            id: disc_transform
            //rotation: root.rotation
            rotation:  calculateRotationPerpendicularToRotationAxis(root.rotation, defaultRotationAxis.axis)
            translation: position
        }

        TorusMesh {
            id: rotation_disc
            radius: 5.0
            minorRadius: 0.5
        }
        components: [ disc_transform, material, rotation_disc ]
    }

    function calculateRotationPerpendicularToRotationAxis(new_rotation, default_rotation_axis)
    {
        var destination_rotation_vector_normalized = isUnitQuaternion(new_rotation) ?
                                                                      default_rotation_axis
                                                                      :
                                                                      Qt.vector3d(new_rotation.x, new_rotation.y, new_rotation.z).normalized();
        var original_rotation_vector_normalized = Qt.vector3d(0, 0, 1);
        var cross_product = original_rotation_vector_normalized.crossProduct(destination_rotation_vector_normalized);
        var cross_product_length = cross_product.length();
        var dot_product = original_rotation_vector_normalized.dotProduct(destination_rotation_vector_normalized);
        var rotation = Math.asin(cross_product_length);
        var calculated_rotation = disc_transform.fromAxisAndAngle( cross_product, toDegrees(rotation) );

        return calculated_rotation;
    }

    function isUnitQuaternion(r)
    {
        var direction = Qt.vector3d(r.x, r.y, r.z);
        var zero      = Qt.vector3d(0, 0, 0);

        return direction.fuzzyEquals(zero) && (Math.abs(1.0 - r.scalar) < 0.003);
    }

    function toDegrees(input_in_radians)
    {
        return input_in_radians * (180.0 / Math.PI);
    }

    onRotationChanged: {
        disc_transform.rotation = calculateRotationPerpendicularToRotationAxis(root.rotation, defaultRotationAxis.axis)
    }
}
