//
//  ChartView.swift
//  ChartView
//
//  Created by nori on 2021/08/03.
//

import SwiftUI

public struct ChartView<Content: View>: View {

    public var model: ChartModel

    private let content: (ChartModel.DataPoint) -> Content

    public init(_ model: ChartModel,
                @ViewBuilder content: @escaping (ChartModel.DataPoint) -> Content) {
        self.model = model
        self.content = content
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 20)
                    .overlay(
                        Text(model.yAxis.title)
                            .lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false)
                            .rotationEffect(Angle(degrees: -90))
                    )
                YAxisView(model.yAxis.labels(10), axisRange: model.yAxis.range) { label in
                    Text(label.text)
                        .font(.system(size: 11))
                }
                .frame(width: 30)
                GraphView(model.data,
                          xAxisRange: model.xAxis.range,
                          yAxisRange: model.yAxis.range,
                          content: content)
            }
            XAxisView(model.xAxis.labels(10), axisRange: model.xAxis.range) { label in
                Text(label.text)
                    .font(.system(size: 11))
            }
            .frame(height: 30)
            .padding(.leading, 50)
            Text(model.xAxis.title)
                .frame(height: 20)
        }
    }
}

struct ChartView_Previews: PreviewProvider {

    static var model: ChartModel = ChartModel(title: "Title",
                                              summary: "Summary",
                                              xAxis: ChartModel.Axis(title: "xAxis", range: (0...100)),
                                              yAxis: ChartModel.Axis(title: "yAxis", range: (0...100)),
                                              data: [
//                                                ChartModel.DataPoint(id: "0", x: 0, y: 0),
                                                ChartModel.DataPoint(id: "1", x: 10, y: 10),
                                                ChartModel.DataPoint(id: "2", x: 20, y: 20),
                                                ChartModel.DataPoint(id: "3", x: 30, y: 30),
                                                ChartModel.DataPoint(id: "4", x: 40, y: 40),
                                                ChartModel.DataPoint(id: "5", x: 50, y: 50),
                                              ])

    static var previews: some View {
        ChartView(model) { dataPoint in
            Circle().frame(width: 15, height: 15, alignment: .center)
        }
    }
}
