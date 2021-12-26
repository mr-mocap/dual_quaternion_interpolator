import QtQuick 2.2
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Rectangle {
    border.width: 1
    border.color: black

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

                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
