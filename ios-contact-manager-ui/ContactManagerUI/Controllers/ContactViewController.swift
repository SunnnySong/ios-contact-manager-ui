//
//  ViewController.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/01/30.
//

import UIKit

final class ContactViewController: UIViewController, UITableViewDelegate {
    enum Section: CaseIterable {
        case main
    }
    @IBOutlet private weak var tableView: UITableView!
    lazy var dataSource: UITableViewDiffableDataSource<Section, UserInfo> = DataSource(tableView)

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchContactsData()
    }

    private func setup() {
        tableView.delegate = self
        tableView.register(ContactCell.self)
    }
}

extension ContactViewController {
    func fetchContactsData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserInfo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(ContactsController.sortedContacts)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ContactViewController: AddContactDelegate {
    func add(contact: UserInfo) {
        ContactsController.add(contact: contact)
        fetchContactsData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAddContactVIew" {
            let destination = segue.destination as! AddContactViewController
            destination.delegate = self
        }
    }
}

extension ContactViewController {
    final class DataSource: UITableViewDiffableDataSource<ContactViewController.Section, UserInfo> {
        init(_ tableView: UITableView) {
            super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
                let cell = tableView.reuse(ContactCell.self, indexPath)
                cell.configure(model: itemIdentifier)
                return cell
            }
        }

        // MARK: editing support
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                if let identifierToDelete = itemIdentifier(for: indexPath) {
                    var snapshot = self.snapshot()
                    snapshot.deleteItems([identifierToDelete])
                    ContactsController.delete(contact: identifierToDelete)
                    apply(snapshot)
                }
            }
        }
    }
}
