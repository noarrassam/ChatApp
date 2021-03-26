//
//  AccountInfoViewController.swift
//  ChatApp
//
//  Created by albb on 3/26/21.
//

import UIKit

class AccountInfoViewController: UIViewController {

    @IBOutlet weak var emailValueLabel: UILabel!
    @IBOutlet weak var usernameValueLabel: UILabel!
    @IBOutlet weak var joinDateValueLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Account Info"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

}
