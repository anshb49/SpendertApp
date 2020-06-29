//
//  MonthlyGraphViewController.swift
//  ExpenseApp
//
//  Created by Praval Telagi on 6/29/20.
//  Copyright © 2020 Ansh Bhalla. All rights reserved.
//

import UIKit
import Charts
import TinyConstraints



class MonthlyGraphViewController: UIViewController, ChartViewDelegate {

    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemGray
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .insideChart
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.axisLineColor = .white
        chartView.xAxis.labelTextColor = .white
        
        chartView.animate(xAxisDuration: 0.5)
        
        return chartView
    }()
    
    lazy var barChartView: BarChartView = {
        let barView = BarChartView()
        barView.backgroundColor = .systemGray
        barView.xAxis.labelPosition = .bottom
        barView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov"])
        barView.xAxis.granularity = 1
        barView.xAxis.setLabelCount(12, force: false)
        barView.rightAxis.enabled = false
        barView.leftAxis.enabled = false
        //barView.animate(yAxisDuration: 1.25)
        return barView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*view.addSubview(lineChartView)
        
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)*/
        
        view.addSubview(barChartView)
        barChartView.centerInSuperview()
        barChartView.width(to: view)
        barChartView.heightToWidth(of: view)
        //barChartView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        barChartView.center = view.center
        
        setData()
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData() {
        let set1 = BarChartDataSet(entries: monthlyExpenseValues, label: "Monthly Expenses")
        set1.colors = ChartColorTemplates.colorful()
        let data = BarChartData(dataSet:set1)
        barChartView.data = data
        
    }
    
    /*func setData() {
        let set1 = LineChartDataSet(entries: yValues, label: "subscribers")
        
        set1.drawCirclesEnabled = false
        set1.mode = .cubicBezier
        set1.lineWidth = 3
        set1.setColor(.white)
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.highlightColor = .white
        
        let data = LineChartData(dataSet: set1)
        lineChartView.data = data
        data.setDrawValues(false)
        
        
    }*/
    
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 10.0),
        ChartDataEntry(x: 1.0, y: 5.0),
        ChartDataEntry(x: 2.0, y: 7.0),
        ChartDataEntry(x: 3.0, y: 5.0),
        ChartDataEntry(x: 4.0, y: 10.0),
        ChartDataEntry(x: 5.0, y: 6.0),
        ChartDataEntry(x: 6.0, y: 5.0),
        ChartDataEntry(x: 7.0, y: 7.0),
        ChartDataEntry(x: 8.0, y: 8.0),
        ChartDataEntry(x: 9.0, y: 12.0),
        ChartDataEntry(x: 10.0, y: 13.0)
    ]
    
    let monthValues: [ChartDataEntry] = [
        ChartDataEntry(x: 6/20, y: 34),
        ChartDataEntry(x: 7/20, y: 234)
    ]
    
    let monthlyExpenseValues: [BarChartDataEntry] = [
        BarChartDataEntry(x: 6, y: 241.71),
        BarChartDataEntry(x: 18, y: 234.27)
        
        /*BarChartDataEntry(x: 0.0, y: 0.0),
        BarChartDataEntry(x: 1.0, y: 1.0),
        BarChartDataEntry(x: 2.0, y: 2.0),
        BarChartDataEntry(x: 3.0, y: 3.0),
        BarChartDataEntry(x: 4.0, y: 4.0),
        BarChartDataEntry(x: 5.0, y: 5.0),
        BarChartDataEntry(x: 6.0, y: 6.0),
        BarChartDataEntry(x: 7.0, y: 7.0),
        BarChartDataEntry(x: 8.0, y: 8.0),
        BarChartDataEntry(x: 9.0, y: 9.0)*/
    ]
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
