TEMPLATE = lib
CONFIG += qt plugin
QT += qml quick
TARGET=nemocontrolsplugin
PLUGIN_IMPORT_PATH = QtQuick/Controls/Nemo

# Private files
QML_FILES += \
    private/NemoControls.qml

OTHER_FILES += qmldir \
    $$QML_FILES

HEADERS += \
    qquicknemocontrolsextensionplugin.h \
    hacks.h

SOURCES += \
    qquicknemocontrolsextensionplugin.cpp \
    hacks.cpp

target.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

qmlfiles.files = $$_PRO_FILE_PWD_/*.qml
qmlfiles.files += $$_PRO_FILE_PWD_/qmldir
qmlfiles.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

privatefiles.files = $$_PRO_FILE_PWD_/private/*.qml
privatefiles.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH/private

INSTALLS += target privatefiles qmlfiles

#RESOURCES += \
#    internal_resources.qrc
