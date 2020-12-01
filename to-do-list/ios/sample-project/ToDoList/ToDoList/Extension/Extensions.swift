//
//  Extensions.swift
//  ToDoList
//
//  Created by stone on 2018/01/28.
//  Copyright © 2018年 stone. All rights reserved.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    func toStrByAppDefStyle() -> String {
        return self.toString(format: "yyyy-MM-dd")
    }
}

extension String {
    
    func toDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    func toDateByAppDefStyle() -> Date? {
        return self.toDate(format: "yyyy-MM-dd")
    }
    
}
