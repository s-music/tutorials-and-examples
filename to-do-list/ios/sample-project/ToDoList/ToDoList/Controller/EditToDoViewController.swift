//
//  EditToDoViewController.swift
//  ToDoList
//
//  Created by stone on 2018/01/28.
//  Copyright © 2018年 stone. All rights reserved.
//

import Foundation
import UIKit

class EditToDoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var limitDateTextField: UITextField!
    @IBOutlet weak var limitDateSwitch: UISwitch!
    @IBOutlet var priorityStars: [UIImageView]!
    @IBOutlet weak var prioritySlider: UISlider!
    @IBOutlet weak var detailTextView: UITextView!
    private let datePicker = UIDatePicker()
    private let saveSegueIdentifier = "Save"
    var editedToDo: ToDo = ToDo()
 
    // MARK: View LifeCycle Metods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleTextField.delegate = self
        self.limitDateTextField.delegate = self
        self.limitDateTextField.inputView = datePicker
        datePicker.locale = Locale(identifier: "ja_JP")
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.onDidChangeDate(datePicker:)), for: .valueChanged)
        self.detailTextView.layer.borderColor = UIColor.darkGray.cgColor
        self.detailTextView.layer.borderWidth = 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.titleTextField.text! = editedToDo.title
        self.limitDateTextField.text! = editedToDo.limitDate.toStrByAppDefStyle()
        self.limitDateSwitch.isOn = editedToDo.isLimited
        self.prioritySlider.value = Float(editedToDo.priority)
        self.detailTextView.text! = editedToDo.detail
        updatePriorityStars(priority: editedToDo.priority)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case saveSegueIdentifier:
            saveToDoData()
            ToDoList.obj.saveToStorage()
        default:
            print("")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Local Functions
    private func saveToDoData() {
        if case "" = self.titleTextField.text! {
            editedToDo.title = "タイトル未設定"
        } else {
            editedToDo.title = self.titleTextField.text!
        }
        editedToDo.isLimited = self.limitDateSwitch.isOn
        editedToDo.limitDate = self.limitDateTextField.text!.toDateByAppDefStyle() ?? Date()
        editedToDo.priority = Int(self.prioritySlider.value)
        editedToDo.detail = self.detailTextView.text
    }
    
    
    // MARk: COPY
    // MARK: IBActions
    @IBAction func changePrioritySlider(_ sender: Any) {
        updatePriorityStars(priority: Int(prioritySlider.value))
    }
    
    @IBAction func onClickLimitDateSwitch(_ sender: Any) {
        switchLimitDateTextField(limitDateSwitch.isOn)
    }
    
    // MARK: Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // Local Functions
    private func updatePriorityStars(priority: Int) {
        priorityStars.forEach { $0.isHidden = ($0.tag > priority) }
    }
    
    private func switchLimitDateTextField(_ isOn: Bool) {
        if(isOn) {
            self.limitDateTextField.isEnabled = true
            self.limitDateTextField.textColor = UIColor.black
        } else {
            self.limitDateTextField.isEnabled = false
            self.limitDateTextField.textColor = UIColor.lightGray
        }
    }
    
    @objc private func onDidChangeDate(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        limitDateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
}

