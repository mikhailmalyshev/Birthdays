//
//  BirthdaysTableViewController.swift
//  Birthdays
//
//  Created by Михаил Малышев on 29.11.2021.
//

import UIKit

class BirthdaysTableViewController: UITableViewController {
    
    var persons: [Person] = [
        Person(name: "Misha",
               surname: "Malyshev",
               birthday: Date(timeIntervalSinceReferenceDate: 11131331)),
        Person(name: "Sasha",
               surname: "Krasnov",
               birthday: Date(timeIntervalSinceReferenceDate: 1413144))]
    var choices = ["Toyota","Honda","Chevy","Audi","BMW"]
    var pickerView = UIPickerView()
    var typeValue = String()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = "\(persons[indexPath.row].name) \(persons[indexPath.row].surname)"
        
        cell.contentConfiguration = content
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addPerson() {
        showAlert()
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
        
//        alert.view.addSubview(myDatePicker)
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
            textField.text = "Выбери дату ниже"
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
                self.persons.append(Person(name: "\(myDatePicker.date)", surname: surname!, birthday: Date(timeIntervalSinceReferenceDate: 1413144)))
            }
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}

//extension BirthdaysTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return choices.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return choices[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if row == 0 {
//            typeValue = "Toyota"
//        } else if row == 1 {
//            typeValue = "Honda"
//        } else if row == 2 {
//            typeValue = "Chevy"
//        } else if row == 3 {
//            typeValue = "Audi"
//        } else if row == 4 {
//            typeValue = "BMW"
//        }
//    }
//}
