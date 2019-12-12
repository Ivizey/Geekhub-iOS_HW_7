//
//  ShowDetailViewController.swift
//  Geekhub iOS_HW_7
//
//  Created by Pavel Bondar on 06.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController {

    @IBOutlet weak private var detailLabel: UILabel!
    var itemArray: ItemArray!

    override func viewDidLoad() {
        super.viewDidLoad()

        detailLabel.text = itemArray.name
    }

    @IBAction private func goToChangeName(_ sender: UIBarButtonItem) {
        guard let editDetailViewController = storyboard?
            .instantiateViewController(identifier: "EditDetailViewController") as?
            EditDetailViewController else { return }
        editDetailViewController.itemArray = itemArray
        navigationController?.pushViewController(editDetailViewController, animated: true)
    }
}
