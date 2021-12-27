import QtQuick 2.2
import QtQuick.Scene3D 2.12
import QtQuick3D 1.15
import QtQuick.Window 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick3D.Helpers 1.15

Window {
    width: 900
    height: 600
    x: 100
    y: 100
    visible: true
    title: qsTr("Dual Quaternion Interpolator")

    Component.onCompleted: {
        initial_dualquaternionview.model.set_coordinate_system( Quaternion.fromAxisAndAngle( Qt.vector3d(0, 1, 0), 0),
                                                                Qt.vector3d(0, 0, 0))
        final_dualquaternionview.model.set_coordinate_system( Quaternion.fromAxisAndAngle( Qt.vector3d(0, 1, 0), 90),
                                                              Qt.vector3d(0, 1 * 20, 0))
        interpolated_dualquaternionview.model.set_interpolated_value(initial_dualquaternionview.model, final_dualquaternionview.model, position)
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

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                DualQuaternionView {
                    id: interpolated_dualquaternionview

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                DualQuaternionView {
                    id: final_dualquaternionview

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }

            Slider {
                id: interpolation_slider
                from: 0
                to: 100
                orientation: Qt.Horizontal

                onMoved: {
                    //var begin = initial_dualquaternionview.model
                    //var end   = final_dualquaternionview.model

                    interpolated_dualquaternionview.model.set_interpolated_value2(initial_dualquaternionview.model, final_dualquaternionview.model, position)
                    //interpolated_dualquaternionview.model.set_interpolated_value(begin, end, position)
                }

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

                Scene3D {
                    id: scene
                    anchors.fill: parent
                    anchors.margins: 10
                    focus: true
                    aspects: [ "input", "logic" ]
                    cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

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
                }
            }
        }
    }
}
