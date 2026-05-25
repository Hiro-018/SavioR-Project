//TileGrid.qml

import Quickshell
import QtQuick

Item {
    id: root
    signal appLaunched()

    readonly property int unit: 90
    readonly property int gap: 6
    readonly property var accents: [
        "#1e2a3a",
        "#1a2a2a",
        "#2a1a2e",
        "#1a2e1a",
        "#2e1a1a",
    ]

    GridView {
        id: grid
        anchors.fill: parent
        anchors.margins: 24
        cellWidth: root.unit + root.gap
        cellHeight: root.unit + root.gap
        clip: true
        model: DesktopEntries.applications

        delegate: Item {
            required property DesktopEntry modelData
            required property int index

            width: root.unit + root.gap
            height: root.unit + root.gap

            Rectangle {
                anchors.centerIn: parent
                width: root.unit
                height: root.unit
                radius: 4
                color: root.accents[index % root.accents.length]
                border.color: "#ffffff08"
                border.width: 1

                Image {
                    anchors.centerIn: parent
                    width: parent.width * 0.5
                    height: parent.height * 0.5
                    source: (modelData.icon !== undefined && modelData.icon !== "")
                    ? "image://icon/" + modelData.icon
                    : "image://icon/application-x-executable"
                    fillMode: Image.PreserveAspectFit
                    onStatusChanged: {
                        if (status === Image.Error)
                            source = "image://icon/application-x-executable"
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: "#3ef0f0"
                    opacity: tileHover.containsMouse ? 0.07 : 0
                    Behavior on opacity { NumberAnimation { duration: 150 } }
                }

                MouseArea {
                    id: tileHover
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        console.log("launching:", modelData.appId)
                        modelData.execute()
                        root.appLaunched()
                    }
                }
            }
        }
    }
}
