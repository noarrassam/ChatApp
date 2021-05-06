//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Noor Rassam on 2021-04-11.
//

import UIKit
import TextFieldEffects
import Firebase
import JGProgressHUD

protocol AuthenticiationControllerProtocol {
    func checkFormStatus()
}

class LoginViewController: UIViewController {
    private var viewModel = LoginViewModel()
    
    @IBOutlet weak var email: HoshiTextField!
    @IBOutlet weak var pass: HoshiTextField!
    
    @IBOutlet weak var login: UIButton!
    
    let loginToList = "gotologin"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    // Post a notification when the text changes, and forwards the message to the text field’s cell if it responds.
    @objc func textDidChange(sender: UITextField){
        if sender == email {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    @objc func handleLogin() {
        
        guard let email = email.text else {return}
        guard let password = pass.text else {return}
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Logging in"
        hud.show(in: view)
        
        // Getting an instance of AuhSerivce to login
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to login with error \(error.localizedDescription)")
                hud.dismiss()
                return
                
            // if login is correct the ConversationController will prompt
            } else if let isLoggedIn = result as? Bool, isLoggedIn == true {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "tabVC") as! ConversationController
                self.present(newViewController, animated: true, completion: nil)
                hud.dismiss()
                
            } else {
                
                print("Show alert to user saying please verify email!")
                hud.dismiss()
            }
        }
    }
    
    // MARK: -Helpers
    
    @IBAction func Login(_ sender: Any) {
        handleLogin()
    }
    
    func configureUI() {
        login!.isEnabled = false
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        email.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        pass.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

// Form Validation
extension LoginViewController: AuthenticiationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsValid {
            login.isEnabled = true
            login.backgroundColor = .blue
        } else {
        login.isEnabled = false
            login.backgroundColor = .white
        }
    }
}
