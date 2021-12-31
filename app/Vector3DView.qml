import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQml 2.15


RowLayout {
    id: rowlayout
    spacing: 20

    property vector3d value;

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
