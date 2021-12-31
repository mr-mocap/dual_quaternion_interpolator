import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import MathLib.Qt 1.0

Rectangle {
    id: base
    border.width: 1
    border.color: "black"

    property QDualQuaternion value;

    Grid {
        id: grid
        columns: 2
        rows: 5
        spacing: 10

        anchors.fill: parent
        anchors.margins: 10

        Text {
            text: "Real"
        }

        QuaternionView {
            id: real_view

            value: base.value.real
        }

        Text {
            text: "Dual"
        }

        QuaternionView {
            id: dual_view

            value: base.value.dual
        }

        Text {
            text: "Translation"
        }

        Vector3DView {
            id: translation_view

            value: base.value.translation
        }

        Text {
            text: "Rotation Axes"
        }

        Vector3DView {
            id: rotation_axes_view

            value: base.value.rotationaxes
        }

        Text {
            text: "Rotation Angle"
        }

        Text {
            id: rotation_angle_view

            text: base.value.rotationangle.toFixed(3)
        }
    }
}
