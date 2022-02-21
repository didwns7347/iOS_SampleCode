//
//  To_DOTableViewController.swift
//  tableViewSampleApp
//
//  Created by yangjs on 2022/02/18.
//

import UIKit

class To_DOTableViewController: UITableViewController {

    @IBOutlet var editBtn: UIBarButtonItem!
    var doneBtn:UIBarButtonItem?
    var tasks = [Task](){
        didSet{
            self.saveTasks()
        }
    }
    override  func viewDidLoad() {
        super.viewDidLoad()
        self.loadTasks()
        self.doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
    }

    @objc func doneButtonTap(){
        self.navigationItem.leftBarButtonItem=self.editBtn
        self.tableView.setEditing(false, animated: true)
    }
    @IBAction func tapEditBtn(_ sender: UIBarButtonItem) {
        guard !self.tasks.isEmpty else{return}
        self.navigationItem.leftBarButtonItem = self.doneBtn
        self.tableView.setEditing(true, animated: true)
    }
    
    @IBAction func addMemoTapped(_ sender: UIBarButtonItem) {
        var addAlert = UIAlertController.init(title: "메모", message:nil, preferredStyle: .alert)
        addAlert.addTextField(configurationHandler: {textFeild in textFeild.placeholder="할 일 입력하셈~"})
        let ok = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let title = addAlert.textFields?[0].text else {return}
            self?.tasks.append(Task(title: title, done: false))
            self?.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        addAlert.addAction(ok)
        addAlert.addAction(cancel)
        self.present(addAlert, animated: true, completion: nil)
    }
    
    func saveTasks(){
        let data = self.tasks.map{["title": $0.title,"done":$0.done]}
        let defaults = UserDefaults.standard
        defaults.set(data,forKey: "tasks")
    }
    func loadTasks(){
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: "tasks") as? [[String:Any]] else {return}
        self.tasks = data.compactMap{
            guard let title = $0["title"] as? String else{return nil}
            guard let done = $0["done"] as? Bool else {return nil}
            return Task(title: title, done: done)
        }
        
    }
    

}

extension To_DOTableViewController{
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for:indexPath)
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        if task.done{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = self.tasks[indexPath.row]
        task.done = !task.done
        self.tasks[indexPath.row] = task
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        if self.tasks.isEmpty{
            self.doneButtonTap()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tasks = self.tasks
        let task = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task,at :destinationIndexPath.row)
        self.tasks=tasks
    }
}
