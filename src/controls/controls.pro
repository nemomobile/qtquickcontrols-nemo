TEMPLATE = lib
CONFIG += qt plugin
QT += qml quick
TARGET=nemocontrolsplugin
PLUGIN_IMPORT_PATH = QtQuick/Controls/Nemo
THEME_IMPORT_PATH = QtQuick/Controls/Styles/Nemo/themes

# Added/Reimplemented Controls
QML_FILES += \
    qml/Button.qml \
    qml/ApplicationWindow.qml \
    qml/ActionButton.qml \
    qml/Page.qml \
    qml/Spinner.qml \
    qml/Label.qml \
    qml/Checkbox.qml\
    qml/ButtonRow.qml \
    qml/Header.qml \
    qml/ProgressBar.qml \
    qml/HeaderToolsLayout.qml \
    qml/Slider.qml\
    qml/ListView.qml \
    qml/ListViewItemWithActions.qml\
    qml/GlacierRoller.qml \
    qml/GlacierRollerItem.qml \
    qml/InverseMouseArea.qml \
    qml/IconButton.qml \
    qml/DatePicker.qml \
    qml/TimePicker.qml \
    qml/ScrollDecorator.qml \
    qml/TextField.qml \
    qml/ErrorStackPage.qml \
    qml/dialogs/QueryDialog.qml \
    qml/dialogs/SelectionDialog.qml \
    qml/dialogs/Dialog.qml

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
    theme.h \
    editfilter.h \
    nemofocussingleton.h

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
    theme.cpp \
    editfilter.cpp \
    nemofocussingleton.cpp

target.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

qmlfiles.files = $$_PRO_FILE_PWD_/qml/*.qml
qmlfiles.files += $$_PRO_FILE_PWD_/qml/qmldir
qmlfiles.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

dialogs.files = $$_PRO_FILE_PWD_/qml/dialogs/*.qml
dialogs.files += $$_PRO_FILE_PWD_/qml/dialogs/qmldir
dialogs.path = $$[QT_INSTALL_QML]/Nemo/Dialogs

images.files = $$_PRO_FILE_PWD_/images
images.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

INSTALLS += target qmlfiles images dialogs
