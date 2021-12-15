TEMPLATE = subdirs

SUBDIRS += app \
    MathLib

app.depends = MathLib
