TEMPLATE = app
QT += qml quick
TARGET = glacier-sizeview
target.path = /usr/bin

CONFIG += link_pkgconfig
LIBS += -lglacierapp
PKGCONFIG += glacierapp


SOURCES += \
    main.cpp

qml.files = glacier-sizeview.qml
qml.path = /usr/share/glacier-sizeview/qml/

INSTALLS += target qml
