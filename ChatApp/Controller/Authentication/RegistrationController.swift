//
//  RegistrationController.swift
//  ChatApp
//
//  Created by Noor Rassam on 2021-04-11.
//

import UIKit
import TextFieldEffects
import Firebase

class RegistrationController: UIViewController {

    @IBOutlet weak var email: MadokaTextField!
    @IBOutlet weak var password: MadokaTextField!
    @IBOutlet weak var fullname: MadokaTextField!
    @IBOutlet weak var username: MadokaTextField!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    
    
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNotificationObservers()
        configureUI()
       
        // Do any additional setup after loading the view.
    }
    
    // Creating a delegate to the image picker
    @objc func handleSelectPhoto(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 88
        }
    }
    
    @objc func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // Check if registration form is fullfilled.
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
    
    // Plus button on registraiton
    @IBAction func PlusButton(_ sender: Any) {
        plusBtn.tintColor = .white
        plusBtn.clipsToBounds = true
        plusBtn.imageView?.clipsToBounds = true
        plusBtn.imageView?.contentMode = .scaleAspectFill
    }
    
    @IBAction func login(_ sender: Any) {
        handleShowLogin() 
    }
    
    // Handle User Registration
    @objc func handleRegistration() {
        guard let email = email.text else {return}
        guard let password = password.text else {return}
        guard let fullname = fullname.text else {return}
        guard let username = username.text?.lowercased() else {return}
        guard let profileImage = profileImage else {return}
        
        let credentials = RegistrationCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        
        // Loader message conatins a progress bar
        showLoader(true, withText:"Sigining You Up")
        
        // Checking if user verified
        AuthService.shared.createUser(credentials: credentials) { error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                self.showLoader(false)
                return
            }
            self.showLoader(false)
            let actionSheet = UIAlertController(title: "Check Your Email", message: "Email Verification has been Sent", preferredStyle: .alert)
            actionSheet.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in self.dismiss(animated: true, completion: nil)}))
            self.present(actionSheet, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func SIgnUp(_ sender: Any) {
        handleRegistration()
    }
    
    // adding constraints
    func configureUI() {
        signUp.isEnabled = false
        plusBtn.frame.size = CGSize(width: 120, height: 120)
        plusBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        plusBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        plusBtn.heightAnchor.constraint(equalToConstant: 120).isActive = true
        plusBtn.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
    }
    
    func configureNotificationObservers() {
        email.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        password.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullname.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        username.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        dismiss(animated: true, completion: nil)
    }
}

// Registraiton Form Validation
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
