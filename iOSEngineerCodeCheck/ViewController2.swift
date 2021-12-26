//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watcherLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issueLabel: UILabel!
    
    var mainViewController: ViewController?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let mainVC = mainViewController else{return}
        let repository = mainVC.repositories[mainVC.index ?? 0]
        
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watcherLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issueLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getIconImage()
        
    }
    
    func getIconImage(){
        guard let VC1 = mainViewController else{return}
        let searchedRepository = VC1.repositories[VC1.index ?? 0]
        
        titleLabel.text = searchedRepository["full_name"] as? String
        
        if let owner = searchedRepository["owner"] as? [String: Any],
              let imageURL = owner["avatar_url"] as? String {
                guard let iconImageURL = URL(string: imageURL) else{return}
                URLSession.shared.dataTask(with:iconImageURL) { (data, res, err) in
                    guard let iconImage = UIImage(data: data!) else{return}
                    self.setIconImage(image: iconImage)
                }.resume()
            }
        
    }
    


    func setIconImage(image : UIImage){
        DispatchQueue.main.async {
        self.imageView.image = image
        }
    }
}
