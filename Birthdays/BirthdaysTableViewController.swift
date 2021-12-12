//
//  BirthdaysTableViewController.swift
//  Birthdays
//
//  Created by Михаил Малышев on 29.11.2021.
//

import UIKit

class BirthdaysTableViewController: UITableViewController {
    
    private var friends: [Friend] = []
    let now = Date()
    let calendar = Calendar.current

    override func viewDidLoad() {
        super.viewDidLoad()
        friends = StorageManager.shared.fetchFriends()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sortFriendsByBirthday()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = "\(friends[indexPath.row].name) \(friends[indexPath.row].surname)"
        content.secondaryText = "\(friends[indexPath.row].burthDayDescription())"
        
        cell.contentConfiguration = content
        return cell
    }

    @IBAction func addPerson() {
        showAlert()
    }
    
    func sortFriendsByBirthday() {
        for birthday in friends {
            let birthdate = calendar.date(from: birthday.birthdate)!
            let components = calendar.dateComponents([.day, .month], from: birthdate)
            let nextDate = calendar.nextDate(after: now, matching: components, matchingPolicy: .nextTimePreservingSmallerComponents)
            birthday.daysBeforeBirthday = calendar.dateComponents([.day], from: now, to: nextDate ?? now).day ?? 0
        }
        friends = friends.sorted(by: { $0.daysBeforeBirthday < $1.daysBeforeBirthday })
    }
    
}

extension BirthdaysTableViewController {
    
    private func showAlert() {
        let title = "Добавить ДР друга"
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.timeZone = .current
        myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        
        let alert = UIAlertController(title: title, message: "Кого добавляем?", preferredStyle: .alert)
        
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
            let name = alert.textFields![1].text
            let surname = alert.textFields![3].text
            if name != "" && surname != "" {
                saveAction.isEnabled = true
             self.friends.append(Friend(name: name!, surname: surname!, birthdate: myDatePicker.calendar.dateComponents([.day, .month, .year], from: myDatePicker.date)))
                StorageManager.shared.saveFriends(with: self.friends.last!)
            }
            UIView.transition(with: self.tableView,
                              duration: 1,
                              options: .transitionCrossDissolve,
                              animations: { self.tableView.reloadData() })
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}
