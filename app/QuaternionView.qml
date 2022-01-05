import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQml 2.15

Grid {
    property quaternion value: Qt.quaternion(1.0, 0.0, 0.0, 0.0)

    id: values_rowlayout
    rows: 1
    columns: 4
    spacing: 10

    Text {
        id: scalar_text
        text: value.scalar.toFixed(3)
        horizontalAlignment: Text.AlignRight

        Layout.fillWidth: true
    }

    Text {
        id: x_text
        text: value.x.toFixed(3)
        horizontalAlignment: Text.AlignRight

        Layout.fillWidth: true
    }

    Text {
        id: y_text
        text: value.y.toFixed(3)
        horizontalAlignment: Text.AlignRight

        Layout.fillWidth: true
    }

    Text {
        id: z_text
        text: value.z.toFixed(3)
        horizontalAlignment: Text.AlignRight

        Layout.fillWidth: true
    }
}
