//
//  ProfileViewController.swift
//  ChatApp
//
//  Created by Naemeh Jalali on 3/24/21.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    private var user: ATCUser?

    @IBOutlet weak var accountInfoRowView: ProfileRowView!
    @IBOutlet weak var settingRowView: ProfileRowView!
    @IBOutlet weak var headerView: GradientBackgroundView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting profile image constraints
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.white.cgColor
        headerView.colors = [#colorLiteral(red: 0.4039215686, green: 0.7294117647, blue: 0.9294117647, alpha: 1), #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)]
        navigationController?.setNavigationBarHidden(true, animated: false)
        accountInfoRowView.action = { [weak self] in
            if let accountInfoViewController = self?.view.window?.rootViewController?.storyboard?.instantiateViewController(identifier: "AccountInfoViewController") as? AccountInfoViewController {
                accountInfoViewController.user = self?.user
                self?.navigationController?.pushViewController(accountInfoViewController, animated: true)
            }
        }
        
        // Navigating to SettingCollectionViewController if true
        settingRowView.action = { [weak self] in
            if let settingViewController = self?.view.window?.rootViewController?.storyboard?.instantiateViewController(identifier: "SettingCollectionViewController") {
                self?.navigationController?.pushViewController(settingViewController, animated: true)
            }
        }
        
        setUser()
    }
    
    // Fetchig user info.
    private func setUser() {
        Service.shared.fetchUsers(type: .currentUser) { users in
            guard let currentUser = users.first else { return }
            self.user = currentUser
            self.profileImageView.kf.setImage(with: URL(string: currentUser.profilePictureURL!))
            self.userLabel.text = "@" + (currentUser.firstName ?? "")
            self.nameLabel.text = currentUser.lastName
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    @IBAction func closeButtonDidTouch(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // Logout Functionality
    @IBAction func logoutButtonDidTouch(_ sender: FillButton) {
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        
        let acceptAction = UIAlertAction(title: "Yes", style: .default) { _ in
            
            try? Auth.auth().signOut()
            if let loginViewController = self.view.window?.rootViewController?.storyboard?.instantiateViewController(identifier: "WelcomeNavigationController") {
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
