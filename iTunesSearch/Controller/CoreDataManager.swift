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
           let favEntity = NSEntityDescription.entity(forEntityName: "FavoriteList", in: managedContext)!
                    
               let app = NSManagedObject(entity: favEntity, insertInto: managedContext)
                   app.setValue(item.appName, forKeyPath: "appName")
                   app.setValue(item.genre, forKey: "genre")
                   app.setValue(item.seller, forKey: "seller")
                    app.setValue(item.image, forKey: "image")
                    app.setValue(item.formattedPrice, forKey: "formattedPrice")
                     app.setValue(item.kind, forKey: "kind")
                   app.setValue(item.previewUrl, forKey: "previewUrl")
          
           
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
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteList")
            do {
                let result = try managedContext.fetch(fetchRequest)
                self.dataList=[]
                for data in result as! [NSManagedObject] {
                          let appName = data.value(forKey: "appName")
                          let genre = data.value(forKey: "genre")
                          let seller = data.value(forKey: "seller")
                          let image = data.value(forKey: "image")
                          let price = data.value(forKey: "formattedPrice")
                          let kind =  data.value(forKey: "kind")
                    let hasFavorited=data.value(forKey: "hasFavorited")
                          let previewUrl = data.value(forKey: "previewUrl")
                          
                    let newApp:AppDetail = AppDetail(appName: appName as? String, genre: genre as? String, seller: seller as? String, image: image as? String, price: price as? String, kind: kind as? String,previewUrl: previewUrl as? String, hasFavorited: hasFavorited as? Bool ?? true)
                   
                     self.dataList.append(newApp)
                }
                
                
            } catch {
                
                print("Failed")
            }
        return self.dataList
        }
       
    func deleteData(appName:String){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteList")
        fetchRequest.predicate = NSPredicate(format: "appName = %@",appName)
       
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
    
    
    func clearEverything(){
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteList")
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            for data in result as! [NSManagedObject]
            {
                managedContext.delete(data)
            }
            
            try managedContext.save()
        } catch {
            
            print("Failed")
        }
}
}
