import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import Qt.labs.settings 1.1

ApplicationWindow {
        id: app
        visible: true
        visibility: Qt.platform.os==='android'?"Maximized":"Windowed"
        width: Qt.platform.os==='android'?Screen.width:300
        height: Qt.platform.os==='android'?Screen.height:600
        title: 'Quirón'
        color: c1
        property string moduleName: 'quiron'//Mercurio Data Desktop Gadget
        property int fs: Qt.platform.os==='android'?width*0.06:width*0.06
        property color c1: 'black'
        property color c2: 'white'
        property color c3: 'red'
        property color c4: 'green'

        property var planetas: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton']//['seleccionar','venus', 'saturno', 'neptuno', 'pluton', 'urano']
        property var signos: ['seleccionar','aries', 'tauro','geminis', 'cancer', 'leo', 'virgo','libra', 'escorpio', 'sagitario', 'capricornio', 'acuario', 'piscis']

        Settings{
            id: apps
            fileName: app.moduleName+'.cfg'
            property int fs: 14
        }
        USettings{
            id: unikSettings
            //url:pws+'/launcher.json'
            url:pws+'/quiron.json'
            function refresh(){
                var nc=unikSettings.currentNumColor
                if(unikSettings.defaultColors){
                    var cc1=unikSettings.defaultColors.split('|')
                    var cc2=cc1[nc].split('-')
                    app.c1=cc2[0]
                    app.c2=cc2[1]
                    app.c3=cc2[2]
                    app.c4=cc2[3]
                    app.visible=true
                }
            }
            Component.onCompleted: refresh()
            onDataChanged:  refresh()
            onCurrentNumColorChanged: {
                if(unikSettings.sound&&currentNumColor>=0){
                    let s=unikSettings.lang==='es'?'Color actual ':'Current color  '
                    s+=parseInt(currentNumColor+1)
                    speak(s)
                }
            }
        }
        Item{
            id: xApp
            anchors.fill: parent
            XData{
                id: xData
                onFlickYChanged: {
                    xTopBar.state=xData.contentY===0?'activo':'inactivo'
                }
            }
            XTopBar{
                id: xTopBar
                //state: xData.contentY===0?'activo':'inactivo'
            }
        }
        Component.onCompleted: {          
            xData.a1()
        }
}
