//
//  ProfileRowView.swift
//  ChatApp
//
//  Created by Naemeh Jalali on 3/24/21.
//

import UIKit

class ProfileRowView: UIView {
    
    var action: (() -> ())?
    
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
    
    @IBInspectable
    var trailingImage: UIImage = .init() {
        didSet {
            disclosureImageView.image = trailingImage
        }
    }

    private let leadingImageView = UIImageView()
    private let leadingLabel = UILabel()
    private let disclosureImageView = UIImageView()
    private let trailingContainerView = UIView()
    private lazy var stackView = UIStackView(arrangedSubviews: [leadingImageView, leadingLabel, trailingContainerView])
    
    var hasLeadingImage = true {
        didSet {
            leadingImageView.isHidden = !hasLeadingImage
        }
    }
    
    

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addSubview(stackView)
        trailingContainerView.addSubview(disclosureImageView)
        leadingLabel.font = .systemFont(ofSize: 12)
        
        stackView.spacing = 8
        
        leadingImageView.translatesAutoresizingMaskIntoConstraints = false
        disclosureImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        trailingContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            leadingImageView.widthAnchor.constraint(equalToConstant: 34),
            leadingImageView.heightAnchor.constraint(equalToConstant: 34),
        ])
        
        NSLayoutConstraint.activate([
            trailingContainerView.widthAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            disclosureImageView.centerXAnchor.constraint(equalTo: trailingContainerView.centerXAnchor),
            disclosureImageView.centerYAnchor.constraint(equalTo: trailingContainerView.centerYAnchor),
            disclosureImageView.heightAnchor.constraint(equalToConstant: 24),
            disclosureImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        backgroundColor = .white
        disclosureImageView.contentMode = .scaleAspectFit
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTap() {
        action?()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        layer.cornerRadius = 8
    }
    

}
