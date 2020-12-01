//
//  ToDo.swift
//  ToDoList
//
//  Created by stone on 2018/01/27.
//  Copyright © 2018年 stone. All rights reserved.
//

import Foundation

class ToDo: Codable {
    
    var title: String = ""
    var detail: String = ""
    var priority: Int = 1
    var limitDate: Date = Date()
    var registrationDate: Date = Date()
    var isLimited: Bool = false
    
}

class ToDoList {
    
    enum SortType {
        case registrationDate
        case limitDate
        case priority
    }
    
    // MARK: Class Properties
    static let obj = ToDoList()
    private var list: [ToDo] = []
    var count: Int  {
        get {
          return self.list.count
        }
    }
    private let storedKey = "ToDoList"
    
    private init() {}
    
    // Global Functions
    func append(_ toDo: ToDo) {
        self.list.append(toDo)
    }
    
    func remove(at index: Int) {
        self.list.remove(at: index)
    }
    
    func getElement(at index: Int) -> ToDo? {
        return (0..<self.count ~= index) ? self.list[index] : nil
    }
    
    func saveToStorage() {
        if let toDoListData = try? JSONEncoder().encode(self.list) {
            UserDefaults.standard.set(toDoListData, forKey: self.storedKey)
            // UserDefaults.standard.synchronize()は非推奨とのこと
        }
    }
    
    func loadStorage() {
        if let storedData = UserDefaults.standard.data(forKey: self.storedKey),
         let decodedData = try? JSONDecoder().decode([ToDo].self, from: storedData) {
            self.list = decodedData
        }
    }
    
    func sort(by type: SortType) {
        switch type {
        case .registrationDate:
            self.sortByRegistrationDate()
        case .limitDate:
            self.sortByLimitDate()
        case .priority:
            self.sortByPriority()
        }
    }
    
    private func sortByRegistrationDate() {
        self.list.sort(by: { $0.registrationDate > $1.registrationDate })
    }
    
    private func sortByLimitDate() {
        let limitedToDoList = self.list.filter { $0.isLimited }.sorted { $0.limitDate < $1.limitDate }
        let unlimitedToDoList = self.list.filter { !$0.isLimited }.sorted { $0.limitDate < $1.limitDate }
        self.list = limitedToDoList + unlimitedToDoList
    }
    
    private func sortByPriority() {
        self.list.sort(by: { $0.priority > $1.priority })
    }
    
}
