//
//  StorageManager.swift
//  Birthdays
//
//  Created by Михаил Малышев on 06.12.2021.
//

import Foundation

//MARK: - StorageManager

class StorageManager {
    
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let friendKey = "friends"
    
    func saveFriends(with friend: Friend) {
        var friends = fetchFriends()
        friends.append(friend)

        guard let data = try? JSONEncoder().encode(friends) else { return }
        userDefaults.set(data, forKey: friendKey)
    }

    func fetchFriends() -> [Friend] {
        guard let data = userDefaults.object(forKey: friendKey) as? Data else { return [] }
        guard let friends = try? JSONDecoder().decode([Friend].self, from: data) else { return [] }
        return friends
    }

    func deleteContact(at index: Int) {
        var friends = fetchFriends()
        friends.remove(at: index)

        guard let data = try? JSONEncoder().encode(friends) else { return }
        userDefaults.set(data, forKey: friendKey)
    }
}
