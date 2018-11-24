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
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            
            coreElements?.networkManager?.loginUser(email: email, password: password, completitionHandler: { (tokenModel) in
               
                if tokenModel.expiresIn == -1 {
                    self.coreElements?.loginFailed()
                } else {
                    self.coreElements?.loginSucceded(tokenModel: tokenModel)
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
