//
//  AlbumTableViewCell.swift
//  Memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import UIKit
import ViewAnimator
import MaterialComponents.MaterialCards

class AlbumTableViewCell: UITableViewCell {
    
    struct Constants {
        static let identifier = "AlbumCellIdentifier"
        static let DefaultMargin: CGFloat = 8.0
    }
    
    public var card: MDCCard = MDCCard()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        translatesAutoresizingMaskIntoConstraints = false
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAlbumListCell(_ album: Album,
                                indexPath: IndexPath? = nil) {
        textLabel?.text = album.title
        backgroundColor = GlobalConstants.Colors.AlbumListGradient.seaGreen
        //card.largeContentImage = UIImage(named: "sadness.png")
    }
}

fileprivate extension AlbumTableViewCell {
    
    private func layout() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let animation = AnimationType.random()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        view.animate(animations: [animation])
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        view.backgroundColor = GlobalConstants.Colors.AlbumListGradient.tumbleweed
        textLabel?.numberOfLines = 0
    }
    
}
