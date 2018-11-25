//
//  AddCommentViewController.swift
//  CityCare
//
//  Created by Anisia Iova on 25/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var invalidDataLabel: UILabel!
    var coreElements: CoreElements?
    var issueId: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invalidDataLabel.isHidden = true

        commentTextField.delegate = self
        
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
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func submitComment(_ sender: Any) {
        if let comment = commentTextField.text {

            let commentModel = CommentStubData()
            commentModel.content = comment
            commentModel.id = UUID().uuidString
            commentModel.creator = (coreElements?.authorizationModel?.profileData.id)!
            
            let tokenType = UserDefaults.standard.string(forKey: (coreElements?.tokenTypeKey)!)
            let accessToken = UserDefaults.standard.string(forKey: (coreElements?.accessTokenKey)!)

            coreElements?.networkManager?.addComment(commentModel: commentModel, issueId: issueId, tokenType: tokenType!, accessToken: accessToken!, completitionHandler: { (succeded) in
                print(succeded)
                if succeded {
                    
                    self.coreElements?.networkManager?.getAllIssues()
                    
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
        } else {
            invalidDataLabel.isHidden = false
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
