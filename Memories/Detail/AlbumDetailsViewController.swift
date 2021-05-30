//
//  AlbumDetailsViewController.swift
//  Memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import UIKit
import ViewAnimator

class AlbumDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
