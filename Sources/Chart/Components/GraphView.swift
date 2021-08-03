//
//  GraphView.swift
//  GraphView
//
//  Created by nori on 2021/08/03.
//

import SwiftUI

public struct GraphView<Content: View>: View {

    public var xAxisRange: ClosedRange<Double>

    public var yAxisRange: ClosedRange<Double>

    public var data: [ChartModel.DataPoint]

    private let content: (ChartModel.DataPoint) -> Content

    public init(_ data: [ChartModel.DataPoint],
                xAxisRange: ClosedRange<Double>,
                yAxisRange: ClosedRange<Double>,
                @ViewBuilder content: @escaping (ChartModel.DataPoint) -> Content) {
        self.data = data
        self.xAxisRange = xAxisRange
        self.yAxisRange = yAxisRange
        self.content = content
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(data) { dataPoint in
                    content(dataPoint)
                        .position(x: x(dataPoint: dataPoint, range: xAxisRange, size: proxy.size),
                                  y: y(dataPoint: dataPoint, range: yAxisRange, size: proxy.size))
                }
            }
        }
        .drawingGroup()
    }
}

private func magnitude(of range: ClosedRange<Double>) -> Double {
    return range.upperBound - range.lowerBound
}

private func x(dataPoint: ChartModel.DataPoint, range: ClosedRange<Double>, size: CGSize) -> Double {
    let magnitude = magnitude(of: range)
    return (size.width / magnitude) * (dataPoint.x - range.lowerBound)
}

private func y(dataPoint: ChartModel.DataPoint, range: ClosedRange<Double>, size: CGSize) -> Double {
    let magnitude = magnitude(of: range)
    return size.height * (1 - (dataPoint.y - range.lowerBound) / magnitude)
}

struct GraphView_Previews: PreviewProvider {

    static var data: [ChartModel.DataPoint] = [
        ChartModel.DataPoint(id: "0", x: 0, y: 0),
        ChartModel.DataPoint(id: "1", x: 10, y: 10),
        ChartModel.DataPoint(id: "2", x: 20, y: 20),
        ChartModel.DataPoint(id: "4", x: 40, y: 40),
    ]

    static var previews: some View {
        GraphView(data, xAxisRange: (0...100), yAxisRange: (0...100)) { dataPoint in
            Circle().frame(width: 15, height: 15, alignment: .center)
        }
    }
}
