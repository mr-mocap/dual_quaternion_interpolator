include (mathlib_dependency.pri)

QT += qml quick

TEMPLATE = lib

CONFIG += staticlib
CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES +=

HEADERS += \
    include/math/ApproximatelyEqualTo.h \
    include/math/Conjugate.h \
    include/math/Dual.h \
    include/math/DualQuaternion.h \
    include/math/Quaternion.h

# Default rules for deployment.
unix {
    target.path = $$[QT_INSTALL_PLUGINS]/generic
}
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    mathlib_dependency.pri
