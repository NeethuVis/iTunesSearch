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
    var hasFavorited: Bool
    var previewUrl:String?
    
    public init(appName: String?, genre: String?, seller: String?, image: String?, price: String?,kind:String?,previewUrl:String?,hasFavorited: Bool = false) {
        
        self.appName = appName
        self.genre = genre
        self.seller = seller
        self.image = image
        self.formattedPrice = price
        self.kind=kind
        self.previewUrl=previewUrl
        self.hasFavorited=hasFavorited
        
        
    }
}

struct FavoritableContact {
    
   
}
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
