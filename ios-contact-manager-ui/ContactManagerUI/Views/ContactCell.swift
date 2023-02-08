//
//  ContactCell.swift
//  ContactManagerUI
//
//  Created by sei_dev on 2/8/23.
//

import UIKit

final class ContactCell: UITableViewCell {

    var userInfo: ContactCellModel?

    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)

        var contentConfig = defaultContentConfiguration().updated(for: state)
        contentConfig.text = userInfo?.text
        contentConfig.secondaryText = userInfo?.secondaryText
        contentConfiguration = contentConfig
    }
}
