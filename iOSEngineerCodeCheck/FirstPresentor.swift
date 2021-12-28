//
//  FirstPresentor.swift
//  iOSEngineerCodeCheck
//
//  Created by kido  on 2021/12/27.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class FirstPresentor: NSObject {
    
    @IBOutlet weak var tableView: UITableView!
    var repositories: [[String: Any]]=[]
    var URLSessionTask: URLSessionTask?
    var searchedWord: String?
    var repositoryURL: String?
    var index: Int?
    
    func searchRepository(searchedWord:String) {
        
        repositoryURL = "https://api.github.com/search/repositories?q=\(searchedWord)"
        guard let githubURL = URL(string: repositoryURL!) else{return}
        URLSessionTask = URLSession.shared.dataTask(with:githubURL) { (data, res, err) in
            guard let taskData = data else{return}
            if let object = try! JSONSerialization.jsonObject(with: taskData) as? [String: Any],
            let items = object["items"] as? [[String: Any]]{
                self.repositories = items
             
            }
            

            
        }
        
    }
    
}
