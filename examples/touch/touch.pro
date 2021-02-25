TEMPLATE = app
QT += qml quick
TARGET = glacier-components
target.path = /usr/bin

CONFIG += link_pkgconfig
LIBS += -lglacierapp
PKGCONFIG += glacierapp

mainqml.files = glacier-components.qml
mainqml.path = /usr/share/glacier-components/qml

qml.files += \
    content/ButtonPage.qml \
    content/BrokenPage.qml \
    content/ProgressBarPage.qml \
    content/SliderPage.qml \
    content/TabBarPage.qml \
    content/TextInputPage.qml \
    content/LiveCoding.qml \
    content/SpinnerPage.qml \
    content/LabelPage.qml \
    content/CheckboxPage.qml \
    content/ButtonRowPage.qml \
    content/DialogsPage.qml \
    content/ListViewPage.qml \
    content/SelectRollerPage.qml \
    content/IconPage.qml \
    content/DatePickerPage.qml \
    content/TimePickerPage.qml \
    content/NotificationsPage.qml \
    content/StatusNotifyPage.qml \
    content/RingIndicatorPage.qml

qml.path = /usr/share/glacier-components/qml/content

images.files = $$files(images/*.png,false)
images.files += $$files(images/*.jpg,false)
images.path = /usr/share/glacier-components/images

OTHER_FILES += $$qml.files

desktop.path = /usr/share/applications
desktop.files = glacier-components.desktop

systemd_dbus_service.path = $${INSTALL_ROOT}/usr/share/dbus-1/services
systemd_dbus_service.files = org.nemomobile.notify.service

INSTALLS += desktop target qml mainqml images systemd_dbus_service

SOURCES += \
    src/main.cpp

DISTFILES += \
    content/StatusNotifyPage.qml \
    content/TimePickerPage.qml
