//
//  AddExpenseViewController.swift
//  ExpenseApp
//
//  Created by Ansh Bhalla on 6/12/20.
//  Copyright © 2020 Ansh Bhalla. All rights reserved.
//

import UIKit
import CoreData

@objc(Show)

class AddExpenseViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var TotalExpenses = [Expense] ()
    var LastExpense = Expense()
    var number = Int()
    var name = String()
    var date = String()
    var amount = Double()
    var currentEntityName = "DeleteTestingEntity"
    
    @IBOutlet weak var NameInput: UITextField!
    
    @IBOutlet weak var DateInput: UITextField!
    
    @IBOutlet weak var ConfirmAdd: UIButton!
    
    @IBOutlet weak var LeavePage: UIButton!
    
    @IBOutlet weak var AmountIInput: UITextField!
    
    @IBOutlet weak var DeleteLastExpenseTestButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let Tap:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(Tap)
        
        
        // Do any additional setup after loading the view.
        
        ConfirmAdd.layer.cornerRadius = 20
        ConfirmAdd.clipsToBounds = true
        
        LeavePage.layer.cornerRadius = 20
        LeavePage.clipsToBounds = true
        //DeleteAllDataInMonthEntity()
        //GetData()
        
    }
    
    @objc func DismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func AddExpense(_ sender: Any) {
        
        
        
       let LatestExpense = Expense()
       LatestExpense.name = NameInput.text!
       LatestExpense.date = DateInput.text!
        
       let date = Date()
       let calendar = Calendar.current
       let hour = calendar.component(.hour, from: date)
       let minutes = calendar.component(.minute, from: date)
       LatestExpense.time = String(hour) + ":" + String(minutes)
        
        
        let textAmount = AmountIInput.text!
        let moneyValue = NumberFormatter().number(from: textAmount)?.doubleValue
        LatestExpense.amount = moneyValue!
        
        SaveData(purchaseName: LatestExpense.name, dateOfPurchase: LatestExpense.date, purchaseAmount: LatestExpense.amount)
        GetData()
        
    }
    
    @IBAction func ResetInputs(_ sender: Any) {
        NameInput.text = ""
        DateInput.text = ""
        //TimeInput.text = ""
    }
    
    func GetMonthlyTotal() -> Double {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MonthlyGraphTestEntity")
        request.returnsObjectsAsFaults = false
        
        do {
            var result = try context.fetch(request)
            let latestMonthAmount = (result.last as! NSManagedObject).value(forKey: "monthlyTotal") as! Double
            context.delete(result.popLast() as! NSManagedObject)
            try context.save()
            return latestMonthAmount
        } catch {
            print("COULDN'T DELETE")
        }
        
        return 0.0
    }
    
    func SaveData(purchaseName: String, dateOfPurchase: String, purchaseAmount: Double) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: currentEntityName, in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        print(purchaseName)
        
        newEntity.setValue(purchaseName, forKey: "nameOfPurchase")
        newEntity.setValue(GetTodaysDate(), forKey: "dateOfPurchase")
        newEntity.setValue(purchaseAmount, forKey: "purchaseAmount")
        
        do {
            try context.save()
            print("SAVED")
        } catch {
            print("ERROR SAVING")
        }
    }
    
    func DeleteLastExpense() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: currentEntityName)
        request.returnsObjectsAsFaults = false
        
        do {
            var result = try context.fetch(request)
            context.delete(result.popLast() as! NSManagedObject)
            try context.save()
        } catch {
            print("COULDN'T DELETE")
        }
    }
    
    func GetData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: currentEntityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in (result as! [NSManagedObject]) {
                //name = data.value(forKey: "nameOfPurchase") as! String
                name = data.value(forKey: "nameOfPurchase") as? String ?? "NO STORE PROVIDED"
                date = data.value(forKey: "dateOfPurchase") as? String ?? "NO DATE PROVIDED"
                amount = data.value(forKey: "purchaseAmount") as? Double ?? 0.00
                print(name)
                print(date)
                print(amount)
                print("")
            }
        } catch {
            print("FAILED")
        }
    }
    
    func GetTodaysDate() -> String {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy"
        let today : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: 0) as Date)
        print(today)
        return today
    }
    
    func GetCurrentMonthAndYear() -> String {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "M/yyyy"
        let todayMonthYear : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: 0) as Date)
        return todayMonthYear
    }
    
    @IBAction func tryToDeleteStuff(_ sender: Any) {
        DeleteLastExpense()
    }
    
    func DeleteAllDataInMonthEntity() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: currentEntityName)
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
