//
//  NetworkManager.swift
//  CityCare
//
//  Created by Radu Albastroiu on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
    
    var urlIssues = URL(string: "http://itec-api.deventure.co/api/Issue/GetAll")
    
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
                                if let issueDict = issue as? [String:Any],
                                    let id = issueDict["Id"] as? String,
                                    let title = issueDict["Title"] as? String,
                                    let description = issueDict["Description"] as? String,
                                    let latitude = issueDict["Latitude"] as? Double,
                                    let longitude = issueDict["Longitude"] as? Double,
                                    let upVotes = issueDict["UpVotes"] as? Int,
                                    let downVotes = issueDict["DownVotes"] as? Int,
                                    let createdAt = issueDict["CreatedAt"] as? Double,
                                    let createdBy = issueDict["CreatedBy"] as? String,
                                    let creator = issueDict["Creator"] as? String {

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
                                    
                                    issuesData.append(issueModel)
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
    
}
