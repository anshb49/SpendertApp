//
//  ExpenseTableViewCell.swift
//  ExpenseApp
//
//  Created by Praval Telagi on 7/8/20.
//  Copyright © 2020 Ansh Bhalla. All rights reserved.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var ExpenseLabel: UILabel!
    
    func update(with expense: String) {
        ExpenseLabel.text = expense
    }

}
