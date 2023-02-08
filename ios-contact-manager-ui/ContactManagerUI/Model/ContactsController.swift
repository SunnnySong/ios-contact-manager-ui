//
//  ContactsController.swift
//  ContactManagerUI
//
//  Created by sei_dev on 2/8/23.
//

import Foundation

final class ContactsController: DataSourceFromJSON {
    var filePath: String { "contacts.json" }
    var data: [UserInfo]  {
        get { (try? load()) ?? [] }
        set { try? save(data: newValue) }
    }
}

extension ContactsController {
    func addContact(_ contact: UserInfo) {
        data += [contact]
    }

    var sortedContacts: [UserInfo] {
        data.sorted()
    }
}
