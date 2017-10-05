TEMPLATE = app
QT += qml quick
TARGET = glacier-components
target.path = /usr/bin

qtHaveModule(widgets) {
    QT += widgets
}

mainqml.files = main.qml
mainqml.path = /usr/share/glacier-components

qml.files += \
    content/AndroidDelegate.qml \
    content/ButtonPage.qml \
    content/ProgressBarPage.qml \
    content/SliderPage.qml \
    content/TabBarPage.qml \
    content/TextInputPage.qml \
    content/LiveCoding.qml \
    content/SpinnerPage.qml \
    content/LabelPage.qml \
    content/CheckboxPage.qml \
    content/ButtonRowPage.qml \
    content/QueryDialogPage.qml \
    content/ListViewPage.qml \
    content/SelectRollerPage.qml \
    content/IconPage.qml \
    content/DatePickerPage.qml

qml.path = /usr/share/glacier-components/content

images.files = images/*.png
images.path = /usr/share/glacier-components/images

OTHER_FILES += $$qml.files


desktop.path = /usr/share/applications
desktop.files = glacier-gallery.desktop

INSTALLS += desktop target qml mainqml images

SOURCES += \
    src/main.cpp
