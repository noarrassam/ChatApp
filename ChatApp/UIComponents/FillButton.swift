//
//  FillButton.swift
//  ChatApp
//
//  Created by user on 3/24/21.
//

import UIKit

class FillButton: UIButton {

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.1843137255, blue: 0.6862745098, alpha: 1)
        setTitleColor(.white, for: .normal)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        layer.cornerRadius = 8
    }

}
