//Disc.qml
import QtQuick

Item {
    id: root

    property string albumArt: ""
    property bool playing: false

    width: 220
    height: 220

    RotationAnimation {
        id: spinAnim
        target: discRotator
        from: 0
        to: 360
        duration: 8000
        loops: Animation.Infinite
        running: root.playing
        easing.type: Easing.Linear
    }

    Item {
        id: discRotator
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        Rectangle {
            anchors.fill: parent
            radius: width / 2
            color: "#1a1a1a"
            border.color: "#333333"
            border.width: 2
        }

        Rectangle {
            id: artClip
            anchors.centerIn: parent
            width: parent.width - 20
            height: parent.height - 20
            radius: width / 2
            clip: true
            color: "#2a1a2e"

            Image {
                anchors.fill: parent
                source: root.albumArt !== "" ? root.albumArt : ""
                fillMode: Image.PreserveAspectCrop
                visible: root.albumArt !== ""
            }
        }

        Rectangle {
            anchors.centerIn: parent
            width: parent.width * 0.55
            height: parent.width * 0.55
            radius: width / 2
            color: "transparent"
            border.color: "#ffffff08"
            border.width: 1
        }

        Rectangle {
            anchors.centerIn: parent
            width: parent.width * 0.4
            height: parent.width * 0.4
            radius: width / 2
            color: "transparent"
            border.color: "#ffffff08"
            border.width: 1
        }

        Rectangle {
            anchors.centerIn: parent
            width: 28
            height: 28
            radius: width / 2
            color: "#0d0d0d"
            border.color: "#444444"
            border.width: 1
        }
    }
}