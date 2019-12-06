//
//  AddItemView.swift
//  Geekhub iOS_HW_7
//
//  Created by Pavel Bondar on 05.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class AddItemView: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
