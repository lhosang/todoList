//
//  ViewController.swift
//  todoList
//
//  Created by Lobsang Tsering on ༢༠༡༧-༡༢-༢༤.
//  Copyright © 2017 Lobsang Tsering. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        
        let newItem1 = Item()
        newItem1.title = "Find Egos"
        
        let newItem2 = Item()
        newItem2.title = "Find keys"
        itemArray.append(newItem)
        itemArray.append(newItem1)
        itemArray.append(newItem2)
        
        if let  items = userDefaults.array(forKey: "toDoListArray") as? [Item] {
            itemArray = items
        }
        
    }

    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    
    // MARK - Table view Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    //MARK - ADD New Item
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField  = UITextField()
        
        let alert = UIAlertController(title: "Add new To do list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add List", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.userDefaults.set(self.itemArray, forKey: "toDoListArray")
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { (cancelAction) in
            print("Cancel")
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item?"
            textField = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}

