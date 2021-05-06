//
//  UIViewControllerExtensions.swift
//  ChatApp
//
//  Created by user on 3/24/21.
//

import UIKit

extension UIViewController {
    
    func makeRootViewController(_ controller: UIViewController, animated: Bool) {
        
        let keyWindow = view.window
        let tempWindow = UIView(frame: UIScreen.main.bounds)
        keyWindow?.addSubview(tempWindow)
        tempWindow.backgroundColor = .white
        tempWindow.alpha = .zero
        
        UIWindow.animate(withDuration: animated ? 0.3 : .zero, animations: {
            tempWindow.alpha = 1
        }) { _ in
            keyWindow?.rootViewController = controller
            UIWindow.animate(withDuration: animated ? 0.3 : .zero, animations: {
                tempWindow.alpha = .zero
            }) { finished in
                keyWindow?.makeKeyAndVisible()
                tempWindow.isHidden = true
                tempWindow.removeFromSuperview()
            }
        }
    }
}
