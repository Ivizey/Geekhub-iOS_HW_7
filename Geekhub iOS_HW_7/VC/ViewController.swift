//
//  ViewController.swift
//  Geekhub iOS_HW_7
//
//  Created by Pavel Bondar on 29.11.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var groupListTableView: UITableView!
    
    var sections = ["Учні", "Вільні слухачі", "Вибули"]

    var students = [
        "Бондар Павло",
        "Вождай Ігор",
        "Демченко Михайло",
        "Запорожець Максим",
        "Ілюшенко Ілля",
        "Nedopaka Alexander",
        "Таченко Дмитро",
        "Гуріненко Валентин"]
    
    var off = ["Горошнюк Вячеслав",
            "БЕРЕЗА МАРИНА",]
    
    var free = ["Пухлій Віталій",
             "Сагайдак Ілля",
             "Шурман Андрій",
             "Лавренко Віталій",
             "Братчикова Дар'я",
             "Крістіна",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "FreeCell", bundle: nil)
        groupListTableView.beginUpdates()
        groupListTableView.register(nib, forCellReuseIdentifier: "FreeCell")
        groupListTableView.endUpdates()
        
        NotificationCenter.default.addObserver(self, selector: #selector(insertItemArray), name: NSNotification.Name(rawValue: "editName"), object: nil)
    }
    
    //MARK: - Edit item in array's
    @objc func insertItemArray(notification: Notification) {
        let editVC = notification.object as! EditDetailViewController
        guard let editItem = editVC.changeNameTextField.text, editVC.changeNameTextField.hasText else {return}
        let index = editVC.itemArray.index
        switch editVC.itemArray.section {
        case 0:
            students[index] = editItem
        case 1:
            free[index] = editItem
        case 2:
            off[index] = editItem
        default:
            print("Other action")
        }
        groupListTableView.reloadData()
    }
    
    // MARK: - Presentation modal view
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddItemView") as! AddItemView
        vc.delegate = self
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = storyboard?.instantiateViewController(identifier: "ShowDetailViewController") as! ShowDetailViewController
        var name = String()
        switch indexPath.section {
        case 0:
            name = students[indexPath.row]
        case 1:
            name = free[indexPath.row]
        case 2:
            name = off[indexPath.row]
        default:
            print("Other list")
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "FreeCell", for: indexPath) as! FreeCell
            cell.nameLabel.text = free[indexPath.row]
            cell.overwriteButton.addTarget(self, action: #selector(buttonMethod), for: .touchUpInside)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OffCell", for: indexPath)
            cell.textLabel?.text = off[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @objc func buttonMethod(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: groupListTableView)
        guard let indexPath = groupListTableView.indexPathForRow(at: point) else {return}
        students.append(free[indexPath.row])
        groupListTableView.reloadData()
        free.remove(at: indexPath.row)
        groupListTableView.deleteRows(at: [indexPath], with: .none)
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = .center
        header.textLabel?.font = .systemFont(ofSize: 17.0, weight: .light)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            free.append(students[indexPath.row])
            tableView.reloadData()
            students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
            break
        case 1:
            off.append(free[indexPath.row])
            tableView.reloadData()
            free.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
            break
        case 2:
            off.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            print("Action")
        }
    }
}

//MARK: - AddItemDelegate
extension ViewController: AddItemDelegate {
    func addItem(item: String, section: Int) {
        switch section {
        case 0:
            students.append(item)
        case 1:
            free.append(item)
        case 2:
            off.append(item)
        default:
            print("Other action")
        }
        groupListTableView.reloadData()
    }
}
