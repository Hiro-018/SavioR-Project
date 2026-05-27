//shell.qml
import Quickshell
import "./taskbar"
import "./launcher"
import "./mediaplayer"

ShellRoot {
    property bool launcherOpen: false
    property bool playerOpen: false

    Bar {}

    Launcher {
        open: launcherOpen
    }

    MusicPlayer {
        open: playerOpen
    }

    // launcher trigger — bottom left
    PanelWindow {
        anchors { bottom: true; left: true }
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

    // player trigger — bottom right
    PanelWindow {
        anchors { bottom: true; right: true }
        implicitWidth: 80
        implicitHeight: 80
        color: "transparent"
        exclusionMode: ExclusionMode.Normal

        PlayerTrigger {
            anchors.fill: parent
            forceShow: playerOpen
                onClicked: playerOpen = !playerOpen
        }
    }
}
