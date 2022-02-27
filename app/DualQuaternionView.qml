import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import include.math.qt 1.0

Rectangle {
    id: base
    border.width: 1
    border.color: "black"

    property DualQuaternion value;

    implicitHeight: grid.implicitHeight + grid.rowSpacing * grid.rows - 1
    implicitWidth: grid.implicitWidth + grid.columnSpacing * grid.columns - 1

    Grid {
        id: grid
        columns: 2
        rows: 5
        rowSpacing: 5
        columnSpacing: 10
        padding: 0

        anchors.fill: parent
        anchors.margins: 10

        Text {
            text: "Real"
        }

        QuaternionView {
            value: base.value.real
        }

        Text {
            text: "Dual"
        }

        QuaternionView {
            value: base.value.dual
        }

        Text {
            text: "Translation"
        }

        Vector3DView {
            value: base.value.translation
        }

        Text {
            text: "Rotation Axes"
        }

        Vector3DView {
            value: base.value.rotationaxes
        }

        Text {
            text: "Rotation Angle"
        }

        Text {
            text: base.value.rotationangle.toFixed(3) + " °"
        }
    }
}
