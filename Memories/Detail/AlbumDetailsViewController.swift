//
//  AlbumDetailsViewController.swift
//  Memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import UIKit
import ViewAnimator

class AlbumDetailsViewController: UIViewController {
    
    private lazy var stack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .fill
        view.alignment = .fill
        view.backgroundColor = GlobalConstants.Colors.AlbumListGradient.seaGreen
        return view
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    // MARK: - Init
    override func viewDidLoad() {
        layout()
    }
    
    func layout() {
        view.backgroundColor = .white
        view.addSubview(stack)
        stack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let label = UILabel()
        label.text =
    }
}
