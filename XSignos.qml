import QtQuick 2.0
import QtGraphicalEffects 1.12

Item {
    id: r
    width: parent.width
    height: g.height
    property int currentIndex: -1
    Grid{
        id: g
        columns: 4//app.rot?6:3
        spacing: app.fs*0.5//app.rot?app.fs*0.25:app.fs
        //anchors.verticalCenter: parent.verticalCenter
        //anchors.left: parent.left
        anchors.horizontalCenter: parent.horizontalCenter
        Repeater{
            id: repIconPlanetas
            model: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
            BotonUX{
                id: xBotSigno
                width: app.rot?app.fs*3.5:app.fs*3.5
                height: width
                text: ''
                fontSize: app.fs*0.5
                //fontSize: app.rot?app.fs:app.fs
                onClicked: {
                    //r.cCasa=index
                    r.currentIndex=index
                }
                fontColor: index===r.currentIndex?app.c1:app.c2
                backgroudColor: index===r.currentIndex?app.c1:app.c2
                bg.color: index===r.currentIndex?app.c2:app.c1
                Column{
                    anchors.centerIn: parent
                    spacing: 0-app.fs*0.5
                    Item{
                        width: xBotSigno.width*0.7
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        Image {
                            id: iconoPlaneta
                            source: "./imgs/signos/"+index+".png"
                            visible: false
                            anchors.fill: parent
                        }
                        ColorOverlay {
                            anchors.fill: iconoPlaneta
                            source: iconoPlaneta
                            color: xBotSigno.hovered?app.c1:app.c2
                        }
                    }
                    UText{
                        text: modelData
                        width: contentWidth
                        //height: app.fs
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: app.fs*0.5
                        color: xBotSigno.hovered?app.c1:app.c2
                    }
                }
            }
        }
    }

}
