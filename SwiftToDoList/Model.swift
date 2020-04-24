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

var ToDoItems: [[String: Any]] {
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
    let currentDate = getCurrentDate()
    
    ToDoItems.append(["name": nameItem, "isCompleted": isCompleted, "date": currentDate])
//    ToDoItems.append(["name": nameItem, "isCompleted": isCompleted, "date": "20.04.2020"])
    print(ToDoItems)
    setBage()
}

func editItem(index: Int, nameItem: String) {
    ToDoItems[index]["name"] = nameItem
    
    print("ToDoItems", ToDoItems)
}

func moveItem(fromIndex: Int, toIndex: Int) {
    let from = ToDoItems[fromIndex]
    ToDoItems.remove(at: fromIndex)
    ToDoItems.insert(from, at: toIndex)
}

func removeItem(at index: Int) {
    ToDoItems.remove(at: index)
    setBage()
}

func changeState(at item: Int) -> Bool {
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    setBage()
    return ToDoItems[item]["isCompleted"] as! Bool
}

func requestForNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
    }
}

func setBage() {
    var totalBageNumber = 0
    
    for item in ToDoItems {
        if (item["isCompleted"] as? Bool) == false {
            totalBageNumber += 1
        }
    }
    
    UIApplication.shared.applicationIconBadgeNumber = totalBageNumber
}

func getCurrentDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    
    return formatter.string(from: date)
}

func groupItems(_ items: [[String: Any]]) -> [String: Any] {
//    var sectionTitles: [String] = []
    let grouped = Dictionary(grouping: items) { $0["date"] as! String }
//    let header: [String] = []
    print(grouped)
    for item in grouped {
        print(item)
    }
    
    return grouped
}
