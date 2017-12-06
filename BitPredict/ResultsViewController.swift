//
//  ResultsViewController.swift
//  BitPredict
//
//  Created by eoin on 11/30/17.
//  Copyright © 2017 panna. All rights reserved.
//

import UIKit
import Charts
import SwiftyJSON


class ResultsViewController: UIViewController {

    var models: Models!
    
    var chart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Results"
        chart = LineChartView(frame: view.frame)
        chart.noDataText = "Data loading ..."
        restAPI.getData { data in
            self.fillChart(data)
        }
        view.addSubview(chart)
    }
    
    func fillChart(_ data: [JSON]) {
        var upDataEntryValues: [ChartDataEntry] = []
        var downDataEntryValues: [ChartDataEntry] = []
        var neutralDataEntryValues: [ChartDataEntry] = []

        for i in 0..<data.count {
            var dataPoint: [JSON] = data[i].arrayValue
            let dailyVotes: Double = dataPoint[1].doubleValue + dataPoint[2].doubleValue + dataPoint[3].doubleValue
            upDataEntryValues.append(ChartDataEntry(x: Double(i), y: 100 * dataPoint[1].doubleValue / dailyVotes))
            downDataEntryValues.append(ChartDataEntry(x: Double(i), y: 100 * dataPoint[3].doubleValue / dailyVotes))
            neutralDataEntryValues.append(ChartDataEntry(x: Double(i), y: 100 * dataPoint[2].doubleValue / dailyVotes))
        }

        let upDataSet: LineChartDataSet = LineChartDataSet(values: upDataEntryValues, label: "Up")
        upDataSet.circleColors = [.green] //Array(repeating: .green, count: data.count)
        upDataSet.colors = [.green]
        
        let downDataSet: LineChartDataSet = LineChartDataSet(values: downDataEntryValues, label: "Down")
        downDataSet.circleColors = [.red] //Array(repeating: .red, count: data.count)
        downDataSet.colors = [.red]
        
        let neutralDataSet: LineChartDataSet = LineChartDataSet(values: neutralDataEntryValues, label: "Neutral")
        neutralDataSet.circleColors = [.lightGray]
        neutralDataSet.colors = [.lightGray]
        
        let lineChartData: LineChartData = LineChartData(dataSets: [upDataSet, neutralDataSet, downDataSet])
        chart.data = lineChartData
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
