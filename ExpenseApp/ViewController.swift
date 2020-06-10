//
//  ViewController.swift
//  ExpenseApp
//
//  Created by Ansh Bhalla on 6/10/20.
//  Copyright © 2020 Ansh Bhalla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelStart: UILabel!
    
    
    
    @IBAction func changeText(_ sender: Any) {
        labelStart.text = "Added Expense"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

