//
//  RegisterViewController.swift
//  CityCare
//
//  Created by Radu Albastroiu on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var invalidDataLabel: UILabel!
    
    var coreElements: CoreElements?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invalidDataLabel.isHidden = true
        
        submitButton.layer.cornerRadius = 10
        submitButton.clipsToBounds = true
        
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        ageTextField.delegate = self
        genderTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 80
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 80
            }
        }
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitForm(_ sender: Any) {
       
        if let email = emailTextField.text,
            let password = passwordTextField.text,
            let fullName = fullNameTextField.text,
            let age = ageTextField.text,
            let gender = genderTextField.text {
            
            var genderG: Gender
            if gender == "F" {
                genderG = Gender.female
            } else if gender == "M" {
                genderG = Gender.male
            } else {
                genderG = Gender.notSpecified
            }
            
            if let age = Int(age) {
                var profileRegistration = ProfileRegisterStubData()
                profileRegistration.age = age
                profileRegistration.email = email
                profileRegistration.fullName = fullName
                profileRegistration.gender = genderG
                profileRegistration.id = UUID().uuidString
                profileRegistration.latitude = (coreElements?.mapController?.currentLocation?.coordinate.latitude)!
                profileRegistration.longitude = (coreElements?.mapController?.currentLocation?.coordinate.longitude)!
                profileRegistration.password = password
                profileRegistration.radius = 100
                profileRegistration.profilePicture = nil
                
                coreElements?.networkManager?.registerUser(registerModel: profileRegistration, completitionHandler: { (authorizationModel) in
                    if authorizationModel.success == false {
                        self.invalidDataLabel.isHidden = false
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
            self.invalidDataLabel.isHidden = false
        }
        self.invalidDataLabel.isHidden = false
    }
    
}
