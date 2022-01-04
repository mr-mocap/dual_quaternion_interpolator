TEMPLATE = app

QT += core gui qml quick 3dinput

CONFIG += c++17
CONFIG += qmltypes

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        QDualQuaternion.cpp \
        QDualQuaternionInterpolator.cpp \
        main.cpp

RESOURCES += qml.qrc

QML_IMPORT_NAME = MathLib.Qt
QML_IMPORT_MAJOR_VERSION = 1
QML_IMPORT_MINOR_VERSION = 0

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    MyScene.qml \
    Vector3DView.qml \
    QuaternionView.qml \
    DualQuaternionView.qml

HEADERS += \
    include/math/ApproximatelyEqualTo.h \
    include/math/Conjugate.h \
    include/math/Dual.h \
    include/math/DualQuaternion.h \
    include/math/Quaternion.h \
    include/math/Qt/QDualQuaternion.h \
    include/math/Qt/QDualQuaternionInterpolator.h \
    utility.h

INCLUDEPATH *= ./include
INCLUDEPATH *= ./include/math
INCLUDEPATH *= ./include/math/Qt

qml.files = *.qml
qml.path = $$DESTPATH
