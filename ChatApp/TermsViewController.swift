//
//  TermsViewController.swift
//  ChatApp
//
//  Created by Noor Rassam on 2021-04-29.
//

import UIKit

class TermsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Close screen if a user don't accept terms and conditions
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
