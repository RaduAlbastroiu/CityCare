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
            coreElements?.networkManager?.loginUser(email: email, password: password, CompletitionHandler: { (tokenModel) in
                if tokenModel.expiresIn == -1 {
                    self.errorMessageLabel.isHidden = false
                } else {
                    UserDefaults.standard.set(tokenModel.accessToken, forKey: "welcome_string")
                    
                }
            })
        } else {
            errorMessageLabel.isHidden = false
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
