import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.12
import Qt.labs.settings 1.0

ApplicationWindow {
        id: app
        visible: true
        visibility: Qt.platform.os==='android'?"Maximized":"Windowed"
        width: Qt.platform.os==='android'?Screen.width:300
        height: Qt.platform.os==='android'?Screen.height:600
        title: 'Mercurio Data para Android'
        color: c1
        property string moduleName: 'mddg'//Mercurio Data Desktop Gadget
        property int fs: width*0.05
        property color c1: 'black'
        property color c2: 'white'
        property color c3: 'red'
        property color c4: 'green'

        property var planetas: ['seleccionar','neptuno', 'pluton']
        property var signos: ['seleccionar','aries', 'tauro','geminis', 'cancer', 'leo', 'virgo','libra', 'escorpio', 'sagitario', 'capricornio', 'acuario', 'piscis']

        Settings{
            id: apps
            fileName: app.moduleName+'.cfg'
            property int fs: 14
        }
        Item{
            id: xApp
            anchors.fill: parent
            XData{id: xData}
        }
        Component.onCompleted: {          
            xData.a1()
        }
}
