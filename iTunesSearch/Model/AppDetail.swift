//
//  AppDetail.swift
//  iTunesSearch
//
//  Created by Neethu Sukumaran on 4/15/20.
//  Copyright © 2020 Neethu Sukumaran. All rights reserved.
//

import Foundation

//Model to map the Json Object
public struct AppDetail {
    
    var appName: String?
    var genre: String?
    var seller: String?
    var image: String?
    var formattedPrice: String?
    var kind:String?
    
   public init(appName: String?, genre: String?, seller: String?, image: String?, price: String?,kind:String?) {
        
        self.appName = appName
        self.genre = genre
        self.seller = seller
        self.image = image
        self.formattedPrice = price
        self.kind=kind
        
        
    }
}

//public struct Item {
//    var name: String
//    var detail: String
//
//    public init(name: String, detail: String) {
//        self.name = name
//        self.detail = detail
//    }
//}

public struct Section {
    var kind: String
    var items: [AppDetail]
    var collapsed: Bool
    
    public init(name: String, items: [AppDetail], collapsed: Bool = false) {
        self.kind = name
        self.items = items
        self.collapsed = collapsed
    }
}
