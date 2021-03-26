//
//  SegmentedRowView.swift
//  ChatApp
//
//  Created by albb on 3/26/21.
//

import UIKit

class StepperRowView: ProfileRowView {
    
    
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
        
        
    }

}
