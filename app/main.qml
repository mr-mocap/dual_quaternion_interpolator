import QtQuick 2.2
import QtQuick.Scene3D 2.12
import QtQuick.Window 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import MathLib.Qt 1.0

Window {
    width: 600
    height: 600
    x: 100
    y: 100
    visible: true
    title: qsTr("Dual Quaternion Interpolator")

    Item {
        id: mainwindow_Item
        anchors.fill: parent
        anchors.margins: 10

        ColumnLayout {
            id: main_columnlayout
            spacing: 20
            anchors.fill: parent

            Slider {
                id: interpolation_slider
                from: 0
                to: 100
                orientation: Qt.Horizontal
                Layout.fillWidth: true
                Layout.fillHeight: false
            }

            Label {
                id: slidervalue_label
                text: interpolation_slider.value.toFixed(2) + "%"
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                Layout.fillHeight: false
            }

            Rectangle {
                id: scene_rectangle
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "darkRed"

                Scene3D {
                    id: scene
                    anchors.fill: parent
                    anchors.margins: 10
                    focus: true
                    aspects: [ "input", "logic" ]
                    cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

                    AxesEntity {
                        id: origin_axes
                    }
                }
            }
        }
    }
}
