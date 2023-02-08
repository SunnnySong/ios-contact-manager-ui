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
//    private let dataSource = TableViewDataSource()
    var dataSource: UITableViewDiffableDataSource<Section, UserInfo>!
    var contactsData = ModelData().contacts

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureDataSource()
        fetchData()
    }

    private func setupTableView() {
        tableView.delegate = self
//        tableView.dataSource = dataSource
    }
}

extension ContactViewController {
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, UserInfo>(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let identifier = ContactCell.reuseIdentifier
            let cell =  tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = self.contactsData[indexPath.row].title
            content.secondaryText = self.contactsData[indexPath.row].subtitle
            cell.contentConfiguration = content
            return cell
        }
    }

    func fetchData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserInfo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(contactsData)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


extension ContactViewController: AddContactDelegate {
    func add(info: UserInfo) {
        contactsData += [info]

        var snapshot = NSDiffableDataSourceSnapshot<Section, UserInfo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(contactsData)
        dataSource.apply(snapshot, animatingDifferences: true)
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

