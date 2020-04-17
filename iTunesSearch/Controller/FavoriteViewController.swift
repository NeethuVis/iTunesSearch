//
//  SecondViewController.swift
//  iTunesSearch
//
//  Created by Neethu Sukumaran on 4/15/20.
//  Copyright © 2020 Neethu Sukumaran. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var apps:[AppDetail]?=[]
    
    @IBOutlet weak var favTableView: UITableView!
    
   
    
var dataManager=CoreDataManager()
    
    struct Storyboard {
        static let appCell = "AppCell"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        super.viewDidLoad()
        self.apps?.removeAll()
        self.apps=dataManager.retrieveData()
       
        favTableView.dataSource=self
        favTableView.delegate=self
        favTableView.reloadData()
        
        
    }
    
    func deleteRow(app:AppDetail)  {
       
        dataManager.deleteData(appName:app.appName!)
        //self.apps?.removeAll()
        DispatchQueue.global().async {
            self.apps=self.dataManager.retrieveData()
            print(self.apps)
            DispatchQueue.main.async {
                self.favTableView?.reloadData()
            }
        }
        
    
      
        
       
       
       
    }

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.apps!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! ItunesAppTableViewCell
        cell.app = self.apps?[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }

}

