import QtQuick 2.1
import QtQuick.Controls 1.0 //needed for the Stack attached property
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Page {
    id: root

    headerTools: HeaderToolsLayout {
        showBackButton: true;
        title: "Roller"
    }

    allowedOrientations: Qt.PortraitOrientation | Qt.LandscapeOrientation | Qt.InvertedLandscapeOrientation | Qt.InvertedPortraitOrientation


    ListModel {
        id: animalsModel
        ListElement { name: "Ant";}
        ListElement { name: "Flea"; }
        ListElement { name: "Parrot"; }
        ListElement { name: "Guinea pig";}
        ListElement { name: "Rat";}
        ListElement { name: "Butterfly";}
        ListElement { name: "Dog";}
        ListElement { name: "Cat";}
        ListElement { name: "Pony";}
        ListElement { name: "Koala";}
        ListElement { name: "Horse";}
        ListElement { name: "Tiger";}
        ListElement { name: "Giraffe";}
        ListElement { name: "Elephant";}
        ListElement { name: "Whale";}
    }


    GlacierRoller {
        id: simpleRoller
        width: parent.width
        anchors{
            top: parent.top
            topMargin: 40
        }

        clip: true
        model: animalsModel
        label: qsTr("Choose your favorite animal")
        delegate:Text{
            height: simpleRoller.itemHeight
            text: name
            color: "white"
            font.pixelSize: 32
            font.bold: (simpleRoller.active && ListView.view.currentIndex === index)

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(!simpleRoller.active)
                    {
                        simpleRoller.active = true;
                    }
                    else
                    {
                        simpleRoller.currentIndex = index
                        simpleRoller.active = false
                    }
                }
            }
        }
    }

    GlacierRoller {
        id: simpleRoller2
        width: parent.width
        anchors{
            top: simpleRoller.bottom
            topMargin: 40
        }

        clip: true
        model: animalsModel
        label: qsTr("Choose your second favorite animal")
        delegate:Text{
            height: simpleRoller2.itemHeight
            text: name
            color: "white"
            font.pixelSize: 32
            font.bold: (simpleRoller2.active && ListView.view.currentIndex === index)

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(!simpleRoller2.active)
                    {
                        simpleRoller2.active = true;
                    }
                    else
                    {
                        simpleRoller2.currentIndex = index
                        simpleRoller2.active = false
                    }
                }
            }
        }
    }
}
