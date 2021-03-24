//
//  GradientBackgroundView.swift
//  ChatApp
//
//  Created by user on 3/24/21.
//

import UIKit

final class GradientBackgroundView: UIView {


    var colors: [UIColor] = [#colorLiteral(red: 0.5176470588, green: 0.8078431373, blue: 0.9098039216, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    private let gradientLayer = CAGradientLayer()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        layer.insertSublayer(gradientLayer, at: .zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = .init(x: 0.5, y: .zero)
        gradientLayer.endPoint = .init(x: 0.5, y: 1)
        gradientLayer.locations = [0.5, 1]
    }

}
