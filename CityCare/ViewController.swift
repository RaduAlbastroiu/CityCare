//
//  ViewController.swift
//  CityCare
//
//  Created by Radu Albastroiu on 23/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var coreElements = CoreElements()
    var locationManager = LocationManager()
    var profileData = ProfileStubData()
    var issueData = IssueStubData()

    @IBOutlet weak var reportIssueButton: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var centerMapButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        reportIssueButton.layer.cornerRadius = 10
        reportIssueButton.clipsToBounds = true
    
        centerMapButton.layer.cornerRadius = 25
        centerMapButton.clipsToBounds = true
        
        coreElements.mapController = MapController(mapView: mapView)
        coreElements.locationManager = locationManager
        coreElements.locationManager?.delegate = coreElements.mapController
        
        let networkManager = NetworkManager()
        coreElements.networkManager = networkManager
        networkManager.coreElements = coreElements
        
        networkManager.getAllIssues()
        
        checkAuthorization()
        
        coreElements.networkManager?.addIssue(issueModel: IssueStubData(), tokenType: "Bearer", accessToken: "0xmmFZcigLT4JJqJFEiz59yUjLR7DUm5JCqkdvq9SBvPGGI_CyNcpJfAFzheBvxpcz_a8Fj0ODh0TfzCl_Pzzi1vydK6ouNSO4S8MJHqq_DYKv5dow2UWrFbQW2SWYN7eF-MunU0lMrQBkwdVS817In4kWvMVMdEPi6mF46dM-qiFAVmRpecb5rg3N7EzYkrw9JkKjOm7RGRoZSy40NVZZ2SHqglCJ1vRG51hJn3gXpE5c9_OOpYSmHMtwAfGBzBiVDAd3oQwviynj5Ui_5OIRp6iq4wJfWcEbmLTaQIQvoUhvrCJiVBdjOPDa5XzReWlMJUbr0st0IXjC-4XR0UgwcwjN_KHY7gZoyAKKkz2hz8MoAzuybWzYmg9Bnvuw4hdWQLJrTm0rLJR0YyNjeHtV11__0MmKDWIgaKhQvbIwRvLvRIqgp8md38qjOELbzLdUJfKRoJ20zuElRDnBNBG3tgOeH7EwMmxJw5GuH3MxLRFaIYGXhT9FIjl62gagDbnqrss1nHp14zMPR3cdc_lo9iBh_CVaHxLrHA7krdZ3yuAR82dO6uI-Kk6F_P_7a8SoQhCBJWC3laiyrJ50Kzab_EmIBaJagFaPvd8oX5dgqW-SRU_8fSAVl2q62S3ZYJvNGhlf5M2vwvPDax_HzBvIgNow6Pazdv9QjnB6TXYmt4coMhVlZSAzIIjg2YehMbQRnM-iT4FW8erijNcjTEZMVJQsoyf4KMzPH9DLglrozDquhOndWSOwJquzoavKXTsifDMPF7mDWm8GDatynTeK2mMyRNlaiTkKvslLN20tbeNNWoQvBsI8y5dRHDmPzhGEer2xXD6zNnKyq90_uxISSK4h01JFVHFcs8CwckN2dsbpFG9nnDzz2QEfedKwW2HfgsecOsLecQbTGWORCEnyVqOcMr-w0-6dJb2JqwvI1xW1X1LySgfjywM7us_ks65EUoJ0abQSawBReyL3TPGkoajOHFLZsBaWvKSLjQewPl0J28nEjiBPEObgeH4mU3FD993le4NOTkaTI4q4oE6kvCI8a_gX2A3NRWvgRb0Ug6g2IEPjxZu_9t7MCeM3Cd2YGAdHsnSmjYkgInHbWX_L2XzecpsXBjEnmd_vZ7vTB-naLG9IwQ6bmlNiXItMT6w1Ui2JxeSb0LzQ9ieYVdiB66kXfZWet8DMpvMMxvEIyrPe-lK2b5V0mX9j22tRRSmiYifS3rpgKVsnw-cz9Q5SLtpESrx5rjhTVedXMZSzzqWcVW9ah67IBirXUdbN_SJJ4DbS-jjtnw6utMnVe8G3rHoDbi8n3S88eZs9Ar7El4dwRM7TevLJbWaeJIH3_6LQkfzJ_TKwcIWhmAHvTp_VHsZz81RutCLokCwIWK7yinz3-8PSmG8iR9ozdKJzGof-9V0y2n9w4LMpmim_lkDkOXCW_psDkRfUrJ4zltmss2Otu8qQGW2tS_aRDw3Ha14f_60oJSAubmQVvYaJrpVkHB0Qgt2KDtltdcsPvXS6hv4XnLKx2tFG2TB-ewRUuc4p5EB6NzFcPVZTcMW519aVAKVQptr6pVOeDrvLHQUxDYhtjXrPuDdiO-rDAI72xvEMbAzBcY4b8Z1R4xy1PWjOaUE1U3fbx7xtFKYgvDY9G3-4J2m-ttTQZFAz0TnDnqxo9OoXqoV7GH2khEFpTndeqDcBtiY2TAkSD7TNsTa-8WT0LvlrRk-_Gg5TzW3dhlufPNl0fkyP-hQlx01KvuozFRICPNPjUDP_xZJ65iGxLvEW-4TuwaexcnRsfEhL2XXUHwLAt84pRMeDZezvqqzK-ZIiDve78NQGgwKPDa59EDACEJ2xPbJLdsriRXRfu-RFTCvdOX_S97aCWyVnW7Ed2Ge035phIr7OWvMNp9l4LvETTktkgEkA0PK3VQ2PNU8Oass6uNzRIioAcNTFXF3rmYW8dfsNVlv51AtVtaO-00rn_aCKe4rNA9c_B5U6KueYMUVD6lYYHVPbAUiUOXT8JN5XKQnLuNIKvYHLK-z0kZh1ayfcJWBLcFoD7VokMjIm-Z8JO-H2xaDfw5ndYhlASwleb3S4ov9Bq-kWMg5BI", completitionHandler: { data in
            print(data)
        })
    }
    
    func checkAuthorization() {
        if let email = UserDefaults.standard.string(forKey: coreElements.emailKey),
            let tokenType = UserDefaults.standard.string(forKey: coreElements.tokenTypeKey),
            let accessToken = UserDefaults.standard.string(forKey: coreElements.accessTokenKey) {

            coreElements.networkManager?.isAuthorized(userEmail: email, tokenType: tokenType, accessToken: accessToken, completitionHandler: { authorizationModel in
                if authorizationModel.success == false {
                    self.coreElements.authorizationFailed()
                } else {
                    self.coreElements.authorizationSucceded(authorization: authorizationModel)
                }
            })
        } else {
            self.coreElements.authorizationFailed()
        }
    }
    
    func registerUser(registerModel: ProfileRegisterModel) {
        coreElements.networkManager?.registerUser(registerModel: ProfileRegisterStubData(), completitionHandler: { data in
            self.coreElements.authorizationModel = data
        })
    }

    @IBAction func centerMap(_ sender: Any) {
        coreElements.mapController?.centerMapOnLocation()
    }

    @IBAction func profileButtonPress(_ sender: Any) {
        if coreElements.isLoggedIn == true {
            performSegue(withIdentifier: "ProfileSegue", sender: nil)
        } else {
            performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileSegue" {
            if let profileController = segue.destination as? ProfileViewController {
                profileController.coreElements = coreElements
            }
        } else if segue.identifier == "IssueListSegue" {
            if let issueNavigationController = segue.destination as? UINavigationController,
                let issueListController = issueNavigationController.topViewController as? IssuesListController {
                
                issueListController.coreElements = coreElements
            }
        } else if segue.identifier == "LoginSegue" {
            if let loginViewController = segue.destination as? LoginViewController {
                loginViewController.coreElements = self.coreElements
            }
        }
    }
}

