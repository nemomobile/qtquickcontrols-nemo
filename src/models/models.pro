TEMPLATE = lib
TARGET = nemouxmodels

PLUGIN_IMPORT_PATH = Nemo/UX/Models

QT -= gui
QT += qml

CONFIG += qt plugin hide_symbols

SOURCES += \
    calendarmodel.cpp \
    plugin.cpp

HEADERS += \
    calendarmodel.h

target.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

qmlfiles.files =\
    qmldir
qmlfiles.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

INSTALLS += target qmlfiles

DISTFILES += \
    qmldir
