TEMPLATE = lib
CONFIG += qt plugin
QT += qml quick
TARGET=nemostyleplugin
PLUGIN_IMPORT_PATH = QtQuick/Controls/Styles/Nemo

QT+=qml

# Styles
QML_FILES = \

# Images
QML_FILES += \
    images/editbox.png \
    images/disabled-overlay.png \
    images/slider-handle-left.svg \
    images/slider-trumpet-stretch.png \
    images/slider-trumpet-up.png \
    images/slider-trumpet.png

keyboard.files = virtualkeyboard/style.qml
keyboard.path = $$[QT_INSTALL_QML]/QtQuick/VirtualKeyboard/Styles/Nemo

target.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

qmlfiles.files = qml/ButtonStyle.qml \
                qml/CheckBoxStyle.qml \
                qml/ComboBoxStyle.qml \
                qml/FocusFrameStyle.qml \
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
                qml/TextAreaStyle.qml \
                qml/ToolBarStyle.qml \
                qml/ToolButtonStyle.qml \
                qml/IconButtonStyle.qml \
                qml/qmldir

qmlfiles.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

themes.files = $$_PRO_FILE_PWD_/themes/glacier_black.json \
               $$_PRO_FILE_PWD_/themes/glacier_white.json \
               $$_PRO_FILE_PWD_/themes/glacier_orange.json

themes.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH/themes

images.files = $$files($$_PRO_FILE_PWD_/images/*.svg,false)\
               $$files($$_PRO_FILE_PWD_/images/*.png,false)

images.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH/images/

kbdimages.files = $$files($$_PRO_FILE_PWD_/images/virtualkeyboard/*.svg,false)\
               $$files($$_PRO_FILE_PWD_/images/virtualkeyboard/*.png,false)

kbdimages.path = $$[QT_INSTALL_QML]/QtQuick/VirtualKeyboard/Styles/Nemo/images

HEADERS += \
    qquicknemostyleextensionplugin.h

SOURCES += \
    qquicknemostyleextensionplugin.cpp

INSTALLS += target \
            images \
            qmlfiles \
            themes \
            keyboard \
            kbdimages

DEFINES += 'THEME_DIR=\'\"$$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH/themes"\''
