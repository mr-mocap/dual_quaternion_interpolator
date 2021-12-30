import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import MathLib.Qt 1.0

Rectangle {
    id: base
    border.width: 1
    border.color: "black"
    anchors.margins: 20

    property QDualQuaternion value;

    ColumnLayout {
        id: main_columnlayout
        spacing: 20

        anchors.fill: parent

        RowLayout {
            id: real_rowlayout
            spacing: 20

            Layout.fillWidth: true

            Text {
                text: "Real"

                Layout.fillWidth: false
            }

            QuaternionView {
                id: real_view

                value: base.value.real

                Layout.fillWidth: true
            }
        }

        RowLayout {
            id: dual_rowlayout
            spacing: 20

            Layout.fillWidth: true

            Text {
                text: "Dual"

                Layout.fillWidth: false
            }

            QuaternionView {
                id: dual_view

                value: base.value.dual

                Layout.fillWidth: true
            }
        }

        RowLayout {
            id: translation_rowlayout
            spacing: 20

            Layout.fillWidth: true

            Text {
                text: "Translation"

                Layout.fillWidth: false
            }

            Vector3DView {
                id: translation_view

                value: base.value.translation

                Layout.fillWidth: true
            }
        }
    }
}
