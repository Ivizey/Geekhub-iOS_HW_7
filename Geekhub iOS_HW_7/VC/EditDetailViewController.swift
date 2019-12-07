//
//  EditDetailViewController.swift
//  Geekhub iOS_HW_7
//
//  Created by Pavel Bondar on 06.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class EditDetailViewController: UIViewController {
    
    @IBOutlet weak var changeNameTextField: UITextField!
    var editText: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeNameTextField.text = editText
    }
    
    @IBAction func goToRoot(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
