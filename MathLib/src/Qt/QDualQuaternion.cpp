#include <math/Qt/QDualQuaternion.h>
#include <QQmlEngine>

QDualQuaternion::QDualQuaternion(QObject *parent)
    : QObject{parent}
{

}

void QDualQuaternion::RegisterType()
{
    qmlRegisterType<QDualQuaternion>("MathLib.Qt", 1, 0, "DualQuaternion");
}
