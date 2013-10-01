TEMPLATE = lib
CONFIG += qt plugin
QT += qml quick
TARGET=nemostyleplugin
PLUGIN_IMPORT_PATH = QtQuick/Controls/Styles/Nemo

QT+=qml

# Styles
QML_FILES = \
    ButtonStyle.qml \
    CheckBoxStyle.qml \
    ComboBoxStyle.qml \
    FocusFrameStyle.qml \
    GroupBoxStyle.qml \
    MenuBarStyle.qml \
    MenuStyle.qml \
    ProgressBarStyle.qml \
    RadioButtonStyle.qml \
    ScrollViewStyle.qml\
    SliderStyle.qml \
    SpinBoxStyle.qml \
    StatusBarStyle.qml \
    TableViewStyle.qml \
    TabViewStyle.qml \
    TextFieldStyle.qml \
    ToolBarStyle.qml \
    ToolButtonStyle.qml

# Private files
QML_FILES += \
    private/ControlsStyleConfig.qml

# Images
#QML_FILES += \
#    images/480x854/*.png 
#    images/480x854/theme1/*.png
#    images/480x854/theme2/*.png

# Images
QML_FILES += \
    images/button.png \
    images/button_down.png \
    images/tab.png \
    images/header.png \
    images/groupbox.png \
    images/focusframe.png \
    images/tab_selected.png \
    images/scrollbar-handle-horizontal.png \
    images/scrollbar-handle-vertical.png \
    images/progress-indeterminate.png \
    images/editbox.png \
    images/arrow-up.png \
    images/arrow-up@2x.png \
    images/arrow-down.png \
    images/arrow-down@2x.png \
    images/arrow-left.png \
    images/arrow-left@2x.png \
    images/arrow-right.png \
    images/arrow-right@2x.png

OTHER_FILES += qmldir \
    themes/Theme1.js \
    themes/Theme2.js \
    $$QML_FILES

target.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

qmlfiles.files = $$_PRO_FILE_PWD_/*.qml
qmlfiles.files += $$_PRO_FILE_PWD_/qmldir
qmlfiles.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

privatefiles.files = $$_PRO_FILE_PWD_/private/*.qml
privatefiles.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH/private

themes.files = $$_PRO_FILE_PWD_/themes/*.js
themes.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH/themes

images.files = $$_PRO_FILE_PWD_/images
images.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

HEADERS += \
    qquicknemostyleextensionplugin.h

SOURCES += \
    qquicknemostyleextensionplugin.cpp

INSTALLS += target images qmlfiles themes privatefiles

# RESOURCES += \
#     rsc.qrc

