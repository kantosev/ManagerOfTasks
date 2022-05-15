//
//  CreateViewController.swift
//  ManagerOfTasks
//
//  Created by Антон Кирилюк on 15.05.2022.
//

import UIKit

class CreateTaskController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var doAfterEdit: ((String, String) -> Void)?
    var textInTextField: String = ""
    var textInTextView: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldText()
        setTextView()
    }
    
    // MARK: - SupportFunc
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let nameOfTask = textField.text ?? ""
        let taskText = textView.text ?? ""
        doAfterEdit?(nameOfTask, taskText)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    private func addTargetToTextField() {
        textField.addTarget(
            self,
            action: #selector(firstNameTextFieldDidChanged),
            for: .editingChanged
        )
    }
    @objc private func firstNameTextFieldDidChanged() {
        guard let firstName = textField.text else { return }
        saveButton.isEnabled = !firstName.isEmpty
    }
    private func setTextFieldText() {
        textField.text = textInTextField
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.layer.cornerRadius = 5
        textField.clearButtonMode = .whileEditing
    }
    private func setTextView() {
        textView.text = textInTextView
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.cornerRadius = 5
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.keyboardDismissMode = .onDrag
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
