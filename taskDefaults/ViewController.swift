//
//  ViewController.swift
//  taskDefaults
//
//  Created by Felipe Santos on 28/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    var tasks : [String] = []
    
    let textField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Adicionar tarefas..."
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let button : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func saveTasks() {
        UserDefaults.standard.set(tasks, forKey: "tasks")
    }
    
    @objc func addTask() {
        if let task = textField.text, !task.isEmpty {
            tasks.append(task)
            saveTasks()
            tableView.reloadData()
            textField.text = ""
        }
    }
    
    func loadTasks() -> [String] {
        return UserDefaults.standard.stringArray(forKey: "tasks") ?? []
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func configureTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureConstraints() {
        [textField, button, tableView].forEach {
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        button.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        configureTapGestureRecognizer()
        configureConstraints()
        tasks = loadTasks()
    }
    
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Apagar"
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            saveTasks()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = tasks.remove(at: fromIndexPath.row)
        tasks.insert(itemToMove, at: to.row)
        saveTasks()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
}

