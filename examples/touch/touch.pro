TEMPLATE = app
QT += qml quick
TARGET = touch_nemo
target.path = /usr/lib/qt5/examples

qtHaveModule(widgets) {
    QT += widgets
}

include(src/src.pri)

OTHER_FILES += \
    main.qml \
    content/AndroidDelegate.qml \
    content/ButtonPage.qml \
    content/ProgressBarPage.qml \
    content/SliderPage.qml \
    content/TabBarPage.qml \
    content/TextInputPage.qml \
    content/LiveCoding.qml \
    content/ToolBarLayoutExample.qml \
    content/SpinnerPage.qml \
    content/LabelPage.qml \
    content/CheckboxPage.qml

RESOURCES += \
    resources.qrc

INSTALLS += target
