import QtQuick 2.0
import QtGraphicalEffects 1.12

Item {
    id: r
    width: parent.width
    height: g.height
    property int currentIndex: -1
    Flickable{
        id: f
        width: r.width
        height: r.height+app.fs*2
        contentWidth: g.width//*1.25
        contentHeight: height
        anchors.verticalCenter: r.verticalCenter
        anchors.left: parent.left
        boundsBehavior: Flickable.StopAtBounds
        Grid{
            id: g
            columns: 12//app.rot?6:3
            spacing: app.fs*0.5//app.rot?app.fs*0.25:app.fs
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            //anchors.horizontalCenter: parent.horizontalCenter
            Repeater{
                id: repIconPlanetas
                model: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Jupiter', 'Saturno', 'Urano', 'Neptuno', 'Pluton']
                BotonUX{
                    id: xBotPlaneta
                    width: app.rot?app.fs*3:app.fs*3
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
                            width: xBotPlaneta.width*0.7
                            height: width
                            anchors.horizontalCenter: parent.horizontalCenter
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
                            font.pixelSize: app.fs*0.5
                            color: xBotPlaneta.hovered?app.c1:app.c2
                        }
                    }
                }
            }
        }
    }
}
