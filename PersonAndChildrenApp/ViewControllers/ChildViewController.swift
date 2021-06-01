//
//  ChildViewController.swift
//  PersonAndChildrenApp
//
//  Created by Aleksandr Rybachev on 01.06.2021.
//

import UIKit

class ChildViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var childNameTF: UITextField!
    @IBOutlet var childAgeTF: UITextField!
    @IBOutlet var doneButton: UIBarButtonItem!
    
    var delegate: NewChildViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        childAgeTF.addTarget(
            self,
            action: #selector(textFieldChanged),
            for: .editingChanged
        )
    }
    
    // MARK: - IBActions
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        saveAndExit()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc func textFieldChanged() {
        guard let ageTF = childAgeTF.text else { return }
        doneButton.isEnabled = !ageTF.isEmpty ? true : false
    }
    
    // MARK: - Private methods
    private func saveAndExit() {
        guard let childName = childNameTF.text else { return }
        guard let childAge = childAgeTF.text else { return }
        
        let child = Child(name: childName, age: childAge)
        StorageManager.shared.saveChild(child: child)
        
        delegate.saveChild(child)
        dismiss(animated: true)
    }
    
}
