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
    
    let currentEntityName = "DeleteTestingEntity"
    let monthDataEntityName = "MonthlyGraphTestEntity"
    let weekDataEntityName = "WeeklyGraphTestEntity"
    
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
        
        //AddMonthlyTotalTestData()
        //DeleteAllDataInMonthEntity()
        SetupWeekCostSaving()
        SetupMonthCostSaving()
        SetupDailyCostSaving()
        LoadFrontPageData()
        
    }
    
    func LoadFrontPageData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: currentEntityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            if ((result as! [NSManagedObject]).count > 0) {
                RecentStoreLabel.text = ((result.last as! NSManagedObject).value(forKey: "nameOfPurchase") as! String)
                let FormattedLatestExpense = String(format: "%.2f", (result.last as! NSManagedObject).value(forKey: "purchaseAmount") as! Double)
                RecentExpenseLabel.text = "$" + FormattedLatestExpense
                SetMonthlyTotalLabel()
                SetWeeklyTotalLabel()
            }
        } catch {
            print("COULDN'T LOAD FRONT PAGE DATA")
        }
    }
    
    func SetupMonthCostSaving() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: monthDataEntityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            //print(result.count)
            if ((result as! [NSManagedObject]).count == 0 || (result.last as! NSManagedObject).value(forKey: "month") as! String != DateFunctions.GetCurrentMonthAndYear()) {
                let entity = NSEntityDescription.entity(forEntityName: monthDataEntityName, in: context)
                let newEntity = NSManagedObject(entity: entity!, insertInto: context)
                newEntity.setValue(0, forKey: "monthlyTotal")
                newEntity.setValue(DateFunctions.GetCurrentMonthAndYear(), forKey: "month")
            }
            
            try context.save()
        } catch {
            print("ERROR")
        }
    }
    
    func SetupDailyCostSaving() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyGraphTestEntity")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            print("RESULT COUNT: " + "\(result.count)")
            
            //let Calendar = NSCalendar.current()
            
            
            
            
            //NSCalendar.current.startOfDay(for: DateFunctions.ConvertStringToDate(date: DateFunctions.GetTodaysDate()))
            
            //let firstDate = DateFunctions.ConvertStringToDate(date: DateFunctions.GetTodaysDate())
            
            //let secondDate = DateFunctions.ConvertStringToDate(date: DateFunctions.GetTodaysDate())
            
            /*let formatter : DateFormatter = DateFormatter()
            formatter.dateFormat = "M/d/yyyy"
            let today : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: -86400) as Date)
            print("YESTERDAY: " + today)
            let isoDate = today
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "M/d/yyyy"
            let newDate = dateFormatter.date(from:isoDate)!*/
            //return newDate
            
            
            let firstDate = NSCalendar.current.startOfDay(for: DateFunctions.ConvertStringToDate(date: DateFunctions.GetTodaysDate()))
            
            let secondDate = NSCalendar.current.startOfDay(for: DateFunctions.ConvertStringToDate(date: DateFunctions.GetTodaysDate()))
            
            
            //let diffInDays = Calendar.current.dateComponents([.day], from: newDate, to: secondDate).day!
            
            //print("DATE: " + "\(diffInDays)")
            
            if ((result as! [NSManagedObject]).count > 0 && (result.last as! NSManagedObject).value(forKey: "date") as! String != DateFunctions.GetTodaysDate()) {
                let previousSavedDate = NSCalendar.current.startOfDay(for: DateFunctions.ConvertStringToDate(date: (result.last as! NSManagedObject).value(forKey: "date") as! String))
                let todayDate = NSCalendar.current.startOfDay(for: DateFunctions.ConvertStringToDate(date: DateFunctions.GetTodaysDate()))
                
                let diffInDays = Calendar.current.dateComponents([.day], from: previousSavedDate, to: todayDate).day!
                
                if (diffInDays > 1 && diffInDays <= 7) {
                    for i in 1...diffInDays - 1 {
                        let entity = NSEntityDescription.entity(forEntityName: "DailyGraphTestEntity", in: context)
                        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
                        newEntity.setValue(0, forKey: "dailyTotal")
                        let formatter : DateFormatter = DateFormatter()
                        formatter.dateFormat = "M/d/yyyy"
                        let intervalTime = -86400 * (diffInDays - i)
                        let date : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: Double(intervalTime)) as Date)
                        print("THIS IS THE FORMAT FOR THE DATES: " + date)
                        newEntity.setValue( date, forKey: "date")
                        try context.save()
                    }
                } else if (diffInDays > 7) {
                    for i in 1 ... 6 {
                        let entity = NSEntityDescription.entity(forEntityName: "DailyGraphTestEntity", in: context)
                        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
                        newEntity.setValue(0, forKey: "dailyTotal")
                        let formatter : DateFormatter = DateFormatter()
                        formatter.dateFormat = "M/d/yyyy"
                        let intervalTime = -86400 * (7 - i)
                        let date : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: Double(intervalTime)) as Date)
                        print("THIS IS THE FORMAT FOR THE DATES: " + date)
                        newEntity.setValue( date, forKey: "date")
                        try context.save()
                    }
                }
                
            }
            
            
            
            if ((result as! [NSManagedObject]).count == 0 || (result.last as! NSManagedObject).value(forKey: "date") as! String != DateFunctions.GetTodaysDate()) {
                let entity = NSEntityDescription.entity(forEntityName: "DailyGraphTestEntity", in: context)
                let newEntity = NSManagedObject(entity: entity!, insertInto: context)
                newEntity.setValue(0, forKey: "dailyTotal")
                newEntity.setValue(DateFunctions.GetTodaysDate(), forKey: "date")
            }
            try context.save()
        } catch {
            print("ERROR")
        }
    }
    
    func SetupWeekCostSaving() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: weekDataEntityName)
        request.returnsObjectsAsFaults = false
            
        do {
            let result = try context.fetch(request)
            print(result.count)
            
            
            if ((result as! [NSManagedObject]).count == 0 || !(DateFunctions.isInSameWeek(as: DateFunctions.ConvertStringToDate(date: ((result.last as! NSManagedObject).value(forKey: "week") as! String))))) {
                let entity = NSEntityDescription.entity(forEntityName: weekDataEntityName, in: context)
                let newEntity = NSManagedObject(entity: entity!, insertInto: context)
                newEntity.setValue(0, forKey: "weeklyTotal")
                newEntity.setValue(DateFunctions.GetTodaysDate(), forKey: "week")
            }
            
            try context.save()
        } catch {
            print("ERROR")
        }
    }
    
    func SetMonthlyTotalLabel() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: monthDataEntityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            
            //print((result.last as! NSManagedObject).value(forKey: "monthlyTotal") as! Double)
            let FormattedMonthlyExpense = String(format: "%.2f", (result.last as! NSManagedObject).value(forKey: "monthlyTotal") as! Double)
            MonthlyTotalLabel.text = "$" + "\(FormattedMonthlyExpense)"
            
            /*for data in result as! [NSManagedObject] {
                print(data.value(forKey: "monthlyTotal") as! Double)
            }*/
        } catch {
            print("COULDN'T SET MONTHLY TOTAL LABEL")
        }
    }
    
    func SetWeeklyTotalLabel() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: weekDataEntityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            
            print((result.last as! NSManagedObject).value(forKey: "weeklyTotal") as! Double)
            let FormattedWeeklyExpense = String(format: "%.2f", (result.last as! NSManagedObject).value(forKey: "weeklyTotal") as! Double)
            WeeklyTotalLabel.text = "$" + "\(FormattedWeeklyExpense)"
            
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "week") as! String)
                print(data.value(forKey: "weeklyTotal") as! Double)
            }
        } catch {
            print("COULDN'T SET WEEKLY TOTAL LABEL")
        }
    }
    
    func DeleteAllDataInMonthEntity() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: monthDataEntityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            print((result as! [NSManagedObject]).count)
            for data in (result as! [NSManagedObject]).reversed() {
                context.delete(data)
                try context.save()
                print(result.count)
            }
        } catch {
            print("COULDN'T DELETE")
        }
        
        print("THAT NUMBER ABOVE SHOULD BE ZERO")
    }
    
    /*@IBAction func ExpenseSummaryAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Expense Summary", message:
            "You have clicked on Expense Summary", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        

        self.present(alertController, animated: true, completion: nil)
    }*/

}

