//
//  Service.swift
//  ChatApp
//
//  Created by Naemeh Jalali on 4/23/21.
//

import Firebase

class Service {
    
    private init() { }
    
    static let shared = Service()
    
    private var auth = Auth.auth()
    
    func fetchUsers(type: FetchType, _ users: @escaping ([ATCUser]) -> ()) {
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            var items = [ATCUser]()
            snapshot?.documents.forEach {
                let dictionary = $0.data()
                let uid = dictionary["uid"] as! String
                let username = dictionary["username"] as! String
                let fullname = dictionary["fullname"] as! String
                let profileImageUrl = dictionary["profileImageUrl"] as! String
                let email = dictionary["email"] as! String
                let user = ATCUser(uid: uid, firstName: username, lastName: fullname, avatarURL: profileImageUrl, email: email, isOnline: true)
                switch type {
                case .currentUser:
                    guard self.auth.currentUser?.uid == uid else { return }
                    items.append(user)
                case .allUsers:
                    items.append(user)
                }
            }
            users(items)
        }
    }
    
    var isAutoLoginEnabled: Bool {
        get {
            UserDefaults.standard.bool(forKey: "AutoLogin")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "AutoLogin")
        }
    }
    
    var isAvatarShowEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "AvatarShowEnabled") }
        set { UserDefaults.standard.setValue(newValue, forKey: "AvatarShowEnabled")  }
    }
    
    var storedCredential: (email: String, password: String) {
        get {
            let email = UserDefaults.standard.string(forKey: "Email") ?? ""
            let password = UserDefaults.standard.string(forKey: "Password") ?? ""
            return (email, password)
        }
        set {
            UserDefaults.standard.setValue(newValue.email, forKey: "Email")
            UserDefaults.standard.setValue(newValue.password, forKey: "Password")
        }
    }
    
}

extension Service {
    enum FetchType {
        case currentUser, allUsers
    }
}
