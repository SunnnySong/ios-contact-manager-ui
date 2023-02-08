//
//  ContactCell.swift
//  ContactManagerUI
//
//  Created by sei_dev on 2/8/23.
//

import UIKit

final class ContactCell: UITableViewCell {
    func configure(model: ContactCellModel) {
        var contentConfig = defaultContentConfiguration()
        contentConfig.text = model.text
        contentConfig.textProperties.font = .preferredFont(forTextStyle: .headline)
        contentConfig.secondaryText = model.secondaryText
        contentConfig.secondaryTextProperties.font = .preferredFont(forTextStyle: .body)
        contentConfiguration = contentConfig
    }
}
