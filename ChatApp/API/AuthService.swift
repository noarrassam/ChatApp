//
//  AuthService.swift
//  ChatApp
//
//  Created by Noor Rassam on 2021-04-14.
//

import Firebase
import UIKit
import JGProgressHUD

struct RegistrationCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    
    func logUserIn(withEmail email: String, password: String, completion: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            return logUserIn(withEmail: email, password: password, completion: completion)
        }
        
        user.reload { (error) in
            switch user.isEmailVerified {
            case true:
                print("users email is verified")
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    completion(true, nil)
                }
//                Auth.auth().signIn(withEmail: email, password: password, completion: completion)
                
            case false:
                user.sendEmailVerification { (error) in
                
                    guard let error = error else {
                        completion(false, nil)
                        return print("user email verification sent")
                        
                    }
                    
                    self.handleError(error: error)
                    completion(false, error)
                }
            
                print("verify it now")
                
            
            }
        }
    }
    
    func handleError(error: Error) {
        let errorAuthStatus = AuthErrorCode.init(rawValue: error._code)!
        switch errorAuthStatus {
        case .tooManyRequests:
            print("tooManyRequests")
        default:
            print("Error")
        }
    }
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    public func sendVerificationMail() {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
//                let actionSheet = UIAlertController(title: "Check Your Email", message: "Email Verification has been Sent", preferredStyle: .actionSheet)
//                actionSheet.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                //actionSheet.show(, sender: <#T##Any?#>)
//                //present(actionSheet, animated: true, completion: nil)

            })
            
        }
        else {
            // Either the user is not available, or the user is already verified.
        }
    }

    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return}
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            if let error = error {
                completion!(error)
                print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else {return}
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
                        return
                    }
                    sendVerificationMail()
                    guard let uid = result?.user.uid else {return}
                    
                    let data = ["email":credentials.email,
                                "fullname": credentials.fullname,
                                "profileImageUrl": profileImageUrl,
                                "uid": uid,
                                "username": credentials.username] as [String: Any]
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                }
            }
        }
    }
}
