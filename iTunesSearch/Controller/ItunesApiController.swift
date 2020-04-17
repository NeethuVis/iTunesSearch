//
//  ItunesApiController.swift
//  iTunesSearch
//
//  Created by Neethu Sukumaran on 4/15/20.
//  Copyright © 2020 Neethu Sukumaran. All rights reserved.
//

import Foundation

class ItunesApiController {
    
    var iosApps: [AppDetail] = []
    
    func getJsonFromUrl(url: URL, completion: @escaping ([AppDetail]?) -> Void)
    {
        //Remove previously fetched data
        iosApps.removeAll()
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                print(jsonObj.value(forKey: "results")!)
                
                //getting the results tag array from json and converting it to NSArray
                if let appArray = jsonObj.value(forKey: "results") as? NSArray {
                    
                    //looping through all the elements
                    for app in appArray{
                        
                        //converting the element to a dictionary
                        if let appDict = app as? NSDictionary {
                            
                            //getting the name from the dictionary
                            let appName = appDict.value(forKey: "trackName")
                            let genre = appDict.value(forKey: "primaryGenreName")
                            let seller = appDict.value(forKey: "sellerName")
                            let image = appDict.value(forKey: "artworkUrl60")
                            let price = appDict.value(forKey: "formattedPrice")
                            let kind =  appDict.value(forKey: "kind")
                            let previewUrl=appDict.value(forKey: "previewUrl")
                            
                            let newApp:AppDetail = AppDetail(appName: appName as? String, genre: genre as? String, seller: seller as? String, image: image as? String, price: price as? String, kind: kind as? String, previewUrl: previewUrl as? String)
                            self.iosApps.append(newApp)
                            
                        }
                    }
                }
        
                completion(self.iosApps)
            }
        }).resume()
        
            }
    
    
}
