//Launcher.qml

import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: launcher
    property bool open: false

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: "transparent"
    visible: open

    Rectangle {
        id: bg
        anchors.fill: parent
        color: "#e61a1a2e"
        opacity: launcher.open ? 1 : 0

        Behavior on opacity { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }

        TileGrid {
            anchors.fill: parent
            onAppLaunched: launcher.open = false
        }
    }
}
