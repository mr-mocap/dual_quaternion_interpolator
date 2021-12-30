import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQml 2.15

Item {
    property vector3d value;

    RowLayout {
       id: rowlayout
       spacing: 20

       anchors.fill: parent

       Text {
           id: x_text
           text: value.x.toFixed(3)

           Layout.fillWidth: true
           Layout.fillHeight: true
       }

       Text {
           id: y_text
           text: value.y.toFixed(3)

           Layout.fillWidth: true
           Layout.fillHeight: true
       }

       Text {
           id: z_text
           text: value.z.toFixed(3)

           Layout.fillWidth: true
           Layout.fillHeight: true
       }
    }
}
