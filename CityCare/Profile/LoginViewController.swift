//
//  LoginViewController.swift
//  CityCare
//
//  Created by Radu Albastroiu on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

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
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func login(_ sender: Any) {
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            
            coreElements?.networkManager?.loginUser(email: email, password: password, completitionHandler: { (tokenModel) in
               
                if tokenModel.expiresIn == -1 {
                    self.coreElements?.loginFailed()
                    DispatchQueue.main.async {
                        self.errorMessageLabel.isHidden = false
                    }
                } else {
                    self.coreElements?.loginSucceded(tokenModel: tokenModel)
                    let transition = CATransition()
                    transition.duration = 0.3
                    transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromLeft
                    self.view.layer.add(transition, forKey: "leftoright")
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 50
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 50
            }
        }
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func goBack(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        view.layer.add(transition, forKey: "leftoright")
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegisterSegue" {
            if let registerViewController = segue.destination as? RegisterViewController {
                registerViewController.coreElements = coreElements
            }
        }
    }
    
}
