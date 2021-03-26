import QtQuick 2.0
import QtGraphicalEffects 1.12

Item {
    id: r
    visible: false
    Grid{
        columns: app.rot?6:3
        spacing: app.rot?app.fs*0.25:app.fs
        anchors.horizontalCenter: parent.horizontalCenter
        Repeater{
            id: repIconPlanetas
            model: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Jupiter', 'Saturno', 'Urano', 'Neptuno', 'Pluton']
            BotonUX{
                id: xBotPlaneta
                width: app.rot?app.fs*5.5:app.fs*5.5
                height: width
                text: ''
                fontSize: app.fs
                //fontSize: app.rot?app.fs:app.fs
                onClicked: r.cCasa=index
                Column{
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 0-app.fs*0.5
                    spacing: 0-app.fs*0.5
                    Item{
                        width: xBotPlaneta.width*0.7
                        height: width
                        Image {
                            id: iconoPlaneta
                            source: "./imgs/planetas/"+(''+modelData).toLowerCase()+".png"
                            visible: false
                            anchors.fill: parent
                        }
                        ColorOverlay {
                            anchors.fill: iconoPlaneta
                            source: iconoPlaneta
                            color: xBotPlaneta.hovered?app.c1:app.c2
                        }
                    }
                    UText{
                        text: modelData
                        width: contentWidth
                        //height: app.fs
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: app.fs*0.8
                        color: xBotPlaneta.hovered?app.c1:app.c2
                    }
                }
            }
        }
    }
}
