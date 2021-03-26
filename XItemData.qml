import QtQuick 2.0

Rectangle {
    id:r
    width: parent.width-app.fs
    height: textData.contentHeight+app.fs*2
    color: app.c1
    anchors.horizontalCenter: parent.horizontalCenter
    property string text
    border.width: 2
    border.color: app.c2
    radius: app.fs*0.25
    Text{
        id: textData
        text: r.text
        font.pixelSize: apps.fs
        color: app.c2
        width: r.width-apps.fs
        wrapMode: Text.WordWrap
        anchors.centerIn: parent
    }
    Row{
        Repeater{
            model: 3
            Item{
                width: r.width/3
                height: r.height
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(index===0){
                            apps.fs--
                        }
                        if(index===2){
                            apps.fs++
                        }
                    }
                }
            }
        }
    }
}
