import QtQuick 2.6
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Page {
    id: listViewPage

    headerTools: HeaderToolsLayout { showBackButton: true; title: "ListView" }


    ListModel {
        id: animalsModel
        ListElement { name: "Ant"; desc: "Small description"; size: "Tiny"; canRemove: true}
        ListElement { name: "Flea"; desc: ""; size: "Tiny"; canRemove: false }
        ListElement { name: "Parrot"; desc: ""; size: "Small"; canRemove: true }
        ListElement { name: "Guinea pig"; desc: "The guinea pig, cavy or domestic guinea pig, or cuy for livestock breeds, is a species of rodent belonging to the family Caviidae and the genus Cavia"; size: "Small"; canRemove: false }
        ListElement { name: "Rat"; desc: ""; size: "Small"; canRemove: true }
        ListElement { name: "Butterfly"; desc: ""; size: "Small"; canRemove: false }
        ListElement { name: "Dog"; desc: ""; size: "Medium"; canRemove: true }
        ListElement { name: "Cat"; desc: ""; size: "Medium"; canRemove: false }
        ListElement { name: "Pony"; desc: ""; size: "Medium"; canRemove: true }
        ListElement { name: "Koala"; desc: ""; size: "Medium"; canRemove: false }
        ListElement { name: "Horse"; desc: ""; size: "Large"; canRemove: true }
        ListElement { name: "Tiger"; desc: ""; size: "Large"; canRemove: false }
        ListElement { name: "Giraffe"; desc: ""; size: "Large"; canRemove: true }
        ListElement { name: "Elephant"; desc: ""; size: "Huge"; canRemove: false }
        ListElement { name: "Whale"; desc: ""; size: "Huge"; canRemove: true }
    }

    ListView {
        id: view
        anchors.fill: parent
        clip: true
        model: animalsModel
        delegate: ListViewItemWithActions {
            id: item
            label: name
            description: desc
            showNext: false
            showActions: canRemove

            width: parent.width
            height: Theme.itemHeightLarge

            actions:[
                ActionButton {
                    iconSource: "image://theme/times"
                }

            ]
        }
        section.property: "size"
    }
}
