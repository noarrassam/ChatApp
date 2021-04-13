//
//  RegistrationController.swift
//  ChatApp
//
//  Created by Noor Rassam on 2021-04-11.
//

import TextFieldEffects
import Firebase
import UIKit

class RegistrationController: UIViewController {

    
    @IBOutlet weak var email: MadokaTextField!
    @IBOutlet weak var password: MadokaTextField!
    @IBOutlet weak var fullname: MadokaTextField!
    @IBOutlet weak var username: MadokaTextField!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    
//    private let plusPhotoButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "plusPhoto2X"), for: .normal)
//        button.tintColor = .white
//        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
//        button.clipsToBounds = true
//        return button
//    }()
    
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNotificationObservers()
        configureUI()
       
        // Do any additional setup after loading the view.
    }
    
    @objc func handleSelectPhoto(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == email {
            viewModel.email = sender.text
        }else if sender == password {
            viewModel.password = sender.text
        }else if sender == fullname {
            viewModel.fullname = sender.text
        }else {
            viewModel.username = sender.text
        }
        checkFormStatus()
    }
    
    @objc func handleShowLogin() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func PlusButton(_ sender: Any) {
        plusBtn.tintColor = .white
        plusBtn.clipsToBounds = true
        plusBtn.imageView?.clipsToBounds = true
        plusBtn.imageView?.contentMode = .scaleAspectFill
    }
    
    @IBAction func login(_ sender: Any) {
        handleShowLogin() 
    }
    
    @objc func handleRegistration() {
        guard let email = email.text else {return}
        guard let password = password.text else {return}
        guard let fullname = fullname.text else {return}
        guard let username = username.text?.lowercased() else {return}
        guard let profileImage = profileImage else {return}
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else {return}
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            if let error = error {
                print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else {return}
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else {return}
                    
                    let data = ["email":email,
                                "fullname": fullname,
                                "profileImageUrl": profileImageUrl,
                                "uid": uid,
                                "username": username] as [String: Any]
                    Firestore.firestore().collection("users").document(uid).setData(data){ error in
                        if let error = error {
                            print("DEBUG: Failed to upload user data error: \(error.localizedDescription)")
                            return
                        }
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func SIgnUp(_ sender: Any) {
//        signUp.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        handleRegistration()
    }
    
    func configureUI() {
        signUp.isEnabled = false
        //view.addSubview(plusPhotoButton)
        //plusPhotoButton.centerX(inView: view)
        //Hor kiddaaaa => what's up?
        
        //plusBtn.translatesAutoresizingMaskIntoConstraints = false
        //plusPhotoButton.center = view.center
        plusBtn.frame.size = CGSize(width: 120, height: 120)
        //plusBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        plusBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        plusBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        plusBtn.heightAnchor.constraint(equalToConstant: 120).isActive = true
        //plusBtn.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        plusBtn.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
    }
    
    func configureNotificationObservers() {
        email.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        password.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullname.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        username.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

// MARK: - UIIMageController Delegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        plusBtn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusBtn.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        plusBtn.layer.borderWidth = 3.0
        plusBtn.layer.cornerRadius = 120 / 2
        //plusBtn.imageView?.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
}
extension RegistrationController: AuthenticiationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsValid {
            signUp.isEnabled = true
            signUp.backgroundColor = .blue
        } else {
            signUp.isEnabled = false
            signUp.backgroundColor = .white
        }
    }
}
