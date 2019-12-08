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
    var itemArray: ItemArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailLabel.text = itemArray.name
    }
    
    @IBAction func goToChangeName(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(identifier: "EditDetailViewController") as! EditDetailViewController
        vc.itemArray = itemArray
        navigationController?.pushViewController(vc, animated: true)
    }
}
