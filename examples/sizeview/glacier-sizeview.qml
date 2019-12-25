import QtQuick 2.6
import QtQuick.Window 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0


ApplicationWindow {
    id: appWindow

    initialPage: Page {
        id: root

        headerTools: HeaderToolsLayout {
            id: tools
            title: "Example"
        }

        Component.onCompleted: {
            console.log("iconSizeLauncher:"+Theme.iconSizeLauncher)

            console.log("itemWidthLarge:"+Theme.itemWidthLarge)
            console.log("itemWidthMedium:"+Theme.itemWidthMedium)
            console.log("itemWidthSmall:"+Theme.itemWidthSmall)
            console.log("itemWidthExtraSmall:"+Theme.itemWidthExtraSmall)

            console.log("itemHeightHuge:"+Theme.itemHeightHuge)
            console.log("itemHeightExtraLarge:"+Theme.itemHeightExtraLarge)
            console.log("itemHeightLarge:"+Theme.itemHeightLarge)
            console.log("itemHeightMedium:"+Theme.itemHeightMedium)
            console.log("itemHeightSmall:"+Theme.itemHeightSmall)
            console.log("itemHeightExtraSmall:"+Theme.itemHeightExtraSmall)

            console.log("itemSpacingHuge:"+Theme.itemSpacingHuge)
            console.log("itemSpacingLarge:"+Theme.itemSpacingLarge)
            console.log("itemSpacingMedium:"+Theme.itemSpacingMedium)
            console.log("itemSpacingSmall:"+Theme.itemSpacingSmall)
            console.log("itemSpacingExtraSmall:"+Theme.itemSpacingExtraSmall)

            console.log("fontSizeExtraLarge:"+Theme.fontSizeExtraLarge)
            console.log("fontSizeLarge:"+Theme.fontSizeLarge)
            console.log("fontSizeMedium:"+Theme.fontSizeMedium)
            console.log("fontSizeSmall:"+Theme.fontSizeSmall)
            console.log("fontSizeTiny:"+Theme.fontSizeTiny)

            console.log("fontWeightLarge:"+Theme.fontWeightLarge)
            console.log("fontWeightMedium:"+Theme.fontWeightMedium)

            console.log("fontFamily:"+Theme.fontFamily)

            console.log("accentColor:"+Theme.accentColor)
            console.log("fillColor:"+Theme.fillColor)
            console.log("fillDarkColor:"+Theme.fillDarkColor)
            console.log("textColor:"+Theme.textColor)
            console.log("backgroundColor:"+Theme.backgroundColor)
            console.log("backgroundAccentColor:"+Theme.backgroundAccentColor)
        }

        Flickable{
            id: mainArea
            height: parent.height-tools.height
            width: parent.width

            contentHeight: content.height

            Column {
                id: content
                width: parent.width
                spacing: size.dp(20)

                Label{
                    text: qsTr("iconSizeLauncher:")+Theme.iconSizeLauncher
                }

                Rectangle{
                    color: Theme.accentColor
                    width: Theme.itemWidthLarge
                    height: Theme.itemHeightMedium

                    Label{
                        text: "Theme.itemWidthLarge"
                    }
                }

                Rectangle{
                    color: Theme.accentColor
                    width: Theme.itemWidthMedium
                    height: Theme.itemHeightMedium

                    Label{
                        text: "Theme.itemWidthMedium"
                    }
                }
                Rectangle{
                    color: Theme.accentColor
                    width: Theme.itemWidthSmall
                    height: Theme.itemHeightMedium

                    Label{
                        text: "Theme.itemWidthSmall"
                    }
                }
                Rectangle{
                    color: Theme.accentColor
                    width: Theme.itemWidthExtraSmall
                    height: Theme.itemHeightMedium

                    Label{
                        text: "Theme.itemWidthExtraSmall"
                    }
                }
                Rectangle{
                    color: Theme.accentColor
                    width: Theme.itemWidthMedium
                    height: Theme.itemHeightHuge

                    Label{
                        text: "Theme.itemHeightHuge"
                    }
                }
                Rectangle{
                    color: Theme.accentColor
                    width: Theme.itemWidthMedium
                    height: Theme.itemHeightExtraLarge

                    Label{
                        text: "Theme.itemHeightExtraLarge"
                    }
                }
                Rectangle{
                    color: Theme.accentColor
                    width: Theme.itemWidthMedium
                    height: Theme.itemHeightLarge

                    Label{
                        text: "Theme.itemHeightLarge"
                    }
                }
                Rectangle{
                    color: Theme.accentColor
                    width: Theme.itemWidthMedium
                    height: Theme.itemHeightMedium

                    Label{
                        text: "Theme.itemHeightMedium"
                    }
                }
                Rectangle{
                    color: Theme.accentColor
                    width: Theme.itemWidthMedium
                    height: Theme.itemHeightSmall

                    Label{
                        text: "Theme.itemHeightSmall"
                    }
                }
                Rectangle{
                    color: Theme.accentColor
                    width: Theme.itemWidthMedium
                    height: Theme.itemHeightExtraSmall

                    Label{
                        text: "Theme.itemHeightExtraSmall"
                    }
                }
                Row{
                    Rectangle{
                        width: Theme.itemSpacingHuge
                        height: parent.height
                        color: Theme.accentColor
                    }
                    Label{
                        text: "Theme.itemSpacingHuge"
                    }
                }
                Row{
                    Rectangle{
                        width: Theme.itemSpacingLarge
                        height: parent.height
                        color: Theme.accentColor
                    }
                    Label{
                        text: "Theme.itemSpacingLarge"
                    }
                }

                Row{
                    Rectangle{
                        width: Theme.itemSpacingMedium
                        height: parent.height
                        color: Theme.accentColor
                    }
                    Label{
                        text: "Theme.itemSpacingMedium"
                    }
                }

                Row{
                    Rectangle{
                        width: Theme.itemSpacingSmall
                        height: parent.height
                        color: Theme.accentColor
                    }
                    Label{
                        text: "Theme.itemSpacingSmall"
                    }
                }

                Row{
                    Rectangle{
                        width: Theme.itemSpacingExtraSmall
                        height: parent.height
                        color: Theme.accentColor
                    }
                    Label{
                        text: "Theme.itemSpacingExtraSmall"
                    }
                }

                Label{
                    text: "fontSizeExtraLarge"
                    font.pixelSize: Theme.fontSizeExtraLarge
                }

                Label{
                    text: "fontSizeLarge"
                    font.pixelSize: Theme.fontSizeLarge
                }

                Label{
                    text: "fontSizeMedium"
                    font.pixelSize: Theme.fontSizeMedium
                }

                Label{
                    text: "fontSizeSmall"
                    font.pixelSize: Theme.fontSizeSmall
                }

                Label{
                    text: "fontSizeTiny"
                    font.pixelSize: Theme.fontSizeTiny
                }
            }
        }
    }
}
