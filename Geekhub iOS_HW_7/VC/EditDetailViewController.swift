//
//  EditDetailViewController.swift
//  Geekhub iOS_HW_7
//
//  Created by Pavel Bondar on 06.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class EditDetailViewController: UIViewController {

    @IBOutlet weak private var changeNameTextField: UITextField!
    var itemArray: ItemArray!

    override func viewDidLoad() {
        super.viewDidLoad()

        changeNameTextField.text = itemArray.name
    }
    func getTextFromTetField() -> String {
        if let text = changeNameTextField.text, changeNameTextField.hasText {
            return text
        } else {
            return ""
        }
    }

    @IBAction private func saveChangesButton(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeANameInTheList"), object: self)
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction private func goToRoot(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
