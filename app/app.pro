TEMPLATE = app
QT += quick

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../MathLib/release/ -lMathLib
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../MathLib/debug/ -lMathLib
else:unix: LIBS += -L$$OUT_PWD/../MathLib/ -lMathLib

INCLUDEPATH += $$PWD/../MathLib
DEPENDPATH += $$PWD/../MathLib

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../MathLib/release/libMathLib.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../MathLib/debug/libMathLib.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../MathLib/release/MathLib.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../MathLib/debug/MathLib.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../MathLib/libMathLib.a
