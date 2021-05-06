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
    
    // Creating Alerts
    func createAlertController(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        self.dismiss(animated: true, completion: nil)
        return alert
    }
    
    
    @IBAction func login(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func forgotPassBtn(_ sender: Any) {
        let auth = Auth.auth()
        
        // Sending reset password through Firestore to an email address
        auth.sendPasswordReset(withEmail: email.text!) { (error) in
            if let error = error {
                let alert = self.createAlertController(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                    return
            }
            // Sedning Alert message to reset password
            let alert = self.createAlertController(title: "Hurray", message: "A password reset email has been sent!")
            self.present(alert, animated: true, completion: nil)
            
        }
        
        // Reseting with new password in Firestore
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
