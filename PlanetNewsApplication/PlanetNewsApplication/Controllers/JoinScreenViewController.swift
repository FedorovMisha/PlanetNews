//
//  JoinScreenViewController.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 17.11.2021.
//

import UIKit

class JoinScreenViewController: UIViewController {

    var joinScreenView: JoinScreenView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        joinScreenView = JoinScreenView(controller: self, frame: UIScreen.main.bounds)
        self.view.backgroundColor = .red
        self.view.addSubview(joinScreenView)
    }
    
    @objc func didTouchLoginButton() {
        let vc = SignInViewController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTouchSignUpButton() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
