//
//  XAxisView.swift
//  XAxisView
//
//  Created by nori on 2021/08/03.
//

import SwiftUI

public struct XAxisView<Content: View>: View {

    public var labels: [ChartModel.AxisLabel]

    public var axisRange: ClosedRange<Double>

    private let content: (ChartModel.AxisLabel) -> Content

    public init(_ labels: [ChartModel.AxisLabel],
                axisRange: ClosedRange<Double>,
                @ViewBuilder content: @escaping (ChartModel.AxisLabel) -> Content) {
        self.labels = labels
        self.axisRange = axisRange
        self.content = content
    }

    public var body: some View {
        VStack(spacing: 0) {
            Divider()
            GeometryReader { proxy in
                ZStack {
                    ForEach(labels, id: \.value) { label in
                        content(label)
                            .position(x: x(label: label, range: axisRange, size: proxy.size),
                                      y: proxy.size.height / 2)
                    }
                }
            }
        }
    }
}

public struct YAxisView<Content: View>: View {

    public var labels: [ChartModel.AxisLabel]

    public var axisRange: ClosedRange<Double>

    private let content: (ChartModel.AxisLabel) -> Content

    public init(_ labels: [ChartModel.AxisLabel],
                axisRange: ClosedRange<Double>,
                @ViewBuilder content: @escaping (ChartModel.AxisLabel) -> Content) {
        self.labels = labels
        self.axisRange = axisRange
        self.content = content
    }

    public var body: some View {
        HStack(spacing: 0) {
            GeometryReader { proxy in
                ZStack {
                    ForEach(labels, id: \.value) { label in
                        content(label)
                            .position(x: proxy.size.width / 2,
                                      y: y(label: label, range: axisRange, size: proxy.size))
                    }
                }
            }
            Divider()
        }
    }
}

private func magnitude(of range: ClosedRange<Double>) -> Double {
    return range.upperBound - range.lowerBound
}

private func x(label: ChartModel.AxisLabel, range: ClosedRange<Double>, size: CGSize) -> Double {
    let magnitude = magnitude(of: range)
    return (size.width / magnitude) * (label.value - range.lowerBound)
}

private func y(label: ChartModel.AxisLabel, range: ClosedRange<Double>, size: CGSize) -> Double {
    let magnitude = magnitude(of: range)
    return size.height * (1 - (label.value - range.lowerBound) / magnitude)
}


struct AxisView_Previews: PreviewProvider {

    static var axisLabels: [ChartModel.AxisLabel] = [
        ChartModel.AxisLabel(text: "30", value: 10),
        ChartModel.AxisLabel(text: "30", value: 20),
        ChartModel.AxisLabel(text: "30", value: 30)
    ]

    static var previews: some View {
        XAxisView(axisLabels, axisRange: (0...100)) { label in
            Text(label.text)
        }
        YAxisView(axisLabels, axisRange: (0...100)) { label in
            Text(label.text)
        }
    }
}
