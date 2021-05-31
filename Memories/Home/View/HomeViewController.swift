//
//  ViewController.swift
//  memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import UIKit
import ViewAnimator
import Combine
import SwiftUI
//
//final class HomeViewModel {
//    @Published var 
//}

final class HomeViewModel: ObservableObject {
    @Published private(set) var albums: [Album] = []
    private let service = Service()
    
    func fetch() {
        service.getAlbums()
    }
}

class HomeViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Constants
    private struct Constants {
        static let Identifier = "PhotoCellIdentifier"
        static let TableViewCellInset: CGFloat = 5.0
    }
    
    private var viewModel: HomeViewModel!
    private var cancellables: Set<AnyCancellable> = []

    
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
        bindViewModel()
        bind()
    }
    
    private func bindViewModel() {
        viewModel = HomeViewModel()
          viewModel.objectWillChange.sink { [weak self] in
              guard let self = self else {
                  return
              }
              print(self.viewModel.albums)
          }.store(in: &cancellables)
      }
    
    func bind() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.Constants.identifier)
    }
    
    
    
    // MARK: - UITableView Delegate

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = presentAlbumListCell(indexPath) else { return UITableViewCell() }
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
    
    private func presentAlbumListCell(_ indexPath: IndexPath) -> AlbumTableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  AlbumTableViewCell.Constants.identifier, for: indexPath) as? AlbumTableViewCell else { return nil }
        guard viewModel.albums.count > 0 else { return nil }
        cell.configureAlbumListCell(viewModel.albums[indexPath.row], indexPath: indexPath)
        return cell
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

