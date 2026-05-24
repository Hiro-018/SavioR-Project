import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: bar

    anchors {
        bottom: true
        left: true
        right: true
    }

    height: 80
    color: "transparent"
    exclusionMode: ExclusionMode.Normal

    property bool revealed: false


    MouseArea {
        id: edgezone
        width: 400
        height: 4
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        hoverEnabled: true
        onEntered: bar.revealed = true
    }

    MouseArea {
        id: hotzone
        width: 400
        height: 76
        anchors.bottom: edgezone.top
        anchors.horizontalCenter: parent.horizontalCenter
        hoverEnabled: true
        propagateComposedEvents: true

        onEntered: bar.revealed = true
        onExited: {
            if (!edgezone.containsMouse)
                bar.revealed = false
        }

        RowLayout {
            id: dock
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: bar.revealed ? 4 : -80
            spacing: 3

            Behavior on anchors.bottomMargin {
                NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
            }

            Repeater {
                model: ToplevelManager.toplevels

                delegate: Item {
                    required property Toplevel modelData

                    property bool hovered: false
                    width: 60
                    height: 60

                    function resolveIcon(appId) {
                        const map = {
                            "Spotify": "spotify",
                            "Opera GX": "opera",
                            "opera gx": "opera",
                        }
                        if (map[appId]) return "image://icon/" + map[appId]
                            return "image://icon/" + appId.toLowerCase().replace(/ /g, "-")
                    }

                    Rectangle {
                        anchors.fill: parent
                        radius: 8
                        color: modelData.activated ? "#f09e9e" : "transparent"
                        opacity: 0.15
                    }

                    Image {
                        anchors.centerIn: parent
                        width: 39
                        height: 39
                        source: resolveIcon(modelData.appId)
                        fillMode: Image.PreserveAspectFit
                        scale: parent.hovered ? 1.35 : 1.0

                        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }

                        onStatusChanged: {
                            if (status === Image.Error)
                                source = "image://icon/application-x-executable"
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.hovered = true
                        onExited: parent.hovered = false
                        onClicked: {
                            if (modelData.activated) {
                                modelData.setMinimized(true)
                            } else {
                                modelData.activate()
                            }
                        }
                    }
                }
            }
        }
    }
}
