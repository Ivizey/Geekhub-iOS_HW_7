//
//  FreeCell.swift
//  Geekhub iOS_HW_7
//
//  Created by Pavel Bondar on 29.11.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class FreeCell: UITableViewCell {

    @IBOutlet private weak var overwriteButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    func setNameLabel(name: String) {
        nameLabel.text = name
    }
    func getTaskOverWriteButton() -> UIButton {
        return overwriteButton
    }
}
