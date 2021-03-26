//
//  SwitchRowView.swift
//  ChatApp
//
//  Created by albb on 3/26/21.
//

import UIKit

class SwitchRowView: ProfileRowView {


    private var switchView = UISwitch()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        hasLeadingImage = false
        
        addSubview(switchView)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            switchView.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

}
