//
//  AC.swift
//  ManagerOfTasks
//
//  Created by Антон Кирилюк on 18.04.2022.
//

import UIKit

struct AlertController {
    static func getAlertController() -> UIAlertController {
        let ac = UIAlertController(title: "Создание задачи", message: "Напишите задачу", preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Помыть кота"
        }
        let okAction = UIAlertAction(title: "Создать", style: .default)
        ac.addAction(okAction)
        
        return ac
    }
}

