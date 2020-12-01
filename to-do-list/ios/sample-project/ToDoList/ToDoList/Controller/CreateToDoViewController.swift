//
//  CreateToDoViewController.swift
//  ToDoList
//
//  Created by stone on 2018/01/28.
//  Copyright © 2018年 stone. All rights reserved.
//

import Foundation
import UIKit

class CreateToDoViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Class Properties
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var limitDateTextField: UITextField!
    @IBOutlet weak var limitDateSwitch: UISwitch!
    @IBOutlet var priorityStars: [UIImageView]!
    @IBOutlet weak var prioritySlider: UISlider!
    @IBOutlet weak var detailTextView: UITextView!
    private let datePicker = UIDatePicker()
    private let createSegueIdentifier = "Create"
    
    // MARK: View LifeCycle Meshods
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.limitDateTextField.text = datePicker.date.toStrByAppDefStyle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case createSegueIdentifier:
            guard let _ = segue.destination as? MainViewController else {
                fallthrough
            }
            let newToDo = createToDo()
            ToDoList.obj.append(newToDo)
            ToDoList.obj.saveToStorage()
        default:
            print("")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
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
    
    private func createToDo() -> ToDo {
        let toDo = ToDo()
        if case "" = self.titleTextField.text!  {
            toDo.title = "タイトル未設定"
        } else {
            toDo.title = self.titleTextField.text!
        }
        toDo.isLimited = self.limitDateSwitch.isOn
        toDo.limitDate = self.limitDateTextField.text!.toDateByAppDefStyle() ?? Date()
        toDo.registrationDate = Date()
        toDo.priority = Int(self.prioritySlider.value)
        toDo.detail = self.detailTextView.text!
        return toDo
    }
    
    @objc private func onDidChangeDate(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        limitDateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
}

