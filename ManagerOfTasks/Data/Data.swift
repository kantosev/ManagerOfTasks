//
//  Data.swift
//  ManagerOfTasks
//
//  Created by Антон Кирилюк on 18.04.2022.
//

import Foundation

struct Tasks {
//    static let tasks: [String] = ["Выгулять собаку", "Покормить кота", "Сходить в магазин", "Убраться"]
    
    static let userDefaults = UserDefaults.standard
    
    static func saveData(data: [String], key: String) {
        userDefaults.set(data, forKey: key)
    }
    
    static func fetchData(key: String) -> [String] {
        return userDefaults.object(forKey: key) as? [String]  ?? []
    }
}
