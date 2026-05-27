//Controls.qml
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

Item {
    id: root
    property var player: null

    implicitWidth: 160
    implicitHeight: 40

    RowLayout {
        anchors.centerIn: parent
        spacing: 16

        Text {
            text: "⏮"
            font.pixelSize: 18
            color: prevHover.containsMouse ? "#3ef0f0" : "#888888"
            Behavior on color { ColorAnimation { duration: 120 } }
            MouseArea {
                id: prevHover
                anchors.fill: parent
                hoverEnabled: true
                onClicked: if (root.player) root.player.previous()
            }
        }

        Rectangle {
            width: 40
            height: 40
            radius: width / 2
            color: playHover.containsMouse ? "#3ef0f0" : "#ffffff15"
            Behavior on color { ColorAnimation { duration: 120 } }

            Text {
                anchors.centerIn: parent
                text: root.player && root.player.playbackState === MprisPlaybackState.Playing ? "⏸" : "▶"
                font.pixelSize: 16
                color: playHover.containsMouse ? "#0d0d0d" : "#ffffff"
                Behavior on color { ColorAnimation { duration: 120 } }
            }

            MouseArea {
                id: playHover
                anchors.fill: parent
                hoverEnabled: true
                onClicked: if (root.player) root.player.togglePlaying()
            }
        }

        Text {
            text: "⏭"
            font.pixelSize: 18
            color: nextHover.containsMouse ? "#3ef0f0" : "#888888"
            Behavior on color { ColorAnimation { duration: 120 } }
            MouseArea {
                id: nextHover
                anchors.fill: parent
                hoverEnabled: true
                onClicked: if (root.player) root.player.next()
            }
        }
    }
}