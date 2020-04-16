//
//  FirstViewController.swift
//  iTunesSearch
//
//  Created by Neethu Sukumaran on 4/15/20.
//  Copyright © 2020 Neethu Sukumaran. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController, UISearchBarDelegate {
  
    
    // Search Bar Controller
    @IBOutlet weak var searchBar: UISearchBar!
    
    //AppDetail Object array
    var apps:[AppDetail]?
    var sectionArray:[String] = []
     var sectionsData : [ Section]=[]
    
    //ApiController Object
    var api = ApiController()
    var dataManager=CoreDataManager()
    
    var isSearching = false
    
    struct Storyboard {
        static let appCell = "AppCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    //Fetch Data from API to the given string match
    func fetchApps(searchText: String)
    {
        let jsonUrl = AppStoreEndPoint.search(term: searchText)
        let url = jsonUrl.request.url
       
        api.getJsonFromUrl(url: url!) { (apps) in
            self.apps = apps
            for item in apps!
            {
                
                var section:String?
                section=item.kind
                
                if section != nil {
                   if self.sectionArray.contains(section!) == false {
                        self.sectionArray.append(section!)
                   
                   }
                } else {
                   print("Your string does not have a value")
                }
        }
             self.sectionsData=[]
            for sectionName in self.sectionArray{
                var itemArray:[AppDetail]=[]
                for items in apps!{
                   
                    if  sectionName == items.kind{
                        itemArray.append(items)
                        
                        
                    }
                
                 }
                let marks = Section(name: sectionName, items:itemArray)
                // sectionObj.init()
                
                 self.sectionsData.append(marks)
                 
            }
            
            
           
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return sectionsData[section].collapsed ? 0 : sectionsData[section].items.count
      
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label=UILabel(frame: CGRect(x: 70, y: 70, width: 40, height: 500))
        label.textAlignment = .justified
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textColor = UIColor.white
        label.backgroundColor = .gray
        
        //label.
        label.text = sectionsData[section].kind
        return label
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
       let starButton=UIButton(type: .custom)
       starButton.setImage(#imageLiteral(resourceName: "star"), for:.normal)
       starButton.frame=CGRect(x:0,y:0,width: 20,height: 20)
        starButton.addTarget(self, action:#selector(self.favoriteSelected), for: .touchUpInside)
        cell.accessoryView=starButton
        let item: AppDetail = sectionsData[indexPath.section].items[indexPath.row]
        cell.app=item
            
        return cell
    }
    @objc func favoriteSelected() {
      //  print("Button Clicked")
    }
    // Modal Popup when clicking on a table row/cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let indexPath = tableView.indexPathForSelectedRow
        let item: AppDetail = sectionsData[indexPath!.section].items[indexPath!.row]
        dataManager.createData(item: item)
    }
    
    // When user starts searching for specific apps
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            sectionsData.removeAll()
            sectionsData=[]
            apps?.removeAll()
            self.sectionArray.removeAll()
            self.tableView.reloadData()
            
        } else {
            sectionsData.removeAll()
             sectionsData=[]
            apps?.removeAll()
            self.tableView.reloadData()
            self.sectionArray.removeAll()
            fetchApps(searchText: searchText)
        }
    }

}

