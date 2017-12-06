//
//  ResultsViewController.swift
//  BitPredict
//
//  Created by eoin on 11/30/17.
//  Copyright © 2017 panna. All rights reserved.
//

import UIKit
import Charts


class ResultsViewController: UIViewController {

    var models: Models!
    
    var chart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Results"
        restAPI.getData()
        chart = LineChartView(frame: view.frame)
        fillChart()
        view.addSubview(chart)
    }
    
    func fillChart() {
        let chartDataEntryValues: [ChartDataEntry] = [
            ChartDataEntry(x: 40, y: 0),
            ChartDataEntry(x: 10, y: 100),
            ChartDataEntry(x: 50, y: 50),
            ChartDataEntry(x: 60, y: 60),
            ChartDataEntry(x: 40, y: 4)
        ]

        let dataSet: LineChartDataSet = LineChartDataSet(values: chartDataEntryValues, label: "Test")
        let lineChartData: LineChartData = LineChartData(dataSet: dataSet)
        chart.data = lineChartData
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
