//MusicPlayer.qml

import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: playerWindow

    property bool open: false

    anchors {
        bottom: true
        right: true
    }

    implicitWidth: 280
    implicitHeight: 360
    color: "transparent"
    exclusionMode: ExclusionMode.Normal

    property var currentPlayer: Mpris.players.length > 0 ? Mpris.players[0] : null
    property bool isPlaying: currentPlayer !== null && currentPlayer.playbackState === MprisPlaybackState.Playing

    Rectangle {
        id: card
        width: 280
        height: 340
        radius: 16
        color: "#e6111118"
        border.color: "#ffffff0a"
        border.width: 1

        y: playerWindow.open ? 8 : 360
        Behavior on y { NumberAnimation { duration: 280; easing.type: Easing.OutCubic } }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 12

            Item {
                Layout.alignment: Qt.AlignHCenter
                width: 240
                height: 240

                Canvas {
                    id: progressArc
                    anchors.fill: parent
                    property real progress: {
                        if (!playerWindow.currentPlayer) return 0
                        var pos = playerWindow.currentPlayer.position
                        var dur = playerWindow.currentPlayer.length
                        return dur > 0 ? pos / dur : 0
                    }
                    onProgressChanged: requestPaint()
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        var cx = width / 2
                        var cy = height / 2
                        var r = width / 2 - 6

                        ctx.beginPath()
                        ctx.arc(cx, cy, r, 0, Math.PI * 2)
                        ctx.strokeStyle = "#ffffff10"
                        ctx.lineWidth = 4
                        ctx.stroke()

                        ctx.beginPath()
                        ctx.arc(cx, cy, r, -Math.PI / 2, -Math.PI / 2 + Math.PI * 2 * progress)
                        ctx.strokeStyle = "#3ef0f0"
                        ctx.lineWidth = 4
                        ctx.lineCap = "round"
                        ctx.stroke()
                    }
                }

                Disc {
                    anchors.centerIn: parent
                    width: 210
                    height: 210
                    albumArt: playerWindow.currentPlayer ? (playerWindow.currentPlayer.trackArtUrl ?? "") : ""
                    playing: playerWindow.isPlaying
                }
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 4

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: playerWindow.currentPlayer ? (playerWindow.currentPlayer.trackTitle ?? "Nothing playing") : "Nothing playing"
                    color: "#ffffff"
                    font.pixelSize: 14
                    font.weight: Font.Medium
                    elide: Text.ElideRight
                    width: 220
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: playerWindow.currentPlayer ? (playerWindow.currentPlayer.trackArtist ?? "") : ""
                    color: "#888888"
                    font.pixelSize: 12
                    elide: Text.ElideRight
                    width: 220
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Controls {
                Layout.alignment: Qt.AlignHCenter
                player: playerWindow.currentPlayer
            }
        }
    }

    Timer {
        interval: 1000
        running: playerWindow.isPlaying
        repeat: true
        onTriggered: progressArc.requestPaint()
    }

    Component.onCompleted: {
        console.log("MPRIS players found:", Mpris.players.length)
        for (var i = 0; i < Mpris.players.length; i++) {
            console.log("player", i, ":", Mpris.players[i].identity)
        }
    }
}