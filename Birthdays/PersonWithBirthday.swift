//
//  PersonWithBirthday.swift
//  Birthdays
//
//  Created by Михаил Малышев on 29.11.2021.
//

import Foundation

class Person {
    let name: String
    let surname: String
    var age: Int?
    var birthdate: DateComponents {
        didSet(date){
            let calendar = Calendar.current
            let now = calendar.dateComponents([.year, .month, .day], from: Date())
            let ageComponents = calendar.dateComponents([.year], from: date, to: now)
            age = ageComponents.year!
        }
    }
    init(name: String, surname: String, date: DateComponents) {
        self.name = name
        self.surname = surname
        birthdate = date
    }
    
    func burthDayDescription() -> String {
        let date = Calendar.current.date(from: birthdate)!
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        
        return formatter.string(from: date)
    }
}
