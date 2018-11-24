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
    var userDataStr = "http://itec-api.deventure.co//api/Account/GetUserByEmail";
    
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
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) -> UIImage {
        print("Download Started")
        var image = UIImage()
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
               image = UIImage(data: data)!
            }
        }
        return image
    }
    
    func getUserData(userEmail: String, completitionHandler completion:@escaping (ProfileModel) -> Void) {
        // build request url
        let userDataUrl = URL(string: (userDataStr + userEmail))

        let request = URLRequest(url: userDataUrl!)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                    completion(ProfileStubData())
                    return
                }
                
                let status = httpResponse.statusCode
                if(status == 200) {
                    do {
                        let profileData = ProfileStubData()
                        if let profileDict = try JSONSerialization.jsonObject(with: data) as? [String:Any],
                            let id = profileDict["Id"] as? String,
                            let fullName = profileDict["FullName"] as? String,
                            let latitude = profileDict["Latitude"] as? Double,
                            let longitude = profileDict["Longitude"] as? Double,
                            let radius = profileDict["Radius"] as? Double,
                            let age = profileDict["Age"] as? Int,
                            let gender = profileDict["Gender"] as? Int,
                            let profilePicture = profileDict["ProfilePicture"] as? String,
                            let issues = profileDict["Issues"] as? [Any] {
                            
                            profileData.id = id
                            profileData.fullName = fullName
                            profileData.latitude = latitude
                            profileData.longitude = longitude
                            profileData.radius = radius
                            profileData.age = age
                            profileData.gender = Gender(value: gender)!
                            profileData.profilePicture = self.downloadImage(from: URL(string: profilePicture)!)
                            for issue in issues {
                                if let issueDict = issue as? [String:Any] {
                                    profileData.issues.append(self.constructIssue(issueDict: issueDict))
                                }
                            }
                        }

                        completion(profileData)
                    } catch {
                        print("Error deserializing JSON: \(error)")
                    }
                } else {
                    completion(ProfileStubData())
                }
            }
        }
        // start task
        task.resume()
    }
    
    func constructIssue(issueDict: [String:Any]) -> IssueModel {
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
            
            let issueModel = IssueStubData()
            issueModel.id = id
            issueModel.title = title
            issueModel.description = description
            issueModel.latitude = latitude
            issueModel.longitude = longitude
            issueModel.upVotes = upVotes
            issueModel.downVotes = downVotes
            issueModel.createdAt = Date.init(timeIntervalSince1970: createdAt)
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
                    commentModel.createdAt = Date.init(timeIntervalSince1970: createdAt)
                    commentModel.edited = edited
                    
                    issueModel.comments.append(commentModel)
                }
            }
            
            for imageUrl in images {
                issueModel.images.append(self.downloadImage(from: URL(string: imageUrl)!))
            }
            
            return issueModel
        } else {
            return IssueStubData()
        }
    }
}


