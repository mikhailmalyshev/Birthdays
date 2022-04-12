//
//  FriendTableViewCell.swift
//  Birthdays
//
//  Created by Михаил Малышев on 12.04.2022.
//

import UIKit

// MARK: - CustomTablewViewCell

class FriendTableViewCell: UITableViewCell {
    var viewModel: FriendTableViewCellViewModelProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = "\(viewModel.friendName) \(viewModel.friendSurname)"
            content.secondaryText = "\(viewModel.birthdayDescription)"
            contentConfiguration = content
        }
    }
}
