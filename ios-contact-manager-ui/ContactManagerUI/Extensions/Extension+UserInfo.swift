//
//  Extension+UserInfo.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/02/01.
//

import Foundation

extension UserInfo: ContactCellModel {
    var text: String {
        "\(self.name)(\(self.age))"
    }
    var secondaryText: String {
        self.phone
    }
}

extension UserInfo: Comparable {
    static func < (lhs: UserInfo, rhs: UserInfo) -> Bool {
        lhs.name < rhs.name || lhs.age < rhs.age || lhs.phone < rhs.phone
    }
}
