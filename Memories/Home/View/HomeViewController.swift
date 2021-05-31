//
//  ViewController.swift
//  memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import UIKit
import ViewAnimator
import Combine
//
//final class HomeViewModel {
//    @Published var 
//}

class HomeViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Constants
    private struct Constants {
        static let Identifier = "PhotoCellIdentifier"
        static let TableViewCellInset: CGFloat = 5.0
    }
    
    
    // MARK: - UI

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .singleLine
        tv.separatorColor = .white
        tv.separatorInset = UIEdgeInsets(top: 0, left: Constants.TableViewCellInset, bottom: 0, right: 0)
        return tv
    }()
    
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }
    
    func bind() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.Constants.identifier)
    }
    
    
    // MARK: - UITableView Delegate

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  AlbumTableViewCell.Constants.identifier, for: indexPath)
        switch indexPath.row {
        case indexPath.row % 2:
            cell.backgroundColor = GlobalConstants.Colors.AlbumListGradient.seaGreen
        default:
            cell.backgroundColor = GlobalConstants.Colors.AlbumListGradient.seaGreen
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func layout() {
        view.backgroundColor = .cyan
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

