//
//  ContactsController.swift
//  ContactManagerUI
//
//  Created by sei_dev on 2/8/23.
//

import Foundation

enum ContactsController: DataSourceFromJSON {
    static var filePath: String { "contacts.json" }
    static private(set) var data: [UserInfo] = (try? load()) ?? []
}

extension ContactsController {
    static func saveCurrentData() {
        try? save(data: data)
    }

    static func add(contact: UserInfo) {
        data += [contact]
    }

    static func delete(contact: UserInfo) {
        if let index = data.firstIndex(where: { $0 == contact }) {
            data.remove(at: index)
        }
    }

    static var sortedContacts: [UserInfo] {
        data.sorted()
    }
}
