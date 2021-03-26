import QtQuick 2.0

Item {
    id: r
    width: parent.width
    height: 1
    state: 'activo'
    states: [
        State {
            name: "activo"
            PropertyChanges {
                target: xTopBar
                y:0
            }
        },
        State {
            name: "inactivo"
            PropertyChanges {
                target: xTopBar
                y:0-xTopBar.height
            }
        }
    ]
    Rectangle{
        id: xTopBar
        width: parent.width
        height: app.fs*4
        Behavior on y{NumberAnimation{duration: 250}}
        Rectangle{width: r.width;height: 2;color: 'gray';anchors.bottom: r.bottom}
        Text{
            id: tit
            font.pixelSize: app.fs*1.5
            text: '<b>Quirón by @nextisgner</b>'
            anchors.centerIn: parent
        }
    }
}
