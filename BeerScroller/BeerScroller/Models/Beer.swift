//
//  Beer.swift
//  BeerScroller
//
//  Created by Ben Scheirman on 10/25/17.
//  Copyright © 2017 NSScreencast. All rights reserved.
//

import Foundation

struct Beer : Codable {
    let id: String
    let name: String
    let abv: String?
    
    let breweries: [Brewery]
}

extension Beer : Equatable {
    static func ==(lhs: Beer, rhs: Beer) -> Bool {
        return lhs.id == rhs.id
    }
}
