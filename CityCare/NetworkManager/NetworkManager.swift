//
//  NetworkManager.swift
//  CityCare
//
//  Created by Radu Albastroiu on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: NSObject {
    
    var urlIssues = URL(string: "http://itec-api.deventure.co/api/Issue/GetAll")
    var userDataStr = "http://itec-api.deventure.co/api/Account/GetUserByEmail?email=";
    var isAuthorizedStr = "http://itec-api.deventure.co/api/Account/IsAuthorized?email=";
    var registerUserStr = "http://itec-api.deventure.co/api/Account/Register"

    func getIssues(completitionHandler completion:@escaping ([IssueModel]) -> Void) {
        let request = URLRequest(url: urlIssues!)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                    completion([])
                    return
                }
                    
                let status = httpResponse.statusCode
                if(status == 200) {
                    do {
                        if let issues = try JSONSerialization.jsonObject(with: data) as? [Any] {
                            
                            var issuesData = [IssueModel]()
                            for issue in issues {
                                if let issueDict = issue as? [String:Any] {
                                    issuesData.append(self.constructIssue(issueDict: issueDict))
                                }
                            }
                    
                            completion(issuesData)
                        }
                    } catch {
                        print("Error deserializing JSON: \(error)")
                    }
                        
                } else {
                    completion([])
                }
            }
        }
        // start task
        task.resume()
    }
    
    func getUserData(userEmail: String, completitionHandler completion:@escaping (AuthorizationModel) -> Void) {

        // build request url
        let encodedStr = userDataStr + userEmail.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let userDataUrl = URL(string: encodedStr)

        let request = URLRequest(url: userDataUrl!)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                
                let status = httpResponse.statusCode
                if(status == 200) {
                    do {
                        let authModel = AuthorizationStubData()
                        if let authDict = try JSONSerialization.jsonObject(with: data) as? [String:Any],
                            let profileDict = authDict["Data"] as? [String:Any],
                            let success = authDict["Success"] as? Bool,
                            let statusCode = authDict["StatusCode"] as? Int {
                            
                            authModel.profileData = self.constructProfileData(profileDict: profileDict)
                            authModel.success = success
                            authModel.statusCode = statusCode
                        }
                        
                        completion(authModel)
                    } catch {
                        print("Error deserializing JSON: \(error)")
                    }
                } else {
                    completion(AuthorizationStubData())
                }
            }
        }
        // start task
        task.resume()
    }
    
    func isAuthorized(userEmail: String, tokenType: String, accessToken: String, completitionHandler completion:@escaping (AuthorizationModel) -> Void) {
        
        // build request url
        let encodedStr = isAuthorizedStr + userEmail.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let isAuthorizedUrl = URL(string: encodedStr)
        
        var request = URLRequest(url: isAuthorizedUrl!)
        request.addValue((tokenType + " " + accessToken), forHTTPHeaderField: "Authorization")
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                
                let status = httpResponse.statusCode
                if(status == 200) {
                    do {
                        let authModel = AuthorizationStubData()
                        if let authDict = try JSONSerialization.jsonObject(with: data) as? [String:Any],
                            let profileDict = authDict["Data"] as? [String:Any],
                            let success = authDict["Success"] as? Bool,
                            let statusCode = authDict["StatusCode"] as? Int {
                            
                            authModel.profileData = self.constructProfileData(profileDict: profileDict)
                            authModel.success = success
                            authModel.statusCode = statusCode
                        }
                            
                        completion(authModel)
                    } catch {
                        print("Error deserializing JSON: \(error)")
                    }
                    
                } else {
                    completion(AuthorizationStubData())
                }
            }
        }
        // start task
        task.resume()
    }
    
    func loginUser(email: String, password: String, CompletitionHandler completion:@escaping (TokenModel) -> Void) {
        
    }
    
    func registerUser(registerModel: ProfileRegisterModel, completitionHandler completion:@escaping (AuthorizationModel) -> Void) {

        let registerUrl = URL(string: registerUserStr)!
        var request = URLRequest(url: registerUrl)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let json = registerModel.toJson()
        request.httpBody = json.data(using: .utf8)
       
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                return
            }

            let status = httpResponse.statusCode
            if(status == 200) {
                let responseString = String(data: data, encoding: .utf8)
            }
            
        }
        // start task
        task.resume()
    }

    func constructIssue(issueDict: [String:Any]) -> IssueModel {
        
        let issueModel = IssueStubData()
        
        if let id = issueDict["Id"] as? String,
            let title = issueDict["Title"] as? String,
            let description = issueDict["Description"] as? String,
            let latitude = issueDict["Latitude"] as? Double,
            let longitude = issueDict["Longitude"] as? Double,
            let upVotes = issueDict["UpVotes"] as? Int,
            let downVotes = issueDict["DownVotes"] as? Int,
            let createdAt = issueDict["CreatedAt"] as? Double,
            let createdBy = issueDict["CreatedBy"] as? String,
            let creator = issueDict["Creator"] as? String,
            let comments = issueDict["Comments"] as? [Any],
            let images = issueDict["Images"] as? [String] {
            
            issueModel.id = id
            issueModel.title = title
            issueModel.description = description
            issueModel.latitude = latitude
            issueModel.longitude = longitude
            issueModel.upVotes = upVotes
            issueModel.downVotes = downVotes
            issueModel.createdAt = Date.init(timeIntervalSince1970: createdAt/1000)
            issueModel.createdBy = createdBy
            issueModel.creator = creator
            
            // Add comments to issue model
            for comment in comments {
                if let commentDict = comment as? [String:Any],
                    let id = commentDict["Id"] as? String,
                    let content = commentDict["Content"] as? String,
                    let creator = commentDict["Creator"] as? String,
                    let createdAt = commentDict["CreatedAt"] as? Double,
                    let edited = commentDict["EditedAt"] as? Int {
                    
                    let commentModel = CommentStubData()
                    commentModel.id = id
                    commentModel.content = content
                    commentModel.creator = creator
                    commentModel.createdAt = Date.init(timeIntervalSince1970: createdAt/1000)
                    commentModel.edited = edited
                    
                    issueModel.comments.append(commentModel)
                }
            }
            
            for imageUrl in images {
                issueModel.images.append(self.downloadImage(from: URL(string: imageUrl)!))
            }
            
        }
        
        return issueModel
    }
    
    func constructProfileData(profileDict: [String:Any]) -> ProfileModel {
        
        let profileData = ProfileStubData()
        
        if let id = profileDict["Id"] as? String,
            let fullName = profileDict["FullName"] as? String,
            let latitude = profileDict["Latitude"] as? Double,
            let longitude = profileDict["Longitude"] as? Double,
            let radius = profileDict["Radius"] as? Double,
            let age = profileDict["Age"] as? Int,
            let gender = profileDict["Gender"] as? Int,
            let issues = profileDict["Issues"] as? [Any] {
            
            profileData.id = id
            profileData.fullName = fullName
            profileData.latitude = latitude
            profileData.longitude = longitude
            profileData.radius = radius
            profileData.age = age
            profileData.gender = Gender(rawValue: gender)!
            for issue in issues {
                if let issueDict = issue as? [String:Any] {
                    profileData.issues.append(self.constructIssue(issueDict: issueDict))
                }
            }
        }
        
        if let profilePicture = profileDict["ProfilePicture"] as? String {
            profileData.profilePicture = self.downloadImage(from: URL(string: profilePicture)!)
        }
        
        return profileData
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) -> UIImage {
        var image = UIImage()
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                image = UIImage(data: data)!
            }
        }
        return image
    }
}


