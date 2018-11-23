//
//  ReportViewController.swift
//  CityCare
//
//  Created by Radu Albastroiu on 23/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {

    @IBOutlet weak var imageChosen: UIImageView!
    var coreElements: CoreElements?
    var imagePicker: ImagePickerManager?
    var viewFirstAppeared = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = ImagePickerManager(presentingViewController: self)
        imagePicker?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if viewFirstAppeared {
            imagePicker?.presentPhotoPickerCamera(animated: true)
            viewFirstAppeared = false
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

extension ReportViewController: ImagePickerManagerDelegate {
    func imageChosen(manager: ImagePickerManager, image: UIImage) {
        imageChosen.image = image
        manager.dismissPhotoPicker(animated: true, completion: nil)
    }
}
