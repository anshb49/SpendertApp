//
//  ExpenseTableViewCell.swift
//  ExpenseApp
//
//  Created by Praval Telagi on 7/8/20.
//  Copyright © 2020 Ansh Bhalla. All rights reserved.
//

import UIKit
import CoreData

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var ExpenseLabel: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!
    
    
    @IBOutlet weak var AmountLabel: UILabel!
    
    func update(with expense: NSManagedObject) {
        ExpenseLabel.text = (expense.value(forKey: "nameOfPurchase") as! String)
        
        DateLabel.text = (expense.value(forKey: "dateOfPurchase") as! String)
        
        AmountLabel.text = "$" + "\( String(format: "%.2f", (expense).value(forKey: "purchaseAmount") as! Double))"
        
        ExpenseLabel.textColor = .white
        DateLabel.textColor = .white
        AmountLabel.textColor = .white
    }

}
