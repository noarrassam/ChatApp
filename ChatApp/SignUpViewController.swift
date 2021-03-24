//
//  SignUpViewController.swift
//  ChatApp
//
//  Created by user on 3/24/21.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loginButtonDidTouch(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func signUpButtonDidTouch(_ sender: UIButton) {
        if let homeNavigationController = view.window?.rootViewController?.storyboard?.instantiateViewController(identifier: "HomeNavigationController") {
            makeRootViewController(homeNavigationController, animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
