//
//  SegmentedRowView.swift
//  ChatApp
//
//  Created by Naemeh Jalali on 3/26/21.
//

import UIKit

class StepperRowView: ProfileRowView {
    
    var stepperValue: ((Double) -> ())?
    private var stepperView = UIStepper()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        hasLeadingImage = false
        addSubview(stepperView)
        stepperView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stepperView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stepperView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        stepperView.addTarget(self, action: #selector(stepperDidChange(_:)), for: .valueChanged)
        
    }
    
    @objc private func stepperDidChange(_ stepper: UIStepper) {
        stepperValue?(stepper.value)
    }

}
