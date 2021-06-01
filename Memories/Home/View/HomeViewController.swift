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

final class HomeViewModel: ObservableObject {
    var albums: [Album] = []
    @Published private(set) var filteredAlbums: [Album] = []

    private let service = Service()

    func fetch() {
        service.getAlbums { items in
            guard let list = items else { return }
            self.albums = list
            self.filteredAlbums = self.groupAlbumsById(list)
        }
    }
    
    func groupAlbumsById(_ albums: [Album]) -> [Album] {
        return albums.unique { $0.albumId }
    }
}



class HomeViewController: UIViewController, UITableViewDelegate {
    
    
    // MARK: - Constants
    private struct Constants {
        static let Identifier = "PhotoCellIdentifier"
        static let TableViewCellInset: CGFloat = 5.0
        static let Title = "All Albums"
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
        tv.rowHeight = 170.0
        tv.separatorInset = UIEdgeInsets(top: 0, left: Constants.TableViewCellInset, bottom: 0, right: 0)
        return tv
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Init

    convenience init(viewModel: HomeViewModel? = nil) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
        title = Constants.Title
        bind()
        layout()
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        guard let ds = self.dataSource else { return }
        viewModel.$filteredAlbums.receive(on: DispatchQueue.main)
            .sink { [weak self] albums in
                guard let self = self else {
                    return
                }
                ds.setList(albums)
                self.tableView.reloadData()
            }.store(in: &subscriptions)
    }
    
    func bind() {
        let dataSource = AlbumListDataSource<Album>(albums: viewModel.filteredAlbums)
        self.dataSource = dataSource
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.Constants.identifier)
    }
    
    
    // MARK: - UITableView Delegate
    // TODO: - Navigate with Coordinator using Combine or RxCocoa Relay instead of pushing new view controller from the VC
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsScreen = AlbumDetailsViewController()
        guard let vm = viewModel else { return }
        let filtered = vm.albums.filter { $0.albumId == vm.albums[indexPath.row].albumId }
        detailsScreen.albums = filtered
        navigationController?.pushViewController(detailsScreen, animated: true)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = albums[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AlbumTableViewCell.Constants.identifier,
            for: indexPath
        ) as? AlbumTableViewCell else { return UITableViewCell() }
        cell.configureAlbumListCell(album)
        GetImageAdapter.getImage(from: album.thumbnailUrl) { img in
            cell.imageView?.image = img
        }
        return cell
    }
}

