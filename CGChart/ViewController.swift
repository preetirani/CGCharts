//
//  ViewController.swift
//  CGChart
//
//  Created by Rani on 31/07/19.
//  Copyright © 2019 Vinsol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createChart()
    }

    func createChart() {
        let entry1 = BarEntry(x: 1, yMin: 10, yMax: 40)
        let entry2 = BarEntry(x: 2, yMin: 5, yMax: 15)
        let entry3 = BarEntry(x: 3, yMin: 20, yMax: 25)
        let entry4 = BarEntry(x: 4, yMin: 3, yMax: 8)
        let entry5 = BarEntry(x: 5, yMin: 13, yMax: 34)
        let entry6 = BarEntry(x: 6, yMin: 23, yMax: 47)
        let entry7 = BarEntry(x: 7, yMin: 39, yMax: 55)
        let entry8 = BarEntry(x: 8, yMin: 30, yMax: 30)
        let entry9 = BarEntry(x: 9, yMin: 10, yMax: 90)
        let entry10 = BarEntry(x: 10, yMin: 10, yMax: 20)
        
        barChartView.xMax = 10
        barChartView.yMax = 100
        barChartView.identicalBars = true
        barChartView.barWidth = 10
        barChartView.margins = (10,10,10,10)
        let gridData = GridData(horizontalPartitions: 10, verticalPartitions: 10)
        let barData = [entry1, entry2, entry3, entry4, entry5, entry6, entry7, entry8, entry9, entry10]
        barChartView.draw(barEntrySet: barData, gridData: gridData)
    }
    
    
}

