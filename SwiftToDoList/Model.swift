//
//  Model.swift
//  SwiftToDoList
//
//  Created by Abi  Radzhabova on 4/21/20.
//  Copyright © 2020 Abi  Radzhabova. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class ToDoItems {
    var toDoItems: [[String: Any]] {
        set {
            UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
            UserDefaults.standard.synchronize()
        }
        
        get {
            if let data = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String: Any]] {
                return data
            } else {
                return []
            }
        }
    }
    
    func addItem(nameItem: String, isCompleted: Bool = false) {
        let date: Date = Date()
        let currentDate = date.getCurrentDate()
        
        toDoItems.append(["name": nameItem, "isCompleted": isCompleted, "date": currentDate])
        setBage()
    }

    func editItem(index: Int, nameItem: String) {
        toDoItems[index]["name"] = nameItem
    }

    func moveItem(fromIndex: Int, toIndex: Int) {
        let from = toDoItems[fromIndex]
        toDoItems.remove(at: fromIndex)
        toDoItems.insert(from, at: toIndex)
    }

    func removeItem(at index: Int) {
        toDoItems.remove(at: index)
        setBage()
    }

    func changeState(at item: Int) -> Bool {
        toDoItems[item]["isCompleted"] = !(toDoItems[item]["isCompleted"] as! Bool)
        setBage()
        return toDoItems[item]["isCompleted"] as! Bool
    }
    
    func setBage() {
        var totalBageNumber = 0

        for item in toDoItems {
            if (item["isCompleted"] as? Bool) == false {
                totalBageNumber += 1
            }
        }

        UIApplication.shared.applicationIconBadgeNumber = totalBageNumber
    }
}











//func groupItems(_ items: [[String: Any]]) -> [String: Any] {
//    let grouped = Dictionary(grouping: items) { $0["date"] as! String }
//    
//    print(grouped)
//    for item in grouped {
//        print(item)
//    }
//    
//    return grouped
//}
