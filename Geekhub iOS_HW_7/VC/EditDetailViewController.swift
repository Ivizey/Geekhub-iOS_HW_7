//
//  EditDetailViewController.swift
//  Geekhub iOS_HW_7
//
//  Created by Pavel Bondar on 06.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

protocol EditItemDelegate {
    func editItem(item: String, section: Int, count: Int)
}

class EditDetailViewController: UIViewController {
    
    @IBOutlet weak var changeNameTextField: UITextField!
    var editText: String!
    var section: Int!
    var count: Int!
    var delegate: EditItemDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeNameTextField.text = editText
    }
    
    @IBAction func saveChangesButton(_ sender: UIBarButtonItem) {
        guard let editItem = changeNameTextField.text, changeNameTextField.hasText else {return}
        delegate?.editItem(item: editItem, section: section, count: count)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func goToRoot(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
