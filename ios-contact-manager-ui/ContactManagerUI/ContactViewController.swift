//
//  ViewController.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/01/30.
//

import UIKit

final class ContactViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSource: UITableViewDiffableDataSource<Section, UserInfo>!
    
    private let contactsData = ModelData().contacts

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        setupTableViewDataSource()
        setupSnapshot()
    }

    private func setupTableView() {
        tableView.delegate = self
    }
    
    
    private func setupTableViewDataSource() {
        
        tableView.dataSource = UITableViewDiffableDataSource<Section, UserInfo> (tableView: self.tableView, cellProvider: { [weak self] (tableView, indexPath, itemIdentifier) -> UITableViewCell? in
            let identifier = "contactCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            
            var content = cell.defaultContentConfiguration()
            content.text = self?.contactsData[indexPath.row].title
            content.secondaryText = self?.contactsData[indexPath.row].subtitle
            cell.contentConfiguration = content
            return cell
        })
    }
    
    private func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserInfo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(ModelData().contacts)
//        tableView.dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ContactViewController: UITableViewDelegate {
}


enum Section {
    case main
}
