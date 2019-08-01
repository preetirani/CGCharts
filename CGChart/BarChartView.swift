//
//  ChartView.swift
//  CGChart
//
//  Created by Rani on 31/07/19.
//  Copyright © 2019 Vinsol. All rights reserved.
//

import UIKit
typealias Margin = (Leading: CGFloat, Trailing: CGFloat, Top: CGFloat, Bottom: CGFloat)
class BarChartView: UIView {
    var xMin: CGFloat = 0
    var xMax: CGFloat = 100
    var yMin: CGFloat = 0
    var yMax: CGFloat = 100
    
    var identicalBars: Bool = true
    var barColor: UIColor = UIColor.red
    var barWidth: CGFloat = 10
    var margins: Margin = (0,0,0,0)
    
    private var context: CGContext?
    private var barData: [BarEntry] = []
    private var gridData: GridData?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        self.context = context
        draw(barEntrySet: self.barData, gridData: gridData)
    }
    
    func draw(barEntrySet: [BarEntry], gridData: GridData? = nil) {
        self.barData = barEntrySet
        self.gridData = gridData
        guard let context = self.context else {
            return
        }
        
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(bounds)
        
        if gridData != nil {
            drawGridLines(context: context, data: gridData!)
        }
        
        drawBars(context: context, data: barEntrySet)
    }
}

extension BarChartView {
    private func horizontalLines(partitions: Int) -> [CGPoint] {
        let widthOfHorizontalSegment = bounds.height / CGFloat(partitions)
        var points: [CGPoint] = []
        var y = bounds.minY
        for _ in 0 ... partitions {
            let startPoint = CGPoint(x: bounds.minX, y: y)
            let endPoint = CGPoint(x: bounds.maxX, y: y)
            points.append(startPoint)
            points.append(endPoint)
            y += widthOfHorizontalSegment
        }
        return points
    }
    
    private func verticalLines(partitions: Int) -> [CGPoint] {
        let widthOfVerticalSegment = bounds.width / CGFloat(partitions)
        var points: [CGPoint] = []
        var x = bounds.minX
        for _ in 0 ... partitions {
            let startPoint = CGPoint(x: x, y: bounds.minY)
            let endPoint = CGPoint(x: x, y: bounds.maxY)
            points.append(startPoint)
            points.append(endPoint)
            x += widthOfVerticalSegment
        }
        return points
    }
    
    private func drawGridLines(context: CGContext, data: GridData) {
        context.setLineWidth(data.lineWidth)
        context.setStrokeColor(data.color.cgColor)
        context.strokeLineSegments(between: horizontalLines(partitions: data.horizontalPartitions))
        context.strokeLineSegments(between: verticalLines(partitions: data.verticalPartitions))

    }
}

extension BarChartView {
//    private func drawBar(context: CGContext, data: BarEntry) {
//        let xAxisLength = xMax - xMin
//        let yAxisLength = yMax - yMin
//        let width = bounds.width
//        let height = bounds.height
//
//        let topMargin = height * 0.10
//        let bottomMargin = height * 0.10
//        let leftMargin = width * 0.10
//        let rightMargin = width * 0.10
//
//        let x = data.x * (width / xAxisLength)
//        let ymin = data.yMin * (height / yAxisLength)
//        let ymax = data.yMax * (height / yAxisLength)
//
//        let barHeight = ymax - ymin
//        let barWidth = identicalBars ? self.barWidth : data.barWidth
//        let radius = barWidth / 2
//
//        let path = UIBezierPath(roundedRect: CGRect(x: x, y: ymin, width: barWidth, height: barHeight), cornerRadius: radius)
//        context.setFillColor(identicalBars ? barColor.cgColor : data.color.cgColor)
//        context.addPath(path.cgPath)
//        context.fillPath()
//    }
    
    private func drawBars(context: CGContext, data: [BarEntry]) {
        let xAxisLength = xMax - xMin
        let yAxisLength = yMax - yMin
        var width = bounds.width
        var height = bounds.height
        
        let topMargin = margins.Top / xAxisLength
        let bottomMargin = margins.Bottom / xAxisLength
        let leftMargin = margins.Leading / xAxisLength
        let rightMargin = margins.Trailing / xAxisLength
        
        let xMaxRelativeWidth: CGFloat = xMax * (width / xAxisLength) + barWidth
        let adjustBarSpace = xMaxRelativeWidth - width
        
        func drawBar(data: BarEntry) {
            context.saveGState()
            var x = data.x * (width / xAxisLength) - margins.Leading //- margins.Leading
            if xMaxRelativeWidth > width {
                x -= adjustBarSpace
            }
            
            if x < 0 {
                x = 0
            }
            
            let ymin = data.yMin * (height / yAxisLength) + topMargin
            let ymax = data.yMax * (height / yAxisLength) - bottomMargin
            
            var barHeight = ymax - ymin
            let barWidth = identicalBars ? self.barWidth : data.barWidth
            let radius = barWidth / 2
            
            if barHeight <= 0 {
                barHeight = barWidth
            }
            
            let path = UIBezierPath(roundedRect: CGRect(x: x, y: ymin, width: barWidth, height: barHeight), cornerRadius: radius)
            context.setFillColor(identicalBars ? barColor.cgColor : data.color.cgColor)
            context.addPath(path.cgPath)
            context.fillPath()
            context.restoreGState()
        }
        
        data.forEach{ drawBar(data: $0)}
        
    }
}
