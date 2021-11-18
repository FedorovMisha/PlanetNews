//
//  SignInViewController.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 18.11.2021.
//

import UIKit

class SignInViewController: UIViewController {
    var signInView: SignInView!
    var authorizationService = AuthorizationService(userManger: UserManagerService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInView = SignInView(self, frame: UIScreen.main.bounds)
        self.view.addSubview(signInView)
    }
    
    @objc func didTouchBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func didTouchSignInButton() {
        guard let emailInput = signInView.emailInput, let passwordInput = signInView.passwordInput else {
            return
        }
        
        guard let email = emailInput.text, let password = passwordInput.text else {
            let vc = UIAlertController(title: "Sign In Error", message: "Incorrect data", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(vc, animated: true, completion: nil)
            return
        }
        
        if authorizationService.signIn(SignInCredentials(email: email, password: password)){
            let vc = TestViewController()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let alertVC = UIAlertController(title: "Sign In", message: "Sign in error! \n the user may not exist or the data was entered incorrectly", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
