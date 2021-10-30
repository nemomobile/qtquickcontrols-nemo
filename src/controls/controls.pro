TEMPLATE = lib
CONFIG += qt plugin
QT += qml quick
TARGET=nemocontrolsplugin
PLUGIN_IMPORT_PATH = QtQuick/Controls/Nemo
THEME_IMPORT_PATH = QtQuick/Controls/Styles/Nemo/themes

CONFIG += link_pkgconfig
PKGCONFIG += mlite5

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
    qml/ToolButton.qml \
    qml/ScrollDecorator.qml \
    qml/TextField.qml \
    qml/NemoIcon.qml \
    qml/ErrorStackPage.qml \
    qml/dialogs/QueryDialog.qml \
    qml/dialogs/SelectionDialog.qml \
    qml/dialogs/Dialog.qml

OTHER_FILES += qmldir \
    $$QML_FILES

HEADERS += \
    nemoblurredimage.h \
    qquicknemocontrolsextensionplugin.h \
    hacks.h \
    nemowindow.h \
    nemopage.h \
    qquickfilteringmousearea.h \
    nemoimageprovider.h \
    ringindicator.h \
    themedaemon/mlocalthemedaemonclient.h \
    themedaemon/mabstractthemedaemonclient.h \
    sizing.h \
    theme.h \
    editfilter.h \
    nemofocussingleton.h

SOURCES += \
    nemoblurredimage.cpp \
    qquicknemocontrolsextensionplugin.cpp \
    hacks.cpp \
    nemowindow.cpp \
    nemopage.cpp \
    qquickfilteringmousearea.cpp \
    nemoimageprovider.cpp \
    ringindicator.cpp \
    themedaemon/mlocalthemedaemonclient.cpp \
    themedaemon/mabstractthemedaemonclient.cpp \
    sizing.cpp \
    theme.cpp \
    editfilter.cpp \
    nemofocussingleton.cpp

target.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

qmlfiles.files = $$files($$_PRO_FILE_PWD_/qml/*.qml,false)
qmlfiles.files += $$_PRO_FILE_PWD_/qml/qmldir
qmlfiles.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

dialogs.files = $$files($$_PRO_FILE_PWD_/qml/dialogs/*.qml,false)
dialogs.files += $$_PRO_FILE_PWD_/qml/dialogs/qmldir
dialogs.path = $$[QT_INSTALL_QML]/Nemo/Dialogs

images.files = $$_PRO_FILE_PWD_/images
images.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

INSTALLS += target qmlfiles images dialogs
