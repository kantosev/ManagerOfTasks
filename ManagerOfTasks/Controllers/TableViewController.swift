//
//  TableViewController.swift
//  ManagerOfTasks
//
//  Created by Антон Кирилюк on 18.04.2022.
//

import UIKit
import CoreData


class TableViewController: UITableViewController {
    
    private var tasks: [Task] = []
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = Tasks.fetchData()
        
        // Uncomment the following line to preserve selection between presentations
//                 self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
   
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        // Configure content.
        content.text = tasks[indexPath.row].title
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    // удаление и изменение задачи
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = tasks[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _,_,_ in
            self.tasks.remove(at: indexPath.row)
            self.context.delete(task)
            do {
                try self.context.save()
            } catch {
                print(error)
            }
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let changeAction = UIContextualAction(style: .normal, title: "Изменить") { _,_,_ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "CreateTaskController") as? CreateTaskController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
            vc.textInTextField = self.tasks[indexPath.row].title ?? ""
            vc.doAfterEdit = { [unowned self] nameOfTask in
                if nameOfTask != vc.textInTextField {
                    guard let index = self.tasks.firstIndex(of: self.tasks[indexPath.row]) else { return }
                    task.title = nameOfTask
                    self.context.refresh(task, mergeChanges: true)
                    do {
                        try context.save()
                    } catch {
                        print(error)
                    }
                    self.tasks.remove(at: index)
                    self.tasks.insert(task, at: index)
                    self.tableView.reloadData()
                   
                }
            }
        }
        let actions = UISwipeActionsConfiguration(actions: [deleteAction, changeAction])
        return actions
    }
    
    
    
    
    
//      Перемещение ячеек
//     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//         let fromTask = tasks.remove(at: fromIndexPath.row)
//         let fromTaskIndex = fromTask.index
//         let toTask = tasks[to.row]
//         tasks.insert(fromTask, at: to.row)
//
//         fromTask.index = toTask.index
////         toTask.index = fromTaskIndex
//         context.refresh(fromTask, mergeChanges: true)
//
//         if context.hasChanges {
//             do {
//                 try self.context.save()
//             } catch {
//                 print(error)
//             }
//         }
//     }
     
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateScreen" {
            guard let destination = segue.destination as? CreateTaskController else { return }
            destination.doAfterEdit = { [unowned self] nameOfTask in
                guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
                guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
                task.title = nameOfTask
                task.index = Int16(tasks.count)
                if context.hasChanges {
                    do {
                        try context.save()
                    } catch {
                        print(error)
                    }
                }
                self.tasks.append(task)
                self.tableView.reloadData()
//                Tasks.saveData(data: tasks, key: "tasks")
                
            }
            
        }
    }
    // Убирает красный кружок
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    // Не сдвигает таблицу вправо при редактировании
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    
}
