//
//  AddItemView.swift
//  Geekhub iOS_HW_7
//
//  Created by Pavel Bondar on 05.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

protocol AddItemDelegate {
    func addItem(item: String)
}

class AddItemView: UIViewController {
    
    var delegate: AddItemDelegate?
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBAction func goToRoot(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addItemInListButton(_ sender: UIButton) {
        
        guard let item = inputTextField.text, inputTextField.hasText else {return}
        delegate?.addItem(item: item)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func groupSelection(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("0")
        case 1:
            print("1")
        case 2:
            print("2")
        default:
            print("Acrion")
        }
    }
}
