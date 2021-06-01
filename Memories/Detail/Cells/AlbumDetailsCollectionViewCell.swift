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
    
    // MARK: - Constants
    struct Constants {
        static let identifier = "AlbumDetailsCell"
    }
    
    var card: MDCCard!
    var image: UIImage? = nil
    var title: String? = nil
    
    // MARK: - UI
    private lazy var previewImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = false
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .white
        v.textAlignment = .center
        v.numberOfLines = 0
        v.font = UIFont.systemFont(ofSize: 12.0)
        return v
    }()
    
    
    // MARK: - Init
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
        //        contentView.addSubview(card)
        let animation = AnimationType.random()
        card.animate(animations: [animation])
        
        contentView.addSubview(previewImageView)
        contentView.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        previewImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        previewImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        previewImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func configureCardSpecs() {
        titleLabel.text = title
        previewImageView.image = image
    }
}
