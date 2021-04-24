//
//  SwitchRowView.swift
//  ChatApp
//
//  Created by Naemeh Jalali on 3/26/21.
//

import UIKit

class SwitchRowView: ProfileRowView {


    var switchValue: ((Bool) -> ())?
    private var switchView = UISwitch()
    
    var switchIsOn: Bool {
        get { switchView.isOn }
        set { switchView.isOn = newValue }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        hasLeadingImage = false
        
        addSubview(switchView)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            switchView.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        switchView.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
    }
    
    @objc private func switchDidChange(_ switchView: UISwitch) {
        switchValue?(switchView.isOn)
    }

}
