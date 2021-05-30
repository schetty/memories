//
//  ViewController.swift
//  memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import UIKit
import ViewAnimator



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
        tv.separatorStyle = .none
        tv.separatorColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 150.0
        tv.backgroundColor = .magenta
        tv.separatorInset = UIEdgeInsets(top: 0, left: Constants.TableViewCellInset, bottom: 0, right: Constants.TableViewCellInset)
        return tv
    }()
    
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
        tableView.reloadData()
    }
    
    func bind() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.Constants.identifier)
    }
    
    
    // MARK: - UITableView Delegate

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier:  AlbumTableViewCell.Constants.identifier, for: indexPath)
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
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

