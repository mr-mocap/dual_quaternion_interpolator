import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQml 2.15

Item {
    property quaternion model: Qt.quaternion(1.0, 0.0, 0.0, 0.0)

    RowLayout {
        id: values_rowlayout
        spacing: 20

        anchors.fill: parent

        Text {
            id: scalar_text
            text: model.scalar.toFixed(3)

            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Text {
            id: x_text
            text: model.x.toFixed(3)

            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Text {
            id: y_text
            text: model.y.toFixed(3)

            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Text {
            id: z_text
            text: model.z.toFixed(3)

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
