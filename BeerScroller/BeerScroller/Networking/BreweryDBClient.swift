//
//  BreweryDBClient.swift
//  BeerScroller
//
//  Created by Ben Scheirman on 10/25/17.
//  Copyright © 2017 NSScreencast. All rights reserved.
//

import Foundation
import Alamofire
import Keys

class BreweryDBClient {
    
    private let baseURL: URL = URL(string: "https://api.brewerydb.com/v2/")!
    
    init() {
    }
    
    func fetchBeers(page: Int = 1, styleId: Int, completion: @escaping (PagedResponse<Beer>) -> Void) {
        let req = Alamofire.request(baseURL.appendingPathComponent("beers"), parameters: [
            "styleId": styleId,
            "p": page,
            "withBreweries": "Y",
            "key": BeerScrollerKeys().breweryDBApiKey
            ])
        
        req.validate(statusCode: 200..<300)
        req.validate(contentType: ["application/json"])
        req.responseData { dataResponse in
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            let pagedResponse = try! decoder.decode(PagedResponse<Beer>.self, from: data)
            completion(pagedResponse)
        }
    }
    
    private func getURL(path: String, params: [URLQueryItem]) -> URL {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.queryItems = params
        return components.url!
    }
}
