//
//  ShowDetailViewController.swift
//  Geekhub iOS_HW_7
//
//  Created by Pavel Bondar on 06.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController {
    
    @IBOutlet weak var detailLabel: UILabel!
    var name: String!
    var section: Int!
    var count: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailLabel.text = name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToChangeName" {
            let vc = segue.destination as! EditDetailViewController
            vc.editText = name
            vc.section = section
            vc.count = count
        }
    }
}
