//
//  ForgotPasswordController.swift
//  ChatApp
//
//  Created by Noor Rassam on 2021-04-14.
//

import UIKit
import TextFieldEffects
import Firebase

class ForgotPasswordController: UIViewController {
    
    @IBOutlet weak var email: AkiraTextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    func createAlertController(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        
        return alert
    }
    
    
    @IBAction func login(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func forgotPassBtn(_ sender: Any) {
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: email.text!) { (error) in
            if let error = error {
                let alert = self.createAlertController(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                    return
            }
            let alert = self.createAlertController(title: "Hurray", message: "A password reset email has been sent!")
            self.present(alert, animated: true, completion: nil)
        }
        
        func resetPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error == nil {
                    onSuccess()
                }else {
                    onError(error!.localizedDescription)
                }
            }
        }
    }
}
