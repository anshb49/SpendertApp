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
import CoreData



class MonthlyGraphViewController: UIViewController, ChartViewDelegate {

    let MonthsOnGraph = 12
    let monthDataEntityName = "MonthlyGraphTestEntity"
    @IBOutlet weak var CloseButton: UIButton!
    
    
    
    lazy var barChartView: BarChartView = {
        let barView = BarChartView()
        barView.backgroundColor = UIColor(red: (33/255.0), green: (33/255.0), blue: (33/255.0), alpha: 1.0)
        barView.xAxis.labelPosition = .bottom
        barView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov"])
        barView.xAxis.labelHeight = 100
        barView.xAxis.labelWidth = 20
        barView.xAxis.granularity = 1
        barView.xAxis.setLabelCount(12, force: false)
        barView.rightAxis.enabled = false
        barView.leftAxis.enabled = false
        barView.xAxis.labelTextColor = .white
        barView.animate(yAxisDuration: 1.20)
        
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
        //LoadData()
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData() {
        let set1 = BarChartDataSet(entries: LoadData(), label:"")
        set1.colors = ChartColorTemplates.material()
        set1.valueTextColor = .white
        set1.barShadowColor = .white
        
        let data = BarChartData(dataSet:set1)
        
        barChartView.data = data
        
    }
    
    func LoadData() -> [BarChartDataEntry] {
        var monthlyExpenseVals = [BarChartDataEntry]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: monthDataEntityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            
            let dataArray = result as! [NSManagedObject]
            var loopCounter = 0
            for data in dataArray.reversed() {
                if (loopCounter == MonthsOnGraph) {
                    break
                }
                
                let dataMonth = DateFunctions.GetDateMonth(date: data.value(forKey: "month") as! String)
                var xPos = 0
                if (Int(dataMonth)! < MonthsOnGraph && Int(dataMonth)! <= Int(DateFunctions.GetCurrentMonth())!) {
                    xPos = 12 + Int(dataMonth)!
                } else {
                    xPos = Int(dataMonth)!
                }
                
                let yPos = data.value(forKey: "monthlyTotal") as! Double
                monthlyExpenseVals.append(BarChartDataEntry(x: Double(xPos), y: yPos))
                
                loopCounter += 1
            }
            
            
        } catch {
            print("FAILED")
        }
        
        return monthlyExpenseVals
    }
    
    
    let monthlyExpenseValues: [BarChartDataEntry] = [
        /*BarChartDataEntry(x: 6, y: 241.71),
        BarChartDataEntry(x: 18, y: 234.27)*/
        
        BarChartDataEntry(x: 1.0, y: 1.0),
        BarChartDataEntry(x: 2.0, y: 2.0),
        BarChartDataEntry(x: 3.0, y: 3.0),
        BarChartDataEntry(x: 4.0, y: 4.0),
        BarChartDataEntry(x: 5.0, y: 5.0),
        BarChartDataEntry(x: 6.0, y: 6.0),
        BarChartDataEntry(x: 7.0, y: 7.0),
        BarChartDataEntry(x: 8.0, y: 8.0),
        BarChartDataEntry(x: 9.0, y: 9.0)
    ]
    
    @IBAction func DismissViewController(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
