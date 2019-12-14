//
//  AddItemView.swift
//  Geekhub iOS_HW_7
//
//  Created by Pavel Bondar on 05.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

protocol AddItemDelegate: AnyObject {
    func addItem(item: String, section: Int)
}

class AddItemViewController: UIViewController {

    weak var delegate: AddItemDelegate?
    private var sectionSelection = 0
    private var sections: [String]!

    @IBOutlet private weak var inputTextField: UITextField!
    @IBOutlet private weak var choiceStudents: UIPickerView!
    @IBAction private func goToRoot(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func specifySections(sections: [String]) {
        self.sections = sections
    }

    @IBAction private func addItemInListButton(_ sender: UIButton) {
        guard let item = inputTextField.text, inputTextField.hasText else { return }
        delegate?.addItem(item: item, section: sectionSelection)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDataSource
extension AddItemViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        sections.count
    }
}

// MARK: - UIPickerViewDelegate
extension AddItemViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        sections[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            sectionSelection = 0
        case 1:
            sectionSelection = 1
        case 2:
            sectionSelection = 2
        default:
            print("Other section")
        }
    }
}
