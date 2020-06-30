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
    
    var currentEntityName = "DeleteTestingEntity"
    
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
        
        
        SetupMonthCostSaving()
        GetFrontPageData()
        //DeleteAllDataInMonthEntity()
    }
    
    func GetFrontPageData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: currentEntityName)
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
                LastExpenseDate = data.value(forKey: "dateOfPurchase") as? String ?? "NO DATE PROVIDED"
                let curFormattedDate = FormatDate(dateToFormat: LastExpenseDate)
                
                if(GetCurrentMonthAndYear().compare(curFormattedDate).rawValue == 0) {
                    MonthlyTotalExpense += LastExpenseAmount
                }
                
                if (LastExpenseDate != "NO DATE PROVIDED" && LastExpenseDate != "NO DATE" && isInSameWeek(as: ConvertStringToDate(date: LastExpenseDate))) {
                    WeeklyTotalExpense += LastExpenseAmount
                }
            }
            
            SetFormattedFrontPageLabels(LastExpenseAmount: LastExpenseAmount, MonthlyTotalExpense: MonthlyTotalExpense, WeeklyTotalExpense: WeeklyTotalExpense, LastExpenseStore: LastExpenseStore)
            
            AddMonthTotalToDataset(monthlyTotal: MonthlyTotalExpense)
            
        } catch {
            print("FAILED")
        }
    }
    
    func AddMonthTotalToDataset(monthlyTotal: Double) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MonthlyGraphTestEntity")
        request.returnsObjectsAsFaults = false
        
        do {
            var result = try context.fetch(request)
            context.delete(result.popLast() as! NSManagedObject)
            try context.save()
            
            
            let entity = NSEntityDescription.entity(forEntityName: "MonthlyGraphTestEntity", in: context)
            let newEntity = NSManagedObject(entity: entity!, insertInto: context)
            
            newEntity.setValue(monthlyTotal, forKey: "monthlyTotal")
            newEntity.setValue(GetCurrentMonthAndYear(), forKey: "month")
            
            try context.save()
            result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "monthlyTotal") as! Double)
            }
        } catch {
            print("COULDN'T DELETE")
        }
    }
    
    func SetupMonthCostSaving() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MonthlyGraphTestEntity")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            print(result.count)
            if ((result as! [NSManagedObject]).count == 0 || (result.last as! NSManagedObject).value(forKey: "month") as! String != GetCurrentMonthAndYear()) {
                let entity = NSEntityDescription.entity(forEntityName: "MonthlyGraphTestEntity", in: context)
                let newEntity = NSManagedObject(entity: entity!, insertInto: context)
                newEntity.setValue(0, forKey: "monthlyTotal")
                newEntity.setValue(GetCurrentMonthAndYear(), forKey: "month")
            }
            
            try context.save()
        } catch {
            print("ERROR")
        }
    }
    
    func DeleteAllDataInMonthEntity() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MonthlyGraphTestEntity")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            print((result as! [NSManagedObject]).count)
            for data in (result as! [NSManagedObject]).reversed()  {
                context.delete(data)
                try context.save()
                print(result.count)
            }
        } catch {
            print("COULDN'T DELETE")
        }
        
        
        print("THAT NUMBER ABOVE SHOULD BE ZERO")
    }
    
    func SetFormattedFrontPageLabels(LastExpenseAmount: Double, MonthlyTotalExpense: Double, WeeklyTotalExpense: Double, LastExpenseStore: String) {
        
        let FormattedRecentExpense = String(format: "%.2f", LastExpenseAmount)
        RecentExpenseLabel.text = "$" + "\(FormattedRecentExpense)"
        let FormattedMonthlyExpense = String(format: "%.2f", MonthlyTotalExpense)
        MonthlyTotalLabel.text = "$" + "\(FormattedMonthlyExpense)"
        let FormattedWeeklyExpense = String(format: "%.2f", WeeklyTotalExpense)
        WeeklyTotalLabel.text = "$" + "\(FormattedWeeklyExpense)"
        RecentStoreLabel.text = LastExpenseStore
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

