//
//  ProfileRowView.swift
//  ChatApp
//
//  Created by user on 3/24/21.
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

    private let leadingImageView = UIImageView()
    private let leadingLabel = UILabel()
    private let stackView = UIStackView()
    
    var hasLeadingImage = true {
        didSet {
            leadingImageView.isHidden = !hasLeadingImage
        }
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addSubview(stackView)
        
        leadingLabel.font = .systemFont(ofSize: 12)
        stackView.addArrangedSubview(leadingImageView)
        stackView.addArrangedSubview(leadingLabel)
        stackView.spacing = 8
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            leadingImageView.widthAnchor.constraint(equalToConstant: 34),
            leadingImageView.heightAnchor.constraint(equalToConstant: 34),
        ])
        
        backgroundColor = .white
        
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
