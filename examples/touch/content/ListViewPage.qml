import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Page {
    id: listViewPage

    headerTools: HeaderToolsLayout { showBackButton: false; title: "MediumListView" }


    ListModel {
        id: animalsModel
        ListElement { name: "Ant"; desc: "Small description"; size: "Tiny" }
        ListElement { name: "Flea"; desc: ""; size: "Tiny" }
        ListElement { name: "Parrot"; desc: ""; size: "Small" }
        ListElement { name: "Guinea pig"; desc: "The guinea pig, cavy or domestic guinea pig, or cuy for livestock breeds, is a species of rodent belonging to the family Caviidae and the genus Cavia"; size: "Small" }
        ListElement { name: "Rat"; desc: ""; size: "Small" }
        ListElement { name: "Butterfly"; desc: ""; size: "Small" }
        ListElement { name: "Dog"; desc: ""; size: "Medium" }
        ListElement { name: "Cat"; desc: ""; size: "Medium" }
        ListElement { name: "Pony"; desc: ""; size: "Medium" }
        ListElement { name: "Koala"; desc: ""; size: "Medium" }
        ListElement { name: "Horse"; desc: ""; size: "Large" }
        ListElement { name: "Tiger"; desc: ""; size: "Large" }
        ListElement { name: "Giraffe"; desc: ""; size: "Large" }
        ListElement { name: "Elephant"; desc: ""; size: "Huge" }
        ListElement { name: "Whale"; desc: ""; size: "Huge" }
    }

    ListView {
        id: view
        anchors.fill: parent
        clip: true
        model: animalsModel
        delegate: ListViewItemWithActions {
            label: name
            description: desc
        }
        section.property: "size"
    }
}
