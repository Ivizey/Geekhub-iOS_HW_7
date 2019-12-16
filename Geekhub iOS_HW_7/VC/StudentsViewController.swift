//
//  ViewController.swift
//  Geekhub iOS_HW_7
//
//  Created by Pavel Bondar on 29.11.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class StudentsViewController: UIViewController {

    @IBOutlet weak private var groupListTableView: UITableView!

    private var sections = ["Учні", "Вільні слухачі", "Вибули"]

    private var students = [
        "Бондар Павло",
        "Вождай Ігор",
        "Демченко Михайло",
        "Запорожець Максим",
        "Ілюшенко Ілля",
        "Nedopaka Alexander",
        "Таченко Дмитро",
        "Гуріненко Валентин"]

    private var off = ["Горошнюк Вячеслав",
                       "БЕРЕЗА МАРИНА" ]
    private var free = ["Пухлій Віталій",
                        "Сагайдак Ілля",
                        "Шурман Андрій",
                        "Лавренко Віталій",
                        "Братчикова Дар'я",
                        "Крістіна" ]

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "FreeCell", bundle: nil)
        groupListTableView.beginUpdates()
        groupListTableView.register(nib, forCellReuseIdentifier: "FreeCell")
        groupListTableView.endUpdates()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(insertItemArray),
                                               name: NSNotification.Name(rawValue: "changeANameInTheList"),
                                               object: nil)
    }

    // MARK: - Presentation modal view
    @IBAction private func addItemButton(_ sender: UIBarButtonItem) {
        guard let addViewController = storyboard?
            .instantiateViewController(withIdentifier: "AddItemViewController") as?
            AddItemViewController else { return }
        addViewController.specifySections(sections: sections)
        addViewController.delegate = self
        addViewController.modalPresentationStyle = .automatic
        present(addViewController, animated: true, completion: nil)
    }

    // MARK: - Edit item in array's
    @objc func insertItemArray(notification: Notification) {
        guard let editViewController = notification.object as? EditDetailViewController else { return }
        let editItem = editViewController.getTextFromTetField()
        let index = editViewController.itemArray.index
        switch editViewController.itemArray.section {
        case 0:
            students[index] = editItem
        case 1:
            free[index] = editItem
        case 2:
            off[index] = editItem
        default:
            return
        }
        groupListTableView.reloadData()
    }

    @objc func moveItem(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: groupListTableView)
        guard let indexPath = groupListTableView.indexPathForRow(at: point) else { return }
        groupListTableView.beginUpdates()
        students.append(free[indexPath.row])
        free.remove(at: indexPath.row)
        groupListTableView.insertRows(at: [IndexPath(row: students.count - 1,
                                                     section: indexPath.section - 1)], with: .bottom)
        groupListTableView.deleteRows(at: [indexPath], with: .top)
        groupListTableView.endUpdates()
    }
}

// MARK: - UITableViewDataSource
extension StudentsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailView = storyboard?
            .instantiateViewController(identifier: "ShowDetailViewController") as?
            ShowDetailViewController else { return }
        var name: String!
        switch indexPath.section {
        case 0:
            name = students[indexPath.row]
        case 1:
            name = free[indexPath.row]
        case 2:
            name = off[indexPath.row]
        default:
            return
        }
        let itemArray = ItemArray(name: name, section: indexPath.section, index: indexPath.row)
        detailView.itemArray = itemArray
        navigationController?.pushViewController(detailView, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return students.count
        case 1:
            return free.count
        case 2:
            return off.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StudentsCell", for: indexPath)
            cell.textLabel?.text = students[indexPath.row]
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FreeCell", for: indexPath) as? FreeCell
            if let cell = cell {
                cell.setNameLabel(name: free[indexPath.row])
                let button = cell.getTaskOverWriteButton()
                button.addTarget(self, action: #selector(moveItem(_:)), for: .touchUpInside)
                return cell
            } else {
                return UITableViewCell()
            }
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OffCell", for: indexPath)
            cell.textLabel?.text = off[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension StudentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textAlignment = .center
        header.textLabel?.font = .systemFont(ofSize: 17.0, weight: .light)
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        switch indexPath.section {
        case 0:
            free.append(students[indexPath.row])
            students.remove(at: indexPath.row)
            tableView.insertRows(at: [IndexPath(row: free.count - 1, section: indexPath.section + 1)], with: .right)
        case 1:
            off.append(free[indexPath.row])
            free.remove(at: indexPath.row)
            tableView.insertRows(at: [IndexPath(row: off.count - 1, section: indexPath.section + 1)], with: .right)
        case 2:
            off.remove(at: indexPath.row)
        default:
            return
        }
        tableView.deleteRows(at: [indexPath], with: .left)
        tableView.endUpdates()
    }
}

// MARK: - AddItemDelegate
extension StudentsViewController: AddItemDelegate {
    func addItem(item: String, section: Int) {
        switch section {
        case 0:
            students.append(item)
        case 1:
            free.append(item)
        case 2:
            off.append(item)
        default:
            return
        }
        groupListTableView.reloadData()
    }
}
