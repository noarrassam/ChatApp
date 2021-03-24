//
//  ProfileRowView.swift
//  ChatApp
//
//  Created by user on 3/24/21.
//

import UIKit

class ProfileRowView: UIView {
    
    @IBInspectable
    var leadingImage: UIImage = .init() {
        didSet {
            leadingImageView.image = leadingImage
        }
    }
    
    @IBInspectable
    var leadingText: String = .init() {
        didSet {
            leadingLabel.text = leadingText
        }
    }

    private let leadingImageView = UIImageView()
    private let leadingLabel = UILabel()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addSubview(leadingImageView)
        addSubview(leadingLabel)
        
        leadingImageView.translatesAutoresizingMaskIntoConstraints = false
        leadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingImageView.widthAnchor.constraint(equalToConstant: 34),
            leadingImageView.heightAnchor.constraint(equalToConstant: 34),
            leadingImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            leadingImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            leadingLabel.leadingAnchor.constraint(equalTo: leadingImageView.trailingAnchor, constant: 8),
            leadingLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        backgroundColor = .white
        
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        layer.cornerRadius = 8
    }
    

}
