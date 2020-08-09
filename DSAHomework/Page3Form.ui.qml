import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtCharts 2.3
import QtCharts 2.2

Item {
    id: item1
    property alias columnLayout: columnLayout
    property alias chartView: chartView

    Connections {
        target: netManager
        onValueUpdated3: {

            series3.append(x, y)
            if (x > xAxis.max) {
                xAxis.max = x
            }
            if (y > yAxis.max) {
                yAxis.max = y
            }
        }
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        RowLayout {
            z: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            Text {
                id: text1
                color: "#510051"
                text: "hacim"
                font.bold: true
                font.family: "Times New Roman"
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 24
                font.italic: false
            }
        }
    }
    Item {
        id: item2
        x: 0
        y: 58
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 40

        ChartView {
            id: chartView
            plotAreaColor: "#ffffff"
            title: "hacim Chart"
            anchors.fill: parent
            ValueAxis {
                id: yAxis
                titleText: "Volume"
                titleVisible: true
                gridVisible: true
                tickCount: 11
                min: 0
                max: 100
            }
            DateTimeAxis {
                id: xAxis
                tickCount: 20
                visible: true
                labelsAngle: 90
                gridVisible: true
                format: "yyyy-MM-dd"
                min: "2018-06-30"
                max: "2018-12-30"
            }
            LineSeries {
                id: series3
                axisX: xAxis
                axisY: yAxis
                name: "hacim Values"
                width: 3
                color: "#006666"
                visible: true
            }
        }
    }
}
