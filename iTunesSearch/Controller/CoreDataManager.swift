//
//  CoreDataManager.swift
//  iTunesSearch
//
//  Created by Neethu Sukumaran on 4/16/20.
//  Copyright © 2020 Neethu Sukumaran. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
   
    var dataList: [AppDetail] = []
    func createData(item:AppDetail){
           
           //As we know that container is set up in the AppDelegates so we need to refer that container.
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           
           //We need to create a context from this container
           let managedContext = appDelegate.persistentContainer.viewContext
           
           //Now let’s create an entity and new user records.
           let favEntity = NSEntityDescription.entity(forEntityName: "FavList", in: managedContext)!
                    
               let user = NSManagedObject(entity: favEntity, insertInto: managedContext)
                   user.setValue(item.appName, forKeyPath: "appName")
                   user.setValue(item.genre, forKey: "genre")
                   user.setValue(item.seller, forKey: "seller")
                    user.setValue(item.image, forKey: "image")
                    user.setValue(item.formattedPrice, forKey: "formattedPrice")
                     user.setValue(item.kind, forKey: "kind")
          
           
           do {
               try managedContext.save()
              
           } catch let error as NSError {
               print("Could not save. \(error), \(error.userInfo)")
           }
       }
    
    func retrieveData()->[AppDetail] {
            
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare the request of type NSFetchRequest  for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavList")
            do {
                let result = try managedContext.fetch(fetchRequest)
                
                for data in result as! [NSManagedObject] {
                          let appName = data.value(forKey: "appName")
                          let genre = data.value(forKey: "genre")
                          let seller = data.value(forKey: "seller")
                          let image = data.value(forKey: "image")
                          let price = data.value(forKey: "formattedPrice")
                          let kind =  data.value(forKey: "kind")
                          
                          let newApp:AppDetail = AppDetail(appName: appName as? String, genre: genre as? String, seller: seller as? String, image: image as? String, price: price as? String, kind: kind as? String)
                   
                     self.dataList.append(newApp)
                }
                
                
            } catch {
                
                print("Failed")
            }
        return self.dataList
        }
       
    
    
    
    
    

}
