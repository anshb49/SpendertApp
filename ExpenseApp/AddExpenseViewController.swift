//
//  AddExpenseViewController.swift
//  ExpenseApp
//
//  Created by Ansh Bhalla on 6/12/20.
//  Copyright © 2020 Ansh Bhalla. All rights reserved.
//

import UIKit
import CoreData

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
    
    @IBOutlet weak var NameInput: UITextField!
    
    @IBOutlet weak var DateInput: UITextField!
    
    @IBOutlet weak var ConfirmAdd: UIButton!
    
    @IBOutlet weak var LeavePage: UIButton!
    
    @IBOutlet weak var AmountIInput: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let Tap:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(Tap)
        
        
        // Do any additional setup after loading the view.
        
        ConfirmAdd.layer.cornerRadius = 20
        ConfirmAdd.clipsToBounds = true
        
        LeavePage.layer.cornerRadius = 20
        LeavePage.clipsToBounds = true
        
        GetData()
        //print(LastExpense.amount)
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
        /*print(LatestExpense.name)
        print(LatestExpense.date)
        print(LatestExpense.time)
        print(LatestExpense.amount)*/
        
        
        //TotalExpenses.append(LatestExpense)
        
        //print(TotalExpenses.count)
    }
    
    @IBAction func ResetInputs(_ sender: Any) {
        NameInput.text = ""
        DateInput.text = ""
        //TimeInput.text = ""
    }
    
    func SaveData(purchaseName: String, dateOfPurchase: String, purchaseAmount: Double) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ExpensesDatabaseEntity", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        print(purchaseName)
        
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy"
        let today : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: 0) as Date)
        print(today)
        
        
        newEntity.setValue(purchaseName, forKey: "nameOfPurchase")
        newEntity.setValue(today, forKey: "dateOfPurchase")
        newEntity.setValue(purchaseAmount, forKey: "purchaseAmount")
        
        do {
            try context.save()
            print("SAVED")
        } catch {
            print("ERROR SAVING")
        }
    }
    
    func GetData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ExpensesDatabaseEntity")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                //name = data.value(forKey: "nameOfPurchase") as! String
                name = data.value(forKey: "nameOfPurchase") as? String ?? "NO STORE PROVIDED"
                date = data.value(forKey: "dateOfPurchase") as? String ?? "NO DATE PROVIDED"
                amount = data.value(forKey: "purchaseAmount") as? Double ?? 0.00
                print(name)
                print(date)
                print(amount)
                print("")
            }
            /*print(name)
            print(date)
            print(amount)*/
        } catch {
            print("FAILED")
        }
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
