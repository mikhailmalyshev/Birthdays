//
//  BirthdaysViewModel.swift
//  Birthdays
//
//  Created by Михаил Малышев on 12.04.2022.
//

import Foundation

// MARK: - BirthdaysViewModelProtocol

protocol BirthdaysViewModelProtocol: AnyObject {
    var friends: [Friend] { get }
    var friendsCount: Int { get }
    
    func fetchFriends(completion: @escaping () -> Void)
    func cellViewModel(at index: IndexPath) -> FriendTableViewCellViewModelProtocol
    func addFriend(name: String, surname: String, birthDay: DateComponents)
    func removeFriend(at indexPath: Int)
    func sortByBirthDay()
}

// MARK: - BirthdaysViewModel

class BirthdaysViewModel: BirthdaysViewModelProtocol {
    
    // Настройка календаря
    
    private let now = Date()
    private let calendar = Calendar.current
    
    // Массив с друзьями

    var friends: [Friend] = []
    
    // Количество друзей в списке
    
    var friendsCount: Int {
        friends.count
    }
    
    // Получение списка друзей из БД
    
    func fetchFriends(completion: @escaping () -> Void) {
        self.friends = StorageManager.shared.fetchFriends()
        completion()
    }
    
    // viewModel для ячейки по индексу
    
    func cellViewModel(at indexPath: IndexPath) -> FriendTableViewCellViewModelProtocol {
        let friend = friends[indexPath.row]
        return FriendTablewViewCellViewModel(friend: friend)
    }
    
    // Добавление друга в таблицу
    
    func addFriend(name: String, surname: String, birthDay: DateComponents) {
        let friend = Friend(name: name,
                            surname: surname,
                            birthdate: birthDay)
        StorageManager.shared.saveFriends(with: friend)
    }
    
    // Удаление друга из таблицы
    
    func removeFriend(at indexPath: Int) {
        StorageManager.shared.deleteContact(at: indexPath)
    }
    
    // Сортировка самому близкому ДР
    
    func sortByBirthDay() {
        for friend in friends {
            let birthdate = calendar.date(from: friend.birthdate)!
            let components = calendar.dateComponents([.day, .month], from: birthdate)
            let nextDate = calendar.nextDate(after: now, matching: components, matchingPolicy: .nextTimePreservingSmallerComponents)
            friend.daysBeforeBirthday = calendar.dateComponents([.day], from: now, to: nextDate ?? now).day ?? 0
        }
        friends = friends.sorted(by: { $0.daysBeforeBirthday < $1.daysBeforeBirthday })
    }
}

