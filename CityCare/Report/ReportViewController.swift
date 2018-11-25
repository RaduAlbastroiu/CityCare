//
//  ReportViewController.swift
//  CityCare
//
//  Created by Radu Albastroiu on 23/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var invalidDataLabel: UILabel!
    
    var coreElements: CoreElements?
    var imagePicker: ImagePickerManager?
    var viewFirstAppeared = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        invalidDataLabel.isHidden = true
        
        imagePicker = ImagePickerManager(presentingViewController: self)
        imagePicker?.delegate = self
        
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ReportViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReportViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    override func viewDidAppear(_ animated: Bool) {
        /*
        if viewFirstAppeared {
            imagePicker?.presentPhotoPickerCamera(animated: true)
            viewFirstAppeared = false
        }
 */
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    @IBAction func submit(_ sender: Any) {
        if let title = titleTextField.text,
            let description = descriptionTextField.text {
            
            let issueModel = IssueStubData()
            issueModel.createdBy = (coreElements?.authorizationModel?.profileData.id)!
            issueModel.id = UUID().uuidString
            issueModel.title = title
            issueModel.description = description
            issueModel.longitude = (coreElements?.mapController?.currentLocation?.coordinate.longitude)!
            issueModel.latitude = (coreElements?.mapController?.currentLocation?.coordinate.latitude)!
            
            let tokenType = UserDefaults.standard.string(forKey: (coreElements?.tokenTypeKey)!)
            let accessToken = UserDefaults.standard.string(forKey: (coreElements?.accessTokenKey)!)
            
            coreElements?.networkManager?.addIssue(issueModel: issueModel, tokenType: tokenType!, accessToken: accessToken!, completitionHandler: { (succeded) in
                if succeded {
                    DispatchQueue.main.async {
                        let transition = CATransition()
                        transition.duration = 0.3
                        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                        transition.type = CATransitionType.push
                        transition.subtype = CATransitionSubtype.fromLeft
                        self.view.layer.add(transition, forKey: "leftoright")
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            })
        }
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
}

extension ReportViewController: ImagePickerManagerDelegate {
    func imageChosen(manager: ImagePickerManager, image: UIImage) {
        //imageChosen.image = image
        manager.dismissPhotoPicker(animated: true, completion: nil)
    }
}
