//
//  ProfileViewController.swift
//  ChatApp
//
//  Created by user on 3/24/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var headerView: GradientBackgroundView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.colors = [#colorLiteral(red: 0.4039215686, green: 0.7294117647, blue: 0.9294117647, alpha: 1), #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)]
    }
    

    @IBAction func closeButtonDidTouch(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func logoutButtonDidTouch(_ sender: FillButton) {
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        
        let acceptAction = UIAlertAction(title: "Yes", style: .default) { _ in
            if let loginViewController = self.view.window?.rootViewController?.storyboard?.instantiateViewController(identifier: "LoginViewController") {
                self.makeRootViewController(loginViewController, animated: true)
            }
            
        }
        actionSheet.addAction(acceptAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            actionSheet.dismiss(animated: true)
        }
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
    }
    
}
