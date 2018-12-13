import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtCharts 2.2

Item {
    id: item1
    property alias chartView: chartView

    Connections {
        target: netManager
        onValueUpdated: {

            series.append(x, y)
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
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            Text {
                id: text1
                color: "#510051"
                text: qsTr("ilker")
                font.bold: true
                font.family: "Times New Roman"
                z: 1
                font.italic: false
                font.pointSize: 24
            }
        }
    }

    Item {
        id: item2
        x: 0
        y: 58
        width: parent.width
        height: parent.height
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40

        ChartView {
            id: chartView
            anchors.topMargin: 48
            plotAreaColor: "#ffffff"
            title: "chart"
            anchors.fill: parent
            theme: ChartView.ChartThemeLight
            ValueAxis {
                id: yAxis
                titleText: "x"
                titleVisible: true
                gridVisible: true
                tickCount: 11
                min: 0
                max: 200
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
                id: series
                axisX: xAxis
                axisY: yAxis
                name: "acık deger"
                width: 3
                color: "#006600"
                visible: true
            }
        }

        Image {
            id: image
            x: 263
            y: -35
            width: 100
            height: 64
            anchors.horizontalCenterOffset: -262
            anchors.horizontalCenter: parent.horizontalCenter
            source: "aa.png"
            visible: true
        }
    }
}
