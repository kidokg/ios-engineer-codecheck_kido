//
//  secondPresentor.swift
//  iOSEngineerCodeCheck
//
//  Created by kido  on 2021/12/28.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class secondPresentor: NSObject {
    weak var mainViewController: ViewController?

    var Icon : UIImage?
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func getIconImage(main: ViewController) {
         
        let searchedRepository = main.repositories[main.index ?? 0]
        
        self.titleLabel.text = searchedRepository["full_name"] as? String
        
        if let owner = searchedRepository["owner"] as? [String: Any],
            let imageURL = owner["avatar_url"] as? String {
                guard let iconImageURL = URL(string: imageURL) else{return}
                URLSession.shared.dataTask(with:iconImageURL) { (data, res, err) in
                    guard let iconImage = UIImage(data: data!) else{return}
                    self.Icon = iconImage
                    
                    //self.setIconImage(image: iconImage)
                }.resume()
            }
    }
    
}
