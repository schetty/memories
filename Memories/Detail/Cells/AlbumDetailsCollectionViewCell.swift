//
//  AlbumDetailsCollectionViewCell.swift
//  Memories
//
//  Created by Naomi Schettini on 6/1/21.
//

import UIKit
import MaterialComponents.MDCCard

final class AlbumDetailsCollectionViewCell: UICollectionViewCell {
    
    struct Constants {
        static let identifier = "AlbumDetailsCell"
    }
    
    var image: UIImage? = nil
    var title: String? = nil
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        let card = MDCCard(frame: CGRect(x: 0, y: 0, width: (contentView.frame.width), height: (contentView.frame.height)))
        card.largeContentTitle = title
        card.largeContentImage = image
        contentView.addSubview(card)
    }
}
