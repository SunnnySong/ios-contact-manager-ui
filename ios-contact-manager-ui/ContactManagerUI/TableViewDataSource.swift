////
////  TableViewDataSource.swift
////  ContactManagerUI
////
////  Created by sei_dev on 2/1/23.
////
//
//import UIKit
//
//final class TableViewDataSource: NSObject, UITableViewDataSource {
//    private let contactsData = ModelData().contacts
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return contactsData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let identifier = "contactCell"
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//
//        var content = cell.defaultContentConfiguration()
//        content.text = contactsData[indexPath.row].title
//        content.secondaryText = contactsData[indexPath.row].subtitle
//        cell.contentConfiguration = content
//        return cell
//    }
//}
