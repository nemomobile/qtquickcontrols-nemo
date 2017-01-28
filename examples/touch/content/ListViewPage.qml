import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Page {
    id: listViewPage

    headerTools: HeaderToolsLayout { showBackButton: false; title: "ListView" }


    ListModel {
        id: animalsModel
        ListElement { name: "Ant"; size: "Tiny" }
        ListElement { name: "Flea"; size: "Tiny" }
        ListElement { name: "Parrot"; size: "Small" }
        ListElement { name: "Guinea pig"; size: "Small" }
        ListElement { name: "Rat"; size: "Small" }
        ListElement { name: "Butterfly"; size: "Small" }
        ListElement { name: "Dog"; size: "Medium" }
        ListElement { name: "Cat"; size: "Medium" }
        ListElement { name: "Pony"; size: "Medium" }
        ListElement { name: "Koala"; size: "Medium" }
        ListElement { name: "Horse"; size: "Large" }
        ListElement { name: "Tiger"; size: "Large" }
        ListElement { name: "Giraffe"; size: "Large" }
        ListElement { name: "Elephant"; size: "Huge" }
        ListElement { name: "Whale"; size: "Huge" }
    }

    ListView {
        id: view
        anchors.fill: parent
        clip: true
        model: animalsModel
        delegate: ListViewItem {
            label: name;
        }
        section.property: "size"
    }
}
