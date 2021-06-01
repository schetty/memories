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
        service.getAlbums { items in
            guard let list = items else { return }
            self.albums = list
        }
    }
}



class HomeViewController: UIViewController, UITableViewDelegate {
    
    
    // MARK: - Constants
    private struct Constants {
        static let Identifier = "PhotoCellIdentifier"
        static let TableViewCellInset: CGFloat = 5.0
    }
    
    private var viewModel: HomeViewModel!
    private var subscriptions = Set<AnyCancellable>()
    private var dataSource: AlbumListDataSource<Album>!
    
    // MARK: - UI
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .singleLine
        tv.separatorColor = .white
        tv.isUserInteractionEnabled = true
        tv.separatorInset = UIEdgeInsets(top: 0, left: Constants.TableViewCellInset, bottom: 0, right: 0)
        return tv
    }()
    
    
    // MARK: - Init
    
    convenience init(viewModel: HomeViewModel? = nil) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
        bind()
        layout()
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        guard let ds = self.dataSource else { return }
        viewModel.$albums.receive(on: DispatchQueue.main)
            .sink { [weak self] albums in
                guard let self = self else {
                    return
                }
                ds.setList(albums)
                self.tableView.reloadData()
            }.store(in: &subscriptions)
    }
    
    func bind() {
        let dataSource = AlbumListDataSource<Album>(albums: viewModel.albums)
        self.dataSource = dataSource
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.Constants.identifier)
    }
    
    
    
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
    
    private func presentAlbumListCell(_ indexPath: IndexPath) -> AlbumTableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  AlbumTableViewCell.Constants.identifier, for: indexPath) as? AlbumTableViewCell else { return nil }
        guard viewModel.albums.count > 0 else { return nil }
        cell.configureAlbumListCell(viewModel.albums[indexPath.row], indexPath: indexPath)
        return cell
    }
    
}

extension HomeViewController {
    func layout() {
        view.backgroundColor = .cyan
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource

class AlbumListDataSource<Identifiable>: NSObject, UITableViewDataSource {
    var albums: [Album]
    
    init(albums: [Album]) {
        self.albums = albums
    }
    
    func setList(_ list: [Album]) {
        self.albums = list
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = albums[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: AlbumTableViewCell.Constants.identifier,
            for: indexPath
        )
        
        cell.textLabel?.text = album.title
        cell.detailTextLabel?.text = album.url
        
        return cell
    }
}

