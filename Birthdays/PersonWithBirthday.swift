//
//  PersonWithBirthday.swift
//  Birthdays
//
//  Created by Михаил Малышев on 29.11.2021.
//

import Foundation

class Friend: Codable {
    let name: String
    let surname: String
    let birthdate: DateComponents
    var daysBeforeBirthday = 0
    
    init(name: String, surname: String, birthdate: DateComponents) {
        self.name = name
        self.surname = surname
        self.birthdate = birthdate
    }
    
    func burthDayDescription() -> String {
        let date = Calendar.current.date(from: birthdate)!
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        
        var age: Int
        let calendar = Calendar.current
        let now = calendar.dateComponents([.year, .month, .day], from: Date())
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
        age = ageComponents.year!

        return "\((formatter.string(from: date))), \(age) years"
    }
}
