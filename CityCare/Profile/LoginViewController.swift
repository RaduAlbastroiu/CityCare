//
//  LoginViewController.swift
//  CityCare
//
//  Created by Radu Albastroiu on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var coreElements: CoreElements?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtonView: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorMessageLabel.isHidden = true

        loginButtonView.layer.cornerRadius = 10
        loginButtonView.clipsToBounds = true
    }
    
    @IBAction func login(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            coreElements?.networkManager?.loginUser(email: email, password: password, completitionHandler: { (tokenModel) in
                if tokenModel.expiresIn == -1 {
                    self.errorMessageLabel.isHidden = false
                    
                    self.coreElements?.authorizationModel?.profileData = ProfileStubData()
                    self.coreElements?.authorizationModel?.success = false
                    self.coreElements?.authorizationModel?.statusCode = -1
                    
                } else if tokenModel.expiresIn > 0 {
                    
                    UserDefaults.standard.set(tokenModel.accessToken, forKey: self.coreElements!.accessTokenKey)
                    UserDefaults.standard.set(tokenModel.tokenType, forKey: self.coreElements!.tokenTypeKey)
                    UserDefaults.standard.set(tokenModel.userName, forKey: self.coreElements!.emailKey)
                    
                    self.coreElements?.authorizationModel?.profileData = tokenModel.userData
                    self.coreElements?.authorizationModel?.success = true
                    self.coreElements?.authorizationModel?.statusCode = 0
                    
                    self.coreElements?.isLoggedIn = true
                    
                    self.dismiss(animated: true, completion: nil)
                }
            })
        } else {
            
            self.coreElements?.authorizationModel?.profileData = ProfileStubData()
            self.coreElements?.authorizationModel?.success = false
            self.coreElements?.authorizationModel?.statusCode = -1
            
            errorMessageLabel.isHidden = false
        }
    }
    
    
    
}
