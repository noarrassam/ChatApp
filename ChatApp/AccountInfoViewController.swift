//
//  AccountInfoViewController.swift
//  ChatApp
//
//  Created by Naemeh Jalali on 3/26/21.
//

import UIKit

class AccountInfoViewController: UIViewController {
    
    var user: ATCUser?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet private weak var emailValueLabel: UILabel!
    @IBOutlet private weak var usernameValueLabel: UILabel!
    @IBOutlet private weak var joinDateValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.white.cgColor
        title = "Account Info"
        setUserDetailOnView()
    }
    
    // Set User Details
    private func setUserDetailOnView() {
        guard let user = user, let profileImage = user.profilePictureURL else { return }
        emailValueLabel.text = user.email
        usernameValueLabel.text = user.lastName
        joinDateValueLabel.text = "@" + (user.firstName ?? "")
        profileImageView.kf.setImage(with: URL(string: profileImage))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

}
