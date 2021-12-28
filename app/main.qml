import QtQuick 2.15
import QtQuick.Scene3D 2.12
import QtQuick3D 1.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick3D.Helpers 1.15
import MathLib.Qt 1.0

Window {
    width: 900
    height: 600
    x: 100
    y: 100
    visible: true
    title: qsTr("Dual Quaternion Interpolator")

    Component.onCompleted: {
        dq_interpolator.first.set_coordinate_system( Quaternion.fromAxisAndAngle( Qt.vector3d(0, 1, 0), 0),
                                                     Qt.vector3d(0, 0, 0))
        dq_interpolator.second.set_coordinate_system( Quaternion.fromAxisAndAngle( Qt.vector3d(0, 1, 0), 90),
                                                      Qt.vector3d(0, 1 * 20, 0))
    }

    QDualQuaternionInterpolator {
        id: dq_interpolator

        fraction: interpolation_slider.position
    }

    Item {
        id: mainwindow_Item

        anchors.fill: parent
        anchors.margins: 10

        ColumnLayout {
            id: main_columnlayout
            spacing: 20

            anchors.fill: parent

            RowLayout {
                id: data_rowlayout
                spacing: 20

                Layout.fillWidth: true
                Layout.fillHeight: true

                DualQuaternionView {
                    id: initial_dualquaternionview

                    model: dq_interpolator.first

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                DualQuaternionView {
                    id: interpolated_dualquaternionview

                    model: dq_interpolator.result

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                DualQuaternionView {
                    id: final_dualquaternionview

                    model: dq_interpolator.second

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }

            Slider {
                id: interpolation_slider
                from: 0
                to: 100
                live: true
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
                color: "darkRed"

                Layout.fillWidth: true
                Layout.fillHeight: true

//                Scene3D {
//                    id: scene
//                    anchors.fill: parent
//                    anchors.margins: 10
//                    focus: true
//                    aspects: [ "input", "logic" ]
//                    cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

//                    AxesEntity {
//                        id: origin_axes

//                        position: initial_dualquaternionview.model.translation
//                    }
//                    AxisHelper {
//                        id: origin_axes
//                        enableAxisLines: true
//                        position: initial_dualquaternionview.model.translation
//                        rotation: initial_dualquaternionview.model.rotation
//                    }

//                    AxesEntity {
//                        id: interpolated_axes

//                        position: interpolated_dualquaternionview.model.translation
//                    }
//                    AxisHelper {
//                        id: interpolated_axes
//                        enableAxisLines: true
//                        position: interpolated_dualquaternionview.model.translation
//                        rotation: interpolated_dualquaternionview.model.rotation
//                    }

//                    AxesEntity {
//                        id: destination_axes

//                        position: final_dualquaternionview.model.translation
//                    }
//                    AxisHelper {
//                        id: destination_axes
//                        enableAxisLines: true
//                        position: final_dualquaternionview.model.translation
//                        rotation: final_dualquaternionview.model.rotation
//                    }
//                }
            }
        }
    }
}
