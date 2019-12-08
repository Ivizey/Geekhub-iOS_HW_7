//
//  AddItemView.swift
//  Geekhub iOS_HW_7
//
//  Created by Pavel Bondar on 05.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

protocol AddItemDelegate {
    func addItem(item: String, section: Int)
}

class AddItemView: UIViewController {
    
    var delegate: AddItemDelegate?
    var checkGroup: Int?
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var studentButton: UIButton!
    @IBOutlet weak var freeButton: UIButton!
    @IBOutlet weak var offButton: UIButton!
    
    @IBAction func goToRoot(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addItemInListButton(_ sender: UIButton) {
        
        guard let item = inputTextField.text, inputTextField.hasText else {return}
        if let checkGroup = checkGroup {
            delegate?.addItem(item: item, section: checkGroup)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func groupSelection(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            checkGroup = 0
            freeButton.setImage(nil, for: .normal)
            offButton.setImage(nil, for: .normal)
        case 1:
            checkGroup = 1
            studentButton.setImage(nil, for: .normal)
            offButton.setImage(nil, for: .normal)
        case 2:
            checkGroup = 2
            freeButton.setImage(nil, for: .normal)
            studentButton.setImage(nil, for: .normal)
        default:
            print("Other section")
        }
        sender.setImage(UIImage(named: "logo"), for: .normal)
    }
}
