//
//  ConversationsController.swift
//  ChatApp
//
//  Created by Noor Rassam on 2021-04-11.
//

import UIKit
import Firebase

private let resuseIdentifier = "ConversationalCell"
class ConversationController: UIViewController {
    
    //private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureUI()
        authenticateUser()
        let config = ChatUIConfiguration()
        config.configureUI()
        let threadsDataSource = ATCGenericLocalHeteroDataSource(items: ATCChatMockStore.threads)
        let remoteData = ATCRemoteData()
        remoteData.getChannels()
        let user = 2
        let newViewController :  ChatHostViewController = ChatHostViewController(uiConfig: config,
                                        threadsDataSource: threadsDataSource,
                                        viewer: ATCChatMockStore.users[user])
        print("currentUser: \(ATCChatMockStore.users[user].debugDescription)")
        //self.navigationController!.pushViewController(newViewController, animated: true)
        self.present(newViewController, animated: true, completion: nil)
    }
    
    // MARK: - API
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        }else{
            print("DEBUG: User is not logged in. Configure controller..")
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
    
//    func configureUI() {
//       view.backgroundColor = .white
//
//        configureNavigationBar()
//        configureTableView()
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "Messages"
//
//        let image = UIImage(systemName: "person.circle.fill")
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
//    }
//
//    func configureTableView() {
//        tableView.backgroundColor = .white
//        tableView.rowHeight = 80
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: resuseIdentifier)
//        tableView.tableFooterView = UIView()
//        tableView.delegate = self
//        tableView.dataSource = self
//
//
//        view.addSubview(tableView)
//        tableView.frame = view.frame
//    }
    
//    func configureNavigationBar() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        appearance.backgroundColor = .systemBlue
//
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.compactAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
//
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "Messages"
//        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.isTranslucent = true
//
//        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
//
//    }
}
//
//extension ConversationController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//}
//
//extension ConversationController: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: resuseIdentifier, for: indexPath)
//        cell.textLabel?.text = "Test Cell"
//        return cell
//    }
//}
