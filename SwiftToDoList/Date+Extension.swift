//
//  Date+Extension.swift
//  SwiftToDoList
//
//  Created by Abi  Radzhabova on 4/27/20.
//  Copyright © 2020 Abi  Radzhabova. All rights reserved.
//

import Foundation

extension Date {
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"

        return formatter.string(from: date)
    }
}

