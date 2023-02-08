//
//  ViewController.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/01/30.
//

import UIKit

final class ContactViewController: UIViewController {

    enum Section: CaseIterable {
        case main
    }
    @IBOutlet private weak var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, UserInfo>!
    let contactsController = ContactsController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureDataSource()
        fetchContactsData()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.register(ContactCell.self)
    }
}

extension ContactViewController {
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, UserInfo>(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.reuse(ContactCell.self, indexPath)
            cell.userInfo = itemIdentifier
            return cell
        }
    }

    func fetchContactsData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserInfo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(contactsController.sortedContacts)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ContactViewController: AddContactDelegate {
    func add(info: UserInfo) {
        contactsController.addContact(info)
        fetchContactsData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAddContactVIew" {
            let destination = segue.destination as! AddContactViewController
            destination.delegate = self
        }
    }
}

extension ContactViewController: UITableViewDelegate {

}

