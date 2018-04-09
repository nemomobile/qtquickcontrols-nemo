import QtQuick 2.6
import QtQuick.Controls 1.0

import QtQuick.Controls.Styles.Nemo 1.0


Slider {
    id: slider
    property bool showValue: false
    property int valueFontSize: Theme.fontSizeTiny
    property bool useSpecSlider: true
    property bool alwaysUp: false

    style: SliderStyle{}
}
