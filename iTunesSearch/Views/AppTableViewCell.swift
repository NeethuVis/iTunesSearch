//
//  AppTableViewCell.swift
//  iTunesSearch
//
//  Created by Neethu Sukumaran on 4/15/20.
//  Copyright © 2020 Neethu Sukumaran. All rights reserved.
//

import UIKit

class AppTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    

    
    @IBOutlet weak var artworkImageView: UIImageView!
    
    @IBOutlet weak var appName: UILabel!
    
    @IBOutlet weak var genre: UILabel!
    
    
   
    
    @IBOutlet weak var iTunesLink: UILabel!
    
    //Update UI Components when appDetail object is set
    var app:AppDetail! {
    didSet{
        self.updateUI()
    }
    }
    
    func updateUI()
    {
        appName.text = app.appName
       // sellerName.text = app.seller! + " (App)"
        let url = URL(string: app.image!)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.artworkImageView.image = UIImage(data: data!)
            }
        }
    }
}
