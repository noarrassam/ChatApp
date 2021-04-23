//
//  ViewController.swift
//  ChatApp
//
//  Created by Noor Rassam on 2021-03-21.
//

import UIKit
import TransitionButton

class ViewController: UIViewController {

    let button = TransitionButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //button.center = view.center
        button.center.x = self.view.frame.width - 200
        button.center.y = self.view.frame.width + 300
        
        button.backgroundColor = .systemPink
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
        
        button.spinnerColor = .white
    }
    
    @objc func didTapButton() {
        button.startAnimation()
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            self.button.stopAnimation(animationStyle: .expand, revertAfterDelay: 1)
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as! LoginViewController
            self.present(nextViewController, animated:true)
        }
//    }
}
