//
//  SettingViewController.swift
//  ChatApp
//
//  Created by albb on 3/26/21.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var showProfileView: SwitchRowView!
    @IBOutlet weak var increaseFontView: StepperRowView!
    @IBOutlet weak var saveSessionView: SwitchRowView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Setting"
        showProfileView.leadingText = "Show profile picture"
        saveSessionView.leadingText = "Save current session"
        increaseFontView.leadingText = "Font Size"
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
