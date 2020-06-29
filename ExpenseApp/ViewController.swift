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
    
    @IBOutlet weak var RecentStoreLabel: UILabel!
    
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
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ExpensesDatabaseEntity")
        request.returnsObjectsAsFaults = false
        
        var LastExpenseAmount = 0.00
        var LastExpenseDate = ""
        var MonthlyTotalExpense = 0.00
        var WeeklyTotalExpense = 0.00
        
        var LastExpenseStore = ""
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                LastExpenseStore = data.value(forKey: "nameOfPurchase") as? String ?? "NO STORE"
                LastExpenseAmount = data.value(forKey: "purchaseAmount") as? Double ?? 0.00
                LastExpenseDate = data.value(forKey: "dateOfPurchase") as? String ?? "NO DATE"
                let curFormattedDate = FormatDate(dateToFormat: LastExpenseDate)
                
                if(GetCurrentMonthAndYear().compare(curFormattedDate).rawValue == 0) {
                    MonthlyTotalExpense += LastExpenseAmount
                }
                
                if (LastExpenseDate != "NO DATE PROVIDED" && LastExpenseDate != "NO DATE" && isInSameWeek(as: ConvertStringToDate(date: LastExpenseDate))) {
                    WeeklyTotalExpense += LastExpenseAmount
                }
            }
            
            let FormattedRecentExpense = String(format: "%.2f", LastExpenseAmount)
            RecentExpenseLabel.text = "$" + "\(FormattedRecentExpense)"
            let FormattedMonthlyExpense = String(format: "%.2f", MonthlyTotalExpense)
            MonthlyTotalLabel.text = "$" + "\(FormattedMonthlyExpense)"
            let FormattedWeeklyExpense = String(format: "%.2f", WeeklyTotalExpense)
            WeeklyTotalLabel.text = "$" + "\(FormattedWeeklyExpense)"
            
            RecentStoreLabel.text = LastExpenseStore
            
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
    
    func GetCurrentMonthAndYear() -> String {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "M/yyyy"
        let todayMonthYear : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: 0) as Date)
        return todayMonthYear
    }
    
    func ConvertStringToDate(date: String) -> Date {
        let isoDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "M/d/yyyy"
        let newDate = dateFormatter.date(from:isoDate)!
        return newDate
    }
    
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        return calendar.isDate(Date(), equalTo: date, toGranularity: component)
    }
    
    func isInSameWeek(as date: Date) -> Bool {
        return isEqual(to: date, toGranularity: .weekOfYear)
    }


}

