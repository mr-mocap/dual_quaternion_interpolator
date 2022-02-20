/****************************************************************************
**
** Copyright (C) 2015 Klaralvdalens Datakonsult AB (KDAB).
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt3D module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/


import Qt3D.Core 2.0
import Qt3D.Render 2.12
import Qt3D.Input 2.12
import Qt3D.Extras 2.15


Entity {
    id: root

    property vector3d position: Qt.vector3d(0, 0, 0)
    property quaternion rotation: Qt.quaternion(1, 0, 0, 0)
    property real axis_length: 8
    property real axes_radius: 0.4

    WireframeMaterial {
        id: wireframeMaterial_red
        effect: WireframeEffect {}
        ambient: Qt.rgba( 0.2, 0.2, 0.2, 1.0 )
        diffuse: Qt.rgba( 0.8, 0.0, 0.0, 1.0 )
        lineColor: diffuse
    }

    WireframeMaterial {
        id: wireframeMaterial_green
        effect: WireframeEffect {}
        ambient: Qt.rgba( 0.2, 0.2, 0.2, 1.0 )
        diffuse: Qt.rgba( 0.0, 0.8, 0.0, 1.0 )
        lineColor: diffuse
    }

    WireframeMaterial {
        id: wireframeMaterial_blue
        effect: WireframeEffect {}
        ambient: Qt.rgba( 0.2, 0.2, 0.2, 1.0 )
        diffuse: Qt.rgba( 0.0, 0.0, 0.8, 1.0 )
        lineColor: diffuse
    }

    Entity {
        Transform {
            id: transform
            translation: position
            rotation: root.rotation
        }
        Entity {
            Transform {
                id: transform_y
                translation: Qt.vector3d(0, axis_length / 2.0, 0)
            }
            CylinderMesh {
                id: mesh
                radius: root.axes_radius
                length: root.axis_length
            }
            components: [ wireframeMaterial_green, mesh, transform_y ]
        }
        Entity {
            Transform {
                id: transform_z
                translation: Qt.vector3d(0, 0, axis_length / 2.0)
                rotationX: 90
            }
            CylinderMesh {
                id: mesh2
                radius: root.axes_radius
                length: root.axis_length
            }
            components: [ wireframeMaterial_blue, mesh2, transform_z ]
        }
        Entity {
            Transform {
                id: transform_x
                translation: Qt.vector3d(axis_length / 2.0, 0, 0)
                rotationZ: 90
            }
            CylinderMesh {
                id: mesh3
                radius: root.axes_radius
                length: root.axis_length
            }
            components: [ wireframeMaterial_red, mesh3, transform_x ]
        }
        components: [ transform ]
    }
}
