//
//  Data.swift
//  ManagerOfTasks
//
//  Created by Антон Кирилюк on 18.04.2022.
//

import UIKit
import CoreData

struct Tasks {
    
    private static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func fetchData() -> [Task] {
        var tasks: [Task] = []
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "index", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            tasks = try context.fetch(fetchRequest)
            return tasks
        } catch {
            print(error)
        }
        return []
    }
}
