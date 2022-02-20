import QtQuick 2.15
import QtQuick.Scene3D 2.15
import Qt3D.Core 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import MathLib.Qt 1.0

Window {
    width: 900
    height: 700
    visible: true
    title: qsTr("Dual Quaternion Interpolator")

    property vector3d initialAxis: Qt.vector3d(0, 1, 0)
    property vector3d finalAxis: Qt.vector3d(0, 1, 0)

    QDualQuaternionInterpolator {
        id: dq_interpolator
        fraction: interpolation_slider.position

        Component.onCompleted: {
          first.set_coordinate_system( quaternion_from_axis_and_angle( initialAxis, 0), Qt.vector3d(0, 0, 0) )
          second.set_coordinate_system( quaternion_from_axis_and_angle( finalAxis, 90), Qt.vector3d(0, 50, 0) )
        }
    }

    Item {
        id: mainwindow_Item

        anchors.fill: parent
        anchors.margins: 10

        ColumnLayout {
            id: main_columnlayout
            spacing: 5

            anchors.fill: parent

            RowLayout {
                id: data_rowlayout
                spacing: 10

                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.maximumHeight: initial_dualquaternionview.implicitHeight

                DualQuaternionView {
                    id: initial_dualquaternionview

                    value: dq_interpolator.first

                    Layout.fillWidth: true
                }

                DualQuaternionView {
                    id: interpolated_dualquaternionview

                    value: dq_interpolator.result

                    Layout.fillWidth: true
                }

                DualQuaternionView {
                    id: final_dualquaternionview

                    value: dq_interpolator.second

                    Layout.fillWidth: true
                }
            }

            Slider {
                id: interpolation_slider
                from: 0
                to: 100
                live: true
                orientation: Qt.Horizontal
                padding: 0

                Layout.fillWidth: true
                Layout.maximumHeight: implicitHeight
            }

            Label {
                id: slidervalue_label
                text: interpolation_slider.value.toFixed(2) + "%"
                horizontalAlignment: Text.AlignHCenter
                padding: 0

                Layout.fillWidth: true
                Layout.maximumHeight: implicitHeight
            }

            Rectangle {
                id: scene_rectangle
                color: "lightGrey"

                Layout.fillWidth: true
                Layout.fillHeight: true

                Scene3D {
                    id: scene3d
                    anchors.fill: parent
                    focus: true
                    aspects: [ "input", "logic" ]
                    cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

                    MyScene {
                        initialPosition: dq_interpolator.first.translation
                        initialRotation: dq_interpolator.first.rotation

                        interpolatedPosition: dq_interpolator.result.translation
                        interpolatedRotation: dq_interpolator.result.rotation

                        finalPosition: dq_interpolator.second.translation
                        finalRotation: dq_interpolator.second.rotation
                    }
                }
            }
        }
    }
}
