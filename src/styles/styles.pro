TEMPLATE = lib
CONFIG += qt plugin
QT += qml quick
TARGET=nemostyleplugin
PLUGIN_IMPORT_PATH = QtQuick/Controls/Styles/Nemo

QT+=qml

# Styles
QML_FILES = \
    qml/ButtonStyle.qml \
    qml/CheckBoxStyle.qml \
    qml/ComboBoxStyle.qml \
    qml/FocusFrameStyle.qml \
    qml/GrooveStyle.qml \
    qml/GroupBoxStyle.qml \
    qml/MenuBarStyle.qml \
    qml/MenuStyle.qml \
    qml/ProgressBarStyle.qml \
    qml/RadioButtonStyle.qml \
    qml/ScrollViewStyle.qml\
    qml/SliderStyle.qml \
    qml/SpinBoxStyle.qml \
    qml/StatusBarStyle.qml \
    qml/TableViewStyle.qml \
    qml/TabViewStyle.qml \
    qml/TextFieldStyle.qml \
    qml/ToolBarStyle.qml \
    qml/ToolButtonStyle.qml \
    qml/IconButtonStyle.qml

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
    images/arrow-right@2x.png \
    images/disabled-overlay.png \
    images/switch-ball.png \
    images/slider-ball.png \
    images/slider-handle-left.svg \
    images/slider-trumpet-stretch.png \
    images/slider-trumpet-up.png \
    images/slider-trumpet.png

OTHER_FILES += qmldir \
    themes/Theme1.js \
    themes/Theme2.js \
    themes/glacier.json \
    themes/ugly.json \
    $$QML_FILES

target.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

qmlfiles.files = $$_PRO_FILE_PWD_/qml/*.qml
qmlfiles.files += $$_PRO_FILE_PWD_/qml/qmldir
qmlfiles.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

themes.files = $$_PRO_FILE_PWD_/themes/*.json
themes.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH/themes

images.files = $$_PRO_FILE_PWD_/images/*.svg\
               $$_PRO_FILE_PWD_/images/*.png

images.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH/images/

HEADERS += \
    qquicknemostyleextensionplugin.h

SOURCES += \
    qquicknemostyleextensionplugin.cpp

INSTALLS += target images qmlfiles themes

DEFINES += 'THEME_DIR=\'\"$$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH/themes"\''

