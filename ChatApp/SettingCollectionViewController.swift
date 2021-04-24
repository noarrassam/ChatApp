//
//  SettingViewController.swift
//  ChatApp
//
//  Created by Naemeh Jalali on 3/26/21.
//

import UIKit

class SettingCollectionViewController: UICollectionViewController {
    
    static let switchIdentifier = "SwitchIdentifier"
    static let stepperIdentifier = "StepperIdentifier"
    private var stepperValue: CGFloat = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Setting"
        collectionView.backgroundView = GradientBackgroundView()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Self.switchIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Self.stepperIdentifier)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        Setting.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Setting.allCases[section].numberOfRows
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Setting.allCases[indexPath.section] {
        case .switches:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.switchIdentifier, for: indexPath)
            let view = SwitchRowView()
            cell.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: cell.topAnchor),
                view.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
                view.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -20)
            ])
            switch SwitchRow.allCases[indexPath.item] {
            case .saveSession:
                view.leadingText = "Save current session"
                view.switchIsOn = Service.shared.isAutoLoginEnabled
                view.switchValue = { Service.shared.isAutoLoginEnabled = $0 }
            case .showProfile:
                view.leadingText = "Show avatar in chat"
                view.switchIsOn = Service.shared.isAvatarShowEnabled
                view.switchValue = { Service.shared.isAvatarShowEnabled = $0 }
            }
            view.fontSize = view.fontSize + stepperValue
            return cell
        case .stepper:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.stepperIdentifier, for: indexPath)
            let view = StepperRowView()
            cell.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: cell.topAnchor),
                view.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
                view.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: cell.trailingAnchor,  constant: -20)
            ])
            view.stepperValue = { value in
                self.stepperValue = CGFloat(value)
                view.fontSize = view.fontSize + self.stepperValue
                collectionView.reloadSections([0])
            }
            view.leadingText = "Font Size"
            return cell
        }
    }

}

extension SettingCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width, height: 52)
    }
}

extension SettingCollectionViewController {
    enum Setting: CaseIterable {
        case switches
        case stepper
        
        var numberOfRows: Int {
            switch self {
            case .switches:
                return 2
            case .stepper:
                return 1
            }
        }
    }
    
    enum SwitchRow: CaseIterable {
        case showProfile
        case saveSession
    }
}
