import QtQuick 2.0
import QtQuick.Particles 2.0
import "Generator.js" as Generator
Item{
    id:rocket
    width: 200
    height: 300
    Canvas {
        id:canvas
        width:200
        height:285
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        property color strokeStyle:  "#1A1A1A"//grey
        property color fillStyle: "#E3E3E3" // grey-blue?
        property int lineWidth: 2//lineWidthCtrl.value
//        property int lineWidthIn: lineWidthCtrl.value
        property bool fill: true
        property bool stroke: true
        property real alpha: 1.0
        antialiasing: true

        onLineWidthChanged:requestPaint();
        onFillChanged:requestPaint();
        onStrokeChanged:requestPaint();

        onPaint: {
            var ctx = canvas.getContext('2d');
            var originX = 0
            var originY = 0
            ctx.globalAlpha = canvas.alpha;
            ctx.strokeStyle = canvas.strokeStyle;
            ctx.fillStyle = canvas.fillStyle;
            ctx.lineWidth = canvas.lineWidth;
            ctx.translate(originX, originY)
            ctx.translate(-originX, -originY)
            ctx.moveTo(100,0);
            ctx.beginPath();
            ctx.lineTo(100,10);//шпиль
            ctx.quadraticCurveTo(108,25,110,35);//конус
            ctx.lineTo(110,180);//тело
            ctx.quadraticCurveTo(118,220,125,280);//юбка бок пр
            ctx.quadraticCurveTo(117,285,102,282);//юбка низ пр
            ctx.lineTo(98,282);//юбка низ
            ctx.quadraticCurveTo(80,285,75,280);//юбка низ лев
            ctx.quadraticCurveTo(82,220,90,180);//юбка бок лев
            ctx.lineTo(90,35);
            ctx.quadraticCurveTo(92,25,100,10);
            ctx.lineTo(100,0);
            ctx.fill();
            ctx.moveTo(110,35);
            ctx.closePath();
            ctx.quadraticCurveTo(100,38,90,35);//конус - тело
            ctx.moveTo(110,180);
            ctx.quadraticCurveTo(100,183,90,180);//тело - юбка
            ctx.quadraticCurveTo(95,195,98,282);//юбка - лев
            ctx.moveTo(110,180);
            ctx.quadraticCurveTo(105,195,102,282);//юбка - лев

            ctx.stroke();
            ctx.restore();
        }
    }


    Timer{
        id:timerLaunch
        interval: 5000
        running:false
        repeat:false
        onTriggered: {

        }
    }

    Timer{
        id:timerTakeOff
        interval: 10000;
        running:false
        repeat:false
        onTriggered: {
            var a,b
            a=rocket.x
            b=rocket.y
            anchors.bottom=undefined
            rocket.x=a
            rocket.y=b
            dropYAnim.duration = 20000;
            dropAnim.running = true;
            createDots();
        }
    }

    Timer{
        id:timerPostTakeOff
        interval: 11000;
        running: false
        repeat: false
        onTriggered: {

        }
    }

    Component.onCompleted: {
        timerTakeOff.running=true;
        timerLaunch.running=true;
        timerPostTakeOff.running=true;
    }

    SequentialAnimation on y{
        id: dropAnim
        running: false
        NumberAnimation {
            id: dropYAnim
            to: 0-rocket.height-400

        }

    }

    function createDots(){
        Generator.createObjects("Particles.qml", main, function(flameDot){
            flameDot.x=rocket.x+Math.random()%500;
            flameDot.y=rocket.y+Math.random()%100;
        });
    }



}
