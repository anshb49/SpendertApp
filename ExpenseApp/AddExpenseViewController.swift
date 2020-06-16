//
//  AddExpenseViewController.swift
//  ExpenseApp
//
//  Created by Ansh Bhalla on 6/12/20.
//  Copyright © 2020 Ansh Bhalla. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var TotalExpenses = [Expense] ()
    
    @IBOutlet weak var NameInput: UITextField!
    
    @IBOutlet weak var DateInput: UITextField!
    
    @IBOutlet weak var TimeInput: UITextField!
    
    @IBOutlet weak var ConfirmAdd: UIButton!
    
    @IBOutlet weak var LeavePage: UIButton!
    
    @IBOutlet weak var ExpenseAmount: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let Tap:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(Tap)
        
        
        // Do any additional setup after loading the view.
        
        ConfirmAdd.layer.cornerRadius = 20
        ConfirmAdd.clipsToBounds = true
        
        LeavePage.layer.cornerRadius = 20
        LeavePage.clipsToBounds = true
    }
    
    @objc func DismissKeyboard() {
        view.endEditing(true)
    }

    
    @IBAction func AddExpense(_ sender: Any) {
        let LatestExpense = Expense()
        LatestExpense.name = NameInput.text!
        LatestExpense.date = DateInput.text!
        LatestExpense.time = TimeInput.text!
        /*let purchaseAmountAsString = AmountInput.text!
        let purchaseAmount = Double(purchaseAmountAsString)
        LatestExpense.amount = purchaseAmount!*/
        
        
        print(LatestExpense.name)
        print(LatestExpense.date)
        print(LatestExpense.time)
        print(LatestExpense.amount)
        
        TotalExpenses.append(LatestExpense)
        
        print(TotalExpenses.count)
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
