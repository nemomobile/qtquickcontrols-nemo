TEMPLATE = lib
CONFIG += qt plugin
QT += qml quick
TARGET=nemocontrolsplugin
PLUGIN_IMPORT_PATH = QtQuick/Controls/Nemo
THEME_IMPORT_PATH = QtQuick/Controls/Styles/Nemo/themes

# Added/Reimplemented Controls
QML_FILES += \
    Button.qml \
    ApplicationWindow.qml \
    Page.qml \
    Spinner.qml \
    Label.qml \
    Checkbox.qml\
    ButtonRow.qml \
    QueryDialog.qml \
    Header.qml \
    HeaderToolsLayout.qml \
    Slider.qml\
    ListView.qml \
    ListViewItemWithActions.qml\
    GlacierRoller.qml \
    GlacierRollerItem.qml \
    InverseMouseArea.qml

OTHER_FILES += qmldir \
    $$QML_FILES

HEADERS += \
    qquicknemocontrolsextensionplugin.h \
    hacks.h \
    nemowindow.h \
    nemopage.h \
    qquickfilteringmousearea.h \
    nemoimageprovider.h \
    themedaemon/mlocalthemedaemonclient.h \
    themedaemon/mabstractthemedaemonclient.h \
    sizing.h \
    theme.h

SOURCES += \
    qquicknemocontrolsextensionplugin.cpp \
    hacks.cpp \
    nemowindow.cpp \
    nemopage.cpp \
    qquickfilteringmousearea.cpp \
    nemoimageprovider.cpp \
    themedaemon/mlocalthemedaemonclient.cpp \
    themedaemon/mabstractthemedaemonclient.cpp \
    sizing.cpp \
    theme.cpp

target.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

qmlfiles.files = $$_PRO_FILE_PWD_/*.qml
qmlfiles.files += $$_PRO_FILE_PWD_/qmldir
qmlfiles.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

images.files = $$_PRO_FILE_PWD_/images
images.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

INSTALLS += target qmlfiles images
