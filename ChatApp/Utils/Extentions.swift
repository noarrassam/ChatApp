//
//  Extentions.swift
//  ChatApp
//
//  Created by Noor Rassam on 2021-04-11.
//

import UIKit
import JGProgressHUD

class Extention : UIViewController {
    
}

extension UIViewController {
    
    static let hud = JGProgressHUD(style: .dark)
    
    func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    func showLoader(_ show: Bool, withText text: String? = "Loading") {
        view.endEditing(true)
        //let hud = JGProgressHUD(style: .dark)
        UIViewController.hud.textLabel.text = text
        
        if show {
            UIViewController.hud.show(in: view)
        }else {
            UIViewController.hud.dismiss()
        }
    }
}
