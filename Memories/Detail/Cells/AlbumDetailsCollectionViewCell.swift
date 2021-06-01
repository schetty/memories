//
//  AlbumDetailsCollectionViewCell.swift
//  Memories
//
//  Created by Naomi Schettini on 6/1/21.
//

import UIKit
import MaterialComponents.MDCCard
import ViewAnimator

final class AlbumDetailsCollectionViewCell: UICollectionViewCell {
    
    struct Constants {
        static let identifier = "AlbumDetailsCell"
    }
    var card: MDCCard!
    var image: UIImage? = nil
    var title: String? = nil
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Google's documentation on iOS is always such garbage. I would switch out these Material Design Cards for something way easier to use or just make my own cards. I cannot figure out why the custom card properties just do not render.
    
    func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        card = MDCCard(frame: CGRect(x: 0,
                                     y: 0,
                                 width: (contentView.frame.width),
                                height: (contentView.frame.height)))
        card.setBorderWidth(1.0, for: .normal)
        card.setShadowColor(GlobalConstants.Colors.AlbumListGradient.tumbleweed,
                            for: .normal)
        contentView.addSubview(card)
        let animation = AnimationType.random()
        card.animate(animations: [animation])
    }
    
    func configureCardSpecs() {
        card.largeContentTitle = title
        card.largeContentImage = image
    }
}
