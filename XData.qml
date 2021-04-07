import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: r
    anchors.fill: parent
    property bool desplegado: xPlanetas.currentIndex!==0//cbPlanetas.currentIndex!==0
    property alias contentY: flick.contentY
    signal flickYChanged()
    Flickable{
        id: flick
        anchors.fill: r
        contentWidth: r.width
        contentHeight: col1.height+app.fs*8
        property int uContentY: 0
        onContentYChanged: {
            r.flickYChanged()
        }
        Column{
            id: col1
            anchors.top: parent.top
            anchors.topMargin: app.fs*5
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: app.fs
            Row{
                visible: false
                spacing: app.fs*0.5
                Text{
                    id: labelPlanetas
                    text: 'Planeta: '
                    font.pixelSize: app.fs
                    color: app.c2
                    anchors.verticalCenter: parent.verticalCenter
                }
                ComboBox{
                    id: cbPlanetas
                    font.pixelSize: app.fs
                    width: r.width-labelPlanetas.contentWidth-app.fs
                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.horizontalCenter: parent.horizontalCenter
                    model: app.planetas
                    onCurrentIndexChanged: updateData()
                    Rectangle{
                        width: parent.width+4
                        height: parent.height+4
                        color: 'transparent'
                        border.width: 3
                        border.color: 'red'
                        //z: parent.z-1
                        anchors.centerIn: parent
                        visible: parent.focus
                    }
                }
            }
            XPlanetas{
                id: xPlanetas
                onCurrentIndexChanged: updateData()
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: app.fs*2
                //visible: false
                visible: xPlanetas.currentIndex!==0//cbPlanetas.currentIndex!==0
                onVisibleChanged: {
                    if(!visible){
                        rb1.checked=false
                        rb2.checked=false
                    }
                }
                Row{
                    Text{
                        text: 'Signo'
                        font.pixelSize: app.fs
                        color: app.c2
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    RadioButton{
                        id: rb1
                        onCheckedChanged: {
                            if(checked){
                                rb2.checked=false
                            }
                        }
                    }
                }
                Row{
                    Text{
                        text: 'Casa'
                        font.pixelSize: app.fs
                        color: app.c2
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    RadioButton{
                        id: rb2
                        onCheckedChanged: {
                            if(checked){
                                rb1.checked=false
                            }
                        }
                    }
                }
            }
            XCasas{
                id:xCasas
                visible: rb2.checked
                onCurrentIndexChanged: updateData()
            }
            XSignos{
                id: xSignos
                visible: rb1.checked
                onCurrentIndexChanged: updateData()
            }
            Column{
                id: col2
                width: r.width
                spacing: app.fs*0.25
            }
        }
    }
    function updateData(){
        for(var i=0;i<col2.children.length;i++){
            col2.children[i].destroy(1)
        }
        flick.contentX=0
        getJSON()
    }
    function setData(json){
        let tipo=xSignos.visible?'s':'h'
        let num=xSignos.visible?xSignos.currentIndex:parseInt(xCasas.currentIndex + 1)
        let data=json[tipo+''+num]
        if(!data){
            return
        }
        let dataItems=data.split('|')
        for(var i=0;i<dataItems.length;i++){
            let comp=Qt.createComponent('XItemData.qml')
            let obj=comp.createObject(col2, {text:dataItems[i]})
        }
    }
    function getJSON() {
        var request = new XMLHttpRequest()

        //Url GitHub Raw Data
        //https://github.com/nextsigner/quiron/raw/main/data/pluton.json

        //Url File Local Data
        //'file:///home/ns/Documentos/unik/quiron/data/neptuno.json'

        //let jsonFileUrl='file://'+pws+'/quiron/data/'+cbPlanetas.currentText+'.json'

        let jsonFileUrl='file://'+pws+'/quiron/data/'+app.planetas[xPlanetas.currentIndex]+'.json'
        console.log('jsonFileUrl: '+jsonFileUrl)
        request.open('GET', jsonFileUrl, true);
        //request.open('GET', 'https://github.com/nextsigner/quiron/raw/main/data/'+cbPlanetas.currentText+'.json', true);
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status && request.status === 200) {
                    console.log("response", request.responseText)
                    var result = JSON.parse(request.responseText)
                    if(result){
                        setData(result)
                    }
                    //console.log('Data-->'+JSON.stringify(result))
                } else {
                    console.log("HTTP:", request.status, request.statusText)
                }
            }
        }
        request.send()
    }
    function reset(){
        xSignos.currentIndex=0
        xCasas.currentIndex=0
        rb1.checked=false
        rb2.checked=false
        updateData()
        cbPlanetas.currentIndex=0
        cbPlanetas.focus=true
    }
    function a1(){
        rb1.checked=false
        rb2.checked=false
        cbPlanetas.focus=true
        updateData()
    }
    function a2(){
        rb1.checked=true
        cbSignos.focus=true
        updateData()
    }
    function a3(){
        rb2.checked=true
        //cbCasas.focus=true
        updateData()
    }
}
