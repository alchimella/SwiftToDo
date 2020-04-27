//
//  TableViewController.swift
//  SwiftToDoList
//
//  Created by Abi  Radzhabova on 4/21/20.
//  Copyright © 2020 Abi  Radzhabova. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var toDo: ToDoItems = ToDoItems()
//    private let groupedItems = groupItems(ToDoItems)
    
    @IBAction func pushAddItem(_ sender: Any) {
        let alertController = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter text"
        }
        
        let alertActionAdd = UIAlertAction(title: "Add", style: .cancel) { (alert) in
            let newItem = alertController.textFields![0].text
            
            if newItem != "" {
                self.toDo.addItem(nameItem: newItem!)
                self.tableView.reloadData()
            }
        }
        
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .default) { (alert) in
           
        }
        
        alertController.addAction(alertActionAdd)
        alertController.addAction(alertActionCancel)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> Int? {
////        let currentItem = ToDoItems[section]
//        let arr = ["red", "bad", "rat"]
//
//        return "\(arr[section])"
//    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.text = ToDoItems[section]["date"] as? String
//        print(ToDoItems[section]["date"] as? String)
//        return label
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDo.toDoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let currentItem = toDo.toDoItems[indexPath.row]
        cell.textLabel?.text = currentItem["name"] as? String
        
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.imageView?.image = UIImage(named: "checked.png")
        } else {
            cell.imageView?.image = UIImage(named: "unchecked.png")
        }
        
        if tableView.isEditing {
            cell.textLabel?.alpha = 0.4
            cell.imageView?.alpha = 0.4
        } else {
            cell.textLabel?.alpha = 1
            cell.imageView?.alpha = 1
        }
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") {(action, indexPath) in
            self.toDo.removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let edit = UITableViewRowAction(style: .destructive, title: "Edit") {(action, indexPath) in
            let alertController = UIAlertController(title: "Edit new item", message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.text = self.toDo.toDoItems[indexPath.row]["name"] as? String
                textField.placeholder = "Enter text"
            }
            
            let alertActionAdd = UIAlertAction(title: "Edit", style: .cancel) { (alert) in
                let newItem = alertController.textFields![0].text
                
                if newItem != "" {
                    self.toDo.editItem(index: indexPath.row, nameItem: newItem!)
                    self.tableView.reloadData()
                }
            }
            
            let alertActionCancel = UIAlertAction(title: "Cancel", style: .default) { (alert) in
               
            }
            
            alertController.addAction(alertActionAdd)
            alertController.addAction(alertActionCancel)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        edit.backgroundColor = UIColor.orange
        
        return [edit, delete]
    }
    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        toDo.editItem(index: indexPath.row, nameItem: "Checked")
        
        if toDo.changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "checked.png")
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "unchecked.png")
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        toDo.moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        
        tableView.reloadData()
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
