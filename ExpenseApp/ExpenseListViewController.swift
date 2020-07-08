//
//  ExpenseListViewController.swift
//  ExpenseApp
//
//  Created by Praval Telagi on 7/8/20.
//  Copyright © 2020 Ansh Bhalla. All rights reserved.
//

import UIKit
import CoreData

var expenseList = [NSManagedObject]()

class ExpenseListViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DeleteTestingEntity")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            
            expenseList = result as! [NSManagedObject]
        } catch {
            print("FAILED")
        }
        
        
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

}

extension ExpenseListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expense = expenseList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "expense", for: indexPath) as! ExpenseTableViewCell
        
        cell.update(with: (expense.value(forKey: "nameOfPurchase") as! String))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseList.count
    }
}

