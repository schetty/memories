//
//  AlbumDetailsViewController.swift
//  Memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import UIKit

class AlbumDetailsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    private struct Constants {
        static let CellSpacing: CGFloat = 24
        static let CellHeight: CGFloat = 130
        static let sideMargin: CGFloat = 16.0
        static let collectionCellWidth: CGFloat = 140
        static let Title = "details grouped by album ID"
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.sideMargin
        layout.minimumInteritemSpacing = Constants.CellSpacing
        layout.itemSize = CGSize(width: Constants.collectionCellWidth,
                                 height: Constants.CellHeight)
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = GlobalConstants.Colors.AlbumListGradient.viridian
        view.register(AlbumDetailsCollectionViewCell.self, forCellWithReuseIdentifier: AlbumDetailsCollectionViewCell.Constants.identifier)
        return view
    }()
    
    var albums: [Album]? = nil
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - Init
    override func viewDidLoad() {
        title = Constants.Title
        layout()
        bind()
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let a = albums else {
            return 0
        }
        return a.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumDetailsCollectionViewCell.Constants.identifier, for: indexPath) as? AlbumDetailsCollectionViewCell else { return UICollectionViewCell() }
        
        guard let a = albums else { return cell }
        cell.title = a[indexPath.row].title
        GetImageAdapter.getImage(from: a[indexPath.row].url) { img in
            cell.image = img
            cell.configureCardSpecs()
        }
        return cell
    }
}

extension AlbumDetailsViewController {
    func bind() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func layout() {
        view.backgroundColor = GlobalConstants.Colors.AlbumListGradient.springGreen
        view.addSubview(collectionView)
        collectionView.register(AlbumDetailsCollectionViewCell.self, forCellWithReuseIdentifier: AlbumDetailsCollectionViewCell.Constants.identifier)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24.0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -8.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  24.0).isActive = true
    }
}


