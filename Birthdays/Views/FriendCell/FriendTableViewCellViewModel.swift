//
//  FriendTableViewCellViewModel.swift
//  Birthdays
//
//  Created by Михаил Малышев on 12.04.2022.
//

import Foundation

// MARK: - TableViewCellViewModelProtocol

protocol FriendTableViewCellViewModelProtocol: AnyObject {
    var friendName: String { get }
    var friendSurname: String { get }
    var birthdayDescription: String { get }
    init(friend: Friend)
}

// MARK: - TableViewCellViewModel

class FriendTablewViewCellViewModel: FriendTableViewCellViewModelProtocol {
    
    private let friend: Friend
    
    var friendName: String {
        friend.name
    }
    
    var friendSurname: String {
        friend.surname
    }
    
    var birthdayDescription: String {
        friend.birthDayDescription()
    }
    
    required init(friend: Friend) {
        self.friend = friend
    }
}

