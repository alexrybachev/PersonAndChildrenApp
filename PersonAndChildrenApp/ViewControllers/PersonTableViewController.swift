//
//  PersonTableViewController.swift
//  PersonAndChildrenApp
//
//  Created by Aleksandr Rybachev on 31.05.2021.
//

import UIKit

protocol NewChildViewControllerDelegate {
    func saveChild(_ child: Child)
}

class PersonTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var tableTView: UITableView!
    @IBOutlet var addButton: UIBarButtonItem!
    
    // MARK: - Private properties
    private let sections = ["Обо мне", "Мои дети"]
    private var kids: [Child] = [] {
        didSet {
            if kids.count >= 5 {
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kids = StorageManager.shared.fetchChildren()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newChildVC = segue.destination as! ChildViewController
        newChildVC.delegate = self
    }

    // MARK: - TableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return kids.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let personCell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonTableViewCell
            
            return personCell
        default:
            let childCell = tableView.dequeueReusableCell(withIdentifier: "childCell", for: indexPath)
            let child = kids[indexPath.row]
            
            var content = childCell.defaultContentConfiguration()
            content.text = child.name
            content.secondaryText = child.age + " лет"
            childCell.contentConfiguration = content
            
            return childCell
        }
    }
    
}

// MARK: - UITableViewDelegate
extension PersonTableViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            kids.remove(at: indexPath.row)
            StorageManager.shared.deleteChild(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - Protocol NewChildViewControllerDelegate
extension PersonTableViewController: NewChildViewControllerDelegate {
    func saveChild(_ child: Child) {
        kids.append(child)
        tableTView.reloadData()
    }
}

