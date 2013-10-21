TEMPLATE = lib
CONFIG += qt plugin
QT += qml quick
TARGET=nemocontrolsplugin
PLUGIN_IMPORT_PATH = QtQuick/Controls/Nemo
THEME_IMPORT_PATH = QtQuick/Controls/Styles/Nemo/themes

# Added/Reimplemented Controls
QML_FILES += \
    Button.qml \
    ApplicationWindow.qml

OTHER_FILES += qmldir \
    $$QML_FILES

HEADERS += \
    qquicknemocontrolsextensionplugin.h \
    hacks.h \
    nemowindow.h

SOURCES += \
    qquicknemocontrolsextensionplugin.cpp \
    hacks.cpp \
    nemowindow.cpp

target.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

qmlfiles.files = $$_PRO_FILE_PWD_/*.qml
qmlfiles.files += $$_PRO_FILE_PWD_/qmldir
qmlfiles.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

INSTALLS += target qmlfiles
