//
//  ConversationsController.swift
//  ChatApp
//
//  Created by Noor Rassam on 2021-04-11.
//

import UIKit
import Firebase

private let resuseIdentifier = "ConversationalCell"
class ConversationController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    @IBOutlet weak var profileButton: UIButton!
    
    @IBAction func profileButtonDidTouch() {
        performSegue(withIdentifier: "ProfileSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as! UITableViewCell
        let c = self.channels[indexPath.row]
        cell.textLabel?.text = c.id
        cell.detailTextLabel?.text = c.name
        return cell
    }
    
    @IBOutlet weak var table: UITableView!
    var user : ATCUser = ATCUser(firstName: "", lastName: "")
    var channels : [ATCChatChannel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUser()
        let db = Firestore.firestore().collection("users")
        db.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting users documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    let data = document.data();
                    if data["uid"]! as! String == Auth.auth().currentUser?.uid {
                        self.user = ATCUser(uid: data["uid"]! as! String, firstName: data["fullname"]! as! String, lastName: "", avatarURL: data["profileImageUrl"]! as! String, email: data["email"]! as! String, isOnline: false)
                    }
            }
                Firestore.firestore().collection("channels").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting users documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let data2 = document.data();
                            let channel = ATCChatChannel(id: data2["id"]! as! String, name: data2["name"]! as! String)
                            self.channels.append(channel)
                        }
                    }
                    self.table.reloadData()
            }

            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = self.channels[indexPath.row]
        let viewer = self.user
        let uiConfig = ATCChatUIConfiguration(primaryColor: UIColor(hexString: "#0084ff"),
                                              secondaryColor: UIColor(hexString: "#f0f0f0"),
                                              inputTextViewBgColor: UIColor(hexString: "#f4f4f6"),
                                              inputTextViewTextColor: .black,
                                              inputPlaceholderTextColor: UIColor(hexString: "#979797"))
        let chatVC = ATCChatThreadViewController(user: viewer, channel: channel, uiConfig: uiConfig)
        self.present(chatVC, animated: true, completion: nil)
   }
    
    @IBAction func tapAddChannel(_ sender: Any) {
        let alert = UIAlertController(title: "title", message: "subtitle", preferredStyle: .alert)
                alert.addTextField { (textField:UITextField) in
                    textField.placeholder = "inputPlaceholder"
                }
                alert.addAction(UIAlertAction(title: "actionTitle", style: .default, handler: { (action:UIAlertAction) in
                    guard let textField =  alert.textFields?.first else {
                        print("error")
                        return
                    }
                    print(textField.text)
                    let uiConfig = ATCChatUIConfiguration(primaryColor: UIColor(hexString: "#0084ff"),
                                                          secondaryColor: UIColor(hexString: "#f0f0f0"),
                                                          inputTextViewBgColor: UIColor(hexString: "#f4f4f6"),
                                                          inputTextViewTextColor: .black,
                                                          inputPlaceholderTextColor: UIColor(hexString: "#979797"))
                    let channel = ATCChatChannel(id: textField.text!, name: "Chat Title")
                    self.channels.append(channel)
                    let viewer = self.user
                    self.table.reloadData()
                    let chatVC = ATCChatThreadViewController(user: viewer, channel: channel, uiConfig: uiConfig)
                    self.present(chatVC, animated: true, completion: nil)
                }))
                alert.addAction(UIAlertAction(title: "cancelTitle", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
        
    }
    // MARK: - API
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        }else{
            print("DEBUG: User is logged in. Configure controller.. \(Auth.auth().currentUser?.uid)")
        }
    }
    
    @objc func showProfile(){
        logout()
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        }catch {
            print("DEBUG Error signing out..")
        }
    }
    
    // MARK: - Helpers
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginViewController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
}
