//
//  ViewController.swift
//  ExpenseApp
//
//  Created by Ansh Bhalla on 6/10/20.
//  Copyright © 2020 Ansh Bhalla. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBOutlet weak var MonthlyAverage: UIButton!
    
    @IBOutlet weak var WeeklyAverage: UIButton!
    
    @IBOutlet weak var RecentTransaction: UIButton!
    
    @IBOutlet weak var AddExpense: UIButton!
    
    @IBOutlet weak var RecentExpenseLabel: UILabel!
    
    @IBOutlet weak var WeeklyTotalLabel: UILabel!
    
    @IBOutlet weak var MonthlyTotalLabel: UILabel!
    
    
    @IBOutlet weak var ExpenseSummary: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        MonthlyAverage.layer.cornerRadius = 20
        MonthlyAverage.clipsToBounds = true
        //MonthlyAverage.layer.borderWidth = 1;
        //MonthlyAverage.layer.borderColor = UIColor.init(displayP3Red: 0, green: 255, blue: 162, alpha: 1).cgColor
        
        
        
        WeeklyAverage.layer.cornerRadius = 20
        WeeklyAverage.clipsToBounds = true
        
        RecentTransaction.layer.cornerRadius = 20
        RecentTransaction.clipsToBounds = true
        
        AddExpense.layer.cornerRadius = 20
        AddExpense.clipsToBounds = true
        
        ExpenseSummary.layer.cornerRadius = 20
        ExpenseSummary.clipsToBounds = true
        
        GetFrontPageData()
    }
    
    func GetFrontPageData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults = false
        var LastExpenseAmount = 0.00
        var LastExpenseDate = ""
        var MonthlyTotalExpense = 0.00
        let formatter : DateFormatter = DateFormatter()
           formatter.dateFormat = "M/yy"
           let todayMonthYear : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: 0) as Date)
           
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                LastExpenseAmount = data.value(forKey: "purchaseAmount") as? Double ?? 0.00
                LastExpenseDate = data.value(forKey: "dateOfPurchase") as? String ?? "NO DATE"
                var curFormattedDate = String()
                curFormattedDate = FormatDate(dateToFormat: LastExpenseDate)
                
                if (todayMonthYear.compare(curFormattedDate).rawValue == 0) {
                    MonthlyTotalExpense += LastExpenseAmount
                }
                
                
                
            }
            let FormattedRecentExpense = String(format: "%.2f", LastExpenseAmount)
            RecentExpenseLabel.text = "$" + "\(FormattedRecentExpense)"
            let FormattedMonthlyExpense = String(format: "%.2f", MonthlyTotalExpense)
            MonthlyTotalLabel.text = "$" + "\(FormattedMonthlyExpense)"
            
        } catch {
            print("FAILED")
        }
    }
    
    func FormatDate(dateToFormat: String) -> String {
        var newDateFormat = ""
        var foundSlash = true
        
        for char in dateToFormat {
            if (foundSlash) {
                newDateFormat = newDateFormat + "\(char)"
            }
            
            if (char == "/") {
                foundSlash = !foundSlash
            }
        }
        return newDateFormat
    }


}

