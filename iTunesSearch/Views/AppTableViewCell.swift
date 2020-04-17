//
//  ItunesAppTableViewCell.swift
//  iTunesSearch
//
//  Created by Neethu Sukumaran on 4/15/20.
//  Copyright © 2020 Neethu Sukumaran. All rights reserved.
//

import UIKit

class ItunesAppTableViewCell: UITableViewCell {
    var link=SearchViewController()
    var link2=FavoriteViewController()
    var dataManager=CoreDataManager()
    @IBOutlet weak var artworkImageView: UIImageView!
    
    @IBOutlet weak var appName: UILabel!
    
    @IBOutlet weak var genre: UILabel!
    
    @IBOutlet weak var iTunesLink: UILabel!
  
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    //Update UI Components when appDetail object is set
    
    var app:AppDetail! {
    didSet{
        self.updateUI()
    }
    }
    
    func updateUI()
    {
       
        appName.text = app.appName
       
        genre.text = app.genre
        iTunesLink.text=app.previewUrl
        let url = URL(string: app.image!)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.artworkImageView.image = UIImage(data: data!)
            }
        }
    }
    @IBAction func favButtonClick(_ sender: Any) {
        if app.hasFavorited == false{
           favButton.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
            app.hasFavorited=true
            dataManager.createData(item: app)
        }
        else{
            favButton.setImage(#imageLiteral(resourceName: "unFav"), for: .normal)
            app.hasFavorited=false
            dataManager.deleteData(appName:app.appName!)
            
        }
      }
    
      
    @IBAction func deleteButtonClick(_ sender: Any) {
        link2.deleteRow(app: app)
        
        
        
    }
}
