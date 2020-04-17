//
//  AppStoreEndPoint.swift
//  iTunesSearch
//
//  Created by Neethu Sukumaran on 4/15/20.
//  Copyright © 2020 Neethu Sukumaran. All rights reserved.
//

import Foundation

enum AppStoreEndPoint
{
    case search(term: String)
    
    var request: URLRequest{
        var components = URLComponents(string: baseURL)!
        components.path = path
        components.queryItems = queryComponents
        let url = components.url!
        
        return URLRequest(url: url)
        
    }
    
    private var baseURL: String {
        return "https://itunes.apple.com/"
    }
    
    private var path: String {
        switch self {
        case .search: return "/search"
        }
    }
    
    private struct ParameterKeys {
        static let term = "term"
        static let entity = "entity"
        static let limit = "limit"
        
    }
    
    private struct DefaultValues {
        static let limit = "10"
    }
    
    private var parameters: [String : Any] {
        switch self {
        case .search(let term):
            let parameters: [String : Any] = [
                ParameterKeys.term : term,
                ParameterKeys.limit : DefaultValues.limit
            ]
            
            return parameters
        
        }
    }
    
    private var queryComponents: [URLQueryItem] {
        
        var components = [URLQueryItem]()
        
        for(key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        
        return components
    }
    
    
    
}
