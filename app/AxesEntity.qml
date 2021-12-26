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
  id: sceneRoot
  //property RenderCapabilities capabilities : renderSettings.renderCapabilities
  property real x_position : 0
  property real y_position : 0
  property real z_position : 0

  //property QDualQuaternion coord_system

  Camera {
      id: camera
      projectionType: CameraLens.PerspectiveProjection
      fieldOfView: 45
      nearPlane : 0.1
      farPlane : 1000.0
      position: Qt.vector3d( 0.0, 0.0, 40.0 )
      upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
      viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
  }

  FirstPersonCameraController { camera: camera }

  components: [
      RenderSettings {
	  id: renderSettings
	  activeFrameGraph: ForwardRenderer {
	      camera: camera
	      clearColor: "transparent"
	  }
      },
      InputSettings { }
  ]

  PhongMaterial {
    id: material
  }

  property real axis_length: 3

  Entity {
    Transform {
	id: transform
	translation: Qt.vector3d(x_position, y_position, z_position)
    }
    Entity {
	Transform {
	  id: transform2
	  translation: Qt.vector3d(0, 1.5, 0)
	}
	CylinderMesh {
	  id: mesh
	  radius: 0.2
	  length: axis_length
	}
	components: [ material, mesh, transform2 ]
    }
    Entity {
	Transform {
	  id: transform3
	  translation: Qt.vector3d(0, 0, 1.5)
	  rotationX: 90
	}
	CylinderMesh {
	  id: mesh2
	  radius: 0.2
	  length: axis_length
	}
	components: [ material, mesh2, transform3 ]
    }
    Entity {
	Transform {
	  id: transform4
	  translation: Qt.vector3d(1.5, 0, 0)
	  rotationZ: 90
	}
	CylinderMesh {
	  id: mesh3
	  radius: 0.2
	  length: axis_length
	}
	components: [ material, mesh3, transform4 ]
    }
    components: [ transform ]
  }
}
