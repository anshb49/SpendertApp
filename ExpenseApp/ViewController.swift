//
//  ViewController.swift
//  ExpenseApp
//
//  Created by Ansh Bhalla on 6/10/20.
//  Copyright © 2020 Ansh Bhalla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBOutlet weak var MonthlyAverage: UIButton!
    
    @IBOutlet weak var WeeklyAverage: UIButton!
    
    @IBOutlet weak var RecentTransaction: UIButton!
    
    @IBOutlet weak var AddExpense: UIButton!
    
    
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
        
    }


}

