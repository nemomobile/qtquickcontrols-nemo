TEMPLATE = lib
TARGET = nemomodelsplugin

QT += qml
CONFIG += qt plugin hide_symbols

SOURCES += \
    calendarmodel.cpp \
    plugin.cpp

HEADERS += \
    calendarmodel.h

target.path = /usr/lib/qt5/qml/org/nemomobile/models/

INSTALLS += target

DISTFILES += \
    qmldir
