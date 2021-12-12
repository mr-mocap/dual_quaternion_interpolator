import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 2.3

Window {
    width: 800
    height: 600
    visible: true
    title: qsTr("Dual Quaternion Interpolator")

    Item {
        id: mainwindow_Item
        anchors.fill: parent
        anchors.margins: 10

        Slider {
            id: interpolation_slider
            from: 0
            to: 100
            orientation: Qt.Horizontal

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Label {
            id: slidervalue_label
            text: interpolation_slider.value.toFixed(2) + "%"
            anchors.top: interpolation_slider.bottom
            anchors.topMargin: 10
            anchors.left: interpolation_slider.left
            anchors.right: interpolation_slider.right
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
