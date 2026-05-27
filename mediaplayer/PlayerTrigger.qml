//TriggerButton
import Quickshell
import Quickshell.Wayland
import QtQuick

Item {
    id: root
    property bool revealed: false
    property bool forceShow: false
    signal clicked()

    MouseArea {
        id: edgezone
        width: 80
        height: 4
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        hoverEnabled: true
        onEntered: root.revealed = true
    }

    MouseArea {
        id: hotzone
        width: 80
        height: 76
        anchors.bottom: edgezone.top
        anchors.right: parent.right
        hoverEnabled: true
        propagateComposedEvents: true

        onEntered: root.revealed = true
        onExited: {
            if (!edgezone.containsMouse)
                root.revealed = false
        }
        onClicked: root.clicked()

        Image {
            anchors.centerIn: parent
            width: 28
            height: 28
            source: "image://icon/media-playback-start"
            fillMode: Image.PreserveAspectFit
            opacity: root.revealed || root.forceShow ? 1 : 0
            scale: root.revealed || root.forceShow ? 1 : 0.7

            Behavior on opacity { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }
            Behavior on scale { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }
        }
    }
}
