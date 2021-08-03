//
//  ChartModel.swift
//  ChartModel
//
//  Created by nori on 2021/08/03.
//

import Foundation

public struct ChartModel {

    public var title: String

    public var summary: String

    public var xAxis: Axis

    public var yAxis: Axis

    public var data: [DataPoint]

    public init(
        title: String = "",
        summary: String = "",
        xAxis: Axis,
        yAxis: Axis,
        data: [DataPoint]
    ) {
        self.title = title
        self.summary = summary
        self.xAxis = xAxis
        self.yAxis = yAxis
        self.data = data
    }
}

extension ChartModel {

    public struct Axis {

        public var title: String

        public var range: ClosedRange<Double>

        public init(title: String = "", range: ClosedRange<Double>) {
            self.title = title
            self.range = range
        }

        public func labels(_ interval: Double) -> [AxisLabel] {
            let magnitude = range.upperBound - range.lowerBound
            let labelCount = Int(magnitude / fabs(interval))
            return (0...labelCount).map { index in
                let value = interval * Double(index) + range.lowerBound
                return AxisLabel(text: "\(value)", value: value)
            }
        }
    }
}

extension ChartModel {

    public struct AxisLabel {

        public var text: String

        public var value: Double

        public init(text: String, value: Double) {
            self.text = text
            self.value = value
        }
    }
}

extension ChartModel {

    public struct DataPoint: Identifiable {

        public var id: String

        public var name: String

        public var x: Double

        public var y: Double

        public init(id: String, name: String = "", x: Double, y: Double) {
            self.id = id
            self.name = name
            self.x = x
            self.y = y
        }
    }
}

