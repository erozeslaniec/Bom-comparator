import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.15
import QtQml 2.15


Window {
    id: mainWindow
    width: 640
    height: 300
    visible: true
    title: qsTr("Bom Comparator 3000")
    property string dominantColor: "#C0C0C0"
    property string lighterColor: "#d9d9d9"
    property string textColor: "#434343"
    color: dominantColor

    Connections{
        target: backend

        function onSubmitText1Signal(str){
            textLabel1.text = str
        }

        function onSubmitText2Signal(str){
            textLabel2.text = str
        }
    }

    Image{
        id: logo
        anchors.right: parent.right
        anchors.top: parent.top
        height: 50
        fillMode: Image.PreserveAspectFit
        source: "../img/bitmaps/logo grafotronic.jpg"
    }

    Row{
        id: dropRow
        width: parent.width
        height: 100
        anchors.centerIn: parent
        Rectangle{
            width: parent.width/2
            height: parent.height
            color: dominantColor
            border.color: textColor
            border.width: 1
            clip: true

            Text {
                color: textColor
                id: textLabel1
                width: 200
                wrapMode: Text.WordWrap
                anchors.centerIn: parent
                text: qsTr("Drop an origin\nBOM file")
                horizontalAlignment: Text.AlignHCenter
                font.family: "Verdana"


            }
            DropArea {
                id: dropArea1;
                anchors.fill: parent
                onEntered: {
                    parent.color = lighterColor
                    drag.accept (Qt.LinkAction);
                }
                onDropped: {
                    console.log(drop.urls)
                    parent.color = dominantColor

                    backend.addFirstFile(drop.urls[0])
                }
                onExited: {
                    parent.color = dominantColor
                }
            }
        }

        Rectangle{
            width: parent.width/2
            height: parent.height
            color: mainWindow.color
            border.color: textColor
            border.width: 1
            clip: true
            Text {
                id: textLabel2
                width: 200
                wrapMode: Text.WordWrap
                anchors.centerIn: parent
                color: textColor
                text: qsTr("Drop a file\ncontaining changes")
                horizontalAlignment: Text.AlignHCenter
                font.family: "Verdana"

            }
            DropArea {
                id: dropArea2;
                anchors.fill: parent
                onEntered: {
                    parent.color = lighterColor
                    drag.accept (Qt.LinkAction);
                }
                onDropped: {
                    console.log(drop.urls)
                    parent.color = dominantColor
                    textLabel2.text=drop.urls[0]
                    backend.addSecondFile(drop.urls[0])
                }
                onExited: {
                    parent.color = dominantColor
                }
            }
        }
    }

    Button {
        id: button
        anchors.top: dropRow.bottom

        anchors.topMargin: 10
        anchors.horizontalCenter:parent.horizontalCenter
        width: 200
        height: 40
        text: qsTr("Compare")
        onClicked: {
            backend.compareReq()
        }
    }


}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.25}
}
##^##*/
