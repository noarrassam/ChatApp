//
//  DashboardTabBarController.swift
//  ChatApp
//
//  Created by 陈西 on 2021-04-19.
//

import UIKit

class DashboardTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //let item1 = Item1ViewController()
        //let icon1 = UITabBarItem(title: "Title", image: UIImage(named: "someImage.png"), selectedImage: UIImage(named: "otherImage.png"))
        //item1.tabBarItem = icon1

        
        
        //configureUI
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
        var controllers = self.viewControllers
        controllers?.append(newViewController)
        self.viewControllers = controllers
        //self.navigationController!.pushViewController(newViewController, animated: true)
        //self.present(newViewController, animated: true, completion: nil)
    }

    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}
