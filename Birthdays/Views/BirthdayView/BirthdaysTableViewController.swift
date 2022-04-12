//
//  BirthdaysTableViewController.swift
//  Birthdays
//
//  Created by Михаил Малышев on 29.11.2021.
//

import UIKit

// MARK: - BirthdaysTableViewController

class BirthdaysTableViewController: UITableViewController {
    
    // ViewModel
    
    private var viewModel: BirthdaysViewModelProtocol! {
        didSet {
            viewModel.fetchFriends {
                self.viewModel.sortByBirthDay()
                self.tableView.reloadData()
            }
        }
    }
    
    // Методы жизненного цикла VC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BirthdaysViewModel()
    }
    
    // Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.friendsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FriendTableViewCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            
            self.viewModel.removeFriend(at: indexPath.row)
            self.viewModel.fetchFriends {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    // IBAction для добавления ДР друга
    
    @IBAction func addPerson() {
        showAlert()
    }
}

// MARK: - Настройка алерта

extension BirthdaysTableViewController {
    
    private func showAlert() {
        let myDatePicker = UIDatePicker()
        myDatePicker.timeZone = .current
        myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        
        let alert = UIAlertController(title: "Добавить ДР друга",
                                      message: "Кого добавляем?",
                                      preferredStyle: .alert)
        
        alert.addTextField { (textField) -> Void in
            textField.text = "Имя"
            textField.isUserInteractionEnabled = false
        }
        
        alert.addTextField { (textField) -> Void in
            textField.text = ""
        }
        
        alert.addTextField { (textField) -> Void in
            textField.text = "Фамилия"
            textField.isUserInteractionEnabled = false
        }
        alert.addTextField { (textField) -> Void in
            textField.text = ""
        }
        
        alert.addTextField { textField in
            textField.text = "День Рождения"
            textField.isUserInteractionEnabled = false
        }
        
        alert.addTextField { textField in
            textField.text = "Тапни сюда"
            textField.inputView = myDatePicker
        }
        
        if let textFields = alert.textFields {
            if textFields.count > 0 {
                textFields[0].superview!.superview!.subviews[0].removeFromSuperview()
                textFields[0].superview!.backgroundColor = UIColor.clear
            }
            
            if textFields.count > 2 {
                textFields[2].superview!.superview!.subviews[0].removeFromSuperview()
                textFields[2].superview!.backgroundColor = UIColor.clear
            }
            if textFields.count > 4 {
                textFields[4].superview!.superview!.subviews[0].removeFromSuperview()
                textFields[4].superview!.backgroundColor = UIColor.clear
            }
            if textFields.count > 5 {
                textFields[5].superview!.superview!.subviews[0].removeFromSuperview()
                textFields[5].superview!.backgroundColor = UIColor.clear
            }
        }
        
        let saveAction = UIAlertAction(title: "Добавить", style: .default) { (saveAction) in
            guard let name = alert.textFields![1].text else { return }
            guard let surname = alert.textFields![3].text else { return }
            if name != "" && surname != "" {
                saveAction.isEnabled = true
                let birthDate = myDatePicker.calendar.dateComponents([.day, .month, .year], from: myDatePicker.date)
                
                self.viewModel.addFriend(name: name,
                                         surname:surname,
                                         birthDay: birthDate)
                self.viewModel.fetchFriends {
                    self.viewModel.sortByBirthDay()
                    UIView.transition(with: self.tableView,
                                      duration: 1,
                                      options: .transitionCrossDissolve,
                                      animations: { self.tableView.reloadData() })
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

