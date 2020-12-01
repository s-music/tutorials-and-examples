//
//  ViewController.swift
//  ToDoList
//
//  Created by stone on 2018/01/22.
//  Copyright © 2018年 stone. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Class Properties
    @IBOutlet weak var toDoTable: UITableView!
    private let toDoCellIdentifier = "ToDoTableCell"
    private let editSegueIdentifier = "Edit"
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    
    // MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        toDoTable.delegate = self
        toDoTable.dataSource = self
        ToDoList.obj.loadStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        toDoTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier) {
        case editSegueIdentifier:
            if let vc = segue.destination as? EditToDoViewController,
                let indexPath = self.toDoTable.indexPathForSelectedRow,
                let selectedToDo = ToDoList.obj.getElement(at: indexPath.row) {
                
                vc.editedToDo = selectedToDo
            }
        default:
            print("")
        }
    }
    
    // MARK: IBActions
    @IBAction func createSegue(segue: UIStoryboardSegue) {}
    @IBAction func saveSegue(segue: UIStoryboardSegue) {}
    
    @IBAction func onClickSortButton(_ sender: Any) {
        createAlert()
    }
    
    
    // MARK: Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoList.obj.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: toDoCellIdentifier, for: indexPath) as! ToDoTableCell
        if let toDo = ToDoList.obj.getElement(at: indexPath.row) {
            cell.setItem(toDo)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            ToDoList.obj.remove(at: indexPath.row)
            ToDoList.obj.saveToStorage()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: Local Functions
    
    private func sort(type: ToDoList.SortType) {
        ToDoList.obj.sort(by: type)
        self.toDoTable.reloadData()
    }
    
    private func createAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "登録日順", style: .default) {
            (action: UIAlertAction) in self.sort(type: .registrationDate)
        })
        alertController.addAction(UIAlertAction(title: "期限順", style: .default) {
            (action: UIAlertAction) in self.sort(type: .limitDate)
        })
        alertController.addAction(UIAlertAction(title: "優先度順", style: .default) {
            (action: UIAlertAction) in self.sort(type: .priority)
        })
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    

}

