//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Noor Rassam on 2021-04-11.
//

import TextFieldEffects
import Firebase
import UIKit

protocol AuthenticiationControllerProtocol {
    func checkFormStatus()
}

class LoginViewController: UIViewController {
    
    private var viewModel = LoginViewModel()
    
    @IBOutlet weak var email: HoshiTextField!
    @IBOutlet weak var pass: HoshiTextField!
    
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
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
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to login with error \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: -Helpers
    
    @IBAction func Login(_ sender: Any) {
        login.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    
    func configureUI() {
        login.isEnabled = false
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        email.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        pass.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

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
