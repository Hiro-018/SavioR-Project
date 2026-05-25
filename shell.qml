//shell.qml

import Quickshell
import "./taskbar"
import "./launcher"

ShellRoot {
    property bool launcherOpen: false

    Bar {}

    Launcher {
        open: launcherOpen
    }

    PanelWindow {
        anchors {
            bottom: true
            left: true
        }
        implicitWidth: 80
        implicitHeight: 80
        color: "transparent"
        exclusionMode: ExclusionMode.Normal

        TriggerButton {
            anchors.fill: parent
            forceshow: launcherOpen
                onClicked: launcherOpen = !launcherOpen
        }
    }
}
