//
//  ViewController.swift
//  memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import UIKit
import ViewAnimator

fileprivate struct Constants {
    static let Identifier = "PhotoCellIdentifier"
    static let TableViewCellInset: CGFloat = 5.0
}

class HomeViewController: UIViewController, UITableViewDelegate {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.separatorColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 80
        tv.backgroundColor = .magenta
        tv.separatorInset = UIEdgeInsets(top: 5, left: Constants.TableViewCellInset, bottom: 5, right: Constants.TableViewCellInset)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.addSubview(tableView)
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: Constants.Identifier)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: (cell.frame.width * 0.8), height: (cell.frame.height)))
        view.backgroundColor = .orange
        let animation = AnimationType.random()
        view.animate(animations: [animation])
        cell.addSubview(view)
        return cell
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

