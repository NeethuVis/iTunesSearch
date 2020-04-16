//
//  SecondViewController.swift
//  iTunesSearch
//
//  Created by Neethu Sukumaran on 4/15/20.
//  Copyright © 2020 Neethu Sukumaran. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var apps:[AppDetail]?
    
    @IBOutlet weak var favTableView: UITableView!
    
   
    
var dataManager=CoreDataManager()
    
    struct Storyboard {
        static let appCell = "AppCell"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apps=dataManager.retrieveData()
       
        favTableView.dataSource=self
        favTableView.delegate=self
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.apps!.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
        cell.app = self.apps?[indexPath.row]
           cell.selectionStyle = .none

           return cell
       }


}

