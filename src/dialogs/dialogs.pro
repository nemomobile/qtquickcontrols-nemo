PLUGIN_IMPORT_PATH = Nemo/Dialogs

qmlfiles.files = qmldir
qmlfiles.files += *.qml

qmlfiles.path = $$[QT_INSTALL_QML]/$$PLUGIN_IMPORT_PATH

DISTFILES += \
    qmldir \
    QueryDialog.qml

INSTALLS += qmlfiles
