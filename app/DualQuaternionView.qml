import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import MathLib.Qt 1.0

Rectangle {
    id: base
    border.width: 1
    border.color: "black"

    property QDualQuaternion value;

    ColumnLayout {
        id: main_columnlayout
        spacing: 20

        anchors.fill: parent

        RowLayout {
            id: rotation_rowlayout
            spacing: 20

            Layout.fillWidth: true
            Layout.fillHeight: true

            Label {
                text: "Rotation"

                Layout.fillWidth: false
                Layout.fillHeight: true
            }

            QuaternionView {
                id: rotation_view

                value: base.value.real

                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        RowLayout {
            id: translation_rowlayout
            spacing: 20

            Layout.fillWidth: true
            Layout.fillHeight: true

            Label {
                text: "Translation"

                Layout.fillWidth: false
                Layout.fillHeight: true
            }

            QuaternionView {
                id: translation_view

                value: base.value.dual

                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
